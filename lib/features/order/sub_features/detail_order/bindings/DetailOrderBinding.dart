import 'package:get/get.dart';
import 'package:venturo_core/features/order/sub_features/detail_order/controllers/order_detail_order_controller.dart';

class DetailOrderBinding extends Bindings {
  void dependencies() {
    Get.lazyPut<OrderDetailOrderController>(() => OrderDetailOrderController());
  }
}
