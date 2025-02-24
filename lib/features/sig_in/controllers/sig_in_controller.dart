import 'package:dio/dio.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:panara_dialogs/panara_dialogs.dart';
import 'package:venturo_core/features/profile/controllers/profile_controller.dart';

import '../../../configs/routes/route.dart';
import '../../../constants/cores/api/api_constant.dart';
import '../../../shared/controllers/global_controller.dart';
import '../../../shared/styles/color_style.dart';
import '../../../shared/styles/google_text_style.dart';

class SigInController extends GetxController {
  static SigInController get to => Get.find();

  @override
  void onInit() {
    super.onInit();
    Get.put(ProfileController(), permanent: true);
  }

  var formKey = GlobalKey<FormState>();
  var emailCtrl = TextEditingController();
  var emailValue = "".obs;
  var passwordCtrl = TextEditingController();
  var passwordValue = "".obs;
  var isPassword = true.obs;
  var isRememberMe = false.obs;
  final Dio _dio = Dio();
  final box = Hive.box('venturo');

  // show password
  void showPassword() {
    if (isPassword.value == true) {
      isPassword.value = false;
    } else {
      isPassword.value = true;
    }
  }

  Future<void> loginApi(BuildContext context) async {
    final url = ApiConstant.apiLogin;
    try {
      final response = await _dio.post(url, data: {
        'email': emailCtrl.text,
        'password': passwordCtrl.text,
      });
      if (response.statusCode == 200) {
        final data = response.data['data'];
        final String token = response.data['data']['token'].toString();
        ProfileController.to.saveLoginData(data);

        box.put('token', response.data['data']['token'].toString());
        print('Token yang tersimpan: $token');

        Get.offAllNamed(Routes.getLocationScreenRoute);
        await GlobalController.setLoggedIn(true);
      } else {
        PanaraInfoDialog.show(context,
            title: 'Warning',
            buttonText: 'Coba Lagi',
            message: 'Email atau Password salah', onTapDismiss: () {
          Get.back();
        },
            panaraDialogType: PanaraDialogType.warning,
            barrierDismissible: false);
      }
    } catch (e) {
      print('Error: $e');
      PanaraInfoDialog.show(context,
          title: 'Warning',
          buttonText: 'Coba Lagi',
          message: 'Tidak dapat login', onTapDismiss: () {
        Get.back();
      }, panaraDialogType: PanaraDialogType.warning, barrierDismissible: false);
    }
  }

  signInWithGoogle(BuildContext context) async {
    try {
      final GoogleSignIn googleSignIn = GoogleSignIn();
      final GoogleSignInAccount? gUser = await googleSignIn.signIn();

      if (gUser == null) {
        PanaraInfoDialog.show(context,
            title: 'Warning',
            buttonText: 'Coba Lagi',
            message: 'Tidak ada akun google di perangkat', onTapDismiss: () {
          Get.back();
        },
            panaraDialogType: PanaraDialogType.warning,
            barrierDismissible: false);
        // gaada akun
        return;
      }

      final GoogleSignInAuthentication gAuth = await gUser.authentication;

      final credential = GoogleAuthProvider.credential(
        accessToken: gAuth.accessToken,
        idToken: gAuth.idToken,
      );

      await FirebaseAuth.instance.signInWithCredential(credential);

      // berhasil login
      Get.offAllNamed(Routes.getLocationScreenRoute);
      await GlobalController.setLoggedIn(true);
    } on FirebaseAuthException catch (e) {
      print('Error: $e');
    } catch (e) {
      print('Error: $e');
    }
  }

  // Submitted form val
  void validateForm(context) async {
    await GlobalController.to.checkConnection();

    var isValid = formKey.currentState!.validate();
    Get.focusScope!.unfocus();

    if (isValid && GlobalController.to.isConnect.value == true) {
      EasyLoading.show(
          status: 'Sedang diproses....',
          maskType: EasyLoadingMaskType.black,
          dismissOnTap: false);

      formKey.currentState!.save();
      if (emailCtrl.text == "admin@gmail.com" && passwordCtrl.text == "admin") {
        EasyLoading.dismiss();
        Get.offAllNamed(Routes.initial);
      } else {
        EasyLoading.dismiss();
        PanaraInfoDialog.show(context,
            title: 'Warning',
            buttonText: 'Coba Lagi',
            message: 'Email dan Password salah', onTapDismiss: () {
          Get.back();
        },
            panaraDialogType: PanaraDialogType.warning,
            barrierDismissible: false);
      }
    } else if (GlobalController.to.isConnect.value == false) {
      Get.toNamed(Routes.initial);
    }
  }

  void flavorSeting() async {
    Get.bottomSheet(
      Obx(
        () => Wrap(
          children: [
            Container(
              width: double.infinity.w,
              padding: EdgeInsets.symmetric(
                horizontal: 5.w,
                vertical: 5.h,
              ),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10.r),
                color: ColorStyle.white,
              ),
              child: Column(
                children: <Widget>[
                  ListTile(
                    onTap: () {
                      GlobalController.to.isStaging.value = false;
                      GlobalController.to.baseUrl = ApiConstant.production;
                    },
                    title: Text(
                      "Production",
                      style: GoogleTextStyle.fw400.copyWith(
                        color: GlobalController.to.isStaging.value == true
                            ? ColorStyle.black
                            : ColorStyle.primary,
                        fontSize: 14.sp,
                      ),
                    ),
                    trailing: GlobalController.to.isStaging.value == true
                        ? null
                        : Icon(
                            Icons.check,
                            color: ColorStyle.primary,
                            size: 14.sp,
                          ),
                  ),
                  Divider(
                    height: 1.h,
                  ),
                  ListTile(
                    onTap: () {
                      GlobalController.to.isStaging.value = true;
                      GlobalController.to.baseUrl = ApiConstant.staging;
                    },
                    title: Text(
                      "Staging",
                      style: GoogleTextStyle.fw400.copyWith(
                        color: GlobalController.to.isStaging.value == true
                            ? ColorStyle.primary
                            : ColorStyle.black,
                        fontSize: 14.sp,
                      ),
                    ),
                    trailing: GlobalController.to.isStaging.value == true
                        ? Icon(
                            Icons.check,
                            color: ColorStyle.primary,
                            size: 14.sp,
                          )
                        : null,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
