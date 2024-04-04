import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:food_app/utils/base_colors.dart';
import 'package:food_app/utils/base_styles.dart';

class CustomElevatedButton extends StatelessWidget {
  const CustomElevatedButton(
      {Key? key,
      required this.onPressed,
      this.title = '',
      this.padding,
      this.textStyle})
      : super(key: key);

  final VoidCallback onPressed;
  final String title;
  final EdgeInsets? padding;
  final TextStyle? textStyle;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        padding: padding,
        backgroundColor: BaseColors.pink,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10.r),
        ),
      ),
      child: Text(
        title,
        style: textStyle,
      ),
    );
  }
}

class HomePageButton extends StatelessWidget {
  const HomePageButton({
    Key? key,
    required this.callback,
    required this.name,
    required this.backgroundColor,
    required this.textColor,
    required this.padding,
  }) : super(key: key);

  final VoidCallback callback;
  final String name;
  final Color backgroundColor;
  final Color textColor;
  final EdgeInsets padding;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
        style: TextButton.styleFrom(
          foregroundColor: textColor,
          backgroundColor: backgroundColor,
          padding: padding,
          textStyle: BaseStyles.buttonTextStyle,
          tapTargetSize: MaterialTapTargetSize.shrinkWrap,
          minimumSize: const Size(100, 48),
        ),
        onPressed: callback,
        child: Text(name));
  }
}

class HomePageButton2 extends StatelessWidget {
  const HomePageButton2({
    Key? key,
    required this.onPressed,
    required this.name,
    this.backgroundColor,
    this.textColor,
    this.padding,
    this.icon,
  }) : super(key: key);

  final VoidCallback onPressed;
  final String name;
  final Color? backgroundColor;
  final Color? textColor;
  final EdgeInsets? padding;
  final IconData? icon;

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton.extended(
      backgroundColor: backgroundColor,
      foregroundColor: textColor,
      onPressed: onPressed,
      label: Text(name),
      icon: icon == null ? null : Icon(icon),
    );
  }
}
