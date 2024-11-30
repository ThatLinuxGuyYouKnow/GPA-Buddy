import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:gpa_calculator/models/courseSelectionList.dart';
import 'package:gpa_calculator/widgets/courseSection.dart';
import 'package:provider/provider.dart';

class GpaScreen extends StatefulWidget {
  const GpaScreen({super.key});

  @override
  State<GpaScreen> createState() => _GpaScreenState();
}

List<Map<String, dynamic>> courses = [
  {
    'widget': CourseSubsection(
      key: GlobalKey<CourseSubsectionState>(),
      onGradeSelected: (grade) {},
      onCourseUnitChanged: (String courseUnit) {},
    ),
    'key': GlobalKey<CourseSubsectionState>(),
  }
];

class _GpaScreenState extends State<GpaScreen> {
  double totalGradeWeight = 0.0;
  int courseCount = 1;
  double? calculatedGPA;
  int totalCourseUnits = 0;

  // Use a list of courses with keys
  List<Map<String, dynamic>> courses = [
    {
      'widget': CourseSubsection(
        key: GlobalKey<CourseSubsectionState>(),
        onGradeSelected: (grade) {},
        onCourseUnitChanged: (String courseUnit) {},
      ),
      'key': GlobalKey<CourseSubsectionState>(),
    }
  ];

  void _addCourse() {
    setState(() {
      final newKey = GlobalKey<CourseSubsectionState>();
      courses.add({
        'widget': CourseSubsection(
          key: newKey,
          onGradeSelected: (grade) {},
          onCourseUnitChanged: (unit) {
            print(unit.toString());
          },
        ),
        'key': newKey,
      });
    });
  }

  void _removeCourse(int index) {
    setState(() {
      if (index < courses.length) {
        courses.removeAt(index);
        courseCount = courses.length;
      }
    });
  }

  double _convertGradeToValue(String grade) {
    switch (grade) {
      case 'A':
        return 5.0;
      case 'B':
        return 4.0;
      case 'C':
        return 3.0;
      case 'D':
        return 2.0;
      case 'E':
        return 1.0;
      case 'F':
        return 0.0;
      default:
        return 0.0;
    }
  }

  @override
  Widget build(BuildContext context) {
    final textListModel = Provider.of<CourseSelectionList>(context);
    return LayoutBuilder(
      builder: (BuildContext context, BoxConstraints constraints) {
        final isDesktop = constraints.maxWidth > 900;
        final isTablet =
            constraints.maxWidth > 600 && constraints.maxWidth <= 900;
        final containerWidth = isDesktop
            ? constraints.maxWidth * 0.4
            : isTablet
                ? constraints.maxWidth * 0.6
                : constraints.maxWidth * 0.85;

        return Scaffold(
          backgroundColor: Colors.white,
          appBar: AppBar(
            backgroundColor: Colors.white,
            actions: [
              IconButton(
                onPressed: null,
                icon: Icon(
                  Icons.settings,
                  size: !isDesktop && !isTablet ? 20 : 40,
                  color: Colors.black,
                ),
              )
            ],
          ),
          body: Center(
            child: SingleChildScrollView(
              child: Container(
                width: containerWidth,
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.grey.shade300),
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      'GPA Calculator',
                      style: GoogleFonts.ubuntu(
                        fontSize: 30,
                        fontWeight: FontWeight.bold,
                      ),
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: 20),
                    ConstrainedBox(
                      constraints: const BoxConstraints(
                        minHeight: 200,
                        maxHeight: 650,
                      ),
                      child: Container(
                        padding: const EdgeInsets.all(10),
                        decoration: BoxDecoration(
                          border: Border.all(color: Colors.grey.shade300),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: SingleChildScrollView(
                          child: Expanded(
                            child: ListView.builder(
                              itemCount: textListModel.courseList.length,
                              itemBuilder: (context, index) {
                                return const CourseSubsection();
                              },
                            ),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 20),
                    InkWell(
                      onTap: _addCourse,
                      child: Container(
                        decoration: BoxDecoration(
                          border: Border.all(),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        height: 50,
                        width: double.infinity,
                        child: const Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(Icons.add),
                            SizedBox(width: 8),
                            Text('Add Course'),
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(height: 20),
                    InkWell(
                      onTap: () {
                        setState(() {
                          for (var course in courses) {
                            final courseKey = course['key']
                                as GlobalKey<CourseSubsectionState>;
                            final state = courseKey.currentState;

                            final grade = state?.getGradeValue();
                            final units = state?.getCourseUnits();

                            if (grade != null && units != null) {
                              totalGradeWeight += grade * units;
                              totalCourseUnits += units;
                            }
                          }
                        });
                      },
                      child: Container(
                        decoration: BoxDecoration(
                          color: Colors.black,
                          border: Border.all(),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        height: 50,
                        width: double.infinity,
                        child: Center(
                          child: Text(
                            'Calculate GPA',
                            style: GoogleFonts.ubuntu(
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 20),
                    calculatedGPA != null
                        ? Text(
                            'Your GPA: ${calculatedGPA!.toStringAsFixed(2)}',
                            style: GoogleFonts.ubuntu(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                            ),
                          )
                        : const SizedBox.shrink(),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
