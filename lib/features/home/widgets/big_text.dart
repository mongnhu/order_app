import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class BigText extends StatelessWidget {
  final Color? color;
  final String text;
  final double? size;
  final TextStyle? textStyle;
  final TextOverflow overflow;

  const BigText({
    super.key,
    this.color,
    required this.text,
    this.overflow = TextOverflow.ellipsis,
    this.textStyle,
    this.size,
  });

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      overflow: overflow,
      style: TextStyle(fontSize: size?.sp ?? 30.sp, color: color),
    );
  }
}
