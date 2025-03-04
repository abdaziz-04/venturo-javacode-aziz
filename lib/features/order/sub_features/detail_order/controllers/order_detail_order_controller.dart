import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:get/get.dart';
import 'package:venturo_core/shared/styles/color_style.dart';

class OrderDetailOrderController extends GetxController {
  static OrderDetailOrderController get to => Get.find();
  RxInt totalHarga = 0.obs;
  RxMap<String, dynamic> order = <String, dynamic>{}.obs;

  @override
  void onInit() {
    super.onInit();
    final data = Get.arguments;
    getTotalPrice(data);
    order.value = data;
  }

  Future<void> cancelOrder(int id) async {
    var headers = {
      'token': 'ce7eaad890aa429494b00bf3019dfb4f2050958c',
      'Content-Type': 'application/json'
    };
    var dio = Dio();
    var response = await dio.request(
      'https://trainee.landa.id/javacode/order/batal/$id',
      options: Options(
        method: 'POST',
        headers: headers,
      ),
    );

    if (response.statusCode == 200) {
      print(json.encode(response.data));
      Get.back();
      Get.snackbar(
        "Berhasil",
        "Order berhasil dibatalkan",
        snackPosition: SnackPosition.TOP,
        backgroundColor: ColorStyle.primary,
        colorText: ColorStyle.white,
      );
    } else {
      print(response.statusMessage);
    }
  }

  int getTotalPrice(Map<String, dynamic> data) {
    totalHarga.value = 0;
    if (data['menu'] != null && data['menu'] is List) {
      for (var item in data['menu']) {
        final dynamic itemTotal = item['total'];

        if (itemTotal is int) {
          totalHarga += itemTotal;
        } else if (itemTotal is String) {
          totalHarga += int.tryParse(itemTotal) ?? 0;
        }
      }
    }
    print(totalHarga);

    return totalHarga.value;
  }
}
