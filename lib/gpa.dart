import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:gpa_calculator/logic/finalGpaCalculator.dart';
import 'package:gpa_calculator/widgets/courseSection.dart';
import 'package:gpa_calculator/widgets/courseSection.dart';

class GpaScreen extends StatefulWidget {
  const GpaScreen({super.key});

  @override
  State<GpaScreen> createState() => _GpaScreenState();
}

class _GpaScreenState extends State<GpaScreen> {
  double totalGradeCount = 0.0;
  double courseCount = 1.0;
  List<Widget> courses = [
    CourseSubsection(
      onGradeSelected: (grade) {},
      onCourseUnitChanged: (String courseUnit) {},
    )
  ];
  List<double> courseWeights = []; // To track individual course weights

  _addCourse() {
    setState(() {
      final index = courses.length; // Get index for the new course
      courseCount = index as double;
      courses.add(CourseSubsection(
        onRemove: (course) {
          _removeCourse(index); // Pass index to remove the correct course
        },
        onGradeSelected: (d) {},
        onCourseUnitChanged: (String courseUnit) {},
        onCourseWeightChanged: (double? courseWeight) {
          if (courseWeight != null) {
            setState(() {
              if (index < courseWeights.length) {
                totalGradeCount -= courseWeights[index]; // Remove old weight
                courseWeights[index] = courseWeight; // Update new weight
              } else {
                courseWeights.add(courseWeight); // Add new weight
              }
              totalGradeCount += courseWeight;

              courseCount = index as double;
            });
          }
        },
      ));
    });
    print('total grade count' + totalGradeCount.toString());
  }

  _removeCourse(int index) {
    setState(() {
      if (index < courses.length && index < courseWeights.length) {
        totalGradeCount -= courseWeights[index]; // Subtract the course's weight
        courses.removeAt(index); // Remove course widget
        courseWeights.removeAt(index); // Remove corresponding weight
      }
    });
  }

  @override
  Widget build(BuildContext context) {
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
                  size: !isDesktop & !isTablet ? 20 : 40,
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
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              ...courses,
                              const SizedBox(height: 20),
                            ],
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
                        calculateGPA(
                            totalGradeWeights: totalGradeCount,
                            numberOfCourses: courseCount);
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
