import 'dart:async';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:image_picker/image_picker.dart';
import 'firebase_options.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform);
  await FirebaseAuth.instance.signInAnonymously();
  runApp(const MaterialApp(home: MediaPage()));
}

class MediaPage extends StatefulWidget {
  const MediaPage({super.key});
  @override
  State<MediaPage> createState() => _MediaPageState();
}

class _MediaPageState extends State<MediaPage> {
  String status = 'No image selected';
  String? imageUrl;
  String token = 'Loading FCM token...';
  String message = 'No foreground push received';
  StreamSubscription<RemoteMessage>? subscription;

  @override
  void initState() { super.initState(); initMessaging(); }

  Future<void> initMessaging() async {
    try {
      final messaging = FirebaseMessaging.instance;
      await messaging.requestPermission();
      final value = await messaging.getToken();
      subscription = FirebaseMessaging.onMessage.listen((event) {
        if (mounted) setState(() => message =
          event.notification?.title ?? 'Data message received');
      });
      if (mounted) setState(() => token = value ?? 'No token yet');
    } catch (e) {
      if (mounted) setState(() => token = 'FCM unavailable: $e');
    }
  }

  Future<void> upload() async {
    final photo = await ImagePicker().pickImage(source: ImageSource.gallery);
    if (photo == null) return;
    setState(() => status = 'Uploading...');
    try {
      final uid = FirebaseAuth.instance.currentUser!.uid;
      final ref = FirebaseStorage.instance.ref()
        .child('uploads/$uid/${DateTime.now().millisecondsSinceEpoch}.jpg');
      await ref.putFile(File(photo.path));
      final url = await ref.getDownloadURL();
      if (mounted) setState(() {
        imageUrl = url; status = 'Upload complete';
      });
    } catch (e) {
      if (mounted) setState(() => status = 'Upload error: $e');
    }
  }

  @override
  void dispose() { subscription?.cancel(); super.dispose(); }
  @override
  Widget build(BuildContext context) => Scaffold(
    appBar: AppBar(title: const Text('Storage + FCM demo')),
    body: ListView(padding: const EdgeInsets.all(16), children: [
      FilledButton(onPressed: upload, child: const Text('Choose & upload image')),
      Text(status),
      if (imageUrl != null) Image.network(imageUrl!, height: 170),
      const Divider(),
      const Text('FCM device token (do not publish publicly):'),
      SelectableText(token, maxLines: 4),
      Text('Foreground notification: $message'),
    ]),
  );
}
