import 'package:fincept1/Color.dart';
import 'package:fincept1/DashBoardMain/AddMoney/AddMoneyScreen.dart';
import 'package:fincept1/DashBoardMain/ExpenseTrackerScreen/ExpenseScreen.dart';
import 'package:fincept1/DashBoardMain/FinEduScreen/EducationScreen.dart';
import 'package:fincept1/DashBoardMain/MainScreen/MainScreen.dart';
import 'package:fincept1/DashBoardMain/ProfileSettingsScreen/ProfileScreen.dart';
import 'package:fincept1/config/images.dart';
import 'package:fincept1/config/textstyle.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../OnboardingScreens/tab_controller.dart';


class DashBoardMain extends StatefulWidget {
  const DashBoardMain({Key? key}) : super(key: key);

  @override
  State<DashBoardMain> createState() => _DashBoardMainState();
}

class _DashBoardMainState extends State<DashBoardMain> {

  final tabController = Get.put(TabScreenController());

  @override
  void initState() {
    tabController.customInit();
    super.initState();
  }

  int _currentIndex = 0;

  void onTabTapped(int index) {
    setState(() {
      _currentIndex = index;
    });
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: BottomNavigationBar(
        elevation: 20,
        currentIndex: tabController.pageIndex.value,
        onTap: (index) {
          setState(() {
            tabController.pageIndex.value = index;
          });
        },
        backgroundColor: AppTheme.isLightTheme == false
            ? HexColor('#15141f')
            : Theme.of(context).appBarTheme.backgroundColor,
        type: BottomNavigationBarType.fixed,
        unselectedItemColor: AppTheme.isLightTheme == false
            ? const Color(0xffA2A0A8)
            : HexColor(AppTheme.primaryColorString!).withOpacity(0.4),
        selectedItemColor: HexColor(AppTheme.primaryColorString!),
        items: [
          BottomNavigationBarItem(
            icon: SizedBox(
              height: 20,
              width: 20,
              child: SvgPicture.asset(
                DefaultImages.homr,
                color: tabController.pageIndex.value == 0
                    ? HexColor(AppTheme.primaryColorString!)
                    : AppTheme.isLightTheme == false
                    ? const Color(0xffA2A0A8)
                    : HexColor(AppTheme.primaryColorString!)
                    .withOpacity(0.4),
              ),
            ),
            label: "Home",
          ),
          BottomNavigationBarItem(
            icon: SizedBox(
              height: 20,
              width: 20,
              child: Icon(Icons.menu_book_outlined,
              color: tabController.pageIndex.value == 1
                  ? HexColor(AppTheme.primaryColorString!)
                  : AppTheme.isLightTheme == false
                  ? const Color(0xffA2A0A8)
                  : HexColor(AppTheme.primaryColorString!)
                  .withOpacity(0.4),),
            ),
            label: "Education",
          ),
          BottomNavigationBarItem(
              icon: SizedBox(
                height: 20,
                width: 20,
                child: SvgPicture.asset(
                  DefaultImages.chart,
                  color: tabController.pageIndex.value == 2
                      ? HexColor(AppTheme.primaryColorString!)
                      : AppTheme.isLightTheme == false
                      ? const Color(0xffA2A0A8)
                      : HexColor(AppTheme.primaryColorString!)
                      .withOpacity(0.4),
                ),
              ),
              label: "Tracker"),
          BottomNavigationBarItem(
              icon: SizedBox(
                height: 20,
                width: 20,
                child: SvgPicture.asset(
                  DefaultImages.profileUser,
                  color: tabController.pageIndex.value == 3
                      ? HexColor(AppTheme.primaryColorString!)
                      : AppTheme.isLightTheme == false
                      ? const Color(0xffA2A0A8)
                      : HexColor(AppTheme.primaryColorString!)
                      .withOpacity(0.4),
                ),
              ),
              label: "Profile"),
        ],
      ),
      body: GetX<TabScreenController>(
        init: tabController,
        builder: (tabController) => tabController.pageIndex.value == 0
            ? MainScreen()
            : tabController.pageIndex.value == 1
            ? const EducationScreen()
            : tabController.pageIndex.value == 2
            ? const ExpenseScreen()
            : const ProfileScreen(),
      ),
    );
  }
}


