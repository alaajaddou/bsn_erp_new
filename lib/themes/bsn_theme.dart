import 'package:flutter/material.dart';

class BsnTheme {
  static Color primaryColor = Colors.red;
  static Color secondaryColor = Colors.white;

  static Color getColor(Set<MaterialState> states) {
    const Set<MaterialState> interactiveStates = <MaterialState>{
      MaterialState.pressed,
      MaterialState.hovered,
      MaterialState.focused,
    };
    if (states.any(interactiveStates.contains)) {
      return Colors.white;
    }
    return Colors.white;
  }

  static theme() {
    return ThemeData(
        backgroundColor: primaryColor,
        indicatorColor: primaryColor,
        appBarTheme: AppBarTheme(backgroundColor: BsnTheme.primaryColor));
  }
}
