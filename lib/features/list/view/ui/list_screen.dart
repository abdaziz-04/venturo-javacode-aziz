import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_slidable/flutter_slidable.dart';

import 'package:get/get.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

import 'package:venturo_core/features/list/view/components/menu_chip.dart';
import 'package:venturo_core/features/list/view/components/promo_card.dart';
import 'package:venturo_core/features/list/view/components/section_header.dart';
import 'package:venturo_core/shared/styles/color_style.dart';

import '../../../../configs/routes/route.dart';
import '../../../../constants/cores/assets/image_constants.dart';
import '../../controllers/list_controller.dart';
import '../components/menu_card.dart';
import '../components/search_app_bar.dart';
import '../../../../shared/widgets/title_section.dart';

class ListScreen extends StatelessWidget {
  const ListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
          appBar: SearchAppBar(
            onChange: (value) {
              ListController.to.keyword(value);
            },
          ),
          floatingActionButton: FloatingActionButton(
            // onPressed: () => Get.offAllNamed(Routes.noConnectionRoute),
            onPressed: () => Get.toNamed(Routes.checkoutRoute),
            child: Icon(
              Icons.shopping_cart,
              color: ColorStyle.light,
            ),
            backgroundColor: ColorStyle.primary,
          ),
          body: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TitleSection(
                title: 'Promo yang tersedia',
                image: ImageConstants.promo,
              ),
              // Promo
              SizedBox(
                height: 150.h,
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  padding: EdgeInsets.symmetric(horizontal: 25.w),
                  itemCount: ListController.to.promo.length,
                  itemBuilder: (context, index) {
                    final promo = ListController.to.promo[index];
                    return Padding(
                      padding: EdgeInsets.symmetric(horizontal: 8.5.w),
                      child: PromoCard(
                        promoName: promo['nama'] ?? 'Promo yang tersedia',
                        discountNominal: promo['diskon']?.toString() ?? '0',
                        thumbnailUrl: promo['foto'] ??
                            'https://img.freepik.com/free-photo/high-angle-uncompleted-voting-questionnaire_23-2148265549.jpg?semt=ais_hybrid',
                      ),
                    );
                  },
                ),
              ),
              SizedBox(height: 25.h),
              // Kategori
              SizedBox(
                height: 45.h,
                width: 1.sw,
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  padding: EdgeInsets.symmetric(horizontal: 25.w),
                  itemCount: ListController.to.categories.length,
                  itemBuilder: (context, index) {
                    final category = ListController.to.categories[index];
                    return Obx(
                      () => Padding(
                        padding: EdgeInsets.symmetric(horizontal: 10.w),
                        child: MenuChip(
                          text: category,
                          onTap: () {
                            ListController.to
                                .selectedCategory(category.toLowerCase());
                          },
                          isSelected:
                              ListController.to.selectedCategory.value ==
                                  category.toLowerCase(),
                        ),
                      ),
                    );
                  },
                ),
              ),
              SizedBox(height: 20.h),
              Obx(() {
                final currentCategory =
                    ListController.to.selectedCategory.value;
                return Container(
                  width: 1.sw,
                  height: 35.h,
                  margin: EdgeInsets.only(bottom: 10.h),
                  child: SectionHeader(
                    title: currentCategory == 'all'
                        ? 'Semua Menu'
                        : currentCategory == 'makanan'
                            ? 'Makanan'
                            : 'Minuman',
                    icon: currentCategory == 'all'
                        ? Icons.restaurant_menu
                        : currentCategory == 'makanan'
                            ? Icons.fastfood
                            : Icons.local_drink,
                  ),
                );
              }),
              Expanded(
                child: Obx(() => SmartRefresher(
                      controller: ListController.to.refreshController,
                      enablePullDown: true,
                      onRefresh: ListController.to.onRefresh,
                      enablePullUp:
                          ListController.to.canLoadMore.value ? true : false,
                      onLoading: () async {
                        await ListController.to.getListOfData();
                      },
                      child: ListView.builder(
                          padding: EdgeInsets.symmetric(horizontal: 25.w),
                          itemBuilder: (context, index) {
                            final item = ListController.to.filteredList[index];
                            return Padding(
                              padding: EdgeInsets.symmetric(vertical: 8.5.h),
                              child: Obx(() => Slidable(
                                    endActionPane: ActionPane(
                                      motion: const ScrollMotion(),
                                      children: [
                                        SlidableAction(
                                          onPressed: (context) {
                                            ListController.to.deleteItem(item);
                                          },
                                          borderRadius: BorderRadius.horizontal(
                                              right: Radius.circular(10.r)),
                                          backgroundColor: ColorStyle.danger,
                                          foregroundColor: Colors.white,
                                          icon: Icons.delete,
                                          label: 'Delete',
                                        )
                                      ],
                                    ),
                                    child: Material(
                                      borderRadius: BorderRadius.circular(10.r),
                                      elevation: 2,
                                      child: MenuCard(
                                        menu: item,
                                        isSelected: ListController
                                            .to.selectedItems
                                            .contains(item),
                                        onTap: () {
                                          Get.toNamed(Routes.detailMenuRoute,
                                              arguments: item['id_menu']);
                                          if (ListController.to.selectedItems
                                              .contains(item)) {
                                            ListController.to.selectedItems
                                                .remove(item);
                                          } else {
                                            ListController.to.selectedItems
                                                .add(item);
                                          }
                                        },
                                      ),
                                    ),
                                  )),
                            );
                          },
                          itemCount: ListController.to.filteredList.length,
                          itemExtent: 122.h),
                    )),
              )
            ],
          )),
    );
  }
}
