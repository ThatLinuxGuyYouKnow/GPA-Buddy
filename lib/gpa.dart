import 'package:flutter/material.dart';

class GpaScreen extends StatelessWidget {
  GpaScreen({super.key});
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
          body: Center(
            child: Column(
              children: [],
            ),
          ),
        );
      },
    );
  }
}
