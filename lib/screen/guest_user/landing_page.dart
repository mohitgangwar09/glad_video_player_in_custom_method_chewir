import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:glad/screen/common/community_forum.dart';
import 'package:glad/screen/common/dde_in_area.dart';
import 'package:glad/screen/common/landing_carousel.dart';
import 'package:glad/screen/common/livestock_marketplace.dart';
import 'package:glad/screen/common/mcc_in_area.dart';
import 'package:glad/screen/custom_widget/custom_methods.dart';
import 'package:glad/screen/dashboard/bottom_navigation_dde.dart';
import 'package:glad/screen/drawer/guest_drawer.dart';
import 'package:glad/screen/profile/glad_profile.dart';
import 'package:glad/utils/extension.dart';
import 'package:glad/utils/images.dart';
import 'package:glad/utils/styles.dart';

class GuestLandingPage extends StatelessWidget {
  const GuestLandingPage({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      top: false,
      child: Scaffold(
        body: Stack(
          children: [

            landingBackground(),
            Padding(
              padding: const EdgeInsets.only(top: 40.0),
              child: Column(
                children: [
                  guestAppBar(onTapDrawer: (){
                    landingKey.currentState?.openDrawer();
                  }, onTapProfile: (){
                    const GladProfile().navigate();

                  },visibility: true),

                  landingPage(),

                ],
              ),
            ),

          ],
        ),
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
              location: '+256 758711344',
              image: '',
              caption: 'Begumanya Charles',
              video: '',
              timeAgo: '5 Hrs ago',
            ),



          ],
        ),
      ),
    );
  }


}
