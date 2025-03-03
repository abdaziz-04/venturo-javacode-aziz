import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:venturo_core/configs/routes/route.dart';
import 'package:venturo_core/constants/cores/assets/image_constants.dart';
import 'package:venturo_core/features/rating/constants/rating_assets_constant.dart';
import 'package:venturo_core/features/rating/controllers/rating_controller.dart';
import 'package:venturo_core/features/rating/view/components/rating_card.dart';
import 'package:venturo_core/shared/styles/color_style.dart';
import 'package:venturo_core/shared/widgets/custom_app_bar.dart';

class RatingScreen extends StatelessWidget {
  RatingScreen({Key? key}) : super(key: key);

  final assetsConstant = RatingAssetsConstant();
  @override
  Widget build(BuildContext context) {
    final rate = RatingController.to.rateItem;
    return Scaffold(
      appBar: CustomAppBar(
        title: 'Daftar Penilaian',
        showActions: true,
        icon: Icons.delete,
        onPress: () {
          Get.defaultDialog(
            title: 'Hapus Semua Penilaian',
            middleText: 'Apakah anda yakin ingin menghapus semua penilaian?',
            textConfirm: 'Ya',
            textCancel: 'Tidak',
            buttonColor: ColorStyle.primary,
            confirmTextColor: ColorStyle.white,
            cancelTextColor: ColorStyle.primary,
            onConfirm: () {
              Get.back();
              RatingController.to.deleteAllRate();
            },
          );
        },
      ),
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage(ImageConstants.bgPattern2),
            fit: BoxFit.fitHeight,
          ),
        ),
        child: Padding(
          padding: EdgeInsets.symmetric(vertical: 20.h),
          child: Column(
            children: [
              Expanded(
                child: Obx(() => ListView.builder(
                      itemCount: rate.length,
                      itemBuilder: (context, index) {
                        return RatingCard(
                          rateItem: rate[index],
                        );
                      },
                    )),
              ),
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(100),
        ),
        onPressed: () {
          Get.toNamed(Routes.addRateRoute);
        },
        child: Icon(
          Icons.add,
          color: ColorStyle.white,
        ),
        backgroundColor: ColorStyle.primary,
      ),
    );
  }
}
