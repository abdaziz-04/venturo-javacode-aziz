import 'package:get/get.dart';
import 'package:venturo_core/features/checkout/controllers/checkout_controller.dart';

class ListBinding extends Bindings {
  @override
  void dependencies() {
    Get.put(CheckoutController());
  }
}
