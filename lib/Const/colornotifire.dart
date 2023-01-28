import 'package:flutter/material.dart';

class ColorNotifire with ChangeNotifier {
  bool isDark = false;
  set setIsDark(value) {
    isDark = value;
    notifyListeners();
  }

  get getIsDark => isDark;
  get getprimerycolor => isDark ? darkPrimeryColor : primeryColor;
  get getbackcolor => isDark ? darkbackColor : lightbackColor;
  get getprimerydarkcolor => isDark ? primerydarkColor : primerylightColor;
  get getdarkscolor => isDark ? lightColor : darkColor;
  get getdarkgreycolor => isDark ? darkgreyColor : greyColor;
  get getdarkwhitecolor => isDark ? darkwhiteColor : lightwhiteColor;
  get getbluecolor => isDark ? darkblueColor : blueColor;
  get gettabcolor => isDark ? darktabColor : tabColor;
  get gettabwhitecolor => isDark ? darktabwhiteColor : lighttabwhiteColor;
  get getpurplcolor => isDark ? darkpurpulColor : purpulColor;

}

dynamic height;
dynamic width;

Color primeryColor = const Color(0xffFBFBFD);
Color darkPrimeryColor = const Color(0xff2D2D3A);

Color darkColor = Colors.black;
Color lightColor = Colors.white;

Color lightbackColor = const Color(0xffD6E4FF);
Color darkbackColor = const Color(0xff3d3d4e);

Color greyColor = const Color(0xff686578);
Color darkgreyColor = const Color(0xff686578);

Color blueColor = const Color(0xff6C56F9);
Color darkblueColor = const Color(0xff6C56F9);

Color primerylightColor = const Color(0xffFBFBFD);
Color primerydarkColor = const Color(0xff3d3d4e);

Color lightwhiteColor = Colors.white;
Color darkwhiteColor = const Color(0xff3d3d4e);

Color tabColor = const Color(0xffECF1F6);
Color darktabColor = const Color(0xff3d3d4e);

Color lighttabwhiteColor = Colors.white;
Color darktabwhiteColor = const Color(0xff4b4b5a);

Color purpulColor = const Color(0xffD6E4FF);
Color darkpurpulColor = const Color(0xff4b4b5a);