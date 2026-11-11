int totalScore({required int assignment,
    required int midterm, required int finalExam}) {
  if (assignment < 0 || assignment > 25 ||
      midterm < 0 || midterm > 25 ||
      finalExam < 0 || finalExam > 50) {
    throw ArgumentError('Marks out of range');
  }
  return assignment + midterm + finalExam;
}
