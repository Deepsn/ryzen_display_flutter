import 'package:flutter/material.dart';
import 'package:ryzen_display_flutter/screens/display_screen.dart';

import 'managers/window_manager.dart';

void main() async {
  await manageWindow();
  runApp(const DisplayScreen());
}
