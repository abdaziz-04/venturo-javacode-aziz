import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:image_picker/image_picker.dart';
import 'package:venturo_core/shared/styles/color_style.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:venturo_core/shared/widgets/image_picker_dialog.dart';

import '../../../configs/routes/route.dart';
import 'package:device_information/device_information.dart';

import '../../../shared/controllers/global_controller.dart';

class ProfileController extends GetxController {
  static ProfileController get to => Get.find();
  late final TextEditingController nameController;
  late final TextEditingController emailController;
  late final TextEditingController phoneController;
  late final TextEditingController pinController;

  var productName = ''.obs;
  var apiLevel = ''.obs;
  RxnString token = RxnString();
  RxList<Map<String, dynamic>> loginData = RxList<Map<String, dynamic>>();
  final userData = Hive.box('user');
  final Rx<File?> _imageFile = Rx<File?>(null);
  RxString nama = ''.obs;
  RxString email = ''.obs;
  RxString phone = ''.obs;
  RxString pin = ''.obs;
  Rx<DateTime?> selectedDate = Rx<DateTime?>(null);

  File? get imageFile => _imageFile.value;

  @override
  void onInit() {
    super.onInit();
    getDeviceInfo();
    nameController = TextEditingController();
    emailController = TextEditingController();
    phoneController = TextEditingController();
    pinController = TextEditingController();
    getUser();
  }

  Future<void> selectDate(BuildContext context) async {
    final DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: selectedDate.value ?? DateTime.now(),
      firstDate: DateTime(1965),
      lastDate: DateTime.now(),
    );
    if (pickedDate != null) {
      selectedDate.value = pickedDate;
    }
  }

  void changeName() {
    nama.value = nameController.text;
    print('Nama: ${nama.value}');
  }

  void changeEmail() {
    email.value = emailController.text;
    print('Email: ${email.value}');
  }

  void changePhone() {
    phone.value = phoneController.text;
    print('Phone: ${phone.value}');
  }

  void changePin() {
    pin.value = pinController.text;
    print('Pin: ${pin.value}');
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
    await userData.clear();

    Get.offAllNamed(Routes.sigInRoute);
  }

  Future<void> pickImage() async {
    try {
      ImageSource? imageSource = await Get.defaultDialog(
        title: '',
        titleStyle: const TextStyle(fontSize: 0),
        content: const ImagePickerDialog(),
      );

      if (imageSource == null) return;

      final pickedFile = await ImagePicker().pickImage(
        source: imageSource,
        maxWidth: 300,
        maxHeight: 300,
        imageQuality: 75,
      );

      if (pickedFile != null) {
        _imageFile.value = File(pickedFile.path);
        final croppedFile = await ImageCropper().cropImage(
          sourcePath: _imageFile.value!.path,
          aspectRatio: CropAspectRatio(ratioX: 1.0, ratioY: 1.0),
          uiSettings: [
            AndroidUiSettings(
              toolbarTitle: 'Cropper'.tr,
              toolbarColor: ColorStyle.primary,
              toolbarWidgetColor: Colors.white,
              initAspectRatio: CropAspectRatioPreset.square,
              lockAspectRatio: true,
            )
          ],
        );

        if (croppedFile != null) {
          _imageFile.value = File(croppedFile.path);
        }
      }
    } catch (e, stacktrace) {
      print("Error saat memilih gambar: $e");
      print("Stacktrace: $stacktrace");
    }
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
