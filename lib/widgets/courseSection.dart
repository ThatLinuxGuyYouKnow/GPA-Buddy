import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:gpa_calculator/logic/gradeAndUnitWeight.dart';

var grades = ['A', 'B', 'C', 'D', 'E', 'F'];

class CourseSubsection extends StatefulWidget {
  final void Function(CourseSubsection)? onRemove;
  final Function(String selectedCourse) onGradeSelected;
  final Function(double courseWeight)? onCourseWeightChanged;
  const CourseSubsection(
      {super.key,
      this.onRemove,
      required this.onGradeSelected,
      this.onCourseWeightChanged});

  @override
  State<CourseSubsection> createState() => _CourseSubsectionState();
}

class _CourseSubsectionState extends State<CourseSubsection> {
  final unitController = TextEditingController();
  String selectedGrade = 'A';
  double courseWeightCalculation = 0.0;

  // Expose the course weight calculation externally
  double get courseWeight => courseWeightCalculation;

  String get courseUnits => unitController.text;

  void updateCourseWeight() {
    if (unitController.text.isNotEmpty) {
      courseWeightCalculation =
          getCourseWeight(grade: selectedGrade, unit: unitController.text);
      widget.onCourseWeightChanged?.call(courseWeightCalculation);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            child: Row(
              children: [
                Expanded(
                  flex: 2,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Course Name',
                        style: GoogleFonts.ubuntu(fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(height: 8),
                      TextField(
                        decoration: InputDecoration(
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(8),
                          ),
                          hintText: 'Enter course name',
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  flex: 1,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Units',
                        style: GoogleFonts.ubuntu(fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(height: 8),
                      TextField(
                        controller: unitController,
                        decoration: InputDecoration(
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(8),
                          ),
                          hintText: 'Units',
                        ),
                        keyboardType: TextInputType.number,
                        inputFormatters: [
                          FilteringTextInputFormatter.allow(
                              RegExp(r'^[0-9]$')), // Allow only single digits
                        ],
                        onChanged: (_) {
                          setState(() {
                            updateCourseWeight();
                          });
                        },
                      ),
                    ],
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  flex: 1,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Grade',
                        style: GoogleFonts.ubuntu(fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(height: 8),
                      DropdownButtonFormField<String>(
                        value: selectedGrade,
                        decoration: InputDecoration(
                          contentPadding: const EdgeInsets.symmetric(
                            vertical: 12,
                            horizontal: 10,
                          ),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(8),
                            borderSide: const BorderSide(color: Colors.grey),
                          ),
                          filled: true,
                          fillColor: Colors.grey.shade100,
                        ),
                        dropdownColor: Colors.white,
                        style: GoogleFonts.ubuntu(
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
                        ),
                        items: grades.map((String grade) {
                          return DropdownMenuItem(
                            value: grade,
                            child: Text(
                              grade,
                              style: GoogleFonts.ubuntu(
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          );
                        }).toList(),
                        onChanged: (
                          String? change,
                        ) {
                          setState(() {
                            selectedGrade = change ?? 'A';
                            updateCourseWeight();
                            widget.onGradeSelected(selectedGrade);
                          });
                        },
                        icon: const Icon(
                          Icons.arrow_drop_down,
                          color: Colors.black,
                        ),
                      ),
                    ],
                  ),
                ),
                if (widget.onRemove != null)
                  IconButton(
                    icon: const Icon(Icons.delete, color: Colors.red),
                    onPressed: () => widget.onRemove!(widget),
                  ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
