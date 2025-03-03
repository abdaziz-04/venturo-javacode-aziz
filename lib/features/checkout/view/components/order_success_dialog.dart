import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:venturo_core/configs/routes/route.dart';
import 'package:venturo_core/constants/cores/assets/image_constants.dart';
import 'package:venturo_core/features/checkout/controllers/checkout_controller.dart';
import 'package:venturo_core/features/list/sub_features/detail/controllers/list_detail_controller.dart';
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
      child: SizedBox(
        width: 300.w,
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 15.r),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              28.verticalSpace,
              Image.asset(
                ImageConstants.imgPan,
                width: 130.w,
              ),
              28.verticalSpace,
              Text(
                'Order is being prepared'.tr,
                style: TextStyle(
                  fontSize: 22.sp,
                ),
                textAlign: TextAlign.center,
              ),
              14.verticalSpace,
              Text.rich(
                TextSpan(
                  children: [
                    TextSpan(
                      text: 'You can track your order in',
                      style: TextStyle(
                        fontSize: 12.sp,
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
                    Get.offAllNamed(Routes.homeRoute,
                        arguments: {"tabIndex": 1});
                    CheckoutController.to.deleteAllCart();
                    ListDetailController.to.deleteAllCart();
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Theme.of(context).primaryColor,
                    maximumSize: Size(1.sw, 40.h),
                    side: BorderSide(
                      color: Theme.of(context).primaryColorDark,
                    ),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(50.r),
                    ),
                    elevation: 2,
                    minimumSize: Size(1.sw, 40.h),
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
      ),
    );
  }
}
