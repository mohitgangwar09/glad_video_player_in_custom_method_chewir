import 'package:flutter/material.dart';
import 'package:glad/screen/common/community_forum.dart';
import 'package:glad/screen/common/featured_trainings.dart';
import 'package:glad/screen/common/landing_carousel.dart';
import 'package:glad/screen/common/trending_news.dart';
import 'package:glad/screen/custom_widget/custom_methods.dart';
import 'package:glad/screen/supplier_screen/profile/service_provider_profile.dart';
import 'package:glad/utils/extension.dart';
import 'package:glad/utils/helper.dart';

import 'package:glad/screen/supplier_screen/dashboard/dashboard_supplier.dart';

class SupplierLandingPage extends StatelessWidget {
  const SupplierLandingPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      child: Stack(
        children: [
          landingBackground(),

          Padding(
            padding: EdgeInsets.only(top: appBarHeight()),
            child: Column(
              children: [
                customAppBar('Hello ', ' Hurton,', onTapDrawer: (){
                  landingKey.currentState?.openDrawer();
                }, onTapProfile: (){
                  const ServiceProvider().navigate();
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
            100.verticalSpace(),
          ],
        ),
      ),
    );
  }


}
