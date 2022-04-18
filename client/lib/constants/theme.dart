import 'package:flutter/material.dart' as material;
import 'package:flutter/services.dart';
import 'package:noty_client/utils/graphics/color.dart' as color;

class ThemeConstant {
  // Colors
  static material.Color colorPrimaryLight = const material.Color(0xff6ABFF9);
  static material.Color textColorPrimary = const material.Color(0xffffffff);
  static material.Color colorPrimaryDark = const material.Color(0xff161616);
  static material.Color textFieldBgColor = const material.Color(0xff2d2d2f);
  static material.Color textFieldTextColor = const material.Color(0xff98989f);
  static material.Color appBarColor = const material.Color(0xff1c1c1c);

  // Color swatch
  static material.MaterialColor materialColorSwatch =
      color.createMaterialColor(colorPrimaryLight);

  // Theme data
  static material.ThemeData theme = material.ThemeData(
      primarySwatch: materialColorSwatch,
      primaryColor: colorPrimaryLight,
      scaffoldBackgroundColor: colorPrimaryDark,
      textTheme: material.Typography().white,
      fontFamily: "SF-Pro-Display",
      primaryTextTheme: material.Typography().white,
      elevatedButtonTheme: material.ElevatedButtonThemeData(
        style: material.ButtonStyle(
          foregroundColor: material.MaterialStateProperty.all<material.Color>(
              textColorPrimary),
          shape: material.MaterialStateProperty.all<
              material.RoundedRectangleBorder>(
            material.RoundedRectangleBorder(
              borderRadius: material.BorderRadius.circular(10.0),
            ),
          ),
        ),
      ),
      appBarTheme: material.AppBarTheme(
          systemOverlayStyle: SystemUiOverlayStyle.light,
          foregroundColor: textColorPrimary),
      unselectedWidgetColor: colorPrimaryLight);
}
