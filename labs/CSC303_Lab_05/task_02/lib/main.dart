import 'package:flutter/material.dart';

void main() => runApp(MaterialApp(
  initialRoute: '/',
  onGenerateRoute: (settings) {
    if (settings.name == '/') {
      return MaterialPageRoute(builder: (_) => const HomePage());
    }
    if (settings.name == '/profile') {
      final label = settings.arguments as String? ?? 'Guest';
      return MaterialPageRoute(
        builder: (_) => ProfilePage(label: label), settings: settings);
    }
    return MaterialPageRoute(builder: (_) => const ErrorPage());
  },
));

class HomePage extends StatelessWidget {
  const HomePage({super.key});
  @override
  Widget build(BuildContext context) => Scaffold(
    appBar: AppBar(title: const Text('Named routes')),
    body: Center(child: FilledButton(
      onPressed: () => Navigator.pushNamed(context, '/profile',
          arguments: 'Student representative'),
      child: const Text('Open profile'),
    )),
  );
}

class ProfilePage extends StatelessWidget {
  final String label;
  const ProfilePage({super.key, required this.label});
  @override
  Widget build(BuildContext context) => Scaffold(
    appBar: AppBar(title: const Text('Profile')),
    body: Center(child: Text(label)),
  );
}

class ErrorPage extends StatelessWidget {
  const ErrorPage({super.key});
  @override
  Widget build(BuildContext context) => const Scaffold(
    body: Center(child: Text('Route not found')),
  );
}
