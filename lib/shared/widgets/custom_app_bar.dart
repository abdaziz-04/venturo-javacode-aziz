import 'package:flutter/material.dart';

import '../styles/color_style.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String title;
  final bool isCenterTitle;
  final Function? onPress;
  final bool showActions;
  final IconData? icon;

  const CustomAppBar({
    super.key,
    required this.title,
    this.onPress,
    this.isCenterTitle = true,
    this.icon,
    required this.showActions,
  });

  @override
  Size get preferredSize => Size.fromHeight(kToolbarHeight);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: Colors.white,
      title: Text(
        title,
        style: TextStyle(
          fontWeight: FontWeight.bold,
          color: ColorStyle.primary,
          decoration: TextDecoration.underline,
        ),
      ),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(
          bottom: Radius.circular(20.0),
        ),
      ),
      elevation: 5.0,
      shadowColor: Colors.grey.withOpacity(0.5),
      centerTitle: isCenterTitle,
      actions: showActions && onPress != null
          ? [
              IconButton(
                icon: Icon(icon, color: ColorStyle.danger),
                onPressed: () {
                  onPress!();
                },
              ),
            ]
          : null,
    );
  }
}
