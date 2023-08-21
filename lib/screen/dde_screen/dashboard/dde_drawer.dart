import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:glad/cubit/auth_cubit/auth_cubit.dart';
import 'package:glad/screen/custom_widget/custom_appbar.dart';

import '../../../utils/color_resources.dart';
import '../../../utils/extension.dart';
import '../../../utils/images.dart';
import '../../../utils/styles.dart';
import '../../auth_screen/login_with_password.dart';
import '../../custom_widget/custom_methods.dart';

class DdeDrawer extends StatelessWidget {
  const DdeDrawer({super.key});

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
              25.verticalSpace(),
              navigationItem(context),
            ],
          ),

          sideBackground(),

          helpLineItem(),

        ],
      ),
    );
  }


  Widget navigationItem(context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(30, 0, 0, 0),
      child: Column(
        children: [
          navigationBarItem(image: Images.myEarning, onTap: (){},text: 'My earnings'),
          20.verticalSpace(),
          navigationBarItem(
              image: Images.aboutus,
              onTap: () {},
              text: 'Message board',
              visible: false
          ),
          const SizedBox(
            height: 30,
          ),
          navigationBarItem(
              image: Images.news, onTap: () {}, text: 'News & Events'),
          const SizedBox(
            height: 30,
          ),
          navigationBarItem(image: Images.notification, onTap: () {}, text: 'Notification',visible: false),
          const SizedBox(
            height: 30,
          ),
          navigationBarItem(
            image: Images.faq,
            onTap: () {},
            text: "Faq's",
          ),
          const SizedBox(
            height: 30,
          ),
          navigationBarItem(
              image: Images.drawerLogout, onTap: () {
            BlocProvider.of<AuthCubit>(context).clearSharedData();
            BlocProvider.of<AuthCubit>(context).emit(AuthCubitState.initial());
          }, text: 'Logout'),

        ],
      ),
    );
  }

  Widget helpLineItem() {
    return Positioned(
      bottom: 0,
      left: 0,
      right: 0,
      child: Column(
        children: [
          Container(
            height: 110,
            decoration: const BoxDecoration(color: ColorResources.maroon1),
            child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  SvgPicture.asset(
                    Images.call,
                    width: 45,
                    height: 45,
                  ),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'GLAD Helpline Number',
                        style: figtreeMedium.copyWith(
                            fontSize: 12, color: Colors.white),
                      ),
                      5.verticalSpace(),
                      Text(
                        '+234567890',
                        style: figtreeSemiBold.copyWith(
                            fontSize: 20, color: Colors.white),
                      )
                    ],
                  ),
                  SvgPicture.asset(
                    Images.whatsapp,
                    width: 40,
                    height: 40,
                  ),
                ]),
          ),
          const SizedBox(
            height: 30,
          ),
          socialMediaItem(),
          const SizedBox(
            height: 30,
          )
        ],
      ),
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

  Widget menuItem(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(left: 15.0),
          child: CustomAppBar(context: context, titleText1: '', leading: closeDrawer(
            child: SvgPicture.asset(
              Images.close,
              width: 30,
              height: 30,
            ),
          ), action: SvgPicture.asset(
            Images.onboardingnew,
            width: 30,
            height: 30,
          ),),
        ),
        50.verticalSpace(),
        Padding(
          padding: const EdgeInsets.fromLTRB(20, 0, 0, 0),
          child: Text(
            'Menu',
            style: figtreeMedium.copyWith(fontSize: 28, color: Colors.white),
          ),
        ),
        40.verticalSpace(),
        InkWell(
          onTap: () {
            const LoginWithPassword().navigate(isRemove: true);
          },
          child: Padding(
            padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [

              ],
            ),
          ),
        ),
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
