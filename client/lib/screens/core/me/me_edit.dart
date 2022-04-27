import 'package:flutter/material.dart';
import 'package:noty_client/constants/theme.dart';
import 'package:noty_client/widgets/leading_button.dart';
import 'package:noty_client/widgets/textfield/textfield.dart';
import 'package:noty_client/widgets/typography/appbar_text.dart';

class EditProfileScreen extends StatefulWidget {
  const EditProfileScreen({Key? key}) : super(key: key);

  @override
  State<EditProfileScreen> createState() => _EditProfileScreenState();
}

class _EditProfileScreenState extends State<EditProfileScreen> {
  final _firstNameController = TextEditingController();
  final _lastNameController = TextEditingController();
  final _passwordController = TextEditingController();
  final _newPasswordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    var screenPadding = MediaQuery.of(context).padding;
    double height = MediaQuery.of(context).size.height;
    double screenHeight = height - screenPadding.top - screenPadding.bottom;
    return Scaffold(
      appBar: AppBar(
        title: const SizedBox(
          width: 120,
          child: AppBarText(text: "Edit Profile"),
        ),
        centerTitle: true,
        leadingWidth: 100,
        leading: const LeadingButton(
          text: "Back",
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.fromLTRB(20, 20, 20, 50),
        child: ConstrainedBox(
          constraints: BoxConstraints.tightFor(
            height: screenHeight - 80,
          ),
          child: SizedBox(
            width: double.infinity,
            height: double.infinity,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Column(
                  children: [
                    Container(
                      margin: const EdgeInsets.only(bottom: 16),
                      child: Image.asset(
                        "assets/images/profile.png",
                        width: 150,
                      ),
                    ),
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
                    SizedBox(
                      height: 220,
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
                                labelText: 'Current Password',
                                labelStyle: TextStyle(
                                    color: ThemeConstant.textFieldTextColor),
                                filled: true,
                                fillColor: ThemeConstant.textFieldBgColor),
                          ),
                          TextField(
                            controller: _newPasswordController,
                            obscureText: true,
                            decoration: InputDecoration(
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                labelText: 'New Password',
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
                SizedBox(
                  width: double.infinity,
                  height: 50,
                  child: ElevatedButton(
                      child: const Text("Save"),
                      onPressed: () {
                        // Navigator.pushReplacement(
                        //     context,
                        //     MaterialPageRoute(
                        //         builder: (context) => const LoginScreen()));
                        Navigator.pop(context);
                      }),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
