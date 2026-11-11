import 'package:flutter/material.dart';

void main() => runApp(const MaterialApp(home: DirectoryPage()));

class Student {
  final String name;
  final String department;
  final String? phone;
  const Student(this.name, this.department, this.phone);
}

class DirectoryPage extends StatefulWidget {
  const DirectoryPage({super.key});
  @override
  State<DirectoryPage> createState() => _DirectoryPageState();
}

class _DirectoryPageState extends State<DirectoryPage> {
  final entries = const [
    Student('Ayesha', 'CS', '0300-0000001'),
    Student('Hamza', 'SE', null),
    Student('Hina', 'CS', '0300-0000003'),
    Student('Bilal', 'SE', null),
  ];
  String selected = 'All';

  @override
  Widget build(BuildContext context) {
    final visible = entries.where((s) =>
        selected == 'All' || s.department == selected).toList();
    return Scaffold(
      appBar: AppBar(title: const Text('Student directory')),
      body: Column(children: [
        SegmentedButton<String>(
          segments: const [
            ButtonSegment(value: 'All', label: Text('All')),
            ButtonSegment(value: 'CS', label: Text('CS')),
            ButtonSegment(value: 'SE', label: Text('SE')),
          ],
          selected: {selected},
          onSelectionChanged: (v) => setState(() => selected = v.first),
        ),
        Expanded(child: ListView.builder(
          itemCount: visible.length,
          itemBuilder: (context, i) {
            final s = visible[i];
            return ListTile(
              leading: CircleAvatar(child: Text(s.name[0])),
              title: Text(s.name),
              subtitle: Text('${s.department} • ${s.phone ?? 'No phone'}'),
            );
          },
        )),
      ]),
    );
  }
}
