import 'package:flutter/material.dart';

void main() => runApp(const MaterialApp(home: ProfilePage()));

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Faculty profile')),
      body: SafeArea(child: LayoutBuilder(builder: (context, size) {
        final wide = size.maxWidth >= 520;
        final portrait = Container(
          width: wide ? 140 : 100, height: 120,
          decoration: BoxDecoration(
            color: Colors.teal.shade100,
            borderRadius: BorderRadius.circular(16),
          ),
          child: const Icon(Icons.person, size: 75),
        );
        final details = const Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            Text('Muhammad Jamshaid Iqbal',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
            SizedBox(height: 8),
            Text('Department of Computer Science'),
            Text('COMSATS University Islamabad — Sahiwal'),
            SizedBox(height: 8),
            Chip(label: Text('Mobile Application Development')),
          ],
        );
        return SingleChildScrollView(
          padding: const EdgeInsets.all(20),
          child: Card(child: Padding(
            padding: const EdgeInsets.all(16),
            child: wide
                ? Row(children: [portrait, const SizedBox(width: 18),
                    Expanded(child: details)])
                : Column(children: [portrait, const SizedBox(height: 16),
                    details]),
          )),
        );
      })),
    );
  }
}
