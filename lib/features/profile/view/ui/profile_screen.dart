import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import 'package:venturo_core/shared/styles/color_style.dart';
import 'package:venturo_core/shared/widgets/custom_app_bar.dart';
import 'package:venturo_core/shared/widgets/info_row.dart';
import 'package:venturo_core/shared/widgets/text_bottom_sheet.dart';

import '../../../../constants/cores/assets/image_constants.dart';

import '../../constants/profile_assets_constant.dart';
import '../../controllers/profile_controller.dart';
import '../components/profile_info_row.dart';

class ProfileScreen extends StatelessWidget {
  ProfileScreen({Key? key}) : super(key: key);

  final assetsConstant = ProfileAssetsConstant();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            print('Data login = ${ProfileController.to.loginData}');
            // ProfileController.to.getUser();
          },
          child: Icon(Icons.bug_report_outlined),
        ),
        appBar: CustomAppBar(
          title: 'Profil',
          showActions: false,
        ),
        body: Obx(() {
          final loginData = ProfileController.to.loginData;
          return SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.only(top: 30, left: 16, right: 16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Center(
                      child: Container(
                    padding: const EdgeInsets.all(4),
                    decoration: BoxDecoration(
                      color: ColorStyle.primary,
                      shape: BoxShape.circle,
                    ),
                    child: ClipOval(
                        child: SizedBox.fromSize(
                      size: Size.fromRadius(70.r),
                      child: Image.network(
                        loginData[0]['user']?['foto'] ?? '',
                        fit: BoxFit.cover,
                      ),
                    )),
                  )),
                  SizedBox(height: 16),
                  Center(
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Image.asset(
                          ImageConstants.icKTP,
                          width: 20,
                        ),
                        SizedBox(width: 8),
                        Text('Verifikasi KTP mu Sekarang',
                            style: TextStyle(color: ColorStyle.primary)),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 15, vertical: 10),
                    child: Text(
                      'Info Akun',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 20,
                        color: ColorStyle.primary,
                      ),
                    ),
                  ),
                  Container(
                    decoration: BoxDecoration(
                      color: ColorStyle.grey.withOpacity(0.2),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    // height: 100,
                    width: double.infinity,
                    child: Column(
                      children: [
                        SizedBox(height: 16),
                        InfoRow(
                          info: 'Nama',
                          value: loginData[0]['user']?['nama'] ?? '',
                          onPress: () {
                            showModalBottomSheet<void>(
                              context: context,
                              isScrollControlled: true,
                              builder: (BuildContext context) {
                                return Padding(
                                  padding: EdgeInsets.only(
                                      bottom: MediaQuery.of(context)
                                          .viewInsets
                                          .bottom),
                                  child: TextModalBottomSheet(
                                    title: 'Nama',
                                    hintText:
                                        loginData[0]['user']?['nama'] ?? '',
                                  ),
                                );
                              },
                            );
                          },
                        ),
                        const Divider(),
                        InfoRow(info: 'Tanggal Lahir', value: 'Belum diisi'),
                        const Divider(),
                        InfoRow(info: 'No Telepon', value: '08123456789'),
                        const Divider(),
                        InfoRow(
                            info: 'Email',
                            value: loginData[0]['user']?['email'] ?? ''),
                        const Divider(),
                        InfoRow(
                            info: 'Ubah Pin',
                            value: loginData[0]['user']?['pin'] ?? ''),
                        const Divider(),
                        InfoRow(info: 'Ganti Bahasa', value: 'Indonesia'),
                        SizedBox(height: 16),
                      ],
                    ),
                  ),
                  SizedBox(height: 16),
                  Container(
                    decoration: BoxDecoration(
                      color: ColorStyle.grey.withOpacity(0.2),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    width: double.infinity,
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        children: [
                          SizedBox(width: 8),
                          Image.asset(
                            ImageConstants.icRating,
                            width: 20,
                          ),
                          SizedBox(width: 8),
                          Text(
                            'Penilaian',
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                          Spacer(),
                          SizedBox(
                            height: 40,
                            width: 150,
                            child: ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: ColorStyle.primary,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(100),
                                  ),
                                ),
                                onPressed: () {},
                                child: Text(
                                  'Nilai Sekarang',
                                  style: TextStyle(color: Colors.white),
                                )),
                          ),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(height: 16),
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 15, vertical: 10),
                    child: Text(
                      'Info Lainnya',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 20,
                        color: ColorStyle.primary,
                      ),
                    ),
                  ),
                  SizedBox(height: 16),
                  Container(
                    decoration: BoxDecoration(
                      color: ColorStyle.grey.withOpacity(0.2),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    width: double.infinity,
                    child: Padding(
                        padding: const EdgeInsets.symmetric(vertical: 10),
                        child: Obx(() => Column(
                              children: [
                                ProfileInfoRow(
                                    info: 'Device Info',
                                    value:
                                        ProfileController.to.productName.value),
                                const Divider(),
                                ProfileInfoRow(
                                    info: 'Android Level',
                                    value: ProfileController.to.apiLevel.value),
                              ],
                            ))),
                  ),
                  SizedBox(height: 16),
                  SizedBox(
                    width: double.infinity,
                    height: 40.h,
                    child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: ColorStyle.primary,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(100),
                          ),
                        ),
                        onPressed: () {
                          ProfileController.to.logout();
                        },
                        child: Text(
                          'Logout',
                          style: TextStyle(color: Colors.white),
                        )),
                  ),
                  SizedBox(height: 30.h),
                  // TileOptionWidget(
                  //   title: 'Privacy Policy'.tr,
                  //   message: 'Here',
                  //   onTap: ProfileController.to.privacyPolicyWebView,
                  // ),
                ],
              ),
            ),
          );
        }),
      ),
    );
  }
}
