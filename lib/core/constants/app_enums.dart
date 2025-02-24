enum TimeBlockStatus {
  submitted,
  approved,
  rejected,
}

// lib/constants/enums/state_code_enum.dart

enum StateCode {
  alabama(1),
  alaska(2),
  arizona(3),
  arkansas(4),
  california(5),
  colorado(6),
  connecticut(7),
  delaware(8),
  florida(9),
  georgia(10),
  hawaii(11),
  idaho(12),
  illinois(13),
  indiana(14),
  iowa(15),
  kansas(16),
  kentucky(17),
  louisiana(18),
  maine(19),
  maryland(20),
  massachusetts(21),
  michigan(22),
  minnesota(23),
  mississippi(24),
  missouri(25),
  montana(26),
  nebraska(27),
  nevada(28),
  newHampshire(29),
  newJersey(30),
  newMexico(31),
  newYork(32),
  northCarolina(33),
  northDakota(34),
  ohio(35),
  oklahoma(36),
  oregon(37),
  pennsylvania(38),
  rhodeIsland(39),
  southCarolina(40),
  southDakota(41),
  tennessee(42),
  texas(43),
  utah(44),
  vermont(45),
  virginia(46),
  washington(47),
  westVirginia(48),
  wisconsin(49),
  wyoming(50);

  final int code;
  const StateCode(this.code);

  static StateCode fromCode(int code) {
    return StateCode.values.firstWhere(
      (state) => state.code == code,
      orElse: () => throw ArgumentError('Invalid state code: $code'),
    );
  }
}