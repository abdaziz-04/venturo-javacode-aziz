import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:venturo_core/configs/routes/route.dart';
import 'package:venturo_core/features/order/controllers/order_controller.dart';
import 'package:venturo_core/features/order/view/components/detail_order_card.dart';
import 'package:venturo_core/features/order/view/components/no_data.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

class OnGoingScreen extends StatelessWidget {
  OnGoingScreen({super.key});

  static FirebaseAnalytics analytics = FirebaseAnalytics.instance;

  @override
  Widget build(BuildContext context) {
    final OrderController orderController = OrderController.to;
    analytics.setCurrentScreen(
      screenName: 'Ongoing Order Screen',
      screenClassOverride: 'Trainee',
    );
    return Scaffold(
      body: orderController.ongoingOrders.isEmpty
          ? NoData(
              info: 'Sudah Pesan? Lacak pesananmu di sini.',
            )
          : Padding(
              padding: EdgeInsets.symmetric(horizontal: 20.h, vertical: 30.h),
              child: Column(
                children: [
                  Expanded(
                    child: SmartRefresher(
                      controller: orderController.oRefresh,
                      onRefresh: orderController.onGoingRefresh,
                      enablePullDown: true,
                      child: ListView.builder(
                        itemCount: orderController.ongoingOrders.length,
                        itemBuilder: (context, index) {
                          final order = orderController.ongoingOrders[index];
                          return Padding(
                            padding: EdgeInsets.symmetric(vertical: 10.h),
                            child: DetailOrderCard(
                              detailOrder: order,
                              onTap: () {
                                Get.toNamed(
                                  Routes.orderDetailRoute,
                                  arguments: order,
                                );
                                print('Detail order ${order}');
                              },
                            ),
                          );
                        },
                      ),
                    ),
                  ),
                ],
              ),
            ),
    );
  }
}
