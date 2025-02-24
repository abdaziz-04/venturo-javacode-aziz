import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:venturo_core/shared/models/user_model.dart';

import '../../../configs/routes/route.dart';
import 'package:device_information/device_information.dart';

import '../../../shared/controllers/global_controller.dart';

class ProfileController extends GetxController {
  static ProfileController get to => Get.find();

  var productName = ''.obs;
  var apiLevel = ''.obs;
  Rxn<UserModel> user = Rxn<UserModel>();
  RxnString token = RxnString();
  Rxn<Map<String, dynamic>> loginData = Rxn<Map<String, dynamic>>();

  @override
  void onInit() {
    super.onInit();
    getDeviceInfo();
  }

  // Simpan data login
  void saveLoginData(Map<String, dynamic> data) {
    loginData.value = data;
    try {
      final parsedUser = UserModel.fromJson(data);
      user.value = parsedUser;
      token.value = parsedUser.token;
      print(
          "🧑‍💻 Login Success, user: ${user.value?.user.email}, token: ${token.value}, semua data: ${loginData.value}");
    } catch (e) {
      print("Error menyimpan data login: $e");
    }
  }

  // Logout
  void logout() async {
    await FirebaseAuth.instance.signOut();
    await GlobalController.setLoggedIn(false);
    final box = Hive.box('venturo');
    await box.delete('token');
    print('Token dihapus');

    Get.offAllNamed(Routes.sigInRoute);
  }

  void privacyPolicyWebView() {
    Get.toNamed(Routes.privacyPolicy);
  }

  void getDeviceInfo() async {
    try {
      var fetchedProductName = await DeviceInformation.productName;
      var fetchedApiLevel = await DeviceInformation.platformVersion;

      productName.value = fetchedProductName;
      apiLevel.value = fetchedApiLevel;
    } catch (e) {
      _showErrorSnackbar('Error', 'Terjadi kesalahan: $e');
    }
  }

  void _showErrorSnackbar(String title, String message) {
    Get.snackbar(
      title,
      message,
      snackPosition: SnackPosition.BOTTOM,
      backgroundColor: Colors.red,
      colorText: Colors.white,
      icon: Icon(Icons.error, color: Colors.white),
    );
  }
}
