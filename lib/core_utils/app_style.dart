import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:machine_test/core_utils/app_colors.dart';


class AppTextStyle {


  static TextStyle euclidBold(double size, Color color) {
    return TextStyle(
      fontSize: size,
      fontWeight: FontWeight.bold,
      color: color,
      fontFamily: 'EuclidCircularA_Bold',
    );
  }

  static TextStyle euclidRegular(double size, Color color) {
    return TextStyle(
      fontSize: size,
      fontWeight: FontWeight.normal,
      color: color,
      fontFamily: 'EuclidCircularA_Regular',
    );
  }

  static TextStyle euclidMedium(double size, Color color) {
    return TextStyle(
      fontSize: size,
      fontWeight: FontWeight.w500,
      color: color,
      fontFamily: 'EuclidCircularA_Medium',
    );
  }

  static TextStyle euclidSemiBold(double size, Color color) {
    return TextStyle(
      fontSize: size,
      fontWeight: FontWeight.w600,
      color: color,
      fontFamily: 'EuclidCircularA_SemiBold',
    );
  }

  static TextStyle euclidItalic(double size, Color color) {
    return TextStyle(
      fontSize: size,
      fontStyle: FontStyle.italic,
      color: color,
      fontFamily: 'EuclidCircularA_Italic',
    );
  }

  static TextStyle euclidBoldItalic(double size, Color color) {
    return TextStyle(
      fontSize: size,
      fontWeight: FontWeight.bold,
      fontStyle: FontStyle.italic,
      color: color,
      fontFamily: 'EuclidCircularA_BoldItalic',
    );
  }
}
