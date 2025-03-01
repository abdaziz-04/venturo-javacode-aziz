import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:venturo_core/features/order/controllers/order_controller.dart';
import 'package:venturo_core/features/order/view/components/date_picker.dart';
import 'package:venturo_core/features/order/view/components/drop_down_status.dart';
import 'package:venturo_core/features/order/view/components/history_detail_order_card.dart';
import 'package:venturo_core/features/order/view/components/no_data.dart';
import 'package:venturo_core/shared/styles/color_style.dart';

class HistoryScreen extends StatelessWidget {
  const HistoryScreen({super.key});
  static FirebaseAnalytics analytics = FirebaseAnalytics.instance;

  @override
  Widget build(BuildContext context) {
    analytics.setCurrentScreen(
      screenName: 'History Order Screen',
      screenClassOverride: 'Trainee',
    );
    final OrderController orderController = OrderController.to;
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          print('Status dipilih: ${orderController.selectedStatus}, '
              'Tanggal dipilih: ${orderController.selectedDate}');
        },
        child: const Icon(Icons.bug_report),
      ),
      body: Column(
        children: [
          Container(
            color: ColorStyle.white,
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 20.h, vertical: 20.h),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  DropDownStatus(),
                  Obx(() => DatePicker(
                        onChanged: (newRange) =>
                            orderController.selectedDate.value = newRange,
                        selectedDate: orderController.selectedDate.value,
                      ))
                ],
              ),
            ),
          ),
          Expanded(
            child: Obx(() {
              return orderController.historyOrders.isEmpty
                  ? NoData(
                      info: 'Sudah Pesan? Lacak pesananmu di sini.',
                    )
                  : Padding(
                      padding: EdgeInsets.symmetric(horizontal: 20.h),
                      child: SmartRefresher(
                        controller: orderController.hRefresh,
                        onRefresh: orderController.historyRefresh,
                        enablePullDown: true,
                        child: ListView.builder(
                          itemCount: orderController.historyOrders.length,
                          itemBuilder: (context, index) {
                            final order = orderController.historyOrders[index];
                            final rxOrder = RxMap<String, dynamic>.from(order);
                            return Padding(
                              padding: EdgeInsets.symmetric(vertical: 10.h),
                              child: HistoryDetailOrderCard(rxOrder),
                            );
                          },
                        ),
                      ),
                    );
            }),
          )
        ],
      ),
    );
  }
}
