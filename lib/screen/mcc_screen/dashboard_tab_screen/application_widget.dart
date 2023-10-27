import 'package:flutter/material.dart';
import 'package:glad/screen/custom_widget/custom_methods.dart';
import 'package:glad/utils/extension.dart';
import 'package:glad/utils/images.dart';

class MCCApplicationScreen extends StatelessWidget {
  final double? bottom;
  const MCCApplicationScreen({Key? key,this.bottom = 0}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return customProjectContainer(
        marginTop: 10,
        width: screenWidth()-45,
        child: Padding(
          padding: EdgeInsets.only(top: 25.0,bottom: bottom!,left: 20,right: 20,),
          child: InkWell(
            onTap: (){
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
        ));
  }
}
