import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:venturo_core/features/checkout/controllers/checkout_controller.dart';
import 'package:venturo_core/features/order/view/components/order_again_button.dart';
import 'package:venturo_core/features/order/view/components/rate_button.dart';
import 'package:venturo_core/features/order/view/components/status_info.dart';
import 'package:venturo_core/shared/styles/color_style.dart';

class HistoryDetailOrderCard extends StatelessWidget {
  final RxMap<String, dynamic> detailOrder;

  const HistoryDetailOrderCard(this.detailOrder, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      final order = detailOrder;
      return InkWell(
        child: Ink(
          padding: EdgeInsets.all(7.r),
          decoration: BoxDecoration(
            color: Colors.grey[100],
            borderRadius: BorderRadius.circular(10.r),
            boxShadow: const [
              BoxShadow(
                color: Colors.black87,
                offset: Offset(0, 1),
                blurRadius: 3,
                spreadRadius: -1,
              ),
            ],
          ),
          child: Row(
            children: [
              Container(
                height: 130.h,
                width: 120.w,
                margin: EdgeInsets.only(right: 12.w),
                padding: EdgeInsets.all(5.r),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10.r),
                  color: Colors.white,
                ),
                child: CachedNetworkImage(
                  imageUrl: order['menu'].length > 1 &&
                          order['menu'][1]['foto'] != null
                      ? order['menu'][1]['foto']
                      : order['menu'][0]['foto'] ??
                          'https://st4.depositphotos.com/2102215/38162/v/1600/depositphotos_381626826-stock-illustration-online-food-order-service-advertising.jpg',
                  fit: BoxFit.contain,
                  errorWidget: (context, url, error) => CachedNetworkImage(
                    imageUrl:
                        'https://st4.depositphotos.com/2102215/38162/v/1600/depositphotos_381626826-stock-illustration-online-food-order-service-advertising.jpg',
                    fit: BoxFit.contain,
                  ),
                ),
              ),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        StatusInfo(detailOrder: order),
                        const Spacer(),
                        Text(
                          order['tanggal'].toString(),
                          style: TextStyle(
                            color: Colors.grey,
                            fontSize: 14.sp,
                          ),
                        ),
                      ],
                    ),
                    Container(
                      constraints: BoxConstraints(maxWidth: 200.w),
                      child: Text(
                        (order['menu'] as List)
                            .map((menu) => menu['nama'])
                            .join(', '),
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 20.sp,
                          fontWeight: FontWeight.bold,
                        ),
                        overflow: TextOverflow.ellipsis,
                        maxLines: 2,
                      ),
                    ),
                    SizedBox(height: 5.h),
                    Row(
                      children: [
                        Text(
                          'Rp ${order['total_bayar']}',
                          style: TextStyle(
                            color: ColorStyle.primary,
                            fontWeight: FontWeight.bold,
                            fontSize: 16.sp,
                          ),
                        ),
                        SizedBox(width: 5.w),
                        Text(
                          '(${detailOrder['menu'].length} Menu)',
                          style: TextStyle(
                            color: Colors.grey,
                            fontSize: 14.sp,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 10.h),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        if (order['status'] == 4)
                          OrderAgainButton(onTap: () {
                            print('Order again ${order}');
                            CheckoutController.to.authOrderAgain(
                                potongan: 0,
                                cartItems: detailOrder['menu'],
                                finalTotalPrice: detailOrder['total_bayar']);
                          })
                        else ...[
                          RateButton(),
                          OrderAgainButton(
                            onTap: () {
                              print('Order again ${order}');
                            },
                          ),
                        ],
                      ],
                    )
                  ],
                ),
              ),
            ],
          ),
        ),
      );
    });
  }
}
