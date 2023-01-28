// ignore_for_file: avoid_function_literals_in_foreach_calls

import 'package:fincept1/AuthScreens/LoginScreen/authentication_controller.dart';
import 'package:fincept1/AuthScreens/LoginScreen/custom_button.dart';
import 'package:fincept1/AuthScreens/LoginScreen/custom_textformfield.dart';
import 'package:fincept1/AuthScreens/LoginScreen/otp_auth_screen.dart';
import 'package:fincept1/OnboardingScreens/OnBoard1.dart';
import 'package:fincept1/config/images.dart';
import 'package:fincept1/config/textstyle.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

class ResetPasswordScreen extends StatefulWidget {
  const ResetPasswordScreen({Key? key}) : super(key: key);

  @override
  State<ResetPasswordScreen> createState() => _ResetPasswordScreenState();
}

class _ResetPasswordScreenState extends State<ResetPasswordScreen> {
  final authController = Get.put(AuthenticationController());
  final List<FocusNode> _focusNodes = [
    FocusNode(),
    FocusNode(),
  ];

  @override
  void initState() {
    authController.isNewVisible.value = false;
    authController.isConfirmVisible.value = false;
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
          onTap: () {
            FocusScope.of(context).requestFocus(FocusNode());
          },
          child: Container(
            color: AppTheme.isLightTheme == false
                ? const Color(0xff15141F)
                : const Color(0xffFFFFFF),
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
                          "Reset your Password",
                          style:
                              Theme.of(context).textTheme.headline6!.copyWith(
                                    fontWeight: FontWeight.w800,
                                    fontSize: 24,
                                  ),
                        ),
                        const SizedBox(
                          height: 4,
                        ),
                        Text(
                          "At least 8 characters, with uppercase and lowercase letters",
                          textAlign: TextAlign.center,
                          style:
                              Theme.of(context).textTheme.bodyText2!.copyWith(
                                    fontWeight: FontWeight.w500,
                                    fontSize: 16,
                                    color: const Color(0xffA2A0A8),
                                  ),
                        ),
                        const SizedBox(
                          height: 32,
                        ),
                        CustomTextFormField(
                          focusNode: _focusNodes[0],
                          sufix: InkWell(
                            onTap: () {
                              authController.isNewVisible.value =
                                  !authController.isNewVisible.value;
                            },
                            child: Padding(
                              padding: const EdgeInsets.all(14.0),
                              child: SvgPicture.asset(
                                DefaultImages.eye,
                                // color:  HexColor(AppTheme.secondaryColorString!)
                              ),
                            ),
                          ),
                          prefix: Padding(
                            padding: const EdgeInsets.all(14.0),
                            child: SvgPicture.asset(
                              DefaultImages.pswd,
                              color: _focusNodes[0].hasFocus
                                  ? HexColor(AppTheme.primaryColorString!)
                                  : const Color(0xffA2A0A8),
                              // color:  HexColor(AppTheme.secondaryColorString!)
                            ),
                          ),
                          hintText: "New Password",
                          obscure: authController.isNewVisible.value == true
                              ? false
                              : true,
                          textEditingController:
                              authController.newPswdController.value,
                          capitalization: TextCapitalization.none,
                          limit: [
                            FilteringTextInputFormatter.singleLineFormatter,
                          ],
                          inputType: TextInputType.visiblePassword,
                        ),
                        const SizedBox(height: 24),
                        CustomTextFormField(
                          focusNode: _focusNodes[1],
                          sufix: InkWell(
                            onTap: () {
                              authController.isConfirmVisible.value =
                                  !authController.isConfirmVisible.value;
                            },
                            child: Padding(
                              padding: const EdgeInsets.all(14.0),
                              child: SvgPicture.asset(
                                DefaultImages.eye,
                                // color:  HexColor(AppTheme.secondaryColorString!)
                              ),
                            ),
                          ),
                          prefix: Padding(
                            padding: const EdgeInsets.all(14.0),
                            child: SvgPicture.asset(
                              DefaultImages.pswd,
                              color: _focusNodes[1].hasFocus
                                  ? HexColor(AppTheme.primaryColorString!)
                                  : const Color(0xffA2A0A8),
                              // color:  HexColor(AppTheme.secondaryColorString!)
                            ),
                          ),
                          hintText: "Confirm Password",
                          obscure: authController.isConfirmVisible.value == true
                              ? false
                              : true,
                          textEditingController:
                              authController.confirmPswdController.value,
                          capitalization: TextCapitalization.none,
                          limit: [
                            FilteringTextInputFormatter.allow(
                                RegExp('[a-zA-Z]')),
                          ],
                          inputType: TextInputType.visiblePassword,
                        ),
                        const SizedBox(
                          height: 32,
                        ),
                        InkWell(
                          onTap: () {
                            Get.to(
                               OnBoard1(),
                              transition: Transition.rightToLeft,
                              duration: const Duration(milliseconds: 500),
                            );
                          },
                          // child: customButton(
                          //     HexColor(AppTheme.primaryColorString!),
                          //     "Sign in",
                          //     HexColor(AppTheme.secondaryColorString!),
                          //     context),
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
