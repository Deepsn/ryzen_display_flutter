import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:ryzen_display_flutter/adj_widget.dart';
import 'package:ryzen_display_flutter/hooks/use_timer.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

class TemperatureData {
  TemperatureData(this.index, this.temperature);

  final int index;
  final double temperature;
}

class TemperatureChart extends AdjWidget {
  const TemperatureChart({super.key, required super.adj});

  @override
  Widget build(BuildContext context) {
    final data = useState<List<double>>([]);
    final maxTemperature = useState(100.0);

    useTimer(Duration(seconds: 1), (timer) {
      data.value = [...data.value, adj.getTCTLTemp()];

      if (data.value.length > 15) {
        data.value.removeAt(0);
      }

      maxTemperature.value = adj.getTCTLTempLimit() + 5;
    });

    return Expanded(
      child: SfCartesianChart(
        plotAreaBorderWidth: 0,
        primaryXAxis: const NumericAxis(majorGridLines: MajorGridLines(width: 0), isVisible: false),
        primaryYAxis: CategoryAxis(
          axisLine: AxisLine(width: 0),
          majorTickLines: MajorTickLines(size: 0),
          maximum: maxTemperature.value,
          minimum: 1,
        ),

        series: <LineSeries<TemperatureData, num>>[
          LineSeries<TemperatureData, num>(
            dataSource: _getChartData(data.value),
            xValueMapper: (TemperatureData data, _) => data.index,
            yValueMapper: (TemperatureData data, _) => data.temperature,
            animationDuration: 0,
            animationDelay: 0,
          ),
        ],
      ),
    );
  }

  List<TemperatureData> _getChartData(List<double> data) {
    return data.mapIndexed((index, temperature) => TemperatureData(index, temperature)).toList();
  }
}
