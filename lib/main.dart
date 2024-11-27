import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:gpa_calculator/gpa.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'GPA CALCULATOR',
        theme: ThemeData(
          fontFamily: GoogleFonts.ubuntu.toString(),
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.black),
          useMaterial3: true,
        ),
        home: GpaScreen());
  }
}
