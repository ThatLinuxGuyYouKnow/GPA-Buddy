import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:gpa_calculator/widgets/courseSection.dart';

class GpaScreen extends StatefulWidget {
  const GpaScreen({super.key}); // Use `const` for better optimization.

  @override
  State<GpaScreen> createState() => _GpaScreenState();
}

class _GpaScreenState extends State<GpaScreen> {
  // List to store course widgets
  final List<CourseSubsection> courses = [CourseSubsection()];

  // Method to add a new course
  void _addCourse() {
    setState(() {
      courses.add(CourseSubsection());
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
          appBar: AppBar(
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
                constraints: const BoxConstraints(
                  minHeight: 350,
                  maxHeight: 800, // Increased height for dynamic content
                ),
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
                      constraints: const BoxConstraints(
                        minHeight: 200,
                        maxHeight: 600, // Allow room for multiple courses
                      ),
                      padding: const EdgeInsets.all(10),
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.grey.shade300),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          // Display dynamic list of courses
                          ...courses,
                          const SizedBox(height: 20),
                          // Add Course Button
                          InkWell(
                            onTap: _addCourse, // Add new course when tapped
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
                          // Calculate GPA Button
                          Container(
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
                        ],
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
