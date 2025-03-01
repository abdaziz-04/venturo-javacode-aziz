import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:venturo_core/shared/styles/color_style.dart';

class OrderAgainButton extends StatelessWidget {
  final void Function() onTap;
  const OrderAgainButton({
    super.key,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        SizedBox(
          height: 30.h,
          width: 110.w,
          child: ElevatedButton(
            style: ElevatedButton.styleFrom(
              foregroundColor: ColorStyle.primary,
              backgroundColor: ColorStyle.primary,
              side: BorderSide(color: ColorStyle.primary),
              padding: EdgeInsets.symmetric(vertical: 1.h),
            ),
            onPressed: onTap,
            child: FittedBox(
              fit: BoxFit.scaleDown,
              child: Text(
                'Pesan Lagi',
                style: TextStyle(fontSize: 14.sp, color: ColorStyle.white),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
