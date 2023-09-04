import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:glad/cubit/dde_Farmer_cubit/dde_farmer_cubit.dart';
import 'package:glad/screen/custom_widget/custom_appbar.dart';
import 'package:glad/screen/custom_widget/custom_methods.dart';
import 'package:glad/screen/custom_widget/custom_textfield.dart';
import 'package:glad/screen/dde_screen/dde_farmer_detail.dart';
import 'package:glad/screen/dde_screen/dde_farmer_filter.dart';
import 'package:glad/screen/farmer_screen/common/widegt/project_widget.dart';
import 'package:glad/screen/farmer_screen/dashboard/dashboard_farmer.dart';
import 'package:glad/utils/color_resources.dart';
import 'package:glad/utils/extension.dart';
import 'package:glad/utils/helper.dart';
import 'package:glad/utils/images.dart';
import 'package:glad/utils/styles.dart';

class FarmerDdeTabScreen extends StatefulWidget {
  const FarmerDdeTabScreen({Key? key}) : super(key: key);

  @override
  State<FarmerDdeTabScreen> createState() => _FarmerDdeTabScreenState();
}

class _FarmerDdeTabScreenState extends State<FarmerDdeTabScreen> {
  @override
  Widget build(BuildContext context) {
    BlocProvider.of<DdeFarmerCubit>(context).getFarmer(context);
    return BlocBuilder<DdeFarmerCubit,DdeState>(builder: (context,state){
      return Stack(
        children: [
          landingBackground(),
          hideKeyboard(
            context,
            child: Column(
              children: [
                CustomAppBar(
                  context: context,
                  titleText1: "Farmers",
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
                  leading: openDrawer(
                      onTap: () {
                        // onTapDrawer();
                      },
                      child: SvgPicture.asset(Images.drawer)),
                  centerTitle: true,
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
                                border: InputBorder.none, hintText: "Search"),
                          )),
                    ],
                  ),
                ),
                Container(
                  margin: const EdgeInsets.only(
                      left: 18, right: 7, bottom: 20, top: 10),
                  height: 36,
                  child: customList(
                      axis: Axis.horizontal,
                      child: (int index) {
                        return InkWell(
                          onTap: (){
                          },
                          child: Container(
                            margin: const EdgeInsets.only(right: 12, left: 0),
                            padding: const EdgeInsets.only(left: 10, right: 10),
                            decoration: boxDecoration(
                                borderColor: const Color(0xffDCDCDC),
                                borderWidth: 1.1,
                                borderRadius: 62,
                                backgroundColor: Colors.white),
                            child: Row(
                              children: [
                                "Critical".textMedium(fontSize: 14),
                                6.horizontalSpace(),
                                "04".textSemiBold(
                                    fontSize: 12, color: const Color(0xffFC5E60)),
                              ],
                            ),
                          ),
                        );
                      }),
                ),
                Expanded(
                  child: SingleChildScrollView(
                    padding: const EdgeInsets.only(bottom: 120, left: 0),
                    child: customList(child: (int i) {
                      return Padding(
                        padding: const EdgeInsets.only(
                            left: 10, right: 20, bottom: 12),
                        child: Stack(
                          children: [
                            InkWell(
                              onTap: (){
                                const DdeFarmerDetail().navigate();
                              },
                              child: customProjectContainer(
                                child: Padding(
                                  padding:
                                  const EdgeInsets.fromLTRB(15.0, 20, 0, 0),
                                  child: Column(
                                    children: [
                                      Row(
                                        crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                        children: [
                                          Image.asset(Images.sampleUser),
                                          15.horizontalSpace(),
                                          Column(
                                            crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                            children: [
                                              Text("Matts Francesca",
                                                  style: figtreeMedium.copyWith(
                                                      fontSize: 16,
                                                      color: Colors.black)),
                                              4.verticalSpace(),
                                              Row(
                                                crossAxisAlignment:
                                                CrossAxisAlignment.end,
                                                children: [
                                                  const Icon(
                                                    Icons.call,
                                                    color: Colors.black,
                                                    size: 16,
                                                  ),
                                                  Text("+22112 3232 3223",
                                                      style:
                                                      figtreeRegular.copyWith(
                                                          fontSize: 12,
                                                          color: Colors.black)),
                                                ],
                                              ),
                                              4.verticalSpace(),
                                              Row(
                                                crossAxisAlignment:
                                                CrossAxisAlignment.end,
                                                children: [
                                                  const Icon(
                                                    Icons.location_on,
                                                    color: Colors.black,
                                                    size: 16,
                                                  ),
                                                  SizedBox(
                                                    width: MediaQuery.of(context)
                                                        .size
                                                        .width *
                                                        0.5,
                                                    child: Text(
                                                      "Luwum St. Rwoozi, Kampala...",
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
                                      Padding(
                                        padding: const EdgeInsets.only(
                                            left:05, right: 15, top: 18),
                                        child: Row(
                                          mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                          children: [
                                            Text.rich(
                                              TextSpan(
                                                children: [
                                                  TextSpan(
                                                      text: 'Farm: ',
                                                      style:
                                                      figtreeRegular.copyWith(
                                                          color: const Color(
                                                              0xff808080),
                                                          fontSize: 12)),
                                                  TextSpan(
                                                    text: '50 Acres',
                                                    style: figtreeSemiBold.copyWith(
                                                        fontSize: 12),
                                                  ),
                                                ],
                                              ),
                                            ),
                                            Text.rich(
                                              TextSpan(
                                                children: [
                                                  TextSpan(
                                                      text: 'Milking/Cows: ',
                                                      style:
                                                      figtreeRegular.copyWith(
                                                          color: const Color(
                                                              0xff808080),
                                                          fontSize: 12)),
                                                  TextSpan(
                                                    text: '50',
                                                    style: figtreeSemiBold.copyWith(
                                                        fontSize: 12),
                                                  ),
                                                ],
                                              ),
                                            ),
                                            Text.rich(
                                              TextSpan(
                                                children: [
                                                  TextSpan(
                                                      text: 'Yield/Cow: ',
                                                      style:
                                                      figtreeRegular.copyWith(
                                                          color: const Color(
                                                              0xff808080),
                                                          fontSize: 12)),
                                                  TextSpan(
                                                    text: '50 ltr',
                                                    style: figtreeSemiBold.copyWith(
                                                        fontSize: 12),
                                                  ),
                                                ],
                                              ),
                                            )
                                          ],
                                        ),
                                      ),
                                      20.verticalSpace(),
                                      Padding(
                                        padding: const EdgeInsets.only(right:15),
                                        child: Container(
                                          height: 80,
                                          padding: 20.paddingHorizontal(),
                                          decoration: boxDecoration(
                                              backgroundColor:
                                              const Color(0xffFFF3F4),
                                              borderRadius: 10),
                                          child: Column(
                                            children: [
                                              Row(
                                                children: [
                                                  "Dam Construction"
                                                      .textMedium(fontSize: 12),
                                                  Container(
                                                    margin: 9.marginAll(),
                                                    padding:
                                                    const EdgeInsets.symmetric(
                                                        vertical: 4,
                                                        horizontal: 7),
                                                    decoration: boxDecoration(
                                                      borderRadius: 30,
                                                      borderColor:
                                                      const Color(0xff6A0030),
                                                    ),
                                                    child: Text(
                                                      "Suggested",
                                                      textAlign: TextAlign.center,
                                                      style: figtreeMedium.copyWith(
                                                          color:
                                                          const Color(0xff6A0030),
                                                          fontSize: 10),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                              Row(
                                                mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                                children: [
                                                  Column(
                                                    mainAxisAlignment:
                                                    MainAxisAlignment.center,
                                                    crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                    children: [
                                                      "UGX 3.2M".textSemiBold(
                                                          color: Colors.black,
                                                          fontSize: 16),
                                                      "Investment".textMedium(
                                                          fontSize: 12,
                                                          color: const Color(
                                                              0xff808080)),
                                                    ],
                                                  ),
                                                  Column(
                                                    mainAxisAlignment:
                                                    MainAxisAlignment.center,
                                                    crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                    children: [
                                                      "UGX 4.5M".textSemiBold(
                                                          color: Colors.black,
                                                          fontSize: 16),
                                                      "Revenue".textMedium(
                                                          fontSize: 12,
                                                          color: const Color(
                                                              0xff808080)),
                                                    ],
                                                  ),
                                                  Column(
                                                    mainAxisAlignment:
                                                    MainAxisAlignment.center,
                                                    crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                    children: [
                                                      "40%".textSemiBold(
                                                          color: Colors.black,
                                                          fontSize: 16),
                                                      "ROI".textMedium(
                                                          fontSize: 12,
                                                          color: const Color(
                                                              0xff808080)),
                                                    ],
                                                  ),
                                                ],
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                      15.verticalSpace(),
                                      Container(
                                        width: 140,
                                        height: 3,
                                        decoration: boxDecoration(
                                            borderRadius: 10,
                                            backgroundColor: Colors.green),
                                      )
                                    ],
                                  ),
                                ),
                              ),
                            ),
                            Positioned(
                                top: 0,
                                right: 0,
                                child: Row(
                                  children: [
                                    SvgPicture.asset(Images.callPrimary),
                                    6.horizontalSpace(),
                                    SvgPicture.asset(Images.whatsapp),
                                    6.horizontalSpace(),
                                    SvgPicture.asset(Images.redirectLocation),
                                    4.horizontalSpace(),
                                  ],
                                )),
                          ],
                        ),
                      );
                    }),
                  ),
                )
              ],
            ),
          ),

        ],
      );

    });

  }
}
