import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:venturo_core/features/order/controllers/order_controller.dart';
import 'package:venturo_core/features/order/view/components/date_picker.dart';
import 'package:venturo_core/features/order/view/components/drop_down_status.dart';
import 'package:venturo_core/features/order/view/components/history_detail_order_card.dart';
import 'package:venturo_core/features/order/view/components/no_data.dart';
import 'package:venturo_core/shared/styles/color_style.dart';

class HistoryScreen extends StatelessWidget {
  const HistoryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final OrderController orderController = OrderController.to;
    return Scaffold(
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            print('Status dipilih: ${OrderController.to.selectedStatus}, '
                'Tanggal dipilih: ${OrderController.to.selectedDate}');
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
            Obx(() {
              return orderController.historyOrders.isEmpty
                  ? NoData(
                      info: 'Sudah Pesan? Lacak pesananmu di sini.',
                    )
                  : Expanded(
                      child: Padding(
                        padding: EdgeInsets.symmetric(horizontal: 20.h),
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
            })
          ],
        ));
  }
}
