import 'dart:io';
import 'package:flutter/material.dart';
import 'package:noty_client/constants/environment.dart';
import 'package:noty_client/constants/theme.dart';
import 'package:noty_client/models/response/error/error_response.dart';
import 'package:noty_client/models/response/info_response.dart';
import 'package:noty_client/models/response/me/me_infomation.dart';
import 'package:noty_client/services/me.dart';
import 'package:noty_client/services/providers/providers.dart';
import 'package:noty_client/widgets/leading_button.dart';
import 'package:noty_client/widgets/typography/appbar_text.dart';
import 'package:provider/provider.dart';
import 'package:rounded_loading_button/rounded_loading_button.dart';
import 'package:image_picker/image_picker.dart';

class EditProfileScreen extends StatefulWidget {
  final String firstname;
  final String lastname;
  const EditProfileScreen(
      {Key? key, required this.firstname, required this.lastname})
      : super(key: key);

  @override
  State<EditProfileScreen> createState() => _EditProfileScreenState();
}

class _EditProfileScreenState extends State<EditProfileScreen> {
  final _passwordController = TextEditingController();
  final _newPasswordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();
  final RoundedLoadingButtonController _profileLoadingButton =
      RoundedLoadingButtonController();

  // ignore: avoid_init_to_null
  File? imagefile = null;
  String tempFirstname = '';
  String tempLastname = '';
  final ImagePicker _picker = ImagePicker();

