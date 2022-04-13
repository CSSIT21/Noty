import 'package:flutter/material.dart' as material;
import 'package:flutter/services.dart';
import 'package:noty_client/utils/graphics/color.dart' as color;

class ThemeConstant {
  // Colors
  static material.Color colorPrimaryLight = const material.Color(0xff6ABFF9);
  static material.Color textColorPrimary = const material.Color(0xffffffff);

  // Color swatch
  static material.MaterialColor materialColorSwatch =
      color.createMaterialColor(colorPrimaryLight);

  // Theme data
  static material.ThemeData theme = material.ThemeData(
    primarySwatch: materialColorSwatch,
    primaryColor: const material.Color(0xff6ABFF9),
    scaffoldBackgroundColor: const material.Color(0xff161616),
    textTheme: material.Typography().white,
    elevatedButtonTheme: material.ElevatedButtonThemeData(
      style: material.ButtonStyle(
        foregroundColor: material.MaterialStateProperty.all<material.Color>(
            textColorPrimary),
      ),
    ),
    appBarTheme: const material.AppBarTheme(
        systemOverlayStyle: SystemUiOverlayStyle.light),
  );
}
