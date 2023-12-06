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
      title: Center(child: Text(titleText)),
      backgroundColor: Colors.grey, // Customize your AppBar theme here
      elevation: 0,
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(height);
}