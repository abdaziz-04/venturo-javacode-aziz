// ignore_for_file: invalid_use_of_protected_member

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:venturo_core/features/checkout/sub_features/voucher/controllers/checkout_voucher_controller.dart';
import 'package:venturo_core/shared/styles/elevated_button_style.dart';
import 'package:venturo_core/shared/widgets/custom_app_bar.dart';

import '../../../../../../shared/styles/color_style.dart';

class DetailVoucherScreen extends StatelessWidget {
  DetailVoucherScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final voucher = Get.arguments as Map<String, dynamic>?;
    if (voucher == null) {
      return Center(child: CircularProgressIndicator());
    }
    return Scaffold(
      appBar: CustomAppBar(title: 'Detail Voucher', showActions: false),
      body: Column(
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
                child: voucher['info_voucher'] == null
                    ? Container(
                        height: 200.h,
                        color: Colors.grey[300],
                      )
                    : Image.network(
                        voucher['info_voucher'],
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
                  SizedBox(height: 10.h),
                  Text(
                    voucher['nama'],
                    style: TextStyle(
                        fontSize: 20.sp,
                        color: ColorStyle.primary,
                        fontWeight: FontWeight.bold),
                    textAlign: TextAlign.right,
                  ),
                  Html(
                    data: voucher['catatan'],
                    style: {
                      'body': Style(
                        fontSize: FontSize(16.sp),
                      ),
                    },
                  ),
                  // Text(
                  //   voucher['catatan'],
                  //   style: TextStyle(fontSize: 14.sp),
                  // ),
                  const Divider(),
                  Row(
                    children: [
                      Icon(
                        Icons.menu,
                        color: ColorStyle.primary,
                      ),
                      SizedBox(width: 10.w),
                      Text(
                        'Valid Date',
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 16.sp),
                      ),
                      Spacer(),
                      Text(
                        voucher['periode_mulai'] +
                            ' - ' +
                            voucher['periode_selesai'],
                        style: TextStyle(fontSize: 16.sp),
                      ),
                    ],
                  ),
                  const Divider(),
                ],
              ),
            ),
          ),
        ],
      ),
      bottomNavigationBar: Container(
        height: 70.h,
        decoration: BoxDecoration(
          borderRadius: const BorderRadius.only(
            topLeft: Radius.circular(30),
            topRight: Radius.circular(30),
          ),
          boxShadow: const [
            BoxShadow(color: Colors.black38, spreadRadius: 0, blurRadius: 10),
          ],
          color: ColorStyle.white,
        ),
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 20.h, vertical: 10.h),
          child: Column(
            children: [
              SizedBox(
                height: 50.h,
                width: double.infinity,
                child: ElevatedButton(
                    style: EvelatedButtonStyle.mainRounded,
                    onPressed: () {
                      CheckoutVoucherController.to.addVoucher(voucher);
                      Get.back();
                    },
                    child: Text('Oke')),
              )
            ],
          ),
        ),
      ),
    );
  }
}
