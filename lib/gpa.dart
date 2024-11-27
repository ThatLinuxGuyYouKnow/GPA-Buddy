import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:gpa_calculator/widgets/courseSection.dart';

class GpaScreen extends StatelessWidget {
  const GpaScreen({super.key}); // Use `const` for better optimization.

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
                  ))
            ],
          ),
          body: Center(
            child: SingleChildScrollView(
              child: Container(
                constraints: const BoxConstraints(
                  minHeight: 350,
                  maxHeight: 500,
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
                        maxHeight: 300,
                      ),
                      padding: const EdgeInsets.all(10),
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.grey.shade300),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: const Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          CourseSubsection(), // Use the updated widget
                          SizedBox(height: 20),
                          CourseSubsection(),
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
