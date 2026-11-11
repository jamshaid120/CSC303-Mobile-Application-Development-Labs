import 'package:flutter/material.dart';

void main() => runApp(const MaterialApp(home: CoursesPage()));

class CoursesPage extends StatefulWidget {
  const CoursesPage({super.key});
  @override
  State<CoursesPage> createState() => _CoursesPageState();
}

class _CoursesPageState extends State<CoursesPage> {
  String selected = 'No course selected';
  final courses = const ['Mobile Application Development',
    'Database Systems', 'Software Engineering'];

  Future<void> openDetail(String course) async {
    final result = await Navigator.push<String>(context,
      MaterialPageRoute(builder: (_) => DetailPage(name: course)));
    if (!mounted || result == null) return;
    setState(() => selected = result);
  }

  @override
  Widget build(BuildContext context) => Scaffold(
    appBar: AppBar(title: const Text('Course navigator')),
    body: Column(children: [
      Padding(padding: const EdgeInsets.all(16),
        child: Text('Chosen: $selected')),
      Expanded(child: ListView(
        children: courses.map((name) => ListTile(
          title: Text(name), trailing: const Icon(Icons.chevron_right),
          onTap: () => openDetail(name),
        )).toList(),
      )),
    ]),
  );
}

class DetailPage extends StatelessWidget {
  final String name;
  const DetailPage({super.key, required this.name});

  @override
  Widget build(BuildContext context) => Scaffold(
    appBar: AppBar(title: const Text('Course details')),
    body: Center(child: Column(mainAxisSize: MainAxisSize.min,
      children: [
        Text(name, style: Theme.of(context).textTheme.titleLarge),
        const SizedBox(height: 18),
        FilledButton(
          onPressed: () => Navigator.pop(context, name),
          child: const Text('Choose course'),
        ),
      ],
    )),
  );
}
