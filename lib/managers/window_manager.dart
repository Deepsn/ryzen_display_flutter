import 'package:flutter/material.dart';
import 'package:window_manager/window_manager.dart';

Future<void> manageWindow() async {
  WidgetsFlutterBinding.ensureInitialized();
  await windowManager.ensureInitialized();

  WindowOptions options = WindowOptions(
    size: Size(300, 200),
    minimumSize: Size(300, 200),
    backgroundColor: Colors.transparent,
    center: true,
    skipTaskbar: false,
    titleBarStyle: TitleBarStyle.hidden,
  );

  windowManager.waitUntilReadyToShow(options, () async {
    await windowManager.setBackgroundColor(Colors.transparent);
    await windowManager.show();
    await windowManager.focus();
  });
}
