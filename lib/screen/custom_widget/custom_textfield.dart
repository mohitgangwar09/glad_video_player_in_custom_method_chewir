import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:glad/utils/color_resources.dart';
import 'package:glad/utils/extension.dart';
import 'package:glad/utils/styles.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../utils/images.dart';
import 'container_border.dart';

class CustomTextField extends StatelessWidget {
  final String hint;
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
  final int? backgroundColor;
  final List<TextInputFormatter>? inputFormatters;
  final TextStyle? hintStyle;
  final Icon? suffixIcon;
  final Color? suffixIconColor;

  const CustomTextField(
      {Key? key,
      required this.hint,
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
      this.suffixIconColor})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return withoutBorder
        ? SizedBox(
            height: 50,
            child: Stack(
              children: [
                TextField(
                  focusNode: focusNode,
                  controller: controller,
                  autofocus: false,
                  onTap: onTap,
                  enabled: enabled,
                  maxLines: maxLine,
                  minLines: minLine,
                  cursorColor: Colors.grey,
                  obscureText: obscureText!,
                  keyboardType: inputType,
                  style: GoogleFonts.figtree(textStyle: style),
                  onEditingComplete: onEditingComplete,
                  decoration: InputDecoration(
                    // hintText: hint,
                    contentPadding: leadingImage == null
                        ? 9.paddingVertical()
                        : const EdgeInsets.only(left: 30),
                    labelText: hint,
                    labelStyle: style,
                    enabledBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: underLineBorderColor!),
                    ),
                    focusedBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: underLineBorderColor!),
                    ),
                    hintStyle: GoogleFonts.figtree(
                      textStyle: const TextStyle(
                          fontWeight: FontWeight.normal, fontSize: 14),
                    ),
                    border: InputBorder.none,
                  ),
                  onChanged: onChanged,
                ),
                if (leadingImage != null)
                  Align(
                      alignment: Alignment.centerLeft,
                      child: SvgPicture.asset(
                        leadingImage!,
                        colorFilter:
                            ColorFilter.mode(imageColors!, BlendMode.srcIn),
                        width: imageWidth,
                        height: imageHeight,
                      )),
                if (image != null)
                  Align(
                      alignment: Alignment.centerRight,
                      child: SvgPicture.asset(
                        image!,
                        colorFilter:
                            ColorFilter.mode(imageColors!, BlendMode.srcIn),
                        width: imageWidth,
                        height: imageHeight,
                      ))
              ],
            ),
          )
        : Stack(
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
                                fontSize: 15, color: const Color(0xff8A98A5)),
                            hintStyle: hintStyle ??
                                figtreeRegular.copyWith(
                                    fontSize: 16,
                                    color: const Color(0xff70757D)),
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
            if (leadingImage != null)
              Positioned(
                top: 0,
                bottom: 0,
                left: 10,
                child: SvgPicture.asset(
                  leadingImage!,
                  colorFilter:
                  ColorFilter.mode(imageColors!, BlendMode.srcIn),
                  width: imageWidth,
                  height: imageHeight,
                ),
              ),
            if (image != null)
              Positioned(
                right: 10,
                top: 0,
                bottom: 0,
                child: SvgPicture.asset(
                  image!,
                  colorFilter:
                  ColorFilter.mode(imageColors!, BlendMode.srcIn),
                  width: imageWidth,
                  height: imageHeight,
                ),
              )
          ],
        );
  }
}
