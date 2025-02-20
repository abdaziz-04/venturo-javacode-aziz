import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../../shared/styles/color_style.dart';
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

  void showDiscountDialog() {
    Get.defaultDialog(
      title: "Info Diskon",
      titleStyle: TextStyle(
        color: ColorStyle.primary,
        fontSize: 20.sp,
        fontWeight: FontWeight.bold,
      ),
      middleText: "Kamu mendapatkan diskon Rp. ${discount.value}!",
      buttonColor: ColorStyle.primary,
      confirm: SizedBox(
        width: 150.w,
        child: ElevatedButton(
          onPressed: () {
            Get.back();
          },
          child: Text("Oke", style: TextStyle(color: ColorStyle.white)),
          style: ElevatedButton.styleFrom(
            backgroundColor: ColorStyle.primary,
          ),
        ),
      ),
    );
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
