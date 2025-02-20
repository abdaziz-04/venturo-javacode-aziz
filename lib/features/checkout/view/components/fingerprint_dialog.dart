import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:get/get_utils/get_utils.dart';

import '../../../../shared/styles/color_style.dart';

class FingerprintDialog extends StatelessWidget {
  const FingerprintDialog({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 15.w),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          // title
          Text(
            'Verify order'.tr,
            style: Get.textTheme.headlineMedium,
          ),
          // subtitle
          Text(
            'Press your fingerprint'.tr,
            style: Get.textTheme.bodySmall!.copyWith(color: ColorStyle.black),
          ),

          30.verticalSpacingRadius,

          // fingerprint icon
          GestureDetector(
            child: Icon(Icons.fingerprint,
                size: 80.r, color: Theme.of(context).primaryColor),
            onTap: () => Get.back<String>(result: 'fingerprint'),
          ),

          30.verticalSpacingRadius,

          // verify using pin code
          TextButton(
            onPressed: () => Get.back<String>(result: 'pin'),
            child: Text(
              'Verify using PIN code',
              style: Get.textTheme.titleSmall!
                  .copyWith(color: Theme.of(context).primaryColor),
            ),
          ),
        ],
      ),
    );
  }
}
