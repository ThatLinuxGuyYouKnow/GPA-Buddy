calculateGPA(
    {required double totalGradeWeights, required double numberOfCourses}) {
  print(numberOfCourses.toString() + "  number of courses");
  print(totalGradeWeights.toString() + "  number of courses");
  final double gpa = totalGradeWeights / numberOfCourses;
  print(gpa);
  return totalGradeWeights / numberOfCourses;
}
