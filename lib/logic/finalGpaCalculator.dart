calculateGPA(
    {required double totalGradeWeights, required double numberOfCourses}) {
  print(numberOfCourses.toString() + "  number of courses");
  print(totalGradeWeights.toString() + "  grade weights");
  final double gpa = totalGradeWeights / numberOfCourses;
  print(gpa);
  return totalGradeWeights / numberOfCourses;
}
