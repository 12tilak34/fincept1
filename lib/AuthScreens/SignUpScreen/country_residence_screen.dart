import 'package:fincept1/AuthScreens/LoginScreen/custom_button.dart';
import 'package:fincept1/AuthScreens/SignUpScreen/custom_coutry.dart';
import 'package:fincept1/AuthScreens/SignUpScreen/select_reason_screen.dart';
import 'package:fincept1/config/textstyle.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

class CountryResidenceScreen extends StatefulWidget {
  const CountryResidenceScreen({Key? key}) : super(key: key);

  @override
  State<CountryResidenceScreen> createState() => _CountryResidenceScreenState();
}

class _CountryResidenceScreenState extends State<CountryResidenceScreen> {
  Country? _selectedCountry;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final country = _selectedCountry;
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
            color: AppTheme.isLightTheme == false
                ? const Color(0xff15141F)
                : const Color(0xffFFFFFF),
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
                    child: const Icon(
                      Icons.arrow_back,
                    ),
                  ),
                  const SizedBox(
                    height: 38,
                  ),
                  Text(
                    "Country of residence",
                    style: Theme.of(context).textTheme.headline6!.copyWith(
                          fontWeight: FontWeight.w800,
                          fontSize: 24,
                        ),
                  ),
                  const SizedBox(
                    height: 4,
                  ),
                  Text(
                    "The terms and services which apply to you, will depend on your country of residence",
                    style: Theme.of(context).textTheme.bodyText2!.copyWith(
                          fontWeight: FontWeight.w500,
                          fontSize: 16,
                          color: const Color(0xffA2A0A8),
                        ),
                  ),
                  const SizedBox(
                    height: 32,
                  ),
                  country == null
                      ? Container(
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
                                child: Text("Select Country",
                                    style: Theme.of(context)
                                        .textTheme
                                        .bodyText2!
                                        .copyWith(
                                            fontWeight: FontWeight.w400,
                                            fontSize: 16,
                                            color: const Color(0xffA2A0A8))),
                              ),
                              InkWell(
                                focusColor: Colors.transparent,
                                highlightColor: Colors.transparent,
                                hoverColor: Colors.transparent,
                                splashColor: Colors.transparent,
                                onTap: () {
                                  setState(() {
                                    _onPressedShowDialog();
                                  });
                                },
                                child: Padding(
                                  padding: const EdgeInsets.only(right: 16.0),
                                  child: Icon(
                                    Icons.keyboard_arrow_down,
                                    size: 30,
                                    color:
                                        HexColor(AppTheme.primaryColorString!),
                                  ),
                                ),
                              )
                            ],
                          ),
                        )
                      : Container(
                          height: 56,
                          decoration: BoxDecoration(
                              color: const Color(0xffF9F9FA),
                              borderRadius: BorderRadius.circular(16)),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Container(
                                    height: 46,
                                    width: 56,
                                    decoration: const BoxDecoration(
                                        shape: BoxShape.circle,
                                        color: Colors.white),
                                    child: CircleAvatar(
                                      backgroundImage: AssetImage(country.flag),
                                    )),
                              ),
                              Text(
                                country.countryCode,
                                style: const TextStyle(
                                    fontWeight: FontWeight.w600,
                                    color: Color(
                                      0xffA2A0A8,
                                    ),
                                    fontSize: 16),
                              ),
                              const SizedBox(
                                width: 8,
                              ),
                              Expanded(
                                child: Text(
                                  country.name,
                                  overflow: TextOverflow.ellipsis,
                                  maxLines: 1,
                                  style: const TextStyle(
                                      fontWeight: FontWeight.w600,
                                      color: Color(
                                        0xff15141F,
                                      ),
                                      fontSize: 16),
                                ),
                              ),
                            ],
                          ),
                        ),
                  const Spacer(),
                  RichText(
                    textAlign: TextAlign.left,
                    text: TextSpan(children: <TextSpan>[
                      TextSpan(
                        text: "By pressing sign up securely, you agree to our ",
                        style: Theme.of(context).textTheme.bodyText2!.copyWith(
                              fontWeight: FontWeight.w500,
                              fontSize: 14,
                              color: const Color(0xffA2A0A8),
                            ),
                      ),
                      TextSpan(
                        text: "Terms & Conditions ",
                        style: Theme.of(context).textTheme.bodyText2!.copyWith(
                              fontWeight: FontWeight.w500,
                              fontSize: 14,
                              color: AppTheme.isLightTheme == false
                                  ? const Color(0xffA2A0A8)
                                  : const Color(0xff15141F),
                            ),
                      ),
                      TextSpan(
                        text: " and ",
                        style: Theme.of(context).textTheme.bodyText2!.copyWith(
                              fontWeight: FontWeight.w500,
                              fontSize: 14,
                              color: const Color(0xffA2A0A8),
                            ),
                      ),
                      TextSpan(
                          text: "Privacy policy.",
                          style:
                              Theme.of(context).textTheme.bodyText2!.copyWith(
                                    fontWeight: FontWeight.w500,
                                    fontSize: 14,
                                    color: AppTheme.isLightTheme == false
                                        ? const Color(0xffA2A0A8)
                                        : const Color(0xff15141F),
                                  )),
                    ]),
                  ),
                  const SizedBox(height: 28),
                  InkWell(
                    focusColor: Colors.transparent,
                    highlightColor: Colors.transparent,
                    hoverColor: Colors.transparent,
                    splashColor: Colors.transparent,
                    onTap: () {
                      Get.to(
                        const SelectReasonScreen(),
                        transition: Transition.rightToLeft,
                        duration: const Duration(milliseconds: 500),
                      );
                    },
                    child: customButton(
                        HexColor(AppTheme.primaryColorString!),
                        "Continue",
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

  void _onPressedShowDialog() async {
    final country = await showCountryPickerDialog(
      context,
    );
    if (country != null) {
      setState(() {
        _selectedCountry = country;
      });
    }
  }
}
