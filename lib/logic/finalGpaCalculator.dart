double calculateGPA(
    {required double totalGradeWeights, required int totalUnits}) {
  print(totalUnits.toString() + "         total units");
  print(totalGradeWeights.toString() + "        totalGradeWeightss");
  if (totalUnits == 0) return 0.0; // Avoid division by zero
  return totalGradeWeights / totalUnits;
}
