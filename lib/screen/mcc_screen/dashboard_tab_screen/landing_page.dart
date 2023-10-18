import 'package:carousel_slider/carousel_slider.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:glad/screen/common/community_forum.dart';
import 'package:glad/screen/common/featured_trainings.dart';
import 'package:glad/screen/common/landing_carousel.dart';
import 'package:glad/screen/common/trending_news.dart';
import 'package:glad/screen/custom_widget/custom_appbar.dart';
import 'package:glad/screen/custom_widget/custom_methods.dart';
import 'package:glad/screen/mcc_screen/dashboard_tab_screen/application_widget.dart';
import 'package:glad/screen/mcc_screen/profile/mcc_profile.dart';
import 'package:glad/utils/color_resources.dart';
import 'package:glad/utils/extension.dart';
import 'package:glad/utils/helper.dart';
import 'package:glad/utils/images.dart';
import 'package:glad/utils/styles.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class MCCLandingPage extends StatelessWidget {
  const MCCLandingPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      child: Stack(
        children: [
          landingBackground(),
          Column(
            children: [

              CustomAppBar(
                context: context,
                titleText1: 'Welcome to ',
                titleText2: 'GLAD',
                leading: null,
                action: Row(
                  children: [
                    phoneCall(256758711344),
                    7.horizontalSpace(),
                    InkWell(
                        onTap: () {
                          const MccProfile().navigate();
                        },
                        child: SvgPicture.asset(Images.person)),
                    8.horizontalSpace(),
                  ],
                ),
              ),
              landingPage(context),
            ],
          ),
        ],
      ),
    );
  }

  Widget landingPage(context) {
    return Expanded(
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const LandingCarousel(),
            10.verticalSpace(),

            Padding(
              padding: const EdgeInsets.only(right: 20.0,bottom: 25,left: 10),
              child: customGrid(
                  context,
                  mainAxisExtent: 160,
                  crossAxisSpacing: 10,
                  child: (int index) {
                    return customProjectContainer(
                        width: screenWidth(),
                        child: Stack(
                          children: [
                            Align(
                              alignment: Alignment.center,
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [

                                  "09".textMedium(fontSize: 32,
                                      color: const Color(0xffFC5E60)),

                                  12.verticalSpace(),

                                  "Pending".textMedium(fontSize: 16),

                                  7.verticalSpace(),

                                  "Loans pending for\n approval".textMedium(fontSize: 12,color: const Color(0xff727272),
                                      maxLines: 2,overflow: TextOverflow.ellipsis,textAlign: TextAlign.center),


                                ],
                              ),
                            ),
                          ],
                        ));
                  }),
            ),

            Padding(
              padding: const EdgeInsets.only(left: 24.0,right: 24,top: 10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  "Pending Application".textMedium(fontSize: 18),

                  "View All".textSemiBold(underLine: TextDecoration.underline,
                  fontSize: 12,color: const Color(0xff6A0030))
                ],
              ),
            ),

            Container(
              margin: const EdgeInsets.only(left: 8),
              height: 235,
                child: customList(axis: Axis.horizontal,child: (index){
                  return const Padding(
                    padding: EdgeInsets.only(right: 5.0,left: 0),
                    child: MCCApplicationScreen(),
                  );})),

            30.verticalSpace(),

            ddeProfileSlider(context),

            CommunityForum(
              name: 'Begumanya Charles',
              location: 'Kampala, Uganda',
              image: '',
              caption:
                  'Lorem Ipsum has been the industry\'s standard dummy text ever since the 1500s, when an unknown printer took a galley.',
              video: '',
              timeAgo: '5 Hrs ago',
              onTapShowAll: () {},
            ),
            10.verticalSpace(),
            const FeaturedTrainings(),
            10.verticalSpace(),
            const TrendingNewsAndEvents(),
            100.verticalSpace(),
          ],
        ),
      ),
    );
  }

  Widget ddeProfileSlider(context){
    return Padding(
      padding: const EdgeInsets.only(left: 10.0,right: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [

          Padding(padding: const EdgeInsets.only(left: 10),
          child: 'DDE'.textMedium(fontSize: 18),),

          CarouselSlider(
            items: [1,2,3,4].map<Widget>((e) => Stack(
              alignment: Alignment.center,
              children: [
                SizedBox(
                    height: 100,
                    width: MediaQuery.of(context).size.width),
                customProjectContainer(
                  // height: 115,
                  width: MediaQuery.of(context).size.width,
                  child: Column(
                    children: [

                      Padding(
                        padding: const EdgeInsets.fromLTRB(15.0, 20, 0, 10),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Image.asset(Images.sampleUser),
                            15.horizontalSpace(),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text('Begumanya Charles',
                                    style: figtreeMedium.copyWith(
                                        fontSize: 16, color: Colors.black)),
                                4.verticalSpace(),
                                Row(
                                  crossAxisAlignment: CrossAxisAlignment.end,
                                  children: [
                                    const Icon(
                                      Icons.call,
                                      color: Colors.black,
                                      size: 16,
                                    ),
                                    Text('+256 758711344',
                                        style: figtreeRegular.copyWith(
                                            fontSize: 12, color: Colors.black)),
                                  ],
                                ),
                                4.verticalSpace(),
                                Row(
                                  crossAxisAlignment: CrossAxisAlignment.end,
                                  children: [
                                    const Icon(
                                      Icons.location_on,
                                      color: Colors.black,
                                      size: 16,
                                    ),
                                    SizedBox(
                                      width:
                                      MediaQuery.of(context).size.width * 0.5,
                                      child: Text(
                                        'Plot 11, street 09, Luwum St. Rwooz',
                                        style: figtreeRegular.copyWith(
                                          fontSize: 12,
                                          color: Colors.black,
                                          overflow: TextOverflow.ellipsis,
                                        ),
                                      ),
                                    ),
                                  ],
                                )
                              ],
                            )
                          ],
                        ),
                      ),

                      const Padding(
                        padding: EdgeInsets.symmetric(horizontal: 24),
                        child: Divider(thickness: 1.2,color: Color(0xffDCDCDC))),

                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [

                          'Farmers Managed'.textMedium(fontSize: 14),

                          12.horizontalSpace(),

                          Stack(
                            children: [

                              CircleAvatar(
                                  radius: 20,
                                  child: Image.asset(Images.sampleUser,fit: BoxFit.cover,width: 40,height: 40)),

                              Padding(
                                padding: const EdgeInsets.only(left: 30.0),
                                child: CircleAvatar(
                                    radius: 20,
                                    child: Image.asset(Images.sampleUser,fit: BoxFit.cover,width: 70,height: 70)),
                              ),

                              Padding(
                                padding: const EdgeInsets.only(left: 60),
                                child: CircleAvatar(
                                    radius: 20,
                                    child: Image.asset(Images.sampleUser,fit: BoxFit.cover,width: 70,height: 70)),
                              ),

                            ],
                          ),

                          CircleAvatar(
                            radius: 20,
                            backgroundColor: Colors.yellow,
                            child: '+2'.textMedium(),
                          )

                        ],
                      )

                    ],
                  ),
                ),
                Positioned(
                    top: 0,
                    right: 10,
                    child: Row(
                      children: [
                        SvgPicture.asset(Images.callPrimary),
                        6.horizontalSpace(),
                        SvgPicture.asset(Images.whatsapp),
                        4.horizontalSpace(),
                      ],
                    )),
              ],
            )).toList(),
            options: CarouselOptions(
              autoPlay: true,
              clipBehavior: Clip.none,
              enableInfiniteScroll: false,
              viewportFraction: 1,
              height: 180,
              onPageChanged: (index, reason) {

              },
            )
          ),

          5.verticalSpace(),

          const Center(
            child: Padding(
              padding: EdgeInsets.all(5),
              child: AnimatedSmoothIndicator(
                activeIndex: 3,
                count: 3,
                effect: WormEffect(
                    activeDotColor: ColorResources.maroon,
                    dotHeight: 7,
                    dotWidth: 7,
                    dotColor: ColorResources.grey),
              ),
            ),
          ),

          15.verticalSpace(),

        ],
      ),
    );
  }

}