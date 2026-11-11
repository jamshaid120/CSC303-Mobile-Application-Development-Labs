import 'package:flutter/material.dart';
import 'database.dart';

void main() => runApp(const MaterialApp(home: NotesPage()));

class NotesPage extends StatefulWidget {
  const NotesPage({super.key});
  @override
  State<NotesPage> createState() => _NotesPageState();
}

class _NotesPageState extends State<NotesPage> {
  final db = AppDatabase();
  final input = TextEditingController();

  @override
  void dispose() { input.dispose(); db.close(); super.dispose(); }

  Future<void> addNote() async {
    final text = input.text.trim();
    if (text.isEmpty || text.length > 200) return;
    await db.createNote(text);
    input.clear();
  }

  Future<void> editNote(Note note) async {
    var draft = note.content;
    final result = await showDialog<String>(
      context: context,
      builder: (dialogContext) => AlertDialog(
        title: const Text('Edit note'),
        content: TextFormField(
          initialValue: note.content,
          onChanged: (value) => draft = value,
        ),
        actions: [
          TextButton(onPressed: () => Navigator.pop(dialogContext),
              child: const Text('Cancel')),
          FilledButton(onPressed: () => Navigator.pop(dialogContext, draft),
              child: const Text('Save')),
        ],
      ),
    );
    if (!mounted || result == null) return;
    final changed = result.trim();
    if (changed.isEmpty || changed.length > 200) return;
    await db.updateNote(note.id, changed);
  }

  @override
  Widget build(BuildContext context) => Scaffold(
    appBar: AppBar(title: const Text('Drift notes')),
    body: Column(children: [
      Padding(padding: const EdgeInsets.all(12), child: Row(children: [
        Expanded(child: TextField(controller: input,
          decoration: const InputDecoration(labelText: 'New note'))),
        IconButton(onPressed: addNote, icon: const Icon(Icons.add)),
      ])),
      Expanded(child: StreamBuilder<List<Note>>(
        stream: db.watchNotes(),
        builder: (context, snapshot) {
          if (snapshot.hasError) return Text('Error: ${snapshot.error}');
          if (!snapshot.hasData) {
            return const Center(child: CircularProgressIndicator());
          }
          final values = snapshot.data!;
          return ListView.builder(
            itemCount: values.length,
            itemBuilder: (_, i) => ListTile(
              onTap: () => editNote(values[i]),
              title: Text(values[i].content),
              trailing: IconButton(
                icon: const Icon(Icons.delete_outline),
                onPressed: () => db.deleteNote(values[i].id)),
            ),
          );
        },
      )),
    ]),
  );
}
