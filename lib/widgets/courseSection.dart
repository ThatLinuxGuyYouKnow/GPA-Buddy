import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

var grades = ['A', 'B', 'C', 'D', 'E', 'F'];

class CourseSubsection extends StatefulWidget {
  CourseSubsection({super.key});
  @override
  State<CourseSubsection> createState() => _CourseSubsectionState();
}

class _CourseSubsectionState extends State<CourseSubsection> {
  // Add `const` for immutable widgets.
  String selectedGrade = 'A';

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Flexible(
          flex: 2,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Course Name',
                style: GoogleFonts.ubuntu(fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 8),
              TextField(
                decoration: InputDecoration(
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                  hintText: 'Enter course name',
                ),
              ),
            ],
          ),
        ),
        const SizedBox(width: 16),
        Flexible(
          flex: 1,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Units',
                  style: GoogleFonts.ubuntu(fontWeight: FontWeight.bold)),
              const SizedBox(height: 8),
              TextField(
                decoration: InputDecoration(
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                  hintText: 'Units',
                ),
                keyboardType: TextInputType.number,
              ),
            ],
          ),
        ),
        const SizedBox(width: 16),
        Flexible(
          flex: 1,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Grade',
                style: GoogleFonts.ubuntu(fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 8),
              DropdownButtonFormField<String>(
                value: selectedGrade,
                decoration: InputDecoration(
                  contentPadding:
                      const EdgeInsets.symmetric(vertical: 12, horizontal: 10),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                    borderSide: const BorderSide(color: Colors.grey),
                  ),
                  filled: true,
                  fillColor: Colors.grey.shade100,
                ),
                dropdownColor: Colors.white,
                style: GoogleFonts.ubuntu(
                    fontWeight: FontWeight.bold, color: Colors.black),
                items: grades.map((String grade) {
                  return DropdownMenuItem(
                    value: grade,
                    child: Text(
                      grade,
                      style: GoogleFonts.ubuntu(fontWeight: FontWeight.w500),
                    ),
                  );
                }).toList(),
                onChanged: (String? change) {
                  setState(() {
                    selectedGrade = change ?? 'A';
                  });
                },
                icon: const Icon(Icons.arrow_drop_down, color: Colors.black),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
