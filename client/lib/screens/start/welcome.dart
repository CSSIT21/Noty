import 'package:flutter/material.dart' as material;
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
        padding: const material.EdgeInsets.fromLTRB(0, 150, 0, 50),
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
                  const material.Padding(
                    padding: material.EdgeInsets.fromLTRB(50, 50, 50, 30),
                    child: material.Text(
                      "Place to make you PAIN",
                      textAlign: material.TextAlign.center,
                      style: material.TextStyle(
                          fontSize: 34,
                          fontWeight: material.FontWeight.w700,
                          color: material.Color(0xff6ABFF9)),
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
                    style: material.ButtonStyle(
                      shape: material.MaterialStateProperty.all<
                          material.RoundedRectangleBorder>(
                        material.RoundedRectangleBorder(
                          borderRadius: material.BorderRadius.circular(10.0),
                        ),
                      ),
                    ),
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
