// ignore_for_file: prefer_const_constructors

import 'package:fincept1/AuthScreens/LoginScreen/custom_button.dart';
import 'package:fincept1/AuthScreens/LoginScreen/reset_pswd_screen.dart';
import 'package:fincept1/config/textstyle.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:pin_code_fields/pin_code_fields.dart';


class VerifyYourIdentityScreen extends StatefulWidget {
  const VerifyYourIdentityScreen({Key? key}) : super(key: key);

  @override
  State<VerifyYourIdentityScreen> createState() => _VerifyYourIdentityScreenState();
}

class _VerifyYourIdentityScreenState extends State<VerifyYourIdentityScreen> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: WillPopScope(
        onWillPop: () async {
          SystemNavigator.pop();
          return false;
        },
        child: InkWell(
          onTap: () {
            FocusScope.of(context).requestFocus(FocusNode());
          },
          child: Container(
            color: AppTheme.isLightTheme == false ? const Color(0xff15141F) : const Color(0xffFFFFFF),
            child: Padding(
              padding: const EdgeInsets.only(left: 20, right: 20, top: 35),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  InkWell(
                      onTap: () {
                        Get.back();
                      },
                      child: const Icon(Icons.arrow_back)),
                  const Spacer(),
                  Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text(
                          "Verify your identity",
                          style: Theme.of(context).textTheme.headline6!.copyWith(
                                fontWeight: FontWeight.w800,
                                fontSize: 24,
                              ),
                        ),
                        const SizedBox(
                          height: 4,
                        ),
                        Text(
                          "We have just sent a code to",
                          style: Theme.of(context).textTheme.bodyText2!.copyWith(
                                fontWeight: FontWeight.w500,
                                fontSize: 16,
                                color: Color(0xffA2A0A8),
                              ),
                        ),
                        const SizedBox(
                          height: 4,
                        ),
                        Text(
                          "(+62) 812 345 6XXX",
                          style: Theme.of(context).textTheme.bodyText2!.copyWith(
                                fontWeight: FontWeight.w600,
                                fontSize: 16,
                              ),
                        ),
                        const SizedBox(
                          height: 32,
                        ),
                        const SizedBox(
                          height: 32,
                        ),
                        InkWell(
                          onTap: () {
                            Get.to(
                              const ResetPasswordScreen(),
                              transition: Transition.rightToLeft,
                              duration: const Duration(milliseconds: 500),
                            );
                          },
                          child: customButton(HexColor(AppTheme.primaryColorString!), "Continue", HexColor(AppTheme.secondaryColorString!), context),
                        ),
                      ],
                    ),
                  ),
                  const Spacer(),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
