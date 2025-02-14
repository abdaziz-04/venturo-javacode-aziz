import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:get/get.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

import 'package:venturo_core/features/list/view/components/menu_chip.dart';
import 'package:venturo_core/features/list/view/components/promo_card.dart';
import 'package:venturo_core/shared/styles/color_style.dart';

import '../../../../configs/routes/route.dart';
import '../../../../constants/cores/assets/image_constants.dart';
import '../../controllers/list_controller.dart';
import '../components/menu_card.dart';
import '../components/search_app_bar.dart';
import '../components/title_section.dart';

class ListScreen extends StatelessWidget {
  const ListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Column(
        children: [
          // Search App Bar
          const SearchAppBar(
              // searchController: ListController.to.searchController,
              // onChange: ListController.to.onSearch,
              ),
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
              itemCount: 5,
              itemBuilder: (context, index) {
                return Padding(
                  padding: EdgeInsets.symmetric(horizontal: 8.5.w),
                  child: PromoCard(
                    promoName:
                        'Dengan mengisi review kamu bisa mendapatkan promo',
                    discountNominal: '50',
                    thumbnailUrl:
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
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              padding: EdgeInsets.symmetric(horizontal: 25.w),
              itemCount: ListController.to.categories.length,
              itemBuilder: (context, index) {
                final category = ListController.to.categories[index];
                return Padding(
                  padding: EdgeInsets.symmetric(horizontal: 8.5.w),
                  child: Obx(
                    () => MenuChip(
                      text: category,
                      isSelected:
                          ListController.to.selectedCategory.value == category,
                      onTap: () {
                        ListController.to.selectCategory(category);
                      },
                    ),
                  ),
                );
              },
            ),
          ),
          TitleSection(
            title: 'Menu',
            image: ImageConstants.iconAllMenu,
          ),

          Expanded(
            child: Obx(
              () => ListController.to.isLoading.value
                  ? Center(
                      child:
                          CircularProgressIndicator(color: ColorStyle.primary))
                  : SmartRefresher(
                      controller: ListController.to.refreshController,
                      enablePullDown: true,
                      onRefresh: ListController.to.onRefresh,
                      // enablePullUp: ListController.to.canLoadMore.value,
                      onLoading: () async {
                        await ListController.to.refreshDataByCategory(
                            ListController.to.selectedCategory.value);
                        ListController.to.refreshController.loadComplete();
                      },
                      child: ListView.builder(
                        padding: EdgeInsets.symmetric(horizontal: 25.w),
                        itemCount: ListController.to.filteredListApi.length,
                        itemExtent: 112.h,
                        itemBuilder: (context, index) {
                          final item = ListController.to.filteredListApi[index];
                          return Padding(
                            padding: EdgeInsets.symmetric(vertical: 8.5.h),
                            child: Material(
                              borderRadius: BorderRadius.circular(10.r),
                              elevation: 2,
                              child: Slidable(
                                endActionPane: ActionPane(
                                  motion: const ScrollMotion(),
                                  children: [
                                    SlidableAction(
                                      onPressed: (context) {
                                        ListController.to.deleteItemApi(item);
                                        print("delete {$item}");
                                      },
                                      borderRadius: BorderRadius.circular(10.r),
                                      backgroundColor: Colors.red,
                                      foregroundColor: Colors.white,
                                      icon: Icons.delete,
                                    ),
                                  ],
                                ),
                                child: MenuCard(
                                  menu: item,
                                  isSelected: false,
                                  onTap: () {
                                    Get.toNamed(Routes.detailMenuRoute,
                                        arguments: item);
                                  },
                                ),
                              ),
                            ),
                          );
                        },
                      ),
                    ),
            ),
          ),
        ],
      ),
    );
  }
}
