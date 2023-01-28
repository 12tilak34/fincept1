import 'package:fincept1/AuthScreens/LoginScreen/custom_button.dart';
import 'package:fincept1/AuthScreens/LoginScreen/verify_screen.dart';
import 'package:fincept1/config/textstyle.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:pin_code_fields/pin_code_fields.dart';

class PasswordPin extends StatefulWidget {
  const PasswordPin({Key? key}) : super(key: key);

  @override
  State<PasswordPin> createState() => _PasswordPinState();
}

class _PasswordPinState extends State<PasswordPin> {

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
            color: AppTheme.isLightTheme == false ? const Color(0xff15141F) : Colors.white,
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
                          "Create New Pin",
                          style: Theme.of(context).textTheme.headline6!.copyWith(
                                fontWeight: FontWeight.w800,
                                fontSize: 24,
                              ),
                        ),
                        const SizedBox(
                          height: 4,
                        ),
                        Text(
                          "Add a pin number to make your wallet more secure",
                          textAlign: TextAlign.center,
                          style: Theme.of(context).textTheme.bodyText2!.copyWith(
                                fontWeight: FontWeight.w500,
                                fontSize: 16,
                                color: Theme.of(context).textTheme.caption!.color,
                              ),
                        ),
                        const SizedBox(
                          height: 32,
                        ),

                        const SizedBox(
                          height: 32,
                        ),
                        InkWell(
                          focusColor: Colors.transparent,
                          highlightColor: Colors.transparent,
                          hoverColor: Colors.transparent,
                          splashColor: Colors.transparent,
                          onTap: () {
                            Get.to(
                              const VerifyIdentityScreen(),
                              transition: Transition.rightToLeft,
                              duration: const Duration(milliseconds: 500),
                            );
                          },
                          child: customButton(HexColor(AppTheme.primaryColorString!), "Continue", HexColor(AppTheme.secondaryColorString!), context),
                        ),
                      ],
                    ),
                  ),
                  Spacer(),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
