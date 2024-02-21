
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:glad/cubit/auth_cubit/auth_cubit.dart';
import 'package:glad/cubit/landing_page_cubit/landing_page_cubit.dart';
import 'package:glad/screen/auth_screen/login_with_password.dart';
import 'package:glad/screen/common/dde_in_area.dart';
import 'package:glad/screen/custom_widget/custom_methods.dart';
import 'package:glad/screen/custom_widget/custom_textfield.dart';
import 'package:glad/utils/color_resources.dart';
import 'package:glad/utils/extension.dart';
import 'package:glad/utils/images.dart';
import 'package:glad/utils/styles.dart';

class RegisterPopUp extends StatefulWidget {
  const RegisterPopUp({Key? key}) : super(key: key);

  @override
  State<RegisterPopUp> createState() => _RegisterPopUpState();
}

class _RegisterPopUpState extends State<RegisterPopUp> {


  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      if(BlocProvider.of<LandingPageCubit>(context).state.guestDashboardResponse == null) {
        BlocProvider.of<LandingPageCubit>(context).getGuestDashboard(context);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      bottom: true,
      top: false,
      maintainBottomViewPadding: false,
      child: Scaffold(
        body: BlocBuilder<LandingPageCubit, LandingPageState>(
        builder: (context, state) {
      if (state.status == LandingPageStatus.loading) {
        return const Center(
            child: CircularProgressIndicator(
              color: ColorResources.maroon,
            ));
      } else if (state.guestDashboardResponse == null) {
        return Center(child: Text("${state.guestDashboardResponse} Api Error"));
      } else {
        return Stack(children: [
          Positioned(left: 80, child: SvgPicture.asset(Images.addRemark1)),
          Positioned(
              bottom: 0, right: 0, child: SvgPicture.asset(Images.otpBack1)),
          Padding(
            padding: const EdgeInsets.only(top: 40.0),
            child: Column(
              children: [
                Expanded(
                  child: SingleChildScrollView(
                    child: Padding(
                      padding: const EdgeInsets.fromLTRB(25, 20, 25, 0),
                      child: Column(
                        children: [
                          remarkOtp(),
                          20.verticalSpace(),
                          // istClickOnSendOtp == ""?const SizedBox.shrink():
                          mainView(state),
                          // pinFieldController(context),
                        ],
                      ),
                    ),
                  ),
                )
              ],
            ),
          ),
          Positioned(top: 40, left: 10, child: arrowBackButton()),
        ],);
      }
          }
        ),
      ),
    );
  }

  Widget remarkOtp() {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            SvgPicture.asset(Images.addRemark),
          ],
        ),

      ],
    );
  }

  mainView(LandingPageState state) {
    return Column(
      children: [
        Padding(padding: const EdgeInsets.symmetric(horizontal: 60), child: 'You need to register before buying.'.textRegular(fontSize: 20, textAlign: TextAlign.center)),
        30.verticalSpace(),
        Padding(padding: const EdgeInsets.symmetric(horizontal: 60), child: 'New User?'.textRegular(fontSize: 16, textAlign: TextAlign.center)),
        10.verticalSpace(),

        if(state.guestDashboardResponse!.data!.dairyDevelopmentExecutive != null)
          DDEInArea(
            name: state.guestDashboardResponse!.data!.dairyDevelopmentExecutive!.name ?? '',
            phone: state.guestDashboardResponse!.data!.dairyDevelopmentExecutive!.phone ?? '',
            image: state.guestDashboardResponse!.data!.dairyDevelopmentExecutive!.photo ?? '',
            state: state,
          ),
        Padding(padding: const EdgeInsets.symmetric(horizontal: 30), child: 'Our expert will visit your farm to collect your details and assist in registering you in our application'.textRegular(fontSize: 12, textAlign: TextAlign.center)),

        30.verticalSpace(),
        Padding(padding: const EdgeInsets.symmetric(horizontal: 60), child: 'OR'.textRegular(fontSize: 16, textAlign: TextAlign.center)),


        30.verticalSpace(),
        Padding(padding: const EdgeInsets.symmetric(horizontal: 60), child: 'Already have and account?'.textRegular(fontSize: 16, textAlign: TextAlign.center)),

        10.verticalSpace(),
        Container(
            margin: 20.marginAll(),
            height: 55,
            width: screenWidth() * 0.5,
            child: customButton("Login",
                fontColor: 0xffffffff,
                onTap: () async{
                  const LoginWithPassword().navigate();
                }))
      ],
    );
  }
}