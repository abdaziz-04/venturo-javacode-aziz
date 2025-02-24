import 'package:get/get.dart';
import 'package:venturo_core/features/checkout/sub_features/voucher/controllers/checkout_voucher_controller.dart';
import 'package:venturo_core/features/list/sub_features/detail/controllers/list_detail_controller.dart';

import '../controllers/checkout_controller.dart';

class CheckoutBinding extends Bindings {
  @override
  void dependencies() {
    Get.put(CheckoutController());
    Get.put(ListDetailController());
    Get.put(CheckoutVoucherController());
  }
}
