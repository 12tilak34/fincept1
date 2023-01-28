import 'package:fincept1/AuthScreens/LoginScreen/custom_button.dart';
import 'package:fincept1/AuthScreens/LoginScreen/proof/residency-proof_screen.dart';
import 'package:fincept1/config/images.dart';
import 'package:fincept1/config/textstyle.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

class VerifyIdentityScreen extends StatefulWidget {
  const VerifyIdentityScreen({Key? key}) : super(key: key);

  @override
  State<VerifyIdentityScreen> createState() => _VerifyIdentityScreenState();
}

class _VerifyIdentityScreenState extends State<VerifyIdentityScreen> {
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
                : Colors.white,
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
                    child: const Icon(Icons.arrow_back),
                  ),
                  const SizedBox(
                    height: 44,
                  ),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SizedBox(
                        height: 160,
                        width: 160,
                        child: SvgPicture.asset(
                          AppTheme.isLightTheme == false
                              ? DefaultImages.darkVerify
                              : DefaultImages.verifyIcon,
                          fit: BoxFit.fill,
                        ),
                      ),
                      const SizedBox(
                        height: 32,
                      ),
                      Text(
                        "First, let’s verify your identity",
                        textAlign: TextAlign.center,
                        style: Theme.of(context).textTheme.headline6!.copyWith(
                              fontWeight: FontWeight.w800,
                              fontSize: 24,
                            ),
                      ),
                      const SizedBox(
                        height: 24,
                      ),
                      Text(
                        "We’re required by law to verify your identity before you can spend with your card or send money. Your information will be encrypted and stored securely.",
                        textAlign: TextAlign.center,
                        style: Theme.of(context).textTheme.bodyText2!.copyWith(
                            fontWeight: FontWeight.w500,
                            fontSize: 16,
                            color: const Color(0xffA2A0A8)),
                      ),
                    ],
                  ),
                  const Spacer(),
                  InkWell(
                    onTap: () {
                      Get.to(
                        const RedsidencyProofScreen(),
                        transition: Transition.rightToLeft,
                        duration: const Duration(milliseconds: 500),
                      );
                    },
                    child: customButton(
                        HexColor(AppTheme.primaryColorString!),
                        "Verify Identity",
                        HexColor(AppTheme.secondaryColorString!),
                        context),
                  ),
                  SizedBox(height: MediaQuery.of(context).padding.bottom + 14),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
