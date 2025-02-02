import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:glad/cubit/dashboard_cubit/dashboard_cubit.dart';
import 'package:glad/screen/common/community.dart';
import 'package:glad/screen/custom_widget/custom_methods.dart';
import 'package:glad/screen/farmer_screen/online_training.dart';
import 'package:glad/screen/livestock/livestock_screen.dart';
import 'package:glad/screen/guest_user/dashboard_tab_screen/news_and_event.dart';
import 'package:glad/screen/guest_user/drawer_screen.dart';
import 'package:glad/screen/guest_user/dashboard_tab_screen/landing_page.dart';
import 'package:glad/utils/extension.dart';
import 'package:glad/utils/images.dart';
import 'package:glad/utils/color_resources.dart';

final GlobalKey<ScaffoldState> landingKey = GlobalKey();

class DashboardGuest extends StatelessWidget {
  const DashboardGuest({Key? key}) : super(key: key);

  static const widgetOptions = [
    GuestLandingPage(),
    LiveStockScreen(),
    CommunityPost(),
    NewsAndEvent(isBottomAppBar: true,),
    OnlineTraining(isBottomAppBar: true),
  ];

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<DashboardCubit, DashboardState>(
      builder: (BuildContext context, state) {
        return willPopScope(
          context: context,
          state: state,
          child: Scaffold(
              key: landingKey,
              extendBody: true,
              drawer: const GuestSideDrawer(),
              body: widgetOptions.elementAt(state.selectedIndex),
              bottomNavigationBar: bottomNavigationBar(state, context)),
        );
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
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              bottomNavigationItem('Home', Images.home, context,
                  state.selectedIndex, 0, Images.selectedHome),
              10.horizontalSpace(),
              bottomNavigationItem('Livestock', Images.liveStock, context,
                  state.selectedIndex, 1, Images.selectedLiveStock),
              10.horizontalSpace(),
              bottomNavigationItem('Community', Images.communityBottom, context,
                  state.selectedIndex, 2, Images.selectedCommunityBottom),
              10.horizontalSpace(),
              bottomNavigationItem('News', Images.newsBottom, context,
                  state.selectedIndex, 3, Images.selectedNewsBottom),
              10.horizontalSpace(),
              bottomNavigationItem('Training', Images.trainingBottom, context,
                  state.selectedIndex, 4, Images.selectedTrainingBottom),
            ],
          ),
        ),
      ],
    );
  }
}
