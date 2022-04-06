import 'dart:async';

import 'package:flutter/material.dart';
import 'package:noty_client/screens/core/index.dart';
import 'package:rounded_loading_button/rounded_loading_button.dart';

class LoginFragment extends StatefulWidget {
  const LoginFragment({Key? key}) : super(key: key);

  @override
  State<LoginFragment> createState() => _LoginFragmentState();
}

class _LoginFragmentState extends State<LoginFragment> {
  final RoundedLoadingButtonController _loginBtnController = RoundedLoadingButtonController();

  // Just a mock function to simulating network activity delay
  void _loginCall() async {
    Timer(const Duration(milliseconds: 2500), () {
      _loginBtnController.success();
      _loginNavigate();
    });
  }

  void _loginNavigate() async {
    Timer(const Duration(milliseconds: 1500), () {
      Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => const CoreScreen()));
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        RoundedLoadingButton(
          child: const Text('Login', style: TextStyle(color: Colors.white)),
          color: Colors.amber,
          controller: _loginBtnController,
          onPressed: _loginCall,
        ),
      ],
    );
  }
}
