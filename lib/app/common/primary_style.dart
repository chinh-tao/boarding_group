import 'package:flutter/material.dart';

class PrimaryStyle {
  static String fontFamily = 'NotoSansJP';

  static TextStyle bold(double size,
      {Color? color, double? height, TextDecoration? decoration}) {
    return TextStyle(
        fontSize: size,
        fontFamily: fontFamily,
        fontWeight: FontWeight.bold,
        height: height,
        decoration: decoration,
        color: color);
  }

  static TextStyle medium(double size,
      {Color? color, double? height, double? spacing}) {
    return TextStyle(
        fontSize: size,
        fontFamily: fontFamily,
        fontWeight: FontWeight.w600,
        height: height,
        color: color,
        letterSpacing: spacing);
  }

  static TextStyle normal(double size,
      {Color? color, double? height, double? spacing}) {
    return TextStyle(
        fontSize: size,
        fontFamily: fontFamily,
        fontWeight: FontWeight.w500,
        color: color,
        height: height,
        letterSpacing: spacing);
  }

  static TextStyle regular(double size,
      {Color? color,
      TextDecoration? decoration,
      double? height,
      double? spacing}) {
    return TextStyle(
        fontSize: size,
        fontFamily: fontFamily,
        fontWeight: FontWeight.w400,
        decoration: decoration,
        color: color,
        height: height,
        letterSpacing: spacing);
  }

  static TextStyle light(double size,
      {Color? color, double? height, double? spacing}) {
    return TextStyle(
        fontSize: size,
        fontFamily: fontFamily,
        fontWeight: FontWeight.w200,
        height: height,
        letterSpacing: spacing);
  }

  static TextStyle get error {
    return TextStyle(
        fontSize: 17, color: Colors.redAccent, fontFamily: fontFamily);
  }
}
