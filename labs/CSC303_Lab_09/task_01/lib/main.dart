import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() => runApp(const MaterialApp(home: ReadingGoalPage()));

class ReadingGoalPage extends StatefulWidget {
  const ReadingGoalPage({super.key});
  @override
  State<ReadingGoalPage> createState() => _ReadingGoalPageState();
}

class _ReadingGoalPageState extends State<ReadingGoalPage> {
  final prefs = SharedPreferencesAsync();
  int sessions = 0;
  bool loading = true;

  @override
  void initState() { super.initState(); load(); }

  Future<void> load() async {
    final value = await prefs.getInt('reading_sessions') ?? 0;
    if (!mounted) return;
    setState(() { sessions = value; loading = false; });
  }

  Future<void> addSession() async {
    final next = sessions + 1;
    await prefs.setInt('reading_sessions', next);
    if (mounted) setState(() => sessions = next);
  }

  Future<void> reset() async {
    await prefs.remove('reading_sessions');
    if (mounted) setState(() => sessions = 0);
  }

  @override
  Widget build(BuildContext context) => Scaffold(
    appBar: AppBar(title: const Text('Reading tracker')),
    body: Center(child: loading
      ? const CircularProgressIndicator()
      : Column(mainAxisSize: MainAxisSize.min, children: [
          Text('$sessions sessions completed',
            style: Theme.of(context).textTheme.headlineSmall),
          FilledButton(onPressed: addSession,
            child: const Text('Complete session')),
          TextButton(onPressed: reset, child: const Text('Reset')),
        ])),
  );
}
