import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:sentry_flutter/sentry_flutter.dart';
import 'package:venturo_core/features/order/repositories/order_repository.dart';

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

      final List<Map<String, dynamic>> history =
          orders.where((order) => order['status'] >= 3).toList();

      if (selectedStatus.value == 'all') {
        historyOrders.assignAll(history);
        print('History Orders: $historyOrders');
      } else if (selectedStatus.value == 'completed') {
        historyOrders.assignAll(
          history.where((order) => order['status'] == 3).toList(),
        );
        print('History Orders: $historyOrders');
      } else if (selectedStatus.value == 'cancelled') {
        historyOrders.assignAll(
          history.where((order) => order['status'] == 4).toList(),
        );
        print('History Orders: $historyOrders');
      }
    } catch (e, s) {
      await Sentry.captureException(e, stackTrace: s);
      orderHistoryState.value = 'error';
    }
  }
}
