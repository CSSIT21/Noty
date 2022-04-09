import 'package:flutter/material.dart' as material;
import 'package:noty_client/utils/graphics/color.dart' as color;

class ThemeConstant {
  // Colors
  static material.Color colorPrimaryLight = const material.Color(0xffb77fff);

  // Color swatch
  static material.MaterialColor materialColorSwatch = color.createMaterialColor(colorPrimaryLight);

  // Theme data
  static material.ThemeData theme = material.ThemeData(
    primarySwatch: materialColorSwatch,
  );
}
