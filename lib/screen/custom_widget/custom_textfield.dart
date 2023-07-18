import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:glad/utils/extension.dart';
import 'package:glad/utils/styles.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../utils/images.dart';
import 'container_border.dart';

class CustomTextField extends StatelessWidget {
  final String hint;
  final String text;
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
  final String? image;
  final bool? status;
  final double? imageWidth,imageHeight;
  final TextInputType? inputType;
  final bool showEdit;
  final bool withoutBorder;
  final bool? enabled;
  final int? maxLine,minLine;
  final String? error;
  final bool? obscureText;
  final bool visibleNumber;
  final double? width;
  final int? borderColor;
  final int? backgroundColor;
  final List<TextInputFormatter>? inputFormatters;
  final TextStyle? hintStyle;

  const CustomTextField({
    Key? key,
    required this.hint,
    this.controller,
    this.visibleNumber=false,
    this.onChanged,
    this.length,
    this.style,
    this.decoration,
    this.borderColor= 0xffD9D9D9,
    this.backgroundColor= 0xffFFFFFF,
    this.onEditingComplete,
    this.focusNode,
    this.onTap,
    this.imageColor,
    this.focusTag,
    this.status,
    this.imageWidth,
    this.imageHeight,
    this.inputType,
    required this.text,
    this.showEdit=false,
    this.withoutBorder=false,
    this.image,
    this.enabled,
    this.maxLine=2,
    this.minLine=1,
    this.error,
    this.obscureText = false,
    this.width,
    this.inputFormatters,
    this.hintStyle
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return withoutBorder?
    SizedBox(
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
            obscureText: obscureText!,
            keyboardType: inputType,
            style: GoogleFonts.figtree(
                textStyle: style
            ),
            onEditingComplete: onEditingComplete,
            decoration: InputDecoration(
              // hintText: hint,
              contentPadding: 10.paddingVertical(),
              labelText: hint,
              labelStyle: figtreeRegular.copyWith(
                color: Colors.white,
                fontSize: 14
              ),
              hintStyle: GoogleFonts.figtree(
                  textStyle: const TextStyle(
                      fontWeight: FontWeight.normal,
                      fontSize: 14
                  ),
              ),
              // border: InputBorder.none,
            ),
            onChanged: onChanged,
          ),

          if(image!=null)
            Align(alignment: Alignment.centerRight,
                child: SvgPicture.asset(image!,width: imageWidth,height: imageHeight,))

        ],
      ),
    ):
    Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        ContainerBorder(
          margin: 0.marginVertical(),
          padding: 10.paddingOnly(top: 15, bottom:15 ),
          borderColor: borderColor,
          backColor: backgroundColor,
          radius: 10,
          widget: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              5.horizontalSpace(),
              if(image!=null)
                Padding(
                  padding: const EdgeInsets.only(right: 5.0),
                  child: SvgPicture.asset('$image',width: imageWidth,height: imageHeight,color: imageColor,),
                ),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.only(left: 10.0),
                  child:  SizedBox(
                    width:width,
                    child: TextField(
                      focusNode: focusNode,
                      controller: controller,
                      inputFormatters:inputFormatters??[LengthLimitingTextInputFormatter(length),],
                      autofocus: false,
                      cursorColor: Colors.black,
                      onTap: onTap,
                      enabled: enabled,
                      maxLines: maxLine,
                      minLines: minLine,
                      obscureText: obscureText!,
                      keyboardType: inputType,
                      style:hintStyle?? figtreeRegular.copyWith(
                          fontSize: 16,
                          color: Colors.black
                      ),
                      onEditingComplete: onEditingComplete,
                      decoration: InputDecoration(
                        labelText: hint,
                        enabledBorder: const UnderlineInputBorder(
                          borderSide: BorderSide(color: Colors.transparent),
                        ),
                        focusedBorder: const UnderlineInputBorder(
                          borderSide: BorderSide(color: Colors.transparent),
                        ),
                        labelStyle: figtreeRegular.copyWith(
                            fontSize: 15,
                            color: const Color(0xff8A98A5)
                        ),
                        hintStyle: hintStyle??figtreeRegular.copyWith(
                            fontSize: 16,
                            color: const Color(0xff70757D)
                        ),
                        contentPadding: const EdgeInsets.all(0.0),
                        isDense: true,
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

        if(error != null)
          Visibility(
            visible: error == ''?false:true,
            child: Padding(
              padding: const EdgeInsets.only(left: 5.0,top: 7),
              child: Row(
                children: [

                  SvgPicture.asset(Images.errorIcon,width: 20,height: 20,),
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.only(left: 7.0),
                      child: Text(error.toString(),
                        style: figtreeRegular.copyWith(
                          color: const Color(0xff929292),
                        ),),
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
