import 'package:flutter/widgets.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:ryzen_display_flutter/ryzenadj.dart';

import '../hooks/use_timer.dart';

class TDPDisplay extends HookWidget {
  const TDPDisplay({
    super.key,
    this.showMaxPowerDraw = false,
    required this.adj,
  });

  final RyzenAdj adj;
  final bool showMaxPowerDraw;

  @override
  Widget build(BuildContext context) {
    final tdp = useState(0.0);
    final maxTdp = useState(0.0);

    useTimer(Duration(seconds: 1), (timer) {
      tdp.value = adj.getCurrentPowerDraw();

      if (showMaxPowerDraw) {
        maxTdp.value = adj.getMaxPowerDraw();
      }
    });

    return Text(
      "${tdp.value.toStringAsFixed(1)}W${maxTdp.value > 0 ? " / ${maxTdp.value.toStringAsFixed(1)}W MAX" : ""}",
    );
  }
}
