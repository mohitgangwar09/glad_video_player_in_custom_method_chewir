import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:glad/cubit/landing_page_cubit/landing_page_cubit.dart';
import 'package:glad/screen/common/community_forum.dart';
import 'package:glad/screen/common/dde_in_area.dart';
import 'package:glad/screen/common/featured_trainings.dart';
import 'package:glad/screen/common/landing_carousel.dart';
import 'package:glad/screen/common/livestock_marketplace.dart';
import 'package:glad/screen/common/mcc_in_area.dart';
import 'package:glad/screen/common/review.dart';
import 'package:glad/screen/common/trending_news.dart';
import 'package:glad/screen/custom_widget/custom_appbar.dart';
import 'package:glad/screen/custom_widget/custom_methods.dart';
import 'package:glad/screen/custom_widget/show_all_button.dart';
import 'package:glad/screen/farmer_screen/common/widegt/project_widget.dart';
import 'package:glad/screen/farmer_screen/dashboard/dashboard_farmer.dart';
import 'package:glad/screen/farmer_screen/dashboard/milk_production_yield.dart';
import 'package:glad/screen/farmer_screen/profile/farmer_profile.dart';
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

    // SchedulerBinding.instance.addPostFrameCallback((_) {
    BlocProvider.of<LandingPageCubit>(context).getFarmerDashboard(context);
    // });
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
      }else if(state.response==null){
        return Center(child: Text("${state.response} Api Error"));
      }else{
        return Container(
          color: Colors.white,
          child: Stack(
            children: [
              landingBackground(),
              Column(
                children: [
                  CustomAppBar(
                    context: context,
                    titleText1: 'Hello ',
                    titleText2: state.response!=null? state.response!.farmerMaster!.name!.split(' ')[0]:"",
                    leading: openDrawer(
                        onTap: () {
                          farmerLandingKey.currentState?.openDrawer();
                        },
                        child: SvgPicture.asset(Images.drawer)),
                    action: Row(
                      children: [
                        InkWell(
                            onTap: () {}, child: SvgPicture.asset(Images.call)),
                        7.horizontalSpace(),
                        InkWell(
                            onTap: () {
                              const FarmerProfile().navigate();
                            },
                            child: CachedNetworkImage(
                              imageUrl: state.response!.farmerMaster!.photo!,
                              errorWidget: (_, __, ___) =>
                                  SvgPicture.asset(Images.person),
                            )),
                        8.horizontalSpace(),
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
    });
  }

  Widget landingPage(context, LandingPageState state) {
    return Expanded(
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const LandingCarousel(),
            10.verticalSpace(),
            Padding(
              padding: const EdgeInsets.only(right: 20.0, left: 10, bottom: 25),
              child: Column(
                children: [
                  Row(
                    children: [
                      Expanded(
                        child: InkWell(
                          onTap: () {
                            const MilkProductionYield().navigate();
                          },
                          child: customProjectContainer(
                              width: screenWidth(),
                              child: graphCard('${state.response!
                                  .farmerMilkProduction![0].totalMilkProduction}K ltr.', 'Milk produced', 'Last 6 months')),
                        ),
                      ),
                      Expanded(
                        child: InkWell(
                          onTap: () {
                            const MilkProductionYield().navigate();
                          },
                          child: customProjectContainer(
                              width: screenWidth(), child: graphCard('UGX ${state.response!
                              .farmerMilkProduction![0].suppliedToPdfl}M', 'Supplied to PDFL', 'Last 6 months')),
                        ),
                      )
                    ],
                  ),
                  Row(
                    children: [
                      Expanded(
                        child: InkWell(
                          onTap: () {
                            const MilkProductionYield().navigate();
                          },
                          child: customProjectContainer(
                              width: screenWidth(), child: graphCard('40 cows', 'Milking cows', '05 breeds')),
                        ),
                      ),
                      Expanded(
                        child: InkWell(
                          onTap: () {
                            const MilkProductionYield().navigate();
                          },
                          child: customProjectContainer(
                              width: screenWidth(), child: graphCard('${state.response!
                              .farmerMilkProduction![0].yieldPerCow} ltr.', 'Yield per cow', 'Each day')),
                        ),
                      )
                    ],
                  )
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(20, 10, 20, 0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  'Suggested Investment'.textMedium(fontSize: 18),
                  ShowAllButton(onTap: () {})
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
                          name: state.response!.farmerProject![i].name!,
                          targetYield:
                              state.response!.farmerProject![i].targetYield!,
                          investment: state
                              .response!.farmerProject![i].investmentAmount!,
                          revenue:
                              state.response!.farmerProject![i].revenuePerYear!,
                          index: i + 1,
                          incrementalProduction: state.response!.farmerProject![i].incrementalProduction ?? 180,
                          roi: state.response!.farmerProject![i].roiPerYear!,
                        ),
                        width: screenWidth() - 53);
                  }),
            ),
            10.verticalSpace(),
            MCCInArea(
              name: state.response!.mcc!.name ?? '',
              phone: state.response!.mcc!.phone ?? '+256 758711344',
              address: state.response!.mcc!.address ??
                  'Plot 11, street 09, Luwum St. Rwooz Plot 11, street 09, Luwum St. Rwooz',
              image: state.response!.mcc!.image ?? '',
            ),
            35.verticalSpace(),
            DDEInArea(
              name: state.response!.dde!.name ?? 'Begumanya Charles',
              phone: state.response!.dde!.phone ?? '+256 758711344',
              image: state.response!.dde!.image ?? '',
            ),
            topPerformingFarmer(),
            35.verticalSpace(),
            const LiveStockMarketplace(),
            10.verticalSpace(),
            const CommunityForum(
              name: 'Begumanya Charles',
              location: '+256 758711344',
              image: '',
              caption:
                  'Lorem Ipsum has been the industry\'s standard dummy text ever since the 1500s, when an unknown printer took a galley.',
              video: '',
              timeAgo: '5 Hrs ago',
            ),
            10.verticalSpace(),
            const FeaturedTrainings(),
            10.verticalSpace(),
            const TrendingNewsAndEvents(),
            10.verticalSpace(),
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
                    for (int index = 0; index < (state.response!.testimonials!.isNotEmpty ?3 : 0); index++)
                      GladReview(
                        review:
                            state.response!.testimonials![index].description!,
                        name: state.response!.testimonials![index].name == ''
                            ? 'John Smith'
                            : state.response!.testimonials![index].name!,
                        userType: 'Farmer',
                        location: 'Kampala, Uganda',
                        attachment:
                            state.response!.testimonials![index].attachment ??
                                '',
                        attachmentType:
                            state.response!.testimonials![index].type!,
                      ),
                  ],
                  options: CarouselOptions(
                    autoPlay: true,
                    enableInfiniteScroll: false,
                    viewportFraction: 1,
                    clipBehavior: Clip.none,
                    enlargeCenterPage: true,
                    height: screenHeight() < 750
                        ? screenHeight() * 0.285
                        : screenHeight() * 0.22,
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
                count: 3,
                effect: const WormEffect(
                    activeDotColor: ColorResources.maroon,
                    dotHeight: 7,
                    dotWidth: 7,
                    dotColor: ColorResources.grey),
              ),
            )),
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

  Widget topPerformingFarmer() {
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
                                "Hurton Elizabeth".textMedium(
                                    color: Colors.black, fontSize: 16),
                                4.verticalSpace(),
                                "1234 NW Bobcat Lane, St".textRegular(
                                    color: const Color(0xff727272)),
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
                                              text: '30',
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
                                              text: '15 LTR',
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
                                      onTap: () {}),
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
