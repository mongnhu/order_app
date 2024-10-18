import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class AppIcon extends StatelessWidget {
  final IconData icon;
  final double size = 30;
  final Color? iconColor;
  final Size? boxSize;
  final double? iconSize;

  const AppIcon({
    super.key,
    required this.icon,
    this.iconColor,
    this.boxSize,
    this.iconSize,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 50.h,
      width: 50.w,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(size.sp / 2),
        color: Theme.of(context).colorScheme.secondaryContainer,
      ),
      child: Icon(
        icon,
        color: iconColor,
        // color: Colors.black,
        size: 30.sp,
      ),
    );
  }
}
