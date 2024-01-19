import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:glad/cubit/dashboard_cubit/dashboard_cubit.dart';
import 'package:glad/cubit/landing_page_cubit/landing_page_cubit.dart';
import 'package:glad/cubit/profile_cubit/profile_cubit.dart';
import 'package:glad/screen/common/community_forum.dart';
import 'package:glad/screen/common/dde_in_area.dart';
import 'package:glad/screen/common/featured_trainings.dart';
import 'package:glad/screen/common/landing_carousel.dart';
import 'package:glad/screen/custom_loan/custom_loan_list.dart';
import 'package:glad/screen/farmer_screen/profile/edit_kyc_documents.dart';
import 'package:glad/screen/farmer_screen/profile/kyc_update.dart';
import 'package:glad/screen/livestock/livestock_marketplace.dart';
import 'package:glad/screen/common/mcc_in_area.dart';
import 'package:glad/screen/common/review.dart';
import 'package:glad/screen/common/trending_news.dart';
import 'package:glad/screen/custom_widget/custom_appbar.dart';
import 'package:glad/screen/custom_widget/custom_methods.dart';
import 'package:glad/screen/custom_widget/show_all_button.dart';
import 'package:glad/screen/farmer_screen/common/widegt/project_widget.dart';
import 'package:glad/screen/farmer_screen/dashboard/dashboard_farmer.dart';
import 'package:glad/screen/farmer_screen/dashboard/milk_production_yield.dart';
import 'package:glad/screen/farmer_screen/dashboard/supplied_to_pdfl.dart';
import 'package:glad/screen/farmer_screen/farmer_comparison.dart';
import 'package:glad/screen/farmer_screen/online_training.dart';
import 'package:glad/screen/farmer_screen/profile/farmer_profile.dart';
import 'package:glad/screen/guest_user/dashboard_tab_screen/news_and_event.dart';
import 'package:glad/utils/app_constants.dart';
import 'package:glad/utils/color_resources.dart';
import 'package:glad/utils/extension.dart';
import 'package:glad/utils/images.dart';
import 'package:glad/utils/styles.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class FarmerLandingPage extends StatefulWidget {
  const FarmerLandingPage({Key? key}) : super(key: key);

  @override
  State<FarmerLandingPage> createState() => _FarmerLandingPageState();
}

class _FarmerLandingPageState extends State<FarmerLandingPage> {
  int activeIndex = 0;

