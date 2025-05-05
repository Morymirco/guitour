import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:iconsax/iconsax.dart';
import '../theme/app_colors.dart';

class CustomIcon extends StatelessWidget {
  final String? svgName;
  final IconData? iconData;
  final double size;
  final Color? color;
  final Color? backgroundColor;
  final double padding;
  final bool isCircle;

  const CustomIcon({
    Key? key,
    this.svgName,
    this.iconData,
    this.size = 24,
    this.color,
    this.backgroundColor,
    this.padding = 8,
    this.isCircle = false,
  }) : assert(svgName != null || iconData != null, 'Either svgName or iconData must be provided'),
       super(key: key);

  @override
  Widget build(BuildContext context) {
    final iconColor = color ?? AppColors.primaryGold;
    final bgColor = backgroundColor ?? AppColors.primaryGold.withOpacity(0.1);

    Widget icon;
    if (svgName != null) {
      icon = SvgPicture.asset(
        'assets/icons/$svgName.svg',
        height: size,
        width: size,
        colorFilter: ColorFilter.mode(iconColor, BlendMode.srcIn),
      );
    } else {
      icon = Icon(
        iconData,
        size: size,
        color: iconColor,
      );
    }

    if (isCircle || backgroundColor != null) {
      return Container(
        padding: EdgeInsets.all(padding),
        decoration: BoxDecoration(
          color: bgColor,
          shape: isCircle ? BoxShape.circle : BoxShape.rectangle,
          borderRadius: !isCircle ? BorderRadius.circular(8) : null,
        ),
        child: icon,
      );
    }

    return icon;
  }
} 