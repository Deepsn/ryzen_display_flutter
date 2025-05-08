import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:ryzen_display_flutter/adj_widget.dart';
import 'package:ryzen_display_flutter/hooks/use_timer.dart';
import 'package:syncfusion_flutter_charts/sparkcharts.dart';

class TemperatureChart extends AdjWidget {
  const TemperatureChart({super.key, required super.adj});

  @override
  Widget build(BuildContext context) {
    final data = useState<List<double>>([]);

    useTimer(Duration(seconds: 1), (timer) {
      data.value = [...data.value, adj.getTCTLTemp()];

      if (data.value.length > 15) {
        data.value.removeAt(0);
      }
    });

    return Expanded(
      child: SfSparkAreaChart(
        data: data.value,
        color: Colors.blue.withAlpha((255 / 2).round()),
        borderColor: Colors.blue,
        borderWidth: 3,
      ),
    );
  }
}
