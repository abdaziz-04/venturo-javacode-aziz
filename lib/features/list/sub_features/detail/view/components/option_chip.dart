import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../../../../../shared/styles/color_style.dart';

class OptionChip extends StatelessWidget {
  final bool isSelected;
  final String text;
  final Function()? onTap;

  const OptionChip({
    Key? key,
    this.isSelected = false,
    required this.text,
    this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(30.r),
      child: Ink(
        padding: EdgeInsets.symmetric(horizontal: 14.r),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(30.r),
          color: isSelected ? ColorStyle.primary : ColorStyle.white,
        ),
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Center(
            child: Text(
              text.tr,
              style: Get.textTheme.bodyLarge!.copyWith(
                color: isSelected ? ColorStyle.white : ColorStyle.black,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
