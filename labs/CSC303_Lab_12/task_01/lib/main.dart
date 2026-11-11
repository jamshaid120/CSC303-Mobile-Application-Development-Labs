import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'firebase_options.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform);
  await FirebaseAuth.instance.signInAnonymously();
  runApp(const MaterialApp(home: CloudNotesPage()));
}

class CloudNotesPage extends StatefulWidget {
  const CloudNotesPage({super.key});
  @override
  State<CloudNotesPage> createState() => _CloudNotesPageState();
}

class _CloudNotesPageState extends State<CloudNotesPage> {
  final input = TextEditingController();
  @override
  void dispose() { input.dispose(); super.dispose(); }
  CollectionReference<Map<String, dynamic>> get notes {
    final uid = FirebaseAuth.instance.currentUser!.uid;
    return FirebaseFirestore.instance.collection('users')
      .doc(uid).collection('notes');
  }

  Future<void> add() async {
    final value = input.text.trim();
    if (value.isEmpty) return;
    try {
      await notes.add({'body': value,
        'createdAt': FieldValue.serverTimestamp()});
      input.clear();
    } catch (e) {
      if (mounted) ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Save failed: $e')));
    }
  }

  @override
  Widget build(BuildContext context) => Scaffold(
    appBar: AppBar(title: const Text('Firestore notes')),
    body: Column(children: [
      Padding(padding: const EdgeInsets.all(12), child: Row(children: [
        Expanded(child: TextField(controller: input,
          decoration: const InputDecoration(labelText: 'Cloud note'))),
        IconButton(onPressed: add, icon: const Icon(Icons.cloud_upload)),
      ])),
      Expanded(child: StreamBuilder<QuerySnapshot<Map<String, dynamic>>>(
        stream: notes.snapshots(),
        builder: (context, snapshot) {
          if (snapshot.hasError) return Text('Firestore error: ${snapshot.error}');
          if (!snapshot.hasData) {
            return const Center(child: CircularProgressIndicator());
          }
          final docs = snapshot.data!.docs;
          return ListView.builder(itemCount: docs.length,
            itemBuilder: (context, i) {
              final row = docs[i];
              return ListTile(
                title: Text(row.data()['body'] as String? ?? ''),
                trailing: IconButton(icon: const Icon(Icons.delete),
                  onPressed: () => row.reference.delete()),
              );
            });
        },
      )),
    ]),
  );
}
