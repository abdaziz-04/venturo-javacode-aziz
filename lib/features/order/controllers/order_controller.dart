import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:local_auth/local_auth.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:sentry_flutter/sentry_flutter.dart';
import 'package:venturo_core/features/checkout/controllers/checkout_controller.dart';
import 'package:venturo_core/features/order/repositories/order_repository.dart';
import 'package:venturo_core/features/profile/controllers/profile_controller.dart';

class OrderController extends GetxController {
  static OrderController get to => Get.find();
  late final OrderRepository _orderRepository;

  var selectedTabIndex = 0.obs;

  RxList<Map<String, dynamic>> ongoingOrders = RxList();
  RxList<Map<String, dynamic>> historyOrders = RxList();

  RxString onGoingOrderState = 'loading'.obs;
  RxString orderHistoryState = 'loading'.obs;

  final RefreshController oRefresh = RefreshController(initialRefresh: false);
  final RefreshController hRefresh = RefreshController(initialRefresh: false);

  final Rx<DateTimeRange> selectedDate = DateTimeRange(
    start: DateTime.now().subtract(const Duration(days: 7)),
    end: DateTime.now(),
  ).obs;

  final _auth = LocalAuthentication();

  RxString selectedStatus = 'all'.obs;

  Map<String, String> get dateFilterStatus => {
        'all': 'Semua Status',
        'completed': 'Selesai',
        'cancelled': 'Dibatalkan',
      };

  @override
  void onInit() {
    super.onInit();
    _orderRepository = OrderRepository();
    getOnGoingOrders();
    getOrderHistories();
  }

  Future<bool> hasBiometrics() async {
    final isAvailable = await _auth.canCheckBiometrics;
    final isDeviceSupported = await _auth.isDeviceSupported();
    return isAvailable && isDeviceSupported;
  }

  Future<bool> authOrderAgain(
      {required int potongan,
      required List<Map<String, dynamic>> cartItem,
      required int finalTotalPrice}) async {
    final isAuthAvailable = await hasBiometrics();
    if (!isAuthAvailable) {
      print('Biometrics not available or device not supported');
      return false;
    }
    try {
      final isAuthenticated = await _auth.authenticate(
          localizedReason: 'Touch your finger on the sensor to login');
      if (isAuthenticated) {
        print('🔒 Berhasil terautentikasi');
        print('Placing order with details:');
        print(
            'User ID: ${ProfileController.to.loginData[0]['user']?['id_user']}');
        print('Potongan: $potongan');
        print('Cart Items: $cartItem');
        print('Final Total Price: $finalTotalPrice');
        CheckoutController.to.placeOrder(
            idUser: ProfileController.to.loginData[0]['id_user'],
            potongan: potongan,
            cartItems: cartItem,
            finalTotalPrice: finalTotalPrice);
      } else {
        print('Authentication failed');
      }
      return isAuthenticated;
    } catch (e) {
      print('Error during authentication: $e');
      return false;
    }
  }

  void historyRefresh() async {
    try {
      await getOrderHistories();
    } finally {
      hRefresh.refreshCompleted();
    }
  }

  void onGoingRefresh() async {
    try {
      await getOnGoingOrders();
    } finally {
      oRefresh.refreshCompleted();
    }
  }

  Future<void> getOnGoingOrders() async {
    onGoingOrderState.value = 'loading';
    try {
      final orders = await _orderRepository.fetchOrders();
      final filtered = orders.where((order) => order['status'] < 3).toList();
      ongoingOrders.assignAll(filtered.reversed.toList());
      onGoingOrderState.value = 'success';
      print('Ongoing Orders: $ongoingOrders');
    } catch (e, s) {
      await Sentry.captureException(e, stackTrace: s);
      onGoingOrderState.value = 'error';
      print('Error: $e');
    }
  }

  Future<void> getOrderHistories() async {
    orderHistoryState.value = 'loading';
    try {
      final orders = await _orderRepository.fetchOrders();
      final filtered = orders.where((order) => order['status'] >= 3).toList();
      historyOrders.assignAll(filtered.reversed.toList());
      orderHistoryState.value = 'success';
      print('History Orders: $historyOrders');
    } catch (e, s) {
      await Sentry.captureException(e, stackTrace: s);
      orderHistoryState.value = 'error';
    }
  }

  Future<void> updateFilteredHistoryOrders() async {
    try {
      final orders = await _orderRepository.fetchOrders();

      List<Map<String, dynamic>> filteredOrders =
          orders.where((order) => order['status'] >= 3).toList();

      if (selectedStatus.value == 'completed') {
        filteredOrders =
            filteredOrders.where((order) => order['status'] == 3).toList();
      } else if (selectedStatus.value == 'cancelled') {
        filteredOrders =
            filteredOrders.where((order) => order['status'] == 4).toList();
      }

      if (selectedDate.value != null) {
        filteredOrders = filteredOrders.where((order) {
          final orderDate = DateTime.parse(order['tanggal'] as String);
          return !orderDate.isBefore(selectedDate.value.start) &&
              !orderDate.isAfter(selectedDate.value.end);
        }).toList();
      }

      historyOrders.assignAll(filteredOrders);
      print('Filtered History Orders: $historyOrders');
    } catch (e, s) {
      await Sentry.captureException(e, stackTrace: s);
      orderHistoryState.value = 'error';
    }
  }
}
