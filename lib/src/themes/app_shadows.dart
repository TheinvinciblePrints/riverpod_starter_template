import 'package:flutter/material.dart';

class AppShadows {
  static const BoxShadow mobile = BoxShadow(
    offset: Offset(0, 0),
    blurRadius: 25,
    spreadRadius: 0,
    color: Color(0x14000000), // "#00000014"
  );

  static const BoxShadow card = BoxShadow(
    offset: Offset(0, 0),
    blurRadius: 10,
    spreadRadius: 0,
    color: Color(0x14000000), // "#00000014"
  );

  static const BoxShadow bar = BoxShadow(
    offset: Offset(0, -2),
    blurRadius: 4,
    spreadRadius: 0,
    color: Color(0x0D000000), // "#0000000d"
  );

  static const List<BoxShadow> mobileShadow = [mobile];
  static const List<BoxShadow> cardShadow = [card];
  static const List<BoxShadow> barShadow = [bar];
}
