import 'package:flutter/material.dart';
import 'package:gpa_calculator/widgets/courseSection.dart';

class CourseSelectionList extends ChangeNotifier {
  final List<Widget> courses = [const CourseSubsection()];
  List<Widget> get courseList => courses;

  addCourse() {
    courses.add(const CourseSubsection());
    notifyListeners();
  }

  removeCourse() {
    courses.removeLast();
    notifyListeners();
  }
}
