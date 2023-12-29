import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:glad/cubit/auth_cubit/auth_cubit.dart';
import 'package:glad/cubit/dashboard_cubit/dashboard_cubit.dart';
import 'package:glad/cubit/profile_cubit/profile_cubit.dart';
import 'package:glad/screen/common/notification.dart';
import 'package:glad/screen/custom_widget/custom_appbar.dart';
import 'package:glad/screen/farmer_screen/drawer_screen/add_testimonial.dart';
import 'package:glad/screen/farmer_screen/drawer_screen/earnings.dart';
import 'package:glad/screen/farmer_screen/drawer_screen/message_board.dart';
import 'package:glad/screen/farmer_screen/online_training.dart';
import 'package:glad/screen/guest_user/faq_screen.dart';
import 'package:glad/utils/app_constants.dart';
import 'package:glad/utils/sharedprefrence.dart';

import '../../../utils/color_resources.dart';
import '../../../utils/extension.dart';
import '../../../utils/images.dart';
import '../../../utils/styles.dart';
import '../../custom_widget/custom_methods.dart';

class FarmerDrawer extends StatelessWidget {
  const FarmerDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: const Color(0xFF6A0030),
      child: Stack(
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              menuItem(context),
              const SizedBox(
                height: 10,
              ),
              Expanded(
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      navigationItem(context),
                      helpLineItem(),
                    ],
                  ),
                ),
              )
            ],
          ),
          sideBackground(),
        ],
      ),
    );
  }

  Widget navigationItem(context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(30, 0, 0, 0),
      child: Column(
        children: [
          navigationBarItem(
              image: Images.myEarning,
              onTap: () {
                const Earnings().navigate();
              },
              text: 'My earnings'),
          30.verticalSpace(),
          navigationBarItem(
              image: Images.aboutus,
              onTap: () async{
                var roleId = await SharedPrefManager.getPreferenceString(AppConstants.userRoleId);

                MessageBoard(userRoleId:roleId.toString(),
                    userType: 'farmer_id',
                    roleType:'farmer').navigate();
              },
              text: 'Message board',
              visible: false),
          30.verticalSpace(),
          navigationBarItem(
              image: Images.drawerTraining, onTap: () {
                const OnlineTraining(isBottomAppBar: false,).navigate();
          }, text: 'Training'),
          30.verticalSpace(),
          navigationBarItem(
            image: Images.faq,
            onTap: () {
              pressBack();
              const FaqScreen().navigate();
            },
            text: "Faq's",
          ),
          30.verticalSpace(),
          navigationBarItem(
              image: Images.notification,
              onTap: () {
                BlocProvider.of<ProfileCubit>(context).getNotificationListApi(context);
                const CommonNotification().navigate();
              },
              text: 'Notification',
              visible: false),
          30.verticalSpace(),
          navigationBarItem(
            image: Images.aboutus,
            onTap: () {
              const AddTestimonial().navigate();
            },
            text: 'Add testimonial',
          ),
          30.verticalSpace(),
          navigationBarItem(
              image: Images.privacy, onTap: () {}, text: 'Privacy policy'),
          30.verticalSpace(),
          navigationBarItem(
            image: Images.drawerLogout,
            onTap: () {
              BlocProvider.of<AuthCubit>(context).clearSharedData();
              BlocProvider.of<AuthCubit>(context).emit(AuthCubitState.initial());
              BlocProvider.of<DashboardCubit>(context).selectedIndex(0);
            },
            text: 'Logout',
          ),
          30.verticalSpace(),
        ],
      ),
    );
  }

  Widget helpLineItem() {
    return Column(
      children: [
        Container(
          height: 110,
          decoration: const BoxDecoration(color: ColorResources.maroon1),
          child:
              Row(mainAxisAlignment: MainAxisAlignment.spaceAround, children: [
                phoneCall(256758711344),
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'GLAD Helpline Number',
                  style:
                      figtreeMedium.copyWith(fontSize: 12, color: Colors.white),
                ),
                5.verticalSpace(),
                Text(
                  '+234567890',
                  style: figtreeSemiBold.copyWith(
                      fontSize: 20, color: Colors.white),
                )
              ],
            ),
                whatsapp(256758711344),
          ]),
        ),
        20.verticalSpace(),
        socialMediaItem(),
        20.verticalSpace(),
      ],
    );
  }

  Widget socialMediaItem() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        SvgPicture.asset(Images.facebook),
        const SizedBox(
          width: 20,
        ),
        SvgPicture.asset(Images.twitter),
        const SizedBox(
          width: 20,
        ),
        SvgPicture.asset(Images.linkedin),
        const SizedBox(
          width: 20,
        ),
        SvgPicture.asset(Images.youtube),
      ],
    );
  }

  Widget menuItem(context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(left: 15.0),
          child: CustomAppBar(
            context: context,
            titleText1: '',
            leading: closeDrawer(
              child: SvgPicture.asset(
                Images.close,
                width: 30,
                height: 30,
              ),
            ),
            action: SvgPicture.asset(
              Images.onboardingnew,
              width: 30,
              height: 30,
            ),
          ),
        ),
        50.verticalSpace(),
        Padding(
          padding: const EdgeInsets.fromLTRB(20, 0, 0, 0),
          child: Text(
            'Menu',
            style: figtreeMedium.copyWith(fontSize: 28, color: Colors.white),
          ),
        ),
        20.verticalSpace(),
      ],
    );
  }

  Widget sideBackground() {
    return Positioned(
        right: 0,
        top: 135,
        // bottom:0,
        // left: 0,
        child: SvgPicture.asset(Images.drawerInside));
  }
}
