import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:glad/cubit/landing_page_cubit/landing_page_cubit.dart';
import 'package:glad/cubit/livestock_cubit/livestock_cubit.dart';
import 'package:glad/screen/auth_screen/login_with_password.dart';
import 'package:glad/screen/auth_screen/register_popup.dart';
import 'package:glad/screen/livestock/livestock_cart_list_screen.dart';
import 'package:glad/screen/livestock/livestock_detail.dart';
import 'package:glad/screen/livestock/livestock_filter.dart';
import 'package:glad/screen/livestock/loan_application_screen.dart';
import 'package:glad/screen/livestock/my_livestock.dart';
import 'package:glad/screen/custom_widget/custom_appbar.dart';
import 'package:glad/screen/custom_widget/custom_methods.dart';
import 'package:glad/screen/farmer_screen/dashboard/dashboard_farmer.dart';
import 'package:glad/screen/guest_user/dashboard/dashboard_guest.dart';
import 'package:glad/utils/app_constants.dart';
import 'package:glad/utils/color_resources.dart';
import 'package:glad/utils/extension.dart';
import 'package:glad/utils/images.dart';
import 'package:glad/utils/styles.dart';

class LiveStockScreen extends StatefulWidget {
  const LiveStockScreen({Key? key}) : super(key: key);

  @override
  State<LiveStockScreen> createState() => _LiveStockScreenState();
}

class _LiveStockScreenState extends State<LiveStockScreen> {

  TextEditingController searchEditingController = TextEditingController();

