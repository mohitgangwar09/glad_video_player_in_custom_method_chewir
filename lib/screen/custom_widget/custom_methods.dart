import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:glad/utils/extension.dart';
import 'package:glad/utils/images.dart';
import 'package:glad/utils/styles.dart';
import 'package:shimmer/shimmer.dart';

Widget customButton(String text,
    {Widget widget = const SizedBox(),
    Widget lastWidget = const SizedBox(),
    bool enableFirst = false,
    bool enableLast = false,
    required Function onTap,
    double elevation = 2,
    int fontColor = 0xff000000,
    int color = 0xff6A0030,
    double radius = 30,
    double height = 50,
    double? width,
    TextStyle? style,
    // int ? borderColor=0xff18444B,
    int borderColor = 0x00000000,
    LinearGradient? greenGradient = null,
    bool enableGradient = true,
    EdgeInsetsGeometry? margin}) {
  return InkWell(
    onTap: () {
      onTap();
    },
    child: Container(
      margin: margin,
      width: width ?? screenWidth() * 0.44,
      height: height,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.all(
            Radius.circular(radius),
          ),
          border: Border.all(color: Color(borderColor)),
          color: Color(color),
          gradient: enableGradient ? greenGradient : null),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Visibility(
            visible: enableFirst,
            child: widget,
          ),
          Visibility(
            visible: enableFirst,
            child: const SizedBox(
              width: 10,
            ),
          ),
          Text(
            text,
            style: style ??
                figtreeSemiBold.copyWith(color: Color(fontColor), fontSize: 16),
          ),
          Visibility(
            visible: enableLast,
            child: const SizedBox(
              width: 10,
            ),
          ),
          Visibility(
            visible: enableLast,
            child: lastWidget,
          ),
        ],
      ),
    ),
  );
}

Widget networkImage(
    {required String text,
    double size = 28,
    int? backColor,
    double radius = 8.0,
    double? height,
    double? width}) {
  return Container(
    width: width,
    height: height,
    decoration: BoxDecoration(
        color: Colors.black12,
        borderRadius: BorderRadius.all(
          Radius.circular(radius),
        ),
        border: Border.all(
          width: 1,
          color: backColor != null ? Color(backColor) : Colors.black12,
        )),
    child: ClipRRect(
      borderRadius: BorderRadius.circular(radius),
      child: CachedNetworkImage(
        height: height,
        imageUrl: text,
        fit: BoxFit.cover,
        placeholder: (context, url) => ClipRRect(
          borderRadius: BorderRadius.circular(radius),
          child: SizedBox(
            width: width ?? screenWidth(),
            height: height ?? screenWidth() * 0.3,
            child: Shimmer.fromColors(
              baseColor: Colors.grey[300]!,
              highlightColor: Colors.grey[100]!,
              child: Card(
                color: Colors.grey[300],
              ),
            ),
          ),
        ),
        errorWidget: (context, url, error) => Icon(
          Icons.error,
          color: Colors.grey,
          size: size,
        ),
      ),
    ),
    /*  Image.network(
      text, loadingBuilder: (context, child, loadingProgress) {
        if (loadingProgress == null) {
          return child;
        }
        return   ClipRRect(
          borderRadius: BorderRadius.circular(radius),
          child: SizedBox(
            width: width,
            height: height,
            child: Shimmer.fromColors(
              baseColor: Colors.grey[300]!,
              highlightColor: Colors.grey[100]!,
              child: Card(

                color: Colors.grey[300],
              ),
            ),
          ),
        );
      },
      errorBuilder: (context, error, stackTrace) =>
          const Icon(Icons.error,color: Colors.grey,size: 28,),
      fit: BoxFit.cover,
      height: height,
    ),*/
  );
}

// listView
Widget customList<T>(
    {
    //required Widget Function(T, int) child,
    required Widget Function(int) child,
    List<T> list = const [],
    ScrollController? controller,
    double itemSpace = 0,
    ScrollPhysics scrollPhysics = const BouncingScrollPhysics(),
    EdgeInsets padding = const EdgeInsets.all(0.0),
    Axis axis = Axis.vertical}) {
  return ListView.builder(
    padding: padding,
    controller: controller,
    physics: scrollPhysics,
    scrollDirection: axis,
    clipBehavior: Clip.none,
    shrinkWrap: true,
    itemBuilder: (context, index) => Container(child: child(index)),
    itemCount: list.isNotEmpty ? list.length : 4,
  );
}

