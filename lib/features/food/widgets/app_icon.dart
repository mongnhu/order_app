import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class AppIcon extends StatelessWidget {
  final IconData icon;
  final Color? iconColor;
  final Size? boxSize;
  final double? iconSize;
  final bool isLarge;

  const AppIcon({
    super.key,
    required this.icon,
    this.iconColor,
    this.boxSize,
    this.iconSize,
    this.isLarge = false,
  });

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      cursor: SystemMouseCursors.click,
      child: Container(
        height: 50.h,
        width: 50.w,
        padding: isLarge ? const EdgeInsets.only(left: 4) : EdgeInsets.zero,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15.w),
          color: Theme.of(context).colorScheme.secondaryContainer,
        ),
        alignment: isLarge ? Alignment.centerLeft : Alignment.center,
        child: Icon(
          icon,
          color: iconColor,
          // color: Colors.black,
          size: iconSize ?? 30.sp,
        ),
      ),
    );
  }
}
