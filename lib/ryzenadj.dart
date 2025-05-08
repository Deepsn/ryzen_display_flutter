import "package:ryzen_display_flutter/libryzen_lookups.dart";

class RyzenAdj {
  final lookups = LibRyzenLookups();
  var _refreshFails = 0;

  void refresh() {
    final errorCode = refreshTable();

    if (errorCode != 0) {
      _refreshFails++;
      assert(_refreshFails < 5, "Unable to refresh table with the status code of $errorCode");
    }
  }

  int refreshTable() {
    return lookups.refreshTable(lookups.access);
  }

  int getBiosIfVer() {
    return lookups.getSMUBiosVersion(lookups.access);
  }

  double getTCTLTemp() {
    refresh();
    return lookups.getTCTLTemp(lookups.access);
  }

  double getCurrentPowerDraw() {
    refresh();
    return lookups.getCurrentPowerDraw(lookups.access);
  }

  double getMaxPowerDraw() {
    refresh();
    return lookups.getMaxPowerDraw(lookups.access);
  }

  double getTCTLTempLimit() {
    refresh();
    return lookups.getTCTLTempLimit(lookups.access);
  }

  int setTCTLTemp(int temp) {
    return lookups.setTCTLTemp(lookups.access, temp);
  }
}
