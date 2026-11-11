import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class Article {
  final int id;
  final String title;
  final String body;
  Article(this.id, this.title, this.body);
  factory Article.fromJson(Map<String, dynamic> x) => Article(
    x['id'] as int, x['title'] as String, x['body'] as String);
}

void main() => runApp(const MaterialApp(home: ArticleFeed()));

class ArticleFeed extends StatefulWidget {
  const ArticleFeed({super.key});
  @override
  State<ArticleFeed> createState() => _ArticleFeedState();
}

class _ArticleFeedState extends State<ArticleFeed> {
  final prefs = SharedPreferencesAsync();
  List<Article> articles = [];
  Set<String> favorites = {};
  String status = 'Loading...';
  bool busy = false;

  @override
  void initState() { super.initState(); load(); }

  Future<void> load() async {
    if (busy) return;
    setState(() => busy = true);
    var source = 'Live API';
    String raw;
    try {
      final response = await http.get(
        Uri.parse('https://jsonplaceholder.typicode.com/posts'))
          .timeout(const Duration(seconds: 10));
      if (response.statusCode != 200) throw Exception('HTTP error');
      raw = response.body;
      final parsed = jsonDecode(raw) as List<dynamic>;
      parsed.take(25).map((e) => Article.fromJson(
        e as Map<String, dynamic>)).toList();
      await prefs.setString('feed_cache', raw);
    } catch (_) {
      raw = await prefs.getString('feed_cache') ?? '[]';
      source = raw == '[]' ? 'Offline, no data' : 'Offline cache';
    }
    try {
      final decoded = jsonDecode(raw) as List<dynamic>;
      final values = decoded.take(25).map((e) =>
        Article.fromJson(e as Map<String, dynamic>)).toList();
      final saved = (await prefs.getStringList('favs')) ?? [];
      if (mounted) setState(() {
        articles = values; favorites = saved.toSet(); status = source;
      });
    } catch (_) {
      if (mounted) setState(() => status = 'Invalid response / cache');
    } finally {
      if (mounted) setState(() => busy = false);
    }
  }
  Future<void> toggle(int id) async {
    final next = {...favorites};
    if (!next.add('$id')) next.remove('$id');
    await prefs.setStringList('favs', next.toList());
    if (mounted) setState(() => favorites = next);
  }

  @override
  Widget build(BuildContext context) => Scaffold(
    appBar: AppBar(title: const Text('CSC303 article reader')),
    body: Column(children: [
      ListTile(title: Text(status),
        subtitle: Text('${favorites.length} favorites'),
        trailing: IconButton(onPressed: busy ? null : load,
          icon: const Icon(Icons.refresh))),
      if (busy) const LinearProgressIndicator(),
      Expanded(child: ListView.builder(
        itemCount: articles.length,
        itemBuilder: (context, i) {
          final article = articles[i];
          final saved = favorites.contains('${article.id}');
          return ListTile(
            title: Text(article.title),
            leading: CircleAvatar(child: Text('${article.id}')),
            trailing: IconButton(
              icon: Icon(saved ? Icons.bookmark : Icons.bookmark_border),
              onPressed: () => toggle(article.id)),
            onTap: () => Navigator.push(context, MaterialPageRoute(
              builder: (_) => ArticleDetail(article: article))),
          );
        },
      )),
    ]),
  );
}

class ArticleDetail extends StatelessWidget {
  final Article article;
  const ArticleDetail({super.key, required this.article});
  @override
  Widget build(BuildContext context) => Scaffold(
    appBar: AppBar(title: Text('Article ${article.id}')),
    body: ListView(padding: const EdgeInsets.all(20), children: [
      Text(article.title,
        style: Theme.of(context).textTheme.headlineSmall),
      const SizedBox(height: 12),
      Text(article.body),
    ]),
  );
}
