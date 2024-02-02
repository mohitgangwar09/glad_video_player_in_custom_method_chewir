import 'package:cached_network_image/cached_network_image.dart';
import 'package:dio/dio.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:glad/cubit/auth_cubit/auth_cubit.dart';
import 'package:glad/cubit/dashboard_cubit/dashboard_cubit.dart';
import 'package:glad/cubit/dde_farmer_cubit/dde_farmer_cubit.dart';
import 'package:glad/cubit/livestock_cubit/livestock_cubit.dart';
import 'package:glad/cubit/profile_cubit/profile_cubit.dart';
import 'package:glad/cubit/project_cubit/project_cubit.dart';
import 'package:glad/cubit/weather_cubit/weather_cubit.dart';
import 'package:glad/screen/common/weather_chart.dart';
import 'package:glad/screen/custom_loan/apply_custom_loan.dart';
import 'package:glad/screen/dde_screen/preview_screen.dart';
import 'package:glad/screen/livestock/add_livestock.dart';
import 'package:glad/screen/livestock/livestock_cart_list_screen.dart';
import 'package:glad/utils/app_constants.dart';
import 'package:open_file_safe_plus/open_file_safe_plus.dart';
import 'package:glad/utils/color_resources.dart';
import 'dart:io' show File, Platform;
import 'package:glad/utils/extension.dart';
import 'package:glad/utils/images.dart';
import 'package:glad/utils/styles.dart';
import 'package:intl/intl.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:shimmer/shimmer.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:url_launcher/url_launcher_string.dart';

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
    double opacity = 1,
    // int ? borderColor=0xff18444B,
    int borderColor = 0x00000000,
    LinearGradient? greenGradient,
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
          color: Color(color).withOpacity(opacity),
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
                figtreeSemiBold.copyWith(color: Color(fontColor).withOpacity(opacity), fontSize: 16),
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
    double? width,
    BoxFit fit = BoxFit.cover}) {
  return Container(
    width: width,
    height: height,
    decoration: BoxDecoration(
        color: Colors.transparent,
        borderRadius: BorderRadius.all(
          Radius.circular(radius),
        ),
        border: Border.all(
          width: 1,
          color: backColor != null ? Color(backColor) : Colors.transparent,
        )),
    child: ClipRRect(
      borderRadius: BorderRadius.circular(radius),
      child: CachedNetworkImage(
        height: height,
        imageUrl: text,
        fit: fit,
        placeholder: (context, url) => SizedBox(
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
        errorWidget: (context, url, error) => Image.asset(
          Images.placeHolder,
          // fit: BoxFit.cover,
          // fit: BoxFit.contain,
        ),
      ),
    ),
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
    Axis axis = Axis.vertical,
    bool reverse = false}) {
  return ListView.builder(
    padding: padding,
    controller: controller,
    physics: scrollPhysics,
    scrollDirection: axis,
    clipBehavior: Clip.none,
    shrinkWrap: true,
    reverse: reverse,
    itemBuilder: (context, index) => Container(child: child(index)),
    itemCount: list.length,
  );
}

// gridView
Widget customGrid<T>(BuildContext context,
    {required Widget Function(int) child,
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
    itemBuilder: (context, index) => child(index),
    itemCount: list.length,
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

void showTestimonialPicker(
    context, {
      required Function videoFunction,
      required Function photoFunction,
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
                leading: const Icon(Icons.video_library),
                title: const Text('Video Library'),
                onTap: () {
                  videoFunction();
                }),
            ListTile(
              leading: const Icon(Icons.photo_library),
              title: const Text('Photo Library'),
              onTap: () async {
                photoFunction();
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
          activeColor: ColorResources.maroon,
          value: value,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(4.0),
          ),
          onChanged: (newValue) {
            // onChanged!(newValue);
            //   setState(() => rememberMe = newValue);
          }),
    ),
  );
}

Widget checkBox2({bool value = false, ValueChanged<bool?>? onChanged, double opacity = 1}) {
  return Container(
    height: 30,
    width: 30,
    decoration: BoxDecoration(border: Border.all(color: ColorResources.maroon.withOpacity(opacity), width: 2), borderRadius: BorderRadius.circular(8)),
    child: value ? Icon(Icons.check, color: ColorResources.maroon.withOpacity(opacity)) : const SizedBox.shrink(),
  );
}

String getYoutubeVideoId(String url) {
  return url == '' ? '' : url.split('v=')[1];
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

Widget hideKeyboard(BuildContext context,{Widget? child}){
  return GestureDetector(
    onTap: (){
      FocusScope.of(context).requestFocus(FocusNode());
    },
    child: child,
  );
}


Widget authBackgroundForgotOtp({Widget? widget}){
  return Stack(
    children: [

      Align(
          alignment: Alignment.topRight,child: SvgPicture.asset(Images.otpBack2,
        fit: BoxFit.fill,)),

      widget!,

      Positioned(
          bottom: 0,right: 0,child: SvgPicture.asset(Images.otpBack1,))

    ],
  );
}

Widget authBackgroundRegisterPopUp({Widget? widget}){
  return Stack(
    children: [

      Align(
          alignment: Alignment.topRight,child: SvgPicture.asset(Images.otpBack2,
        fit: BoxFit.fill,)),

      widget!,

      Positioned(
          bottom: 0,right: 0,child: SvgPicture.asset(Images.otpBack1,))

    ],
  );
}



validator(String error,{Color color = Colors.red}) {
  return Padding(
    padding: const EdgeInsets.only(top: 8.0),
    child: Row(
      children: [

        Image.asset(
          Images.errorIcon,
          width: 23,
          height: 23,
          color: color,
        ),

        8.horizontalSpace(),

        Expanded(
          child: Align(
            alignment: Alignment.centerLeft,
            child: Padding(
              padding: const EdgeInsets.only(top: 4.0),
              child: Text(error.toString(),
                style: figtreeRegular.copyWith(
                    color: color
                ),),
            ),
          ),
        ),
      ],
    ),
  );
}

Widget customTextButton({required Function onTap,String? text,TextDecoration? decoration,Color? color, double? fontSize}){
  return TextButton(onPressed: (){
    onTap();
  }, child: Text(text.toString().tr,
      style: figtreeMedium.copyWith(
          fontSize: fontSize,
          color: color,
          decoration: decoration
    ),));
}

Widget navigationBarItem(
    {required String image,
    String? text,
    required Function onTap,
    bool visible = false,
    String? title = ""}) {
  return InkWell(
    onTap: () => onTap(),
    child: Row(
      children: [
        SizedBox(
          width: 25,
          child: SvgPicture.asset(image),
        ),
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


Widget openDrawer({required Widget child,required Function onTap}){

  return InkWell(
    onTap: (){
      onTap();
    },
    child: child,
  );
}

Widget closeDrawer({required Widget child}){

  return Builder(builder: (context){
    return InkWell(
      onTap: (){
        pressBack();
      },
      child: child,
    );
  });
}

// bottom Navigation View
bottomNavigationItem(String text, String image,BuildContext context,int selectedIndex , int i,String selectedImage) {
  return Expanded(
    flex: 1,
    child: InkWell(
      onTap: (){
        // BlocProvider.of<DashboardCubit>(context).addLast(i);
        BlocProvider.of<DashboardCubit>(context).state.navigationQueue.addLast(i);
        BlocProvider.of<DashboardCubit>(context).selectedIndex(i);

      },
      child: Container(
        padding: const EdgeInsets.only(left:  0,right: 0,top:11,bottom:11),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          color: selectedIndex == i ? ColorResources.primary:Colors.transparent,
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [

            selectedIndex == i?
            SvgPicture.asset(selectedImage,width: 28,height: 28):
            SvgPicture.asset(image,width: 28,height: 28),

            Padding(
              padding: const EdgeInsets.only(top: 8),
              child: Text(text,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: figtreeRegular.copyWith(
                    fontSize: 10,
                    color: selectedIndex == i?ColorResources.yellow:Colors.white
                    ,
                  )),
            )
          ],
        ),
      ),
    ),
  );
}

Widget landingBackground(){
  return  Positioned(
    right: 0,
    child: SvgPicture.asset(
      Images.ppBg,
      alignment: Alignment.topRight,
    ),
  );
}

BoxDecoration boxDecoration({Color borderColor= Colors.transparent,
  double borderWidth = 0,double borderRadius = 0,Color backgroundColor = Colors.transparent,}){
  return BoxDecoration(
    border: Border.all(color: borderColor,width: borderWidth),
    borderRadius: BorderRadius.circular(borderRadius),
    color: backgroundColor
  );
}

Widget customProjectContainer({required Widget child,double? width,double? height,double? marginTop =20,double? borderRadius = 20,double? marginLeft = 10}){
  return Container(
    margin: EdgeInsets.only(left:marginLeft!,top: marginTop!),
    width: width,
    height: height,
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(borderRadius!),
      border: Border.all(color: const Color(0xffDCDCDC),width: 1),
      boxShadow:[
    BoxShadow(
    color: Colors.grey.withOpacity(0.3),
      blurRadius: 16.0,
      offset: const Offset(0, 5))],
    ),
    child: child,
  );
}

Widget farmerProjectDesign(){
  return Padding(
    padding: const EdgeInsets.all(15.0),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [

        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text("Dam Construction",
            style: figtreeMedium.copyWith(
              color: Colors.black,
              fontSize: 18
            ),),

            Container(
              padding: const EdgeInsets.symmetric(vertical: 3,horizontal: 7),
              decoration: boxDecoration(
                borderRadius: 30,
                borderColor: const Color(0xff6A0030),
              ),
              child: Text("Active",
              style: figtreeMedium.copyWith(
                color: const Color(0xff6A0030),
                fontSize: 12

              ),),
            )
          ],
        ),

        Padding(
          padding: const EdgeInsets.only(top: 2.0),
          child: Text("Water Management",
            style: figtreeRegular.copyWith(
                color: const Color(0xff808080),
                fontSize: 12
            ),),
        ),

        Padding(
          padding: const EdgeInsets.only(top: 10.0),
          child: Text("Construct a water tank and water trough in night paddock plus water pump …",
            style: figtreeRegular.copyWith(
                color: const Color(0xff808080),
                fontSize: 14
            ),),
        ),

        20.verticalSpace(),

        Container(
          height: 60,
          padding: 20.paddingHorizontal(),
          decoration: boxDecoration(
            backgroundColor: const Color(0xffFFF3F4),
            borderRadius: 10
          ),child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [

            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [

                "UGX 3.2M".textSemiBold(color: Colors.black, fontSize: 16),

                "Investment".textMedium(fontSize: 12,color: const Color(0xff808080)),



              ],
            ),

            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [

                "UGX 4.5M".textSemiBold(color: Colors.black, fontSize: 16),

                "Revenue".textMedium(fontSize: 12,color: const Color(0xff808080)),



              ],
            ),


            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [

                "40%".textSemiBold(color: Colors.black, fontSize: 16),

                "ROI".textMedium(fontSize: 12,color: const Color(0xff808080)),



              ],
            ),


          ],
        ),
        ),

        15.verticalSpace(),

        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text.rich(
              TextSpan(
                children: [
                   TextSpan(text: 'Loan: ',
                       style: figtreeMedium.copyWith(
                           color: const Color(0xff808080),
                           fontSize: 12
                       )),
                  TextSpan(
                    text: 'UGX 3.7M',
                    style: figtreeMedium.copyWith(
                      color: Colors.black,
                      fontSize: 12
                    ),
                  ),
                ],
              ),),
            Text.rich(
              TextSpan(
                children: [
                   TextSpan(text: 'EMI/MO: ',
                       style: figtreeMedium.copyWith(
                           color: const Color(0xff808080),
                           fontSize: 12
                       )),
                  TextSpan(
                    text: 'UGX 4.5k',
                    style: figtreeMedium.copyWith(
                      color: Colors.black,
                      fontSize: 12
                    ),
                  ),
                ],
              ),),

            Text.rich(
              TextSpan(
                children: [
                  TextSpan(text: 'Balance: ',
                      style: figtreeMedium.copyWith(
                          color: const Color(0xff808080),
                          fontSize: 12
                      )),
                  TextSpan(
                    text: '40%',
                    style: figtreeMedium.copyWith(
                        color: Colors.black,
                        fontSize: 12
                    ),
                  ),
                ],
              ),),
          ],
        ),

        30.verticalSpace(),

        Row(
          children: [

            CircleAvatar(
              radius: 30,
              child: Image.asset(Images.sampleUser,
              fit: BoxFit.cover,width: 80,height: 80,)),

            12.horizontalSpace(),

            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [

                "Matts Francesca".textMedium(fontSize: 14,),

                5.verticalSpace(),

                "+256 758711344".textRegular(fontSize: 12, ),

                5.verticalSpace(),

                "Luwum St. Rwoozi, Kampala...".textRegular(fontSize: 12,),

              ],
            )

          ],
        ),

      ],
    ),
  );
}

