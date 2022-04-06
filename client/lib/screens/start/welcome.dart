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
      appBar: material.AppBar(
        title: const material.Text("Welcome"),
        automaticallyImplyLeading: false, // Used for removing back button.
      ),
      body: material.SizedBox(
        width: double.infinity,
        child: material.Column(
          mainAxisAlignment: material.MainAxisAlignment.center,
          crossAxisAlignment: material.CrossAxisAlignment.center,
          children: [
            material.ElevatedButton(
                child: const material.Text("Login"),
                onPressed: () {
                  material.Navigator.push(context, material.MaterialPageRoute(builder: (context) => const LoginScreen()));
                }),
          ],
        ),
      ),
    );
  }
}
