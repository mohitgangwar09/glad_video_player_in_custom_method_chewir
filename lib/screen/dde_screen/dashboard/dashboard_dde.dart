import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:glad/cubit/dashboard_cubit/dashboard_cubit.dart';
import 'package:glad/screen/common/community.dart';
import 'package:glad/screen/custom_widget/custom_methods.dart';
import 'package:glad/screen/dde_screen/dashboard/dde_drawer.dart';
import 'package:glad/screen/dde_screen/dashboard_tab_screen/enquiry_screen.dart';
import 'package:glad/screen/dde_screen/dashboard_tab_screen/farmer_dde_tab_screen.dart';
import 'package:glad/screen/dde_screen/dashboard_tab_screen/landing_page.dart';
import 'package:glad/screen/dde_screen/dashboard_tab_screen/project_screen.dart';
import 'package:glad/screen/guest_user/drawer_screen.dart';
import 'package:glad/screen/dde_screen/dde_profile.dart';
import 'package:glad/utils/extension.dart';
import 'package:glad/utils/images.dart';
import 'package:glad/utils/color_resources.dart';

final GlobalKey<ScaffoldState> ddeLandingKey = GlobalKey();

class DashboardDDE extends StatelessWidget {
  const DashboardDDE({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var provider = BlocProvider.of<DashboardCubit>(context);

    final widgetOptions = [
      const DDELandingPage(),
      const FarmerDdeTabScreen(),
      const ProjectScreen(),
      const EnquiryScreen(),
      const CommunityPost()
    ];

    return BlocBuilder<DashboardCubit, DashboardState>(
      builder: (BuildContext context, state) {
        return Scaffold(
            key: ddeLandingKey,
            drawer: const DdeDrawer(),
            extendBody: true,
            body: widgetOptions.elementAt(state.selectedIndex),
            bottomNavigationBar: bottomNavigationBar(provider.state, context));
      },
    );
  }

  /////////////////  bottom Navigation Bar ////////////////////
  Widget bottomNavigationBar(DashboardState state, BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          margin:
              const EdgeInsets.only(left: 14, right: 14, top: 14, bottom: 14),
          padding: const EdgeInsets.only(left: 7, right: 7, top: 9, bottom: 9),
          decoration: BoxDecoration(
            color: ColorResources.primary,
            borderRadius: BorderRadius.circular(90),
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.5),
                spreadRadius: 0,
                blurRadius: 4,
                offset: const Offset(0, 4), // changes position of shadow
              ),
            ],
          ),
          // height: 72,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              bottomNavigationItem('Home', Images.home, context,
                  state.selectedIndex, 0, Images.selectedHome),
              10.horizontalSpace(),
              bottomNavigationItem('Farmers', Images.farmer, context,
                  state.selectedIndex, 1, Images.selectedFarmer),
              10.horizontalSpace(),
              bottomNavigationItem('Projects', Images.application, context,
                  state.selectedIndex, 2, Images.selectedApplication),
              10.horizontalSpace(),
              bottomNavigationItem('Enquiry', Images.enquiry, context,
                  state.selectedIndex, 3, Images.selectedEnquiry),
              10.horizontalSpace(),
              bottomNavigationItem('Community', Images.communityBottom, context,
                  state.selectedIndex, 4, Images.selectedCommunityBottom),
            ],
          ),
        ),
      ],
    );
  }
}
