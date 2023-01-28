// ignore_for_file: avoid_function_literals_in_foreach_calls
import 'package:amplify_auth_cognito/amplify_auth_cognito.dart';
import 'package:amplify_flutter/amplify_flutter.dart';
import 'package:fincept1/AuthScreens/LoginScreen/LoginScreen.dart';
import 'package:fincept1/AuthScreens/LoginScreen/custom_button.dart';
import 'package:fincept1/AuthScreens/LoginScreen/otp_auth_screen.dart';
import 'package:fincept1/config/images.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import '../../config/textstyle.dart';
import '../LoginScreen/custom_textformfield.dart';

class SignUpScreen extends StatefulWidget {
  final Function showResult;
  final Function changeDisplay;
  final Function setError;
  final VoidCallback backToSignIn;

  SignUpScreen(
      this.showResult, this.changeDisplay, this.setError, this.backToSignIn);

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  bool signUpController = false;

  final usernameController = TextEditingController();
  final passwordController = TextEditingController();
  final emailController = TextEditingController();
  final phoneController = TextEditingController();
  final name = TextEditingController();
  final birthdate = TextEditingController();
  final gender = TextEditingController();
  final address = TextEditingController();
  final aadhaar = TextEditingController();

  void _signUp() async {
    var userAttributes = {
      CognitoUserAttributeKey.email: emailController.text,
      CognitoUserAttributeKey.phoneNumber: phoneController.text,
      CognitoUserAttributeKey.birthdate: birthdate.text,
      CognitoUserAttributeKey.gender: gender.text,
      CognitoUserAttributeKey.name: name.text,
      CognitoUserAttributeKey.address: address.text,
      const CognitoUserAttributeKey.custom('AadhaarNumbers'): aadhaar.text,
    };
    try {
      var res = await Amplify.Auth.signUp(
              username: phoneController.text.trim(),
              password: passwordController.text.trim(),
              options: CognitoSignUpOptions(userAttributes: userAttributes));
      if (res.nextStep.signUpStep == 'CONFIRM_SIGN_UP_STEP') {
       Navigator.push(context, MaterialPageRoute(builder: (context)=> OtpVerificationScreen()));
      }
      if (res.nextStep.signUpStep == 'DONE') {
        // complete sign up
      }
      widget.showResult('Sign Up Status = ' + res.nextStep.signUpStep);
      // widget.changeDisplay(
      //     res.nextStep.signUpStep != 'DONE' ? 'SHOW_CONFIRM' : 'SHOW_SIGN_UP');
    } on AmplifyException catch (e) {
      print(e);
      //widget.setError(e);
    }
    Amplify.DataStore.save(User)
  }

  bool _isAmplifyConfigured = false;
  late AmplifyAuthCognito auth;
  String displayState = '';
  String authState = 'User not signed in';
  String lastHubEvent = '';
  AmplifyException? _error;

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

  void _fetchSession() async {
    try {
      CognitoAuthSession res = await Amplify.Auth.fetchAuthSession(
              options: CognitoSessionOptions(getAWSCredentials: true))
          as CognitoAuthSession;
      showResult('Session Sign In Status = ' + res.isSignedIn.toString());
    } on AmplifyException catch (e) {
      setError(e);
      print(e);
    }
  }

  void _getCurrentUser() async {
    try {
      var res = await Amplify.Auth.getCurrentUser();
      showResult('Current User Name = ' + res.username);
    } on AmplifyException catch (e) {
      setError(e);
    }
  }

  void _signOut() async {
    try {
      await Amplify.Auth.signOut();
      showResult('Signed Out');
      changeDisplay('SHOW_SIGN_IN');
    } on AmplifyException catch (e) {
      setState(() {
        _error = e;
      });
      print(e);
    }
  }

  void _showCreateUser() async {
    changeDisplay('SHOW_SIGN_UP');
  }

  final List<FocusNode> _focusNodes = [
    FocusNode(),
    FocusNode(),
    FocusNode(),
  ];

