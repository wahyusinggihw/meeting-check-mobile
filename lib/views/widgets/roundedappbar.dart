import 'package:flutter/material.dart';

class RoundedAppBar extends StatelessWidget implements PreferredSizeWidget {
  final double height;
  final TabBar tabBar;

  const RoundedAppBar({
    Key? key,
    required this.height,
    required this.tabBar,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double deviceWidth = MediaQuery.of(context).size.width;
    // EdgeInsets devicePadding = MediaQuery.of(context).padding;
    return Container(
      height: height,
      width: deviceWidth > 600 ? deviceWidth / 1.1 : deviceWidth,
      decoration: const BoxDecoration(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(20),
          topRight: Radius.circular(20),
        ),
        color: Colors.white,
      ),
      child: tabBar,
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(height);
}
