import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
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
import 'package:glad/utils/extension.dart';
import 'package:glad/utils/helper.dart';
import 'package:glad/screen/guest_user/dashboard/dashboard_guest.dart';
import 'package:glad/utils/images.dart';

class GuestLandingPage extends StatelessWidget {
  const GuestLandingPage({super.key});

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
                leading: openDrawer(
                    onTap: () {
                      landingKey.currentState?.openDrawer();
                    },
                    child: SvgPicture.asset(Images.drawer)),
                action: Row(
                  children: [
                    InkWell(onTap: () async{
                      await callOnMobile(256758711344);
                    }, child: SvgPicture.asset(Images.call)),
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
              landingPage(),
            ],
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
            const GladReview(),
            100.verticalSpace(),
          ],
        ),
      ),
    );
  }
}
