import 'package:flutter/material.dart';
import 'package:ryzen_display_flutter/display.dart';

void main() {
  runApp(const RyzenDisplay());
}

class RyzenDisplay extends StatelessWidget {
  const RyzenDisplay({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "Ryzen display",
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
          seedColor: Colors.deepPurple,
          brightness: Brightness.dark,
        ),
      ),
      home: Scaffold(body: Display()),
    );
  }
}
