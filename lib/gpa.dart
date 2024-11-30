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

class _GpaScreenState extends State<GpaScreen> {
  double totalGradeWeight = 0.0;
  int courseCount = 1;
  double? calculatedGPA;
  int totalCourseUnits = 0;

  @override
  Widget build(BuildContext context) {
    final courseListModel = Provider.of<CourseSelectionList>(context);

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
                    Container(
                      constraints: BoxConstraints(maxHeight: 700),
                      padding: const EdgeInsets.all(10),
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.grey.shade300),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: ListView.builder(
                        itemCount: courseListModel.courseList.length,
                        itemBuilder: (context, index) {
                          return CourseSubsection(
                            index: index,
                          );
                        },
                      ),
                    ),
                    const SizedBox(height: 20),
                    InkWell(
                      onTap: () => courseListModel.addCourse(),
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
                          // Use the provider's courseWeight and courseUnit lists
                          totalGradeWeight = courseListModel.courseWeight.fold(
                              0, (previous, current) => previous + current);
                          totalCourseUnits = courseListModel.courseUnit.fold(
                              0, (previous, current) => previous + current);
                          print(
                              'total corse unit' + totalCourseUnits.toString());
                          print('total grade weight' +
                              totalGradeWeight.toString());
                          // Calculate GPA
                          calculatedGPA = totalGradeWeight / totalCourseUnits;
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
