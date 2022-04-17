import 'package:flutter/material.dart' as material;
import 'package:noty_client/constants/theme.dart';
import 'package:noty_client/screens/start/login.dart';

class WelcomeScreen extends material.StatefulWidget {
  const WelcomeScreen({material.Key? key}) : super(key: key);

  @override
  material.State<WelcomeScreen> createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends material.State<WelcomeScreen> {
  @override
  material.Widget build(material.BuildContext context) {
    return material.Scaffold(
      body: material.Padding(
        padding: const material.EdgeInsets.only(top: 150, bottom: 50),
        child: material.SizedBox(
          width: double.infinity,
          child: material.Column(
            mainAxisAlignment: material.MainAxisAlignment.spaceBetween,
            crossAxisAlignment: material.CrossAxisAlignment.center,
            children: [
              material.Column(
                children: [
                  material.Image.asset(
                    "assets/images/logo.png",
                    width: 200,
                  ),
                  material.Padding(
                    padding: const material.EdgeInsets.fromLTRB(50, 50, 50, 30),
                    child: material.Text(
                      "Place to make you PAIN",
                      textAlign: material.TextAlign.center,
                      style: material.TextStyle(
                          fontSize: 34,
                          fontWeight: material.FontWeight.w800,
                          color: ThemeConstant.colorPrimaryLight),
                    ),
                  ),
                  const material.Text(
                    "Easy and convenience place to note?",
                    textAlign: material.TextAlign.center,
                    style: material.TextStyle(fontSize: 14),
                  ),
                ],
              ),
              material.SizedBox(
                width: 320,
                height: 50,
                child: material.ElevatedButton(
                    child: const material.Text("Get Started"),
                    onPressed: () {
                      material.Navigator.push(
                          context,
                          material.MaterialPageRoute(
                              builder: (context) => const LoginScreen()));
                    }),
              )
            ],
          ),
        ),
      ),
    );
  }
}
