import 'dart:async';

import 'package:flutter_hooks/flutter_hooks.dart';

void useTimer(Duration duration, void Function(Timer) callback) {
  useEffect(() {
    final timer = Timer.periodic(duration, callback);
    return timer.cancel;
  }, []);
}
