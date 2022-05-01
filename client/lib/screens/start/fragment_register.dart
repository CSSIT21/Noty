import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';
import 'package:noty_client/constants/theme.dart';
import 'package:noty_client/models/response/error/error_response.dart';
import 'package:noty_client/screens/core/index.dart';
import 'package:noty_client/screens/start/show_alert_dialog.dart';
import 'package:noty_client/services/account.dart';
import 'package:noty_client/widgets/leading_button.dart';
import 'package:noty_client/widgets/typography/appbar_text.dart';
import 'package:rounded_loading_button/rounded_loading_button.dart';

class RegisterFragment extends StatefulWidget {
  const RegisterFragment({Key? key}) : super(key: key);

  @override
  State<RegisterFragment> createState() => _RegisterFragmentState();
}

class _RegisterFragmentState extends State<RegisterFragment> {
  final _formKey = GlobalKey<FormState>();
  final RoundedLoadingButtonController _registerBtnController =
      RoundedLoadingButtonController();
  bool checked = false;
  String? firstname;
  String? lastname;
  String? email;
  String? password;
  String? confirmPassword;
  bool isSubmit = false;

  void _registerCall() async {
    // _loginNavigate();
    if (password != confirmPassword) {
      showAlertDialog(context, "Password does not match");
    } else if (!checked) {
      showAlertDialog(context, "Please agree to terms and conditions");
    } else {
      var register = await AccountService.register(
          firstname!, lastname!, email!, password!);
      if (register is ErrorResponse) {
        showAlertDialog(context, register.message);
        _registerBtnController.reset();
      } else {
        _registerBtnController.success();
        _loginNavigate();
      }
    }
  }

  void _loginNavigate() {
    Navigator.pushReplacement(
        context, MaterialPageRoute(builder: (context) => const CoreScreen()));
  }

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
            height: isSubmit ? screenHeight + 50 : screenHeight,
          ),
          child: Container(
            width: double.infinity,
            height: double.infinity,
            padding: const EdgeInsets.fromLTRB(30, 30, 30, 50),
            child: Form(
              key: _formKey,
              autovalidateMode: isSubmit
                  ? AutovalidateMode.onUserInteraction
                  : AutovalidateMode.disabled,
              child: Column(
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
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Container(
                              margin: const EdgeInsets.only(bottom: 6),
                              width: double.infinity,
                              child: const Text("Firstname-Lastname"),
                            ),
                            Container(
                              margin: const EdgeInsets.only(bottom: 8),
                              child: TextFormField(
                                onSaved: (value) {
                                  firstname = value;
                                },
                                decoration: InputDecoration(
                                    hintText: "Firstname",
                                    hintStyle: TextStyle(
                                        color:
                                            ThemeConstant.textFieldTextColor),
                                    border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(10),
                                    ),
                                    filled: true,
                                    fillColor: ThemeConstant.textFieldBgColor),
                                validator: (value) {
                                  if (value!.isEmpty) {
                                    return 'This field cannot be empty';
                                  }
                                  return null;
                                },
                                onChanged: (_) => setState(() {}),
                              ),
                            ),
                            TextFormField(
                              onSaved: (value) {
                                lastname = value;
                              },
                              decoration: InputDecoration(
                                  hintText: "Lastname",
                                  hintStyle: TextStyle(
                                      color: ThemeConstant.textFieldTextColor),
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                  filled: true,
                                  fillColor: ThemeConstant.textFieldBgColor),
                              validator: (value) {
                                if (value!.isEmpty) {
                                  return 'This field cannot be empty';
                                }
                                return null;
                              },
                            ),
                          ],
                        ),
                      ),
                      Container(
                        margin: const EdgeInsets.only(bottom: 20),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Container(
                              margin: const EdgeInsets.only(bottom: 6),
                              width: double.infinity,
                              child: const Text("Email"),
                            ),
                            TextFormField(
                              onSaved: (value) {
                                email = value;
                              },
                              decoration: InputDecoration(
                                  hintText: "Email",
                                  hintStyle: TextStyle(
                                      color: ThemeConstant.textFieldTextColor),
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                  filled: true,
                                  fillColor: ThemeConstant.textFieldBgColor),
                              validator: (value) {
                                if (value!.isEmpty) {
                                  return 'This field cannot be empty';
                                }
                                if (!EmailValidator.validate(value)) {
                                  return 'Email is invalid';
                                }
                                return null;
                              },
                            ),
                          ],
                        ),
                      ),
                      SizedBox(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Container(
                              margin: const EdgeInsets.only(bottom: 6),
                              width: double.infinity,
                              child: const Text("Password"),
                            ),
                            Container(
                              margin: const EdgeInsets.only(bottom: 8),
                              child: TextFormField(
                                onSaved: (value) {
                                  password = value;
                                },
                                // onChanged: (value) =>
                                //     setState(() => password = value),
                                obscureText: true,
                                autovalidateMode: isSubmit
                                    ? AutovalidateMode.onUserInteraction
                                    : AutovalidateMode.disabled,
                                decoration: InputDecoration(
                                    hintText: "Password",
                                    hintStyle: TextStyle(
                                        color:
                                            ThemeConstant.textFieldTextColor),
                                    border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(10),
                                    ),
                                    filled: true,
                                    fillColor: ThemeConstant.textFieldBgColor),
                                validator: (value) {
                                  if (value!.isEmpty) {
                                    return 'This field cannot be empty';
                                  }
                                  if (value.length < 8) {
                                    return 'Password must be at least 8 characters long';
                                  }
                                  return null;
                                },
                              ),
                            ),
                            TextFormField(
                              onSaved: (value) {
                                confirmPassword = value;
                              },
                              autovalidateMode: isSubmit
                                  ? AutovalidateMode.onUserInteraction
                                  : AutovalidateMode.disabled,
                              obscureText: true,
                              decoration: InputDecoration(
                                  hintText: "Confirm Password",
                                  hintStyle: TextStyle(
                                      color: ThemeConstant.textFieldTextColor),
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                  filled: true,
                                  fillColor: ThemeConstant.textFieldBgColor),
                              validator: (value) {
                                if (value!.isEmpty) {
                                  return 'This field cannot be empty';
                                }
                                return null;
                              },
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  Container(
                    margin: const EdgeInsets.only(top: 7),
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
                              style: TextStyle(
                                  color: ThemeConstant.colorPrimaryLight),
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
                          child: RoundedLoadingButton(
                            child: const Text(
                              'Sign Up',
                              style:
                                  TextStyle(fontSize: 16, color: Colors.white),
                            ),
                            color: ThemeConstant.colorPrimaryLight,
                            borderRadius: 10,
                            controller: _registerBtnController,
                            onPressed: () {
                              setState(() {
                                isSubmit = true;
                              });
                              if (_formKey.currentState!.validate()) {
                                _formKey.currentState!.save();
                                isSubmit = false;
                                _registerCall();
                              }
                              _registerBtnController.reset();
                            },
                          ),
                        )
                      ],
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
