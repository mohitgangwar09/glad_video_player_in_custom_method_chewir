import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:glad/cubit/dashboard_cubit/dashboard_cubit.dart';
import 'package:glad/cubit/landing_page_cubit/landing_page_cubit.dart';
import 'package:glad/screen/auth_screen/login_with_password.dart';
import 'package:glad/screen/common/community_forum.dart';
import 'package:glad/screen/common/dde_in_area.dart';
import 'package:glad/screen/common/featured_trainings.dart';
import 'package:glad/screen/common/landing_carousel.dart';
import 'package:glad/screen/livestock/livestock_marketplace.dart';
import 'package:glad/screen/common/mcc_in_area.dart';
import 'package:glad/screen/common/review.dart';
import 'package:glad/screen/common/trending_news.dart';
import 'package:glad/screen/custom_widget/custom_appbar.dart';
import 'package:glad/screen/custom_widget/custom_methods.dart';
import 'package:glad/utils/color_resources.dart';
import 'package:glad/utils/extension.dart';
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
                        phoneCall(758711344),
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
            if(state.guestDashboardResponse!.data!.milkCollectionCenter != null)
            MCCInArea(
              name: state.guestDashboardResponse!.data!.milkCollectionCenter!.name ?? '',
              phone: state.guestDashboardResponse!.data!.milkCollectionCenter!.phone ?? '',
              address:
              state.guestDashboardResponse!.data!.milkCollectionCenter!.address != null ? state.guestDashboardResponse!.data!.milkCollectionCenter!.address!.address ?? '' : '',
              image: state.guestDashboardResponse!.data!.milkCollectionCenter!.photo ?? '',
              lat: state.guestDashboardResponse!.data!.milkCollectionCenter!.address != null ? state.guestDashboardResponse!.data!.milkCollectionCenter!.address!.latitude ?? 0 : 0,
              long: state.guestDashboardResponse!.data!.milkCollectionCenter!.address != null ? state.guestDashboardResponse!.data!.milkCollectionCenter!.address!.longitude ?? 0 : 0,
            ),
            10.verticalSpace(),
            if(state.guestDashboardResponse!.data!.milkCollectionCenter == null)
              const Padding(
                padding: EdgeInsets.only(top: 40, bottom: 40),
                child: Center(child: Text('No MCC, DDE Available')),
              )
            else if(state.guestDashboardResponse!.data!.dairyDevelopmentExecutive == null)
              const Padding(
                padding: EdgeInsets.only(top: 40, bottom: 40),
                child: Center(child: Text('No DDE Available')),
              ),
            if(state.guestDashboardResponse!.data!.dairyDevelopmentExecutive != null)
            DDEInArea(
              name: state.guestDashboardResponse!.data!.dairyDevelopmentExecutive!.name ?? '',
              phone: state.guestDashboardResponse!.data!.dairyDevelopmentExecutive!.phone ?? '',
              image: state.guestDashboardResponse!.data!.dairyDevelopmentExecutive!.photo ?? '',
              state: state,
            ),
            10.verticalSpace(),
            LiveStockMarketplace(
              onTapShowAll: () {
                BlocProvider.of<DashboardCubit>(context).selectedIndex(1);
              },
            ),
            10.verticalSpace(),
            CommunityForum(
              onTapShowAll: () {
                BlocProvider.of<DashboardCubit>(context).selectedIndex(2);
              },
            ),
            10.verticalSpace(),
            FeaturedTrainings(trainingList: state.guestDashboardResponse!.data!.trainingList ?? [], onTapShowAll: () {
              BlocProvider.of<DashboardCubit>(context).selectedIndex(4);
            },),
            10.verticalSpace(),
            TrendingNewsAndEvents(newsList: state.guestDashboardResponse!.data!.newsEvent ?? [], onTapShowAll: () {
              BlocProvider.of<DashboardCubit>(context).selectedIndex(3);
            },),
            10.verticalSpace(),
            state.guestDashboardResponse!.data!.testimonials!.isNotEmpty ?Column(
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
                            (state.guestDashboardResponse!.data!.testimonials!.length.toInt() > 5 ? 5 : state.guestDashboardResponse!.data!.testimonials!.length);
                        index++)
                          GladReview(
                            review:
                            state.guestDashboardResponse!.data!.testimonials![index].description ??
                                '',
                            name: state.guestDashboardResponse!.data!.testimonials![index].user != null ? state.guestDashboardResponse!.data!.testimonials![index].user!.name ?? '' : '',
                            userType: 'Farmer',
                            location: state.guestDashboardResponse!.data!.testimonials![index].user != null ? state.guestDashboardResponse!.data!.testimonials![index].user!.address != null ? state.guestDashboardResponse!.data!.testimonials![index].user!.address!.address ?? '' : '' : '',
                            attachment:
                            state.guestDashboardResponse!.data!.testimonials![index].attachment ??
                                '',
                            attachmentType:
                            state.guestDashboardResponse!.data!.testimonials![index].type ?? '',
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
                        count: state.guestDashboardResponse!.data!.testimonials!.length.toInt() > 3 ? 3 : state.guestDashboardResponse!.data!.testimonials!.length,
                        effect: const WormEffect(
                            activeDotColor: ColorResources.maroon,
                            dotHeight: 7,
                            dotWidth: 7,
                            dotColor: ColorResources.grey),
                      ),
                    )),
              ],) : const SizedBox.shrink(),
            100.verticalSpace(),
          ],
        ),
      ),
    );
  }
}
