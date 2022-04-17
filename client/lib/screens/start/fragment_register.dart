import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:noty_client/constants/theme.dart';

class RegisterFragment extends StatefulWidget {
  const RegisterFragment({Key? key}) : super(key: key);

  @override
  State<RegisterFragment> createState() => _RegisterFragmentState();
}

class _RegisterFragmentState extends State<RegisterFragment> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text("Register"),
          backgroundColor: ThemeConstant.appBarColor,
          leadingWidth: 100,
          leading: GestureDetector(
            child: Padding(
              padding: const EdgeInsets.only(left: 15),
              child: Row(
                children: [
                  Icon(
                    Icons.arrow_back_ios,
                    color: ThemeConstant.colorPrimaryLight,
                  ),
                  Text(
                    "Back",
                    style: TextStyle(
                        fontSize: 16, color: ThemeConstant.colorPrimaryLight),
                  )
                ],
              ),
            ),
            onTap: () {
              Navigator.pop(context);
            },
          ),
        ),
        body: Container(
            width: double.infinity,
            padding: const EdgeInsets.fromLTRB(30, 0, 30, 0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: const [
                Text(
                  "Create an account",
                  style: TextStyle(fontSize: 24, fontWeight: FontWeight.w700),
                )
              ],
            )));
  }
}
