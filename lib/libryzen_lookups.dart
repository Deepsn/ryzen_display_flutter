import 'dart:ffi' as ffi;

import 'package:ryzen_display_flutter/types/ryzen_access.dart';

typedef RyzenAccessPtr = ffi.Pointer<RyzenAccess>;

typedef InitRyzenAdjFFI = RyzenAccessPtr Function();
typedef InitRyzenAdj = RyzenAccessPtr Function();

typedef GetSMUBiosVersionFFI = ffi.Int Function(RyzenAccessPtr);
typedef GetSMUBiosVersion = int Function(RyzenAccessPtr);

typedef InitTableFFI = ffi.Int Function(RyzenAccessPtr);
typedef InitTable = int Function(RyzenAccessPtr);

typedef RefreshTableFFI = ffi.Int Function(RyzenAccessPtr);
typedef RefreshTable = int Function(RyzenAccessPtr);

typedef GetTCTLTempFFI = ffi.Float Function(RyzenAccessPtr);
typedef GetTCTLTemp = double Function(RyzenAccessPtr);

typedef GetCurrentPowerDrawFFI = ffi.Float Function(RyzenAccessPtr);
typedef GetCurrentPowerDraw = double Function(RyzenAccessPtr);

typedef GetMaxPowerDrawFFI = ffi.Float Function(RyzenAccessPtr);
typedef GetMaxPowerDraw = double Function(RyzenAccessPtr);

typedef SetTCTLTempFFI = ffi.Int Function(RyzenAccessPtr, ffi.Uint32);
typedef SetTCTLTemp = int Function(RyzenAccessPtr, int);

class LibRyzenLookups {
  final lib = ffi.DynamicLibrary.open("libryzenadj.dll");

  late RyzenAccessPtr access;

  late RefreshTable refreshTable;

  late GetSMUBiosVersion getSMUBiosVersion;
  late GetTCTLTemp getTCTLTemp;
  late GetCurrentPowerDraw getCurrentPowerDraw;
  late GetMaxPowerDraw getMaxPowerDraw;

  late GetTCTLTemp getTCTLTempLimit;
  late SetTCTLTemp setTCTLTemp;

  LibRyzenLookups() {
    InitRyzenAdj initRyzenAdj = lib.lookup<ffi.NativeFunction<InitRyzenAdjFFI>>("init_ryzenadj").asFunction();
    access = initRyzenAdj();

    InitTable initTable = lib.lookup<ffi.NativeFunction<InitTableFFI>>("init_table").asFunction();
    int errorCode = initTable(access);
    assert(errorCode == 0);

    refreshTable = lib.lookup<ffi.NativeFunction<RefreshTableFFI>>("refresh_table").asFunction();

    getSMUBiosVersion = lib.lookup<ffi.NativeFunction<GetSMUBiosVersionFFI>>("get_bios_if_ver").asFunction();
    getTCTLTemp = lib.lookup<ffi.NativeFunction<GetTCTLTempFFI>>("get_tctl_temp_value").asFunction();
    getCurrentPowerDraw = lib.lookup<ffi.NativeFunction<GetCurrentPowerDrawFFI>>("get_fast_value").asFunction();
    getMaxPowerDraw = lib.lookup<ffi.NativeFunction<GetMaxPowerDrawFFI>>("get_fast_limit").asFunction();

    getTCTLTempLimit = lib.lookup<ffi.NativeFunction<GetTCTLTempFFI>>("get_tctl_temp").asFunction();
    setTCTLTemp = lib.lookup<ffi.NativeFunction<SetTCTLTempFFI>>("set_tctl_temp").asFunction();
  }
}
