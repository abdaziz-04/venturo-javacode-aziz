import 'package:flutter/material.dart';
import 'package:flutter_conditional_rendering/conditional.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../controllers/order_detail_order_controller.dart';
import 'checked_step.dart';
import 'unchecked_step.dart';

class OrderTracker extends StatelessWidget {
  const OrderTracker({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 16.h),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Pesanan kamu sedang disiapkan:',
            style: TextStyle(
              fontSize: 18.sp,
              fontWeight: FontWeight.bold,
            ),
            textAlign: TextAlign.left,
          ),
          18.verticalSpace,
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Spacer(flex: 10),
              Expanded(
                flex: 10,
                child: Conditional.single(
                  context: context,
                  conditionBuilder: (context) =>
                      OrderDetailOrderController.to.order['status'] >= 0,
                  widgetBuilder: (context) => const CheckedStep(),
                  fallbackBuilder: (context) => const UncheckedStep(),
                ),
              ),
              Expanded(
                flex: 35,
                child: Container(
                  height: 2.h,
                  color: OrderDetailOrderController.to.order['status'] >= 1
                      ? Get.theme.primaryColor
                      : Colors.grey,
                ),
              ),
              Expanded(
                flex: 10,
                child: Conditional.single(
                  context: context,
                  conditionBuilder: (context) =>
                      OrderDetailOrderController.to.order['status'] >= 1,
                  widgetBuilder: (context) => const CheckedStep(),
                  fallbackBuilder: (context) => const UncheckedStep(),
                ),
              ),
              Expanded(
                flex: 35,
                child: Container(
                  height: 2.h,
                  color: OrderDetailOrderController.to.order['status'] >= 2
                      ? Get.theme.primaryColor
                      : Colors.grey,
                ),
              ),
              Expanded(
                flex: 10,
                child: Conditional.single(
                  context: context,
                  conditionBuilder: (context) =>
                      OrderDetailOrderController.to.order['status'] >= 2,
                  widgetBuilder: (context) => const CheckedStep(),
                  fallbackBuilder: (context) => const UncheckedStep(),
                ),
              ),
              const Spacer(flex: 10),
            ],
          ),
          18.verticalSpace,
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                flex: 2,
                child: Text(
                  'Pesanan Diterima',
                  style: TextStyle(
                    fontSize: 16.sp,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
              const Spacer(flex: 1),
              Expanded(
                flex: 2,
                child: Text(
                  'Silahkan Diambil',
                  style: TextStyle(
                    fontSize: 16.sp,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
              const Spacer(flex: 1),
              Expanded(
                flex: 2,
                child: Text(
                  'Pesanan Selesai',
                  style: TextStyle(
                    fontSize: 16.sp,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
