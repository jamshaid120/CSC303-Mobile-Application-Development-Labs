import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

void main() => runApp(const MaterialApp(home: OfflinePage()));

class OfflinePage extends StatefulWidget {
  const OfflinePage({super.key});
  @override
  State<OfflinePage> createState() => _OfflinePageState();
}

class _OfflinePageState extends State<OfflinePage> {
  final prefs = SharedPreferencesAsync();
  List<String> titles = [];
  String status = 'Loading...';
  bool busy = false;

  @override
  void initState() { super.initState(); refresh(); }

  Future<void> refresh() async {
    if (busy) return;
    setState(() => busy = true);
    try {
      final response = await http.get(
        Uri.parse('https://jsonplaceholder.typicode.com/posts'))
          .timeout(const Duration(seconds: 10));
      if (response.statusCode != 200) throw Exception('HTTP error');
      final decoded = jsonDecode(response.body) as List<dynamic>;
      final latest = decoded.take(15).map((e) =>
        (e as Map<String, dynamic>)['title'] as String).toList();
      await prefs.setStringList('cached_bulletins', latest);
      if (mounted) setState(() {
        titles = latest; status = 'Online • Updated from API';
      });
    } catch (_) {
      final cached = await prefs.getStringList('cached_bulletins') ?? [];
      if (mounted) setState(() {
        titles = cached;
        status = cached.isEmpty ? 'Offline • No cached data yet'
            : 'Offline • Showing saved copy';
      });
    } finally {
      if (mounted) setState(() => busy = false);
    }
  }

  @override
  Widget build(BuildContext context) => Scaffold(
    appBar: AppBar(title: const Text('Offline bulletins')),
    body: Column(children: [
      ListTile(title: Text(status),
        trailing: IconButton(onPressed: busy ? null : refresh,
          icon: const Icon(Icons.refresh))),
      if (busy) const LinearProgressIndicator(),
      Expanded(child: ListView.builder(
        itemCount: titles.length,
        itemBuilder: (_, i) => ListTile(title: Text(titles[i])),
      )),
    ]),
  );
}
