// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:venturo_core/features/order/controllers/order_controller.dart';

import 'package:venturo_core/shared/styles/color_style.dart';

class OrderAppBar extends StatelessWidget implements PreferredSizeWidget {
  const OrderAppBar({
    Key? key,
  }) : super(key: key);

  @override
  Size get preferredSize => Size.fromHeight(kToolbarHeight);
  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: Padding(
        padding: EdgeInsets.symmetric(horizontal: 25.h),
        child: Center(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Obx(() => TextButton(
                    onPressed: () {
                      OrderController.to.selectedTabIndex.value = 0;
                    },
                    child: Text(
                      'ongoing'.tr,
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: OrderController.to.selectedTabIndex.value == 0
                            ? ColorStyle.primary
                            : ColorStyle.black,
                        fontSize: 18.sp,
                        decoration:
                            OrderController.to.selectedTabIndex.value == 0
                                ? TextDecoration.underline
                                : TextDecoration.none,
                      ),
                    ),
                  )),
              Obx(() => TextButton(
                    onPressed: () {
                      OrderController.to.selectedTabIndex.value = 1;
                    },
                    child: Text(
                      'history'.tr,
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: OrderController.to.selectedTabIndex.value == 1
                            ? ColorStyle.primary
                            : ColorStyle.black,
                        fontSize: 18.sp,
                        decoration:
                            OrderController.to.selectedTabIndex.value == 1
                                ? TextDecoration.underline
                                : TextDecoration.none,
                      ),
                    ),
                  )),
            ],
          ),
        ),
      ),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(
          bottom: Radius.circular(20.0),
        ),
      ),
      backgroundColor: Colors.white,
      elevation: 5.0,
      shadowColor: Colors.grey.withOpacity(0.5),
    );
  }
}
