import 'package:flutter/material.dart';

void main() => runApp(const ThemeTabsApp());

class ThemeTabsApp extends StatefulWidget {
  const ThemeTabsApp({super.key});
  @override
  State<ThemeTabsApp> createState() => _ThemeTabsAppState();
}

class _ThemeTabsAppState extends State<ThemeTabsApp> {
  bool dark = false;

  @override
  Widget build(BuildContext context) => MaterialApp(
    theme: ThemeData(colorSchemeSeed: Colors.indigo, useMaterial3: true),
    darkTheme: ThemeData(colorSchemeSeed: Colors.indigo,
      brightness: Brightness.dark, useMaterial3: true),
    themeMode: dark ? ThemeMode.dark : ThemeMode.light,
    home: DefaultTabController(length: 2, child: Scaffold(
      appBar: AppBar(
        title: const Text('Course workspace'),
        actions: [PopupMenuButton<String>(
          onSelected: (v) { if (v == 'theme') setState(() => dark = !dark); },
          itemBuilder: (_) => [PopupMenuItem(
            value: 'theme', child: Text(dark ? 'Light mode' : 'Dark mode'))],
        )],
        bottom: const TabBar(tabs: [
          Tab(icon: Icon(Icons.note), text: 'Notes'),
          Tab(icon: Icon(Icons.task), text: 'Tasks'),
        ]),
      ),
      body: const TabBarView(children: [
        Center(child: Text('Lecture notes appear here')),
        Center(child: Text('Pending lab exercises appear here')),
      ]),
    )),
  );
}
