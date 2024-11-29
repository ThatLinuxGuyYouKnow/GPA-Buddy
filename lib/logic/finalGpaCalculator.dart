double calculateGPA(
    {required double totalGradeWeights, required int totalUnits}) {
  print(totalGradeWeights.toString() +
      "        totalGradeWeightss"); //! important: this always turns up empty,==0

  print(totalUnits.toString() +
      "         total units"); //! important: this always turns up empty,==0

  if (totalUnits == 0) return 0.0; // Avoid division by zero
  return totalGradeWeights / totalUnits;
}
