import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform);
  runApp(const MaterialApp(home: AccountPage()));
}

class AccountPage extends StatefulWidget {
  const AccountPage({super.key});
  @override
  State<AccountPage> createState() => _AccountPageState();
}

class _AccountPageState extends State<AccountPage> {
  final email = TextEditingController();
  String feedback = 'Sign in using Task 1, or provide an email to reset.';
  @override
  void dispose() { email.dispose(); super.dispose(); }

  Future<void> reset() async {
    final value = email.text.trim();
    if (!value.contains('@')) {
      setState(() => feedback = 'Enter a valid email format'); return;
    }
    try {
      await FirebaseAuth.instance.sendPasswordResetEmail(email: value);
      if (mounted) setState(() => feedback =
        'If an account is eligible, a reset email will be sent.');
    } on FirebaseAuthException {
      if (mounted) setState(() => feedback =
        'Reset unavailable; check email settings or try later.');
    }
  }

  Future<void> verify() async {
    final user = FirebaseAuth.instance.currentUser;
    if (user == null) return;
    try {
      await user.sendEmailVerification();
      if (mounted) setState(() => feedback = 'Check your inbox.');
    } on FirebaseAuthException catch (e) {
      if (mounted) setState(() => feedback = 'Verification: ${e.code}');
    }
  }

  @override
  Widget build(BuildContext context) {
    final user = FirebaseAuth.instance.currentUser;
    return Scaffold(
      appBar: AppBar(title: const Text('Account tools')),
      body: ListView(padding: const EdgeInsets.all(20), children: [
        Text('Current user: ${user?.email ?? 'Not signed in'}'),
        Text('Verified: ${user?.emailVerified ?? false}'),
        TextField(controller: email,
          decoration: const InputDecoration(labelText: 'Reset email')),
        FilledButton(onPressed: reset,
          child: const Text('Send password reset')),
        OutlinedButton(onPressed: user == null ? null : verify,
          child: const Text('Send verification email')),
        OutlinedButton(onPressed: user == null ? null
          : () async { await FirebaseAuth.instance.signOut();
              if (mounted) setState(() {}); },
          child: const Text('Sign out')),
        Text(feedback),
      ]),
    );
  }
}
