import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:venturo_core/shared/styles/color_style.dart';

import '../../../../configs/routes/route.dart';
import '../../../../constants/cores/assets/image_constants.dart';
import '../../../../shared/controllers/global_controller.dart';
import '../../constants/no_connection_assets_constant.dart';

class NoConnectionScreen extends StatelessWidget {
  NoConnectionScreen({Key? key}) : super(key: key);

  final assetsConstant = NoConnectionAssetsConstant();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage(ImageConstants.bgPattern2),
            fit: BoxFit.cover,
          ),
        ),
        padding: EdgeInsets.symmetric(
          vertical: 35.h,
          horizontal: 35.w,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          mainAxisSize: MainAxisSize.max,
          children: [
            Icon(Icons.wifi_off, size: 100.r, color: ColorStyle.primary),
            SizedBox(height: 25.h),
            Text(
              "Oops Tidak ada koneksi internet",
              style: GoogleFonts.roboto(
                fontSize: 22.sp,
                fontWeight: FontWeight.w800,
                color: ColorStyle.primary,
              ),
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 10.h),
            Text(
              "Pastikan wifi atau data seluler terhubung, lalu tekan tombol coba lagi",
              style: GoogleFonts.roboto(
                fontSize: 18.sp,
                fontWeight: FontWeight.w400,
              ),
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 25.h),
            SizedBox(
              width: 150,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: ColorStyle.primary,
                  padding: const EdgeInsets.symmetric(
                    vertical: 20,
                  ),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(100.0),
                  ),
                ),
                onPressed: () {
                  GlobalController.to.checkConnection();
                  if (GlobalController.to.isConnect.value == true) {
                    Get.offNamed(Routes.homeRoute);
                  }
                },
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "Coba Lagi",
                      style: GoogleFonts.roboto(
                        fontSize: 18.sp,
                        fontWeight: FontWeight.w400,
                        color: Colors.white,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
