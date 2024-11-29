double calculateGPA(
    {required double totalGradeWeights, required int totalUnits}) {
  if (totalUnits == 0) return 0.0; // Avoid division by zero
  return totalGradeWeights / totalUnits;
}
