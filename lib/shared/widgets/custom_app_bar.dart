import 'package:flutter/material.dart';

import '../styles/color_style.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String title;
  final bool isCenterTitle;
  final Function? onPress;
  final bool showActions;

  const CustomAppBar({
    super.key,
    required this.title,
    this.onPress,
    this.isCenterTitle = true,
    required this.showActions,
  });

  @override
  Size get preferredSize => Size.fromHeight(kToolbarHeight);

  @override
  Widget build(BuildContext context) {
    return AppBar(
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
      backgroundColor: Colors.white,
      elevation: 5.0,
      shadowColor: Colors.grey.withOpacity(0.5),
      centerTitle: isCenterTitle,
      actions: showActions && onPress != null
          ? [
              IconButton(
                icon: Icon(Icons.logout, color: ColorStyle.danger),
                onPressed: () {
                  onPress!();
                },
              ),
            ]
          : null,
    );
  }
}
