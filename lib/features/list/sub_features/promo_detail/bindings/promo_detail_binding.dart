import 'package:get/get.dart';

import '../controllers/list_promo_detail_controller.dart';

class PromoDetailBinding extends Bindings {
  @override
  void dependencies() {
    Get.put(ListPromoDetailController());
  }
}
