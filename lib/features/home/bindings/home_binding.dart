import 'package:get/get.dart';
import 'package:venturo_core/features/order/controllers/order_controller.dart';

import '../controllers/home_controller.dart';

class HomeBinding extends Bindings {
  @override
  void dependencies() {
    Get.put(HomeController());
    Get.put(OrderController());
  }
}
