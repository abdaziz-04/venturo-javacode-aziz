import 'package:get/get.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:venturo_core/features/list/sub_features/detail/controllers/list_detail_controller.dart';

class CheckoutEditMenuController extends GetxController {
  static CheckoutEditMenuController get to => Get.find();
  final ListDetailController detailController = ListDetailController.to;
  RxInt qty = 1.obs;
  final RxList<Map<String, dynamic>> cartItem = <Map<String, dynamic>>[].obs;
  final cart = Hive.box('cart');

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

  void updateCartItemJumlah(String itemKey, int newJumlah) {
    // Ambil data item dari Hive
    final Map<String, dynamic>? currentItem = cart.get(itemKey);
    if (currentItem != null) {
      // Update field 'jumlah'
      currentItem['jumlah'] = newJumlah;
      // Simpan kembali data yang sudah diupdate ke Hive
      cart.put(itemKey, currentItem);
      print('Cart item dengan key $itemKey diupdate dengan jumlah: $newJumlah');
    } else {
      print('Cart item dengan key $itemKey tidak ditemukan.');
    }
  }

  void getCart() {
    cartItem.clear();
    cartItem.addAll(cart.values.cast<Map<String, dynamic>>());
    print('🛒 Isi keranjang dari co controller: $cartItem');
  }

  void editCartItem(String key, dynamic newValue) {
    cart.put(key, newValue);
    print('Item with key $key has been updated to $newValue');
  }

  void printCartContents() {
    final cartContents = cart.toMap();
    print(cartContents);
  }

  void qtyIncrement() {
    qty.value++;
    print('🛒 Jumlah item: ${qty.value}');
    updateCartItemJumlah('jumlah', qty.value);
  }

  void qtyDecrement() {
    if (qty.value > 1) {
      qty.value--;
      print('🛒 Jumlah item: ${qty.value}');
      updateCartItemJumlah('jumlah', qty.value);
    }
  }
}
