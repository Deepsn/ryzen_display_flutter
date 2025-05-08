import 'dart:ffi' as ffi;

import 'package:ryzen_display_flutter/types/ryzen_family.dart';

final class RyzenAccess extends ffi.Struct {
  external ffi.Pointer<ffi.Uint32> nb; // *uint32

  external ffi.Pointer<ffi.Bool> pci; // *bool

  external ffi.Pointer<ffi.Void> memObj; // pointer

  external ffi.Pointer<ffi.Void> mp1Smu; // class

  external ffi.Pointer<ffi.Void> pSmu; // class

  @ffi.Int32()
  external int ryzenFamilyRaw; // enum index

  @ffi.Int64()
  external int biosIfVer; // int

  RyzenFamily get ryzenFamily =>
      RyzenFamily.values.firstWhere((e) => e.customIndex == ryzenFamilyRaw);
}