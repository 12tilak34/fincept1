import 'dart:async';
import 'package:amplify_auth_cognito/amplify_auth_cognito.dart';
import 'package:amplify_flutter/amplify_flutter.dart';
import 'package:fincept1/AuthScreens/LoginScreen/LoginScreen.dart';
import 'package:fincept1/ConfigAmplify.dart';
import 'package:fincept1/Const/colornotifire.dart';
import 'package:fincept1/DashBoardMain/DashBoardMain.dart';
import 'package:fincept1/SplashScreen.dart';
import 'package:fincept1/amplifyconfiguration.dart';
import 'package:fincept1/config/textstyle.dart';
import 'package:fincept1/waste.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]).then(
        (_) => runApp(
        MyApp(),
    ),
  );
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  static setCustomeTheme(BuildContext context, int index) async {
    final _MyAppState? state = context.findAncestorStateOfType<_MyAppState>();

    state!.setCustomeTheme(index);
  }

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {

  setCustomeTheme(int index) {
    if (index == 6) {
      setState(() {
        AppTheme.isLightTheme = true;
      });
    } else if (index == 7) {
      setState(() {
        AppTheme.isLightTheme = false;
      });
    }
  }

  late StreamSubscription subscription;
  bool _isAmplifyConfigured = false;
  late AmplifyAuthCognito auth;
  String displayState = '';
  String authState = 'User not signed in';
  String lastHubEvent = '';
  AmplifyException? _error;

  void changeDisplay(_displayState) async {
    setState(() {
      _error = null;
      displayState = _displayState;
    });
    print(displayState);
  }

  void showResult(_authState) async {
    setState(() {
      _error = null;
      authState = _authState;
    });
    print(authState);
  }

  void setError(AmplifyException e) async {
    setState(() {
      _error = e;
    });
  }

  Future<bool> _isSignedIn() async {
    final session = await Amplify.Auth.fetchAuthSession();
    return session.isSignedIn;
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

  void _showCreateUser() async {
    changeDisplay('SHOW_SIGN_UP');
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

  bool _amplifyConfigured = false;

  void configureAmplify() async {
    // If the widget was removed from the tree while the asynchronous platform
    // message was in flight, we want to discard the reply rather than calling
    // setState to update our non-existent appearance.
    if (!mounted) return;

    // Configure analytics plugin
    AmplifyAuthCognito authPlugin = AmplifyAuthCognito();

    Amplify.addPlugins([authPlugin]);

    try {
      await Amplify.configure(amplifyconfig);
      setState(() {
        _amplifyConfigured = true;
      });
    } on AnalyticsException catch (e) {
      print(e.toString());
    }
  }

  Future<void> _configureAmplify() async {

      final auth = AmplifyAuthCognito();

      // If the widget was removed from the tree while the asynchronous platform
      // message was in flight, we want to discard the reply rather than calling
      // setState to update our non-existent appearance.
      if (!mounted) return;

      // Configure analytics plugin
      AmplifyAuthCognito authPlugin = AmplifyAuthCognito();

      Amplify.addPlugins([authPlugin]);

      try {
        await Amplify.configure(amplifyconfig);
        setState(() {
          _amplifyConfigured = true;
        });
      } on AnalyticsException catch (e) {
        print(e.toString());
      }
  }

  @override
  void initState() {
    super.initState();
    _configureAmplify();
  }

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'Fincept',
          home:  SplashScreen(),
    );
  }
}

