import 'package:flutter/foundation.dart';
import '../data/course_repository.dart';

class CourseViewModel extends ChangeNotifier {
  final CourseRepository repository;
  CourseViewModel(this.repository);
  List<String> courses = [];
  String? error;
  bool loading = false;

  Future<void> load() async {
    loading = true;
    error = null;
    notifyListeners();
    try {
      courses = await repository.loadCourses();
    } catch (e) {
      error = 'Unable to load courses: $e';
    } finally {
      loading = false;
      notifyListeners();
    }
  }
}
