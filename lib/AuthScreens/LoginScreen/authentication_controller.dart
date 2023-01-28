import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AuthenticationController extends GetxController {
  //pswd recovery
  Rx<TextEditingController> pswdRecoveryController =
      TextEditingController().obs;

  //Reset pswd
  Rx<TextEditingController> newPswdController = TextEditingController().obs;
  Rx<TextEditingController> confirmPswdController = TextEditingController().obs;
  RxBool isNewVisible = false.obs;
  RxBool isConfirmVisible = false.obs;
}
