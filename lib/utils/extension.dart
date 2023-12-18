import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:glad/screen/custom_widget/custom_toast.dart';
import 'package:glad/utils/styles.dart';
import 'package:intl/intl.dart';

extension UtilityToast on String {
  toast() => Fluttertoast.showToast(
    msg: this,
    textColor: Colors.white,
    backgroundColor: Colors.red,
    gravity: ToastGravity.CENTER,
    toastLength: Toast.LENGTH_LONG,
  );
  removeBracket() =>  replaceAll('[', '').replaceAll(']', '');
}

extension Utility on String {

  textRegular({Color color = Colors.black,double fontSize = 14,TextDecoration? underLine,FontWeight? fontWeight = FontWeight.normal,
    int? maxLines, TextOverflow? overflow,TextAlign? textAlign}) => Text(this,
    maxLines: maxLines,
    overflow: overflow,
    textAlign: textAlign,
    style: figtreeRegular.copyWith(
        color: color,
        fontSize: fontSize,
        decoration: underLine,
        fontWeight: fontWeight,
    ),);

  textMedium({Color color = Colors.black,double fontSize = 14,TextDecoration? underLine,FontWeight? fontWeight = FontWeight.w500,
    int? maxLines, TextOverflow? overflow,TextAlign? textAlign}) => Text(this,
    maxLines: maxLines,
    overflow: overflow,
    textAlign: textAlign,
    style: figtreeMedium.copyWith(
        color: color,
        fontSize: fontSize,
        decoration: underLine,
        fontWeight: fontWeight
    ),);

  textSemiBold({Color color = Colors.black,double fontSize = 14,TextDecoration? underLine,FontWeight? fontWeight = FontWeight.w600,
    int? maxLines, TextOverflow? overflow,TextAlign? textAlign}) => Text(this,
    maxLines: maxLines,
    overflow: overflow,
    textAlign: textAlign,
    style: figtreeMedium.copyWith(
        color: color,
        fontSize: fontSize,
        decoration: underLine,
        fontWeight: fontWeight
    ),);

  textBold({Color color = Colors.black,double fontSize = 14,TextDecoration? underLine,FontWeight? fontWeight = FontWeight.bold,
    int? maxLines, TextOverflow? overflow,TextAlign? textAlign}) => Text(this,
    maxLines: maxLines,
    overflow: overflow,
    textAlign: textAlign,
    style: figtreeMedium.copyWith(
        color: color,
        fontSize: fontSize,
        decoration: underLine,
        fontWeight: fontWeight
    ),);

}

void showCustomToast(BuildContext context, String message, {bool isSuccess = false}) {
  OverlayEntry overlayEntry = OverlayEntry(
    builder: (BuildContext context) {
      return CustomToast(message: message, isSuccess: isSuccess);
    },
  );

  Overlay.of(context).insert(overlayEntry);

  Future.delayed(const Duration(seconds: 4), () {
    overlayEntry.remove();
  });
}

extension Iterables<E> on Iterable<E> {
  Map<K, List<E>> groupBy<K>(K Function(E) keyFunction) => fold(
      <K, List<E>>{},
      (Map<K, List<E>> map, E element) =>
          map..putIfAbsent(keyFunction(element), () => <E>[]).add(element));
}

pressBack() {
  Get.back();
}

double screenHeight() {
  return Get.size.height;
}

double screenWidth() {
  return Get.size.width;
}

extension CustomWidget on Widget {
  navigate(
      {bool isAwait = false,
      bool isRemove = false,
      bool leftToRight = false,
      bool isInfinity = false}) async {
    if (isRemove) {
      return await Get.off(this,
          transition: Transition.rightToLeft,
          duration: const Duration(milliseconds: 500));
    } else if (isAwait) {
      return await Get.to(() => this,
          preventDuplicates: false,
          transition: Transition.rightToLeftWithFade,
          duration: const Duration(milliseconds: 500));
    } else if (isInfinity) {
      return await Get.offAll(this,
          transition: Transition.rightToLeftWithFade,
          duration: const Duration(milliseconds: 500));
    } else {
      return await Get.to(this,
          transition: Transition.rightToLeftWithFade,
          duration: const Duration(milliseconds: 500));
    }
  }
}

extension Integer on int {
  delay(Function function) {
    Future.delayed(Duration(seconds: this), () {
      function();
    });
  }

  horizontalSpace() => SizedBox(width: toDouble());

  verticalSpace() => SizedBox(height: toDouble());

  loop(Function function) {
    for (var i = 0; i < this; i++) {
      function(i);
    }
  }

  paddingLeft() {
    return EdgeInsets.only(left: toDouble());
  }

  textScaleFactor() {
    return Get.textScaleFactor;
  }

  paddingTop() {
    return EdgeInsets.only(top: toDouble());
  }

  paddingAll() {
    return EdgeInsets.all(toDouble());
  }

  paddingRight() {
    return EdgeInsets.only(right: toDouble());
  }

  paddingVertical() {
    return EdgeInsets.only(top: toDouble(), bottom: toDouble());
  }

  paddingHorizontal() {
    return EdgeInsets.only(left: toDouble(), right: toDouble());
  }

  marginAll() {
    return EdgeInsets.all(toDouble());
  }

  marginLeft() {
    return EdgeInsets.only(left: toDouble());
  }

  marginTop() {
    return EdgeInsets.only(top: toDouble());
  }

  marginRight() {
    return EdgeInsets.only(right: toDouble());
  }

  marginVertical() {
    return EdgeInsets.only(top: toDouble(), bottom: toDouble());
  }

  marginHorizontal() {
    return EdgeInsets.only(left: toDouble(), right: toDouble());
  }

  paddingOnly({
    required double top,
    required double bottom,
  }) {
    return EdgeInsets.only(
        right: toDouble(), left: toDouble(), top: top, bottom: bottom);
  }

  marginOnly({
    required double top,
    required double bottom,
  }) {
    return EdgeInsets.only(
        right: toDouble(), left: toDouble(), top: top, bottom: bottom);
  }
}

extension Capitalized on String {
  String capitalized() => substring(0, 1).toUpperCase() + substring(1).toLowerCase();
}

extension StringExtensions on String {
  bool containsIgnoreCase(String secondString) => toLowerCase().contains(secondString.toLowerCase());

//bool isNotBlank() => this != null && this.isNotEmpty;
}

double sum<T extends double>(T lhs, T rhs) => lhs + rhs;

extension DateHelper on DateTime {

  String formatDate(String dateFormatter) {
    final formatter = DateFormat(dateFormatter);
    return formatter.format(this);
  }
  bool isSameDate(DateTime other) {
    return year == other.year &&
        month == other.month &&
        day == other.day;
  }

  int getDifferenceInDaysWithNow() {
    final now = DateTime.now();
    return now.difference(this).inDays;
  }
}