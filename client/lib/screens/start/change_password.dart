import 'package:flutter/material.dart';
import 'package:noty_client/constants/theme.dart';
import 'package:noty_client/widgets/leading_button.dart';

class ChangePassword extends StatefulWidget {
  const ChangePassword({Key? key}) : super(key: key);

  @override
  State<ChangePassword> createState() => _ChangePasswordState();
}

class _ChangePasswordState extends State<ChangePassword> {
  final _passwordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();

  @override
  void dispose() {
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const ChangePassword()));
                  }),
            )
          ],
        ),
      ),
    );
  }
}
