import 'package:fincept1/config/textstyle.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CustomButton extends StatelessWidget {
  final String? title;
  final VoidCallback? onTap;
  const CustomButton({Key? key, this.title, this.onTap}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        onTap!();
      },
      child: Container(
        height: 56,
        width: Get.width,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16),
          color: HexColor(AppTheme.primaryColorString!),
        ),
        child: Center(
          child: Text(
            title!,
            style: Theme.of(Get.context!).textTheme.headline6!.copyWith(
                  fontSize: 16,
                  fontWeight: FontWeight.w700,
                  color: Colors.white,
                ),
          ),
        ),
      ),
    );
  }
}
