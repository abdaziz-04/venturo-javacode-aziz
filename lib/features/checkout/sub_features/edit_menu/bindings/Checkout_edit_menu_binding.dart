import 'package:get/get.dart';
import 'package:venturo_core/features/checkout/sub_features/edit_menu/controllers/checkout_edit_menu_controller.dart';

class CheckoutEditMenuBinding extends Bindings {
  @override
  void dependencies() {
    Get.put(CheckoutEditMenuController());
  }
}
