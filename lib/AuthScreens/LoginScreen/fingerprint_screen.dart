import 'package:fincept1/AuthScreens/LoginScreen/tab_screen.dart';
import 'package:fincept1/config/images.dart';
import 'package:fincept1/config/textstyle.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

class FingerPrintScreen extends StatefulWidget {
  const FingerPrintScreen({Key? key}) : super(key: key);

  @override
  State<FingerPrintScreen> createState() => _FingerPrintScreenState();
}

class _FingerPrintScreenState extends State<FingerPrintScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: AppTheme.isLightTheme == false ? const Color(0xff15141F) : const Color(0xffFFFFFF),
        child: Column(
          children: [
            Expanded(
              flex: 9,
              child: Stack(
                alignment: Alignment.bottomCenter,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(bottom: 55),
                    child: Container(
                      width: Get.width,
                      decoration: BoxDecoration(
                        image: DecorationImage(
                          image: AssetImage(
                            AppTheme.isLightTheme == false ? DefaultImages.darkFinger : DefaultImages.fingerBg,
                          ),
                          fit: BoxFit.fill,
                        ),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(
                            padding: EdgeInsets.only(
                              left: 20,
                              right: 20,
                              top: AppBar().preferredSize.height,
                            ),
                            child: InkWell(
                                focusColor: Colors.transparent,
                                highlightColor: Colors.transparent,
                                hoverColor: Colors.transparent,
                                splashColor: Colors.transparent,
                                onTap: () {
                                  Get.back();
                                },
                                child: const Icon(Icons.arrow_back)),
                          ),
                          SizedBox(
                            height: Get.height / 5,
                          ),
                          Center(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Text(
                                  "Fingerprint",
                                  style: Theme.of(context).textTheme.headline6!.copyWith(
                                        fontWeight: FontWeight.w800,
                                        fontSize: 24,
                                      ),
                                ),
                                const SizedBox(
                                  height: 4,
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(left: 45.0, right: 45),
                                  child: Text(
                                    "Please lift and rest your finger for login authentication",
                                    textAlign: TextAlign.center,
                                    style: Theme.of(context)
                                        .textTheme
                                        .bodyText2!
                                        .copyWith(fontWeight: FontWeight.w500, fontSize: 16, color: const Color(0xffA2A0A8)),
                                  ),
                                ),
                              ],
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                  InkWell(
                    focusColor: Colors.transparent,
                    highlightColor: Colors.transparent,
                    hoverColor: Colors.transparent,
                    splashColor: Colors.transparent,
                    onTap: () {
                      Get.to(
                        const TabScreen(),
                        transition: Transition.rightToLeft,
                        duration: const Duration(milliseconds: 500),
                      );
                    },
                    child: Padding(
                      padding: const EdgeInsets.only(left: 20.0),
                      child: Container(
                        height: 120,
                        width: 120,
                        decoration: const BoxDecoration(shape: BoxShape.circle),
                        child: SvgPicture.asset(
                          AppTheme.isLightTheme == false ? DefaultImages.darkScanner : DefaultImages.fingerPrint,
                          //color:  HexColor(AppTheme.secondaryColorString!)
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Expanded(
              flex: 1,
              child: Padding(
                padding: const EdgeInsets.only(left: 45, right: 45),
                child: Center(
                  child: SizedBox(
                    width: Get.width,
                    child: RichText(
                      textAlign: TextAlign.center,
                      text: TextSpan(
                        children: <TextSpan>[
                          TextSpan(
                            text: "By set fingerprint, you agree to our ",
                            style: Theme.of(context).textTheme.bodyText2!.copyWith(
                                  fontWeight: FontWeight.w500,
                                  fontSize: 14,
                                  color: const Color(0xffA2A0A8),
                                ),
                          ),
                          TextSpan(
                              text: "Terms",
                              style: Theme.of(context).textTheme.bodyText2!.copyWith(
                                  fontWeight: FontWeight.w500,
                                  fontSize: 14,
                                  color: AppTheme.isLightTheme == false ? const Color(0xffA2A0A8) : const Color(0xff15141F))),
                          TextSpan(
                            text: " and ",
                            style: Theme.of(context).textTheme.bodyText2!.copyWith(
                                  fontWeight: FontWeight.w500,
                                  fontSize: 14,
                                  color: const Color(0xffA2A0A8),
                                ),
                          ),
                          TextSpan(
                              text: "Conditions",
                              style: Theme.of(context)
                                  .textTheme
                                  .bodyText2!
                                  .copyWith(fontWeight: FontWeight.w500, fontSize: 14, color: const Color(0xff15141F))),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
