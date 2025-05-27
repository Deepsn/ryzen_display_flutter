import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:indexed/indexed.dart';
import 'package:window_manager/window_manager.dart';

import '../charts/temperature_chart.dart';
import '../displays/tdp_display.dart';
import '../displays/temperature_display.dart';
import '../ryzenadj.dart';

class DisplayScreen extends StatefulWidget {
  const DisplayScreen({super.key});

  @override
  State<StatefulWidget> createState() => _DisplayScreenState();
}

class _DisplayScreenState extends State<DisplayScreen> with WindowListener {
  final adj = RyzenAdj();

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "Main display",
      theme: ThemeData(colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple, brightness: Brightness.dark)),
      home: Scaffold(
        backgroundColor: Colors.transparent,
        body: Indexer(
          children: [
            Indexed(
              index: 1,
              child: Positioned.fill(
                child: BackdropFilter(
                  filter: ImageFilter.blur(sigmaX: 50, sigmaY: 50),
                  child: Container(color: Colors.black.withAlpha(150)),
                ),
              ),
            ),

            Indexed(
              index: 3,
              child: Positioned.fill(child: DragToMoveArea(child: Container(color: Colors.transparent))),
            ),

            Indexed(
              index: 2,
              child: Column(
                children: [
                  TDPDisplay(adj: adj, showMaxPowerDraw: true),
                  TemperatureDisplay(adj: adj),

                  TemperatureChart(adj: adj),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
