import 'package:flutter/material.dart' as material;
import 'package:noty_client/screens/splash.dart' show SplashScreen;
import 'package:noty_client/screens/start/welcome.dart' show WelcomeScreen;

class RouteConstant {
  static Map<String, material.WidgetBuilder> route() {
    return <String, material.WidgetBuilder>{
      '/': (_) => const SplashScreen(),
      '/welcome': (_) => const WelcomeScreen(),
    };
  }
}
