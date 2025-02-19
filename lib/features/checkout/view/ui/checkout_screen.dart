import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:venturo_core/features/checkout/view/components/checkout_menu_card.dart';
import 'package:venturo_core/features/list/controllers/list_controller.dart';
import 'package:venturo_core/shared/widgets/info_row.dart';

import 'package:venturo_core/shared/widgets/title_section.dart';

import '../../../../constants/cores/assets/image_constants.dart';
import '../../../../shared/styles/color_style.dart';
import '../../../../shared/styles/elevated_button_style.dart';
import '../../../../shared/widgets/custom_app_bar.dart';
import '../../constants/checkout_assets_constant.dart';

class CheckoutScreen extends StatelessWidget {
  CheckoutScreen({Key? key}) : super(key: key);

  final assetsConstant = CheckoutAssetsConstant();
  final item = ListController.to.filteredList[5];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        title: 'Pesanan',
        showActions: false,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 10),
          child: Column(
            children: [
              TitleSection(
                title: 'Makanan',
                image: ImageConstants.iconFood,
              ),
              //! JANLUP FUNGSIONALITAS
              CheckoutMenuCard(menu: item),

              TitleSection(
                title: 'Minuman',
                image: ImageConstants.iconDrinks,
              ),
              // Kategori minuman
              CheckoutMenuCard(menu: item),
            ],
          ),
        ),
      ),
      bottomNavigationBar: Container(
        decoration: BoxDecoration(
          color: ColorStyle.grey.withOpacity(0.1),
          borderRadius: BorderRadius.circular(10),
        ),
        // height: 100,
        width: double.infinity,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            SizedBox(height: 15.h),
            InfoRow(
              info: 'Total Pesanan :',
              value: 'Rp 100.000',
              isBold: true,
              valueColor: ColorStyle.primary,
              containButton: false,
            ),
            const Divider(),
            InfoRow(
                info: 'Diskon',
                value: 'Rp 10.000',
                containImage: true,
                valueColor: ColorStyle.danger,
                image: ImageConstants.icDiscount),
            const Divider(),
            InfoRow(
                info: 'Voucher',
                value: 'Pilih Voucher',
                containImage: true,
                image: ImageConstants.icVoucher),
            const Divider(),
            InfoRow(
                info: 'Pembayaran',
                value: 'Transfer Bank',
                containImage: true,
                image: ImageConstants.icPayment),
            SizedBox(height: 30),
            Container(
              // height: 50.h,
              decoration: BoxDecoration(
                color: ColorStyle.white,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(25),
                  topRight: Radius.circular(25),
                ),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.1),
                    spreadRadius: 2,
                    blurRadius: 5,
                    offset: Offset(0, -2),
                  ),
                ],
              ),
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
                child: Row(
                  children: [
                    Image.asset(
                      ImageConstants.icCart,
                      width: 50.w,
                    ),
                    SizedBox(width: 10.w),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Total Pembayaran',
                          style: TextStyle(
                            fontSize: 15.sp,
                          ),
                        ),
                        Text(
                          'Rp 90.000',
                          style: TextStyle(
                            fontSize: 20.sp,
                            fontWeight: FontWeight.bold,
                            color: ColorStyle.primary,
                          ),
                        ),
                      ],
                    ),
                    const Spacer(),
                    ElevatedButton(
                        style: EvelatedButtonStyle.mainRounded,
                        onPressed: () {},
                        child: Text('Pesan Sekarang'))
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
