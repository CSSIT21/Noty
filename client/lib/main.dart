import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:noty_client/constants/manifest.dart';
import 'package:noty_client/constants/route.dart';
import 'package:noty_client/constants/theme.dart';
import 'package:noty_client/services/providers/providers.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(MultiProvider(
    providers: [
      ChangeNotifierProvider(create: (_) => NotesProvider()),
      ChangeNotifierProvider(create: (_) => ProfileProvider()),
    ],
    child: const MyApp(),
  ));
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // Root widget of the application.
  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle.light);

    return MaterialApp(
      title: ManifestConstant.appName,
      debugShowCheckedModeBanner: false,
      theme: ThemeConstant.theme,
      routes: RouteConstant.route(),
      initialRoute: "/home",
    );
  }
}
