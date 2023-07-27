import 'package:flutter/material.dart';
import 'package:glad/screen/common/community_forum.dart';
import 'package:glad/screen/common/featured_trainings.dart';
import 'package:glad/screen/common/landing_carousel.dart';
import 'package:glad/screen/common/trending_news.dart';
import 'package:glad/screen/custom_widget/custom_methods.dart';
import 'package:glad/screen/mcc_screen/profile/mcc_profile.dart';
import 'package:glad/utils/extension.dart';

class MCCLandingPage extends StatelessWidget {
  const MCCLandingPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      child: Stack(
        children: [
          landingBackground(),
          Padding(
            padding: const EdgeInsets.only(top: 40.0),
            child: Column(
              children: [
                customAppBar('Welcome to ', 'GLAD',
                    onTapDrawer: () {},
                    onTapProfile: () {
                  const MccProfile().navigate();
                    },
                    drawerVisibility: false),
                landingPage(),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget landingPage() {
    return Expanded(
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const LandingCarousel(),
            10.verticalSpace(),
            const CommunityForum(
              name: 'Begumanya Charles',
              location: 'Kampala, Uganda',
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
            100.verticalSpace(),
          ],
        ),
      ),
    );
  }
}