Widget textRegular({Color color = Colors.transparent,double fontSize = 14,TextDecoration? underLine}){
  return Text("data",
  style: figtreeRegular.copyWith(
    color: color,
    fontSize: fontSize,
    decoration: underLine
  ),);
}

Widget farmerBackground(){
  return  Padding(
    padding: const EdgeInsets.only(left:0.0),
    child: SvgPicture.asset(
      Images.farmerBackground,
      alignment: Alignment.topCenter,
    ),
  );
}

Widget customPaint(Color color) {
  return CustomPaint(
      size: const Size(1.1, double.infinity),
      painter: DashedLineVerticalPainter(color: color));
}

Widget horizontalPaint() {
  return CustomPaint(
    size: const Size(1.1, double.infinity),
    painter: DashLinePainter(),
  );
}

class DashedLineVerticalPainter extends CustomPainter {
  DashedLineVerticalPainter({required this.color});
  final Color color;
  @override
  void paint(Canvas canvas, Size size) {
    double dashHeight = 2, dashSpace = 2, startY = 0;
    final paint = Paint()
      ..color = color
      ..strokeWidth = size.width;
    while (startY < size.height) {
      canvas.drawLine(Offset(0, startY), Offset(0, startY + dashHeight), paint);
      startY += dashHeight + dashSpace;
    }
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => false;


}

Widget documentImage(String image, Function() onTapCancel, {bool isPDF = false}) {
  return Stack(
    children: [
      InkWell(
        onTap: isPDF ? () async {
          await Permission.manageExternalStorage.request();
          var result = await OpenFileSafePlus.open(File(image).path);
          print(result.message);
        } : () {
          PreviewScreen(previewImage: image.toString(),).navigate();
        },
        child: Container(
          decoration: BoxDecoration(
            border: Border.all(color: const Color(0xFF819891)),
            borderRadius: BorderRadius.circular(200),
          ),
          child: Padding(
            padding: const EdgeInsets.all(4.0),
            child: ClipRRect(
                borderRadius: BorderRadius.circular(200),
                child: isPDF ? Image.asset(Images.pdfLogo,
                  fit: BoxFit.fill,
                  height: 70,
                  width: 70,
                ) : isUrl(image) ? CachedNetworkImage(
                  imageUrl: image, fit: BoxFit.fill,
                    height: 70,
                    width: 70, errorWidget: (_, __, ___) => Image.asset(
                  Images.sampleVideo,
                  fit: BoxFit.fill,
                  height: 70,
                  width: 70,)) : Image.file(File(image), fit: BoxFit.fill,
                    height: 70,
                    width: 70, errorBuilder: (_, __, ___) => Image.asset(
                  Images.sampleVideo,
                  fit: BoxFit.fill,
                  height: 70,
                  width: 70,
                )),),
          ),
        ),
      ),
      Positioned(
        right: 0,
        child: InkWell(
          onTap: onTapCancel,
          child: Container(
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(200),
                color: Colors.white),
            child: SvgPicture.asset(
              Images.cancelImage,
            ),
          ),
        ),
      ),
    ],
  );
}

