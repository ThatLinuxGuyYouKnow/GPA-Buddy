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
  List<int> get courseUnit => _courseUnit;
  final List<int> _courseUnit = [];
  final List<int> _courseWeight = [];
  addCourse() {
    courses.add(CourseSubsection(
      index: courses.length,
    ));
    notifyListeners();
  }

  removeCourse() {
    courses.removeLast();
    notifyListeners();
  }

  updateCourseWeight(int index, int weight) {
    _courseWeight[index] = weight;
  }

  updateCourseUnit(int index, String text) {
    _courseUnit[index] = int.tryParse(text) ?? 0;
  }
}
