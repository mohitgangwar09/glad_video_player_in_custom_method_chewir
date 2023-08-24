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

class NewsAndEvent extends StatelessWidget {
  const NewsAndEvent({Key? key}) : super(key: key);

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
                titleText1: 'News and Events',
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
                    18.horizontalSpace(),
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
      child: customList(
          padding: const EdgeInsets.fromLTRB(13,13,13,120),
          list: [1, 2, 3, 4, 5, 6, 7],
          child: (index){
            return customShadowContainer(
              margin: 0,
              backColor: Colors.grey.withOpacity(0.4),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [

                  Container(
                      padding: 2.marginAll(),
                      width: 130,
                      height:120,child: ClipRRect(borderRadius: BorderRadius.circular(15),child: Image.asset(Images.sampleLivestock,fit: BoxFit.cover,))),

                  Expanded(
                    flex: 6,
                    child: Padding(
                      padding: const EdgeInsets.only(left: 20.0,top: 15),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                              '"Identification of gaps in farmers businesses and fixing them"',
                              maxLines: 4,
                              overflow: TextOverflow.ellipsis,
                              style: figtreeMedium.copyWith(
                                  fontSize: 16, color: Colors.black),
                              softWrap: true),
                          16.verticalSpace(),
                          Text('18 Apr, 2023',
                              style: figtreeRegular.copyWith(
                                  fontSize: 12, color: const Color(0xff727272))),
                        ],
                      ),
                    ),
                  ),

                  const Expanded(
                    flex: 1,
                    child: Column(
                      children: [



                      ],
                    ),
                  )

                ],
              ),
            );
      }),
    );
  }

}
