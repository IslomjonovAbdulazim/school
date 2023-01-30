// change default styles of app, set my styles as default.
import 'package:flutter/material.dart';

import 'colors.dart';
import 'dimensions.dart';

final s = Styles.instance;

class Styles {
  Styles._();

  static Styles instance = Styles._();

  TextStyle t({
    double? size,
    Color? color,
    FontWeight? weight,
    TextDecoration? decoration,
  }) {
    return TextStyle(
      decoration: decoration,
      color: color ?? c.c1,
      fontSize: size ?? d.t1,
      fontWeight: weight,
    );
  }

  ButtonStyle b({Size? size, Color? color}) {
    return ElevatedButton.styleFrom(
      backgroundColor: color ?? c.c3,
      fixedSize: size,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
    );
  }
}
