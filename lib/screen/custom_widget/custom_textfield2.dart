import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:glad/utils/extension.dart';
import 'package:glad/utils/images.dart';
import 'package:glad/utils/styles.dart';
import 'package:google_fonts/google_fonts.dart';
import 'container_border.dart';

class CustomTextField2 extends StatelessWidget {
  final String? hint;
  final Color? imageColor;
  final TextEditingController? controller;
  final Function(String)? onChanged;
  final Function()? onEditingComplete;
  final Function()? onTap;
  final InputDecoration? decoration;
  final TextStyle? style;
  final FocusNode? focusNode;
  final String? focusTag;
  final int? length;
  final String? image, leadingImage;
  final bool? status;
  final double? imageWidth, imageHeight;
  final double? image2Width, image2Height;
  final String? image2;
  final TextInputType? inputType;
  final bool showEdit;
  final bool withoutBorder;
  final bool? enabled;
  final int? maxLine, minLine;
  final String? error;
  final bool? obscureText;
  final bool visibleNumber;
  final double? width;
  final int? borderColor;
  final Color? underLineBorderColor;
  final Color? imageColors;
  final Color? image2Colors;
  final int? backgroundColor;
  final List<TextInputFormatter>? inputFormatters;
  final TextStyle? hintStyle;
  final Icon? suffixIcon;
  final Color? suffixIconColor;
  final bool? readOnly;
  final String title;

  const CustomTextField2(
      {Key? key,
        this.hint,
        this.controller,
        this.visibleNumber = false,
        this.onChanged,
        this.length,
        this.imageColor = Colors.white,
        this.style,
        this.underLineBorderColor = Colors.white,
        this.decoration,
        this.borderColor = 0xffD9D9D9,
        this.backgroundColor = 0xffFFFFFF,
        this.onEditingComplete,
        this.focusNode,
        this.onTap,
        this.focusTag,
        this.status,
        this.imageWidth,
        this.imageHeight,
        this.inputType,
        this.showEdit = false,
        this.withoutBorder = false,
        this.image,
        this.leadingImage,
        this.imageColors = Colors.white,
        this.enabled,
        this.maxLine = 2,
        this.minLine = 1,
        this.error,
        this.obscureText = false,
        this.width,
        this.inputFormatters,
        this.hintStyle,
        this.suffixIcon,
        this.suffixIconColor,
        this.image2Width,
        this.image2Height,
        this.image2,
        this.image2Colors,
        this.readOnly,
        required this.title})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(children: [
              5.horizontalSpace(),
              title.textMedium(color: Colors.black, fontSize: 12),
            ],),
            5.verticalSpace(),
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
                        child: TextField(
                          focusNode: focusNode,
                          controller: controller,
                          inputFormatters: inputFormatters ??
                              [
                                LengthLimitingTextInputFormatter(length),
                              ],
                          autofocus: false,
                          cursorColor: Colors.black,
                          onTap: onTap,
                          readOnly: readOnly ?? false,
                          enabled: enabled,
                          maxLines: maxLine,
                          minLines: minLine,
                          obscureText: obscureText!,
                          keyboardType: inputType,
                          style: hintStyle ??
                              figtreeRegular.copyWith(
                                  fontSize: 16, color: Colors.black),
                          onEditingComplete: onEditingComplete,
                          decoration: InputDecoration(
                            labelText: hint,
                            enabledBorder: const UnderlineInputBorder(
                              borderSide:
                              BorderSide(color: Colors.transparent),
                            ),
                            focusedBorder: const UnderlineInputBorder(
                              borderSide:
                              BorderSide(color: Colors.transparent),
                            ),
                            labelStyle: figtreeRegular.copyWith(
                                fontSize: 15, color: Colors.grey),
                            hintStyle: hintStyle ??
                                figtreeMedium.copyWith(
                                    fontSize: 16,
                                    color: Colors.grey),
                            contentPadding: const EdgeInsets.all(0.0),
                            isDense: true,
                            suffixIcon: suffixIcon,
                            suffixIconColor: suffixIconColor,
                            border: InputBorder.none,
                          ),
                          onChanged: onChanged,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
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
          )
      ],
    );
  }
}
