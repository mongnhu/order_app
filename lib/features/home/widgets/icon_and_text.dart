import 'package:flutter/material.dart';
import 'package:food_delivery/features/home/widgets/small_text.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class IconAndText extends StatelessWidget {
  final IconData icon;
  final String text;
  final Color color;

  const IconAndText({
    super.key,
    required this.color,
    required this.text,
    required this.icon,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Icon(
          icon,
          color: color,
          size: 25.sp,
        ),
        SmallText(text: text)
      ],
    );
  }
}
