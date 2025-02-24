import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:venturo_core/features/order/controllers/order_controller.dart';
import 'package:venturo_core/features/order/view/components/order_app_bar.dart';
import 'package:venturo_core/features/order/view/ui/history_screen.dart';

import '../../constants/order_assets_constant.dart';
import 'ongoing_screen.dart';

class OrderScreen extends StatelessWidget {
  OrderScreen({Key? key}) : super(key: key);

  final assetsConstant = OrderAssetsConstant();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: OrderAppBar(),
        body: Obx(() => IndexedStack(
              index: OrderController.to.selectedTabIndex.value,
              children: [
                OnGoingScreen(),
                HistoryScreen(),
              ],
            )));
  }
}
