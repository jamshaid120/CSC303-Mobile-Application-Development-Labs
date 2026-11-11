import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class WorkItem {
  String title;
  bool completed;
  WorkItem(this.title, this.completed);
  Map<String, dynamic> toJson() =>
    {'title': title, 'completed': completed};
  factory WorkItem.fromJson(Map<String, dynamic> value) => WorkItem(
    value['title'] as String, value['completed'] as bool);
}

void main() => runApp(const MaterialApp(home: TaskBoard()));

class TaskBoard extends StatefulWidget {
  const TaskBoard({super.key});
  @override
  State<TaskBoard> createState() => _TaskBoardState();
}

class _TaskBoardState extends State<TaskBoard> {
  final prefs = SharedPreferencesAsync();
  final tasks = <WorkItem>[];

  @override
  void initState() { super.initState(); restore(); }

  Future<void> restore() async {
    final text = await prefs.getString('sprint_tasks');
    if (text == null) return;
    try {
      final rows = jsonDecode(text) as List<dynamic>;
      if (mounted) setState(() {
        tasks..clear()..addAll(rows.map((x) =>
          WorkItem.fromJson(x as Map<String, dynamic>)));
      });
    } catch (_) { /* Ignore corrupted demo data. */ }
  }

  Future<void> save() async {
    await prefs.setString('sprint_tasks',
      jsonEncode(tasks.map((x) => x.toJson()).toList()));
  }

  Future<void> addTask() async {
    String draft = '';
    final value = await showDialog<String>(context: context,
      builder: (dialogContext) => AlertDialog(
        title: const Text('New sprint task'),
        content: TextField(autofocus: true,
          onChanged: (value) => draft = value,
          decoration: const InputDecoration(hintText: 'Task title')),
        actions: [
          TextButton(onPressed: () => Navigator.pop(dialogContext),
            child: const Text('Cancel')),
          FilledButton(onPressed: () =>
            Navigator.pop(dialogContext, draft.trim()),
            child: const Text('Add')),
        ],
      ));
    if (value == null || value.isEmpty || !mounted) return;
    setState(() => tasks.add(WorkItem(value, false)));
    await save();
  }

  @override
  Widget build(BuildContext context) {
    final finished = tasks.where((x) => x.completed).length;
    return Scaffold(
      appBar: AppBar(title: Text('Sprint board • $finished/${tasks.length}')),
      floatingActionButton: FloatingActionButton(
        onPressed: addTask, child: const Icon(Icons.add)),
      body: ListView.builder(
        itemCount: tasks.length,
        itemBuilder: (context, i) {
          final item = tasks[i];
          return CheckboxListTile(
            value: item.completed,
            title: Text(item.title),
            subtitle: Text(item.completed ? 'Done' : 'Open'),
            secondary: IconButton(
              icon: const Icon(Icons.open_in_new),
              onPressed: () => Navigator.push(context, MaterialPageRoute(
                builder: (_) => TaskDetail(item: item)))),
            onChanged: (v) {
              setState(() => item.completed = v ?? false); save();
            },
          );
        },
      ),
    );
  }
}

class TaskDetail extends StatelessWidget {
  final WorkItem item;
  const TaskDetail({super.key, required this.item});
  @override
  Widget build(BuildContext context) => Scaffold(
    appBar: AppBar(title: const Text('Task detail')),
    body: Padding(padding: const EdgeInsets.all(20),
      child: Column(crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(item.title,
            style: Theme.of(context).textTheme.headlineSmall),
          Text('Current status: ${item.completed ? 'Done' : 'Open'}'),
        ],
      )),
  );
}