Widget viewDocumentImage(String image, {bool isPDF = false}) {
  return InkWell(
    onTap: isPDF ? () async {
      var dir = await getApplicationDocumentsDirectory();
      await Permission.manageExternalStorage.request();
      await Dio().download(image, "${"${dir.path}/fileName"}.pdf");
      await OpenFileSafePlus.open("${"${dir.path}/fileName"}.pdf");
    } : () {
      PreviewScreen(previewImage: image.toString(),).navigate();
    },
    child: Container(
      decoration: BoxDecoration(
        border: Border.all(color: const Color(0xFF819891)),
        borderRadius: BorderRadius.circular(200),
      ),
      child: Padding(
        padding: const EdgeInsets.all(4.0),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(200),
          child: isPDF ? Image.asset(Images.pdfLogo,
            fit: BoxFit.fill,
            height: 70,
            width: 70,
          ) : CachedNetworkImage(imageUrl: image, fit: BoxFit.fill,
              height: 70,
              width: 70, errorWidget: (_, __, ___) => Image.asset(
                Images.sampleVideo,
                fit: BoxFit.fill,
                height: 70,
                width: 70,
              )),),
      ),
    ),
  );
}


class DashLinePainter extends CustomPainter {
  final Color color;
  final double strokeWidth;
  final double dashWidth;
  final double dashSpace;

