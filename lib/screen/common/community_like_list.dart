import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:glad/cubit/community_cubit/community_cubit.dart';
import 'package:glad/screen/custom_widget/custom_appbar.dart';
import 'package:glad/screen/custom_widget/custom_methods.dart';
import 'package:glad/screen/dde_screen/preview_screen.dart';
import 'package:glad/utils/app_constants.dart';
import 'package:glad/utils/color_resources.dart';
import 'package:glad/utils/extension.dart';
import 'package:glad/utils/helper.dart';
import 'package:glad/utils/images.dart';
import 'package:glad/utils/styles.dart';
import 'package:intl/intl.dart';

class CommunityLikeList extends StatefulWidget {
  const CommunityLikeList({super.key, required this.communityId});
  final String communityId;

  @override
  State<CommunityLikeList> createState() => _CommunityLikeListState();
}

class _CommunityLikeListState extends State<CommunityLikeList> {

  @override
  void initState() {
    super.initState();

    SchedulerBinding.instance.addPostFrameCallback((_) {
      BlocProvider.of<CommunityCubit>(context).likeListApi(context, widget.communityId);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(body: BlocBuilder<CommunityCubit, CommunityCubitState>(
        builder: (context, state) {
          if (state.status == CommunityStatus.submit) {
            return const Center(
                child: CircularProgressIndicator(
                  color: ColorResources.maroon,
                ));
          } else if (state.responseCommunityLikeList == null) {
            return Center(child: Text("${state.responseCommunityLikeList} Api Error"));
          } else {
            return Container(
              color: Colors.white,
              child: Stack(
                children: [
                  landingBackground(),
                  Column(
                    children: [
                      CustomAppBar(
                        context: context,
                        titleText1: 'Liked by',
                        centerTitle: true,
                        leading: arrowBackButton(),
                      ),
                      Expanded(
                          child: SingleChildScrollView(
                            child: Column(
                              children: [
                                20.verticalSpace(),
                                customList(
                                  list: state.responseCommunityLikeList!.data ?? [],
                                  child: (index) => Padding(
                                    padding: const EdgeInsets.only(bottom: 20),
                                    child: Padding(
                                      padding: const EdgeInsets.symmetric(horizontal: 20),
                                      child: Container(
                                        width: screenWidth(),
                                        padding: const EdgeInsets.all(20),
                                        decoration: BoxDecoration(
                                            color: Colors.white,
                                            borderRadius: BorderRadius.circular(20)),
                                        child: Row(
                                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                          children: [
                                            Row(
                                              children: [
                                                ClipRRect(
                                                  borderRadius: BorderRadius.circular(1000),
                                                  child: Container(
                                                    height: AppBar().preferredSize.height * 0.7,
                                                    width: AppBar().preferredSize.height * 0.7,
                                                    decoration:
                                                    const BoxDecoration(shape: BoxShape.circle),
                                                    child: CachedNetworkImage(
                                                      imageUrl: state.responseCommunityLikeList!.data![index].user!.profilePic ?? '',
                                                      errorWidget: (_, __, ___) =>
                                                          Image.asset(Images.sampleUser),
                                                      fit: BoxFit.cover,
                                                    ),
                                                  ),
                                                ),
                                                10.horizontalSpace(),
                                                Column(
                                                  crossAxisAlignment: CrossAxisAlignment.start,
                                                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                                  children: [
                                                    Text(state.responseCommunityLikeList!.data![index].user!.name ?? '',
                                                        style: figtreeMedium.copyWith(
                                                            fontSize: 16, color: Colors.black)),

                                                    SizedBox(
                                                      width: screenWidth() * 0.5,
                                                      child: Text(state.responseCommunityLikeList!.data![index].user!.address!.address ?? '',
                                                          style: figtreeRegular.copyWith(
                                                              fontSize: 12, color: Color(0xFF727272))),
                                                    ),

                                                    // Column(
                                                    //   crossAxisAlignment: CrossAxisAlignment.start,
                                                    //   children: [
                                                    //     10.verticalSpace(),
                                                    //     Text(
                                                    //         state.responseCommunityCommentList!.data![index].comment!,
                                                    //         style: figtreeMedium.copyWith(
                                                    //             fontSize: 16, color: Colors.black)),
                                                    //     10.verticalSpace(),
                                                    //   ],
                                                    // ),
                                                    // DateFormat('dd MMM, yyyy hh:mm a').format(DateTime.parse(state.responseCommunityCommentList!.data![index].createdAt.toString())).textRegular(
                                                    //     color: ColorResources.fieldGrey, fontSize: 14)
                                                  ],
                                                ),
                                              ],
                                            ),
                                            SvgPicture.asset(Images.thumbsUp)
                                          ],
                                        ),
                                      ),
                                    ),
                                  ),)
                              ],
                            ),
                          )),
                    ],
                  ),
                ],
              ),
            );
          }
        }),);
  }
}
