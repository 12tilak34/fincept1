import 'package:amplify_auth_cognito/amplify_auth_cognito.dart';
import 'package:amplify_flutter/amplify_flutter.dart';
import 'package:fincept1/AuthScreens/LoginScreen/LoginScreen.dart';
import 'package:fincept1/AuthScreens/SignUpScreen/SignUpScreen.dart';
import 'package:fincept1/OnboardingScreens/tab_controller.dart';
import 'package:fincept1/config/images.dart';
import 'package:fincept1/config/textstyle.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

Widget customButton(Color bgClr, String text, Color txtClr, BuildContext context) {
  return Container(
    height: 56,
    width: Get.width,
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(16),
      color: bgClr,
    ),
    child: Center(
      child: Text(
        text,
        style: Theme.of(context).textTheme.bodyText2!.copyWith(
          fontWeight: FontWeight.w700,
          fontSize: 16,
          color: txtClr,
        ),
      ),
    ),
  );
}


class OnBoard1 extends StatefulWidget {
  const OnBoard1({Key? key}) : super(key: key);

  @override
  State<OnBoard1> createState() => _OnBoard1State();
}

class _OnBoard1State extends State<OnBoard1> {

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

  final slideController = Get.put(TabScreenController());
  final controller =
  PageController(viewportFraction: 0.8, keepPage: true, initialPage: 0);
  final pages = List<int>.generate(2, (i) => 1, growable: false);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: AppTheme.isLightTheme == false
            ? const Color(0xff15141F)
            : const Color(0xffFFFFFF),
        child: Padding(
          padding: EdgeInsets.only(
            left: 32,
            right: 32.0,
            top: AppBar().preferredSize.height,
          ),
          child: Column(
            children: [
              const SizedBox(height: 15),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    slideController.i.value == 0
                        ? "Welcome to Fincept"
                        : "Fincept",
                    style: Theme.of(context).textTheme.bodyText2!.copyWith(
                      fontWeight: FontWeight.w500,
                      fontSize: 16,
                      color: Theme.of(context).textTheme.caption!.color,
                    ),
                  ),
                  InkWell(
                    onTap: () {
                      Get.offAll(()=>LoginScreen(showResult, changeDisplay, _showCreateUser, _signOut, _fetchSession, _getCurrentUser, setError));
                    },
                    child: Container(
                      height: 34,
                      width: 62,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(8),
                        color: AppTheme.isLightTheme == false
                            ? const Color(0xff52525C)
                            : const Color(0xffF9F9FA),
                      ),
                      child: Center(
                        child: Text(
                          "Skip",
                          style:
                          Theme.of(context).textTheme.bodyText2!.copyWith(
                            fontWeight: FontWeight.w700,
                            fontSize: 14,
                            color: AppTheme.isLightTheme == false
                                ? Colors.white
                                : const Color(0xff15141F),
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              Expanded(
                child: ListView(
                  physics: const ClampingScrollPhysics(),
                  children: [
                    slideController.i.value == 0
                        ? SizedBox(
                      height: 130,
                      child: Text(
                        "Earn a fixed 9% on your investment \nBit the Inflation",
                        style: Theme.of(context)
                            .textTheme
                            .bodyText2!
                            .copyWith(
                          fontWeight: FontWeight.w800,
                          fontSize: 32,
                        ),
                      ),
                    )
                        : SizedBox(
                      height: 130,
                      child: Text(
                        "Educate yourself on wealth management for free",
                        style: Theme.of(context)
                            .textTheme
                            .bodyText2!
                            .copyWith(
                          fontWeight: FontWeight.w800,
                          fontSize: 32,
                        ),
                      ),
                    ),
                    const SizedBox(height: 30),
                    SizedBox(
                      height: 200,
                      child: PageView.builder(
                        controller: controller,
                        itemCount: pages.length,
                        onPageChanged: (slideIndex) {
                          setState(() {
                            slideController.i.value = slideIndex;
                          });
                        },
                        itemBuilder: (_, index) {
                          return Container(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(16),
                                color: Colors.transparent,
                              ),
                              margin: const EdgeInsets.symmetric(
                                  horizontal: 10, vertical: 4),
                              child: index == 0
                                  ? SizedBox(
                                  height: 232,
                                  // width: 232,
                                  child: Image.asset(
                                  "assets/images/wlcm1.png",
                                    fit: BoxFit.fill,
                                  ))
                                  : SizedBox(
                                  height: 232,
                                  //  width: 280,
                                  child: Image.asset(
                                    "assets/images/wlcm2.png",
                                    fit: BoxFit.fill,
                                  )));
                        },
                      ),
                    ),
                    const SizedBox(height: 10),
                    Center(
                      child: SmoothPageIndicator(
                        controller: controller,
                        count: pages.length,
                        effect: const ExpandingDotsEffect(
                          dotHeight: 8,
                          dotWidth: 10,
                          // strokeWidth: 5,
                        ),
                      ),
                    ),
                    //   const SizedBox(height: 30.0),
                  ],
                ),
              ),
              InkWell(
                focusColor: Colors.transparent,
                highlightColor: Colors.transparent,
                hoverColor: Colors.transparent,
                splashColor: Colors.transparent,
                onTap: () {
                  Get.offAll(LoginScreen(showResult, changeDisplay, _showCreateUser, _signOut, _fetchSession, _getCurrentUser, setError));
                },
                child: customButton(HexColor(AppTheme.primaryColorString!),
                    "Login", HexColor(AppTheme.secondaryColorString!), context),
              ),
              const SizedBox(
                height: 16,
              ),
              InkWell(
                focusColor: Colors.transparent,
                highlightColor: Colors.transparent,
                hoverColor: Colors.transparent,
                splashColor: Colors.transparent,
                onTap: () {
                  Get.offAll(SignUpScreen(showResult,changeDisplay,setError,_backToSignIn));
                },
                child: customButton(
                    AppTheme.isLightTheme == false
                        ? const Color(0xff52525C)
                        : const Color(0xffF5F7FE),
                    "Create an account",
                    AppTheme.isLightTheme == false
                        ? Colors.white
                        : HexColor(AppTheme.primaryColorString!),
                    context),
              ),
              SizedBox(
                height: MediaQuery.of(context).padding.bottom + 16,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
