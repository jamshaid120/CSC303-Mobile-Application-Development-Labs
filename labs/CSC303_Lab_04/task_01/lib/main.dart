import 'package:flutter/material.dart';

void main() => runApp(const MaterialApp(home: RegisterPage()));

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});
  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final key = GlobalKey<FormState>();
  final name = TextEditingController();
  final roll = TextEditingController();
  String section = 'A';
  bool agreed = false;

  @override
  void dispose() {
    name.dispose(); roll.dispose(); super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Register for MAD lab')),
      body: Form(key: key, child: ListView(
        padding: const EdgeInsets.all(20), children: [
          TextFormField(
            controller: name,
            decoration: const InputDecoration(labelText: 'Full name'),
            validator: (s) => (s == null || s.trim().length < 3)
                ? 'Enter at least 3 characters' : null,
          ),
          TextFormField(
            controller: roll,
            decoration: const InputDecoration(labelText: 'Roll number'),
            validator: (s) => (s == null || s.trim().isEmpty)
                ? 'Roll number is required' : null,
          ),
          DropdownButtonFormField<String>(
            initialValue: section,
            items: const [
              DropdownMenuItem(value: 'A', child: Text('Section A')),
              DropdownMenuItem(value: 'B', child: Text('Section B')),
            ],
            onChanged: (v) => setState(() => section = v ?? 'A'),
          ),
          CheckboxListTile(
            value: agreed,
            title: const Text('I will submit original work'),
            onChanged: (v) => setState(() => agreed = v ?? false),
          ),
          FilledButton(
            onPressed: () {
              if (!key.currentState!.validate()) return;
              if (!agreed) {
                ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                  content: Text('Accept the declaration first')));
                return;
              }
              showDialog<void>(context: context, builder: (context) =>
                AlertDialog(
                  title: const Text('Registered'),
                  content: Text('${name.text.trim()} (${roll.text.trim()}) '
                      'in Section $section'),
                  actions: [TextButton(onPressed: () => Navigator.pop(context),
                      child: const Text('OK'))],
                ));
            },
            child: const Text('Register'),
          ),
        ],
      )),
    );
  }
}
