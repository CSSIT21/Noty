import 'package:flutter/material.dart' as material;
import 'package:noty_client/screens/core/index.dart';

class LoginScreen extends material.StatefulWidget {
  const LoginScreen({material.Key? key}) : super(key: key);

  @override
  material.State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends material.State<LoginScreen> {
  @override
  material.Widget build(material.BuildContext context) {
    // Learn more about tab bar: https://docs.flutter.dev/cookbook/design/tabs
    return material.DefaultTabController(
        length: 2,
        child: material.Scaffold(
          appBar: material.AppBar(
            title: const material.Text("Get into your account"),
            bottom: const material.TabBar(
              tabs: [
                material.Tab(text: "Login", icon: material.Icon(material.Icons.login)),
                material.Tab(text: "Signup", icon: material.Icon(material.Icons.person_add)),
              ],
            ),
          ),
          body: material.TabBarView(
            children: [
              material.Column(
                mainAxisAlignment: material.MainAxisAlignment.center,
                children: [
                  material.ElevatedButton(
                      onPressed: () {
                        material.Navigator.push(
                            context, material.MaterialPageRoute(builder: (context) => const CoreScreen()));
                      },
                      child: const material.Text("Login")),
                ],
              ),
              const material.Text("Page 2")
            ],
          ),
        ));
  }
}
