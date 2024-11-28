double getCourseWeight({required String grade, required String unit}) {
  double gradeWeight = switch (grade) {
    'A' => 5.0,
    'B' => 4.0,
    'C' => 3.0,
    'D' => 2.0,
    'E' => 1.0,
    'F' => 0.0,
    _ => throw ArgumentError('Invalid grade: $grade')
  };
  return gradeWeight * double.parse(unit);
}
