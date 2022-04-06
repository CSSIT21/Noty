import 'package:flutter/material.dart' show Color, MaterialColor, ThemeData;
import 'package:noty_client/utils/graphics/color.dart' show createMaterialColor;

class ThemeConstant {
  // Colors
  static Color colorPrimaryLight = const Color(0xffb77fff);

  // Color swatch
  static MaterialColor materialColorSwatch = createMaterialColor(colorPrimaryLight);

  // Theme data
  static ThemeData theme = ThemeData(
    primarySwatch: materialColorSwatch,
  );
}