// gridView
Widget customGrid<T>(BuildContext context,
    {required Widget Function(int) child,
    // required Widget Function(T, int) child,
    List<T> list = const [],
    crossAxisCount = 2,
    double childAspectRatio = 1.0,
    double? mainAxisExtent,
    double crossAxisSpacing = 5.0,
    double mainAxisSpacing = 2.0,
    EdgeInsets padding = const EdgeInsets.all(0.0),
    Axis axis = Axis.vertical}) {
  return GridView.builder(
    padding: padding,
    physics: const BouncingScrollPhysics(),
    scrollDirection: axis,
    shrinkWrap: true,
    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: crossAxisCount,
        crossAxisSpacing: crossAxisSpacing,
        mainAxisSpacing: mainAxisSpacing,
        childAspectRatio: childAspectRatio,
        mainAxisExtent: mainAxisExtent),
    itemBuilder: (context, index) => child(index)
    // child(list[index], index),
    ,
    itemCount: list.isNotEmpty ? list.length : 2,
    //controller: listScrollController,
  );
}

// dialog
void modalBottomSheetMenu(BuildContext context,
    {required Widget child, double radius = 20, Color color = Colors.white}) {
  showModalBottomSheet<dynamic>(
      context: context,
      isScrollControlled: true,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
            topLeft: Radius.circular(radius),
            topRight: Radius.circular(radius)),
      ),
      backgroundColor: color,
      builder: (builder) {
        return Padding(
            padding: EdgeInsets.only(
                bottom: MediaQuery.of(context).viewInsets.bottom),
            child: child);
      });
}

customDialog({
  bool barrierDismissible = false,
  var isLoader = false,
  Widget widget = const Text('Pass sub widgets'),
}) async {
  var result = await Get.dialog(
      isLoader
          ? widget
          : Align(
              alignment: Alignment.topCenter,
              child: widget,
            ),
      barrierDismissible: barrierDismissible);
  if (result != null) return result;
}

Widget separator({int color = 0xffD9D9D9}) {
  return Container(
    width: screenWidth(),
    height: 1,
    color: Color(color),
  );
}

svgIconWithOnTap({required String image, required Function onTap}) {
  return InkWell(
      onTap: () {
        onTap();
      },
      child: Padding(
        padding: const EdgeInsets.all(18.0),
        child: SvgPicture.asset(image),
      ));
}

void showPicker(
  context, {
  required Function cameraFunction,
  required Function galleryFunction,
}) {
  showModalBottomSheet(
    backgroundColor: Colors.transparent,
    context: context,
    builder: (BuildContext bc) {
      return Container(
        decoration: const BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.only(
                topLeft: Radius.circular(20), topRight: Radius.circular(20))),
        child: Wrap(
          children: <Widget>[
            ListTile(
                leading: const Icon(Icons.photo_library),
                title: const Text('Photo Library'),
                onTap: () {
                  galleryFunction();
                }),
            ListTile(
              leading: const Icon(Icons.photo_camera),
              title: const Text('Camera'),
              onTap: () async {
                cameraFunction();
              },
            ),
          ],
        ),
      );
    },
  );
}

conditionWidget({bool value = false, ValueChanged<bool?>? onChanged}) {
  return Container(
    color: const Color(0xffF5F7F9),
    padding: const EdgeInsets.only(left: 8.0, right: 8.0, top: 14, bottom: 14),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Expanded(
          child: Center(
            child: Text.rich(
                TextSpan(
                  children: [
                    TextSpan(
                        text: 'By using Twik you accept the '.tr,
                        style: figtreeRegular.copyWith(
                          fontSize: 14,
                          color: Colors.black,
                        )),
                    TextSpan(
                        text: '\nTerms & Conditions '.tr,
                        style: figtreeRegular.copyWith(
                          fontSize: 14,
                          color: Colors.black,
                        )),
                    TextSpan(
                        text: ' and '.tr,
                        style: figtreeMedium.copyWith(
                          fontSize: 14,
                          color: Colors.black,
                        )),
                    TextSpan(
                        text: ' Privacy Policy'.tr,
                        style: figtreeRegular.copyWith(
                          fontSize: 14,
                          color: Colors.black,
                        )),
                  ],
                ),
                textAlign: TextAlign.center),
          ),
        ),
      ],
    ),
  );
}

Widget checkBox({bool value = false, ValueChanged<bool?>? onChanged}) {
  return SizedBox(
    height: 35.0,
    width: 35.0,
    child: Transform.scale(
      scale: 1.2,
      child: Checkbox(
          focusColor: const Color(0xffAEADAD),
          activeColor: const Color(0xff30A8B7),
          value: value,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(4.0),
          ),
          onChanged: (newValue) {
            onChanged!(newValue);
            //   setState(() => rememberMe = newValue);
          }),
    ),
  );
}

