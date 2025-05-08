enum RyzenFamily {
  waitForLoad(-2),
  famUnknown(-1),
  famRaven(0),
  famPicasso(1),
  famRenoir(2),
  famCezanne(3),
  famDali(4),
  famLucienne(5),
  famVanGogh(6),
  famRembrandt(7),
  famMendocino(8),
  famPhoenix(9),
  famHawkPoint(10),
  famStrixPoint(11),
  famStrixHalo(12),
  famEnd(13);

  /// Your custom (possibly negative) index
  final int customIndex;
  const RyzenFamily(this.customIndex);
}