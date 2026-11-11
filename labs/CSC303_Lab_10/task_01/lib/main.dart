import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class Post {
  final int id;
  final String title;
  const Post(this.id, this.title);
  factory Post.fromJson(Map<String, dynamic> json) =>
      Post(json['id'] as int, json['title'] as String);
}

Future<List<Post>> fetchPosts() async {
  final response = await http.get(
    Uri.parse('https://jsonplaceholder.typicode.com/posts'))
      .timeout(const Duration(seconds: 12));
  if (response.statusCode != 200) {
    throw Exception('Server returned ${response.statusCode}');
  }
  final values = jsonDecode(response.body) as List<dynamic>;
  return values.map((e) => Post.fromJson(e as Map<String, dynamic>))
      .toList();
}

void main() => runApp(const MaterialApp(home: PostsPage()));

class PostsPage extends StatefulWidget {
  const PostsPage({super.key});
  @override
  State<PostsPage> createState() => _PostsPageState();
}

class _PostsPageState extends State<PostsPage> {
  late Future<List<Post>> request;
  @override
  void initState() { super.initState(); request = fetchPosts(); }

  @override
  Widget build(BuildContext context) => Scaffold(
    appBar: AppBar(title: const Text('REST posts')),
    floatingActionButton: FloatingActionButton(
      onPressed: () => setState(() => request = fetchPosts()),
      child: const Icon(Icons.refresh)),
    body: FutureBuilder<List<Post>>(
      future: request,
      builder: (context, snapshot) {
        if (snapshot.connectionState != ConnectionState.done) {
          return const Center(child: CircularProgressIndicator());
        }
        if (snapshot.hasError) {
          return Center(child: Text('Request failed: ${snapshot.error}'));
        }
        final posts = snapshot.data ?? [];
        return ListView.builder(itemCount: posts.length,
          itemBuilder: (_, i) => ListTile(
            leading: CircleAvatar(child: Text('${posts[i].id}')),
            title: Text(posts[i].title),
          ));
      },
    ),
  );
}
