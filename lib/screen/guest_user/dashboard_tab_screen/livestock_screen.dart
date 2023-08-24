import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:glad/screen/custom_widget/custom_appbar.dart';
import 'package:glad/screen/custom_widget/custom_methods.dart';
import 'package:glad/screen/custom_widget/livestock_details.dart';
import 'package:glad/screen/guest_user/dashboard/dashboard_guest.dart';
import 'package:glad/utils/color_resources.dart';
import 'package:glad/utils/extension.dart';
import 'package:glad/utils/images.dart';
import 'package:glad/utils/styles.dart';

class LiveStockScreen extends StatelessWidget {
  const LiveStockScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      child: Stack(
        children: [
          landingBackground(),
          Column(
            children: [
              CustomAppBar(
                context: context,
                titleText1: 'Livestock',
                centerTitle: true,
                leading: openDrawer(
                    onTap: () {
                      landingKey.currentState?.openDrawer();
                    },
                    child: SvgPicture.asset(Images.drawer)),
                action: Row(
                  children: [
                    InkWell(
                        onTap: () {
                          /*modalBottomSheetMenu(
                              context, child:
                          SizedBox(
                            height: screenHeight()*0.65,
                            child: Column(
                              children: [

                                Padding(
                                  padding: const EdgeInsets.only(left: 8.0,right: 8),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [

                                      TextButton(onPressed: (){
                                        pressBack();
                                      }, child: "Cancel".textMedium(color: const Color(0xff6A0030),fontSize: 14)),

                                      "Sort By".textMedium(fontSize: 22),

                                      TextButton(onPressed: (){},child: "Reset".textMedium(color: const Color(0xff6A0030),fontSize: 14))

                                    ],
                                  ),
                                ),

                                const Padding(
                                  padding: EdgeInsets.only(left: 20.0,right: 20),
                                  child: Divider(),
                                ),

                                Expanded(
                                  child: customList(list: [1,2,22,2,22,2,2,22,2],child: (index){
                                    return Padding(padding: const EdgeInsets.only(left: 30,right: 30,top:30,bottom: 10),
                                        child: "ROI Highest to Lowest".textRegular(fontSize: 16));
                                  }),
                                ),

                                10.verticalSpace(),

                                Container(margin: 20.marginAll(),height: 55,width: screenWidth(),child: customButton("Apply",fontColor: 0xffffffff, onTap: (){}))


                              ],
                            ),
                          ));*/
                        }, child: SvgPicture.asset(Images.filter2)),
                    13.horizontalSpace(),
                    InkWell(
                        onTap: () {
                        }, child: SvgPicture.asset(Images.filter1)),
                    18.horizontalSpace(),
                  ],
                ),
              ),
              Container(
                margin: const EdgeInsets.only(
                    left: 20, right: 20, bottom: 13, top: 23),
                height: 50,
                decoration: boxDecoration(
                    borderColor: Colors.grey,
                    borderRadius: 62,
                    backgroundColor: Colors.white),
                width: screenWidth(),
                child: Row(
                  children: [
                    13.horizontalSpace(),
                    SvgPicture.asset(Images.searchLeft),
                    13.horizontalSpace(),
                    const Expanded(
                        child: TextField(
                          decoration: InputDecoration(
                              border: InputBorder.none, hintText: "Search by..."),
                        )),
                  ],
                ),
              ),
              landingPage(context),
            ],
          ),
        ],
      ),
    );
  }

  Widget landingPage(BuildContext context){
    return Expanded(
      child: customGrid(
          padding: const EdgeInsets.fromLTRB(13,13,13,120),
          list: [1, 2, 3, 4, 5, 6, 7],
          crossAxisSpacing: 13,
          mainAxisSpacing: 13,
          mainAxisExtent: 300,
          context, child: (index){
        return customShadowContainer(
          margin: 0,
          backColor: Colors.grey.withOpacity(0.4),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                  padding: 2.marginAll(),
                  width: screenWidth(),
                  height:140,child: ClipRRect(borderRadius: BorderRadius.circular(10),child: Image.asset(Images.sampleLivestock,fit: BoxFit.cover,))),
              Padding(
                padding: const EdgeInsets.only(left: 12.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    RichText(
                        text: TextSpan(children: [
                          TextSpan(
                              text: 'Nsonga cow ',
                              style: figtreeMedium.copyWith(
                                  fontSize: 12, color: Colors.black)),
                          TextSpan(
                              text: '(N0987)',
                              style: figtreeMedium.copyWith(
                                  fontSize: 12, color: const Color(0xFF727272)))
                        ])),
                    6.verticalSpace(),
                    Text('UGX 4.5M',
                        style: figtreeSemiBold.copyWith(
                            fontSize: 18, color: Colors.black)),
                    12.verticalSpace(),
                    Row(
                      children: [
                        RichText(
                            text: TextSpan(children: [
                              TextSpan(
                                  text: 'Age: ',
                                  style: figtreeMedium.copyWith(
                                      fontSize: 12, color: const Color(0xFF727272))),
                              TextSpan(
                                  text: '04 yrs',
                                  style: figtreeMedium.copyWith(
                                      fontSize: 12, color: Colors.black)),
                            ])),
                        10.horizontalSpace(),
                        Container(
                          height: 5,
                          width: 5,
                          decoration: const BoxDecoration(
                              color: Colors.black, shape: BoxShape.circle),
                        ),
                        10.horizontalSpace(),
                        RichText(
                            text: TextSpan(children: [
                              TextSpan(
                                  text: 'Milk: ',
                                  style: figtreeMedium.copyWith(
                                      fontSize: 12, color: const Color(0xFF727272))),
                              TextSpan(
                                  text: '16L/day',
                                  style: figtreeMedium.copyWith(
                                      fontSize: 12, color: Colors.black))
                            ])),
                      ],
                    ),
                    6.verticalSpace(),
                    Text('Kampala, Uganda',
                        style: figtreeMedium.copyWith(
                            fontSize: 12, color: Colors.black)),
                    12.verticalSpace(),
                    Row(
                      children: [
                        Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(26),
                            border: Border.all(color: const Color(0xFFFC5E60)),
                          ),
                          padding: const EdgeInsets.symmetric(
                              horizontal: 16, vertical: 9.5),
                          child: SvgPicture.asset(Images.chatBubble),
                        ),
                        6.horizontalSpace(),
                        Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(50),
                            border: Border.all(color: const Color(0xffF6B51D)),
                          ),
                          padding: const EdgeInsets.symmetric(
                              vertical: 10.0, horizontal: 9.5),
                          child: Text('Add to Cart',
                              style: figtreeMedium.copyWith(
                                  fontSize: 13.5, color: Colors.black)),
                        )
                      ],
                    )
                  ],
                ),
              ),
            ],
          ),
        );
      }),
    );
  }

}
