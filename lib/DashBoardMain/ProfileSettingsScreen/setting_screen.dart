import 'package:fincept1/DashBoardMain/AddMoney/Dummypay.dart';
import 'package:fincept1/config/images.dart';
import 'package:fincept1/config/textstyle.dart';
import 'package:fincept1/main.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

class ProfileController extends GetxController {
  RxBool darkMode = false.obs;
  RxBool alert = true.obs;
  RxBool expense = true.obs;
  RxBool utilize = false.obs;
  RxBool balance = true.obs;
  RxBool paid = false.obs;
  RxBool spending = true.obs;
}

class SettingScreen extends StatefulWidget {
  const SettingScreen({Key? key}) : super(key: key);

  @override
  State<SettingScreen> createState() => _SettingScreenState();
}

class _SettingScreenState extends State<SettingScreen> {
  final profileController = Get.put(ProfileController());
  @override
  void initState() {
    setState(() {
      if (AppTheme.isLightTheme == false) {
        profileController.darkMode.value = true;
      } else {
        profileController.darkMode.value = false;
      }
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    int light = 1;
    int dark = 2;
    changeColor(int color) {
      if (color == light) {
        MyApp.setCustomeTheme(context, 6);
      } else {
        MyApp.setCustomeTheme(context, 7);
      }
    }

    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppTheme.isLightTheme == false
            ? HexColor('#15141f')
            : Theme.of(context).appBarTheme.backgroundColor,
        elevation: 0,
        leading: InkWell(
          onTap: () {
            Navigator.pop(context);
          },
          child: Icon(
            Icons.arrow_back,
            color: Theme.of(context).textTheme.headline6!.color,
          ),
        ),
      ),
      body: Container(
        height: Get.height,
        width: Get.width,
        color: AppTheme.isLightTheme == false
            ? HexColor('#15141f')
            : Theme.of(context).appBarTheme.backgroundColor,
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.only(left: 20, right: 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Settings",
                  style: Theme.of(context).textTheme.headline6!.copyWith(
                        fontSize: 24,
                        fontWeight: FontWeight.w800,
                      ),
                ),
                const SizedBox(height: 32),
                Text(
                  "General",
                  style: Theme.of(context).textTheme.caption!.copyWith(
                        fontSize: 14,
                        fontWeight: FontWeight.w500,
                        color: const Color(0xffA2A0A8),
                      ),
                ),
                const SizedBox(height: 16),
                notificationView(
                  context,
                  "Dark Mode",
                  CupertinoSwitch(
                    value: profileController.darkMode.value,
                    activeColor: HexColor(AppTheme.primaryColorString!),
                    onChanged: (v) {
                      setState(() {
                        profileController.darkMode.value = v;
                        if (v == true) {
                          changeColor(dark);
                        } else {
                          changeColor(light);
                        }
                      });
                    },
                  ),
                ),
                const SizedBox(height: 22),
                customRow(
                  context,
                  "Reset Password",
                ),
                const SizedBox(height: 32),
                InkWell(
                  onTap: () {
                    Get.to(
                      const DummyPay(),
                      transition: Transition.downToUp,
                      duration: const Duration(milliseconds: 500),
                    );
                  },
                  child: customRow(
                    context,
                    "Notifications",
                  ),
                ),
                const SizedBox(height: 32),
                customRow(
                  context,
                  "Privacy Settings",
                ),
                const SizedBox(height: 32),
                customRow(
                  context,
                  "Help Center",
                ),
                const SizedBox(height: 32),
                customRow(
                  context,
                  "Contact Us",
                ),
                const SizedBox(height: 32),
                InkWell(
                  onTap: () {
                    Get.offAll(DummyPay());
                  },
                  child: customRow(
                    context,
                    "Log out",
                  ),
                ),
                const SizedBox(height: 32),
                Text(
                  "Follow Us",
                  style: Theme.of(context).textTheme.caption!.copyWith(
                        fontSize: 14,
                        fontWeight: FontWeight.w500,
                        color: const Color(0xffA2A0A8),
                      ),
                ),
                const SizedBox(height: 16),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    socialView(
                      AppTheme.isLightTheme == false
                          ? DefaultImages.twitterdark
                          : DefaultImages.twitter,
                    ),
                    socialView(
                      AppTheme.isLightTheme == false
                          ? DefaultImages.facebookDark
                          : DefaultImages.facebook,
                    ),
                    socialView(
                      AppTheme.isLightTheme == false
                          ? DefaultImages.tiktokDark
                          : DefaultImages.tikTok,
                    ),
                    socialView(
                      AppTheme.isLightTheme == false
                          ? DefaultImages.instagramDark
                          : DefaultImages.instagram,
                    )
                  ],
                ),
                const SizedBox(height: 20),
                Center(
                  child: Text(
                    "Log out",
                    style: Theme.of(context).textTheme.headline6!.copyWith(
                          fontSize: 16,
                          fontWeight: FontWeight.w700,
                          color: const Color(0xffFB4E4E),
                        ),
                  ),
                ),
                const SizedBox(height: 16),
                Center(
                  child: Text(
                    "Fincept © 2023 v1.0",
                    style: Theme.of(context).textTheme.caption!.copyWith(
                          fontSize: 14,
                          fontWeight: FontWeight.w500,
                          color: const Color(0xff9EA3AE),
                        ),
                  ),
                ),
                const SizedBox(height: 20),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

Widget customRow(BuildContext context,String? title) {
  return Row(
    mainAxisAlignment: MainAxisAlignment.spaceBetween,
    children: [
      Text(
        title!,
        style: Theme.of(context).textTheme.bodyText2!.copyWith(
          fontSize: 16,
          fontWeight: FontWeight.w700,
        ),
      ),
      const Icon(
        Icons.arrow_forward_ios,
        color: Color(0xffE8E8E8),
        size:25,
      )
    ],
  );
}

Widget socialView(String? image) {
  return SizedBox(
    height: 64,
    width: 64,
    child: SvgPicture.asset(
      image!,
      fit: BoxFit.fill,
    ),
  );
}

Widget notificationView(BuildContext context, String? title, Widget? widget) {
  return Row(
    mainAxisAlignment: MainAxisAlignment.spaceBetween,
    children: [
      Text(
        title!,
        style: Theme.of(context).textTheme.bodyText2!.copyWith(
          fontSize: 16,
          fontWeight: FontWeight.w700,
        ),
      ),
      widget!,
    ],
  );
}
