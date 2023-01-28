// ignore_for_file: file_names, prefer_const_constructors

import 'package:fincept1/config/textstyle.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';


Widget customMethodContainer(BuildContext context, String text, String subText, String img, VoidCallback onTap) {
  return Container(
    height: 72,
    decoration: BoxDecoration(
        color: AppTheme.isLightTheme == false ? const Color(0xff211F32) : const Color(0xffF9F9FA), borderRadius: BorderRadius.circular(16)),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Row(
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 16.0),
              child: SizedBox(
                height: 40,
                width: 40,
                child: SvgPicture.asset(
                  img,
                  fit: BoxFit.cover,
                  // color:  HexColor(AppTheme.secondaryColorString!)
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    text,
                    style: Theme.of(context).textTheme.bodyText2!.copyWith(
                          fontWeight: FontWeight.w600,
                          fontSize: 16,
                          color: AppTheme.isLightTheme == false ? Colors.white : const Color(0xff15141F),
                        ),
                  ),
                  const SizedBox(
                    height: 2,
                  ),
                  Text(subText,
                      style:
                          Theme.of(context).textTheme.bodyText2!.copyWith(fontWeight: FontWeight.w500, fontSize: 14, color: const Color(0xff808A9E))),
                ],
              ),
            ),
          ],
        ),
        InkWell(
          onTap: onTap,
          child: Padding(
            padding: EdgeInsets.only(right: 16.0),
            child: Icon(
              Icons.arrow_forward_ios_outlined,
              size: 15,
              color: HexColor(AppTheme.primaryColorString!),
            ),
          ),
        )
      ],
    ),
  );
}
