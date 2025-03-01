import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:venturo_core/constants/cores/assets/image_constants.dart';
import 'package:venturo_core/features/order/constants/order_assets_constant.dart';
import 'package:venturo_core/features/order/sub_features/detail_order/controllers/order_detail_order_controller.dart';
import 'package:venturo_core/features/order/sub_features/detail_order/view/components/order_menu_card.dart';
import 'package:venturo_core/features/order/sub_features/detail_order/view/components/order_tracker.dart';
import 'package:venturo_core/shared/styles/color_style.dart';
import 'package:venturo_core/shared/widgets/custom_app_bar.dart';
import 'package:venturo_core/shared/widgets/title_section.dart';

import '../../../../../../shared/widgets/info_row.dart';

class DetailOrderScreen extends StatelessWidget {
  DetailOrderScreen({Key? key}) : super(key: key);

  final assetsConstant = OrderAssetsConstant();
  @override
  Widget build(BuildContext context) {
    final data = Get.arguments;
    final OrderDetailOrderController orderController =
        OrderDetailOrderController.to;
    final List makanan =
        data['menu'].where((item) => item['kategori'] == 'makanan').toList();
    final List minuman =
        data['menu'].where((item) => item['kategori'] == 'minuman').toList();

    return Scaffold(
      appBar: CustomAppBar(
        title: 'Detail Order',
        showActions: false,
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if (makanan.isNotEmpty) ...[
              TitleSection(
                title: 'Makanan',
                image: ImageConstants.iconFood,
              ),
              ListView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: makanan.length,
                itemBuilder: (context, index) {
                  return Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: OrderMenuCard(menu: makanan[index]),
                  );
                },
              ),
            ],
            if (minuman.isNotEmpty) ...[
              TitleSection(
                title: 'Minuman',
                image: ImageConstants.iconDrinks,
              ),
              ListView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: minuman.length,
                itemBuilder: (context, index) {
                  return Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: OrderMenuCard(menu: minuman[index]),
                  );
                },
              ),
            ],
          ],
        ),
      ),
      bottomNavigationBar: Container(
        decoration: BoxDecoration(
          color: Color.fromARGB(255, 233, 233, 233),
          borderRadius: BorderRadius.circular(30),
        ),
        // height: 100,
        width: double.infinity,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            SizedBox(height: 15.h),
            InfoRow(
              info: 'Total Pesanan (${data['menu'].length} Menu):',
              value: 'Rp ${orderController.totalHarga}',
              isBold: true,
              valueColor: ColorStyle.primary,
              containButton: false,
            ),
            const Divider(),
            InfoRow(
                info: 'Pembayaran',
                value: 'Transfer Bank',
                containImage: true,
                containButton: false,
                image: ImageConstants.icPayment),
            const Divider(),
            InfoRow(
              info: 'Total Pembayaran',
              value: data['total_bayar'].toString(),
              containButton: false,
              valueColor: ColorStyle.primary,
              isBold: true,
            ),
            const Divider(),
            SizedBox(height: 15.h),
            OrderTracker(),
            SizedBox(height: 15.h),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          print(orderController.order);
        },
        child: const Icon(Icons.bug_report),
      ),
    );
  }
}
