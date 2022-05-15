import 'package:flutter/material.dart';
import 'package:noty_client/constants/theme.dart';
import 'package:noty_client/screens/start/pin_input.dart';
import 'package:noty_client/services/providers/providers.dart';
import 'package:noty_client/widgets/leading_button.dart';
import 'package:provider/provider.dart';

class ForgotPasswordScreen extends StatefulWidget {
  const ForgotPasswordScreen({Key? key}) : super(key: key);

  @override
  State<ForgotPasswordScreen> createState() => _ForgotPasswordScreenState();
}

class _ForgotPasswordScreenState extends State<ForgotPasswordScreen> {
  final _emailController = TextEditingController();

  @override
  void dispose() {
    _emailController.dispose();
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
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              children: [
                Container(
                  width: double.infinity,
                  margin: const EdgeInsets.only(bottom: 14),
                  child: const Text(
                    "Reset password",
                    style: TextStyle(
                      fontSize: 26,
                      fontWeight: FontWeight.bold,
                    ),
                    textAlign: TextAlign.start,
                  ),
                ),
                Container(
                  width: double.infinity,
                  margin: const EdgeInsets.only(bottom: 28),
                  padding: const EdgeInsets.only(right: 10),
                  child: const Text(
                    "Reset password using your email asscociated with your account",
                    textAlign: TextAlign.start,
                    style: TextStyle(
                      fontSize: 16,
                    ),
                  ),
                ),
                Container(
                  width: double.infinity,
                  margin: const EdgeInsets.only(bottom: 8),
                  padding: const EdgeInsets.only(left: 8),
                  child: const Text(
                    "Email",
                    textAlign: TextAlign.start,
                  ),
                ),
                TextField(
                  controller: _emailController,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    hintText: 'Email',
                    hintStyle:
                        TextStyle(color: ThemeConstant.textFieldTextColor),
                    filled: true,
                    fillColor: ThemeConstant.textFieldBgColor,
                    prefixIcon: Icon(
                      Icons.mail_rounded,
                      color: ThemeConstant.colorPrimaryLight,
                      size: 20,
                    ),
                  ),
                  keyboardAppearance: Brightness.dark,
                ),
              ],
            ),
            Container(
              margin: const EdgeInsets.only(top: 4),
              width: double.infinity,
              height: 50,
              child: ElevatedButton(
                  child: const Text("Send an email"),
                  onPressed: () {
                    context
                        .read<ProfileProvider>()
                        .setResetEmail(_emailController.text);
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const PinInputScreen()));
                  }),
            )
          ],
        ),
      ),
    );
  }
}