  DashLinePainter({
    this.color = ColorResources.grey,
    this.strokeWidth = 1.0,
    this.dashWidth = 5.0,
    this.dashSpace = 5.0,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final Paint paint = Paint()
      ..color = color
      ..strokeWidth = strokeWidth
      ..style = PaintingStyle.stroke;

    // Horizontal Dash Line
    double y = size.height / 2;
    double startX = 0.0;
    while (startX < size.width) {
      double endX = startX + dashWidth;
      canvas.drawLine(Offset(startX, y), Offset(endX, y), paint);
      startX += dashWidth + dashSpace;
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
   return false;
  }
}

Widget arrowBackButton({Color? color, void Function()? onTap}) {
  return InkWell(
      onTap: onTap ?? () {
        pressBack();
      },
      child: Container(
        height: AppBar().preferredSize.height,
        margin: const EdgeInsets.symmetric(horizontal: 3),
        padding: const EdgeInsets.symmetric(horizontal: 3),
        child: color != null
          ? SvgPicture.asset(
        Images.arrowBack,
        colorFilter: const ColorFilter.mode(Colors.white, BlendMode.srcIn),
      ) : SvgPicture.asset(Images.arrowBack),));
}

Widget customShadowContainer({bool enabled=true,
  double? width, int margin=6,
  bool enabledBack=false,Color color=Colors.white,Color backColor=Colors.white,double elevation=0.5,double radius=20, String hintText='Search', Function ? textFieldOnTap,Function ? onTap,Function ? backOnTap,ValueChanged<String>? onChanged,bool enabledSearch=false,bool enableLoc=false,
  bool showCross=true,bool showMap=false,bool
  boxShadow=true, required Widget child }) {
  return Container(
      width: width,
      margin: margin.marginOnly(top: 0, bottom: 0),
      decoration: BoxDecoration(
        color:color ,
        border: Border.all(color: backColor,),
        borderRadius: BorderRadius.circular(radius),
        boxShadow:boxShadow? [
          BoxShadow(
              color: Colors.grey.withOpacity(0.5),
              blurRadius: 16.0,
              offset: const Offset(0, 5)
          ),
        ]:null,
      ),
      child: child
  );
}

Widget sizeBox(){
  return const SizedBox(width: 0,height: 0,);
}

Widget logOut(BuildContext context){
  return InkWell(
    onTap: () {
      BlocProvider.of<AuthCubit>(context).clearSharedData();
      // BlocProvider.of<DashboardCubit>(context).selectedIndex(0);
      BlocProvider.of<DashboardCubit>(context).emit(DashboardState.initial());
      BlocProvider.of<AuthCubit>(context).emit(AuthCubitState.initial());
    },
    child: Row(children: [
      SvgPicture.asset(Images.logout,height: 25,width:25,),
      15.horizontalSpace(),
      Text('Logout',style: figtreeRegular.copyWith(fontSize: 18),)
    ],),
  );
}

Future<void> launchWhatsApp(var mobile) async {
  Uri url = Uri.parse('https://api.whatsapp.com/send?phone=${mobile.toString()}&text=Hi! Glad');
  if (!await launchUrl(url, mode: LaunchMode.externalNonBrowserApplication)) {
    throw Exception('Could not launch $url');
  }
}

Future<void> callOnMobile(var mobile)async{

  launchUrlString("tel:${mobile.toString()}");
}


Widget phoneCall(mobile){
  return InkWell(
    onTap: ()async{
      await callOnMobile(mobile);
    },
    child: SvgPicture.asset(
      Images.call,
      width: 45,
      height: 45,
    ),
  );
}

Widget whatsapp(mobile){
  return InkWell(
    onTap: ()async{
      await launchWhatsApp(mobile);
    },
    child: SvgPicture.asset(
      Images.whatsapp,
      width: 40,
      height: 40,
    ),
  );
}
/////////////Seprator////////////
Widget seprator({int color = 0xffD9D9D9}) {
  return Container(
    width: screenWidth(),
    height: 1,
    color: Color(color),
  );
}

/////////////SearchBox//////////

Widget searchBox({bool enabled=true,
  double? width,
  bool enabledBack=false, String hintText='Search', Function ? onTap,Function ? backOnTap,ValueChanged<String>? onChanged,bool enabledSearch=false,bool enableLoc=false,bool showCross=true,required TextEditingController controller}) {
  return Container(
    margin: 15.marginOnly(top: 0, bottom: 15),
    padding:!showCross?const EdgeInsets.only(left: 15,right: 10,top: 13,bottom: 13):
    const EdgeInsets.only(left: 15,right: 10,top: 10,bottom: 10),
    //  padding:const EdgeInsets.only(left: 15,right: 10,top: 15,bottom: 15),
    decoration:     BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(10),
    ),
    child:Row(
      children: [
        Visibility(
            visible: enabledSearch,
            child: SvgPicture.asset(Images.search)),
        Visibility(
          visible: enabledBack,
          child: InkResponse(
              onTap: (){
                backOnTap!();
              },
              child: const Icon(Icons.arrow_back_outlined,color: Color(0xff2A303A),)),
        ),

        13.horizontalSpace(),
        Expanded(
          child: TextField(
            controller: controller,
            enabled: enabled,
            onChanged: (value){
              onChanged!(value);
            },
            style: figtreeRegular.copyWith(
                color:  const Color(0xff929292),
                fontSize: 16
            ),cursorColor:const Color(0xff2A303A),

            decoration: InputDecoration(

                hintText:hintText ,
                border: InputBorder.none,
                hintStyle : figtreeRegular.copyWith(
                    color:  const Color(0xff929292),
                    fontSize: 16
                )),
          ),
        ),
        Visibility(
            visible: showCross,
            child: InkResponse(
                onTap: () {
                  onTap!();
                },
                child: SvgPicture.asset(Images.cross))),

      ],
    ),
  );
}

Future<DateTime> selectedFutureDate(BuildContext context) async {
  DateTime selectedDate = DateTime.now();
  final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: selectedDate,
      firstDate: DateTime.now(),
      lastDate: DateTime(2030,1));

