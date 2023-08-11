import 'package:flutter/material.dart';
import 'package:glad/utils/extension.dart';
import 'package:glad/utils/helper.dart';
import 'package:glad/utils/styles.dart';

class CustomAppBar extends StatelessWidget {
  final BuildContext context;
  final Widget? leading;
  final Widget? action;
  final String titleText1;
  final String? titleText2;
  final String? description;
  final bool? centerTitle;
  final Color? backgroundColor;
  final TextStyle? titleText1Style;
  final TextStyle? titleText2Style;

  const CustomAppBar(
      {super.key,
      required this.context,
      this.leading,
      this.action,
      required this.titleText1,
      this.titleText2,
      this.description,
      this.centerTitle = false,
      this.backgroundColor,
      this.titleText1Style,
      this.titleText2Style});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(top: getStatusBarHeight(context)),
      child: Container(
        height: AppBar().preferredSize.height,
        width: screenWidth(),
        padding: const EdgeInsets.symmetric(horizontal: 8),
        color: backgroundColor ?? Colors.transparent,
        child: centerTitle!
            ? Stack(
                alignment: Alignment.center,
                children: [
                  Positioned(left: 0, top: 0, bottom: 0, child: leading!),
                  RichText(
                      text: TextSpan(children: [
                    TextSpan(
                        text: titleText1,
                        style: titleText1Style ??
                            figtreeRegular.copyWith(
                                fontWeight: FontWeight.w100,
                                fontSize: 20,
                                color: Colors.black)),
                    TextSpan(
                        text: titleText2,
                        style: titleText2Style ??
                            figtreeMedium.copyWith(
                                fontSize: 20, color: Colors.black))
                  ]), maxLines: 1, overflow: TextOverflow.ellipsis,),
                  if (description != null)
                  Positioned(
                    bottom: 0,
                    child: Text(
                      description!,
                      style: figtreeMedium.copyWith(fontSize: 12),
                    ),
                  ),
                  if (action != null)
                    Positioned(right: 0, top: 0, bottom: 0, child: action!),
                ],
              )
            : Stack(
                alignment: Alignment.center,
                children: [
                  Row(
                    children: [
                      if (leading != null) leading!,
                      10.horizontalSpace(),
                      SizedBox(
                        width: screenWidth() * 0.8,
                        child: RichText(
                            text: TextSpan(children: [
                          TextSpan(
                              text: titleText1,
                              style: titleText1Style ??
                                  figtreeRegular.copyWith(
                                      fontWeight: FontWeight.w100,
                                      fontSize: 20,
                                      color: Colors.black)),
                          TextSpan(
                              text: titleText2,
                              style: titleText2Style ??
                                  figtreeMedium.copyWith(
                                      fontSize: 20, color: Colors.black))
                        ]), maxLines: 1, overflow: TextOverflow.ellipsis,),
                      ),
                    ],
                  ),
                  if (action != null)
                    Positioned(right: 0, top: 0, bottom: 0, child: action!),
                ],
              ),
      ),
    );
  }
}
