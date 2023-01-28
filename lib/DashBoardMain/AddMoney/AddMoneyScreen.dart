import 'package:fincept1/Const/colornotifire.dart';
import 'package:fincept1/DashBoardMain/AddMoney/Dummypay.dart';
import 'package:fincept1/config/textstyle.dart';
import'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
import 'package:razorpay_flutter/razorpay_flutter.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:slide_to_act/slide_to_act.dart';
import 'package:swipe/swipe.dart';

class AddMoney extends StatefulWidget {
  const AddMoney({Key? key}) : super(key: key);

  @override
  State<AddMoney> createState() => _AddMoneyState();
}

class _AddMoneyState extends State<AddMoney> {

  TextEditingController myController = TextEditingController();
  late Razorpay _razorpay;
  String strPay = "";
  bool visible = false;

  pay() {

    if (myController.text.isNotEmpty) {
      SystemChannels.textInput.invokeMethod('TextInput.hide');
      setState(() {
        visible = true;

      });

      String getAmount = myController.text;
      int amount = int.parse(getAmount) * 100;
      openCheckout(amount);
    } else {
      Fluttertoast.showToast(
          msg: "Please enter amount ", toastLength: Toast.LENGTH_SHORT);
    }
  }

  @override
  void initState() {
    super.initState();

    _razorpay = Razorpay();

    _razorpay.on(Razorpay.EVENT_PAYMENT_SUCCESS, _handlePaymentSuccess);
    _razorpay.on(Razorpay.EVENT_PAYMENT_ERROR, _handlePaymentError);
    _razorpay.on(Razorpay.EVENT_EXTERNAL_WALLET, _handleExternalWallet);
  }

  @override
  void dispose() {
    // Clean up the controller when the widget is disposed.
    super.dispose();
    myController.dispose();
    _razorpay.clear();
  }

  void _handlePaymentSuccess(PaymentSuccessResponse response) {
    print('Success Response: $response');

    setState(() {
      visible = false;

    });

    Fluttertoast.showToast(
        msg: "SUCCESS: " + response.paymentId!,
        toastLength: Toast.LENGTH_SHORT);
  }

  void _handlePaymentError(PaymentFailureResponse response) {
    setState(() {
      visible = false;

    });
    print('Error Response: $response');
    Fluttertoast.showToast(
        msg: "ERROR: " + response.code.toString() + " - " + response.message!,
        toastLength: Toast.LENGTH_SHORT);
  }

  void _handleExternalWallet(ExternalWalletResponse response) {
    setState(() {
      visible = false;

    });
    print('External SDK Response: $response');
    Fluttertoast.showToast(
        msg: "EXTERNAL_WALLET: " + response.walletName!,
        toastLength: Toast.LENGTH_SHORT);
  }

  void openCheckout(int amount) async {
    var options = {
      'key': 'rzp_live_wSBSQb3EBdcVts',
      'amount': amount,
      'name': 'Fincept',
      'description': 'Payment To Fincept',
      'retry': {'enabled': true, 'max_count': 1},
      'send_sms_hash': true,
      'external': {
        'wallets': []
      }
    };

    try {
      _razorpay.open(options);
    } catch (e) {
      debugPrint('Error: e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      body: Stack(
        alignment: Alignment.bottomCenter,
        children: [
          Column(
            children: [
              Padding(
                padding: const EdgeInsets.only(left: 20, right: 20, top: 50),
                child: Row(
                  children: [
                    InkWell(
                      focusColor: Colors.transparent,
                      highlightColor: Colors.transparent,
                      hoverColor: Colors.transparent,
                      splashColor: Colors.transparent,
                      onTap: () {
                        Navigator.pop(context);
                      },
                      child: const Icon(
                        Icons.arrow_back,
                        color: Colors.black,
                      ),
                    ),
                    const Expanded(child: SizedBox()),
                    Text(
                      "Add Money",
                      style: Theme.of(context).textTheme.headline6!.copyWith(
                        color: Colors.black,
                        fontSize: 20,
                        fontWeight: FontWeight.w800,
                      ),
                    ),
                    const Expanded(child: SizedBox()),
                    const Icon(
                      Icons.arrow_back,
                      color: Colors.transparent,
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(10.0),
                child: TextField(
                  keyboardType: TextInputType.number,
                  onChanged: (text) {
                    if (text.length == 0) {
                      myController.clear();
                      setState(() {
                        strPay = "";
                      });
                    } else {
                      strPay = text;
                      setState(() {
                        strPay;
                      });
                    }
                  },
                  controller: myController,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    hintText: 'Enter your amount',
                  ),
                  inputFormatters: [
                    new FilteringTextInputFormatter.allow(RegExp('[0-9]')),
                  ],
                ),
              ),
              ElevatedButton(
                onPressed:(){
                  pay();
                },
                child: Text(
                  'Add Money RS $strPay'.toString(),
                  style: TextStyle(fontSize: 15, color: Colors.white),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
