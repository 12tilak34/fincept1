import 'dart:async';
import 'package:amplify_auth_cognito/amplify_auth_cognito.dart';
import 'package:amplify_flutter/amplify_flutter.dart';
import 'package:fincept1/AuthScreens/LoginScreen/LoginScreen.dart';
import 'package:fincept1/DashBoardMain/DashBoardMain.dart';
import 'package:fincept1/OnboardingScreens/OnBoard1.dart';
import 'package:fincept1/config/textstyle.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {

  bool authenticated = false;
  String usermail = "";
  AmplifyAuthCognito auth = AmplifyAuthCognito();

  Future<void> fetchCurrentUserAttributes() async {
    try {
      final result = await Amplify.Auth.fetchUserAttributes();
      for (final element in result) {
        if (element.userAttributeKey.toString() == 'email') {
          setState(() {
            usermail = element.value;
          });
        }
      }
    } on AuthException catch (e) {
      print(e.message);
    }
  }

  // ignore: slash_for_doc_comments
  /**
   * Check the current authentication session
   * if there is a session active, set the state
   * to authenticated which will show the `Home` view
   *
   * Setup HUB listeners for Authentication states. This
   * will set the state back and forth from authenticated/unauthenticated
   * views based on the `authenticated` property
   */
  Future<void> _checkSession() async {
    print("Checking Auth Session...");
    try {
      final session = await Amplify.Auth.fetchAuthSession(
          options: CognitoSessionOptions(getAWSCredentials: true));
      authenticated = session.isSignedIn;

      if (authenticated) {
        final result = await Amplify.Auth.fetchUserAttributes();
        for (final element in result) {
          if (element.userAttributeKey.toString() == 'email') {
            usermail = element.value;
          }
        }
      }
      print("Session state isSignedIn?: $authenticated");
      if (usermail.toString() != "" && authenticated == true) {
        print('Welcome: $usermail');
      }

      // ignore: avoid_catches_without_on_clauses
    } catch (error) {
      authenticated = false;
      // if not signed in this should be caught
      // either way we will setup HUB events
      print("Session state isSignedIn?: $authenticated");
    }
    _setupAuthEvents();
  }

  void _setupAuthEvents() {
    Amplify.Hub.listen([HubChannel.Auth], (hubEvent) {
      switch (hubEvent.eventName) {
        case "SIGNED_IN":
          {
            print("HUB: USER IS SIGNED IN");
            setState(() {
              authenticated = true;
            });
          }
          break;
        case "SIGNED_OUT":
          {
            print("HUB: USER IS SIGNED OUT");
            setState(() {
              authenticated = false;
            });
          }
          break;
        case "SESSION_EXPIRED":
          {
            print("HUB: USER SESSION EXPIRED");
            setState(() {
              authenticated = false;
            });
            auth.signOut(request: null);
          }
          break;
        default:
          {
            print("HUB: CONFIGURATION EVENT");
          }
      }
    });
  }

  AmplifyException? _error;
  String authState = 'User not signed in';
  String displayState = '';

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
  void initState() {
    init();
    super.initState();
  }

  void init() async {
    Timer(const Duration(seconds: 2), () {
      Get.offAll(() => FutureBuilder<void>(
        future: _checkSession(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            return authenticated ? DashBoardMain() : LoginScreen(showResult, changeDisplay, () { }, () { }, () { }, () { }, setError);
          } else {
            return const Center(child: CircularProgressIndicator());
          }
        },
      ));
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        height: Get.height,
        width: Get.width,
        decoration: BoxDecoration(
            color: AppTheme.isLightTheme == false
                ? HexColor('#15141F')
                : HexColor(AppTheme.primaryColorString!)),
        child: Column(
          children: [
            const Spacer(),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Container(
                  height: 350,
                  width: 350,
                  child: Image.asset("assets/images/logo.png"),
                )
              ],
            ),
            const Spacer(),
            Padding(
              padding: const EdgeInsets.only(left: 48, right: 48, bottom: 20),
              child: Text(
                "Fincept is a financial platform to manage your wealth.\n\nA PRODUCT BY TLK INDUSTRIES",
                textAlign: TextAlign.center,
                style: Theme.of(context).textTheme.bodyText2!.copyWith(
                  fontWeight: FontWeight.w500,
                  fontSize: 14,
                  color: const Color(0xffDCDBE0),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
