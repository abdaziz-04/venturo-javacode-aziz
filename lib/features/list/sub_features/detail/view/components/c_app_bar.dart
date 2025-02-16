import 'package:flutter/material.dart';

class CAppBar extends StatelessWidget implements PreferredSizeWidget {
  const CAppBar({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: Center(
          child: Text(
        'Detail Menu',
        style: TextStyle(fontWeight: FontWeight.bold),
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
        SizedBox(
          width: 30,
        )
      ],
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(kToolbarHeight);
}
