import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:venturo_core/shared/styles/color_style.dart';

class InfoRow extends StatelessWidget {
  final String info;
  final String value;
  final String? image;
  final bool containImage;
  final bool isImportant;
  final bool containButton;
  final Color valueColor;
  final bool isBold;
  final Function()? onPress;

  const InfoRow({
    super.key,
    this.isImportant = false,
    this.isBold = false,
    this.image,
    this.valueColor = ColorStyle.dark,
    required this.info,
    required this.value,
    this.containButton = true,
    this.containImage = false,
    this.onPress,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Row(
        children: [
          if (containImage && image != null) Image.asset(image!),
          if (containImage == true) SizedBox(width: 10),
          Text(
            info,
            style: TextStyle(
                fontWeight: FontWeight.bold, fontSize: isImportant ? 20 : 16),
          ),
          Spacer(),
          Text(
            value,
            style: TextStyle(
              fontSize: isImportant ? 20 : 16,
              color: valueColor,
              fontWeight: isBold ? FontWeight.bold : FontWeight.normal,
            ),
          ),
          SizedBox(width: 5.w),
          if (containButton == true)
            SizedBox(
              width: 24.w,
              height: 24.h,
              child: IconButton(
                icon: Icon(
                  Icons.arrow_forward_ios,
                  size: 16.sp,
                  color: ColorStyle.grey.withOpacity(0.5),
                ),
                onPressed: onPress,
              ),
            )
        ],
      ),
    );
  }
}
