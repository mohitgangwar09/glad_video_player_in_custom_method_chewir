import 'package:flutter/material.dart';
import 'package:glad/screen/custom_widget/custom_methods.dart';
import 'package:glad/utils/extension.dart';
import 'package:glad/utils/styles.dart';

class MCCApplicationScreen extends StatelessWidget {
  const MCCApplicationScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return customProjectContainer(
        width: screenWidth(),
        child: Padding(
          padding: const EdgeInsets.only(top: 25.0,left: 20,right: 20,bottom: 20),
          child: InkWell(
            onTap: (){
            },
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [

                Row(
                  children: [

                    12.horizontalSpace(),

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

                15.verticalSpace(),

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

                        "18 Ltr./day".textSemiBold(color: Colors.black, fontSize: 16),

                        3.verticalSpace(),

                        "Target yield /cow".textRegular(fontSize: 12,color: Colors.black),



                      ],
                    ),

                    SizedBox(
                      height: 45,
                      child: customPaint(),
                    ),

                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [

                        "180 Ltr./day".textSemiBold(color: Colors.black, fontSize: 16),

                        3.verticalSpace(),

                        "Incremental production".textRegular(fontSize: 12,color: Colors.black)

                      ],
                    ),

                  ],
                ),),

                10.verticalSpace(),

                Container(
                  margin: 4.marginTop(),
                  padding: 20.paddingHorizontal(),
                  decoration: boxDecoration(
                      borderRadius: 10
                  ),child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [

                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [

                        "UGX 3.2M".textSemiBold(color: Colors.black, fontSize: 16),

                        "Investment".textMedium(fontSize: 12),



                      ],
                    ),

                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [

                        "UGX 4.5M".textSemiBold(color: Colors.black, fontSize: 16),

                        "Revenue".textMedium(fontSize: 12,color: Colors.black),



                      ],
                    ),


                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [

                        "40%".textSemiBold(color: Colors.black, fontSize: 16),

                        "ROI".textMedium(fontSize: 12,),



                      ],
                    ),


                  ],
                ),
                ),

                // 30.verticalSpace()

              ],
            ),
          ),
        ));
  }
}
