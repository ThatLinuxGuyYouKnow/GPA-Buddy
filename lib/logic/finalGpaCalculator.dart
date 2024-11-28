calculateGPA(
    {required double totalGradeWeights, required double numberOfCourses}) {
  final double gpa = totalGradeWeights / numberOfCourses;
  print(gpa);
  return totalGradeWeights / numberOfCourses;
}
