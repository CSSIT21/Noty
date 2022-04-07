import 'package:flutter/material.dart';
import 'package:noty_client/constants/manifest.dart';
import 'package:noty_client/constants/route.dart';
import 'package:noty_client/constants/theme.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // Root widget of the application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: ManifestConstant.appName,
      debugShowCheckedModeBanner: false,
      theme: ThemeConstant.theme,
      routes: RouteConstant.route(),
      initialRoute: "/",
    );
  }
}
