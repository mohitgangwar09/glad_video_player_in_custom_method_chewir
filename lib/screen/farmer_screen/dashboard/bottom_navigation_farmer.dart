import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:glad/cubit/dashboard_cubit/dashboard_cubit.dart';
import 'package:glad/screen/custom_widget/custom_methods.dart';
import 'package:glad/screen/drawer/guest_drawer.dart';
import 'package:glad/screen/guest_user/landing_page.dart';
import 'package:glad/utils/color_resources.dart';
import 'package:glad/utils/extension.dart';
import 'package:glad/utils/images.dart';

class BottomNavigationFarmerScreen extends StatelessWidget {
  const BottomNavigationFarmerScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    var provider = BlocProvider.of<DashboardCubit>(context);

    SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
        statusBarColor: ColorResources.white,
        systemNavigationBarColor: Colors.black, // navigation bar color
        statusBarIconBrightness: Brightness.dark, // status bar icons' color
        systemNavigationBarIconBrightness: Brightness.light));


    final widgetOptions = [
      const GuestLandingPage(),
      const Text("Tours"),
      const Text("Stories"),
      const Text("Orders"),
      const Text("Earnings"),
    ];

    return SafeArea(
        top: false,
        bottom: true,
        child: BlocBuilder<DashboardCubit, DashboardState>(
          builder: (BuildContext context, state) {
            return Scaffold(
                drawer: const GuestSideDrawer(),
                body: widgetOptions.elementAt(state.selectedIndex),
                bottomNavigationBar: bottomNavigationBar(provider.state,context)
            );
          },
        )
    );
  }

  /////////////////  bottom Navigation Bar ////////////////////
  Widget bottomNavigationBar(DashboardState state,BuildContext context){
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          margin: const EdgeInsets.only(left: 14,right: 14,top: 14,bottom: 14),
          padding: const EdgeInsets.only(left: 7,right:7,top: 9,bottom: 9),
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

              bottomNavigationItem('Home',Images.home,context,state.selectedIndex,0,Images.selectedHome),
              10.horizontalSpace(),
              bottomNavigationItem('Projects',Images.application,context,state.selectedIndex,1,Images.selectedApplication),
              10.horizontalSpace(),
              bottomNavigationItem('Statement',Images.statement,context,state.selectedIndex,2,Images.selectedStatement),
              10.horizontalSpace(),
              bottomNavigationItem('Livestock',Images.liveStock,context,state.selectedIndex,3,Images.selectedLiveStock),
              10.horizontalSpace(),
              bottomNavigationItem('Community',Images.communityBottom,context,state.selectedIndex,4,Images.selectedCommunityBottom),

            ],
          ),
        ),
      ],
    );
  }
}