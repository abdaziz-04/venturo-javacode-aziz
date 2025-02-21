import 'package:get/get.dart';
import 'package:venturo_core/features/list/sub_features/detail/controllers/list_detail_controller.dart';

class CheckoutEditMenuController extends GetxController {
  static CheckoutEditMenuController get to => Get.find();
  final ListDetailController detailController = ListDetailController.to;
  RxInt qty = 1.obs;

  @override
  void onInit() {
    super.onInit();
    //  ever(detailController.selectedMenuDetail, (_) {
    //   if (detailController.selectedMenuDetail['menu'] != null) {
    //     price.value = detailController.selectedMenuDetail['menu']['harga'];
    //     print('Default price di-set: ${price.value}');
    //   }
    // });
  }

  void qtyIncrement() {
    qty.value++;
    print('🛒 Jumlah item: ${qty.value}');
  }

  void qtyDecrement() {
    if (qty.value > 1) {
      qty.value--;
      print('🛒 Jumlah item: ${qty.value}');
    }
  }
}
