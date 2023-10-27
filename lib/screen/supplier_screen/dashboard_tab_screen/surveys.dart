import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:glad/screen/custom_widget/custom_appbar.dart';
import 'package:glad/screen/custom_widget/custom_methods.dart';
import 'package:glad/screen/supplier_screen/survey_detail.dart';
import 'package:glad/screen/supplier_screen/survey_filter.dart';
import 'package:glad/utils/extension.dart';
import 'package:glad/utils/images.dart';
import 'package:glad/utils/styles.dart';

import '../dashboard/dashboard_supplier.dart';


class SurveysScreen extends StatelessWidget {
  const SurveysScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        landingBackground(),
        hideKeyboard(
          context,
          child: Column(
            children: [
              CustomAppBar(
                context: context,
                titleText1: 'Survey',
                titleText1Style: figtreeMedium.copyWith(
                    fontSize: 20, color: Colors.black),
                centerTitle: true,
                leading: openDrawer(
                    onTap: () {
                      supplierLandingKey.currentState?.openDrawer();
                    },
                    child: SvgPicture.asset(Images.drawer)),
                action: Row(
                  children: [
                    InkWell(
                        onTap: () {
                          modalBottomSheetMenu(
                              context, child:
                          SizedBox(
                            height: screenHeight()*0.55,
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
                                  child: customList(list: [1,2,22,2,22],child: (index){
                                    return Padding(padding: const EdgeInsets.only(left: 30,right: 30,top:30,bottom: 10),
                                        child: "Default".textRegular(fontSize: 16));
                                  }),
                                ),

                                10.verticalSpace(),

                                Container(margin: 20.marginAll(),height: 55,width: screenWidth(),child: customButton("Apply",fontColor: 0xffffffff, onTap: (){}))


                              ],
                            ),
                          ));
                        }, child: SvgPicture.asset(Images.filter2)),
                    13.horizontalSpace(),
                    InkWell(
                        onTap: () {
                          const FilterSurvey().navigate();
                        }, child: SvgPicture.asset(Images.filter1)),
                    18.horizontalSpace(),
                  ],
                ),
              ),

              10.verticalSpace(),

              Container(
                height: 50,
                margin: 20.marginHorizontal(),
                width: screenWidth(),
                decoration: boxDecoration(
                    borderRadius: 62,
                    borderColor: const Color(0xffDCDCDC),
                  backgroundColor: Colors.white
                ),
                child: Row(
                  children: [

                    Expanded(
                      child: Container(
                        height: screenHeight(),
                        margin: const EdgeInsets.all(6),
                        decoration: boxDecoration(
                            backgroundColor: const Color(0xff6A0030),
                            borderRadius: 62,
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [

                            "Pending".textMedium(color: Colors.white,fontSize: 14),

                            5.horizontalSpace(),

                            SvgPicture.asset(Images.pendingSelected)

                          ],
                        ),
                      ),
                    ),

                    Expanded(
                      child: Container(
                        height: screenHeight(),
                        margin: const EdgeInsets.all(6),
                        decoration: boxDecoration(
                            backgroundColor: Colors.white,
                            borderRadius: 62
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [

                            "Completed".textMedium(color: Colors.black,fontSize: 14),

                            5.horizontalSpace(),

                            SvgPicture.asset(Images.completed,)

                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),

              Expanded(
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      customList(child: (index){
                        return Padding(
                          padding: const EdgeInsets.only(right: 20.0,left: 10),
                          child: customProjectContainer(
                              marginTop: 10,
                              width: screenWidth()-45,
                              child: Padding(
                                padding: const EdgeInsets.only(top: 25.0,bottom: 25,left: 20,right: 20,),
                                child: InkWell(
                                  onTap: (){
                                    const SurveyDetails().navigate();
                                  },
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [

                                      Row(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [

                                          Expanded(
                                            child: Column(
                                              crossAxisAlignment: CrossAxisAlignment.start,
                                              children: [

                                                "Dam Construction".textMedium(fontSize: 18,),

                                                5.verticalSpace(),

                                                "Water Management".textRegular(fontSize: 12, color: const Color(0xff808080)),

                                              ],
                                            ),
                                          ),

                                          "UGX 3.2M".textSemiBold(fontSize: 18),

                                        ],
                                      ),

                                      18.verticalSpace(),

                                      "Construct a water tank and water trough in night paddock plus water pump ".textRegular(
                                          maxLines: 2,
                                          overflow: TextOverflow.ellipsis,
                                          fontSize: 14,color: const Color(0xff808080)
                                      ),

                                      15.verticalSpace(),

                                      Container(
                                        height: 70,
                                        padding: 15.paddingHorizontal(),
                                        decoration: boxDecoration(
                                            backgroundColor: const Color(0xffFFF3F4),
                                            borderRadius: 10
                                        ),child: Row(
                                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                        children: [

                                          Expanded(
                                            child: Column(
                                              mainAxisAlignment: MainAxisAlignment.center,
                                              crossAxisAlignment: CrossAxisAlignment.start,
                                              children: [

                                                "Begumanya Charles".textMedium(color: Colors.black, fontSize: 14,maxLines: 1,overflow: TextOverflow.ellipsis),

                                                1.verticalSpace(),

                                                "+256 758711344".textRegular(fontSize: 12,color: Colors.black),

                                                4.verticalSpace(),

                                                "Luwum St. Rwoozi, Kampala...".textRegular(fontSize: 12,color: Colors.black,maxLines: 1,overflow: TextOverflow.ellipsis),



                                              ],
                                            ),
                                          ),

                                          CircleAvatar(
                                            radius: 24,
                                            child: Image.asset(Images.sampleUser,fit: BoxFit.cover,width: 53,height: 53,),
                                          )

                                        ],
                                      ),),


                                      // 30.verticalSpace()

                                    ],
                                  ),
                                ),
                              )),
                        );}),
                      100.verticalSpace(),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}