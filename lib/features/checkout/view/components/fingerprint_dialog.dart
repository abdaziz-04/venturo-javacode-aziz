import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:venturo_core/features/checkout/controllers/checkout_controller.dart';
import '../../../../shared/styles/color_style.dart';

class FingerprintDialog extends StatelessWidget {
  const FingerprintDialog({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: Colors.white,

      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16.r),
      ),
      // Isi dialog
      child: Padding(
        padding: EdgeInsets.all(20.r),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              'Verifikasi Pesanan'.tr,
              style: Get.textTheme.headline6?.copyWith(
                fontSize: 18.sp,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 8.h),
            Text(
              'Finger Print'.tr,
              style: Get.textTheme.bodyMedium?.copyWith(
                color: ColorStyle.black,
                fontSize: 14.sp,
              ),
            ),
            SizedBox(height: 20.h),
            GestureDetector(
              onTap: () {
                print('Fingerprint');
                CheckoutController.to.authenticate();
              },
              child: Icon(
                Icons.fingerprint,
                size: 130.r,
                color: ColorStyle.primary,
              ),
            ),
            SizedBox(height: 10.h),
            Text(
              'atau'.tr,
              style: TextStyle(
                color: ColorStyle.grey,
                fontSize: 14.sp,
              ),
            ),
            SizedBox(height: 10.h),
            TextButton(
              onPressed: () => Get.back<String>(result: 'pin'),
              child: Text(
                'Verifikasi Menggunakan PIN'.tr,
                style: TextStyle(
                  color: ColorStyle.primary,
                  fontSize: 14.sp,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