  _getFromGallery() async {
    XFile? pickedFile = await _picker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      setState(() {
        imagefile = File(pickedFile.path);
      });
      await ProfileService.changeImage(imagefile!).then((_) {
        context.read<ProfileProvider>().readMeJson();
      });
    }
  }

  @override
  void initState() {
    tempFirstname = widget.firstname;
    tempLastname = widget.lastname;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    MeData meData = context.watch<ProfileProvider>().meData;
    var screenPadding = MediaQuery.of(context).padding;
    double height = MediaQuery.of(context).size.height;
    double screenHeight = height - screenPadding.top - screenPadding.bottom;

    void updateProfile() async {
      if (tempFirstname.isNotEmpty &&
          tempLastname.isNotEmpty &&
          _passwordController.text.isEmpty &&
          _newPasswordController.text.isEmpty &&
          _confirmPasswordController.text.isEmpty) {
        context.read<ProfileProvider>().setFirstname(tempFirstname);
        context.read<ProfileProvider>().setLastname(tempLastname);
        var updateProfile =
            await ProfileService.updateProfile(tempFirstname, tempLastname);
        if (updateProfile is ErrorResponse) {
          _profileLoadingButton.reset();
          var profileErrorSnackBar = SnackBar(
            content: Text(updateProfile.message),
            behavior: SnackBarBehavior.floating,
            margin: EdgeInsets.only(
                bottom: screenHeight - 120, left: 15, right: 15),
            action: SnackBarAction(
              label: 'OK',
              onPressed: () {},
            ),
          );
          ScaffoldMessenger.of(context).showSnackBar(profileErrorSnackBar);
        } else if (updateProfile is InfoResponse) {
          _profileLoadingButton.success();
          Navigator.pop(context);
        }
      } else if (tempFirstname.isNotEmpty &&
          tempLastname.isNotEmpty &&
          _passwordController.text != _newPasswordController.text &&
          _newPasswordController.text == _confirmPasswordController.text &&
          _newPasswordController.text.length >= 8) {
        context.read<ProfileProvider>().setFirstname(tempFirstname);
        context.read<ProfileProvider>().setLastname(tempLastname);
        var updateProfile =
            await ProfileService.updateProfile(tempFirstname, tempLastname);
        var updatePassword = await ProfileService.updatePassword(
            _newPasswordController.text, _passwordController.text);
        if (updateProfile is ErrorResponse) {
          _profileLoadingButton.reset();
          var profileErrorSnackBar = SnackBar(
            content: Text(updateProfile.message),
            behavior: SnackBarBehavior.floating,
            margin: EdgeInsets.only(
                bottom: screenHeight - 120, left: 15, right: 15),
            action: SnackBarAction(
              label: 'OK',
              onPressed: () {},
            ),
          );
          ScaffoldMessenger.of(context).showSnackBar(profileErrorSnackBar);
        } else if (updatePassword is ErrorResponse) {
          _profileLoadingButton.reset();
          var passwordErrorSnackBar = SnackBar(
            content: Text(updatePassword.message),
            behavior: SnackBarBehavior.floating,
            margin: EdgeInsets.only(
                bottom: screenHeight - 120, left: 15, right: 15),
            action: SnackBarAction(
              label: 'OK',
              onPressed: () {},
            ),
          );
          ScaffoldMessenger.of(context).showSnackBar(passwordErrorSnackBar);
        } else if (updateProfile is InfoResponse &&
            updatePassword is InfoResponse) {
          _profileLoadingButton.success();
          Navigator.pop(context);
        }
      } else {
        _profileLoadingButton.reset();
        var error = SnackBar(
          behavior: SnackBarBehavior.floating,
          margin:
              EdgeInsets.only(bottom: screenHeight - 120, left: 15, right: 15),
          content: const Text("Error. Please check your password"),
          action: SnackBarAction(
            label: 'OK',
            onPressed: () {},
          ),
        );
        ScaffoldMessenger.of(context).showSnackBar(error);
      }
    }

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
                        margin: const EdgeInsets.only(bottom: 20),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(120),
                          child: SizedBox(
                            height: 125,
                            width: 125,
                            child: Stack(
                              children: [
                                imagefile == null
                                    ? Image.network(
                                        EnvironmentConstant.internalPrefix +
                                            Provider.of<ProfileProvider>(
                                                    context,
                                                    listen: false)
                                                .meData
                                                .avatarUrl,
                                        errorBuilder:
                                            (context, error, stackTrace) =>
                                                Image.asset(
                                          "assets/images/profile-placeholder.png",
                                          width: 125,
                                          fit: BoxFit.cover,
                                          alignment: Alignment.center,
                                        ),
                                        width: 125,
                                        height: 125,
                                        fit: BoxFit.cover,
                                        alignment: Alignment.center,
                                      )
                                    : Image.file(
                                        imagefile!,
                                        width: 125,
                                        height: 125,
                                        fit: BoxFit.cover,
                                        alignment: Alignment.center,
                                      ),
                                Align(
                                  alignment: Alignment.bottomCenter,
                                  child: Container(
                                    height: 150 * 0.25,
                                    width: double.infinity,
                                    color: Colors.black.withOpacity(0.5),
                                    child: const Center(
                                      child: Text(
                                        "Edit",
                                        style: TextStyle(
                                            color: Colors.white,
                                            fontSize: 12,
                                            fontWeight: FontWeight.w500),
                                      ),
                                    ),
                                  ),
                                ),
                                Positioned.fill(
                                  child: Material(
                                    color: Colors.transparent,
                                    child: InkWell(
                                      splashColor: ThemeConstant
                                          .colorPrimaryLight
                                          .withOpacity(0.5),
                                      onTap: () {
                                        _getFromGallery();
                                      },
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
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
                            TextFormField(
                              initialValue: meData.firstname,
                              keyboardAppearance: Brightness.dark,
                              decoration: InputDecoration(
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                hintText: "Firstname",
                                hintStyle: TextStyle(
                                  color: ThemeConstant.textFieldTextColor,
                                ),
                                filled: true,
                                fillColor: ThemeConstant.textFieldBgColor,
                              ),
                              onChanged: (text) => setState(() {
                                tempFirstname = text;
                              }),
                            ),
                            TextFormField(
                              initialValue: meData.lastname,
                              keyboardAppearance: Brightness.dark,
                              decoration: InputDecoration(
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                hintText: "Lastname",
                                hintStyle: TextStyle(
                                    color: ThemeConstant.textFieldTextColor),
                                filled: true,
                                fillColor: ThemeConstant.textFieldBgColor,
                              ),
                              onChanged: (text) => setState(() {
                                tempLastname = text;
                              }),
                            ),
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
                              keyboardAppearance: Brightness.dark,
                              obscureText: true,
                              decoration: InputDecoration(
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                  hintText: 'Current Password',
                                  hintStyle: TextStyle(
                                      color: ThemeConstant.textFieldTextColor),
                                  filled: true,
                                  fillColor: ThemeConstant.textFieldBgColor),
                            ),
                            TextField(
                              controller: _newPasswordController,
                              keyboardAppearance: Brightness.dark,
                              obscureText: true,
                              decoration: InputDecoration(
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                  hintText: 'New Password',
                                  hintStyle: TextStyle(
                                      color: ThemeConstant.textFieldTextColor),
                                  filled: true,
                                  fillColor: ThemeConstant.textFieldBgColor),
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
                                  hintStyle: TextStyle(
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
                    child: RoundedLoadingButton(
                      child: const Text(
                        'Save',
                        style: TextStyle(fontSize: 16, color: Colors.white),
                      ),
                      color: ThemeConstant.colorPrimaryLight,
                      borderRadius: 10,
                      controller: _profileLoadingButton,
                      onPressed: updateProfile,
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
