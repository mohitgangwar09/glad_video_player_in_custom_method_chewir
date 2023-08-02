import 'package:flutter/material.dart';
import 'package:glad/screen/auth_screen/login_with_password.dart';
import 'package:glad/screen/common/community_forum.dart';
import 'package:glad/screen/common/dde_in_area.dart';
import 'package:glad/screen/common/featured_trainings.dart';
import 'package:glad/screen/common/landing_carousel.dart';
import 'package:glad/screen/common/livestock_marketplace.dart';
import 'package:glad/screen/common/mcc_in_area.dart';
import 'package:glad/screen/common/review.dart';
import 'package:glad/screen/common/trending_news.dart';
import 'package:glad/screen/custom_widget/custom_methods.dart';
import 'package:glad/screen/dde_screen/dde_profile.dart';
import 'package:glad/utils/extension.dart';
import 'dashboard/dashboard_guest.dart';

class GuestLandingPage extends StatelessWidget {
  const GuestLandingPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      child: Stack(
        children: [

          landingBackground(),

          Padding(
            padding: EdgeInsets.only(top: screenHeight()>750?40.0:20),
            child: Column(
              children: [

                customAppBar('Welcome to ', 'GLAD', onTapDrawer: (){
                  landingKey.currentState?.openDrawer();
                }, onTapProfile: (){
                  const LoginWithPassword().navigate();
                },drawerVisibility: true),

                landingPage(),

              ],
            ),
          ),

        ],
      ),
    );
  }


  Widget landingPage(){
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
            const DDEInArea(
              name: 'Begumanya Charles',
              phone: '+256 758711344',
              image: '',
            ),
            10.verticalSpace(),
            const LiveStockMarketplace(),
            10.verticalSpace(),
            const CommunityForum(
              name: 'Begumanya Charles',
              location: 'Kampala, Uganda',
              image: '',
              caption: 'Lorem Ipsum has been the industry\'s standard dummy text ever since the 1500s, when an unknown printer took a galley.',
              video: '',
              timeAgo: '5 Hrs ago',
            ),
            10.verticalSpace(),
            const FeaturedTrainings(),
            10.verticalSpace(),
            const TrendingNewsAndEvents(),
            10.verticalSpace(),
            const GladReview(),
            100.verticalSpace(),
          ],
        ),
      ),
    );
  }


}