  return picked!;
}

Future<DateTime> selectedDate(BuildContext context) async {
  DateTime selectedDate = DateTime.now();
  final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: selectedDate,
      firstDate: DateTime(1930, 1),
      lastDate: DateTime.now());

  return picked!;
}

void ageToast(BuildContext context){
  showCustomToast(context, "Minimum age required is 18");
}

bool isAdult(String dob) {
  final dateOfBirth = DateFormat("MM-dd-yyyy").parse(dob);
  final now = DateTime.now();
  final eighteenYearsAgo = DateTime(
    now.year - 18,
    now.month,
    now.day + 1, // add day to return true on birthday
  );
  return dateOfBirth.isBefore(eighteenYearsAgo);
}

Future<DateTime> selectedDateFarmer(BuildContext context) async {
  DateTime selectedDate = DateTime.now();
  final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: selectedDate,
      firstDate: DateTime(1920, 1),
      lastDate: DateTime.now());

  return picked!;
}

Future<Position> getCurrentLocation() async{
  return await Geolocator.getCurrentPosition(
      desiredAccuracy: LocationAccuracy.high
  );
}

Widget  errorText(String s) {
  return Text(s,
    textAlign:TextAlign.center,
    style: figtreeMedium.copyWith(
        color:   Colors.black,
        fontSize: 20
    ),);
}

bool equalsIgnoreCase(String? string1, String? string2) {
  return string1?.toUpperCase() == string2?.toLowerCase();
}

String getCurrencyString(dynamic value, {String unit = 'UGX '}){
  if(value >= 1000) {
    if(value/1000 >= 1000) {
      if((value/1000)/1000 >= 1000) {
        return '$unit${removeZeroesInFraction((value/1000/1000/1000).toStringAsFixed(2))}B';
      }
      return '$unit${removeZeroesInFraction((value/1000/1000).toStringAsFixed(2))}M';
    }
    return '$unit${removeZeroesInFraction((value/1000).toStringAsFixed(2))}K';
  }
  return '$unit$value';
}

removeZeroesInFraction(String value){
  String value1 = double.parse(value).toStringAsFixed(2);
  if(int.parse(value1.split('.')[1]) == 0){
    return value1.split('.')[0];
  }else if(int.parse(value1.split('.')[1]) % 10 == 0) {
    return '${value1.split('.')[0]}.${int.parse(value1.split('.')[1]) ~/ 10}';
  }
  return value1;
}

bool isUrl(String pass) {
  return pass.startsWith('http');
}
 int getDaysInMonth(int year, int month) {
if (month == DateTime.february) {
final bool isLeapYear = (year % 4 == 0) && (year % 100 != 0) || (year % 400 == 0);
return isLeapYear ? 29 : 28;
}
const List<int> daysInMonth = <int>[31, -1, 31, 30, 31, 30, 31, 31, 30, 31, 30, 31];
return daysInMonth[month - 1];
}


String formatProjectStatus(String status) {
  String formattedStatus = '';
  if(status.contains('_')) {
    List sta = status.split('_');
    formattedStatus = sta.map((e) => e = e.toString().substring(0, 1).toUpperCase() + e.toString().substring(1)).toList().join(' ');
  } else if(status.contains('-')) {
    List sta = status.split('-');
    sta = sta.map((e) => e = e.toString().substring(0, 1).toUpperCase() + e.toString().substring(1)).toList();
    if(status == 'recommendation-from-the-lc'){
      sta[sta.length - 1] = sta[sta.length - 1].toString().toUpperCase();
    }
    formattedStatus = sta.join(' ');
  } else{
    formattedStatus = status.substring(0, 1).toUpperCase() + status.substring(1);
  }

  return formattedStatus;
}

Widget weatherWidget(){
  return BlocBuilder<WeatherCubit,WeatherState>(builder: (context,state){
    if(state.responseWeather!=null){
      return InkWell(
        onTap: () {
          WeatherChart(lat: state.responseWeather?.lat, long: state.responseWeather?.lon,).navigate();
        },
        child: Stack(
          children: [

            Image.asset(Images.weather),

            Positioned(
              right: 80,
              top: 30,
              child: Text(state.responseWeather!.current!.temp!=null?'${double.parse(state.responseWeather!.current!.temp.toString()).toStringAsFixed(1)}°' : '',
                style: figtreeBold.copyWith(
                  fontSize: 36,
                    color: Colors.black
                ),),),
            Builder(
              builder: (context) {
                String cityName = '';
                for (var name in state.responseAddress!.results.toList()[0].addressComponents.toList()) {
                  print('${name.types} ${name.longName}');
                  if(name.types.contains('administrative_area_level_3') && name.longName.isNotEmpty){
                    cityName = name.longName;
                    break;
                  } else if(name.types.contains('administrative_area_level_2') && name.longName.isNotEmpty){
                    cityName = name.longName;
                    break;
                  }
                }
                return Positioned(
                  right: 40,
                  top: 76,
                  child: Text('$cityName, ${DateFormat('dd MMM').format(DateTime.now())}',
                    style: figtreeSemiBold.copyWith(
                        fontSize: 16,
                        color: Colors.black
                    ),),);
              }
            ),

            Positioned(
              left: 30,
              bottom: 38,
              child: Text(state.responseWeather!.current!.windSpeed!=null?'${double.parse((state.responseWeather!.current!.windSpeed*3.6).toString()).toStringAsFixed(2)} km/hr':'0 km/hr',
                style: figtreeBold.copyWith(
                    color: Colors.black
                ),),),

            Positioned(
              left: 0,
              right: 0,
              bottom: 38,
              child: SizedBox(
                width: screenWidth(),
                child: Center(
                  child: Text(double.parse((state.responseWeather!.current!.humidity.toString()??'0').toString()).toStringAsFixed(2),
                    style: figtreeBold.copyWith(
                        color: Colors.black
                    ),),
                ),
              ),),

            Positioned(
              right: 30,
              bottom: 38,
              child: state.responseWeather!.minutely!=null?Text('${double.parse((state.responseWeather!.minutely!.isNotEmpty?state.responseWeather!.minutely![0].precipitation.toString():'0').toString()).toStringAsFixed(2)} %',
                style: figtreeBold.copyWith(
                  color: Colors.black,
                ),):const SizedBox.shrink()),

          ],
        ),
      );
    }else{
      return Image.asset(Images.weather);
    }
  });
}

