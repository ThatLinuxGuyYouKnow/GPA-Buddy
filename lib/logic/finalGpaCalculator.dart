calculateGPA(
    {required double totalGradeWeights, required int numberOfCourses}) {
  print(numberOfCourses.toString() + "  number of courses");
  print(totalGradeWeights.toString() + "  grade weights");
  final double gpa = totalGradeWeights / numberOfCourses.toDouble();
  print(gpa);
  return gpa;
}
