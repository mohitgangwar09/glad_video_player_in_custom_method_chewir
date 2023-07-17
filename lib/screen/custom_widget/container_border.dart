import 'package:flutter/material.dart';
import 'package:glad/utils/extension.dart';

class ContainerBorder extends StatelessWidget {
  final Widget widget;
  final double? height;
  final double? width;
  final int? backColor;
  final int? borderColor;
  final double radius;
  final double borderWidth;
  final EdgeInsetsGeometry? padding;
  final EdgeInsetsGeometry? margin;
  final BorderRadiusGeometry? border;
  const ContainerBorder({
    Key? key,
    required this.widget,
    this.height,
    this.width,
    this.backColor,
    this.borderColor,
    required this.radius,
    this.border,
    this.margin,
    this.padding,
    this.borderWidth = 1,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: padding ?? 0.paddingAll(),
      margin: margin ?? 0.marginAll(),
      height: height,
      width: width,
      decoration: BoxDecoration(
          color: backColor == null ? Colors.transparent : Color(backColor!),
          // color: Color(backColor!),
          borderRadius: border ??
              BorderRadius.all(
                Radius.circular(radius),
              ),
          border: Border.all(
              width: borderWidth,
              color: borderColor != null
                  ? Color(borderColor!)
                  : Colors.transparent)),
      child: widget,
    );
  }
}
