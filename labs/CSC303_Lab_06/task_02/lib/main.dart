import 'package:flutter/material.dart';

void main() => runApp(const MaterialApp(home: SwipePage()));

class SwipePage extends StatefulWidget {
  const SwipePage({super.key});
  @override
  State<SwipePage> createState() => _SwipePageState();
}

class _SwipePageState extends State<SwipePage> {
  final List<String> tasks = ['Read Flutter docs',
    'Finish layout lab', 'Review pull request', 'Run widget tests'];

  @override
  Widget build(BuildContext context) => Scaffold(
    appBar: AppBar(title: const Text('Swipe tasks')),
    body: ListView.builder(
      itemCount: tasks.length,
      itemBuilder: (context, i) {
        final item = tasks[i];
        return Dismissible(
          key: ValueKey(item),
          background: Container(color: Colors.red.shade100,
            alignment: Alignment.centerLeft,
            child: const Icon(Icons.delete_outline)),
          confirmDismiss: (_) async => await showDialog<bool>(
            context: context,
            builder: (dialogContext) => AlertDialog(
              title: const Text('Delete task?'),
              content: Text(item),
              actions: [
                TextButton(onPressed: () => Navigator.pop(dialogContext, false),
                    child: const Text('Cancel')),
                FilledButton(onPressed: () => Navigator.pop(dialogContext, true),
                    child: const Text('Delete')),
              ],
            ),
          ) ?? false,
          onDismissed: (_) {
            setState(() => tasks.remove(item));
            ScaffoldMessenger.of(context).hideCurrentSnackBar();
            ScaffoldMessenger.of(context).showSnackBar(SnackBar(
              content: Text('Deleted $item'),
              action: SnackBarAction(label: 'UNDO', onPressed: () {
                setState(() => tasks.insert((i < tasks.length ? i : tasks.length), item));
              }),
            ));
          },
          child: ListTile(title: Text(item)),
        );
      },
    ),
  );
}
