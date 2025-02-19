import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:venturo_core/shared/widgets/custom_app_bar.dart';

import '../../../../../../shared/styles/color_style.dart';

class PromoDetailScreen extends StatelessWidget {
  PromoDetailScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: CustomAppBar(title: 'Promo', showActions: false),
        body: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(20),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(25),
                child: Image.network(
                    'https://javacode.landa.id/img/promo/gambar_62661b52223ff.png'),
              ),
            ),
            SizedBox(height: 20.h),
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
                      'Nama Promo',
                      style: TextStyle(
                          fontWeight: FontWeight.bold, fontSize: 16.sp),
                    ),
                    SizedBox(height: 10.h),
                    Text(
                      'Deskripsi Promo',
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
                          'Syarat dan Ketentuan',
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 16.sp),
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        SizedBox(width: 35.w),
                        Text(
                          'Deskripsi Syarat dan Ketentuan',
                          style: TextStyle(fontSize: 14.sp),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            )
          ],
        ));
  }
}
