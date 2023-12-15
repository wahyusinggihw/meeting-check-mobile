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
    return Container(
      height: height,
      width: MediaQuery.of(context).size.width,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(20),
          topRight: Radius.circular(20),
        ),
        color: const Color.fromARGB(255, 158, 53, 53),
      ),
      child: tabBar,
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(height);
}
