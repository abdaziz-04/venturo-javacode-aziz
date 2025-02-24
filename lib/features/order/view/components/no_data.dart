import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:venturo_core/features/order/constants/order_assets_constant.dart';

class NoData extends StatelessWidget {
  final String info;

  NoData({
    super.key,
    required this.info,
  });

  final assetsConstant = OrderAssetsConstant();

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Expanded(
            child: Stack(
              alignment: Alignment.center,
              children: [
                Image.asset(
                  'assets/images/bg_pattern2.png',
                  fit: BoxFit.cover,
                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Image.asset(
                      assetsConstant.imgMenu,
                      height: 170,
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 50.h),
                      child: Text(
                        info,
                        style: TextStyle(fontSize: 22.sp),
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          SizedBox(
            height: 55.h,
          ),
        ],
      ),
    );
  }
}
