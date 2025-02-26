import 'package:get/get.dart';
import 'package:hive_flutter/hive_flutter.dart';

import '../../../controllers/list_controller.dart';

class ListDetailController extends GetxController {
  static ListDetailController get to => Get.find();
  final ListController listController = ListController.to;
  RxInt qty = 1.obs;
  RxList<Map<String, dynamic>> cartItem = <Map<String, dynamic>>[].obs;
  final RxMap<String, dynamic> selectedLevel = <String, dynamic>{}.obs;
  final RxList<Map<String, dynamic>> selectedToppings =
      <Map<String, dynamic>>[].obs;

  // final cart = Hive.box('cart');
  RxInt price = 0.obs;

  @override
  void onInit() {
    super.onInit();
    final arguments = Get.arguments;
    print('ListDetailController.onInit() - Arguments: $arguments');
    if (arguments != null) {
      listController.getDetailMenu(arguments);
    } else {
      print('Argument tidak valid atau tidak mengandung id_menu.');
    }
    getCart();
    ever(listController.selectedMenuDetail, (_) {
      if (listController.selectedMenuDetail['menu'] != null) {
        price.value = listController.selectedMenuDetail['menu']['harga'];
        print('Default price di-set: ${price.value}');
      }
    });
  }

  void addLevel(Map<String, dynamic> level) {
    selectedLevel.value = level;
    print('👌Selected level: $level');
  }

  void addTopping(Map<String, dynamic> topping) {
    if (!selectedToppings.any((element) => element['id'] == topping['id'])) {
      selectedToppings.add(topping);
    }
    print('👌 Selected toppings: $selectedToppings');
  }

  void getPrice() {
    int basePrice = listController.selectedMenuDetail['menu']['harga'] ?? 0;

    int levelPrice = selectedLevel['harga'] ?? 0;

    int toppingPrice = selectedToppings.fold<int>(
      0,
      (prev, element) => prev + (element['harga'] as int? ?? 0),
    );
    price.value = (basePrice + levelPrice + toppingPrice) * qty.value;
    print('💰 Harga: ${price.value}');
  }

  void addToCart(int idMenu) {
    final cartItems = {
      'id_menu': idMenu,
      'nama': listController.selectedMenuDetail['menu']['nama'],
      'foto': listController.selectedMenuDetail['menu']['foto'],
      'harga': price.value,
      'kategori': listController.selectedMenuDetail['menu']['kategori'],
      'level': selectedLevel['keterangan'],
      'topping':
          selectedToppings.map((topping) => topping['id_detail']).toList(),
      'jumlah': qty.value,
    };
    cartItem.add(cartItems);
    print('🛒 Berhasil ditambahkan $cartItem');
  }

  void deleteAllCart() {
    cartItem.clear();
    cartItem.clear();
    print('🛒 Berhasil menghapus semua item di keranjang');
  }

  void getCart() {
    cartItem.clear();
    for (var i = 0; i < cartItem.length; i++) {
      cartItem.add(Map<String, dynamic>.from(cartItem[i]));
    }
    print('🛒 Isi keranjang: $cartItem');
  }

  void removeFromCart(int id) {
    cartItem.removeAt(id);
    print('🛒 Berhasil dihapus dari keranjang $id');
  }
}
