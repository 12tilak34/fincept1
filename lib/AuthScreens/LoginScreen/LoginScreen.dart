// ignore_for_file: avoid_function_literals_in_foreach_calls

import 'package:amplify_flutter/amplify_flutter.dart';
import 'package:fincept1/AuthScreens/LoginScreen/custom_button.dart';
import 'package:fincept1/AuthScreens/LoginScreen/custom_textformfield.dart';
import 'package:fincept1/AuthScreens/LoginScreen/otp_auth_login.dart';
import 'package:fincept1/AuthScreens/LoginScreen/otp_auth_screen.dart';
import 'package:fincept1/AuthScreens/LoginScreen/password_recovery_screen.dart';
import 'package:fincept1/AuthScreens/SignUpScreen/SignUpScreen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import '../../config/textstyle.dart';

class LoginScreen extends StatefulWidget {
  final Function showResult;
  final Function changeDisplay;
  final VoidCallback showCreateUser;
  final VoidCallback signOut;
  final VoidCallback fetchSession;
  final VoidCallback getCurrentUser;
  final Function setError;

  LoginScreen(this.showResult, this.changeDisplay, this.showCreateUser,
      this.signOut, this.fetchSession, this.getCurrentUser, this.setError);

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {

  final usernameController = TextEditingController();
  final passwordController = TextEditingController();
  AuthProvider provider = AuthProvider.amazon;

  void _signIn() async {
    try {
      var res = await Amplify.Auth.signIn(
          username: usernameController.text,
          password: passwordController.text);
      widget.showResult(
          'Sign In Status = ' + (res.nextStep?.signInStep ?? 'null'));
      if (res.nextStep?.signInStep == 'CONFIRM_SIGN_IN_WITH_SMS_MFA_CODE') {
        Navigator.push(context, MaterialPageRoute(builder: (context)=> OtpVerificationScreen2()));
      }
      if (res.nextStep?.signInStep == 'DONE') {

      }
    } on AmplifyException catch (e) {
      widget.setError(e);
    }
  }

  void _resetPassword() async {
    try {
      var res = await Amplify.Auth.resetPassword(
        username: usernameController.text.trim(),
      );
      widget.showResult('Reset Password Status = ' + res.nextStep.updateStep);
      widget.changeDisplay('SHOW_CONFIRM_RESET');
    } on AmplifyException catch (e) {
      widget.setError(e);
      print(e);
    }
  }



  @override
  void initState() {
    super.initState();
  }

  AmplifyException? _error;
  String authState = 'User not signed in';
  String displayState = '';
  void _backToSignIn() async {
    changeDisplay('SHOW_SIGN_IN');
  }

  void showResult(_authState) async {
    setState(() {
      _error = null;
      authState = _authState;
    });
    print(authState);
  }

  void changeDisplay(_displayState) async {
    setState(() {
      _error = null;
      displayState = _displayState;
    });
    print(displayState);
  }

  void setError(AmplifyException e) async {
    setState(() {
      _error = e;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: WillPopScope(
        onWillPop: () async {
          SystemNavigator.pop();
          return false;
        },
        child: InkWell(
          focusColor: Colors.transparent,
          highlightColor: Colors.transparent,
          hoverColor: Colors.transparent,
          splashColor: Colors.transparent,
          onTap: () {
            FocusScope.of(context).requestFocus(FocusNode());
          },
          child: Container(
            color: AppTheme.isLightTheme == false
                ? const Color(0xff15141F)
                : const Color(0xffFFFFFF),
            child: Padding(
              padding: EdgeInsets.only(
                left: 20,
                right: 20,
                top: AppBar().preferredSize.height,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // const Icon(Icons.arrow_back),
                  const SizedBox(
                    height: 38,
                  ),
                  Text(
                    "Hi Welcome Back!",
                    style: Theme.of(context).textTheme.headline6!.copyWith(
                      fontWeight: FontWeight.w700,
                      fontSize: 24,
                    ),
                  ),
                  const SizedBox(
                    height: 4,
                  ),
                  Text(
                    "Sign in to your account",
                    style: Theme.of(context).textTheme.bodyText2!.copyWith(
                      fontWeight: FontWeight.w500,
                      fontSize: 16,
                      color: const Color(0xffA2A0A8),
                    ),
                  ),

                  Expanded(
                    child: ListView(
                      physics: const ClampingScrollPhysics(),
                      shrinkWrap: true,
                      children: [
                        Column(
                          children: [
                            const SizedBox(height: 30),
                            CustomTextFormField(
                                prefix: const Padding(
                                  padding: EdgeInsets.all(14.0),
                                  child: Icon(Icons.phone)
                                ),
                                hintText: "Phone Number",
                                inputType: TextInputType.text,
                                textEditingController: usernameController,
                                capitalization: TextCapitalization.none,
                              ),
                            const SizedBox(height: 24),
                            CustomTextFormField(
                                prefix: const Padding(
                                  padding: EdgeInsets.all(14.0),
                                  child: Icon(Icons.password)
                                ),
                                hintText: "Password",
                                textEditingController:passwordController,
                                capitalization: TextCapitalization.none,
                                limit: [
                                  FilteringTextInputFormatter
                                      .singleLineFormatter,
                                ],
                                inputType: TextInputType.visiblePassword,
                              ),
                            const SizedBox(height: 16),
                            InkWell(
                              focusColor: Colors.transparent,
                              highlightColor: Colors.transparent,
                              hoverColor: Colors.transparent,
                              splashColor: Colors.transparent,
                              onTap: () {
                                Get.to(
                                  const PasswordRecoveryScreen(),
                                  transition: Transition.rightToLeft,
                                  duration: const Duration(milliseconds: 500),
                                );
                              },
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: [
                                  Text(
                                    "Forgot your password?",
                                    style: Theme.of(context)
                                        .textTheme
                                        .bodyText2!
                                        .copyWith(
                                      fontWeight: FontWeight.w600,
                                      fontSize: 16,
                                      color: HexColor(
                                          AppTheme.primaryColorString!),
                                    ),
                                  )
                                ],
                              ),
                            ),
                            const SizedBox(height: 32),
                            InkWell(
                              focusColor: Colors.transparent,
                              highlightColor: Colors.transparent,
                              hoverColor: Colors.transparent,
                              splashColor: Colors.transparent,
                              onTap: _signIn,
                              child: customButton(
                                  HexColor(AppTheme.primaryColorString!),
                                  "Login",
                                  HexColor(AppTheme.secondaryColorString!),
                                  context),
                            ),
                            InkWell(
                              focusColor: Colors.transparent,
                              highlightColor: Colors.transparent,
                              hoverColor: Colors.transparent,
                              splashColor: Colors.transparent,
                              onTap: () {
                                Get.to(
                                   SignUpScreen(showResult, changeDisplay, setError, _backToSignIn),
                                  transition: Transition.rightToLeft,
                                  duration: const Duration(milliseconds: 500),
                                );
                              },
                              child: Padding(
                                padding: const EdgeInsets.only(top: 24),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text("Don’t have account?",
                                        style: Theme.of(context)
                                            .textTheme
                                            .bodyText2!
                                            .copyWith(
                                            fontWeight: FontWeight.w600,
                                            fontSize: 16,
                                            color:
                                            const Color(0xff9CA3AF))),
                                    Text(" Sign Up",
                                        style: Theme.of(context)
                                            .textTheme
                                            .bodyText2!
                                            .copyWith(
                                          fontWeight: FontWeight.w600,
                                          fontSize: 16,
                                          color: HexColor(
                                              AppTheme.primaryColorString!),
                                        ))
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 20),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
