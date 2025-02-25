import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:venturo_core/features/order/controllers/order_controller.dart';
import 'package:venturo_core/shared/styles/color_style.dart';

class DropDownStatus extends StatelessWidget {
  DropDownStatus({
    super.key,
  });

  final OrderController orderController = OrderController.to;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 10.h),
      height: 40.h,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(50.h),
        border: Border.all(color: ColorStyle.primary),
        color: ColorStyle.imgBg,
      ),
      child: DropdownButtonHideUnderline(
        child: Obx(() {
          return DropdownButton<String>(
            value: orderController.selectedStatus.value,
            iconSize: 25.h,
            selectedItemBuilder: (BuildContext context) {
              return orderController.dateFilterStatus.entries.map((entry) {
                return Center(
                  child: Text(
                    entry.value,
                    style: TextStyle(
                      color: ColorStyle.black,
                      fontSize: 16.sp,
                      fontWeight:
                          orderController.selectedStatus.value == entry.key
                              ? FontWeight.bold
                              : FontWeight.normal,
                    ),
                  ),
                );
              }).toList();
            },
            style: TextStyle(
                color: ColorStyle.black,
                fontSize: 16.sp,
                fontWeight: FontWeight.normal),
            items: orderController.dateFilterStatus.entries.map((entry) {
              return DropdownMenuItem<String>(
                value: entry.key,
                child: Text(entry.value),
              );
            }).toList(),
            onChanged: (value) {
              orderController.selectedStatus.value = value!;
              orderController.updateFilteredHistoryOrders();
            },
          );
        }),
      ),
    );
  }
}
