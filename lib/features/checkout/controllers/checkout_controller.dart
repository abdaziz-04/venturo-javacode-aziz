import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:venturo_core/features/checkout/view/components/fingerprint_dialog.dart';

import '../../../shared/styles/color_style.dart';
import '../../list/sub_features/detail/controllers/list_detail_controller.dart';

class CheckoutController extends GetxController {
  static CheckoutController get to => Get.find();
  final RxInt totalPrice = 0.obs;
  final RxInt finalTotalPrice = 0.obs;
  final RxInt discount = 0.obs;
  final RxInt voucherPrice = 0.obs;

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

  Map<String, dynamic> prepareOrderPayload({
    required int idUser,
    required int? idVoucher,
    required int potongan,
    required int totalBayar,
    required List<Map<String, dynamic>> cartItems,
  }) {
    List<Map<String, dynamic>> orderItems = cartItems.map((item) {
      return {
        "id_menu": item["id_menu"],
        "harga": item["harga"],
        "level": item["level"] ?? 0,
        "topping": item["topping"] ?? [],
        "jumlah": item["quantity"],
      };
    }).toList();

    return {
      "order": {
        "id_user": idUser,
        "id_voucher": idVoucher ?? 0,
        "potongan": potongan,
        "total_bayar": totalBayar,
      },
      "menu": orderItems,
    };
  }

  Future<void> placeOrder({
    required int idUser,
    required int? idVoucher,
    required int potongan,
    required List<Map<String, dynamic>> cartItems,
  }) async {
    final Dio dio = Dio();

    final payload = prepareOrderPayload(
      idUser: idUser,
      idVoucher: idVoucher,
      potongan: potongan,
      totalBayar: finalTotalPrice.value,
      cartItems: cartItems,
    );

    try {
      final response = await dio.post(
        "https://api.yourserver.com/order", // Ganti dengan URL API order Anda
        data: payload,
      );
      if (response.statusCode == 200) {
        print("Order berhasil: ${response.data}");
      } else {
        print("Order gagal: ${response.statusCode}");
      }
    } catch (e) {
      print("Error saat melakukan order: $e");
    }
  }

  void showFingerprintDialog() async {
    final result = await Get.dialog<String>(const FingerprintDialog());
    print("Result: $result");
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

  void addVoucher(int voucher) {
    voucherPrice.value = voucher;
    print('🎟️ Voucher: $voucher');
    calculateFinalTotalPrice();
  }

  void calculateDiscount() {
    discount.value = (totalPrice.value * 0.2).toInt();
    print('💰 Diskon: ${discount.value}');
  }

  void calculateFinalTotalPrice() {
    finalTotalPrice.value =
        totalPrice.value - discount.value - voucherPrice.value;
    if (finalTotalPrice.value < 0) {
      finalTotalPrice.value = 0;
    }
    print('💰 Total harga akhir: ${finalTotalPrice.value}');
  }

  void calculateTotalPrice() {
    totalPrice.value = cartItem.fold<int>(0,
        (previousValue, element) => previousValue + (element['harga'] as int));
    print('💰 Total harga: ${totalPrice.value}');
  }
}
