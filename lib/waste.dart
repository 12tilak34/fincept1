import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:razorpay_flutter/razorpay_flutter.dart';


class RazorDemo extends StatefulWidget {
  const RazorDemo({Key? key}) : super(key: key);

  @override
  _RazorDemoState createState() => _RazorDemoState();
}

class _RazorDemoState extends State<RazorDemo> {

  TextEditingController myController = TextEditingController();
  late Razorpay _razorpay;
  String strPay = "";
  bool visible = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(children: [
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: TextField(
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
          SizedBox(
            height: 20,
          ),

          Visibility(
              maintainSize: true,
              maintainAnimation: true,
              maintainState: true,
              visible: visible,
              child: CircularProgressIndicator()),

          SizedBox(
            height: 20,
          ),

          ElevatedButton(
            onPressed:(){
              pay();
            },
            child: Text(
              'Pay $strPay'.toString(),
              style: TextStyle(fontSize: 15, color: Colors.white),
            ),
          ),
        ]),
      ),
    );
  }

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
          msg: "Please enter amout ", toastLength: Toast.LENGTH_SHORT);
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
      'name': 'Acme Corp.',
      'description': 'Fine T-Shirt',
      'retry': {'enabled': true, 'max_count': 1},
      'send_sms_hash': true,
      'prefill': {'contact': '8888888888', 'email': 'test@razorpay.com'},
      'external': {
        'wallets': ['paytm']
      }
    };

    try {
      _razorpay.open(options);
    } catch (e) {
      debugPrint('Error: e');
    }
  }
}