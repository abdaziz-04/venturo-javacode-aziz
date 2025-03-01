import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_rx/get_rx.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:venturo_core/shared/models/user_model.dart';

import '../../../configs/routes/route.dart';
import 'package:device_information/device_information.dart';

import '../../../shared/controllers/global_controller.dart';

class ProfileController extends GetxController {
  static ProfileController get to => Get.find();

  var productName = ''.obs;
  var apiLevel = ''.obs;
  // Rxn<UserModel> user = Rxn<UserModel>();
  RxnString token = RxnString();
  RxList<Map<String, dynamic>> loginData = RxList<Map<String, dynamic>>();
  final userData = Hive.box('user');

  @override
  void onInit() {
    super.onInit();
    getDeviceInfo();
    getUser();
  }

  void getUser() {
    final data = userData.get('user');
    if (data != null && data is Map) {
      loginData.value = [Map<String, dynamic>.from(data)];
      print('Data user: ${loginData}');
    } else {
      print("Data user tidak ditemukan atau tidak sesuai format: $data");
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
