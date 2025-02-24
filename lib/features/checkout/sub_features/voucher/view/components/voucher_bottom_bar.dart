import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:venturo_core/features/checkout/sub_features/voucher/controllers/checkout_voucher_controller.dart';
import 'package:venturo_core/shared/styles/color_style.dart';
import 'package:venturo_core/shared/styles/elevated_button_style.dart';

class VoucherBottomBar extends StatelessWidget {
  const VoucherBottomBar({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 125.h,
      decoration: BoxDecoration(
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(30),
          topRight: Radius.circular(30),
        ),
        boxShadow: const [
          BoxShadow(color: Colors.black38, spreadRadius: 0, blurRadius: 10),
        ],
        color: ColorStyle.white,
      ),
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 20.h, vertical: 10.h),
        child: Column(
          children: [
            Row(
              children: [
                Icon(
                  Icons.check_circle_outline,
                  color: ColorStyle.primary,
                  size: 20.sp,
                ),
                SizedBox(width: 5.w),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Penggunaan voucher tidak dapat digabung dengan',
                      style: TextStyle(
                        color: ColorStyle.dark,
                        fontSize: 14.sp,
                      ),
                    ),
                    Text('discount employee reward program',
                        style: TextStyle(
                            color: ColorStyle.primary,
                            fontSize: 14.sp,
                            fontWeight: FontWeight.bold)),
                  ],
                ),
              ],
            ),
            SizedBox(height: 10.h),
            SizedBox(
              height: 50.h,
              width: double.infinity,
              child: ElevatedButton(
                  style: EvelatedButtonStyle.mainRounded,
                  onPressed: () {
                    CheckoutVoucherController.to.confirmVoucher();
                    Get.back();
                  },
                  child: Text('Oke')),
            )
          ],
        ),
      ),
    );
  }
}
