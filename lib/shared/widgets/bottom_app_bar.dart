import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:venturo_core/shared/controllers/bottom_app_controller.dart';
import 'package:venturo_core/shared/styles/color_style.dart';

class CButtomAppBar extends StatelessWidget {
  const CButtomAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    BottomAppController controller = Get.put(BottomAppController());

    return Container(
      decoration: BoxDecoration(
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(20),
          topRight: Radius.circular(20),
        ),
        boxShadow: const [
          BoxShadow(color: Colors.black38, spreadRadius: 0, blurRadius: 10),
        ],
        color: ColorStyle.black,
      ),
      child: ClipRRect(
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(20),
          topRight: Radius.circular(20),
        ),
        child: Obx(
          () => BottomNavigationBar(
            backgroundColor: ColorStyle.dark,
            selectedItemColor: ColorStyle.white,
            unselectedItemColor: ColorStyle.unselect,
            currentIndex: controller.selectedIndex.value,
            onTap: controller.changeIndex,
            items: const <BottomNavigationBarItem>[
              BottomNavigationBarItem(
                icon: Icon(Icons.home),
                label: 'Beranda',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.food_bank),
                label: 'Pesanan',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.person),
                label: 'Profil',
              ),
            ],
          ),
        ),
      ),
    );
  }
}
