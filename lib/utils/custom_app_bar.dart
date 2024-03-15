import 'package:flutter/material.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String titleText;
  final double height;

  const CustomAppBar({
    Key? key,
    required this.titleText,
    this.height = kToolbarHeight,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      centerTitle: true,
      title: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            titleText,
            style: TextStyle(color: Colors.white, fontSize: 20),
          )
        ],
      ),
      backgroundColor: Color(0xff48032f), // Customize your AppBar theme here
      elevation: 0,
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(height);
}
