import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:ryzen_display_flutter/charts/temperature_chart.dart';
import 'package:ryzen_display_flutter/displays/tdp_display.dart';
import 'package:ryzen_display_flutter/displays/temperature_display.dart';
import 'package:ryzen_display_flutter/modifiers/temperature_modifier.dart';
import 'package:ryzen_display_flutter/ryzenadj.dart';

class Display extends HookWidget {
  Display({super.key});

  final adj = RyzenAdj();

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        TDPDisplay(adj: adj, showMaxPowerDraw: true),
        TemperatureDisplay(adj: adj),

        TemperatureLimitModifier(adj: adj),
        TemperatureChart(adj: adj),
      ],
    );
  }
}
