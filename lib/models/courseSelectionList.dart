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

  final List<int> _courseUnit = [0]; // Initialize with a default value
  final List<int> _courseWeight = [0]; // Initialize with a default value

  addCourse() {
    courses.add(CourseSubsection(
      index: courses.length,
    ));
    _courseUnit.add(0); // Add a corresponding unit entry
    _courseWeight.add(0); // Add a corresponding weight entry
    print('new index: ${courses.length}');
    notifyListeners();
  }

  removeCourse() {
    if (courses.length > 1) {
      // Prevent removing the last course
      courses.removeLast();
      _courseUnit.removeLast();
      _courseWeight.removeLast();
      notifyListeners();
    }
  }

  updateCourseWeight(int index, int weight) {
    if (index >= 0 && index < _courseWeight.length) {
      _courseWeight[index] = weight;
      notifyListeners();
      print('course weignht' + courseWeight.toString());
    }
  }

  updateCourseUnit(int index, String text) {
    if (index >= 0 && index < _courseUnit.length) {
      _courseUnit[index] = int.tryParse(text) ?? 0;
      print(courseUnit);
      notifyListeners();
    }
  }
}
