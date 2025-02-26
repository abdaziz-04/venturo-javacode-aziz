import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:venturo_core/configs/routes/route.dart';
import '../../../../shared/styles/color_style.dart';

class OrderSuccessDialog extends StatelessWidget {
  const OrderSuccessDialog({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: Colors.white,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16.r),
      ),
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 15.r),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            28.verticalSpace,
            Icon(
              Icons.check_circle,
              size: 80.r,
              color: Theme.of(context).primaryColor,
            ),
            28.verticalSpace,
            Text(
              'Order is being prepared'.tr,
              style: Get.textTheme.headlineMedium?.copyWith(
                fontWeight: FontWeight.w400,
              ),
              textAlign: TextAlign.center,
            ),
            14.verticalSpace,
            Text.rich(
              TextSpan(
                children: [
                  TextSpan(
                    text: 'You can track your order in',
                    style: Get.textTheme.bodySmall!.copyWith(
                      color: Colors.black,
                    ),
                  ),
                  TextSpan(
                    text: ' ${'Order history'}',
                    style: Get.textTheme.bodySmall!.copyWith(
                      fontWeight: FontWeight.w800,
                      color: Colors.black,
                    ),
                  ),
                ],
              ),
              textAlign: TextAlign.center,
            ),
            14.verticalSpace,
            SizedBox(
              width: 168.w,
              child: ElevatedButton(
                onPressed: () {
                  Get.toNamed(Routes.orderRoute);
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Theme.of(context).primaryColor,
                  maximumSize: Size(1.sw, 56.h),
                  side: BorderSide(
                    color: Theme.of(context).primaryColorDark,
                  ),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(50.r),
                  ),
                  elevation: 2,
                  minimumSize: Size(1.sw, 56.h),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'Okay',
                      textAlign: TextAlign.center,
                      style: Get.textTheme.labelLarge?.copyWith(
                        fontWeight: FontWeight.w800,
                        fontSize: 14.sp,
                        color: ColorStyle.white,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            28.verticalSpace,
          ],
        ),
      ),
    );
  }
}
