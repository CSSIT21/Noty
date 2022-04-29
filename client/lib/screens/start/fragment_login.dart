import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:noty_client/constants/theme.dart';
import 'package:noty_client/models/response/error/error_response.dart';
import 'package:noty_client/screens/core/index.dart';
import 'package:noty_client/services/account.dart';
import 'package:rounded_loading_button/rounded_loading_button.dart';
import 'package:shared_preferences/shared_preferences.dart';

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
  String errorText = '';
  late SharedPreferences prefs;

  getSharedPreferences() async {
    prefs = await SharedPreferences.getInstance();
    String? userData = prefs.getString('user');
  }

  // Just a mock function to simulating network activity delay
  void _loginCall() async {
    if (_emailController.value.text.isEmpty ||
        _passwordController.value.text.isEmpty) {
      setState(() {
        errorText = 'Email or password is empty';
      });
    }
    var login = await AccountService.login(
        _emailController.text, _passwordController.text);
    if (login is ErrorResponse) {
      setState(() {
        errorText = login.message;
      });
      _loginBtnController.reset();
    } else {
      _loginBtnController.success();
      _loginNavigate();
    }
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
  void initState() {
    getSharedPreferences();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async => false,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Image.asset(
            "assets/images/logo.png",
            width: 200,
          ),
          Container(
            width: double.infinity,
            margin: const EdgeInsets.only(top: 50),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  margin: const EdgeInsets.only(bottom: 14),
                  child: const Text(
                    "Login",
                    style: TextStyle(fontSize: 22, fontWeight: FontWeight.w700),
                  ),
                ),
                ValueListenableBuilder(
                    valueListenable: _passwordController,
                    builder: (context, TextEditingValue value, __) {
                      return Column(
                        children: [
                          Container(
                            margin: const EdgeInsets.only(bottom: 12),
                            child: TextField(
                              controller: _emailController,
                              decoration: InputDecoration(
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                hintText: 'Email',
                                hintStyle: TextStyle(
                                    color: ThemeConstant.textFieldTextColor),
                                filled: true,
                                fillColor: ThemeConstant.textFieldBgColor,
                                prefixIcon: Icon(
                                  Icons.mail_rounded,
                                  color: ThemeConstant.colorPrimaryLight,
                                  size: 20,
                                ),
                              ),
                              onChanged: (_) => setState(() {
                                errorText = '';
                              }),
                            ),
                          ),
                          TextField(
                            controller: _passwordController,
                            obscureText: true,
                            decoration: InputDecoration(
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10),
                              ),
                              hintText: 'Password',
                              hintStyle: TextStyle(
                                  color: ThemeConstant.textFieldTextColor),
                              filled: true,
                              fillColor: ThemeConstant.textFieldBgColor,
                              prefixIcon: Icon(
                                CupertinoIcons.lock_fill,
                                color: ThemeConstant.colorPrimaryLight,
                                size: 20,
                              ),
                            ),
                            onChanged: (_) => setState(() {
                              errorText = '';
                            }),
                          ),
                          errorText.isNotEmpty
                              ? Container(
                                  margin: const EdgeInsets.only(top: 10),
                                  child: Text(
                                    errorText,
                                    style: const TextStyle(color: Colors.red),
                                  ),
                                )
                              : Container(),
                          Container(
                            width: double.infinity,
                            margin: const EdgeInsets.only(bottom: 12, top: 10),
                            child: Text(
                              "Forgot password?",
                              textAlign: TextAlign.end,
                              style: TextStyle(
                                  color: ThemeConstant.colorPrimaryLight),
                            ),
                          ),
                          RoundedLoadingButton(
                            child: Text(
                              'Sign In',
                              style: TextStyle(
                                fontSize: 16,
                                color: _passwordController
                                            .value.text.isNotEmpty &&
                                        _emailController.value.text.isNotEmpty
                                    ? Colors.white
                                    : Colors.grey[600],
                              ),
                            ),
                            color: ThemeConstant.colorPrimaryLight,
                            borderRadius: 10,
                            controller: _loginBtnController,
                            onPressed:
                                _passwordController.value.text.isNotEmpty &&
                                        _emailController.value.text.isNotEmpty
                                    ? _loginCall
                                    : null,
                            disabledColor: ThemeConstant.textColorSecondary,
                          ),
                        ],
                      );
                    }),
              ],
            ),
          )
        ],
      ),
    );
  }
}
