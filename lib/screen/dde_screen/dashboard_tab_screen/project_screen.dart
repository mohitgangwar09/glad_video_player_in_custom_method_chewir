import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:glad/cubit/dde_farmer_cubit/dde_farmer_cubit.dart';
import 'package:glad/screen/custom_widget/custom_appbar.dart';
import 'package:glad/screen/custom_widget/custom_methods.dart';
import 'package:glad/screen/dde_screen/dde_farmer_filter.dart';
import 'package:glad/screen/dde_screen/project_widget.dart';
import 'package:glad/screen/farmer_screen/dashboard/dashboard_farmer.dart';
import 'package:glad/screen/farmer_screen/profile/farmer_profile.dart';
import 'package:glad/utils/color_resources.dart';
import 'package:glad/utils/extension.dart';
import 'package:glad/utils/helper.dart';
import 'package:glad/utils/images.dart';
import 'package:glad/utils/styles.dart';

class ProjectScreen extends StatelessWidget {
  const ProjectScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    BlocProvider.of<DdeFarmerCubit>(context).selectRagRating('');

    return Stack(
      children: [
        landingBackground(),
        Column(
          children: [

            CustomAppBar(
              context: context,
              titleText1: 'Projects',
              titleText1Style: figtreeMedium.copyWith(
                  fontSize: 20, color: Colors.black),
              centerTitle: true,
              leading: openDrawer(
                  onTap: () {
                    farmerLandingKey.currentState?.openDrawer();
                  },
                  child: SvgPicture.asset(Images.drawer)),
              action: Row(
                children: [
                  InkWell(
                      onTap: () {
                        modalBottomSheetMenu(
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
                        ));
                      }, child: SvgPicture.asset(Images.filter2)),
                  13.horizontalSpace(),
                  InkWell(
                      onTap: () {
                        const FilterDDEFarmer().navigate();
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
                        borderRadius: 62
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [

                          "Active".textMedium(color: Colors.white,fontSize: 14),

                          5.horizontalSpace(),

                          SvgPicture.asset(Images.activeSelected)

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

                          "Pending".textMedium(color: ColorResources.black,fontSize: 14),

                          5.horizontalSpace(),

                          SvgPicture.asset(Images.pending)

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

                          "Suggested".textMedium(color: Colors.black,fontSize: 14),

                          5.horizontalSpace(),

                          SvgPicture.asset(Images.completed)

                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),

            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.only(bottom: 120,left: 10),
                child: customList(
                  list: List.generate(3, (index) => null),
                    child: (int i) {

                  return Padding(
                    padding: const EdgeInsets.only(right: 20.0),
                    child: customProjectContainer(child: const ProjectWidget(status: true,),width: screenWidth()),
                  );
                }),
              ),
            )

          ],
        ),
      ],
    );
  }
}