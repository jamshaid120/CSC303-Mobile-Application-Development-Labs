import 'package:flutter/material.dart';

void main() => runApp(const MaterialApp(home: CampusShell()));

class CampusShell extends StatefulWidget {
  const CampusShell({super.key});
  @override
  State<CampusShell> createState() => _CampusShellState();
}

class _CampusShellState extends State<CampusShell> {
  int page = 0;
  final titles = const ['Home', 'Courses', 'Account'];
  final views = const [
    Center(child: Text('Campus dashboard')),
    Center(child: Text('Enrolled courses')),
    Center(child: Text('Student account')),
  ];

  @override
  Widget build(BuildContext context) => Scaffold(
    appBar: AppBar(title: Text(titles[page])),
    drawer: Drawer(child: SafeArea(child: ListView(children: [
      const UserAccountsDrawerHeader(
        accountName: Text('CSC303 Student'),
        accountEmail: Text('student@example.com')),
      ListTile(leading: const Icon(Icons.home),
        title: const Text('Home'), onTap: () {
          Navigator.pop(context); setState(() => page = 0);
        }),
      ListTile(leading: const Icon(Icons.person),
        title: const Text('Account'), onTap: () {
          Navigator.pop(context); setState(() => page = 2);
        }),
    ]))),
    body: IndexedStack(index: page, children: views),
    bottomNavigationBar: NavigationBar(
      selectedIndex: page,
      onDestinationSelected: (value) => setState(() => page = value),
      destinations: const [
        NavigationDestination(icon: Icon(Icons.home), label: 'Home'),
        NavigationDestination(icon: Icon(Icons.book), label: 'Courses'),
        NavigationDestination(icon: Icon(Icons.person), label: 'Account'),
      ],
    ),
  );
}
