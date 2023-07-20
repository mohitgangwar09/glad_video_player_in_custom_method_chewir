import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:glad/screen/common/community_forum.dart';
import 'package:glad/screen/common/dde_in_area.dart';
import 'package:glad/screen/common/landing_carousel.dart';
import 'package:glad/screen/common/livestock_marketplace.dart';
import 'package:glad/screen/common/mcc_in_area.dart';
import 'package:glad/screen/drawer/guest_drawer.dart';
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
            Padding(
              padding: const EdgeInsets.only(left: 50.0),
              child: SvgPicture.asset(
                Images.ppBg,
                alignment: Alignment.topRight,
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 40.0),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          10.horizontalSpace(),
                          InkWell(
                              onTap: () {
                                const GuestSideDrawer().navigate();
                              },
                              child: SvgPicture.asset(Images.drawer)),
                          10.horizontalSpace(),
                          RichText(
                              text: TextSpan(children: [
                            TextSpan(
                                text: 'Welcome to ',
                                style: figtreeRegular.copyWith(
                                    fontWeight: FontWeight.w100,
                                    fontSize: 22,
                                    color: Colors.black)),
                            TextSpan(
                                text: 'GLAD',
                                style: figtreeMedium.copyWith(
                                    fontSize: 22, color: Colors.black))
                          ]))
                        ],
                      ),
                      Row(
                        children: [
                          SvgPicture.asset(Images.call),
                          10.horizontalSpace(),
                          SvgPicture.asset(Images.person),
                          15.horizontalSpace(),
                        ],
                      ),
                    ],
                  ),
                  Expanded(
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
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
