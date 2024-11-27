import 'package:flutter/material.dart';

class GpaScreen extends StatefulWidget {
  GpaScreen({super.key});
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('GPA Calculator'),
      ),
      body: LayoutBuilder(
        builder: (BuildContext context, BoxConstraints constraints) {
          final isDesktop = constraints.maxWidth > 900;
          final isTablet =
              constraints.maxWidth > 600 && constraints.maxWidth <= 900;
          final containerWidth = isDesktop
              ? constraints.maxWidth * 0.4
              : isTablet
                  ? constraints.maxWidth * 0.6
                  : constraints.maxWidth * 0.85;
        },
      ),
    );
  }
}
