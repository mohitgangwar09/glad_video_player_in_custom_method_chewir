import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:glad/cubit/dde_farmer_cubit/dde_farmer_cubit.dart';
import 'package:glad/screen/custom_widget/custom_appbar.dart';
import 'package:glad/screen/custom_widget/custom_methods.dart';
import 'package:glad/screen/dde_screen/dde_farmer_detail.dart';
import 'package:glad/screen/dde_screen/dde_farmer_filter.dart';
import 'package:glad/utils/color_resources.dart';
import 'package:glad/utils/extension.dart';
import 'package:glad/utils/images.dart';
import 'package:glad/utils/styles.dart';

class FarmerDdeTabScreen extends StatefulWidget {
  const FarmerDdeTabScreen({Key? key}) : super(key: key);

  @override
  State<FarmerDdeTabScreen> createState() => _FarmerDdeTabScreenState();
}

class _FarmerDdeTabScreenState extends State<FarmerDdeTabScreen> {


  @override
  void initState(){
    super.initState();
    BlocProvider.of<DdeFarmerCubit>(context).getFarmer(context, '');
  }

  Color ragColor(String ragRating) {
    switch (ragRating) {
      case 'critical' : return const Color(0xffFC5E60);
      case 'average' : return const Color(0xffF6B51D);
      case 'satisfactory' : return const Color(0xff12CE57);
      case 'mature' : return ColorResources.maroon;
      default: return Colors.white;
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<DdeFarmerCubit,DdeState>(builder: (context,state){
      if (state.status == DdeFarmerStatus.loading) {
        return const Center(
            child: CircularProgressIndicator(
              color: ColorResources.maroon,
            ));
      }else if(state.response == null){
       return "${state.response} Api Error".textMedium();
      }
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
                SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Container(
                    margin: const EdgeInsets.only(
                        left: 18, right: 7, bottom: 20, top: 10),
                    child: Row(
                      children: [
                        ragRatingButton(context, 'Critical', state.response!.ragRatingCount!.critical.toString(), state.selectedRagRatingType == 'critical', const Color(0xffFC5E60)),
                        ragRatingButton(context, 'Average', state.response!.ragRatingCount!.average.toString(), state.selectedRagRatingType == 'average', const Color(0xffF6B51D)),
                        ragRatingButton(context, 'Satisfactory', state.response!.ragRatingCount!.satisfactory.toString(), state.selectedRagRatingType == 'satisfactory', const Color(0xff12CE57)),
                        ragRatingButton(context, 'Mature', state.response!.ragRatingCount!.mature.toString(), state.selectedRagRatingType == 'mature', ColorResources.maroon),
                      ],
                    ),
                  ),
                ),
                Expanded(
                  child: SingleChildScrollView(
                    padding: const EdgeInsets.only(bottom: 120, left: 0),
                    child: state.response!.farmerMAster!.isNotEmpty ? customList(list: state.response!.farmerMAster!,child: (int i) {
                      return Padding(
                        padding: const EdgeInsets.only(
                            left: 10, right: 20, bottom: 12),
                        child: Stack(
                          children: [
                            InkWell(
                              onTap: (){
                                DdeFarmerDetail(userId: state.response!.farmerMAster![i].userId!,).navigate();
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
                                                  Text(state.response!.farmerMAster![i].phone.toString(),
                                                      style:
                                                      figtreeRegular.copyWith(
                                                          fontSize: 12,
                                                          color: Colors.black)),
                                                  10.horizontalSpace(),
                                                  Container(
                                                    height: 5,
                                                    width: 5,
                                                    decoration: const BoxDecoration(
                                                        color: Colors.black, shape: BoxShape.circle),
                                                  ),
                                                  10.horizontalSpace(),
                                                  Text(
                                                      state.response!.farmerMAster![i].farmingExperience?? "10" + ' yrs exp',
                                                      style: figtreeMedium.copyWith(fontSize: 12,)),

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
                                                      state.response!.farmerMAster![i].fAddress ?? "",
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
                                                    text: '${state.response!.farmerMAster![i].farmSize}Acres',
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
                                                    text: state.response!.farmerMAster![i].milkingCows.toString(),
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
                                                    text: state.response!.farmerMAster![i].yieldPerCow.toString(),
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
                                                      'UGX ${state.response!.farmerMAster![i].investmentAmount!/1000}M'.textSemiBold(
                                                          color: Colors.black,
                                                          fontSize: 16),
                                                     'Investment'.textMedium(
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
                                                      'UGX ${state.response!.farmerMAster![i].revenuePerYear!/1000}M'.textSemiBold(
                                                          color: Colors.black,
                                                          fontSize: 16),
                                                      'Revenue'.textMedium(
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
                                                      ' ${state.response!.farmerMAster![i].roiPerYear}%'.textSemiBold(
                                                          color: Colors.black,
                                                          fontSize: 16),
                                                      'ROI'.textMedium(
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
                                            backgroundColor: ragColor(state.response!.farmerMAster![i].farmerRagRating!.ragRating!.toLowerCase())),
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
                                    InkWell(
                                        onTap: () {
                                          callOnMobile(state.response!.farmerMAster![i].phone ??
                                              '');
                                        },
                                        child: SvgPicture.asset(Images.callPrimary)),
                                    6.horizontalSpace(),
                                    InkWell(
                                        onTap: () {
                                          whatsapp(state.response!.farmerMAster![i].phone ??
                                              '');
                                        },child: SvgPicture.asset(Images.whatsapp)),
                                    6.horizontalSpace(),
                                    SvgPicture.asset(Images.redirectLocation),
                                    4.horizontalSpace(),
                                  ],
                                )),
                          ],
                        ),
                      );
                    }) : Center(child: Text('No Farmers')
                  ),
                  ),
                )
              ],
            ),
          ),

        ],
      );

    });

  }

  InkWell ragRatingButton(BuildContext context, String ragRating, String ragRatingCount, bool isSelected, Color ragColor) {
    return InkWell(
                        onTap: (){
                          BlocProvider.of<DdeFarmerCubit>(context).getFarmer(context, ragRating.toLowerCase());
                        },
                        child: Container(
                          margin: const EdgeInsets.only(right: 12, left: 0),
                          padding: const EdgeInsets.all(10),
                          decoration: boxDecoration(
                              borderColor: const Color(0xffDCDCDC),
                              borderWidth: 1,
                              borderRadius: 62,
                              backgroundColor: isSelected ? ColorResources.maroon :Colors.white),
                          child: Row(
                            children: [
                              ragRating.textMedium(fontSize: 14, color: isSelected ? Colors.white : Colors.black),
                              6.horizontalSpace(),
                             ragRatingCount.toString().textSemiBold(
                                  fontSize: 12, color: isSelected ? Colors.white : ragColor),
                            ],
                          ),
                        ),
                      );
  }
}
