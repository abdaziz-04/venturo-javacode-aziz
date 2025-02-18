import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sentry_flutter/sentry_flutter.dart';
import 'package:venturo_core/features/order/repositories/order_repository.dart';

class OrderController extends GetxController {
  static OrderController get to => Get.find();
  late final OrderRepository _orderRepository;

  @override
  void onInit() {
    super.onInit();
    _orderRepository = OrderRepository();

    getOnGoingOrders();
    getOrderHistories();
  }

  RxList<Map<String, dynamic>> ongoingOrders = RxList();
  RxList<Map<String, dynamic>> historyOrders = RxList();

  RxString onGoingOrderState = 'loading'.obs;
  RxString orderHistoryState = 'loading'.obs;

  Rx<String> selectedCategory = 'all'.obs;

  Map<String, String> get dateFilterStatus => {
        'all': 'Semua',
        'completed': 'Selesai',
        'cancelled': 'Dibatalkan',
      };

  Rx<DateTimeRange> selectedDateRange = DateTimeRange(
    start: DateTime.now().subtract(const Duration(days: 30)),
    end: DateTime.now(),
  ).obs;

  Future<void> getOnGoingOrders() async {
    onGoingOrderState.value = 'loading';

    try {
      final result = _orderRepository.getOngoingOrder();
      final data = result.where((element) => element['status'] != 4).toList();
      ongoingOrders(data.reversed.toList());
      onGoingOrderState.value = 'success';
    } catch (exception, stacktrace) {
      await Sentry.captureException(
        exception,
        stackTrace: stacktrace,
      );

      onGoingOrderState.value = 'error';
    }
  }

  Future<void> getOrderHistories() async {
    orderHistoryState.value = 'loading';

    try {
      final result = _orderRepository.getOrderHistory();
      historyOrders(result.reversed.toList());
      orderHistoryState.value = 'success';
    } catch (exception, stacktrace) {
      await Sentry.captureException(
        exception,
        stackTrace: stacktrace,
      );

      orderHistoryState.value = 'error';
    }
  }

  void setDateFilter(String? category, DateTimeRange? dateRange) {
    selectedCategory(category);
    selectedDateRange(dateRange);
  }

  List<Map<String, dynamic>> get filteredHistoryOrders {
    final historyOrderList = historyOrders.toList();

    if (selectedCategory.value == 'canceled') {
      historyOrderList.removeWhere((element) => element['status'] != 4);
    } else if (selectedCategory.value == 'completed') {
      historyOrderList.removeWhere((element) => element['status'] != 3);
    }
    historyOrderList.removeWhere((element) =>
        DateTime.parse(element['tanggal'] as String)
            .isBefore(selectedDateRange.value.start) ||
        DateTime.parse(element['tanggal'] as String)
            .isAfter(selectedDateRange.value.end));

    historyOrderList.sort((a, b) => DateTime.parse(b['tanggal'] as String)
        .compareTo(DateTime.parse(a['tanggal'] as String)));

    return historyOrderList;
  }

  String get totalHistoryOrder {
    final total = filteredHistoryOrders.where((e) => e['status'] == 3).fold(
        0,
        (previousValue, element) =>
            previousValue + element['total_bayar'] as int);
    return total.toString();
  }
}
