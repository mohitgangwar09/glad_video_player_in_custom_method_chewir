import 'package:carousel_slider/carousel_slider.dart';
import 'package:device_information/device_information.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:glad/cubit/landing_page_cubit/landing_page_cubit.dart';
import 'package:glad/screen/auth_screen/login_with_password.dart';
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
import 'package:glad/screen/dde_screen/dde_profile.dart';
import 'package:glad/utils/color_resources.dart';
import 'package:glad/utils/extension.dart';
import 'package:glad/utils/helper.dart';
import 'package:glad/screen/guest_user/dashboard/dashboard_guest.dart';
import 'package:glad/utils/images.dart';
import 'package:glad/utils/styles.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class GuestLandingPage extends StatefulWidget {
  const GuestLandingPage({super.key});

  @override
  State<GuestLandingPage> createState() => _GuestLandingPageState();
}

class _GuestLandingPageState extends State<GuestLandingPage> {
  int activeIndex = 0;

  @override
  void initState() {
    super.initState();

    SchedulerBinding.instance.addPostFrameCallback((_) {
      BlocProvider.of<LandingPageCubit>(context).getGuestDashboard(context);
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
      } else if (state.guestDashboardResponse == null) {
        return Center(child: Text("${state.guestDashboardResponse} Api Error"));
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
                    titleText1: 'Welcome to ',
                    titleText2: 'GLAD',
                    leading: openDrawer(
                        onTap: () {
                          landingKey.currentState?.openDrawer();
                        },
                        child: SvgPicture.asset(Images.drawer)),
                    action: Row(
                      children: [
                        phoneCall(256758711344),
                        7.horizontalSpace(),
                        InkWell(
                            onTap: () {
                              const LoginWithPassword().navigate();
                            },
                            child: SvgPicture.asset(Images.person)),
                        8.horizontalSpace(),
                      ],
                    ),
                  ),
                  landingPage(state),
                ],
              ),
            ],
          ),
        );
      }
    });
  }

  Widget landingPage(LandingPageState state) {
    return Expanded(
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const LandingCarousel(),
            10.verticalSpace(),
            const MCCInArea(
              name: 'Begumanya Charles',
              phone: '+256 758711344',
              address:
                  'Plot 11, street 09, Luwum St. Rwooz Plot 11, street 09, Luwum St. Rwooz',
              image: '',
            ),
            10.verticalSpace(),
            DDEInArea(
              name: state.guestDashboardResponse!.data!.dairyDevelopmentExecutive!.name ?? '',
              phone: state.guestDashboardResponse!.data!.dairyDevelopmentExecutive!.phone ?? '',
              image: state.guestDashboardResponse!.data!.dairyDevelopmentExecutive!.image ?? '',
              state: state,
            ),
            10.verticalSpace(),
            LiveStockMarketplace(
              onTapShowAll: () {},
            ),
            10.verticalSpace(),
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
                  items: ['', '', '']
                      .map<Widget>(
                        (e) => const GladReview(
                          review:
                              'Lorem is simply dummy of the printing and industry. Lorem Ipsum has industry\'s standard dummy.',
                          name: 'John Smith',
                          userType: 'Farmer',
                          location: 'Kampala, Uganda',
                          attachment: '',
                          attachmentType: 'image',
                        ),
                      )
                      .toList(),
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
            100.verticalSpace(),
          ],
        ),
      ),
    );
  }
}
