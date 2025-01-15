import '/utils/constants/sizes.dart';
import 'package:flutter/material.dart';

class TSpacingStyle{
  static const EdgeInsetsGeometry paddingWithAppBarHeight = EdgeInsets.only(
    top: TSizes.appBarHeight,
    left: TSizes.defultSpace,
    bottom: TSizes.defultSpace,
    right: TSizes.defultSpace
  );
}