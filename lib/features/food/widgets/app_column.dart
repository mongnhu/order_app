import 'package:flutter/material.dart';
import 'package:food_delivery/features/home/widgets/big_text.dart';
import 'package:food_delivery/features/home/widgets/icon_and_text.dart';
import 'package:food_delivery/features/home/widgets/small_text.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class AppColumn extends StatelessWidget {
  final String text;
  final double? size;

  const AppColumn({
    super.key,
    required this.text,
    this.size,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        BigText(
          text: text,
          size: size,
        ),
        Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Row(
              children: [
                Wrap(
                  crossAxisAlignment: WrapCrossAlignment.center,
                  children: [
                    ...List.generate(5, (index) {
                      return Container(
                        alignment: Alignment.center,
                        child: Icon(
                          Icons.star,
                          color: Theme.of(context).colorScheme.primary,
                          size: 18.sp,
                        ),
                      );
                    }),
                    SizedBox(width: 15.w),
                    const SmallText(text: "4.5"),
                    SizedBox(width: 15.w),
                    const SmallText(text: "26"),
                    SizedBox(width: 5.w),
                    const SmallText(text: 'bình luận'),
                  ],
                )
              ],
            )
          ],
        ),
        SizedBox(height: 15.w),
        const Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            IconAndText(
              color: Colors.yellow,
              text: 'Normal',
              icon: Icons.circle_sharp,
            ),
            IconAndText(
              color: Colors.red,
              text: '20km',
              icon: Icons.location_on,
            ),
            IconAndText(
              color: Colors.blue,
              text: '30 phút',
              icon: Icons.access_time,
            ),
          ],
        ),
      ],
    );
  }
}
