import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'firebase_options.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform);
  runApp(const MaterialApp(home: AuthGate()));
}

class AuthGate extends StatelessWidget {
  const AuthGate({super.key});
  @override
  Widget build(BuildContext context) => StreamBuilder<User?>(
    stream: FirebaseAuth.instance.authStateChanges(),
    builder: (context, snapshot) {
      if (snapshot.connectionState == ConnectionState.waiting) {
        return const Scaffold(body: Center(child: CircularProgressIndicator()));
      }
      return snapshot.data == null ? const LoginPage() : const MemberPage();
    },
  );
}

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});
  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final email = TextEditingController();
  final password = TextEditingController();
  String message = '';
  bool busy = false;
  @override
  void dispose() { email.dispose(); password.dispose(); super.dispose(); }

  Future<void> submit({required bool register}) async {
    if (email.text.trim().isEmpty || password.text.length < 6) {
      setState(() => message = 'Email and 6+ character password required');
      return;
    }
    setState(() => busy = true);
    try {
      if (register) {
        await FirebaseAuth.instance.createUserWithEmailAndPassword(
          email: email.text.trim(), password: password.text);
      } else {
        await FirebaseAuth.instance.signInWithEmailAndPassword(
          email: email.text.trim(), password: password.text);
      }
    } on FirebaseAuthException catch (e) {
      if (mounted) setState(() => message = 'Authentication: ${e.code}');
    } finally {
      if (mounted) setState(() => busy = false);
    }
  }

  @override
  Widget build(BuildContext context) => Scaffold(
    appBar: AppBar(title: const Text('Firebase login / signup')),
    body: ListView(padding: const EdgeInsets.all(20), children: [
      TextField(controller: email,
        keyboardType: TextInputType.emailAddress,
        decoration: const InputDecoration(labelText: 'Email')),
      TextField(controller: password, obscureText: true,
        decoration: const InputDecoration(labelText: 'Password')),
      const SizedBox(height: 16),
      FilledButton(onPressed: busy ? null : () => submit(register: false),
        child: const Text('Sign in')),
      OutlinedButton(onPressed: busy ? null : () => submit(register: true),
        child: const Text('Create account')),
      Text(message),
    ]),
  );
}

class MemberPage extends StatelessWidget {
  const MemberPage({super.key});
  @override
  Widget build(BuildContext context) => Scaffold(
    appBar: AppBar(title: const Text('Member area')),
    body: Center(child: Column(mainAxisSize: MainAxisSize.min,
      children: [
        Text('Signed in: ${FirebaseAuth.instance.currentUser?.email}'),
        FilledButton(onPressed: () => FirebaseAuth.instance.signOut(),
          child: const Text('Sign out')),
      ],
    )),
  );
}
