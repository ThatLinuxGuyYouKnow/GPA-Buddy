double calculateGPA(
    {required double totalGradeWeights, required int totalUnits}) {
  print(totalGradeWeights.toString() + "        totalGradeWeightss");
  print(totalUnits.toString() + "         total units");

  if (totalUnits == 0) return 0.0; // Avoid division by zero
  return totalGradeWeights / totalUnits;
}
