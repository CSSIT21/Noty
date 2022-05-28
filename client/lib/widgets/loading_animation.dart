import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:noty_client/constants/theme.dart';

showLoading(BuildContext context) {
  showGeneralDialog(
    context: context,
    barrierDismissible: false,
    pageBuilder: (BuildContext context, animation, secondaryAnimation) {
      return SpinKitFadingCircle(
        color: ThemeConstant.colorPrimaryLight,
        size: 40.0,
      );
    },
  );
}
