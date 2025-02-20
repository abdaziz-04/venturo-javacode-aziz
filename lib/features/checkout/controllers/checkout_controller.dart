import 'package:get/get.dart';

import '../../list/sub_features/detail/controllers/list_detail_controller.dart';

class CheckoutController extends GetxController {
  static CheckoutController get to => Get.find();
  final RxInt totalPrice = 0.obs;
  final RxInt finalTotalPrice = 0.obs;
  final RxInt discount = 0.obs;
  final RxList<Map<String, dynamic>> cartItem = <Map<String, dynamic>>[].obs;

  @override
  void onInit() {
    super.onInit();
    Get.put(ListDetailController());
    getCart();
    calculateTotalPrice();
    calculateDiscount();
    calculateFinalTotalPrice();
  }

  void getCart() {
    cartItem.clear();
    cartItem.addAll(ListDetailController.to.cartItem);
    print('🛒 Isi keranjang dari co controller: $cartItem');
  }

  void calculateDiscount() {
    discount.value = (totalPrice.value * 0.2).toInt();
    print('💰 Diskon: ${discount.value}');
  }

  void calculateFinalTotalPrice() {
    finalTotalPrice.value = totalPrice.value - discount.value;
    print('💰 Total harga akhir: ${finalTotalPrice.value}');
  }

  void calculateTotalPrice() {
    totalPrice.value = cartItem.fold<int>(0,
        (previousValue, element) => previousValue + (element['harga'] as int));
    print('💰 Total harga: ${totalPrice.value}');
  }
}
