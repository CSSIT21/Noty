import 'package:flutter/material.dart';
import 'package:noty_client/constants/theme.dart';
import 'package:noty_client/screens/core/index.dart';
import 'package:noty_client/widgets/textfield/TextFieldDark.dart';
import 'package:noty_client/widgets/typography/TitleText.dart';

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
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Register",
          style: TextStyle(fontSize: 17),
        ),
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
                      fontSize: 17, color: ThemeConstant.colorPrimaryLight),
                )
              ],
            ),
          ),
          onTap: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: SingleChildScrollView(
        child: Container(
          width: double.infinity,
          padding: const EdgeInsets.fromLTRB(30, 30, 30, 50),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                  margin: const EdgeInsets.only(bottom: 40),
                  child: const TitleText(
                    text: "Create an account",
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
                        controller: _lastNameController, labelText: 'Lastname'),
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
              Container(
                margin: const EdgeInsets.only(bottom: 45),
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
              SizedBox(
                child: Column(
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
                      width: 320,
                      height: 50,
                      child: ElevatedButton(
                          child: const Text("Sign Up"),
                          onPressed: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => const CoreScreen()));
                          }),
                    )
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
