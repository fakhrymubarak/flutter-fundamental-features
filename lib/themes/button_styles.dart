import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'colors.dart';

final ButtonStyle buttonPrimaryLarge = ElevatedButton.styleFrom(
  primary: colorPrimary,
  onPrimary: colorWhite,
  minimumSize: Size(300.w, 36.h),
  padding: const EdgeInsets.symmetric(horizontal: 16),
  shape: RoundedRectangleBorder(
    borderRadius: BorderRadius.all(
      Radius.circular(100.r),
    ),
  ),
);
