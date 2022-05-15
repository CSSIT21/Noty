import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:noty_client/constants/theme.dart';
import 'package:noty_client/screens/start/change_password.dart';
import 'package:noty_client/services/providers/providers.dart';
import 'package:noty_client/types/widget/placement.dart';
import 'package:noty_client/widgets/leading_button.dart';
import 'package:noty_client/widgets/typography/header_text.dart';
import 'package:provider/provider.dart';
import 'package:pin_code_fields/pin_code_fields.dart';

class PinInputScreen extends StatefulWidget {
  const PinInputScreen({Key? key}) : super(key: key);

  @override
  State<PinInputScreen> createState() => _PinInputScreenState();
}

class _PinInputScreenState extends State<PinInputScreen> {
  final textController = TextEditingController();

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
      resizeToAvoidBottomInset: false,
      body: Container(
        padding: const EdgeInsets.fromLTRB(20, 40, 20, 50),
        width: double.infinity,
        height: double.infinity,
        child: Column(
          children: [
            Stack(
              alignment: AlignmentDirectional.center,
              children: [
                const Icon(
                  CupertinoIcons.envelope_open_fill,
                  size: 36,
                ),
                SizedBox(
                  width: 80,
                  height: 80,
                  child: DecoratedBox(
                    decoration: BoxDecoration(
                      color: const Color(0x336ABFF9),
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                ),
              ],
            ),
            Container(
              margin: const EdgeInsets.only(top: 30),
              child: Column(
                children: [
                  Container(
                    margin: const EdgeInsets.only(bottom: 10),
                    child: const HeaderText(
                      text: "Check your mail",
                      size: Size.large,
                    ),
                  ),
                  Text("Enter the code send to " +
                      context.watch<ProfileProvider>().email)
                ],
              ),
            ),
            Container(
              margin: const EdgeInsets.only(top: 40, bottom: 50),
              padding: const EdgeInsets.only(left: 10, right: 10),
              child: PinCodeTextField(
                length: 6,
                obscureText: false,
                animationType: AnimationType.fade,
                pinTheme: PinTheme(
                  shape: PinCodeFieldShape.underline,
                  fieldHeight: 60,
                  fieldWidth: 40,
                  inactiveColor: Colors.white,
                  selectedColor: ThemeConstant.colorPrimaryLight,
                  activeColor: ThemeConstant.textColorSecondary,
                ),
                showCursor: false,
                keyboardAppearance: Brightness.dark,
                animationDuration: const Duration(milliseconds: 100),
                controller: textController,
                onChanged: (_) {},
                appContext: context,
              ),
            ),
            Container(
              margin: const EdgeInsets.only(bottom: 30),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    margin: const EdgeInsets.only(right: 6),
                    child: const Text("Didn't recieve the code?"),
                  ),
                  Text(
                    "RESEND",
                    style: TextStyle(color: ThemeConstant.colorPrimaryLight),
                  ),
                ],
              ),
            ),
            Container(
              margin: const EdgeInsets.only(top: 4),
              width: double.infinity,
              height: 50,
              child: ElevatedButton(
                  child: const Text(
                    "Continue",
                    style: TextStyle(
                      fontSize: 16,
                    ),
                  ),
                  onPressed: () {
                    textController.clear();
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