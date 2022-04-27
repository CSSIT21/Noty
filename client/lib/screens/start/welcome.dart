import 'package:flutter/material.dart' as material;
import 'package:noty_client/constants/theme.dart';
import 'package:noty_client/screens/start/login.dart';
import 'package:noty_client/widgets/typography/content_text.dart';
import 'package:noty_client/types/widget/placement.dart';

class WelcomeScreen extends material.StatefulWidget {
  const WelcomeScreen({material.Key? key}) : super(key: key);

  @override
  material.State<WelcomeScreen> createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends material.State<WelcomeScreen> {
  @override
  material.Widget build(material.BuildContext context) {
    double screenHeight = material.MediaQuery.of(context).size.height;

    return material.WillPopScope(
      onWillPop: () async => false,
      child: material.Scaffold(
        body: material.Padding(
          padding:
              material.EdgeInsets.only(top: screenHeight / 5.5, bottom: 50),
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
                      padding:
                          const material.EdgeInsets.fromLTRB(50, 40, 50, 30),
                      child: material.Text(
                        "Place to make you PAIN",
                        textAlign: material.TextAlign.center,
                        style: material.TextStyle(
                            fontSize: 34,
                            fontWeight: material.FontWeight.w800,
                            color: ThemeConstant.colorPrimaryLight),
                      ),
                    ),
                    const ContentText(
                        text: "Easy and convenience place to note?",
                        size: Size.medium),
                  ],
                ),
                material.Container(
                  padding: const material.EdgeInsets.only(left: 35, right: 35),
                  width: double.infinity,
                  height: 50,
                  child: material.ElevatedButton(
                      child: const ContentText(
                          text: "Get Started", size: Size.medium),
                      onPressed: () {
                        material.Navigator.pushReplacement(
                            context,
                            material.MaterialPageRoute(
                                builder: (context) => const LoginScreen()));
                      }),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