  @override
  void initState() {
    _focusNodes.forEach((node) {
      node.addListener(() {
        setState(() {});
      });
    });
    super.initState();
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
                  const SizedBox(
                    height: 10,
                  ),
                  Text(
                    "Getting Started",
                    style: Theme.of(context).textTheme.headline6!.copyWith(
                          fontWeight: FontWeight.w700,
                          fontSize: 24,
                        ),
                  ),
                  const SizedBox(
                    height: 4,
                  ),
                  Text(
                    "Create an account to continue!",
                    style: Theme.of(context).textTheme.bodyText2!.copyWith(
                          fontWeight: FontWeight.w500,
                          fontSize: 16,
                          color: const Color(0xffA2A0A8),
                        ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Expanded(
                    child: ListView(
                      physics: const ClampingScrollPhysics(),
                      shrinkWrap: true,
                      children: [
                        Column(
                          children: [
                            //   const SizedBox(height: 20),
                            CustomTextFormField(
                              prefix: const Padding(
                                  padding: EdgeInsets.all(14.0),
                                  child: Icon(Icons.person)),
                              hintText: "Full Name",
                              inputType: TextInputType.text,
                              textEditingController: name,
                              capitalization: TextCapitalization.words,
                              limit: [
                                FilteringTextInputFormatter.allow(
                                    RegExp('[a-zA-Z ]'))
                              ],
                            ),
                            const SizedBox(height: 24),
                            CustomTextFormField(
                              prefix: const Padding(
                                  padding: EdgeInsets.all(14.0),
                                  child: Icon(Icons.person)),
                              hintText: "Gender",
                              inputType: TextInputType.text,
                              textEditingController: gender,
                              capitalization: TextCapitalization.words,
                              limit: [
                                FilteringTextInputFormatter.allow(RegExp(
                                    '[ male Male MALE female Female FEMALE ]'))
                              ],
                            ),
                            const SizedBox(height: 24),
                            CustomTextFormField(
                              prefix: const Padding(
                                  padding: EdgeInsets.all(14.0),
                                  child: Icon(Icons.home)),
                              hintText: "Address",
                              inputType: TextInputType.text,
                              textEditingController: address,
                              capitalization: TextCapitalization.words,
                              limit: [
                                FilteringTextInputFormatter.allow(
                                    RegExp('[a-zA-Z ]'))
                              ],
                            ),
                            const SizedBox(height: 24),
                            CustomTextFormField(
                              prefix: const Padding(
                                  padding: EdgeInsets.all(14.0),
                                  child: Icon(Icons.cake)),
                              hintText: "Birthdate",
                              inputType: TextInputType.number,
                              textEditingController: birthdate,
                              capitalization: TextCapitalization.words,
                            ),
                            const SizedBox(height: 24),
                            CustomTextFormField(
                              prefix: const Padding(
                                  padding: EdgeInsets.all(14.0),
                                  child: Icon(Icons.phone)),
                              hintText: "Phone Number",
                              inputType: TextInputType.text,
                              textEditingController: phoneController,
                              capitalization: TextCapitalization.none,
                            ),
                            const SizedBox(height: 24),
                            CustomTextFormField(
                              prefix: const Padding(
                                  padding: EdgeInsets.all(14.0),
                                  child: Icon(Icons.email)),
                              hintText: "Email Address",
                              inputType: TextInputType.text,
                              textEditingController: emailController,
                              capitalization: TextCapitalization.words,
                            ),
                            const SizedBox(height: 24),
                            CustomTextFormField(
                              capitalization: TextCapitalization.none,
                              sufix: InkWell(
                                focusColor: Colors.transparent,
                                highlightColor: Colors.transparent,
                                hoverColor: Colors.transparent,
                                splashColor: Colors.transparent,
                                child: Padding(
                                  padding: const EdgeInsets.all(14.0),
                                  child: SvgPicture.asset(
                                    DefaultImages.eye,
                                    // color:  HexColor(AppTheme.secondaryColorString!)
                                  ),
                                ),
                              ),
                              prefix: const Padding(
                                  padding: EdgeInsets.all(14.0),
                                  child: Icon(Icons.password_sharp)),
                              hintText: "Password",
                              obscure: true,
                              textEditingController: passwordController,
                              inputType: TextInputType.visiblePassword,
                            ),
                            const SizedBox(height: 24),
                            CustomTextFormField(
                              prefix: const Padding(
                                  padding: EdgeInsets.all(14.0),
                                  child: Icon(Icons.credit_card_outlined)),
                              hintText: "Aadhaar Card Number",
                              inputType: TextInputType.number,
                              textEditingController: aadhaar,
                              capitalization: TextCapitalization.none,
                            ),
                            const SizedBox(height: 32),
                            InkWell(
                              focusColor: Colors.transparent,
                              highlightColor: Colors.transparent,
                              hoverColor: Colors.transparent,
                              splashColor: Colors.transparent,
                              onTap: _signUp,
                              child: customButton(
                                  HexColor(AppTheme.primaryColorString!),
                                  "Sign Up",
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
                                  LoginScreen(
                                      showResult,
                                      changeDisplay,
                                      _showCreateUser,
                                      _signOut,
                                      _fetchSession,
                                      _getCurrentUser,
                                      setError),
                                  transition: Transition.rightToLeft,
                                  duration: const Duration(milliseconds: 500),
                                );
                              },
                              child: Padding(
                                padding: const EdgeInsets.only(top: 24),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text("Already have an account? ",
                                        style: Theme.of(context)
                                            .textTheme
                                            .bodyText2!
                                            .copyWith(
                                                fontWeight: FontWeight.w600,
                                                fontSize: 16,
                                                color:
                                                    const Color(0xff9CA3AF))),
                                    Text(" Login",
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
