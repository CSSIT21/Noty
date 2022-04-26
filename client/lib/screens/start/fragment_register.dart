import 'package:flutter/material.dart';
import 'package:noty_client/constants/theme.dart';
import 'package:noty_client/screens/core/index.dart';
import 'package:noty_client/types/widget/placement.dart';
import 'package:noty_client/widgets/leading_button.dart';
import 'package:noty_client/widgets/textfield/textfield.dart';
import 'package:noty_client/widgets/typography/appbar_text.dart';
import 'package:noty_client/widgets/typography/header_text.dart';

class RegisterFragment extends StatefulWidget {
  const RegisterFragment({Key? key}) : super(key: key);

  @override
  State<RegisterFragment> createState() => _RegisterFragmentState();
}

class _RegisterFragmentState extends State<RegisterFragment> {
  final _firstNameController = TextEditingController();
  final _lastNameController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();
  bool checked = false;

  @override
  Widget build(BuildContext context) {
    var screenPadding = MediaQuery.of(context).padding;
    double height = MediaQuery.of(context).size.height;
    double screenHeight = height - screenPadding.top - screenPadding.bottom;

    return Scaffold(
      appBar: AppBar(
        title: const AppBarText(text: "Register"),
        centerTitle: true,
        leadingWidth: 100,
        leading: const LeadingButton(
          text: "Back",
        ),
      ),
      body: SingleChildScrollView(
        child: ConstrainedBox(
          constraints: BoxConstraints.tightFor(
            height: screenHeight - 20,
          ),
          child: Container(
            width: double.infinity,
            height: double.infinity,
            padding: const EdgeInsets.fromLTRB(30, 30, 30, 50),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Column(
                  children: [
                    Container(
                        margin: const EdgeInsets.only(bottom: 40),
                        child: Text(
                          "Create an account",
                          style: TextStyle(
                              color: ThemeConstant.colorPrimaryLight,
                              fontSize: 24,
                              fontWeight: FontWeight.bold),
                        )),
                    Container(
                      margin: const EdgeInsets.only(bottom: 20),
                      height: 160,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const SizedBox(
                            width: double.infinity,
                            child: Text("Firstname-Lastname"),
                          ),
                          TextFieldDark(
                              controller: _firstNameController,
                              labelText: 'Firstname'),
                          TextFieldDark(
                              controller: _lastNameController,
                              labelText: 'Lastname'),
                        ],
                      ),
                    ),
                    Container(
                      margin: const EdgeInsets.only(bottom: 20),
                      height: 90,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const SizedBox(
                            width: double.infinity,
                            child: Text("Email"),
                          ),
                          TextFieldDark(
                              controller: _emailController, labelText: 'Email'),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 160,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const SizedBox(
                            width: double.infinity,
                            child: Text("Password"),
                          ),
                          TextField(
                            controller: _passwordController,
                            obscureText: true,
                            decoration: InputDecoration(
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                labelText: 'Password',
                                labelStyle: TextStyle(
                                    color: ThemeConstant.textFieldTextColor),
                                filled: true,
                                fillColor: ThemeConstant.textFieldBgColor),
                          ),
                          TextField(
                            controller: _confirmPasswordController,
                            obscureText: true,
                            decoration: InputDecoration(
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                labelText: 'Confirm Password',
                                labelStyle: TextStyle(
                                    color: ThemeConstant.textFieldTextColor),
                                filled: true,
                                fillColor: ThemeConstant.textFieldBgColor),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Checkbox(
                          value: checked,
                          onChanged: (value) {
                            setState(() {
                              checked = !checked;
                            });
                          },
                        ),
                        const Text("I agree to "),
                        Text(
                          "terms ",
                          style:
                              TextStyle(color: ThemeConstant.colorPrimaryLight),
                        ),
                        const Text("and "),
                        Text("conditions",
                            style: TextStyle(
                                color: ThemeConstant.colorPrimaryLight)),
                      ],
                    ),
                    SizedBox(
                      width: double.infinity,
                      height: 50,
                      child: ElevatedButton(
                          child: const Text("Sign Up"),
                          onPressed: () {
                            Navigator.pushReplacement(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => const CoreScreen()));
                          }),
                    )
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
