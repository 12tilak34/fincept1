// ignore_for_file: unnecessary_new, prefer_equal_for_default_values, unnecessary_const, empty_catches, unnecessary_string_interpolations

import 'dart:convert';
import 'package:fincept1/AuthScreens/SignUpScreen/select_reason_screen.dart';
import 'package:fincept1/config/images.dart';
import 'package:fincept1/config/textstyle.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_sim_country_code/flutter_sim_country_code.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

///This function returns list of countries
Future<List<Country>> getCountries(BuildContext context) async {
  final String response = await rootBundle.loadString('assets/country_code.json');
  final parsed = json.decode(response.toString()).cast<Map<String, dynamic>>();
  return parsed.map<Country>((json) => new Country.fromJson(json)).toList();
}

Future<Country?> getCountryByCountryCode(BuildContext context, String countryCode) async {
  final list = await getCountries(context);
  return list.firstWhere((element) => element.countryCode == countryCode);
}

Future<Country?> showCountryPickerDialog(
  BuildContext context, {
  double cornerRadius: 16,
  bool focusSearchBox: false,
}) {
  return showDialog<Country?>(
      context: context,
      barrierColor: AppTheme.isLightTheme == false ? const Color(0xff15141F) : const Color(0xffFBFBFB),
      barrierDismissible: true,
      builder: (_) => Dialog(
            elevation: 0,
            insetPadding: const EdgeInsets.only(
              left: 16,
              right: 16,
              bottom: 60,
            ),
            backgroundColor: AppTheme.isLightTheme == false ? const Color(0xff15141F) : const Color(0xffFBFBFB),
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.all(
              Radius.circular(cornerRadius),
            )),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 16),
                Padding(
                  padding: const EdgeInsets.only(left: 20.0),
                  child: InkWell(
                      focusColor: Colors.transparent,
                      highlightColor: Colors.transparent,
                      hoverColor: Colors.transparent,
                      splashColor: Colors.transparent,
                      onTap: () => Navigator.pop(context),
                      child: const Icon(Icons.arrow_back)),
                ),
                const SizedBox(height: 16),
                Expanded(
                  child: CountryPickerWidget(
                    onSelected: (country) => Navigator.of(context).pop(country),
                  ),
                ),
              ],
            ),
          ));
}

class Country {
  final String name;
  final String flag;
  final String countryCode;
  final String callingCode;

  const Country(this.name, this.flag, this.countryCode, this.callingCode);

  factory Country.fromJson(Map<String, dynamic> json) {
    return Country(
      json['name'] as String,
      json['flag'] as String,
      json['country_code'] as String,
      json['calling_code'] as String,
    );
  }
}

const TextStyle _defaultItemTextStyle = const TextStyle(fontSize: 16);
const TextStyle _defaultSearchInputStyle = const TextStyle(fontSize: 16);
const String _kDefaultSearchHintText = 'Search country name, code';
const String countryCodePackageName = 'country_calling_code_picker';

class CountryPickerWidget extends StatefulWidget {
  final ValueChanged<Country>? onSelected;

  final TextStyle itemTextStyle;

  final TextStyle searchInputStyle;

  final InputDecoration? searchInputDecoration;

  final double flagIconSize;

  final bool showSeparator;

  final bool focusSearchBox;

  final String searchHintText;

  const CountryPickerWidget({
    Key? key,
    this.onSelected,
    this.itemTextStyle = _defaultItemTextStyle,
    this.searchInputStyle = _defaultSearchInputStyle,
    this.searchInputDecoration,
    this.searchHintText = _kDefaultSearchHintText,
    this.flagIconSize = 32,
    this.showSeparator = false,
    this.focusSearchBox = false,
  }) : super(key: key);

  @override
  _CountryPickerWidgetState createState() => _CountryPickerWidgetState();
}

class _CountryPickerWidgetState extends State<CountryPickerWidget> {
  List<Country> _list = [];
  List<Country> _filteredList = [];
  final _controller = TextEditingController();
  final _scrollController = ScrollController();
  bool _isLoading = false;
  Country? _currentCountry;

