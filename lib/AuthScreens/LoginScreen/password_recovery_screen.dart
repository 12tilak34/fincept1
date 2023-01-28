// ignore_for_file: avoid_function_literals_in_foreach_calls

import 'package:fincept1/AuthScreens/LoginScreen/authentication_controller.dart';
import 'package:fincept1/AuthScreens/LoginScreen/custom_button.dart';
import 'package:fincept1/AuthScreens/LoginScreen/custom_textformfield.dart';
import 'package:fincept1/AuthScreens/LoginScreen/verify_identity_screen.dart';
import 'package:fincept1/config/images.dart';
import 'package:fincept1/config/textstyle.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';


class PasswordRecoveryScreen extends StatefulWidget {
  const PasswordRecoveryScreen({Key? key}) : super(key: key);

  @override
  State<PasswordRecoveryScreen> createState() => _PasswordRecoveryScreenState();
}

class _PasswordRecoveryScreenState extends State<PasswordRecoveryScreen> {
  final authController = Get.put(AuthenticationController());
  final List<FocusNode> _focusNodes = [
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
            color: AppTheme.isLightTheme == false ? const Color(0xff15141F) : const Color(0xffFFFFFF),
            child: Padding(
              padding: const EdgeInsets.only(left: 20, right: 20, top: 35),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  InkWell(
                      focusColor: Colors.transparent,
                      highlightColor: Colors.transparent,
                      hoverColor: Colors.transparent,
                      splashColor: Colors.transparent,
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
                          "Password Recovery",
                          style: Theme.of(context).textTheme.headline6!.copyWith(
                                fontWeight: FontWeight.w800,
                                fontSize: 24,
                              ),
                        ),
                        const SizedBox(
                          height: 4,
                        ),
                        Text(
                          "Enter your Phone number to recover your password",
                          textAlign: TextAlign.center,
                          style: Theme.of(context)
                              .textTheme
                              .bodyText2!
                              .copyWith(fontWeight: FontWeight.w500, fontSize: 16, color: const Color(0xffA2A0A8)),
                        ),
                        const SizedBox(
                          height: 32,
                        ),
                        CustomTextFormField(
                          focusNode: _focusNodes[0],
                          prefix: Padding(
                            padding: const EdgeInsets.all(14.0),
                            child: SvgPicture.asset(
                              DefaultImages.phone,
                              color: _focusNodes[0].hasFocus ? HexColor(AppTheme.primaryColorString!) : const Color(0xffA2A0A8),
                              // color:  HexColor(AppTheme.secondaryColorString!)
                            ),
                          ),
                          hintText: "Phone Number",
                          inputType: TextInputType.phone,
                          textEditingController: authController.pswdRecoveryController.value,
                          capitalization: TextCapitalization.none,
                          limit: [LengthLimitingTextInputFormatter(10), FilteringTextInputFormatter.digitsOnly],
                        ),
                        const SizedBox(
                          height: 32,
                        ),
                        InkWell(
                          onTap: () {
                            Get.to(
                              const VerifyYourIdentityScreen(),
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
