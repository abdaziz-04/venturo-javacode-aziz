import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:venturo_core/configs/routes/route.dart';
import 'package:venturo_core/features/profile/view/components/change_lang_bottom_sheet.dart';

import 'package:venturo_core/shared/styles/color_style.dart';
import 'package:venturo_core/shared/widgets/custom_app_bar.dart';
import 'package:venturo_core/shared/widgets/info_row.dart';
import 'package:venturo_core/features/profile/view/components/text_bottom_sheet.dart';

import '../../../../constants/cores/assets/image_constants.dart';

import '../../constants/profile_assets_constant.dart';
import '../../controllers/profile_controller.dart';
import '../components/profile_info_row.dart';

class ProfileScreen extends StatelessWidget {
  ProfileScreen({Key? key}) : super(key: key);

  final assetsConstant = ProfileAssetsConstant();
  static FirebaseAnalytics analytics = FirebaseAnalytics.instance;

  @override
  Widget build(BuildContext context) {
    analytics.setCurrentScreen(
      screenName: 'Profil Screen',
      screenClassOverride: 'Trainee',
    );
    return SafeArea(
      child: Scaffold(
        appBar: CustomAppBar(
          title: 'title'.tr,
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
                            'edit image'.tr,
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
                          Text('id verification'.tr,
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
                            info: 'name'.tr,
                            value: ProfileController.to.nama.value.isNotEmpty
                                ? ProfileController.to.nama.value
                                : loginData[0]['nama'] ?? '',
                            onPress: () {
                              Get.bottomSheet(
                                Padding(
                                  padding: EdgeInsets.only(
                                      bottom: MediaQuery.of(context)
                                          .viewInsets
                                          .bottom),
                                  child: TextBottomSheet(
                                    title: 'name'.tr,
                                    controller:
                                        ProfileController.to.nameController,
                                    onTap: ProfileController.to.changeName,
                                    hintText: ProfileController
                                            .to.nama.value.isNotEmpty
                                        ? ProfileController.to.nama.value
                                        : loginData[0]['nama'] ?? '',
                                  ),
                                ),
                                isScrollControlled: true,
                              );
                            },
                          ),
                          const Divider(),
                          InfoRow(
                            info: 'born'.tr,
                            value: ProfileController.to.selectedDate.value !=
                                    null
                                ? '${ProfileController.to.selectedDate.value!.day}/${ProfileController.to.selectedDate.value!.month}/${ProfileController.to.selectedDate.value!.year}'
                                : 'not yet filled'.tr,
                            onPress: () {
                              ProfileController.to.selectDate(context);
                            },
                          ),
                          const Divider(),
                          InfoRow(
                            info: 'phone'.tr,
                            value: ProfileController.to.phone.isNotEmpty
                                ? ProfileController.to.phone.value
                                : 'not yet filled'.tr,
                            onPress: () {
                              Get.bottomSheet(
                                Padding(
                                  padding: EdgeInsets.only(
                                      bottom: MediaQuery.of(context)
                                          .viewInsets
                                          .bottom),
                                  child: TextBottomSheet(
                                      title: 'No telepon',
                                      controller:
                                          ProfileController.to.phoneController,
                                      onTap: ProfileController.to.changePhone,
                                      hintText:
                                          ProfileController.to.phone.value),
                                ),
                                isScrollControlled: true,
                              );
                            },
                          ),
                          const Divider(),
                          InfoRow(
                            info: 'email'.tr,
                            value: ProfileController.to.email.isNotEmpty
                                ? ProfileController.to.email.value
                                : loginData[0]['email'],
                            onPress: () {
                              Get.bottomSheet(
                                Padding(
                                  padding: EdgeInsets.only(
                                      bottom: MediaQuery.of(context)
                                          .viewInsets
                                          .bottom),
                                  child: TextBottomSheet(
                                      title: 'email'.tr,
                                      controller:
                                          ProfileController.to.emailController,
                                      onTap: ProfileController.to.changeEmail,
                                      hintText:
                                          ProfileController.to.email.value),
                                ),
                                isScrollControlled: true,
                              );
                            },
                          ),
                          const Divider(),
                          InfoRow(
                            info: 'pin'.tr,
                            value: '***********',
                            onPress: () {
                              Get.bottomSheet(
                                Padding(
                                  padding: EdgeInsets.only(
                                      bottom: MediaQuery.of(context)
                                          .viewInsets
                                          .bottom),
                                  child: TextBottomSheet(
                                      title: 'pin'.tr,
                                      isPassword: true,
                                      controller:
                                          ProfileController.to.pinController,
                                      onTap: ProfileController.to.changePin,
                                      hintText: 'Masukkan pin baru'),
                                ),
                                isScrollControlled: true,
                              );
                            },
                          ),
                          const Divider(),
                          InfoRow(
                            info: 'change language'.tr,
                            value: ProfileController.to.lang == 'id'
                                ? 'Bahasa Indonesia'
                                : 'English',
                            onPress: () {
                              Get.bottomSheet(
                                Obx(() => Padding(
                                      padding: EdgeInsets.only(
                                          bottom: MediaQuery.of(context)
                                              .viewInsets
                                              .bottom),
                                      child: ChangeLangBottomSheet(
                                        selectedLang:
                                            ProfileController.to.lang.value,
                                        title: 'change language'.tr,
                                        controller: ProfileController
                                            .to.emailController,
                                        onTap: (lang) {
                                          ProfileController.to.changeLang(lang);
                                          print(lang == 'id'
                                              ? 'Bahasa Indonesia'
                                              : 'Bahasa Inggris');
                                        },
                                      ),
                                    )),
                                isScrollControlled: true,
                              );
                            },
                          ),
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
                              'rating'.tr,
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
                                    'rate now'.tr,
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
                        'more info'.tr,
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
                                      info: 'device info'.tr,
                                      value: ProfileController
                                          .to.productName.value),
                                  const Divider(),
                                  ProfileInfoRow(
                                      info: 'android level'.tr,
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
                            'logout'.tr,
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
