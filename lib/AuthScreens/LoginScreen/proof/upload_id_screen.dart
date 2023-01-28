import 'package:fincept1/AuthScreens/LoginScreen/custom_button.dart';
import 'package:fincept1/AuthScreens/LoginScreen/tab_screen.dart';
import 'package:fincept1/config/images.dart';
import 'package:fincept1/config/textstyle.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class UploadIdScreen extends StatefulWidget {
  const UploadIdScreen({Key? key}) : super(key: key);

  @override
  State<UploadIdScreen> createState() => _UploadIdScreenState();
}

class _UploadIdScreenState extends State<UploadIdScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        alignment: Alignment.bottomCenter,
        children: [
          Stack(
            alignment: Alignment.centerRight,
            children: [
              Container(
                height: Get.height,
                width: Get.width,
                decoration: BoxDecoration(
                  gradient: LinearGradient(colors: [
                    AppTheme.isLightTheme == false
                        ? const Color(0xff15141F)
                        : const Color(0xffE3E8FC),
                    AppTheme.isLightTheme == false
                        ? const Color(0xff15141F)
                        : const Color(0xffF6F7FE),
                  ], begin: Alignment.topCenter, end: Alignment.bottomCenter),
                  image:  DecorationImage(
                    image: AssetImage(
                      DefaultImages.selfie,
                    ),
                    alignment: Alignment.centerLeft,
                  ),
                ),
                child: Padding(
                  padding: EdgeInsets.only(
                    left: 20,
                    right: 20,
                    top: AppBar().preferredSize.height,
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      InkWell(
                        onTap: () {
                          Navigator.pop(context);
                        },
                        child: const Icon(
                          Icons.arrow_back,
                        ),
                      ),
                      const SizedBox(
                        height: 38,
                      ),
                      Text(
                        "Selfie with ID Card",
                        style: Theme.of(context).textTheme.headline6!.copyWith(
                              fontWeight: FontWeight.w800,
                              fontSize: 24,
                            ),
                      ),
                      const SizedBox(
                        height: 4,
                      ),
                      Text(
                        "Please look at the camera and hold still",
                        style: Theme.of(context).textTheme.bodyText2!.copyWith(
                              fontWeight: FontWeight.w500,
                              fontSize: 16,
                              color: const Color(0xffA2A0A8),
                            ),
                      ),
                    ],
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(right: 32.0),
                child: Container(
                  height: 164,
                  width: 124,
                  decoration: BoxDecoration(
                    image: const DecorationImage(
                        image: AssetImage(
                      DefaultImages.idCard,
                    )),
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
              )
            ],
          ),
          Container(
            height: 226,
            width: Get.width,
            decoration: BoxDecoration(
              color: AppTheme.isLightTheme == false
                  ? const Color(0xff15141F)
                  : Colors.white,
              borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(32), topRight: Radius.circular(32)),
            ),
            child: Padding(
              padding: const EdgeInsets.only(left: 32, right: 32),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  const SizedBox(
                    height: 12,
                  ),
                  Container(
                    height: 6,
                    width: 48,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(24),
                        color: const Color(0xffE3E8FC)),
                  ),
                  const SizedBox(
                    height: 24,
                  ),
                  InkWell(
                    onTap: () {
                      Get.to(
                        const TabScreen(),
                        transition: Transition.rightToLeft,
                        duration: const Duration(milliseconds: 500),
                      );
                    },
                    child: customButton(
                        HexColor(AppTheme.primaryColorString!),
                        "Submit selfie",
                        HexColor(AppTheme.secondaryColorString!),
                        context),
                  ),
                  const SizedBox(
                    height: 16,
                  ),
                  InkWell(
                    onTap: () {
                      // Get.to(
                      //   const TabScreen(),
                      //
                      // );
                    },
                    child: customButton(
                        AppTheme.isLightTheme == false
                            ? const Color(0xff52525C)
                            : const Color(0xffF5F7FE),
                        "Retake selfie",
                        AppTheme.isLightTheme == false
                            ? Colors.white
                            : HexColor(AppTheme.primaryColorString!),
                        context),
                  ),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
