import 'package:flutter/material.dart' as material;
import 'package:noty_client/constants/theme.dart';
import 'package:noty_client/screens/start/fragment_login.dart';
import 'package:noty_client/screens/start/fragment_register.dart';

class LoginScreen extends material.StatefulWidget {
  const LoginScreen({material.Key? key}) : super(key: key);

  @override
  material.State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends material.State<LoginScreen> {
  @override
  material.Widget build(material.BuildContext context) {
    // Learn more about tab bar: https://docs.flutter.dev/cookbook/design/tabs
    // return material.DefaultTabController(
    //     length: 2,
    //     child: material.Scaffold(
    //       appBar: material.AppBar(
    //         bottom: const material.TabBar(
    //           tabs: [
    //             material.Tab(
    //                 text: "Login", icon: material.Icon(material.Icons.login)),
    //             material.Tab(
    //                 text: "Signup",
    //                 icon: material.Icon(material.Icons.person_add)),
    //           ],
    //         ),
    //       ),
    //       body: const material.TabBarView(
    //         children: [LoginFragment(), RegisterFragment()],
    //       ),
    //     ));
    return material.Scaffold(
      body: material.Padding(
        padding: const material.EdgeInsets.fromLTRB(30, 80, 30, 50),
        child: material.SizedBox(
          width: double.infinity,
          child: material.Column(
            mainAxisAlignment: material.MainAxisAlignment.spaceBetween,
            crossAxisAlignment: material.CrossAxisAlignment.center,
            children: [
              const LoginFragment(),
              material.Row(
                mainAxisAlignment: material.MainAxisAlignment.center,
                children: [
                  const material.Text("Don’t have an accout yet? "),
                  material.GestureDetector(
                    onTap: () {
                      material.Navigator.push(
                          context,
                          material.MaterialPageRoute(
                              builder: (context) => const RegisterFragment()));
                    },
                    child: material.Text(
                      "Register",
                      style: material.TextStyle(
                          color: ThemeConstant.colorPrimaryLight),
                    ),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
