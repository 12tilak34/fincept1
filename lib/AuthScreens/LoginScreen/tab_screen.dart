// ignore_for_file: unnecessary_new, prefer_const_constructors, unused_field

import 'package:fincept1/OnboardingScreens/tab_controller.dart';
import 'package:fincept1/config/images.dart';
import 'package:fincept1/config/textstyle.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_svg/flutter_svg.dart';

class TabScreen extends StatefulWidget {
  const TabScreen({Key? key}) : super(key: key);

  @override
  State<TabScreen> createState() => _TabScreenState();
}

class _TabScreenState extends State<TabScreen> {
  final tabController = Get.put(TabScreenController());
 // final homeController = Get.put(HomeController());
  @override
  void initState() {
    tabController.customInit();
  //  homeController.customInit();
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
      floatingActionButton: FloatingActionButton(
        backgroundColor: HexColor(AppTheme.primaryColorString!),
        onPressed: () {},
        child: SvgPicture.asset(
          DefaultImages.scan,
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
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
            label: "home",
          ),
          BottomNavigationBarItem(
            icon: SizedBox(
              height: 20,
              width: 20,
              child: SvgPicture.asset(
                DefaultImages.chart,
                color: tabController.pageIndex.value == 1
                    ? HexColor(AppTheme.primaryColorString!)
                    : AppTheme.isLightTheme == false
                        ? const Color(0xffA2A0A8)
                        : HexColor(AppTheme.primaryColorString!)
                            .withOpacity(0.4),
              ),
            ),
            label: "Statistics",
          ),
          BottomNavigationBarItem(
              icon: SizedBox(
                height: 20,
                width: 20,
                child: SvgPicture.asset(
                  DefaultImages.card,
                  color: tabController.pageIndex.value == 2
                      ? HexColor(AppTheme.primaryColorString!)
                      : AppTheme.isLightTheme == false
                          ? const Color(0xffA2A0A8)
                          : HexColor(AppTheme.primaryColorString!)
                              .withOpacity(0.4),
                ),
              ),
              label: "Card"),
          BottomNavigationBarItem(
              icon: SizedBox(
                height: 20,
                width: 20,
                child: SvgPicture.asset(
                  DefaultImages.user,
                  color: tabController.pageIndex.value == 3
                      ? HexColor(AppTheme.primaryColorString!)
                      : AppTheme.isLightTheme == false
                          ? const Color(0xffA2A0A8)
                          : HexColor(AppTheme.primaryColorString!)
                              .withOpacity(0.4),
                ),
              ),
              label: "profile"),
        ],

        // height: 60,
        // selectedIndex: _currentIndex,
        // onDestinationSelected: (_currentIndex) => setState(() {
        //   this._currentIndex = _currentIndex;
        //   setState(() {
        //     tabController.pageIndex.value = _currentIndex;
        //   });
        // }),
        // backgroundColor: AppTheme.isLightTheme == false
        //     ? HexColor('#15141f')
        //     : Theme.of(context).appBarTheme.backgroundColor,

        // // ignore: prefer_const_literals_to_create_immutables
        // destinations: [
        //   NavigationDestination(
        //     icon: SizedBox(
        //       height: 20,
        //       width: 20,
        //       child: SvgPicture.asset(
        //         DefaultImages.homr,
        //         color: tabController.pageIndex.value == 0
        //             ? HexColor(AppTheme.primaryColorString!)
        //             : AppTheme.isLightTheme == false
        //                 ? const Color(0xffA2A0A8)
        //                 : HexColor(AppTheme.primaryColorString!)
        //                     .withOpacity(0.4),
        //       ),
        //     ),
        //     label: "Home",
        //   ),
        //   NavigationDestination(
        //       icon: SizedBox(
        //         height: 20,
        //         width: 20,
        //         child: SvgPicture.asset(
        //           DefaultImages.chart,
        //           color: tabController.pageIndex.value == 1
        //               ? HexColor(AppTheme.primaryColorString!)
        //               : AppTheme.isLightTheme == false
        //                   ? const Color(0xffA2A0A8)
        //                   : HexColor(AppTheme.primaryColorString!)
        //                       .withOpacity(0.4),
        //         ),
        //       ),
        //       label: "Statistics"),
        //   NavigationDestination(
        //       icon: SizedBox(
        //         height: 20,
        //         width: 20,
        //         child: SvgPicture.asset(
        //           DefaultImages.card,
        //           color: tabController.pageIndex.value == 2
        //               ? HexColor(AppTheme.primaryColorString!)
        //               : AppTheme.isLightTheme == false
        //                   ? const Color(0xffA2A0A8)
        //                   : HexColor(AppTheme.primaryColorString!)
        //                       .withOpacity(0.4),
        //         ),
        //       ),
        //       label: "Card"),
        //   NavigationDestination(
        //       icon: SizedBox(
        //         height: 20,
        //         width: 20,
        //         child: SvgPicture.asset(
        //           DefaultImages.user,
        //           color: tabController.pageIndex.value == 3
        //               ? HexColor(AppTheme.primaryColorString!)
        //               : AppTheme.isLightTheme == false
        //                   ? const Color(0xffA2A0A8)
        //                   : HexColor(AppTheme.primaryColorString!)
        //                       .withOpacity(0.4),
        //         ),
        //       ),
        //       label: "Profile"),
        // ],
      ),
      // body: _widgetOptions.elementAt(_currentIndex),,
      // BottomAppBar(
      //   clipBehavior: Clip.antiAlias,
      //   shape: const CircularNotchedRectangle(),
      //   elevation: 10,
      //   child: SizedBox(
      //     height: 55,
      //     child: BottomNavigationBar(
      //       currentIndex: tabController.pageIndex.value,
      //       onTap: (index) {
      //         setState(() {
      //           tabController.pageIndex.value = index;
      //         });
      //       },
      //       backgroundColor: AppTheme.isLightTheme == false
      //           ? HexColor('#15141f')
      //           : Theme.of(context).appBarTheme.backgroundColor,
      //       type: BottomNavigationBarType.fixed,
      //       unselectedItemColor: AppTheme.isLightTheme == false
      //           ? const Color(0xffA2A0A8)
      //           : HexColor(AppTheme.primaryColorString!).withOpacity(0.4),
      //       selectedItemColor: HexColor(AppTheme.primaryColorString!),
      //       items: [
      //         BottomNavigationBarItem(
      //           icon: SizedBox(
      //             height: 20,
      //             width: 20,
      //             child: SvgPicture.asset(
      //               DefaultImages.homr,
      //               color: tabController.pageIndex.value == 0
      //                   ? HexColor(AppTheme.primaryColorString!)
      //                   : AppTheme.isLightTheme == false
      //                       ? const Color(0xffA2A0A8)
      //                       : HexColor(AppTheme.primaryColorString!)
      //                           .withOpacity(0.4),
      //             ),
      //           ),
      //           label: "home",
      //         ),
      //         BottomNavigationBarItem(
      //           icon: SizedBox(
      //             height: 20,
      //             width: 20,
      //             child: SvgPicture.asset(
      //               DefaultImages.chart,
      //               color: tabController.pageIndex.value == 1
      //                   ? HexColor(AppTheme.primaryColorString!)
      //                   : AppTheme.isLightTheme == false
      //                       ? const Color(0xffA2A0A8)
      //                       : HexColor(AppTheme.primaryColorString!)
      //                           .withOpacity(0.4),
      //             ),
      //           ),
      //           label: "Statistics",
      //         ),
      //         BottomNavigationBarItem(
      //             icon: SizedBox(
      //               height: 20,
      //               width: 20,
      //               child: SvgPicture.asset(
      //                 DefaultImages.card,
      //                 color: tabController.pageIndex.value == 2
      //                     ? HexColor(AppTheme.primaryColorString!)
      //                     : AppTheme.isLightTheme == false
      //                         ? const Color(0xffA2A0A8)
      //                         : HexColor(AppTheme.primaryColorString!)
      //                             .withOpacity(0.4),
      //               ),
      //             ),
      //             label: "Card"),
      //         BottomNavigationBarItem(
      //             icon: SizedBox(
      //               height: 20,
      //               width: 20,
      //               child: SvgPicture.asset(
      //                 DefaultImages.user,
      //                 color: tabController.pageIndex.value == 3
      //                     ? HexColor(AppTheme.primaryColorString!)
      //                     : AppTheme.isLightTheme == false
      //                         ? const Color(0xffA2A0A8)
      //                         : HexColor(AppTheme.primaryColorString!)
      //                             .withOpacity(0.4),
      //               ),
      //             ),
      //             label: "profile"),
      //       ],
      //     ),
      //   ),
      // ),
      // body: GetX<TabScreenController>(
      //   init: tabController,
      //   builder: (tabController) => tabController.pageIndex.value == 0
      //       ? HomeView(homeController: homeController)
      //       : tabController.pageIndex.value == 1
      //           ? const StatisticsView()
      //           : tabController.pageIndex.value == 2
      //               ? const CardView()
      //               : const ProfileView(),
      // ),
    );
  }
}

