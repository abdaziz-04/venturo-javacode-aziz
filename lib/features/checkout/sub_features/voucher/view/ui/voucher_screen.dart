import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:venturo_core/configs/routes/route.dart';
import 'package:venturo_core/features/checkout/controllers/checkout_controller.dart';
import 'package:venturo_core/features/checkout/sub_features/voucher/controllers/checkout_voucher_controller.dart';
import 'package:venturo_core/features/checkout/sub_features/voucher/view/components/voucher_bottom_bar.dart';
import 'package:venturo_core/features/checkout/sub_features/voucher/view/components/voucher_card.dart';
import 'package:venturo_core/shared/widgets/custom_app_bar.dart';

import '../../../../constants/checkout_assets_constant.dart';

class VoucherScreen extends StatelessWidget {
  VoucherScreen({Key? key}) : super(key: key);

  final assetsConstant = CheckoutAssetsConstant();
  final CheckoutVoucherController controller = CheckoutVoucherController.to;

  @override
  Widget build(BuildContext context) {
    final items = controller.voucher;
    return Scaffold(
      appBar: CustomAppBar(title: 'Pilih Voucher', showActions: false),
      body: ListView.builder(
          itemCount: controller.voucher.length,
          shrinkWrap: true,
          padding: EdgeInsets.symmetric(horizontal: 25.w, vertical: 20.h),
          itemBuilder: (context, index) {
            return Padding(
              padding: const EdgeInsets.symmetric(vertical: 10),
              child: VoucherCard(
                onTap: () {
                  Get.toNamed(Routes.voucherDetail, arguments: items[index]);
                  print('voucher = ${items[index]}');
                },
                item: items[index],
              ),
            );
          }),
      bottomNavigationBar: VoucherBottomBar(),
    );
  }
}
