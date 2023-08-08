import 'package:flutter/material.dart';
import 'package:glad/screen/custom_widget/custom_methods.dart';
import 'package:glad/screen/farmer_screen/common/project_details.dart';
import 'package:glad/utils/extension.dart';
import 'package:glad/utils/images.dart';
import 'package:glad/utils/styles.dart';

class ProjectWidget extends StatelessWidget {
  final bool status;
  const ProjectWidget({Key? key,required this.status}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [

        Padding(
          padding: const EdgeInsets.all(15.0),
          child: InkWell(
            onTap: (){
              const ProjectDetails().navigate();
            },
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [

                Row(
                  children: [

                    CircleAvatar(
                        radius: 30,
                        child: Image.asset(Images.sampleUser,
                          fit: BoxFit.cover,width: 80,height: 80,)),

                    12.horizontalSpace(),

                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [

                          "Dam Construction".textMedium(fontSize: 18,),

                          5.verticalSpace(),

                          "Water Management".textRegular(fontSize: 12, ),

                        ],
                      ),
                    ),

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
                      child: customPaint(Colors.grey),
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
        ),


        Visibility(
          visible: status,
          child: Align(
            alignment: Alignment.topRight,
            child: Container(
              margin: 10.marginAll(),
              padding: const EdgeInsets.symmetric(vertical: 4,horizontal: 7),
              decoration: boxDecoration(
                borderRadius: 30,
                borderColor: const Color(0xff6A0030),
              ),
              child: Text("Active",
                textAlign: TextAlign.center,
                style: figtreeMedium.copyWith(
                    color: const Color(0xff6A0030),
                    fontSize: 10

                ),),
            ),
          ),
        )

      ],
    );
  }
}