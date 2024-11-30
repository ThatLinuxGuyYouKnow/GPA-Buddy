import 'package:flutter/material.dart';
import 'package:gpa_calculator/widgets/courseSection.dart';

class CourseSelectionList extends ChangeNotifier {
  final List<Widget> courses = [const CourseSubsection()];
  List<Widget> get courseList => courses;
  List<int> courseWeight = [];
  List<int> _courseWeight = [];
  addCourse() {
    courses.add(const CourseSubsection());
    notifyListeners();
  }

  removeCourse() {
    courses.removeLast();
    notifyListeners();
  }

  updateCourseUnit(int index, String text) {}
}