  void _onSearch(text) {
    if (text == null || text.isEmpty) {
      setState(() {
        _filteredList.clear();
        _filteredList.addAll(_list);
      });
    } else {
      setState(() {
        _filteredList = _list
            .where((element) =>
                element.name.toLowerCase().contains(text.toString().toLowerCase()) ||
                element.callingCode.toLowerCase().contains(text.toString().toLowerCase()) ||
                element.countryCode.toLowerCase().startsWith(text.toString().toLowerCase()))
            .map((e) => e)
            .toList();
      });
    }
  }

  @override
  void initState() {
    _scrollController.addListener(() {
      FocusScopeNode currentFocus = FocusScope.of(context);
      if (!currentFocus.hasPrimaryFocus) {
        currentFocus.unfocus();
      }
    });
    loadList();
    super.initState();
  }

  void loadList() async {
    setState(() {
      _isLoading = true;
    });
    _list = await getCountries(context);
    try {
      String? code = await FlutterSimCountryCode.simCountryCode;
      _currentCountry = _list.firstWhere((element) => element.countryCode == code);
      final country = _currentCountry;
      if (country != null) {
        _list.removeWhere((element) => element.callingCode == country.callingCode);
        _list.insert(0, country);
      }
    } catch (e) {
    } finally {
      setState(() {
        _filteredList = _list.map((e) => e).toList();
        _isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: AppTheme.isLightTheme == false ? const Color(0xff15141F) : Colors.white,
      child: Column(
        children: <Widget>[
          const SizedBox(
            height: 16,
          ),
          Padding(
            padding: const EdgeInsets.only(left: 10.0, right: 10),
            child: Container(
              height: 56,
              decoration: BoxDecoration(
                  //  boxShadow: [BoxShadow(color: Colors.grey,blurRadius: 2)],
                  color: AppTheme.isLightTheme == false ? const Color(0xff211F32) : Colors.grey.shade200,
                  borderRadius: BorderRadius.circular(12)),
              child: Center(
                child: TextFormField(
                    onChanged: _onSearch,
                    textAlign: TextAlign.left,
                    autofocus: false,
                    autocorrect: true,
                    maxLines: 1,
                    textCapitalization: TextCapitalization.words,
                    textInputAction: TextInputAction.next,
                    style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w500, color: Colors.black, fontFamily: 'Manrope'),
                    keyboardType: TextInputType.text,
                    controller: _controller,
                    cursorColor: const Color(0xff15141F),
                    decoration: InputDecoration(
                        prefixIcon: Padding(
                          padding: const EdgeInsets.all(18.0),
                          child: SvgPicture.asset(
                            DefaultImages.searchNormal,
                            color: const Color(0xffA2A0A8),
                          ),
                        ),
                        contentPadding: const EdgeInsets.only(top: 15),
                        isDense: true,
                        suffixIcon: InkWell(
                          focusColor: Colors.transparent,
                          highlightColor: Colors.transparent,
                          hoverColor: Colors.transparent,
                          splashColor: Colors.transparent,
                          onTap: () => Navigator.pop(context),
                          child: Padding(
                            padding: const EdgeInsets.all(14.0),
                            child: Container(
                              decoration: BoxDecoration(color: Colors.grey, borderRadius: BorderRadius.circular(30)),
                              child: Icon(
                                Icons.close,
                                color: AppTheme.isLightTheme == false ? const Color(0xff211F32) : Colors.white,
                                size: 15,
                              ),
                            ),
                          ),
                        ),
                        // suffix: Container(height: 20,
                        // width: 20,

                        // decoration: BoxDecoration(  color: Colors.red,shape: BoxShape.circle),
                        //   child: Center(child: Icon(Icons.close_rounded,size: 15,color: Colors.white,))),
                        border: InputBorder.none,
                        hintText: "",
                        hintStyle: const TextStyle(color: Colors.grey))),
              ),
            ),
          ),
          // Padding(
          //   padding: const EdgeInsets.only(left: 24, right: 24),
          //   child: TextField(
          //     style: widget.searchInputStyle,
          //     autofocus: widget.focusSearchBox,
          //     decoration: widget.searchInputDecoration ??
          //         InputDecoration(
          //           suffixIcon: Visibility(
          //             visible: _controller.text.isNotEmpty,
          //             child: InkWell(
          //               child: const Icon(Icons.clear),
          //               onTap: () => setState(() {
          //                 _controller.clear();
          //                 _filteredList.clear();
          //                 _filteredList.addAll(_list);
          //               }),
          //             ),
          //           ),
          //           border: OutlineInputBorder(
          //             borderSide: const BorderSide(),
          //             borderRadius: BorderRadius.circular(30),
          //           ),
          //           contentPadding:
          //               const EdgeInsets.only(left: 16, right: 16, top: 8, bottom: 8),
          //           hintText: widget.searchHintText,
          //         ),
          //     textInputAction: TextInputAction.done,
          //     controller: _controller,
          //     onChanged: _onSearch,
          //   ),
          // ),
          const SizedBox(
            height: 16,
          ),
          Expanded(
            child: _isLoading
                ? const Center(child: const CircularProgressIndicator())
                : Container(
                    decoration: BoxDecoration(
                      boxShadow: [BoxShadow(blurRadius: 0.5, spreadRadius: 0.05, color: Colors.grey.shade500.withOpacity(0.5))],
                      borderRadius: BorderRadius.circular(12),
                      color: AppTheme.isLightTheme == false ? const Color(0xff15141F) : Colors.white,
                    ),
                    child: ListView.separated(
                      physics: const ClampingScrollPhysics(),
                      padding: const EdgeInsets.only(top: 16),
                      controller: _scrollController,
                      itemCount: _filteredList.length,
                      separatorBuilder: (_, index) => widget.showSeparator ? const Divider() : Container(),
                      itemBuilder: (_, index) {
                        return InkWell(
                          focusColor: Colors.transparent,
                          highlightColor: Colors.transparent,
                          hoverColor: Colors.transparent,
                          splashColor: Colors.transparent,
                          onTap: () {
                            widget.onSelected?.call(_filteredList[index]);
                            Get.to(
                              const SelectReasonScreen(),
                              transition: Transition.rightToLeft,
                              duration: const Duration(milliseconds: 500),
                            );
                          },
                          child: SizedBox(
                            height: 56,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Container(
                                      height: 46,
                                      width: 56,
                                      decoration: const BoxDecoration(shape: BoxShape.circle, color: Colors.white),
                                      child: CircleAvatar(
                                        backgroundImage: AssetImage(_filteredList[index].flag),
                                      )
                                      //   Image.asset(
                                      //    _filteredList[index].flag,
                                      // //   package: countryCodePackageName,
                                      //    width: widget.flagIconSize,
                                      // ),
                                      ),
                                ),
                                Text(
                                  _filteredList[index].countryCode,
                                  style: TextStyle(
                                      fontWeight: FontWeight.w600,
                                      color: AppTheme.isLightTheme == false
                                          ? Colors.white
                                          : const Color(
                                              0xffA2A0A8,
                                            ),
                                      fontSize: 16),
                                ),
                                const SizedBox(
                                  width: 8,
                                ),
                                Expanded(
                                  child: Text(
                                    '${_filteredList[index].name}',
                                    overflow: TextOverflow.ellipsis,
                                    maxLines: 1,
                                    style: TextStyle(
                                        fontWeight: FontWeight.w600,
                                        color: AppTheme.isLightTheme == false
                                            ? Colors.white
                                            : const Color(
                                                0xffA2A0A8,
                                              ),
                                        fontSize: 16),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        );
                      },
                    ),
                  ),
          )
        ],
      ),
    );
  }

  @override
  void dispose() {
    _scrollController.dispose();
    _controller.dispose();
    super.dispose();
  }
}
