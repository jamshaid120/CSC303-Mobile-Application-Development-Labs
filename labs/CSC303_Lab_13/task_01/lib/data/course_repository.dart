abstract class CourseRepository {
  Future<List<String>> loadCourses();
}

class DemoCourseRepository implements CourseRepository {
  @override
  Future<List<String>> loadCourses() async {
    await Future<void>.delayed(const Duration(milliseconds: 300));
    return ['Mobile App Development', 'Database Systems',
      'Software Testing', 'Operating Systems'];
  }
}
