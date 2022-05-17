import 'package:flutter/material.dart';
import 'package:noty_client/constants/theme.dart';
import 'package:noty_client/models/response/info_response.dart';
import 'package:noty_client/screens/start/login.dart';
import 'package:noty_client/services/account.dart';
import 'package:noty_client/services/providers/providers.dart';
import 'package:noty_client/widgets/leading_button.dart';
import 'package:provider/provider.dart';

class ChangePassword extends StatefulWidget {
  const ChangePassword({Key? key}) : super(key: key);

  @override
  State<ChangePassword> createState() => _ChangePasswordState();
}

class _ChangePasswordState extends State<ChangePassword> {
  final _passwordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();
  String errorText = '';

  void showAlertDialog(BuildContext context, String message) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Success!'),
        backgroundColor: ThemeConstant.colorSecondaryDark,
        content: Text(message),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.pushReplacement(context,
                  MaterialPageRoute(builder: (context) => const LoginScreen()));
            },
            child: Text(
              'OK',
              style: TextStyle(color: ThemeConstant.colorPrimaryLight),
              textAlign: TextAlign.center,
            ),
          ),
        ],
      ),
    );
  }

  void resetPassword() async {
    if (_passwordController.text == _confirmPasswordController.text &&
        _passwordController.text.isNotEmpty &&
        _confirmPasswordController.text.isNotEmpty) {
      var response = await AccountService.resetPassword(
          Provider.of<ProfileProvider>(context, listen: false).email,
          _confirmPasswordController.text);
      if (response is InfoResponse) {
        showAlertDialog(context,
            "Your password has been reset! You can now login to the app.");
      } else {
        var error = SnackBar(
          behavior: SnackBarBehavior.floating,
          margin: const EdgeInsets.only(bottom: 20, left: 15, right: 15),
          content: const Text('Password must be at least 8 characters long'),
          action: SnackBarAction(
            label: 'OK',
            onPressed: () {},
          ),
        );
        ScaffoldMessenger.of(context).showSnackBar(error);
      }
    } else if (_passwordController.text.isEmpty ||
        _confirmPasswordController.text.isEmpty) {
      var error = SnackBar(
        behavior: SnackBarBehavior.floating,
        margin: const EdgeInsets.only(bottom: 20, left: 15, right: 15),
        content: const Text('Password is required'),
        action: SnackBarAction(
          label: 'OK',
          onPressed: () {},
        ),
      );
      ScaffoldMessenger.of(context).showSnackBar(error);
    } else if (_passwordController.text != _confirmPasswordController.text) {
      var error = SnackBar(
        behavior: SnackBarBehavior.floating,
        margin: const EdgeInsets.only(bottom: 20, left: 15, right: 15),
        content: const Text('Password mismatch'),
        action: SnackBarAction(
          label: 'OK',
          onPressed: () {},
        ),
      );
      ScaffoldMessenger.of(context).showSnackBar(error);
    } else {
      var error = SnackBar(
        behavior: SnackBarBehavior.floating,
        margin: const EdgeInsets.only(bottom: 20, left: 15, right: 15),
        content: const Text('Password must be at least 8 characters long'),
        action: SnackBarAction(
          label: 'OK',
          onPressed: () {},
        ),
      );
      ScaffoldMessenger.of(context).showSnackBar(error);
    }
  }

  @override
  void dispose() {
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusScopeNode currentFocus = FocusScope.of(context);
        if (!currentFocus.hasPrimaryFocus &&
            currentFocus.focusedChild != null) {
          FocusManager.instance.primaryFocus!.unfocus();
        }
      },
      behavior: HitTestBehavior.translucent,
      child: Scaffold(
        appBar: AppBar(
          centerTitle: true,
          automaticallyImplyLeading: false,
          leadingWidth: 100,
          leading: const LeadingButton(
            text: "Back",
          ),
          backgroundColor: ThemeConstant.colorPrimaryDark,
          elevation: 0,
        ),
        body: Container(
          padding: const EdgeInsets.fromLTRB(20, 10, 20, 50),
          child: Column(
            // mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                children: [
                  Container(
                    margin: const EdgeInsets.only(bottom: 32),
                    child: const Text(
                      "Create your new password",
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),
                  Container(
                    width: double.infinity,
                    margin: const EdgeInsets.only(bottom: 8),
                    padding: const EdgeInsets.only(left: 8),
                    child: const Text(
                      "New Password",
                      textAlign: TextAlign.start,
                    ),
                  ),
                  Container(
                    margin: const EdgeInsets.only(bottom: 10),
                    child: TextField(
                      controller: _passwordController,
                      keyboardAppearance: Brightness.dark,
                      obscureText: true,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                        hintText: 'New Password',
                        hintStyle:
                            TextStyle(color: ThemeConstant.textFieldTextColor),
                        filled: true,
                        fillColor: ThemeConstant.textFieldBgColor,
                      ),
                    ),
                  ),
                  TextField(
                    controller: _confirmPasswordController,
                    keyboardAppearance: Brightness.dark,
                    obscureText: true,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      hintText: 'Confirm Password',
                      hintStyle:
                          TextStyle(color: ThemeConstant.textFieldTextColor),
                      filled: true,
                      fillColor: ThemeConstant.textFieldBgColor,
                    ),
                  ),
                ],
              ),
              Container(
                margin: const EdgeInsets.only(top: 20),
                width: double.infinity,
                height: 50,
                child: ElevatedButton(
                    child: const Text("Save"),
                    onPressed: () {
                      resetPassword();
                    }),
              )
            ],
          ),
        ),
      ),
    );
  }
}
