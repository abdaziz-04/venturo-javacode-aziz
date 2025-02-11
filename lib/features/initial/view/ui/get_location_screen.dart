import 'package:app_settings/app_settings.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../../../constants/cores/assets/image_constants.dart';
import '../../../../shared/controllers/initial_controller.dart';
import '../../../../shared/styles/color_style.dart';

class GetLocationScreen extends StatelessWidget {
  GetLocationScreen({super.key});

  final InitialController initialController = Get.put(InitialController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: WillPopScope(
        child: Container(
          alignment: Alignment.center,
          width: double.infinity,
          height: double.infinity,
          decoration: const BoxDecoration(
            image: DecorationImage(
              image: AssetImage(ImageConstants.bgPattern2),
              fit: BoxFit.fitHeight,
              alignment: Alignment.center,
            ),
          ),
          padding: EdgeInsets.symmetric(horizontal: 30.r),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                'Searching location...'.tr,
                style: Get.textTheme.titleLarge!
                    .copyWith(color: ColorStyle.dark.withOpacity(0.5)),
                textAlign: TextAlign.center,
              ),
              50.verticalSpacingRadius,
              Stack(
                children: [
                  Image.asset(
                    ImageConstants.iconLocation,
                    width: 190.r,
                  ),
                  Padding(
                    padding: EdgeInsets.all(70.r),
                    child: Icon(
                      Icons.location_pin,
                      size: 50.r,
                    ),
                  ),
                ],
              ),
              50.verticalSpacingRadius,
              Obx(() {
                final status = InitialController.to.statusLocation.value;
                if (status == 'error') {
                  return Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        InitialController.to.messageLocation.value,
                        style: Get.textTheme.titleLarge,
                        textAlign: TextAlign.center,
                      ),
                      24.verticalSpacingRadius,
                      ElevatedButton(
                        onPressed: () => AppSettings.openLocationSettings(),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.white,
                          elevation: 2,
                          padding: EdgeInsets.zero,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(24.r),
                          ),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Icon(Icons.settings, color: ColorStyle.dark),
                            16.horizontalSpaceRadius,
                            Text(
                              'Open settings'.tr,
                              style: Get.textTheme.bodySmall,
                            ),
                          ],
                        ),
                      ),
                    ],
                  );
                } else if (status == 'success') {
                  return Text(
                    InitialController.to.address.value!,
                    style: Get.textTheme.titleLarge,
                    textAlign: TextAlign.center,
                  );
                } else {
                  return const CircularProgressIndicator(
                    color: ColorStyle.primary,
                  );
                }
              }),
            ],
          ),
        ),
        onWillPop: () async => false,
      ),
    );
  }
}
