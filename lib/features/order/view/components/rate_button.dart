import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:venturo_core/shared/styles/color_style.dart';

class RateButton extends StatelessWidget {
  const RateButton({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 30.h,
      width: 110.w,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          foregroundColor: ColorStyle.primary,
          backgroundColor: ColorStyle.white,
          side: BorderSide(color: ColorStyle.primary),
          padding: EdgeInsets.symmetric(vertical: 1.h),
        ),
        onPressed: () {},
        child: Text(
          'Beri Penilaian',
          style: TextStyle(fontSize: 13.sp, fontWeight: FontWeight.bold),
        ),
      ),
    );
  }
}
