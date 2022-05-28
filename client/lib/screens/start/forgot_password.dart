import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';
import 'package:noty_client/constants/theme.dart';
import 'package:noty_client/models/response/info_response.dart';
import 'package:noty_client/screens/start/pin_input.dart';
import 'package:noty_client/services/account.dart';
import 'package:noty_client/services/providers/providers.dart';
import 'package:noty_client/widgets/leading_button.dart';
import 'package:provider/provider.dart';
import 'package:rounded_loading_button/rounded_loading_button.dart';

class ForgotPasswordScreen extends StatefulWidget {
  const ForgotPasswordScreen({Key? key}) : super(key: key);

  @override
  State<ForgotPasswordScreen> createState() => _ForgotPasswordScreenState();
}

class _ForgotPasswordScreenState extends State<ForgotPasswordScreen> {
  final _emailController = TextEditingController();
  final RoundedLoadingButtonController _loadingButtonController =
      RoundedLoadingButtonController();
  String errorText = '';

  void _sendEmailRequest() async {
    context.read<ProfileProvider>().setResetEmail(_emailController.text);
    if (_emailController.text.isNotEmpty &&
        EmailValidator.validate(_emailController.text)) {
      var reset =
          await AccountService.resetPasswordEmail(_emailController.text);
      if (reset is InfoResponse) {
        _loadingButtonController.success();
        Navigator.push(context,
            MaterialPageRoute(builder: (context) => const PinInputScreen()));
        _loadingButtonController.reset();
        _emailController.clear();
      } else {
        setState(() {
          errorText = 'Information validation failed';
        });
        _loadingButtonController.reset();
      }
    } else if (_emailController.text.isEmpty) {
      setState(() {
        errorText = 'Email is required';
      });
      _loadingButtonController.reset();
    } else if (!EmailValidator.validate(_emailController.text)) {
      setState(() {
        errorText = 'Email is invalid';
      });
      _loadingButtonController.reset();
    } else {
      setState(() {
        errorText = "I don't know";
      });
      _loadingButtonController.reset();
    }
  }

  @override
  void dispose() {
    _emailController.dispose();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
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
                    keyboardType: TextInputType.emailAddress,
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
                    onChanged: (_) {
                      setState(() {
                        errorText = '';
                      });
                    },
                  ),
                  Container(
                    width: double.infinity,
                    margin: const EdgeInsets.only(top: 10),
                    child: Text(
                      errorText,
                      style: const TextStyle(color: Colors.red),
                      textAlign: TextAlign.end,
                    ),
                  )
                ],
              ),
              RoundedLoadingButton(
                child: const Text(
                  'Send an email',
                ),
                color: ThemeConstant.colorPrimaryLight,
                borderRadius: 10,
                controller: _loadingButtonController,
                onPressed: _emailController.value.text.isNotEmpty
                    ? _sendEmailRequest
                    : null,
                disabledColor: ThemeConstant.textColorSecondary,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
