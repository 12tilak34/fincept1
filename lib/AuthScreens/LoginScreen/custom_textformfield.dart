import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../config/textstyle.dart';


class CustomTextFormField extends StatelessWidget {
  final String? labelText;
  final String hintText;
  final TextEditingController textEditingController;
  final Widget? sufix;
  final Widget? prefix;
  final bool obscure;
  final FocusNode? focusNode;
  final List<TextInputFormatter>? limit;
  final TextCapitalization capitalization;
  final TextInputType? inputType;
  final bool? readOnly;

  const CustomTextFormField({
    Key? key,
    required this.hintText,
    required this.textEditingController,
    this.sufix,
    this.prefix,
    this.obscure = false,
    this.limit,
    this.labelText,
    required this.capitalization,
    this.inputType,
    this.readOnly = false,
    this.focusNode,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 56,
      decoration: BoxDecoration(
          color: AppTheme.isLightTheme == false
              ? const Color(0xff211F32)
              : const Color(0xffF9F9FA),
          borderRadius: BorderRadius.circular(16)),
      child: Padding(
        padding: const EdgeInsets.only(top: 5.0),
        child: TextFormField(
            controller: textEditingController,
            obscureText: obscure,
            focusNode: focusNode,
            textCapitalization: capitalization,
            keyboardType: inputType,
            readOnly: readOnly!,
            inputFormatters: limit,
            decoration: InputDecoration(
                prefixIcon: prefix,
                suffixIcon: sufix,
                labelText: labelText,

                //   labelStyle: pRegular14,
                hintText: hintText,
                // hintStyle: pRegular14.copyWith(
                //   color: ConstColors.textColor.withOpacity(0.5),
                // ),
                border: InputBorder.none)),
      ),
    );
  }
}
