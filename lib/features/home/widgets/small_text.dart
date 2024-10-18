import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class SmallText extends StatelessWidget {
  final Color? color;
  final String text;
  final double size;
  final TextStyle? textStyle;
  final TextOverflow overflow;

  const SmallText({
    super.key,
    this.color,
    required this.text,
    this.size = 18,
    this.overflow = TextOverflow.ellipsis,
    this.textStyle,
  });

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      overflow: overflow,
      style: textStyle?.copyWith(color: color, fontSize: size.sp) ??
          TextStyle(color: color ?? Colors.black38, fontSize: size.sp),
    );
  }
}
