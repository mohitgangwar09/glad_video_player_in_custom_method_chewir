import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:glad/utils/extension.dart';
import 'package:glad/utils/images.dart';
import 'package:glad/utils/styles.dart';
import 'container_border.dart';

class CustomDropdown extends StatelessWidget {
  final String? error;
  final double? width;
  final int? borderColor;
  final int? backgroundColor;
  final String? dropdownValue;
  final String hint;
  final List<String> itemList;
  final TextStyle? itemStyle;
  final TextStyle? hintStyle;
  final void Function(String?) onChanged;
  final String icon;
  final Color? iconColor;
  final double? iconHeight;
  final double? iconWidth;

  const CustomDropdown(
      {Key? key,
      this.borderColor = 0xffD9D9D9,
      this.backgroundColor = 0xffFFFFFF,
      this.error,
      this.width,
      required this.dropdownValue,
      required this.itemList,
      this.itemStyle,
      required this.onChanged,
      required this.hint,
      this.hintStyle,
      required this.icon,
      this.iconColor,
      this.iconHeight,
      this.iconWidth})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        ContainerBorder(
          margin: 0.marginVertical(),
          padding: 10.paddingOnly(top: 15, bottom: 15),
          borderColor: borderColor,
          backColor: backgroundColor,
          radius: 10,
          widget: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              5.horizontalSpace(),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.only(left: 10.0),
                  child: SizedBox(
                    width: width,
                    child: DropdownButton<String>(
                      value: dropdownValue,
                      hint: Text(hint,
                          style: hintStyle ??
                              figtreeSemiBold.copyWith(
                                  fontSize: 16, color: Colors.black)),
                      isExpanded: true,
                      padding: const EdgeInsets.symmetric(vertical: 7.0),
                      underline: const SizedBox.shrink(),
                      icon: Padding(
                        padding: const EdgeInsets.only(right: 5.0),
                        child: SvgPicture.asset(
                          icon,
                          colorFilter:
                              ColorFilter.mode(iconColor!, BlendMode.srcIn),
                          width: iconWidth,
                          height: iconHeight,
                        ),
                      ),
                      isDense: true,
                      items: itemList
                          .map<DropdownMenuItem<String>>((String value) {
                        return DropdownMenuItem<String>(
                          value: value,
                          child: Text(value,
                              style: itemStyle ??
                                  figtreeMedium.copyWith(
                                      fontSize: 16, color: Colors.black)),
                        );
                      }).toList(),
                      onChanged: onChanged,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
        if (error != null)
          Visibility(
            visible: error == '' ? false : true,
            child: Padding(
              padding: const EdgeInsets.only(left: 5.0, top: 7),
              child: Row(
                children: [
                  SvgPicture.asset(
                    Images.errorIcon,
                    width: 20,
                    height: 20,
                  ),
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.only(left: 7.0),
                      child: Text(
                        error.toString(),
                        style: figtreeRegular.copyWith(
                          color: const Color(0xff929292),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
      ],
    );
  }
}
