import 'package:flutter/material.dart';
import 'data/course_repository.dart';
import 'viewmodel/course_viewmodel.dart';

void main() => runApp(const MaterialApp(home: CourseScreen()));

class CourseScreen extends StatefulWidget {
  const CourseScreen({super.key});
  @override
  State<CourseScreen> createState() => _CourseScreenState();
}

class _CourseScreenState extends State<CourseScreen> {
  late final CourseViewModel model;

  @override
  void initState() {
    super.initState();
    model = CourseViewModel(DemoCourseRepository())..load();
  }

  @override
  void dispose() { model.dispose(); super.dispose(); }

  @override
  Widget build(BuildContext context) => Scaffold(
    appBar: AppBar(title: const Text('MVVM course list')),
    body: AnimatedBuilder(
      animation: model,
      builder: (context, _) {
        if (model.loading) {
          return const Center(child: CircularProgressIndicator());
        }
        if (model.error != null) return Center(child: Text(model.error!));
        return ListView.builder(
          itemCount: model.courses.length,
          itemBuilder: (_, i) => ListTile(title: Text(model.courses[i])),
        );
      },
    ),
  );
}
