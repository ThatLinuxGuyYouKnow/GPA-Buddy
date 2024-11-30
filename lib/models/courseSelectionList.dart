import 'package:flutter/material.dart';
import 'package:gpa_calculator/widgets/courseSection.dart';

class CourseSelectionList extends ChangeNotifier {
  final List<Widget> courses = [
    const CourseSubsection(
      index: 0,
    )
  ];
  List<Widget> get courseList => courses;
  List<int> get courseWeight => _courseWeight;
  final List<int> _courseWeight = [];
  addCourse() {
    courses.add(CourseSubsection(
      index: courses.length + 1,
    ));
    notifyListeners();
  }

  removeCourse() {
    courses.removeLast();
    notifyListeners();
  }

  updateCourseUnit(int index, String text) {
    _courseWeight[index];
  }
}
