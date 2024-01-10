import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:glad/cubit/community_cubit/community_cubit.dart';
import 'package:glad/cubit/dde_farmer_cubit/dde_farmer_cubit.dart';
import 'package:glad/cubit/landing_page_cubit/landing_page_cubit.dart';
import 'package:glad/cubit/profile_cubit/profile_cubit.dart';
import 'package:glad/screen/auth_screen/login_with_password.dart';
import 'package:glad/screen/auth_screen/register_popup.dart';
import 'package:glad/screen/common/community_friend_list.dart';
import 'package:glad/screen/common/community_post_add.dart';
import 'package:glad/screen/common/community_post_detail.dart';
import 'package:glad/screen/custom_widget/community_widget.dart';
import 'package:glad/screen/custom_widget/custom_appbar.dart';
import 'package:glad/screen/custom_widget/custom_methods.dart';
import 'package:glad/screen/custom_widget/custom_textfield.dart';
import 'package:glad/screen/dde_screen/dashboard/dashboard_dde.dart';
import 'package:glad/screen/farmer_screen/dashboard/dashboard_farmer.dart';
import 'package:glad/screen/guest_user/dashboard/dashboard_guest.dart';
import 'package:glad/screen/supplier_screen/dashboard/dashboard_supplier.dart';
import 'package:glad/utils/app_constants.dart';
import 'package:glad/utils/color_resources.dart';
import 'package:glad/utils/extension.dart';
import 'package:glad/utils/helper.dart';
import 'package:glad/utils/images.dart';
import 'package:glad/utils/styles.dart';

class CommunityPost extends StatefulWidget {
  const CommunityPost({super.key});

  @override
  State<CommunityPost> createState() => _CommunityPostState();
}

class _CommunityPostState extends State<CommunityPost> {

  @override
  void initState() {
    BlocProvider.of<CommunityCubit>(context).communityListApi(context);
    super.initState();
  }
  @override
  Widget build(BuildContext context) {

    BlocProvider.of<DdeFarmerCubit>(context).selectRagRating('');

    return Scaffold(
      body: BlocBuilder<CommunityCubit, CommunityCubitState>(
        builder: (context, state) {
      if (state.status == CommunityStatus.submit) {
        return const Center(
            child: CircularProgressIndicator(
              color: ColorResources.maroon,
            ));
      } else if (state.responseCommunityList == null) {
        return Center(
            child: Text("${state.responseCommunityList} Api Error"));
      } else {
        return Stack(
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
                  action: context.read<CommunityCubit>().sharedPreferences.containsKey(AppConstants.userType) ? InkWell(
                    onTap: () {
                      const FriendList().navigate();
                    },
                      child: SvgPicture.asset(Images.friendlist)) : null,
                  leading: BlocProvider
                      .of<ProfileCubit>(context)
                      .sharedPreferences
                      .getString(AppConstants.userType) == 'mcc' ?
                  const SizedBox.shrink()
                      : openDrawer(
                      onTap: () {
                        if (BlocProvider
                            .of<LandingPageCubit>(context)
                            .sharedPreferences
                            .getString(AppConstants.userType) == 'dde') {
                          ddeLandingKey.currentState?.openDrawer();
                        } else if (BlocProvider
                            .of<LandingPageCubit>(context)
                            .sharedPreferences
                            .getString(AppConstants.userType) == 'farmer') {
                          farmerLandingKey.currentState?.openDrawer();
                        } else if (BlocProvider
                            .of<LandingPageCubit>(context)
                            .sharedPreferences
                            .getString(AppConstants.userType) == 'supplier') {
                          supplierLandingKey.currentState?.openDrawer();
                        } else if (!BlocProvider
                            .of<LandingPageCubit>(context)
                            .sharedPreferences
                            .containsKey(AppConstants.userType)) {
                          landingKey.currentState?.openDrawer();
                        }
                      },
                      child: SvgPicture.asset(Images.drawer)),
                  // action: InkWell(
                  //     onTap: () {}, child: SvgPicture.asset(Images.filter2)),
                ),
                listviewDetails(state),
              ],
            ),
          ],
        );
      }
        }
      ),
    );
  }

  Widget listviewDetails(CommunityCubitState state) {
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
                      if(context.read<CommunityCubit>().sharedPreferences.containsKey(AppConstants.userType)) {
                        const CommunityPostAdd().navigate();
                      } else {
                        const RegisterPopUp().navigate();
                      }
                    },
                  ))
                ],
              ),
            ),
            20.verticalSpace(),
            customList(
              list: state.responseCommunityList!.data ?? [],
              child: (index) => CommunityWidget(
                name: state.responseCommunityList!.data![index].user!.name ?? '',
                location: state.responseCommunityList!.data![index].user!.address != null
                    ? state.responseCommunityList!.data![index].user!.address!.address ?? ''
                    : '',
                image: state.responseCommunityList!.data![index].user!.profilePic ?? '',
                caption: state.responseCommunityList!.data![index].remark ?? '',
                video: state.responseCommunityList!.data![index].communityDocumentFiles![0].originalUrl ?? '',
                timeAgo: getPostAge(DateTime.parse(state.responseCommunityList!.data![index].createdAt ?? '')),
                likeCount: state.responseCommunityList!.data![index].communityLikesCount ?? 0,
                commentCount: state.responseCommunityList!.data![index].communityCommentsCount ?? 0,
                onTap: () {
                  CommunityPostDetail(id: state.responseCommunityList!.data![index].id.toString()).navigate();
                },
                id: state.responseCommunityList!.data![index].id ?? 0,
                isLiked: state.responseCommunityList!.data![index].isLiked ?? 0,
                index: index,
                fromHome: false,
                isFriend: state.responseCommunityList!.data![index].isFriend ?? 0,
              ),
            ),
            100.verticalSpace(),
          ],
        ),
      ),
    );
  }
}