Widget selectFarmer({String? userId, String? livestockId,bool isCustomLoan = false, int? removeFarmerId}){
  TextEditingController searchEditingController = TextEditingController();
  return BlocBuilder<DdeFarmerCubit,DdeState>(
      builder: (context,state){
        return Column(
          children: [
            Stack(
              children: [
                SizedBox(
                  width: screenWidth(),
                  child: Align(
                    alignment: Alignment.topLeft,
                    child: Padding(
                      padding: const EdgeInsets.only(left: 15.0,top: 2),
                      child: TextButton(onPressed: (){
                        pressBack();
                      }, child: Text("Cancel",
                        style: figtreeMedium.copyWith(
                            color: const Color(0xff6A0030),
                            fontSize: 14
                        ),)),
                    ),
                  ),
                ),

                Align(
                  alignment: Alignment.center,
                  child: Padding(padding: const EdgeInsets.only(top: 11),
                      child: "Select Farmer".textMedium(
                          fontSize: 22
                      )),
                ),

              ],
            ),

            Stack(
              children: [
                Container(
                  height: 50,
                  decoration: boxDecoration(
                      borderColor: Colors.grey,
                      borderRadius: 62,
                      backgroundColor: Colors.white),
                  width: screenWidth()-16,
                  child: Row(
                    children: [
                      13.horizontalSpace(),
                      SvgPicture.asset(Images.searchLeft),
                      13.horizontalSpace(),
                      Expanded(
                          child: TextField(
                            controller: searchEditingController,
                            onChanged: (value){
                              BlocProvider.of<DdeFarmerCubit>(context).getFarmer(context, '${BlocProvider.of<DdeFarmerCubit>(context).state.selectedRagRatingType}'.toLowerCase(), false,searchQuery: value.toString());
                            },
                            decoration: const InputDecoration(
                                border: InputBorder.none, hintText: "Search by..."),
                          )),
                    ],
                  ),
                ),
                Positioned(top: 0,bottom: 0,right:7,child: IconButton(
                    onPressed: () {
                      // setState(() {
                        searchEditingController.clear();
                        BlocProvider.of<DdeFarmerCubit>(context).getFarmer(context, '${BlocProvider.of<DdeFarmerCubit>(context).state.selectedRagRatingType}'.toLowerCase(), false,searchQuery: '');
                      // });
                    },
                    icon: const Icon(Icons.clear)))
              ],
            ),

            state.response!.farmerMAster!.isNotEmpty ? Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.only(bottom: 120, left: 0),
                child: customList(list: state.response!.farmerMAster!,child: (int i) {
                  return Padding(
                    padding: const EdgeInsets.only(
                        left: 10, right: 20, bottom: 0,top: 10),
                    child: Container(
                      decoration: state.selectedIndex == null?null:
                      state.selectedIndex==i?boxDecoration(
                          borderRadius: 10,
                          backgroundColor: const Color(0xffFBF9F9)
                      ):null,
                      child: InkWell(
                        onTap: (){
                          pressBack();
                          if(userId ==null){
                            if(isCustomLoan) {
                              BlocProvider.of<LivestockCubit>(context).selectedDdeFarmerLivestockDetail(state.response!.farmerMAster![i]);
                            } else {
                              BlocProvider.of<LivestockCubit>(context)
                                  .livestockDetailApi(
                                  context, livestockId.toString(),
                                  userId: state.response!.farmerMAster![i]
                                      .userId.toString());
                            }
                          }else{
                            LiveStockCartListScreen(userId:state.response!.farmerMAster![i].userId.toString()).navigate();
                          }
                          if(isCustomLoan) {
                            BlocProvider.of<ProjectCubit>(context).customLoanFormApi(context, BlocProvider.of<LivestockCubit>(context).state.selectedLivestockFarmerMAster!.id.toString(), isLoadingRequired: false);
                          }
                        },
                        child: Padding(
                          padding:
                          const EdgeInsets.fromLTRB(15.0, 10, 0, 5),
                          child: Row(
                            crossAxisAlignment:
                            CrossAxisAlignment.start,
                            children: [
                              state.response!.farmerMAster![i].photo == null ?Image.asset(Images.sampleUser):
                              networkImage(text: state.response!.farmerMAster![i].photo!,height: 46,width: 46,radius: 40),
                              15.horizontalSpace(),
                              Column(
                                crossAxisAlignment:
                                CrossAxisAlignment.start,
                                children: [
                                  Text(state.response!.farmerMAster![i].name!,
                                      style: figtreeMedium.copyWith(
                                          fontSize: 16,
                                          color: Colors.black)),
                                  4.verticalSpace(),
                                  Row(
                                    children: [
                                      /*Text(
                                          "${countryCode == ""? "":countryCode!=null?countryCode.toString():""} ${state.response!.farmerMAster![i].phone.toString()}"
                                          ,
                                          style:
                                          figtreeRegular.copyWith(
                                              fontSize: 12,
                                              color: Colors.black)),*/

                                    ],
                                  ),
                                  4.verticalSpace(),
                                  Row(
                                    crossAxisAlignment:
                                    CrossAxisAlignment.end,
                                    children: [
                                      SizedBox(
                                        width: MediaQuery.of(context)
                                            .size
                                            .width *
                                            0.5,
                                        child: Text(
                                          state.response!.farmerMAster![i].address!=null?
                                          state.response!.farmerMAster![i].address!.address!=null?state.response!.farmerMAster![i].address!.address!:"":"",
                                          style:
                                          figtreeRegular.copyWith(
                                            fontSize: 12,
                                            color: Colors.black,
                                            overflow:
                                            TextOverflow.ellipsis,
                                          ),
                                        ),
                                      ),
                                    ],
                                  )
                                ],
                              )
                            ],
                          ),
                        ),
                      ),
                    ),
                  );
                }),
              ),
            )
                : Padding(
              padding: EdgeInsets.only(top: screenWidth() / 2),
              child: const Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text('No data found'),
                ],
              ),
            ),

          ],
        );
      }
  );
}

