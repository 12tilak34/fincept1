import 'package:fincept1/AuthScreens/LoginScreen/create_pin_screen.dart';
import 'package:fincept1/config/textstyle.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

class SelectReasonScreen extends StatefulWidget {
  const SelectReasonScreen({Key? key}) : super(key: key);

  @override
  State<SelectReasonScreen> createState() => _SelectReasonScreenState();
}

class _SelectReasonScreenState extends State<SelectReasonScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: WillPopScope(
        onWillPop: () async {
          SystemNavigator.pop();
          return false;
        },
        child: Container(
          color: AppTheme.isLightTheme == false
              ? const Color(0xff15141F)
              : Colors.white,
          child: InkWell(
            onTap: () {
              FocusScope.of(context).requestFocus(FocusNode());
            },
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
                    height: 38,
                  ),
                  Text(
                    "Main reason for using FinPay",
                    style: Theme.of(context).textTheme.headline6!.copyWith(
                          fontWeight: FontWeight.w700,
                          fontSize: 24,
                        ),
                  ),
                  const SizedBox(
                    height: 4,
                  ),
                  Text(
                    "We need to know this regulatory reasons. And also, we’re curious!",
                    style: Theme.of(context).textTheme.bodyText2!.copyWith(
                          fontWeight: FontWeight.w500,
                          fontSize: 16,
                          color: const Color(0xffA2A0A8),
                        ),
                  ),
                  const SizedBox(
                    height: 32,
                  ),
                  customReasonContainer(context, "Spend or save daily", () {
                    Get.to(
                      const PasswordPin(),
                      transition: Transition.rightToLeft,
                      duration: const Duration(milliseconds: 500),
                    );
                  }),
                  const SizedBox(
                    height: 24,
                  ),
                  customReasonContainer(context, "Spend while travelling", () {
                    Get.to(
                      const PasswordPin(),
                      transition: Transition.rightToLeft,
                      duration: const Duration(milliseconds: 500),
                    );
                  }),
                  const SizedBox(
                    height: 24,
                  ),
                  customReasonContainer(context, "Send money", () {
                    Get.to(
                      const PasswordPin(),
                      transition: Transition.rightToLeft,
                      duration: const Duration(milliseconds: 500),
                    );
                  }),
                  const SizedBox(
                    height: 24,
                  ),
                  customReasonContainer(
                      context, "Gain exposure to financial assets", () {
                    Get.to(
                      const PasswordPin(),
                      transition: Transition.rightToLeft,
                      duration: const Duration(milliseconds: 500),
                    );
                  })
                  // Expanded(

                  // ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

Widget customReasonContainer(
    BuildContext context, String text, VoidCallback onTap) {
  return InkWell(
    onTap: onTap,
    child: Container(
      height: 56,
      decoration: BoxDecoration(
          color: AppTheme.isLightTheme == false
              ? const Color(0xff211F32)
              : const Color(0xffF9F9FA),
          borderRadius: BorderRadius.circular(16)),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 16.0),
            child: Text(
              text,
              style: Theme.of(context).textTheme.bodyText2!.copyWith(
                fontWeight: FontWeight.w600,
                fontSize: 16,
                color: AppTheme.isLightTheme == false
                    ? Colors.white
                    : const Color(0xff15141F),
              ),
            ),
          ),
          const Padding(
            padding: EdgeInsets.only(right: 16.0),
            child: Icon(
              Icons.arrow_forward_ios_outlined,
              size: 15,
              color: Color(0xffA2A0A8),
            ),
          )
        ],
      ),
    ),
  );
}
