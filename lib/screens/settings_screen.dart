import 'package:flutter/material.dart';

import '../display.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "Settings",
      theme: ThemeData(colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple, brightness: Brightness.dark)),
      home: Scaffold(body: Display()),
    );
  }
}