/*ratingBar(int count,{double itemSize=20,double initialRating=3.0}) {
  return  RatingBar.builder(
    itemSize: itemSize,
    initialRating: initialRating,
    minRating: 1,
    direction: Axis.horizontal,
    allowHalfRating: true,
    itemCount: count,
    itemPadding: const EdgeInsets.symmetric(horizontal: 4.0),
    itemBuilder: (context, _) => const Icon(
      Icons.star,
      color: Colors.amber,
    ),
    onRatingUpdate: (rating) {},
  );
}*/
Widget rowWithImageAndText(
  String image,
  String t, {
  bool flexible = false,
  MainAxisAlignment mainAxisAlignment = MainAxisAlignment.center,
  Color textColor = Colors.black,
}) {
  return Row(
    mainAxisAlignment: mainAxisAlignment,
    crossAxisAlignment: CrossAxisAlignment.center,
    children: [
      SvgPicture.asset(image),
      5.horizontalSpace(),
      Visibility(
        visible: flexible,
        child: Flexible(
          child: Text(
            t,
            maxLines: 1,
            style: figtreeRegular.copyWith(color: textColor, fontSize: 14),
          ),
        ),
      ),
      Visibility(
        visible: !flexible,
        child: Text(
          t,
          maxLines: 1,
          style: figtreeRegular.copyWith(color: textColor, fontSize: 14),
        ),
      ),
    ],
  );
}

userPhoto(String image, {double size = 28}) {
  return InkResponse(
    onTap: () {
      // const LogoutScreen().navigate();
    },
    child: networkImage(
        text: image, height: 40, radius: 50, width: 40, size: size),
  );
}

Widget checkBoxView(
    {required String key, bool value = false, ValueChanged<bool?>? onChanged}) {
  return Row(
    mainAxisAlignment: MainAxisAlignment.start,
    children: [
      checkBox(
          value: value,
          onChanged: (value) {
            onChanged!(value);
          }),
      5.horizontalSpace(),
      Text(key,
          style: figtreeRegular.copyWith(
            fontSize: 14,
            color: const Color(0xff13171E),
          )),
    ],
  );
}

/*backWidget({required Widget child}){
  return CustomScrollView(
      slivers: [
        SliverToBoxAdapter(
            child: Stack(
                children: [
                  SvgPicture.asset(Images.homeBackground,fit: BoxFit.fill,),
                  child
                ]))
      ]);
}*/

cancelButton({required Function onTap, String text = 'Cancel'}) {
  return Center(
    child: InkResponse(
      onTap: () {
        onTap();
      },
      child: Align(
        child: Text(
          text,
          textAlign: TextAlign.center,
          style: figtreeMedium.copyWith(
              decoration: TextDecoration.underline,
              color: const Color(0xff8A98A5),
              fontSize: 16),
        ),
      ),
    ),
  );
}

appBar({int color = 0xffFFF3F4}) {
  return PreferredSize(
      preferredSize: const Size(0, 0),
      child: AppBar(
        elevation: 0,
        backgroundColor: Color(color),
      ));
}

Widget hideKeyboard(BuildContext context, {Widget? child}) {
  return GestureDetector(
    onTap: () {
      FocusScope.of(context).requestFocus(FocusNode());
    },
    child: child,
  );
}

Widget authBackgroundForgotOtp({Widget? widget}) {
  return Stack(
    children: [
      Align(
          alignment: Alignment.topRight,
          child: SvgPicture.asset(
            Images.otpBack2,
            fit: BoxFit.fill,
          )),
      widget!,
      Positioned(
          bottom: 0,
          right: 0,
          child: SvgPicture.asset(
            Images.otpBack1,
          ))
    ],
  );
}

validator(String error) {
  return Align(
    alignment: Alignment.centerLeft,
    child: Padding(
      padding: const EdgeInsets.only(top: 4.0),
      child: Text(
        error.toString(),
        style: figtreeRegular.copyWith(color: Colors.red),
      ),
    ),
  );
}

Widget customTextButton(
    {required Function onTap,
    String? text,
    TextDecoration? decoration,
    Color? color,
    double? fontSize}) {
  return TextButton(
      onPressed: () {
        onTap();
      },
      child: Text(
        text.toString().tr,
        style: figtreeMedium.copyWith(
            fontSize: fontSize, color: color, decoration: decoration),
      ));
}

Widget navigationBarItem(
    {required String image,
    String? text,
    required Function onTap,
    bool visible = false,
    String? title = ""}) {
  return InkWell(
    onTap: onTap(),
    child: Row(
      children: [
        SvgPicture.asset(image),
        20.horizontalSpace(),
        Text(
          text!,
          style: figtreeRegular.copyWith(fontSize: 18, color: Colors.white),
        ),
        10.horizontalSpace(),
        Visibility(
          visible: visible,
          child: Container(
            height:30,
            width: 40,
            decoration: BoxDecoration(
                border: Border.all(width: 1, color: Colors.white),
                borderRadius: BorderRadius.circular(40)),
            child: Center(
              child: Text(
                title.toString(),
                style: figtreeMedium.copyWith(color: Colors.white),

              ),
            ),
          ),
        )
      ],
    ),
  );
}
