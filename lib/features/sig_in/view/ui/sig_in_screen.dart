import 'package:auth_buttons/auth_buttons.dart';
import 'package:firebase_analytics/firebase_analytics.dart';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../../../configs/routes/route.dart';
import '../../../../constants/cores/assets/image_constants.dart';
import '../../../../shared/styles/color_style.dart';
import '../../../../shared/styles/elevated_button_style.dart';
import '../../../../shared/styles/google_text_style.dart';
import '../../constants/sig_in_assets_constant.dart';
import '../../controllers/sig_in_controller.dart';
import '../components/form_signin_component.dart';

class SigIScreen extends StatelessWidget {
  SigIScreen({Key? key}) : super(key: key);
  static FirebaseAnalytics analytics = FirebaseAnalytics.instance;

  final assetsConstant = SigInAssetsConstant();
  final SigInController sc = Get.put(SigInController());
  @override
  Widget build(BuildContext context) {
    analytics.setCurrentScreen(
      screenName: 'Sign In Screen',
      screenClassOverride: 'Android',
    );
    return Scaffold(
      appBar: null,
      extendBody: false,
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(45),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              SizedBox(height: 100.h),
              GestureDetector(
                onDoubleTap: () => SigInController.to.flavorSeting(),
                child: Image.asset(
                  ImageConstants.logo,
                  fit: BoxFit.contain,
                ),
              ),
              SizedBox(height: 90.h),
              Text(
                'Masuk untuk melanjutkan!',
                style: GoogleTextStyle.fw600.copyWith(
                  fontSize: 22.sp,
                  color: Colors.black,
                ),
                textAlign: TextAlign.center,
              ),
              SizedBox(height: 20.h),
              const FormSignInComponent(),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  TextButton(
                    onPressed: () {
                      Get.toNamed(Routes.forgotPasswordRoute);
                    },
                    child: const Text(
                      'Lupa Password?',
                      style: TextStyle(color: ColorStyle.primary),
                    ),
                  ),
                ],
              ),
              ElevatedButton(
                style: EvelatedButtonStyle.mainRounded,
                onPressed: () => SigInController.to.loginApi(context),
                child: Text(
                  "Masuk",
                  style: GoogleTextStyle.fw800.copyWith(
                    fontSize: 14.sp,
                    color: Colors.white,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
              SizedBox(height: 30.h),
              Text(
                'Atau',
                textAlign: TextAlign.center,
              ),
              SizedBox(height: 20.h),
              GoogleAuthButton(
                style: const AuthButtonStyle(
                  width: 180,
                  height: 50,
                  borderRadius: 100,
                  iconSize: 24,
                ),
                text: 'Masuk dengan Google',
                onPressed: () async {
                  SigInController.to.signInWithGoogle(context);
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
