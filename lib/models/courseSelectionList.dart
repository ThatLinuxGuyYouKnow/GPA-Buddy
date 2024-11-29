import 'package:flutter/material.dart';
import 'package:gpa_calculator/widgets/courseSection.dart';

class CourseSelectionList extends ChangeNotifier {
  final List<Widget> courses = [CourseSubsection()];
  List<Widget> get courseList => courses;

  addCourse() {
    courses.add(const CourseSubsection());
  }

  removeCourse() {
    courses.removeLast();
  }
}
