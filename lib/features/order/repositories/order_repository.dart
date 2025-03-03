import 'package:dio/dio.dart';
import 'package:hive_flutter/hive_flutter.dart';

import '../constants/order_api_constant.dart';

class OrderRepository {
  OrderRepository();

  var apiConstant = OrderApiConstant();

  Future<String?> _getToken() async {
    final box = await Hive.openBox('user');
    final token = box.get('token', defaultValue: '');
    if (token.isEmpty) {
      print("⚠️ Token kosong! Coba login ulang.");
      return null;
    }
    return token;
  }

  Future<List<Map<String, dynamic>>> fetchOrders() async {
    final token = await _getToken();
    var headers = {
      'token': token,
      'Cookie': 'PHPSESSID=09362c16d891770e7f6303ab2e777dce'
    };

    var dio = Dio();

    final response = await dio.request(
      'https://trainee.landa.id/javacode/order/user/70',
      options: Options(
        method: 'GET',
        headers: headers,
      ),
      data: '',
    );

    if (response.statusCode == 200) {
      return List<Map<String, dynamic>>.from(response.data['data']);
    } else {
      throw Exception(response.statusMessage);
    }
  }

  var headers = {
    'token': 'ce7eaad890aa429494b00bf3019dfb4f2050958c',
    'Cookie': 'PHPSESSID=09362c16d891770e7f6303ab2e777dce'
  };

  Future<List<Map<String, dynamic>>> getOngoingOrder() async {
    final orders = await fetchOrders();

    return orders.where((element) => element['status'] <= 2).toList();
  }

  Future<List<Map<String, dynamic>>> getOrderHistory() async {
    final orders = await fetchOrders();
    return orders.where((element) => element['status'] >= 3).toList();
  }

  Future<Map<String, dynamic>?> getOrderDetail(int idOrder) async {
    final orders = await fetchOrders();
    try {
      return orders.firstWhere((element) => element['id_order'] == idOrder);
    } catch (_) {
      return null;
    }
  }
}
