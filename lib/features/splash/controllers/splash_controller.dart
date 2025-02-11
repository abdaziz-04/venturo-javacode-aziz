import 'package:get/get.dart';
import 'package:venturo_core/shared/controllers/global_controller.dart';

import '../../../configs/routes/route.dart';

class SplashController extends GetxController {
  static SplashController get to => Get.find();
  @override
  void onInit() {
    _navigateToProfile();

    super.onInit();
  }

  Future<void> _navigateToProfile() async {
    bool loggedIn = await GlobalController.isLoggedIn();
    Future.delayed(Duration(seconds: 2), () {
      if (loggedIn) {
        Get.offAllNamed(Routes.getLocationScreenRoute);
      } else {
        Get.offAllNamed(Routes.sigInRoute);
      }
    });
  }
}
