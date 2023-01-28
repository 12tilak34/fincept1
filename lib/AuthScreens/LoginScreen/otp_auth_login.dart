import 'package:amplify_flutter/amplify_flutter.dart';
import 'package:fincept1/AuthScreens/LoginScreen/custom_button.dart';
import 'package:fincept1/AuthScreens/LoginScreen/custom_textformfield.dart';
import 'package:fincept1/AuthScreens/LoginScreen/tab_screen.dart';
import 'package:fincept1/DashBoardMain/DashBoardMain.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../../config/textstyle.dart';

class OtpVerificationScreen2 extends StatefulWidget {

  @override
  _OtpVerificationScreen2State createState() => _OtpVerificationScreen2State();

  void showResult(String s) {}
}

class _OtpVerificationScreen2State extends State<OtpVerificationScreen2> {

  final usernameController = TextEditingController();
  final confirmationCodeController = TextEditingController();

  void _confirmSignIn() async {
    try {
      var res = await Amplify.Auth.confirmSignIn(
          confirmationValue: confirmationCodeController.text.trim());
      if (res.nextStep?.signInStep == 'CONFIRM_SIGN_UP_STEP') {
        //  previous step completed
      }
      if (res.nextStep?.signInStep == 'DONE') {
        Navigator.push(context, MaterialPageRoute(builder: (context)=> DashBoardMain()));
      }
      widget.showResult('Confirm Sign In Status = ${res.nextStep?.signInStep}');
    } on AmplifyException catch (e) {
      print(e.message);
    }
  }


  @override
  void initState() {
    super.initState();
  }

  AmplifyException? _error;
  String authState = 'User not signed in';
  String displayState = '';
  void _backToSignIn() async {
    changeDisplay('SHOW_SIGN_IN');
  }

  void showResult(_authState) async {
    setState(() {
      _error = null;
      authState = _authState;
    });
    print(authState);
  }

  void changeDisplay(_displayState) async {
    setState(() {
      _error = null;
      displayState = _displayState;
    });
    print(displayState);
  }

  void setError(AmplifyException e) async {
    setState(() {
      _error = e;
    });
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
                  // const Icon(Icons.arrow_back),
                  const SizedBox(
                    height: 38,
                  ),
                  Center(
                    child: Text(
                      "Phone Number Confirmation",
                      style: Theme.of(context).textTheme.headline6!.copyWith(
                        fontWeight: FontWeight.w700,
                        fontSize: 24,
                      ),
                    ),
                  ),
                  Expanded(
                    child: ListView(
                      physics: const ClampingScrollPhysics(),
                      shrinkWrap: true,
                      children: [
                        Column(
                          children: [
                            const SizedBox(height: 30),
                            CustomTextFormField(
                              prefix: const Padding(
                                  padding: EdgeInsets.all(14.0),
                                  child: Icon(Icons.phone)
                              ),
                              hintText: "Enter Your Phone Number",
                              inputType: TextInputType.text,
                              textEditingController: usernameController,
                              capitalization: TextCapitalization.none,
                            ),
                            const SizedBox(height: 24),
                            CustomTextFormField(
                              prefix: const Padding(
                                  padding: EdgeInsets.all(14.0),
                                  child: Icon(Icons.password)
                              ),
                              hintText: "Confirmation Code",
                              textEditingController:confirmationCodeController,
                              capitalization: TextCapitalization.none,
                              limit: [
                                FilteringTextInputFormatter
                                    .singleLineFormatter,
                              ],
                              inputType: TextInputType.visiblePassword,
                            ),
                            const SizedBox(height: 52),
                            InkWell(
                              focusColor: Colors.transparent,
                              highlightColor: Colors.transparent,
                              hoverColor: Colors.transparent,
                              splashColor: Colors.transparent,
                              onTap: _confirmSignIn,
                              child: customButton(
                                  HexColor(AppTheme.primaryColorString!),
                                  "CONFIRM",
                                  HexColor(AppTheme.secondaryColorString!),
                                  context),
                            ),
                          ],
                        ),
                        const SizedBox(height: 20),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
