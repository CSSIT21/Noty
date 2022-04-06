import 'package:flutter/material.dart' show WidgetBuilder;
import 'package:noty_client/screens/splash.dart' show Splash;

class RouteConstant {
  static Map<String, WidgetBuilder> route() {
    return <String, WidgetBuilder>{
      '/': (_) => const Splash(),
    };
  }
}
