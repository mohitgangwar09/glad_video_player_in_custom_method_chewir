import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:glad/utils/extension.dart';
import 'package:glad/utils/images.dart';
import 'package:glad/utils/styles.dart';
import 'container_border.dart';

class CustomTextField2 extends StatelessWidget {
  final String? hint;
  final TextEditingController? controller;
  final Function(String?)? onChanged;
  final Function()? onEditingComplete;
  final Function()? onTap;
  final FocusNode? focusNode;
  final int? length;
  final String? image, leadingImage;
  final double? imageWidth, imageHeight;
  final double? image2Width, image2Height;
  final String? image2;
  final TextInputType? inputType;
  final bool? enabled;
  final int? maxLine, minLine;
  final String? error;
  final bool? obscureText;
  final double? width;
  final int? borderColor;
  final Color? imageColors;
  final Color? image2Colors;
  final int? backgroundColor;
  final List<TextInputFormatter>? inputFormatters;
  final TextStyle? hintStyle;
  final Icon? suffixIcon;
  final Color? suffixIconColor;
  final bool? readOnly;
  final String title;
  final double? height;

  const CustomTextField2(
      {Key? key,
      this.hint,
      this.controller,
      this.onChanged,
      this.length,
        this.height = 60,
      this.borderColor = 0xffD9D9D9,
      this.backgroundColor = 0xffFFFFFF,
      this.onEditingComplete,
      this.focusNode,
      this.onTap,
      this.imageWidth,
      this.imageHeight,
      this.inputType,
      this.image,
      this.leadingImage,
      this.imageColors = Colors.white,
      this.enabled,
      this.maxLine = 1,
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
    return Column(
      children: [
        Row(
          children: [
            5.horizontalSpace(),
            title.textMedium(color: Colors.black, fontSize: 12),
          ],
        ),
        5.verticalSpace(),
        Stack(
          children: [
            ContainerBorder(
              margin: 0.marginVertical(),
              height: height,
              padding: 10.paddingOnly(top: 15, bottom: 15),
              borderColor: borderColor,
              backColor: backgroundColor,
              radius: 10,
              widget: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  leadingImage != null
                      ? 25.horizontalSpace()
                      : 5.horizontalSpace(),
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.only(left: 10.0),
                      child: SizedBox(
                        width: width,
                        child: TextField(
                          focusNode: focusNode,
                          controller: controller,
                          inputFormatters: inputFormatters ??
                              [LengthLimitingTextInputFormatter(length)],
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
                            hintText: hint,
                            alignLabelWithHint: true,
                            enabledBorder: const UnderlineInputBorder(
                              borderSide: BorderSide(color: Colors.transparent),
                            ),
                            focusedBorder: const UnderlineInputBorder(
                              borderSide: BorderSide(color: Colors.transparent),
                            ),
                            labelStyle: figtreeRegular.copyWith(
                                fontSize: 15, color: Colors.grey),
                            hintStyle: hintStyle ??
                                figtreeMedium.copyWith(
                                    fontSize: 16, color: Colors.grey),
                            contentPadding:
                                const EdgeInsets.symmetric(vertical: 10.0),
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
            Positioned(
              right: 13,
              top: 0,
              bottom: 0,
              child: Row(
                children: [
                  if (image != null)
                    SvgPicture.asset(
                      image!,
                      colorFilter:
                          ColorFilter.mode(imageColors!, BlendMode.srcIn),
                      width: imageWidth,
                      height: imageHeight,
                    ),
                  if (image != null) 10.horizontalSpace(),
                  if (image2 != null)
                    SvgPicture.asset(
                      image2!,
                      colorFilter:
                          ColorFilter.mode(image2Colors!, BlendMode.srcIn),
                      width: image2Width,
                      height: image2Height,
                    )
                ],
              ),
            ),
          ],
        ),
      ],
    );
  }
}
