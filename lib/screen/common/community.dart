import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:glad/cubit/dde_farmer_cubit/dde_farmer_cubit.dart';
import 'package:glad/cubit/landing_page_cubit/landing_page_cubit.dart';
import 'package:glad/screen/common/community_post_add.dart';
import 'package:glad/screen/common/community_post_detail.dart';
import 'package:glad/screen/custom_widget/community_widget.dart';
import 'package:glad/screen/custom_widget/custom_appbar.dart';
import 'package:glad/screen/custom_widget/custom_methods.dart';
import 'package:glad/screen/custom_widget/custom_textfield.dart';
import 'package:glad/screen/dde_screen/dashboard/dashboard_dde.dart';
import 'package:glad/screen/farmer_screen/dashboard/dashboard_farmer.dart';
import 'package:glad/utils/app_constants.dart';
import 'package:glad/utils/extension.dart';
import 'package:glad/utils/images.dart';
import 'package:glad/utils/styles.dart';

class CommunityPost extends StatelessWidget {
  const CommunityPost({super.key});

  @override
  Widget build(BuildContext context) {

    BlocProvider.of<DdeFarmerCubit>(context).selectRagRating('');

    return Scaffold(
      body: Stack(
        children: [
          landingBackground(),
          Column(
            children: [
              CustomAppBar(
                context: context,
                titleText1: 'Community',
                titleText1Style:
                    figtreeMedium.copyWith(fontSize: 20, color: Colors.black),
                centerTitle: true,
                leading: openDrawer(
                    onTap: () {
                      if(BlocProvider.of<LandingPageCubit>(context).sharedPreferences.getString(AppConstants.userType) == 'dde') {
                        ddeLandingKey.currentState?.openDrawer();
                      } else if(BlocProvider.of<LandingPageCubit>(context).sharedPreferences.getString(AppConstants.userType) == 'farmer') {
                        farmerLandingKey.currentState?.openDrawer();
                      }
                    },
                    child: SvgPicture.asset(Images.drawer)),
                // action: InkWell(
                //     onTap: () {}, child: SvgPicture.asset(Images.filter2)),
              ),
              listviewDetails(),
            ],
          ),
        ],
      ),
    );
  }

  Widget listviewDetails() {
    return Expanded(
      child: SingleChildScrollView(
        child: Column(
          children: [
            20.verticalSpace(),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0),
              child: Row(
                children: [
                  Image.asset(Images.sampleUser),
                  10.horizontalSpace(),
                  Expanded(
                      child: CustomTextField(
                    hint: 'Post something...',
                    readOnly: true,
                    hintOnly: true,
                    focusNode: FocusNode(),
                    onTap: () {
                      const CommunityPostAdd().navigate();
                    },
                  ))
                ],
              ),
            ),
            20.verticalSpace(),
            customList(
              list: [1, 2, 3, 4, 5, 6, 7],
              child: (index) => CommunityWidget(
                name: 'Begumanya Charles',
                location: 'Kampala, Uganda',
                image: '',
                caption:
                    'Lorem Ipsum has been the industry\'s standard dummy text ever since the 1500s, when an unknown printer took a galley.',
                video: '',
                timeAgo: '5 Hrs ago',
                showAll: true,
                onTap: () {
                  const CommunityPostDetail().navigate();
                },
              ),
            ),
            100.verticalSpace(),
          ],
        ),
      ),
    );
  }
}
