import 'package:flutter_test/flutter_test.dart';
import 'package:mad_lab13/course_math.dart';

void main() {
  test('all maximum marks sum to 100', () {
    expect(totalScore(assignment: 25, midterm: 25,
        finalExam: 50), 100);
  });

  test('out-of-range marks are rejected', () {
    expect(() => totalScore(assignment: 26, midterm: 20,
      finalExam: 40), throwsArgumentError);
  });
}
