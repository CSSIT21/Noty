import 'package:flutter/material.dart' as material;
import 'package:noty_client/screens/start/fragment_login.dart';
import 'package:noty_client/screens/start/fragment_register.dart';
import 'package:rounded_loading_button/rounded_loading_button.dart';

class LoginScreen extends material.StatefulWidget {
  const LoginScreen({material.Key? key}) : super(key: key);

  @override
  material.State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends material.State<LoginScreen> {
  final RoundedLoadingButtonController _btnController = RoundedLoadingButtonController();

  @override
  material.Widget build(material.BuildContext context) {
    // Learn more about tab bar: https://docs.flutter.dev/cookbook/design/tabs
    return material.DefaultTabController(
        length: 2,
        child: material.Scaffold(
          appBar: material.AppBar(
            bottom: const material.TabBar(
              tabs: [
                material.Tab(text: "Login", icon: material.Icon(material.Icons.login)),
                material.Tab(text: "Signup", icon: material.Icon(material.Icons.person_add)),
              ],
            ),
          ),
          body: const material.TabBarView(
            children: [LoginFragment(), RegisterFragment()],
          ),
        ));
  }
}