  @override
  void initState() {
    super.initState();

    SchedulerBinding.instance.addPostFrameCallback((_) {
      BlocProvider.of<LandingPageCubit>(context).getFarmerDashboard(context);
    });
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LandingPageCubit, LandingPageState>(
        builder: (context, state) {
      if (state.status == LandingPageStatus.loading) {
        return const Center(
            child: CircularProgressIndicator(
          color: ColorResources.maroon,
        ));
      } else
        if (state.response == null) {
        return Center(child: Text("${state.response} Api Error"));
      } else {
        return Container(
          color: Colors.white,
          child: Stack(
            children: [
              landingBackground(),

              Column(
                children: [
                  Column(
                    children: [
                      CustomAppBar(
                        context: context,
                        titleText1: 'Hello ',
                        titleText2: state.response!=null?state.response!.user!.name.toString():'',
                        leading: openDrawer(
                            onTap: () {
                              farmerLandingKey.currentState?.openDrawer();
                            },
                            child: SvgPicture.asset(Images.drawer)),
                        action: Row(
                          children: [
                            phoneCall(256758711344),
                            7.horizontalSpace(),
                            InkWell(
                                onTap: () {
                                  const FarmerProfile().navigate();
                                },
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(1000),
                                  child: Container(
                                    height: AppBar().preferredSize.height * 0.7,
                                    width: AppBar().preferredSize.height * 0.7,
                                    decoration:
                                    const BoxDecoration(shape: BoxShape.circle),
                                    child: state.response!.user!.profilePic!=null?CachedNetworkImage(
                                      imageUrl:
                                      state.response!.user!.profilePic!,
                                      errorWidget: (_, __, ___) =>
                                          SvgPicture.asset(Images.person),
                                      fit: BoxFit.cover,
                                    ):SvgPicture.asset(Images.person),
                                  ),
                                )),
                            8.horizontalSpace(),
                          ],
                        ),
                      ),

                      state.response!.user!.farmerMaster!.kycStatus!=null?
                        state.response!.user!.farmerMaster!.kycStatus == "verified"?
                        const SizedBox.shrink():
                        Container(
                          width: screenWidth(),
                          margin: const EdgeInsets.symmetric(horizontal: 20),
                          height: 45,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(80),
                            color: const Color(0xffFC5E60),
                          ),
                          child: Row(
                            children: [
                              if(state.response!.user!.farmerMaster!.kycStatus == "not_available")
                                Row(
                                  children: [
                                    14.horizontalSpace(),
                                    SvgPicture.asset(Images.kyc),
                                    4.horizontalSpace(),
                                    "Your KYC is pending.".textSemiBold(fontSize: 12,color: Colors.white),
                                    10.horizontalSpace(),
                                    InkWell(
                                      onTap: ()async{
                                        KYCUpdate(farmerId: state.response!.user!.farmerMaster!.id, userId: state.response!.user!.id.toString()).navigate();
                                      },
                                      child: Text(
                                        'Upload Documents',
                                        style: figtreeMedium.copyWith(
                                            fontSize: 12, color: ColorResources.white,decoration: TextDecoration.underline),
                                      ),
                                    )
                                  ],
                                )
                              else if(state.response!.user!.farmerMaster!.kycStatus == "pending")
                                Row(
                                  children: [
                                    14.horizontalSpace(),
                                    SvgPicture.asset(Images.kyc),
                                    4.horizontalSpace(),
                                    "Your KYC is pending.".textSemiBold(fontSize: 12,color: Colors.white),
                                    10.horizontalSpace(),
                                    InkWell(
                                      onTap: (){
                                        // const KYCUpdate().navigate();
                                        // print(state.response!.user!.farmerMaster!.kycDocument);
                                        EditKYCDocuments(farmerDocuments: state.response!.user!.farmerMaster!.kycDocument, farmerId: state.response!.user!.farmerMaster!.id, userId: state.response!.user!.id.toString()).navigate();
                                      },
                                      child: Text(
                                        'Edit Documents',
                                        style: figtreeMedium.copyWith(
                                            fontSize: 12, color: ColorResources.white,decoration: TextDecoration.underline),
                                      ),
                                    )
                                  ],
                                )
                              // else if(state.response!.user!.farmerMaster!.kycStatus == "expired")
                              //   Row(
                              //       children: [
                              //         14.horizontalSpace(),
                              //         const Icon(Icons.watch_later_outlined,size: 15,color: Colors.white,),
                              //         4.horizontalSpace(),
                              //         "Your KYC expired.".textSemiBold(fontSize: 12,color: Colors.white),
                              //         10.horizontalSpace(),
                              //         InkWell(
                              //           onTap: (){
                              //             // const SupplierUpdateKyc().navigate();
                              //           },
                              //           child: Text(
                              //             'Documents',
                              //             style: figtreeMedium.copyWith(
                              //                 fontSize: 12, color: ColorResources.white,decoration: TextDecoration.underline),
                              //           ),
                              //         )
                              //       ],
                              //     )
                              else if(state.response!.user!.farmerMaster!.kycStatus == "rejected")
                                Row(
                                      children: [
                                        14.horizontalSpace(),
                                        SvgPicture.asset(Images.kyc),
                                        4.horizontalSpace(),
                                        "Your KYC is rejected.".textSemiBold(fontSize: 12,color: Colors.white),
                                        10.horizontalSpace(),
                                        InkWell(
                                          onTap: ()async{
                                            KYCUpdate(farmerId: state.response!.user!.farmerMaster!.id, userId: state.response!.user!.id.toString()).navigate();
                                          },
                                          child: Text(
                                            'Upload Documents',
                                            style: figtreeMedium.copyWith(
                                                fontSize: 12, color: ColorResources.white,decoration: TextDecoration.underline),
                                          ),
                                        )
                                      ],
                                    )
                            ],
                          ),
                        ):const SizedBox.shrink()

                    ],
                  ),
                  /*CustomAppBar(
                    context: context,
                    titleText1: 'Hello ',
                    titleText2: state.response!=null? state.response!.user!.name!.split(' ')[0]:"",
                    leading: openDrawer(
                        onTap: () {
                          farmerLandingKey.currentState?.openDrawer();
                        },
                        child: SvgPicture.asset(Images.drawer)),
                    action: Row(
                      children: [
                        phoneCall(758711344),
                        7.horizontalSpace(),
                        InkWell(
                            onTap: () {
                              const FarmerProfile().navigate();
                            },
                            child: *//*ClipRRect(
                              borderRadius: BorderRadius.circular(1000),
                              child: Container(
                                height: AppBar().preferredSize.height * 0.7,
                                width: AppBar().preferredSize.height * 0.7,
                                decoration:
                                    const BoxDecoration(shape: BoxShape.circle),
                                child: state.response!.farmerMaster!.photo!=null?CachedNetworkImage(
                                  imageUrl:
                                      state.response!.farmerMaster!.photo!,
                                  errorWidget: (_, __, ___) =>
                                      SvgPicture.asset(Images.person),
                                  fit: BoxFit.cover,
                                ):SvgPicture.asset(Images.person),
                              ),
                            )*//*
                            ClipRRect(
                              borderRadius: BorderRadius.circular(1000),
                              child: Container(
                                height: AppBar().preferredSize.height * 0.7,
                                width: AppBar().preferredSize.height * 0.7,
                                decoration:
                                const BoxDecoration(shape: BoxShape.circle),
                                child: state.response!.user!.profilePic!=null?CachedNetworkImage(
                                  imageUrl:
                                  state.response!.user!.profilePic!,
                                  errorWidget: (_, __, ___) =>
                                      SvgPicture.asset(Images.person),
                                  fit: BoxFit.cover,
                                ):SvgPicture.asset(Images.person),
                              ),
                            )),
                        8.horizontalSpace(),
                      ],
                    ),
                  ),*/
                  landingPage(context, state),
                ],
              ),
            ],
          ),
        );
      }
    });
  }

  Widget landingPage(context, LandingPageState state) {
    return Expanded(
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            LandingCarousel(todayMilkPrice:state.response!.todayMilkPrice!=null?state.response!.todayMilkPrice!.milkPrice??0:0),
            10.verticalSpace(),
            state.response!.farmerMilkProduction!.isNotEmpty
                ? Padding(
                    padding: const EdgeInsets.only(
                        right: 20.0, left: 10, bottom: 25),
                    child: Column(
                      children: [
                        Row(
                          children: [
                            Expanded(
                              child: InkWell(
                                onTap: () {
                                  const MilkProductionYield(type: 'milk_production', farmerId: null).navigate();
                                },
                                child: customProjectContainer(
                                    width: screenWidth(),
                                    child: graphCard(
                                        '${getCurrencyString(state.response!.farmerMilkProduction![0].totalMilkProduction ?? 0, unit: '')} Ltr.',
                                        'Milk produced',
                                        'Last 6 months')),
                              ),
                            ),
                            Expanded(
                              child: InkWell(
                                onTap: () {
                                  const SuppliedToPDFL(farmerId: null).navigate();
                                },
                                child: customProjectContainer(
                                    width: screenWidth(),
                                    child: graphCard(
                                        getCurrencyString(state.response!.farmerMilkProduction![0].suppliedToPdfl ?? 0),
                                        'Supplied to PDFL',
                                        'Last 6 months')),
                              ),
                            )
                          ],
                        ),
                        Row(
                          children: [
                            Expanded(
                              child: InkWell(
                                onTap: () {
                                  const MilkProductionYield(type: 'milking_cows', farmerId: null).navigate();
                                },
                                child: customProjectContainer(
                                    width: screenWidth(),
                                    child: graphCard('${state.response!.farmerCowDetail!.milkingCow} cows', 'Milking cows',
                                        '')),
                              ),
                            ),
                            Expanded(
                              child: InkWell(
                                onTap: () {
                                  const MilkProductionYield(type: 'yield', farmerId: null).navigate();
                                },
                                child: customProjectContainer(
                                    width: screenWidth(),
                                    child: graphCard(
                                        '${state.response!.farmerCowDetail!.yieldPerCow} ltr.',
                                        'Yield per cow',
                                        'Each day')),
                              ),
                            )
                          ],
                        )
                      ],
                    ),
                  )
                : const SizedBox.shrink(),
            Padding(
              padding: const EdgeInsets.fromLTRB(20, 10, 20, 0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  'Suggested Investment'.textMedium(fontSize: 18),
                  ShowAllButton(onTap: () {
                    BlocProvider.of<DashboardCubit>(context).selectedIndex(1);
                  })
                ],
              ),
            ),
            Container(
              margin: const EdgeInsets.only(left: 10, right: 20),
              height: 242,
              child: customList(
                  list: List.generate(
                      state.response!.farmerProject!.length, (index) => index),
                  axis: Axis.horizontal,
                  child: (int i) {
                    return customProjectContainer(
                        child: ProjectWidget(
                          showStatus: false,
                          status: state.response!.farmerProject![i].projectStatus ?? '',
                          image: state.response!.farmerProject![i].project != null ? state.response!.farmerProject![i].project['image'] ?? '' : '',
                          name: state.response!.farmerProject![i].name ?? '',
                          targetYield:
                              state.response!.farmerProject![i].targetYield ??
                                  0,
                          investment: state.response!.farmerProject![i]
                                  .investmentAmount ??
                              0,
                          revenue: state
                                  .response!.farmerProject![i].revenuePerYear ??
                              0,
                          index: i + 1,
                          incrementalProduction: state.response!
                                  .farmerProject![i].incrementalProduction ??
                              0,
                          roi:
                              state.response!.farmerProject![i].roiPerYear ?? 0,
                          category: state.response!.farmerProject![i].farmerImprovementArea !=
                              null ? (state.response!.farmerProject![i].farmerImprovementArea!
                              .improvementArea != null ? state.response!.farmerProject![i].farmerImprovementArea!
                              .improvementArea!.name ?? '' : '') : '',
                          projectId: state.response!.farmerProject![i].id ?? 0,
                          selectedFilter: "suggested",
                        ),
                        width: screenWidth() - 53);
                  }),
            ),
            10.verticalSpace(),
            MCCInArea(
              name: state.response!.mcc!.name ?? '',
              phone: state.response!.mcc!.phone ?? '',
              address:state.response!.mcc!.address != null ? state.response!.mcc!.address!.address ??
                  '' : '',
              image: state.response!.mcc!.photo ?? '',
              lat : state.response!.mcc!.address != null ? state.response!.mcc!.address!.latitude ?? 28.4986 : 28.4986,
              long: state.response!.mcc!.address != null ? state.response!.mcc!.address!.longitude ?? 77.3999 : 77.3999,
            ),
            35.verticalSpace(),
            DDEInArea(
              name: state.response!.dde!.name ?? '',
              phone: state.response!.dde!.phone ?? ' ',
              image: state.response!.dde!.photo ?? '',
            ),
            // topPerformingFarmer(state),
            30.verticalSpace(),
            InkWell(
              onTap: () {
                const CustomLoanList().navigate();
              },
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Image.asset(Images.customLoan),
                )),
            30.verticalSpace(),
            LiveStockMarketplace(
              onTapShowAll: () {
                BlocProvider.of<DashboardCubit>(context).selectedIndex(3);
              },
            ),
            30.verticalSpace(),
            CommunityForum(
              onTapShowAll: () {
                BlocProvider.of<DashboardCubit>(context).selectedIndex(4);
              },
            ),
            10.verticalSpace(),
            FeaturedTrainings(trainingList: state.response!.trainingList ?? [], onTapShowAll: () {
              const OnlineTraining(isBottomAppBar: false).navigate();
            },),
            10.verticalSpace(),
            TrendingNewsAndEvents(newsList: state.response!.newsEvent ?? [], onTapShowAll: () {
              const NewsAndEvent(isBottomAppBar: false,).navigate();
            },),
            10.verticalSpace(),
            state.response!.testimonials!.isNotEmpty ?Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
              Padding(
                padding: const EdgeInsets.fromLTRB(20, 10, 20, 2),
                child: Text('GLAD makes you Happier!',
                    style: figtreeMedium.copyWith(
                        fontSize: 18, color: Colors.black)),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 20),
                child: CarouselSlider(
                    items: [
                      for (int index = 0;
                      index <
                          (state.response!.testimonials!.length.toInt() > 5 ? 5 : state.response!.testimonials!.length);
                      index++)
                        GladReview(
                          review:
                          state.response!.testimonials![index].description ??
                              '',
                          name: state.response!.testimonials![index].user != null ? state.response!.testimonials![index].user!.name ?? '' : '',
                          userType: 'Farmer',
                          location: state.response!.testimonials![index].user != null ? state.response!.testimonials![index].user!.address != null ? state.response!.testimonials![index].user!.address!.address ?? '' : '' : '',
                          attachment:
                          state.response!.testimonials![index].attachment ??
                              '',
                          attachmentType:
                          state.response!.testimonials![index].type ?? '',
                        ),
                    ],
                    options: CarouselOptions(
                      autoPlay: false,
                      enableInfiniteScroll: false,
                      viewportFraction: 1,
                      clipBehavior: Clip.none,
                      enlargeCenterPage: true,
                      height: screenHeight() < 750
                          ? screenHeight() * 0.275
                          : screenHeight() * 0.26,
                      onPageChanged: (index, reason) {
                        setState(() {
                          activeIndex = index;
                        });
                      },
                    )),
              ),
              Center(
                  child: Padding(
                    padding: const EdgeInsets.all(5),
                    child: AnimatedSmoothIndicator(
                      activeIndex: activeIndex,
                      count: state.response!.testimonials!.length.toInt() > 3 ? 3 : state.response!.testimonials!.length,
                      effect: const WormEffect(
                          activeDotColor: ColorResources.maroon,
                          dotHeight: 7,
                          dotWidth: 7,
                          dotColor: ColorResources.grey),
                    ),
                  )),
            ],) : const SizedBox.shrink(),

            100.verticalSpace()
          ],
        ),
      ),
    );
  }

  Stack graphCard(String value, String type, String desc) {
    return Stack(
      children: [
        Align(
          alignment: Alignment.center,
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                value.textMedium(fontSize: 22),
                Container(
                  width: 70,
                  margin: 10.marginAll(),
                  padding:
                      const EdgeInsets.symmetric(vertical: 4, horizontal: 7),
                  decoration: boxDecoration(
                    borderRadius: 30,
                    backgroundColor: const Color(0xffE4FFE3),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      "30%".textSemiBold(color: const Color(0xff4BC56F)),
                      const Icon(
                        Icons.trending_up,
                        color: Color(0xff4BC56F),
                        size: 20,
                      ),
                    ],
                  ),
                ),
                12.verticalSpace(),
                type.textMedium(fontSize: 14),
                7.verticalSpace(),
                desc.textMedium(fontSize: 12, color: const Color(0xff727272))
              ],
            ),
          ),
        ),
        Align(
            alignment: Alignment.topRight,
            child: Padding(
              padding: const EdgeInsets.only(right: 14.0, top: 9),
              child: SvgPicture.asset(Images.menuIcon),
            )),
      ],
    );
  }

  Widget topPerformingFarmer(LandingPageState state) {
    return Padding(
      padding: const EdgeInsets.only(left: 20.0, top: 30, right: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          "Top performing farmers".textMedium(fontSize: 18),
          25.verticalSpace(),
          SizedBox(
            height: 350,
            child: customList(
                list: List.generate(state.response!.topPerformerFarmer!.length,
                    (index) => null),
                axis: Axis.horizontal,
                child: (int index) {
                  return Padding(
                    padding: const EdgeInsets.only(right: 20.0),
                    child: Stack(
                      children: [
                        Container(
                          margin: 30.marginTop(),
                          height: 310,
                          width: screenWidth() - 140,
                          decoration: boxDecoration(
                              borderRadius: 18,
                              backgroundColor: const Color(0xffF9F9F9)),
                        ),
                        Positioned(
                            left: 0,
                            right: 0,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                CircleAvatar(
                                    radius: 35,
                                    child: Image.asset(Images.sampleUser,
                                        fit: BoxFit.cover,
                                        width: 70,
                                        height: 70)),
                                20.verticalSpace(),
                                (state.response!.topPerformerFarmer![index]
                                            .name ??
                                        '')
                                    .textMedium(
                                        color: Colors.black, fontSize: 16),
                                4.verticalSpace(),
                                Text(
                                    state.response!.topPerformerFarmer![index]
                                            .fAddress ??
                                        "1234 NW Bobcat Lane, St",
                                    style: figtreeRegular.copyWith(
                                        color: const Color(0xff727272))),
                                22.verticalSpace(),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    RichText(
                                      text: TextSpan(
                                        text: 'Milking Cows: ',
                                        style: figtreeRegular.copyWith(
                                            color: const Color(0xff727272)),
                                        children: <TextSpan>[
                                          TextSpan(
                                              text: '',
                                              style: figtreeSemiBold.copyWith(
                                                  color:
                                                      const Color(0xff23262A))),
                                        ],
                                      ),
                                    ),
                                    10.horizontalSpace(),
                                    const CircleAvatar(
                                      radius: 4,
                                      backgroundColor: Color(0xff23262A),
                                    ),
                                    10.horizontalSpace(),
                                    RichText(
                                      text: TextSpan(
                                        text: 'Yield: ',
                                        style: figtreeRegular.copyWith(
                                            color: const Color(0xff727272)),
                                        children: <TextSpan>[
                                          TextSpan(
                                              text:
                                                  '${state.response!.topPerformerFarmer![index].currentYield ?? 0} LTR',
                                              style: figtreeSemiBold.copyWith(
                                                  color:
                                                      const Color(0xff23262A))),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                                23.verticalSpace(),
                                Stack(
                                  children: [
                                    CircleAvatar(
                                        radius: 25,
                                        child: Image.asset(Images.sampleUser,
                                            fit: BoxFit.cover,
                                            width: 70,
                                            height: 70)),
                                    Padding(
                                      padding:
                                          const EdgeInsets.only(left: 40.0),
                                      child: CircleAvatar(
                                          radius: 25,
                                          child: Image.asset(Images.sampleUser,
                                              fit: BoxFit.cover,
                                              width: 70,
                                              height: 70)),
                                    ),
                                    Padding(
                                      padding:
                                          const EdgeInsets.only(left: 80.0),
                                      child: CircleAvatar(
                                          radius: 25,
                                          child: Image.asset(Images.sampleUser,
                                              fit: BoxFit.cover,
                                              width: 70,
                                              height: 70)),
                                    ),
                                  ],
                                ),
                                Container(
                                  margin: 20.marginTop(),
                                  width: 110,
                                  height: 45,
                                  child: customButton("Compare",
                                      borderColor: 0xFF6A0030,
                                      color: 0xFFffffff,
                                      fontColor: 0xFF6A0030,
                                      onTap: () {
                                    const FarmerComparison().navigate();
                                      }),
                                )
                              ],
                            )),
                      ],
                    ),
                  );
                }),
          ),
        ],
      ),
    );
  }
}
