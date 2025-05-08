import 'dart:async';

import 'package:battery_plus/battery_plus.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:ryzen_display_flutter/adj_widget.dart';
import 'package:ryzen_display_flutter/hooks/use_timer.dart';
import 'package:syncfusion_flutter_sliders/sliders.dart';

class TemperatureLimitModifier extends AdjWidget {
  TemperatureLimitModifier({super.key, required super.adj});

  final battery = Battery();

  @override
  Widget build(BuildContext context) {
    final temperatureTarget = useState(getCurrentTemperatureLimit());

    useEffect(() {
      final subscription = battery.onBatteryStateChanged.listen((BatteryState state) {
        Timer(Duration(seconds: 2), () {
          print("Setting temp limit back to ${temperatureTarget.value}");
          changeTCTLTempLimit(temperatureTarget.value);
        });
      });
      return () => subscription.cancel();
    }, []);

    useTimer(Duration(minutes: 1), (timer) {
      temperatureTarget.value = getCurrentTemperatureLimit();
      print("Update temperature target ${temperatureTarget.value}");
    });

    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Align(
          alignment: AlignmentDirectional.centerStart,
          child: Padding(
            padding: const EdgeInsetsDirectional.only(start: 25),
            child: Text("Temperature Limit: ${temperatureTarget.value}°C"),
          ),
        ),
        SfSlider(
          value: temperatureTarget.value,
          min: 0,
          max: 100,
          showLabels: true,
          enableTooltip: true,
          onChanged: (dynamic newValue) {
            final value = (newValue as double).round();
            changeTCTLTempLimit(value);
            temperatureTarget.value = value;
          },
        ),
      ],
    );
  }

  int getCurrentTemperatureLimit() {
    return adj.getTCTLTempLimit().round();
  }

  void changeTCTLTempLimit(int temp) {
    final errorCode = adj.setTCTLTemp(temp);
    if (errorCode != 0) {
      print("Failed to change temps error code: $errorCode");
    }
  }
}
