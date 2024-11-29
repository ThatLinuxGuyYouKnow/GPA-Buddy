import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:gpa_calculator/logic/finalGpaCalculator.dart';
import 'package:gpa_calculator/widgets/courseSection.dart';

class GpaScreen extends StatefulWidget {
  const GpaScreen({super.key});

  @override
  State<GpaScreen> createState() => _GpaScreenState();
}

class _GpaScreenState extends State<GpaScreen> {
  double totalGradeCount = 0.0;
  int courseCount = 1; // Use integer for count
  double? calculatedGPA; // Store calculated GPA for display
  int totalCourseUnits = 0;
  List<Widget> courses = [
    CourseSubsection(
      onGradeSelected: (grade) {},
      onCourseUnitChanged: (String courseUnit) {},
    )
  ];
  List<double> courseWeights = []; // To track individual course weights

  void _addCourse() {
    setState(() {
      courses.add(CourseSubsection(
        onGradeSelected: (grade) {},
        onCourseUnitChanged: (String courseUnit) {
          int index = courses.length - 1;
          int units = int.tryParse(courseUnit) ?? 0;

          if (index < courseWeights.length) {
            totalCourseUnits -=
                courseWeights[index].toInt(); // Subtract old units
            courseWeights[index] = units.toDouble(); // Update with new units
          } else {
            courseWeights.add(units.toDouble()); // Add new units
          }

          totalCourseUnits += units;
        },
        onCourseWeightChanged: (double? courseWeight) {
          if (courseWeight != null) {
            int index = courses.length - 1;

            if (index < courseWeights.length) {
              totalGradeCount -= courseWeights[index];
              courseWeights[index] = courseWeight;
            } else {
              courseWeights.add(courseWeight);
            }
            totalGradeCount += courseWeight;
          }
        },
      ));
      courseCount = courses.length; // Update course count
    });
  }

  void _removeCourse(int index) {
    setState(() {
      if (index < courses.length && index < courseWeights.length) {
        totalGradeCount -= courseWeights[index]; // Subtract the weight
        totalCourseUnits -= courseWeights[index].toInt(); // Subtract the units
        courses.removeAt(index); // Remove the course widget
        courseWeights.removeAt(index); // Remove the weight
        courseCount = courses.length; // Update course count
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
                        setState(() {
                          calculatedGPA = calculateGPA(
                              totalGradeWeights: totalGradeCount,
                              totalUnits: courseCount);
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