  @override
  void initState() {
    BlocProvider.of<LivestockCubit>(context).livestockListApi(context,true);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LivestockCubit, LivestockCubitState>(
        builder: (context, state) {
          if (state.status == LivestockStatus.submit) {
            return const Center(
                child: CircularProgressIndicator(
                  color: ColorResources.maroon,
                ));
          } else if (state.responseLivestockList == null) {
            return Center(child: Text("${state.responseLivestockList} Api Error"));
          } else {
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
                              if (BlocProvider
                                  .of<LandingPageCubit>(context)
                                  .sharedPreferences
                                  .getString(AppConstants.userType) ==
                                  'farmer') {
                                farmerLandingKey.currentState?.openDrawer();
                              } else {
                                landingKey.currentState?.openDrawer();
                              }
                            },
                            child: SvgPicture.asset(Images.drawer)),
                        action: Row(
                          children: [
                            if(BlocProvider
                                .of<LandingPageCubit>(context)
                                .sharedPreferences
                                .containsKey(AppConstants.userType))
                            InkWell(
                                onTap: () {
                                  const LiveStockCartListScreen().navigate();
                                },
                                child: SvgPicture.asset(state.responseLivestockList!.data!.cartCount.toString()== "0"?Images.blankCart:Images.cart)),
                            if(!BlocProvider
                                .of<LandingPageCubit>(context)
                                .sharedPreferences
                                .containsKey(AppConstants.userType))
                              InkWell(
                                  onTap: () {
                                    List<String> roiList = [
                                      'Default',
                                      'Price Highest to Lowest',
                                      'Price Lowest to Highest',
                                      'Age Highest to Lowest',
                                      'Age Lowest to Highest',
                                      'Yield Highest to Lowest',
                                      'Yield Lowest to Highest',
                                    ];
                                    List<String> roiRequestToApi = [
                                      '',
                                      'price_highest_desc',
                                      'price_lowest_asc',
                                      'age_highest_desc',
                                      'age_lowest_asc',
                                      'yield_highest_desc',
                                      'yield_lowest_asc'
                                    ];
                                    modalBottomSheetMenu(context,
                                      child: BlocBuilder<LivestockCubit, LivestockCubitState>(
                                          builder: (context, state) {
                                            return SizedBox(
                                              height: screenHeight() * 0.65,
                                              child: Column(
                                                children: [
                                                  Padding(
                                                    padding: const EdgeInsets.only(
                                                        left: 8.0, right: 8),
                                                    child: Row(
                                                      mainAxisAlignment:
                                                      MainAxisAlignment.spaceBetween,
                                                      children: [
                                                        TextButton(
                                                            onPressed: () {
                                                              pressBack();
                                                            },
                                                            child: "Cancel".textMedium(
                                                                color:
                                                                const Color(0xff6A0030),
                                                                fontSize: 14)),
                                                        "Sort By".textMedium(fontSize: 22),
                                                        TextButton(
                                                            onPressed: () {
                                                              BlocProvider.of<LivestockCubit>(context).roiFilter('');
                                                            },
                                                            child: "Reset".textMedium(
                                                                color:
                                                                const Color(0xff6A0030),
                                                                fontSize: 14))
                                                      ],
                                                    ),
                                                  ),
                                                  const Padding(
                                                    padding: EdgeInsets.only(
                                                        left: 20.0, right: 20),
                                                    child: Divider(),
                                                  ),
                                                  Expanded(
                                                    child: customList(
                                                        list: roiList,
                                                        child: (index) {
                                                          return InkWell(
                                                            onTap: (){
                                                              BlocProvider.of<LivestockCubit>(context).roiFilter(roiRequestToApi[index].toString());
                                                            },
                                                            child: Padding(
                                                                padding: const EdgeInsets
                                                                    .only (
                                                                    left: 30,
                                                                    right: 30,
                                                                    top: 30,
                                                                    bottom: 10),
                                                                child: Row(
                                                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                                  children: [
                                                                    roiList[index].toString()
                                                                        .textRegular(
                                                                        fontSize: 16),
                                                                    state.roiFilter == roiRequestToApi[index].toString()?
                                                                    const Icon(Icons.check,color: Colors.red,):const SizedBox.shrink()
                                                                  ],
                                                                )),
                                                          );
                                                        }),
                                                  ),
                                                  10.verticalSpace(),
                                                  Container(
                                                      margin: 20.marginAll(),
                                                      height: 55,
                                                      width: screenWidth(),
                                                      child: customButton("Apply",
                                                          fontColor: 0xffffffff,
                                                          onTap: () {
                                                            BlocProvider.of<LivestockCubit>(context).livestockListApi(context,false);
                                                            pressBack();
                                                          }))
                                                ],
                                              ),
                                            );
                                          }
                                      ),
                                    );
                                  }, child: SvgPicture.asset(Images.filter2)),
                            13.horizontalSpace(),
                            InkWell(
                                onTap: () {
                                  BlocProvider.of<LivestockCubit>(context).livestockBreedApi(context);
                                  const LivestockFilter("").navigate();
                                },
                                child: SvgPicture.asset(Images.filter1)),
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
                            Expanded(
                                child: Stack(
                                  children: [
                                    TextField(
                                      controller: searchEditingController,
                                      onChanged: (value){
                                        BlocProvider.of<LivestockCubit>(context).livestockListApi(context,false,searchQuery:value.toString());
                                      },
                                      decoration: const InputDecoration(
                                          border: InputBorder.none,
                                          hintText: "Search by..."),
                                    ),
                                    searchEditingController.text.isNotEmpty?
                                    Positioned(top: 0,bottom: 0,right:7,child: IconButton(
                                        onPressed: () {
                                          setState(() {
                                            searchEditingController.clear();
                                            BlocProvider.of<LivestockCubit>(context).livestockListApi(context,false,searchQuery:'');
                                          });
                                        },
                                        icon: const Icon(Icons.clear))):const SizedBox.shrink()
                                  ],
                                )),
                          ],
                        ),
                      ),
                      if(BlocProvider
                          .of<LandingPageCubit>(context)
                          .sharedPreferences
                          .containsKey(AppConstants.userType))
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 20),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                InkWell(
                                  onTap:  BlocProvider
                                      .of<LandingPageCubit>(context)
                                      .sharedPreferences
                                      .containsKey(AppConstants.userType) ? () {
                                    const MyLiveStockScreen().navigate();
                                  } : () {
                                    const RegisterPopUp().navigate();
                                  },
                                  child: Container(
                                    margin: const EdgeInsets.only(
                                        right: 12, left: 0),
                                    padding: const EdgeInsets.all(10),
                                    decoration: boxDecoration(
                                        borderColor: const Color(0xffDCDCDC),
                                        borderWidth: 1,
                                        borderRadius: 62,
                                        backgroundColor: Colors.white),
                                    child: 'My Livestock Ads'.textMedium(
                                        fontSize: 12, color: Colors.black),
                                  ),
                                ),
                                InkWell(
                                  onTap:  BlocProvider
                                      .of<LandingPageCubit>(context)
                                      .sharedPreferences
                                      .containsKey(AppConstants.userType) ? () {
                                    const LoanApplication(type: 'buyer',).navigate();
                                  } : () {
                                    const RegisterPopUp().navigate();
                                  },
                                  child: Container(
                                    margin: const EdgeInsets.only(
                                        right: 12, left: 0),
                                    padding: const EdgeInsets.all(10),
                                    decoration: boxDecoration(
                                        borderColor: const Color(0xffDCDCDC),
                                        borderWidth: 1,
                                        borderRadius: 62,
                                        backgroundColor: Colors.white),
                                    child: 'Loan Applications'.textMedium(
                                        fontSize: 12, color: Colors.black),
                                  ),
                                ),
                              ],
                            ),
                            InkWell(
                                onTap: () {
                                  List<String> roiList = [
                                    'Default',
                                    'Price Highest to Lowest',
                                    'Price Lowest to Highest',
                                    'Age Highest to Lowest',
                                    'Age Lowest to Highest',
                                    'Yield Highest to Lowest',
                                    'Yield Lowest to Highest',
                                  ];
                                  List<String> roiRequestToApi = [
                                    '',
                                    'price_highest_desc',
                                    'price_lowest_asc',
                                    'age_highest_desc',
                                    'age_lowest_asc',
                                    'yield_highest_desc',
                                    'yield_lowest_asc'
                                  ];
                                  modalBottomSheetMenu(context,
                                      child: BlocBuilder<LivestockCubit, LivestockCubitState>(
                                          builder: (context, state) {
                                          return SizedBox(
                                            height: screenHeight() * 0.65,
                                            child: Column(
                                              children: [
                                                Padding(
                                                  padding: const EdgeInsets.only(
                                                      left: 8.0, right: 8),
                                                  child: Row(
                                                    mainAxisAlignment:
                                                    MainAxisAlignment.spaceBetween,
                                                    children: [
                                                      TextButton(
                                                          onPressed: () {
                                                            pressBack();
                                                          },
                                                          child: "Cancel".textMedium(
                                                              color:
                                                              const Color(0xff6A0030),
                                                              fontSize: 14)),
                                                      "Sort By".textMedium(fontSize: 22),
                                                      TextButton(
                                                          onPressed: () {
                                                            BlocProvider.of<LivestockCubit>(context).roiFilter('');
                                                          },
                                                          child: "Reset".textMedium(
                                                              color:
                                                              const Color(0xff6A0030),
                                                              fontSize: 14))
                                                    ],
                                                  ),
                                                ),
                                                const Padding(
                                                  padding: EdgeInsets.only(
                                                      left: 20.0, right: 20),
                                                  child: Divider(),
                                                ),
                                                Expanded(
                                                  child: customList(
                                                      list: roiList,
                                                      child: (index) {
                                                        return InkWell(
                                                          onTap: (){
                                                            BlocProvider.of<LivestockCubit>(context).roiFilter(roiRequestToApi[index].toString());
                                                          },
                                                          child: Padding(
                                                              padding: const EdgeInsets
                                                                  .only (
                                                                  left: 30,
                                                                  right: 30,
                                                                  top: 30,
                                                                  bottom: 10),
                                                              child: Row(
                                                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                                children: [
                                                                  roiList[index].toString()
                                                                      .textRegular(
                                                                      fontSize: 16),
                                                                  state.roiFilter == roiRequestToApi[index].toString()?
                                                                  const Icon(Icons.check,color: Colors.red,):const SizedBox.shrink()
                                                                ],
                                                              )),
                                                        );
                                                      }),
                                                ),
                                                10.verticalSpace(),
                                                Container(
                                                    margin: 20.marginAll(),
                                                    height: 55,
                                                    width: screenWidth(),
                                                    child: customButton("Apply",
                                                        fontColor: 0xffffffff,
                                                        onTap: () {
                                                          BlocProvider.of<LivestockCubit>(context).livestockListApi(context,false);
                                                          pressBack();
                                                        }))
                                              ],
                                            ),
                                          );
                                        }
                                      ),
                                  );
                                }, child: SvgPicture.asset(Images.filter2)),
                          ],
                        ),
                      ),
                      landingPage(context, state),
                    ],
                  ),
                ],
              ),
            );
          }
      }
    );
  }

  Widget landingPage(BuildContext context, LivestockCubitState state){
    return state.responseLivestockList!.data != null ? Expanded(
      child: state.responseLivestockList!.data!.liveStoclLIst!.isNotEmpty?
      customGrid(
          padding: const EdgeInsets.fromLTRB(13,13,13,120),
          list: state.responseLivestockList!.data!.liveStoclLIst ?? [],
          crossAxisSpacing: 13,
          mainAxisSpacing: 13,
          mainAxisExtent: 250,
          context, child: (index){
        return InkWell(
          onTap: () {
            LiveStockDetail(id: state.responseLivestockList!.data!.liveStoclLIst![index].id.toString(), isMyLivestock: false,type: 'buyer').navigate();
          },
          child: customShadowContainer(
            margin: 0,
            backColor: Colors.grey.withOpacity(0.4),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Stack(
                  alignment: Alignment.bottomRight,
                  children: [
                    if(state.responseLivestockList!.data!.liveStoclLIst![index].liveStockDocumentFiles!.isNotEmpty)
                      SizedBox(
                          // padding: 2.marginAll(),
                          width: screenWidth(),
                          height:140,child: ClipRRect(borderRadius: const BorderRadius.only(topRight: Radius.circular(20),topLeft: Radius.circular(20)),child: CachedNetworkImage(imageUrl: state.responseLivestockList!.data!.liveStoclLIst![index].liveStockDocumentFiles![0].originalUrl ?? '',
                        fit: BoxFit.cover,
                        errorWidget: (_, __, ___) =>
                            Image.asset(Images.sampleVideo,width: screenWidth(),),)))
                    else
                      const SizedBox(height: 140,),

                    if(state.responseLivestockList!.data!.liveStoclLIst![index].liveStockDocumentFiles!.length > 1)
                      customShadowContainer(
                        backColor: Colors.transparent,
                        color: Colors.transparent,
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            (state.responseLivestockList!.data!.liveStoclLIst![index].liveStockDocumentFiles!.length).toString().textRegular(fontSize: 14, color: Colors.white),
                            const Icon(Icons.image_outlined, color: Colors.white,)
                          ],),
                      )
                  ],
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 10.0, right: 10, top: 6),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      RichText(
                          text: TextSpan(children: [
                            TextSpan(
                                text: '${state.responseLivestockList!.data!.liveStoclLIst![index].cowBreed!.name ?? ''} cow ',
                                style: figtreeMedium.copyWith(
                                    fontSize: 12, color: Colors.black)),
                            TextSpan(
                                text: '(${state.responseLivestockList!.data!.liveStoclLIst![index].advertisementNo ?? ''})',
                                style: figtreeMedium.copyWith(
                                    fontSize: 12, color: const Color(0xFF727272)))
                          ])),
                      6.verticalSpace(),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(getCurrencyString(double.parse(state.responseLivestockList!.data!.liveStoclLIst![index].price.toString())),
                              style: figtreeSemiBold.copyWith(
                                  fontSize: 18, color: Colors.black)),
                          RichText(
                              text: TextSpan(children: [
                                TextSpan(
                                    text: 'Qty: ',
                                    style: figtreeMedium.copyWith(
                                        fontSize: 12, color: const Color(0xFF727272))),
                                TextSpan(
                                    text: state.responseLivestockList!.data!.liveStoclLIst![index].balanceCows.toString(),
                                    style: figtreeMedium.copyWith(
                                        fontSize: 12, color: Colors.black)),
                              ])),
                        ],
                      ),
                      12.verticalSpace(),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          RichText(
                              text: TextSpan(children: [
                                TextSpan(
                                    text: 'Age: ',
                                    style: figtreeMedium.copyWith(
                                        fontSize: 12, color: const Color(0xFF727272))),
                                TextSpan(
                                    text: '${state.responseLivestockList!.data!.liveStoclLIst![index].age ?? ''} yrs',
                                    style: figtreeMedium.copyWith(
                                        fontSize: 12, color: Colors.black)),
                              ])),
                          // 10.horizontalSpace(),
                          Container(
                            height: 5,
                            width: 5,
                            decoration: const BoxDecoration(
                                color: Colors.black, shape: BoxShape.circle),
                          ),
                          // 10.horizontalSpace(),
                          RichText(
                              text: TextSpan(children: [
                                TextSpan(
                                    text: 'Milk: ',
                                    style: figtreeMedium.copyWith(
                                        fontSize: 12, color: const Color(0xFF727272))),
                                TextSpan(
                                    text: '${double.parse(state.responseLivestockList!.data!.liveStoclLIst![index].yield ?? '').toInt()}L/day',
                                    style: figtreeMedium.copyWith(
                                        fontSize: 12, color: Colors.black))
                              ])),
                        ],
                      ),
                      6.verticalSpace(),
                      Row(
                        children: [
                          Text(state.responseLivestockList!.data!.liveStoclLIst![index].user!=null?state.responseLivestockList!.data!.liveStoclLIst![index].user!.name != null
                              ? "${state.responseLivestockList!.data!.liveStoclLIst![index].user!.name}, " ?? ''
                              : '':'',
                            style: figtreeMedium.copyWith(
                                fontSize: 12, color: Colors.black), maxLines: 1,),

                          Flexible(
                            child: Text(state.responseLivestockList!.data!.liveStoclLIst![index].user!=null?state.responseLivestockList!.data!.liveStoclLIst![index].user!.address != null
                                ? state.responseLivestockList!.data!.liveStoclLIst![index].user!.address!.address ?? ''
                                : '':'',
                              overflow: TextOverflow.ellipsis,
                              style: figtreeMedium.copyWith(
                                  fontSize: 12, color: Colors.black), maxLines: 1,),

                          ),
                        ],
                      ),
                      // 12.verticalSpace(),
                      // Row(
                      //   children: [
                      //     Container(
                      //       decoration: BoxDecoration(
                      //         borderRadius: BorderRadius.circular(26),
                      //         border: Border.all(color: const Color(0xFFFC5E60)),
                      //       ),
                      //       padding: const EdgeInsets.symmetric(
                      //           horizontal: 16, vertical: 9.5),
                      //       child: SvgPicture.asset(Images.chatBubble),
                      //     ),
                      //     6.horizontalSpace(),
                      //     Container(
                      //       decoration: BoxDecoration(
                      //         borderRadius: BorderRadius.circular(50),
                      //         border: Border.all(color: const Color(0xffF6B51D)),
                      //       ),
                      //       padding: const EdgeInsets.symmetric(
                      //           vertical: 10.0, horizontal: 9.5),
                      //       child: Text('Add to Cart',
                      //           style: figtreeMedium.copyWith(
                      //               fontSize: 13.5, color: Colors.black)),
                      //     )
                      //   ],
                      // )
                    ],
                  ),
                ),
              ],
            ),
          ),
        );
      }):const Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text('No data found'),
        ],
      ),
    ) : const Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text('No data found'),
      ],
    );
  }
}
