import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:machine_test/core_utils/app_colors.dart';

import '../core_utils/app_style.dart';

class CommonButton extends StatelessWidget {
  final String title;
  final Color? titleColor;
  final Function() onTap;
  const CommonButton({super.key, required this.title, this.titleColor,required this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(onTap: onTap,
      child: Container(
        width: double.maxFinite,
        height: 60.h,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(15.r),
            color: AppColors.color0084FF

        ),
        child: Center(
          child: Text(
            title,
            style: AppTextStyle.euclidMedium(16.sp, titleColor??AppColors.whiteColor),
          ),
        ),
      ),
    );
  }
}