Widget selectFarmerAddDdeLivestock({String? userId, bool isCustomLoan = false}){
  TextEditingController searchEditingController = TextEditingController();
  return BlocBuilder<DdeFarmerCubit,DdeState>(
      builder: (context,state){
        return Column(
          children: [
            Stack(
              children: [
                SizedBox(
                  width: screenWidth(),
                  child: Align(
                    alignment: Alignment.topLeft,
                    child: Padding(
                      padding: const EdgeInsets.only(left: 15.0,top: 2),
                      child: TextButton(onPressed: (){
                        pressBack();
                      }, child: Text("Cancel",
                        style: figtreeMedium.copyWith(
                            color: const Color(0xff6A0030),
                            fontSize: 14
                        ),)),
                    ),
                  ),
                ),

                Align(
                  alignment: Alignment.center,
                  child: Padding(padding: const EdgeInsets.only(top: 11),
                      child: "Select Farmer".textMedium(
                          fontSize: 22
                      )),
                ),

              ],
            ),

            Stack(
              children: [
                Container(
                  height: 50,
                  decoration: boxDecoration(
                      borderColor: Colors.grey,
                      borderRadius: 62,
                      backgroundColor: Colors.white),
                  width: screenWidth()-16,
                  child: Row(
                    children: [
                      13.horizontalSpace(),
                      SvgPicture.asset(Images.searchLeft),
                      13.horizontalSpace(),
                      Expanded(
                          child: TextField(
                            controller: searchEditingController,
                            onChanged: (value){
                              BlocProvider.of<DdeFarmerCubit>(context).getFarmer(context, '${BlocProvider.of<DdeFarmerCubit>(context).state.selectedRagRatingType}'.toLowerCase(), false,searchQuery: value.toString());
                            },
                            decoration: const InputDecoration(
                                border: InputBorder.none, hintText: "Search by..."),
                          )),
                    ],
                  ),
                ),
                Positioned(top: 0,bottom: 0,right:7,child: IconButton(
                    onPressed: () {
                      // setState(() {
                      searchEditingController.clear();
                      BlocProvider.of<DdeFarmerCubit>(context).getFarmer(context, '${BlocProvider.of<DdeFarmerCubit>(context).state.selectedRagRatingType}'.toLowerCase(), false,searchQuery: '');
                      // });
                    },
                    icon: const Icon(Icons.clear)))
              ],
            ),

            state.response!.farmerMAster!.isNotEmpty ? Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.only(bottom: 120, left: 0),
                child: customList(list: state.response!.farmerMAster!,child: (int i) {
                  return Padding(
                    padding: const EdgeInsets.only(
                        left: 10, right: 20, bottom: 0,top: 10),
                    child: Container(
                      decoration: state.selectedIndex == null?null:
                      state.selectedIndex==i?boxDecoration(
                          borderRadius: 10,
                          backgroundColor: const Color(0xffFBF9F9)
                      ):null,
                      child: InkWell(
                        onTap: (){
                          pressBack();
                          if(isCustomLoan) {
                            BlocProvider.of<LivestockCubit>(context).selectedDdeFarmerLivestockDetail(state.response!.farmerMAster![i]);
                            const ApplyCustomLoan().navigate();
                          } else {
                            BlocProvider.of<LivestockCubit>(context).selectedDdeFarmerLivestockDetail(state.response!.farmerMAster![i]);
                            const AddLivestock().navigate();
                          }
                        },
                        child: Padding(
                          padding:
                          const EdgeInsets.fromLTRB(15.0, 10, 0, 5),
                          child: Row(
                            crossAxisAlignment:
                            CrossAxisAlignment.start,
                            children: [
                              state.response!.farmerMAster![i].photo == null ?Image.asset(Images.sampleUser):
                              networkImage(text: state.response!.farmerMAster![i].photo!,height: 46,width: 46,radius: 40),
                              15.horizontalSpace(),
                              Column(
                                crossAxisAlignment:
                                CrossAxisAlignment.start,
                                children: [
                                  Text(state.response!.farmerMAster![i].name!,
                                      style: figtreeMedium.copyWith(
                                          fontSize: 16,
                                          color: Colors.black)),
                                  4.verticalSpace(),
                                  Row(
                                    children: [
                                      /*Text(
                                          "${countryCode == ""? "":countryCode!=null?countryCode.toString():""} ${state.response!.farmerMAster![i].phone.toString()}"
                                          ,
                                          style:
                                          figtreeRegular.copyWith(
                                              fontSize: 12,
                                              color: Colors.black)),*/

                                    ],
                                  ),
                                  4.verticalSpace(),
                                  Row(
                                    crossAxisAlignment:
                                    CrossAxisAlignment.end,
                                    children: [
                                      SizedBox(
                                        width: MediaQuery.of(context)
                                            .size
                                            .width *
                                            0.5,
                                        child: Text(
                                          state.response!.farmerMAster![i].address!=null?
                                          state.response!.farmerMAster![i].address!.address!=null?state.response!.farmerMAster![i].address!.address!:"":"",
                                          style:
                                          figtreeRegular.copyWith(
                                            fontSize: 12,
                                            color: Colors.black,
                                            overflow:
                                            TextOverflow.ellipsis,
                                          ),
                                        ),
                                      ),
                                    ],
                                  )
                                ],
                              )
                            ],
                          ),
                        ),
                      ),
                    ),
                  );
                }),
              ),
            )  : Padding(
              padding: EdgeInsets.only(top: screenWidth() / 2),
              child: const Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text('No data found'),
                ],
              ),
            ),

          ],
        );
      }
  );
}

