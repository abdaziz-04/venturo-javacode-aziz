import 'dart:io';

import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:venturo_core/shared/styles/color_style.dart';

import '../../../../configs/routes/route.dart';
import '../../../../constants/cores/assets/image_constants.dart';
import '../../../../shared/styles/elevated_button_style.dart';
import '../../../../shared/styles/google_text_style.dart';
import '../../../../shared/widgets/text_form_field_widget.dart';
import '../../constants/forgot_password_assets_constant.dart';
import '../../controllers/forgot_password_controller.dart';

class ForgotPasswordScreen extends StatelessWidget {
  ForgotPasswordScreen({Key? key}) : super(key: key);

  final assetsConstant = ForgotPasswordAssetsConstant();
  static FirebaseAnalytics analytics = FirebaseAnalytics.instance;

  @override
  Widget build(BuildContext context) {
    /// Google analytics untuk tracking user di setiap halaman
    if (Platform.isAndroid) {
      /// Tracking bawah dia masuk screen lupa password di device android
      analytics.setCurrentScreen(
        screenName: 'Forgot Password Screen',
        screenClassOverride: 'Android',
      );
    } else if (Platform.isIOS) {
      /// Tracking bawah dia masuk screen lupa password di device ios
      analytics.setCurrentScreen(
        screenName: 'Forgot Password Screen',
        screenClassOverride: 'IOS',
      );
    } else if (Platform.isMacOS) {
      /// Tracking bawah dia masuk screen lupa password di device macos
      analytics.setCurrentScreen(
        screenName: 'Forgot Password Screen',
        screenClassOverride: 'MacOS',
      );
    }

    if (kIsWeb) {
      /// Tracking bawah dia masuk screen lupa password di device web
      analytics.setCurrentScreen(
        screenName: 'Forgot Password Screen',
        screenClassOverride: 'Web',
      );
    }

    return Scaffold(
      appBar: null,
      extendBody: false,
      backgroundColor: ColorStyle.white,
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(45),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              SizedBox(height: 121.h),
              GestureDetector(
                child: Image.asset(
                  ImageConstants.logo,
                  fit: BoxFit.contain,
                ),
              ),
              SizedBox(height: 121.h),
              Text(
                'Masukkan alamat email untuk mengubah password anda',
                style: GoogleTextStyle.fw600.copyWith(
                  fontSize: 22.sp,
                  color: ColorStyle.black,
                ),
                textAlign: TextAlign.center,
              ),
              SizedBox(height: 40.h),
              Form(
                key: ForgotPasswordController.to.formKey,
                child: TextFormFieldWidget(
                  controller: ForgotPasswordController.to.emailCtrl,
                  keyboardType: TextInputType.emailAddress,
                  initialValue: ForgotPasswordController.to.emailValue.value,
                  label: "Email Address",
                  hint: "Input Email Address",
                  isRequired: true,
                  requiredText: "Email address cannot be empty",
                ),
              ),
              SizedBox(height: 40.h),
              ElevatedButton(
                style: EvelatedButtonStyle.mainRounded,
                onPressed: () {
                  Get.toNamed(Routes.otpRoute);
                },
                child: Text(
                  "Ubah Password",
                  style: GoogleTextStyle.fw800.copyWith(
                    fontSize: 14.sp,
                    color: ColorStyle.white,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
