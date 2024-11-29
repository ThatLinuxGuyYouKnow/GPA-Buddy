import 'package:flutter/material.dart';

class CourseSubsection extends StatefulWidget {
  final Function(double)? onGradeSelected;
  final Function(String)? onCourseUnitChanged;

  CourseSubsection({
    super.key,
    this.onGradeSelected,
    this.onCourseUnitChanged,
  });

  @override
  State<CourseSubsection> createState() => CourseSubsectionState();
}

class CourseSubsectionState extends State<CourseSubsection> {
  double? gradeValue;
  int? courseUnits;

  void updateGrade(double grade) {
    setState(() {
      gradeValue = grade;
    });
  }

  void updateUnits(String units) {
    setState(() {
      courseUnits = int.tryParse(units);
    });
  }

  double? getGradeValue() => gradeValue;
  int? getCourseUnits() => courseUnits;

  @override
  Widget build(BuildContext context) {
    // Build logic here for grade/unit input
    return Column(
      children: [
        // Example: Dropdown for grades
        DropdownButton<double>(
          value: gradeValue,
          onChanged: (value) {
            updateGrade(value ?? 0.0);
            if (widget.onGradeSelected != null) {
              widget.onGradeSelected!(value ?? 0.0);
            }
          },
          items: [4.0, 3.0, 2.0, 1.0, 0.0]
              .map((e) => DropdownMenuItem(value: e, child: Text('$e')))
              .toList(),
        ),
        // Example: TextField for units
        TextField(
          onChanged: (value) {
            updateUnits(value);
            if (widget.onCourseUnitChanged != null) {
              widget.onCourseUnitChanged!(value);
            }
          },
          keyboardType: TextInputType.number,
          decoration: const InputDecoration(hintText: 'Units'),
        ),
      ],
    );
  }
}
