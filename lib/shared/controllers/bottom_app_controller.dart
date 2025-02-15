import 'package:get/get.dart';
import 'package:venturo_core/configs/routes/route.dart';

class BottomAppController extends GetxController {
  static BottomAppController get to => Get.find<BottomAppController>();
  final selectedIndex = 0.obs;

  void changeIndex(int index) {
    selectedIndex.value = index;

    switch (index) {
      case 0:
        Get.toNamed(Routes.listRoute);
        break;
      case 1:
        // Get.toNamed(Routes.orderRoute);
        break;
      case 2:
        Get.toNamed(Routes.profileRoute);
        break;
      default:
        break;
    }
  }
}
