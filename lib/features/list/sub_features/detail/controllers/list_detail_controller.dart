import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hive_flutter/hive_flutter.dart';

import '../../../controllers/list_controller.dart';

class ListDetailController extends GetxController {
  static ListDetailController get to => Get.find();
  late final TextEditingController notesController;
  final ListController listController = ListController.to;
  final RxList<Map<String, dynamic>> cartItem = <Map<String, dynamic>>[].obs;
  final RxMap<String, dynamic> selectedLevel = <String, dynamic>{}.obs;
  RxInt qty = 1.obs;
  final RxList<Map<String, dynamic>> selectedToppings =
      <Map<String, dynamic>>[].obs;
  RxString notes = ''.obs;
  RxInt price = 0.obs;

  final cart = Hive.box('cart');

  @override
  void onInit() {
    super.onInit();
    notesController = TextEditingController();
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

  void addNotes() {
    notes.value = notesController.text;
    print('📝 Catatan: ${notes.value};');
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
    final cartItem = {
      'id_menu': idMenu,
      'nama': listController.selectedMenuDetail['menu']['nama'],
      'foto': listController.selectedMenuDetail['menu']['foto'],
      'harga': price.value,
      'kategori': listController.selectedMenuDetail['menu']['kategori'],
      'level': selectedLevel['keterangan'],
      'topping':
          selectedToppings.map((topping) => topping['id_detail']).toList(),
      'jumlah': qty.value,
      'catatan': notes.value,
    };
    cart.add(cartItem);
    print('🛒 Berhasil ditambahkan $cartItem');
  }

  void deleteAllCart() {
    cart.clear();
    cartItem.clear();
    print('🛒 Berhasil menghapus semua item di keranjang');
  }

  void getCart() {
    cartItem.clear();
    for (var i = 0; i < cart.length; i++) {
      cartItem.add(Map<String, dynamic>.from(cart.getAt(i)));
    }
    print('🛒 Isi keranjang: $cartItem');
  }

  void removeFromCart(int id) {
    cart.deleteAt(id);
    print('🛒 Berhasil dihapus dari keranjang');
  }

  void printCartContents() {
    print('🛒 Isi keranjang:');
    for (var i = 0; i < cart.length; i++) {
      print(cart.getAt(i));
    }
  }
}
