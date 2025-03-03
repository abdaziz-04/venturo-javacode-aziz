import 'package:get/get.dart';

import '../../profile/controllers/profile_controller.dart';

class HomeController extends GetxController {
  static HomeController get to => Get.find();

  var tabIndex = 0.obs;

  final ProfileController profileController = Get.put(ProfileController());

  void changeTabIndex(int index) {
    tabIndex.value = index;
  }

  @override
  void onInit() {
    super.onInit();
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void dispose() {
    super.dispose();
  }
}
