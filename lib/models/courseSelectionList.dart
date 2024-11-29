import 'package:flutter/material.dart';

class CourseSelectionList extends ChangeNotifier {
  final List<Widget> courses = [];
  List<Widget> get courseList => courses;
}