Widget ddeTarget(BuildContext context,ProfileCubitState state){
  if(state.responseDdeTargetMonths == null) {
     return const SizedBox.shrink();
  }
  return Padding(
    padding: const EdgeInsets.all(18.0),
    child: BlocBuilder<ProfileCubit,ProfileCubitState>(
      builder: (context,state) {
        return Column(
          children: [

            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    "Targets".textMedium(
                      fontSize: 18
                    ),

                    4.verticalSpace(),

                    "Based on loan closures".textRegular(
                      fontSize: 14
                    ),

                  ],
                ),
                Container(
                  height: 45,
                  decoration: BoxDecoration(
                      border: Border.all(color: const Color(0xffD9D9D9,),width: 1.5),
                      borderRadius: BorderRadius.circular(10)
                  ),
                  // width: screenWidth(),
                  child: DropdownButtonHideUnderline(
                    child: DropdownButton2<String>(
                      isExpanded: true,
                      isDense: true,
                      hint: Text(
                        state.selectedDdeTargetMonth.toString(),
                        style: TextStyle(
                          fontSize: 14,
                          color: Theme.of(context).hintColor,
                        ),
                      ),
                      items: (state.responseDdeTargetMonths!.data! as List)
                          .map((item) => DropdownMenuItem<String>(
                        value: item,
                        child: Text(
                          item,
                          style: const TextStyle(
                            fontSize: 14,
                          ),
                        ),
                      )).toList(),
                      // value: state.counties![0].name!,
                      onChanged: (String? value) {
                        // setState(() {
                        // selectedCounty = value!.name!;
                        BlocProvider.of<ProfileCubit>(context).emit(state.copyWith(selectedDdeTargetMonth: value.toString()));
                        BlocProvider.of<ProfileCubit>(context).ddeTargetApi(context, value.toString());
                        // });
                      },
                      buttonStyleData: const ButtonStyleData(
                        padding: EdgeInsets.symmetric(horizontal: 16),
                        height: 40,
                        width: 140,
                      ),
                      menuItemStyleData: const MenuItemStyleData(
                        height: 40,
                      ),
                    ),
                  ),
                ),
              ],
            ),

            20.verticalSpace(),

            if(state.responseDdeTarget!=null)
              if(state.responseDdeTarget!.data!=null)
              customGrid(context,
                  list: state.responseDdeTarget!.data!,
                  crossAxisCount: 3,
                  mainAxisSpacing: 15,
                  crossAxisSpacing: 13,
                  mainAxisExtent: 153, child: (index) {
                    return InkWell(
                      onTap: () {

                      },
                      child: Container(
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(14),
                          border: Border.all(color: const Color(0xffDCDCDC), width: 1),
                          boxShadow: [
                            BoxShadow(
                                color: Colors.grey.withOpacity(0.1),
                                blurRadius: 1.0,
                                offset: const Offset(0, 1))
                          ],
                        ),
                        child: Padding(
                          // padding: 0.paddingAll(),
                          padding: const EdgeInsets.fromLTRB(8, 15, 8, 15),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              15.verticalSpace(),
                              Text(
                                '${state.responseDdeTarget!.data![index].commissionPercent.toString()}%',
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                                style: figtreeMedium.copyWith(fontSize: 26),
                              ),
                              05.verticalSpace(),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  if(state.responseDdeTarget!.data![index].loanClosureFrom>0)
                                    Text(
                                      "From ${state.responseDdeTarget!.data![index].loanClosureFrom.toString()}",
                                      maxLines: 2,
                                      overflow: TextOverflow.ellipsis,
                                      style: figtreeRegular.copyWith(
                                        fontSize: 13,
                                      ),
                                    ),

                                  Expanded(
                                    child: Center(
                                      child: Text(
                                        " Upto ${state.responseDdeTarget!.data![index].loanClosureUpto.toString()}",
                                        maxLines: 2,
                                        overflow: TextOverflow.ellipsis,
                                        style: figtreeRegular.copyWith(
                                          fontSize: 13,
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              05.verticalSpace(),
                              Container(
                                width: screenWidth(),
                                height: 28,
                                decoration: BoxDecoration(
                                  color: state.responseDdeTarget!.data![index].targetStatus == "Pending"?const Color(0xff6A0030):
                                  state.responseDdeTarget!.data![index].targetStatus == "In progress"?
                                  const Color(0xffF2CA00):const Color(0xff12CE57),

                                  borderRadius: BorderRadius.circular(130),
                                ),
                                child: Align(
                                  alignment: Alignment.center
                                ,child: (state.responseDdeTarget!.data![index].targetStatus ?? '').toString().textMedium(
                                    fontSize: 12,
                                    color: state.responseDdeTarget!.data![index].targetStatus.toString() == "In progress"?Colors.black:Colors.white
                                )),
                              )
                            ],
                          ),
                        ),
                      ),
                    );
                  })
              else
                const Padding(
                  padding: EdgeInsets.only(top: 40),
                  child: Center(child: Text('No Targets Available')),
                )
          ],
        );
      }
    ),
  );
}

Widget willPopScope({required Widget child,required DashboardState state,required BuildContext context}){
  return  WillPopScope(child: child,
      onWillPop: ()async{
        if(state.navigationQueue.isEmpty) return true;
        BlocProvider.of<DashboardCubit>(context).state.navigationQueue.removeLast();
        if(state.navigationQueue.isEmpty) return true;
        BlocProvider.of<DashboardCubit>(context).selectedIndex(state.navigationQueue.last);
        return false;
      });
}