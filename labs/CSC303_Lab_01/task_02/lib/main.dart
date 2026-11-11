import 'package:flutter/material.dart';

void main() => runApp(const FirstPhoneApp());

class FirstPhoneApp extends StatelessWidget {
  const FirstPhoneApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'My First Android App',
      theme: ThemeData(colorSchemeSeed: Colors.teal, useMaterial3: true),
      home: const FirstPhonePage(),
    );
  }
}

class FirstPhonePage extends StatefulWidget {
  const FirstPhonePage({super.key});
  @override
  State<FirstPhonePage> createState() => _FirstPhonePageState();
}

class _FirstPhonePageState extends State<FirstPhonePage> {
  int taps = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('CSC303 • My Android phone')),
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Icon(Icons.phone_android, size: 70),
            const SizedBox(height: 16),
            Text('Button tapped $taps times',
                style: Theme.of(context).textTheme.headlineSmall),
            const SizedBox(height: 12),
            FilledButton(
              onPressed: () => setState(() => taps++),
              child: const Text('Tap on my phone'),
            ),
          ],
        ),
      ),
    );
  }
}
