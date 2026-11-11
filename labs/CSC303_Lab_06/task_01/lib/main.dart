import 'package:flutter/material.dart';

void main() => runApp(const MaterialApp(home: NoticePage()));

class NoticePage extends StatefulWidget {
  const NoticePage({super.key});
  @override
  State<NoticePage> createState() => _NoticePageState();
}

class _NoticePageState extends State<NoticePage> {
  final search = TextEditingController();
  final notices = List.generate(200, (i) => 'Campus notice ${i + 1}');
  @override
  void dispose() { search.dispose(); super.dispose(); }

  @override
  Widget build(BuildContext context) {
    final visible = notices.where((e) =>
      e.toLowerCase().contains(search.text.toLowerCase())).toList();
    return Scaffold(
      appBar: AppBar(title: const Text('Campus notices')),
      body: Column(children: [
        Padding(padding: const EdgeInsets.all(12), child: TextField(
          controller: search,
          decoration: const InputDecoration(
            prefixIcon: Icon(Icons.search), labelText: 'Search notices',
            border: OutlineInputBorder(),
          ),
          onChanged: (_) => setState(() {}),
        )),
        Expanded(child: ListView.builder(
          itemCount: visible.length,
          itemBuilder: (context, i) => Card(
            child: ListTile(
              leading: const Icon(Icons.campaign_outlined),
              title: Text(visible[i]),
              subtitle: const Text('COMSATS Sahiwal'),
              onTap: () => ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text('Opened ${visible[i]}'))),
            ),
          ),
        )),
      ]),
    );
  }
}
