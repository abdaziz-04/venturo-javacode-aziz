import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:venturo_core/shared/styles/color_style.dart';

import '../../../../constants/cores/assets/image_constants.dart';

import '../../../../shared/widgets/tile_option_widget.dart';
import '../../constants/profile_assets_constant.dart';
import '../../controllers/profile_controller.dart';
import '../components/profile_info_row.dart';

class ProfileScreen extends StatelessWidget {
  ProfileScreen({Key? key}) : super(key: key);

  final assetsConstant = ProfileAssetsConstant();
  // final ProfileController pc = Get.put(ProfileController());
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: Center(
              child: Text(
            'Profil',
            style: TextStyle(
              fontWeight: FontWeight.bold,
              color: ColorStyle.primary,
              decoration: TextDecoration.underline,
            ),
          )),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.vertical(
              bottom: Radius.circular(20.0),
            ),
          ),
          backgroundColor: Colors.white,
          elevation: 5.0,
          shadowColor: Colors.grey.withOpacity(0.5),
          actions: [
            IconButton(
              icon: Icon(Icons.logout, color: ColorStyle.danger),
              onPressed: () {
                ProfileController.to.logout();
              },
            ),
          ],
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.only(top: 30, left: 16, right: 16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Center(child: Image.asset(ImageConstants.imgProfile)),
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
                  padding:
                      const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
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
                      ProfileInfoRow(
                        info: 'Nama',
                        value: 'Muhammad Fauzan',
                      ),
                      const Divider(),
                      ProfileInfoRow(info: 'Tanggal Lahir', value: '2004'),
                      const Divider(),
                      ProfileInfoRow(info: 'No Telepon', value: '08123456789'),
                      const Divider(),
                      ProfileInfoRow(info: 'Email', value: 'admin@gmail.com'),
                      const Divider(),
                      ProfileInfoRow(info: 'Ubah Pin', value: '**********'),
                      const Divider(),
                      ProfileInfoRow(info: 'Ganti Bahasa', value: 'Indonesia'),
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
                  padding:
                      const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
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
                      padding: const EdgeInsets.all(8.0),
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
                TileOptionWidget(
                  title: 'Privacy Policy'.tr,
                  message: 'Here',
                  onTap: ProfileController.to.privacyPolicyWebView,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
