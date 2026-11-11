import 'package:flutter_test/flutter_test.dart';
import 'package:mad_lab13/data/course_repository.dart';
import 'package:mad_lab13/viewmodel/course_viewmodel.dart';

class FakeRepo implements CourseRepository {
  final bool shouldFail;
  FakeRepo({this.shouldFail = false});
  @override
  Future<List<String>> loadCourses() async {
    if (shouldFail) throw StateError('test outage');
    return ['Mobile App Development', 'Operating Systems'];
  }
}

void main() {
  test('loads and reports courses', () async {
    final vm = CourseViewModel(FakeRepo());
    final transitions = <bool>[];
    vm.addListener(() => transitions.add(vm.loading));
    await vm.load();
    expect(transitions, [true, false]);
    expect(vm.courses, hasLength(2));
    expect(vm.error, isNull);
    vm.dispose();
  });
  test('reports repository error without staying busy', () async {
    final vm = CourseViewModel(FakeRepo(shouldFail: true));
    await vm.load();
    expect(vm.loading, isFalse);
    expect(vm.error, contains('test outage'));
    vm.dispose();
  });
}
