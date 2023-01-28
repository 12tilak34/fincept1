import 'package:flutter/material.dart';
import 'package:get/get.dart';

Widget customButton(Color bgClr, String text, Color txtClr, BuildContext context) {
  return Container(
    height: 56,
    width: Get.width,
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(16),
      color: bgClr,
    ),
    child: Center(
      child: Text(
        text,
        style: Theme.of(context).textTheme.bodyText2!.copyWith(
              fontWeight: FontWeight.w700,
              fontSize: 16,
              color: txtClr,
            ),
      ),
    ),
  );
}
