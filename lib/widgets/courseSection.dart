import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:gpa_calculator/models/courseSelectionList.dart';
import 'package:provider/provider.dart';

class CourseSubsection extends StatefulWidget {
  final Function(String)? onGradeSelected;
  final Function(String)? onCourseUnitChanged;
  final int index;

  const CourseSubsection({
    super.key,
    this.onGradeSelected,
    this.onCourseUnitChanged,
    required this.index,
  });

  @override
  CourseSubsectionState createState() => CourseSubsectionState();
}

class CourseSubsectionState extends State<CourseSubsection> {
  double? gradeValue;
  int? courseUnits;

  double? getGradeValue() => gradeValue;
  int? getCourseUnits() => courseUnits;
  var grades = ['A', 'B', 'C', 'D', 'E', 'F'];
  final unitController = TextEditingController();
  String selectedGrade = 'A';
  Widget build(BuildContext context) {
    final courseListModel = Provider.of<CourseSelectionList>(context);
    void updateGrade(String grade) {
      courseListModel.updateCourseUnit(widget.index, grade);
    }

    void updateUnits(String units) {
      setState(() {
        courseUnits = int.tryParse(units);
      });
    }

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
                            RegExp(r'^[0-9]+$'),
                          ),
                        ],
                        onChanged: (value) {
                          widget.onCourseUnitChanged!(value);
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
                        onChanged: (value) {
                          if (value != null) {
                            setState(() {
                              selectedGrade = value;
                            });
                            widget.onGradeSelected!(value);
                          }
                        },
                        icon: const Icon(
                          Icons.arrow_drop_down,
                          color: Colors.black,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
