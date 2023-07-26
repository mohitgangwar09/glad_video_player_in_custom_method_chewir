import 'package:flutter/material.dart';
import 'package:glad/screen/common/community_forum.dart';
import 'package:glad/screen/common/dde_in_area.dart';
import 'package:glad/screen/common/landing_carousel.dart';
import 'package:glad/screen/common/livestock_marketplace.dart';
import 'package:glad/screen/common/mcc_in_area.dart';
import 'package:glad/screen/custom_widget/custom_methods.dart';
import 'package:glad/screen/farmer_screen/dashboard/bottom_navigation_farmer.dart';
import 'package:glad/utils/extension.dart';

class FarmerLandingPage extends StatelessWidget {
  const FarmerLandingPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      child: Stack(
        children: [

          landingBackground(),

          Padding(
            padding: const EdgeInsets.only(top: 15.0),
            child: Column(
              children: [

                guestAppBar(onTapDrawer: (){
                  farmerLandingKey.currentState?.openDrawer();
                }, onTapProfile: (){
                },visibility: true),

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
