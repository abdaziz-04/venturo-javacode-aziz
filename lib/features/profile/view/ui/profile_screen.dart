import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:venturo_core/configs/routes/route.dart';

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
        appBar: CustomAppBar(
          title: 'Profil',
          showActions: false,
        ),
        body: Obx(() {
          final loginData = ProfileController.to.loginData;
          return SingleChildScrollView(
            child: Container(
              decoration: BoxDecoration(
                image: DecorationImage(
                    image: AssetImage(ImageConstants.bgPattern2),
                    fit: BoxFit.fitHeight,
                    alignment: Alignment.center),
              ),
              child: Padding(
                padding: const EdgeInsets.only(top: 30, left: 16, right: 16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Center(
                        child: Column(
                      children: [
                        Container(
                            padding: const EdgeInsets.all(4),
                            decoration: BoxDecoration(
                              color: ColorStyle.primary,
                              shape: BoxShape.circle,
                            ),
                            child: Obx(() {
                              if (ProfileController.to.imageFile != null) {
                                return ClipOval(
                                  child: SizedBox.fromSize(
                                    size: Size.fromRadius(70.r),
                                    child: Image.file(
                                      ProfileController.to.imageFile!,
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                );
                              } else {
                                return ClipOval(
                                  child: SizedBox.fromSize(
                                    size: Size.fromRadius(70.r),
                                    child: Image.network(
                                      loginData[0]['foto'] ?? '',
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                );
                              }
                            })),
                        SizedBox(height: 16),
                        ElevatedButton(
                          onPressed: () {
                            ProfileController.to.pickImage();
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: ColorStyle.primary,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(100),
                            ),
                          ),
                          child: Text(
                            'Edit Profile',
                            style: TextStyle(color: Colors.white),
                          ),
                        ),
                      ],
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
                            value: ProfileController.to.nama.value.isNotEmpty
                                ? ProfileController.to.nama.value
                                : loginData[0]['nama'] ?? '',
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
                                      controller:
                                          ProfileController.to.nameController,
                                      onTap: ProfileController.to.changeName,
                                      hintText: ProfileController
                                              .to.nama.value.isNotEmpty
                                          ? ProfileController.to.nama.value
                                          : loginData[0]['nama'] ?? '',
                                    ),
                                  );
                                },
                              );
                            },
                          ),
                          const Divider(),
                          InfoRow(
                            info: 'Tanggal Lahir',
                            value: ProfileController.to.selectedDate.value !=
                                    null
                                ? '${ProfileController.to.selectedDate.value!.day}/${ProfileController.to.selectedDate.value!.month}/${ProfileController.to.selectedDate.value!.year}'
                                : 'Belum diisi',
                            onPress: () {
                              ProfileController.to.selectDate(context);
                            },
                          ),
                          const Divider(),
                          InfoRow(
                            info: 'No Telepon',
                            value: ProfileController.to.phone.isNotEmpty
                                ? ProfileController.to.phone.value
                                : 'Belum diisi',
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
                                        title: 'No telepon',
                                        controller: ProfileController
                                            .to.phoneController,
                                        onTap: ProfileController.to.changePhone,
                                        hintText:
                                            ProfileController.to.phone.value),
                                  );
                                },
                              );
                            },
                          ),
                          const Divider(),
                          InfoRow(
                            info: 'Email',
                            value: ProfileController.to.email.isNotEmpty
                                ? ProfileController.to.email.value
                                : loginData[0]['email'],
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
                                        title: 'Alamat Email',
                                        controller: ProfileController
                                            .to.emailController,
                                        onTap: ProfileController.to.changeEmail,
                                        hintText:
                                            ProfileController.to.email.value),
                                  );
                                },
                              );
                            },
                          ),
                          const Divider(),
                          InfoRow(
                            info: 'Ubah Pin',
                            value: '***********',
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
                                        title: 'Pin',
                                        isPassword: true,
                                        controller:
                                            ProfileController.to.pinController,
                                        onTap: ProfileController.to.changePin,
                                        hintText: 'Masukkan pin baru'),
                                  );
                                },
                              );
                            },
                          ),
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
                                  onPressed: () {
                                    Get.toNamed(Routes.ratingRoute);
                                    print('Beri Penilaian');
                                  },
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
                                      value: ProfileController
                                          .to.productName.value),
                                  const Divider(),
                                  ProfileInfoRow(
                                      info: 'Android Level',
                                      value:
                                          ProfileController.to.apiLevel.value),
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
                  ],
                ),
              ),
            ),
          );
        }),
      ),
    );
  }
}
