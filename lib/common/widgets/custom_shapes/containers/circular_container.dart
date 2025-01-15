import '/utils/constants/colors.dart';
import 'package:flutter/material.dart';

class TCircularContainer extends StatelessWidget {
  const TCircularContainer({
    super.key, 
    this.width = 300, 
    this.height = 300, 
    this.backgroundColor = TColors.white, 
    this.borderRadius = 400, 
    this.child, 
    this.padding = 0,
  });
  final double? width;
  final double? height;
  final Color backgroundColor;
  final double borderRadius;
  final Widget? child;
  final double padding;
  
  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      height: height,
      padding: EdgeInsets.all(padding),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(borderRadius),
        color: backgroundColor
      ),
      child: child,
    );
  }
}