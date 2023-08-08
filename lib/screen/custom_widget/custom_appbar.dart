import 'package:flutter/material.dart';
import 'package:glad/utils/extension.dart';
import 'package:glad/utils/helper.dart';
import 'package:glad/utils/styles.dart';

class CustomAppBar extends StatelessWidget {
  final BuildContext context;
  final Widget? leading;
  final Widget? action;
  final bool richTitle;
  final String titleText1;
  final String? titleText2;
  final String? description;
  final bool? centerTitle;
  final Color? titleColor;
  final Color? backgroundColor;

  const CustomAppBar(
      {super.key,
      required this.context,
      this.leading,
      this.action,
      required this.richTitle,
      required this.titleText1,
      this.titleText2,
      this.description,
      this.centerTitle = false,
      this.titleColor,
      this.backgroundColor});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(top: getStatusBarHeight(context)),
      child: Container(
        height: AppBar().preferredSize.height,
        width: screenWidth(),
        padding: const EdgeInsets.all(8),
        color: backgroundColor ?? Colors.transparent,
        child: centerTitle!
            ? Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  if (leading != null) Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      leading!,
                    ],
                  ),
                  Column(
                    mainAxisAlignment: description != null ? MainAxisAlignment.spaceBetween : MainAxisAlignment.center,
                    children: [
                      Padding(
                        padding:
                            EdgeInsets.only(left: leading == null ? 10 : 0),
                        child: richTitle
                            ? RichText(
                                text: TextSpan(children: [
                                TextSpan(
                                    text: titleText1,
                                    style: figtreeRegular.copyWith(
                                        fontWeight: FontWeight.w100,
                                        fontSize: 20,
                                        color: Colors.black)),
                                TextSpan(
                                    text: titleText2,
                                    style: figtreeMedium.copyWith(
                                        fontSize: 20, color: Colors.black))
                              ]))
                            : Text(titleText1,
                                style: figtreeMedium.copyWith(
                                    fontSize: 20,
                                    color: titleColor ?? Colors.black)),
                      ),
                      if (description != null)
                        Text(
                          description!,
                          style: figtreeMedium.copyWith(fontSize: 12),
                        ),
                    ],
                  ),
                  action ?? const Text(''),
                ],
              )
            : Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      if (leading != null) Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          leading!,
                        ],
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 10),
                        child: RichText(
                            text: TextSpan(children: [
                          TextSpan(
                              text: titleText1,
                              style: figtreeRegular.copyWith(
                                  fontWeight: FontWeight.w100,
                                  fontSize: 20,
                                  color: Colors.black)),
                          TextSpan(
                              text: titleText2,
                              style: figtreeMedium.copyWith(
                                  fontSize: 20, color: Colors.black))
                        ])),
                      ),
                    ],
                  ),
                  action ?? const Text(''),
                ],
              ),
      ),
    );
  }
}
