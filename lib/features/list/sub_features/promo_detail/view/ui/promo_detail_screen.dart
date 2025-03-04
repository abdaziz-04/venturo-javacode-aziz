// ignore_for_file: invalid_use_of_protected_member

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:venturo_core/features/list/controllers/list_controller.dart';
import 'package:venturo_core/shared/widgets/custom_app_bar.dart';
import 'package:flutter_html/flutter_html.dart';
import '../../../../../../shared/styles/color_style.dart';

class PromoDetailScreen extends StatelessWidget {
  PromoDetailScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(title: 'Promo', showActions: false),
      body: Obx(() {
        final promo = ListController.to.selectedPromoDetail.value;

        if (promo.isEmpty || promo['nama'] == null) {
          return Center(child: CircularProgressIndicator());
        }
        return Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(20),
              child: Container(
                width: 400.h,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10.0),
                ),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(8.0),
                  child: promo['foto'] == null
                      ? Container(
                          height: 200.h,
                          color: Colors.grey[300],
                          // Bisa diganti dengan widget skeleton khusus untuk image
                        )
                      : Image.network(
                          promo['foto'],
                          fit: BoxFit.cover,
                        ),
                ),
              ),
            ),
            SizedBox(height: 10.h),
            Expanded(
              child: Container(
                width: double.infinity,
                padding: EdgeInsets.symmetric(
                  horizontal: 25.w,
                  vertical: 20.h,
                ),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.vertical(
                    top: Radius.circular(30.r),
                  ),
                  boxShadow: const [
                    BoxShadow(
                      color: Color.fromARGB(111, 24, 24, 24),
                      blurRadius: 15,
                      spreadRadius: -1,
                      offset: Offset(0, 1),
                    ),
                  ],
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'promo name'.tr,
                      style: TextStyle(
                          fontWeight: FontWeight.bold, fontSize: 16.sp),
                    ),
                    SizedBox(height: 10.h),
                    Text(
                      promo['nama'],
                      style: TextStyle(
                          fontSize: 18.sp,
                          color: ColorStyle.primary,
                          fontWeight: FontWeight.bold),
                    ),
                    const Divider(),
                    Row(
                      children: [
                        Icon(
                          Icons.menu,
                          color: ColorStyle.primary,
                        ),
                        SizedBox(width: 10.w),
                        Text(
                          'sku'.tr,
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 16.sp),
                        ),
                      ],
                    ),
                    SizedBox(height: 10.h),
                    Row(
                      children: [
                        SizedBox(width: 35.w),
                        Expanded(
                          child: promo['sk'] == null
                              ? Container(
                                  height: 50.h,
                                  color: Colors.grey[300],
                                )
                              : Html(
                                  data: promo['sk'],
                                  style: {
                                    'body': Style(
                                      fontSize: FontSize(14.sp),
                                    ),
                                  },
                                ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ],
        );
      }),
    );
  }
}
