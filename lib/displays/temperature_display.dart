import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:ryzen_display_flutter/adj_widget.dart';

import '../hooks/use_timer.dart';

class TemperatureDisplay extends AdjWidget {
  const TemperatureDisplay({super.key, required super.adj});

  @override
  Widget build(BuildContext context) {
    final temperature = useState(0.0);

    useTimer(Duration(seconds: 1), (timer) {
      temperature.value = (adj.getTCTLTemp() * 10).floorToDouble() / 10;
    });

    return Text("${temperature.value}°C");
  }
}
