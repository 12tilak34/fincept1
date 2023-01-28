import 'package:fincept1/DashBoardMain/AddMoney/Dummypay.dart';
import 'package:fincept1/DashBoardMain/ProfileSettingsScreen/chat_screen.dart';
import 'package:fincept1/DashBoardMain/ProfileSettingsScreen/setting_screen.dart';
import 'package:fincept1/config/images.dart';
import 'package:fincept1/config/textstyle.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  @override
  Widget build(BuildContext context) {
      return Container(
        height: Get.height,
        width: Get.width,
        color: Colors.white,
        child: Padding(
          padding: EdgeInsets.only(
            top: AppBar().preferredSize.height,
          ),
          child: Container(
            height: Get.height - 96,
            width: Get.width,
            decoration: BoxDecoration(
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(24),
                topRight: Radius.circular(24),
              ),
              color: AppTheme.isLightTheme == false
                  ? const Color(0xff211F32)
                  : Theme.of(context).appBarTheme.backgroundColor,
            ),
            child: ListView(
              physics: const ClampingScrollPhysics(),
              padding: EdgeInsets.zero,
              children: [
                Padding(
                  padding: const EdgeInsets.only(left: 20, right: 20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SizedBox(height: 15),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          InkWell(
                            onTap: () {
                              Get.to(
                                const SettingScreen(),
                                transition: Transition.downToUp,
                                duration: const Duration(milliseconds: 500),
                              );
                            },
                            child: Icon(
                              Icons.settings,
                              color: Theme.of(context).textTheme.headline6!.color,
                              size: 25,
                            ),
                          )
                        ],
                      ),
                      const SizedBox(height: 10),
                      Row(
                        children: [
                          Stack(
                            alignment: Alignment.bottomRight,
                            children: [
                              SizedBox(
                                height: 70,
                                width: 70,
                                child: Image.asset(
                                  DefaultImages.avatar,
                                  fit: BoxFit.fill,
                                ),
                              ),
                              SizedBox(
                                height: 28,
                                width: 28,
                                child: SvgPicture.asset(
                                  DefaultImages.camera,
                                  fit: BoxFit.fill,
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(width: 23),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "Daniel Travis",
                                style: Theme.of(context)
                                    .textTheme
                                    .bodyText2!
                                    .copyWith(
                                  fontSize: 20,
                                  fontWeight: FontWeight.w800,
                                ),
                              ),
                              const SizedBox(height: 8),
                              Container(
                                height: 28,
                                width: 116,
                                decoration: BoxDecoration(
                                  color:
                                  const Color(0xffF6A609).withOpacity(0.10),
                                  borderRadius: BorderRadius.circular(8),
                                ),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text(
                                      "Member Gold ",
                                      style: Theme.of(context)
                                          .textTheme
                                          .bodyText2!
                                          .copyWith(
                                        color: const Color(0xffF6A609),
                                        fontSize: 12,
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                    SvgPicture.asset(
                                      DefaultImages.ranking,
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                          const Expanded(child: SizedBox()),
                          InkWell(
                            onTap: () {
                              Get.to(DummyPay(),
                                  transition: Transition.downToUp,
                                  duration: const Duration(milliseconds: 500));
                            },
                            child: Text(
                              "Edit Profile",
                              style: Theme.of(context)
                                  .textTheme
                                  .bodyText2!
                                  .copyWith(
                                color: HexColor(AppTheme.primaryColorString!),
                                fontSize: 14,
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 32),
                      Text(
                        "Overview",
                        style: Theme.of(context).textTheme.bodyText2!.copyWith(
                          fontSize: 16,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                      const SizedBox(height: 8),
                      Row(
                        children: [
                          incomeContainer(
                            context,
                            "Net Income",
                            "\$4,500",
                            DefaultImages.income,
                          ),
                          const SizedBox(width: 16),
                          incomeContainer(
                            context,
                            "Expense",
                            "\$1,691",
                            DefaultImages.outcome,
                          )
                        ],
                      ),
                      const SizedBox(height: 16),
                      Container(
                        height: 122,
                        width: Get.width,
                        decoration: BoxDecoration(
                          color: AppTheme.isLightTheme == false
                              ? const Color(0xff323045)
                              : HexColor(AppTheme.primaryColorString!)
                              .withOpacity(0.05),
                          borderRadius: BorderRadius.circular(16),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(16.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                "Spend this week",
                                style: Theme.of(context)
                                    .textTheme
                                    .bodyText2!
                                    .copyWith(
                                  fontSize: 14,
                                  fontWeight: FontWeight.w600,
                                  color: const Color(0xff52525C),
                                ),
                              ),
                              Row(
                                children: [
                                  Container(
                                    height: 16,
                                    width: (Get.width / 2) - 63.5,
                                    decoration: BoxDecoration(
                                      color:
                                      HexColor(AppTheme.primaryColorString!),
                                      borderRadius: BorderRadius.circular(4),
                                    ),
                                  ),
                                  Container(
                                    height: 16,
                                    width: (Get.width / 2) - 93.5,
                                    decoration: BoxDecoration(
                                      color:
                                      HexColor(AppTheme.primaryColorString!)
                                          .withOpacity(0.10),
                                      borderRadius: const BorderRadius.only(
                                        bottomLeft: Radius.circular(4),
                                        topRight: Radius.circular(4),
                                      ),
                                    ),
                                  ),
                                  const SizedBox(width: 16),
                                  Text(
                                    "\$124",
                                    style: Theme.of(context)
                                        .textTheme
                                        .headline6!
                                        .copyWith(
                                      fontSize: 18,
                                      fontWeight: FontWeight.w800,
                                    ),
                                  ),
                                ],
                              ),
                              Text(
                                "\$124 left to spend",
                                style: Theme.of(context)
                                    .textTheme
                                    .bodyText2!
                                    .copyWith(
                                  fontSize: 14,
                                  fontWeight: FontWeight.w400,
                                  color: const Color(0xffA2A0A8),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      const SizedBox(height: 24),
                      InkWell(
                        onTap: () {
                          Get.to(
                            const ChatScreen(),
                            transition: Transition.downToUp,
                            duration: const Duration(milliseconds: 500),
                          );
                        },
                        child: SizedBox(
                          height: 80,
                          width: Get.width,
                          child: SvgPicture.asset(
                                DefaultImages.chatcsDark,
                            fit: BoxFit.fill,
                          ),
                        ),
                      ),
                      const SizedBox(height: 20),
                      Padding(
                        padding: const EdgeInsets.only(left: 16, right: 16),
                        child: Text(
                          "You joined Fincept on January 2023. It’s been 1 month since then and our mission is still the same, help you better manage your finance.",
                          style: Theme.of(context).textTheme.caption!.copyWith(
                            fontSize: 12,
                            fontWeight: FontWeight.w400,
                            height: 1.8,
                            color: const Color(0xffA2A0A8),
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ),
                      const SizedBox(height: 50),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      );
  }
}

Widget incomeContainer(BuildContext context, String? title, String? amount, String? image) {
  return Expanded(
    child: Container(
      height: 100,
      decoration: BoxDecoration(
        color: AppTheme.isLightTheme == false ? const Color(0xff323045) : HexColor(AppTheme.primaryColorString!).withOpacity(0.05),
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(
            title!,
            style: Theme.of(context).textTheme.caption!.copyWith(
              fontSize: 14,
              fontWeight: FontWeight.w600,
            ),
          ),
          const SizedBox(height: 14),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(
                height: 24,
                width: 24,
                child: SvgPicture.asset(
                  image!,
                  fit: BoxFit.fill,
                ),
              ),
              const SizedBox(width: 12),
              Text(
                amount!,
                style: Theme.of(context).textTheme.headline6!.copyWith(
                  fontSize: 24,
                  fontWeight: FontWeight.w800,
                ),
              ),
            ],
          )
        ],
      ),
    ),
  );
}