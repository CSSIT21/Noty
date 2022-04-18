import 'dart:async';

import 'package:flutter/material.dart';
import 'package:noty_client/constants/theme.dart';
import 'package:noty_client/screens/core/index.dart';
import 'package:noty_client/widgets/textfield/TextFieldDark.dart';
import 'package:rounded_loading_button/rounded_loading_button.dart';

class LoginFragment extends StatefulWidget {
  const LoginFragment({Key? key}) : super(key: key);

  @override
  State<LoginFragment> createState() => _LoginFragmentState();
}

class _LoginFragmentState extends State<LoginFragment> {
  final RoundedLoadingButtonController _loginBtnController =
      RoundedLoadingButtonController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  // Just a mock function to simulating network activity delay
  void _loginCall() async {
    Timer(const Duration(milliseconds: 2500), () {
      _loginBtnController.success();
      _loginNavigate();
    });
  }

  void _loginNavigate() async {
    Timer(const Duration(milliseconds: 1500), () {
      Navigator.pushReplacement(
          context, MaterialPageRoute(builder: (context) => const CoreScreen()));
    });
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Image.asset(
          "assets/images/logo.png",
          width: 200,
        ),
        Container(
          width: double.infinity,
          height: 270,
          margin: const EdgeInsets.only(top: 50),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                "Login",
                style: TextStyle(fontSize: 22, fontWeight: FontWeight.w700),
              ),
              TextFieldDark(controller: _emailController, labelText: 'Email'),
              TextField(
                controller: _passwordController,
                obscureText: true,
                decoration: InputDecoration(
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    labelText: 'Password',
                    labelStyle:
                        TextStyle(color: ThemeConstant.textFieldTextColor),
                    filled: true,
                    fillColor: ThemeConstant.textFieldBgColor),
              ),
              Container(
                width: double.infinity,
                margin: const EdgeInsets.only(bottom: 12),
                child: Text(
                  "Forgot password?",
                  textAlign: TextAlign.end,
                  style: TextStyle(color: ThemeConstant.colorPrimaryLight),
                ),
              ),
              RoundedLoadingButton(
                child: const Text('Sign In',
                    style: TextStyle(color: Colors.white, fontSize: 16)),
                color: ThemeConstant.colorPrimaryLight,
                borderRadius: 10,
                controller: _loginBtnController,
                onPressed: _loginCall,
              ),
            ],
          ),
        )
      ],
    );
  }
}
