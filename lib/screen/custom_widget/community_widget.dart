import 'dart:io';
import 'dart:math';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:chewie/chewie.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:glad/cubit/community_cubit/community_cubit.dart';
import 'package:glad/screen/auth_screen/register_popup.dart';
import 'package:glad/screen/common/community_comment_list.dart';
import 'package:glad/screen/common/community_like_list.dart';
import 'package:glad/screen/custom_widget/custom_methods.dart';
import 'package:glad/utils/app_constants.dart';
import 'package:glad/utils/color_resources.dart';
import 'package:glad/utils/extension.dart';
import 'package:glad/utils/helper.dart';
import 'package:glad/utils/images.dart';
import 'package:glad/utils/styles.dart';
import 'package:like_button/like_button.dart';
import 'package:path_provider/path_provider.dart';
import 'package:video_player/video_player.dart';
import 'package:video_thumbnail/video_thumbnail.dart';
import 'package:visibility_detector/visibility_detector.dart';

class CommunityWidget extends StatefulWidget {
  final String name;
  final String location;
  final String image;
  final String caption;
  final String video;
  final String timeAgo;
  final int likeCount;
  final int commentCount;
  final int isLiked;
  final int id;
  final void Function()? onTap;
  final int index;
  final int isFriend;
  final bool fromHome;
  final int userId;

  const CommunityWidget(
      {super.key,
      required this.name,
      required this.location,
      required this.image,
      required this.caption,
      required this.video,
      required this.timeAgo,
      this.onTap,
      required this.likeCount,
      required this.commentCount,
      required this.isLiked,
      required this.id, required this.index, required this.fromHome, required this.isFriend, required this.userId});

  @override
  State<CommunityWidget> createState() => _CommunityWidgetState();
}

class _CommunityWidgetState extends State<CommunityWidget> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(
          right: 12.0, left: 12, bottom: 20),
      child: Stack(
        children: [
          InkWell(
            onTap: widget.onTap,
            child: customShadowContainer(
                backColor: Colors.grey.withOpacity(0.4),
                child: Padding(
                  padding: const EdgeInsets.only(top: 22.0, bottom: 0),
                  child: Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(left: 17.0, right: 17),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            ClipRRect(
                              borderRadius: BorderRadius.circular(1000),
                              child: Container(
                                height: AppBar().preferredSize.height * 0.7,
                                width: AppBar().preferredSize.height * 0.7,
                                decoration:
                                const BoxDecoration(shape: BoxShape.circle),
                                child: CachedNetworkImage(
                                  imageUrl: widget.image,
                                  errorWidget: (_, __, ___) =>
                                      Image.asset(Images.sampleUser),
                                  fit: BoxFit.cover,
                                ),
                              ),
                            ),
                            15.horizontalSpace(),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(widget.name,
                                    style: figtreeMedium.copyWith(
                                        fontSize: 18, color: Colors.black)),
                                4.verticalSpace(),
                                Row(
                                  children: [
                                    SizedBox(
                                      width: screenWidth() * 0.37,
                                      child: Text(widget.location,
                                          style: figtreeMedium.copyWith(
                                              fontSize: 12, color: Colors.black),
                                      maxLines: 1,),
                                    ),
                                    10.horizontalSpace(),
                                    Text(widget.timeAgo,
                                        style: figtreeMedium.copyWith(
                                            fontSize: 12, color: Colors.black)),
                                  ],
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                      10.verticalSpace(),
                      Padding(
                        padding: const EdgeInsets.only(left: 17.0, right: 17),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Expanded(
                              child: Text(
                                widget.caption,
                                maxLines: 2,
                                style: figtreeRegular.copyWith(
                                    fontSize: 16, color: Colors.black),
                                softWrap: true,
                              ),
                            ),
                          ],
                        ),
                      ),
                      10.verticalSpace(),
                      if(!widget.video.endsWith('.mp4'))
                        Container(
                        margin: 3.marginAll(),
                        height: 244,
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(10),
                          child: CachedNetworkImage(
                            imageUrl: widget.video,
                            errorWidget: (_, __, ___) =>
                                Image.asset(
                                  Images.sampleVideo,
                                  width: screenWidth(),
                                  fit: BoxFit.cover,
                                ),
                            width: screenWidth(),
                            fit: BoxFit.cover,
                          ),
                        ),
                      )
                      else
                        Container(
                          margin: 3.marginAll(),
                          height: widget.fromHome ? 244 : null,
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(10),
                            child: CommunityVideoPlayer(url: widget.video),
                          ),
                        ),
                      10.verticalSpace(),
                      BlocBuilder<CommunityCubit, CommunityCubitState>(
                        builder: (context, state) {
                          return Padding(
                            padding: const EdgeInsets.symmetric(horizontal: .0),
                            child: Padding(
                              padding: const EdgeInsets.only(right: .0, left: 20),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  LikeButton(
                                    size: 18,
                                    circleColor:
                                    const CircleColor(start: Colors.blue, end: Colors.blueAccent),
                                    bubblesColor: const BubblesColor(
                                      dotPrimaryColor: Colors.blue,
                                      dotSecondaryColor: Colors.blueAccent,
                                    ),
                                    isLiked: widget.isLiked > 0,
                                    likeBuilder: (bool isLiked) {
                                      return SvgPicture.asset(
                                          Images.likeButton,
                                          colorFilter: ColorFilter.mode(
                                              isLiked ? const Color(0xFFFFB300) : Colors.grey,
                                              BlendMode.srcIn)
                                      );
                                    },
                                    likeCount: widget.likeCount,
                                    countBuilder: (int? count, bool isLiked, String text) {
                                      Widget result;
                                      if (count == 0) {
                                        result = Text(
                                          "Like",
                                          style: figtreeRegular.copyWith(
                                              fontSize: 14,
                                              color: const Color(0xFF727272)),
                                        );
                                      } else {
                                        result = InkWell(
                                          onTap: () {
                                            if(!context.read<CommunityCubit>().sharedPreferences.containsKey(AppConstants.userType)) {
                                              const RegisterPopUp().navigate();
                                            } else {
                                              CommunityLikeList(
                                                  communityId: widget.id
                                                      .toString()).navigate();
                                            }
                                          },
                                          child: RichText(
                                              text: TextSpan(children: [
                                                TextSpan(
                                                  text: 'Like:',
                                                  style: figtreeRegular.copyWith(
                                                      fontSize: 14,
                                                      color: const Color(0xFF727272)),
                                                ),
                                                TextSpan(
                                                  text: ' $text',
                                                  style: figtreeSemiBold.copyWith(
                                                      fontSize: 14, color: Colors.black),
                                                ),
                                              ])),
                                        );
                                      }
                                      return result;
                                    },
                                    onTap: (tap) async{
                                      if(!context.read<CommunityCubit>().sharedPreferences.containsKey(AppConstants.userType)) {
                                        const RegisterPopUp().navigate();
                                      } else {
                                        context.read<CommunityCubit>().addLikeApi(context, widget.id.toString());
                                      }
                                      return tap;
                                    },
                                  ),
                                  InkWell(
                                    onTap: () {
                                      CommunityCommentList(communityId: widget.id.toString()).navigate();
                                    },
                                    child: Row(
                                      children: [
                                        SvgPicture.asset(Images.commentButton),
                                        4.horizontalSpace(),
                                        Text(
                                          'Comment',
                                          style: figtreeRegular.copyWith(
                                              fontSize: 14,
                                              color: const Color(0xFF727272)),
                                          softWrap: true,
                                        ),
                                        widget.commentCount != 0 ? RichText(
                                            text: TextSpan(children: [
                                              TextSpan(
                                                text: ':',
                                                style: figtreeRegular.copyWith(
                                                    fontSize: 14,
                                                    color: const Color(0xFF727272)),
                                              ),
                                              TextSpan(
                                                text: ' ${widget.commentCount}',
                                                style: figtreeSemiBold.copyWith(
                                                    fontSize: 14, color: Colors.black),
                                              ),
                                            ])) : const SizedBox.shrink(),
                                      ],
                                    ),
                                  ),
                                  InkWell(
                                    onTap: () async {
                                      sharePost(widget.video, widget.caption, widget.name);
                                    },
                                    child: Row(
                                      children: [
                                        const Icon(
                                          Icons.share_outlined,
                                          color: Color(0xFF727272),
                                          size: 19,
                                        ),
                                        4.horizontalSpace(),
                                        Text(
                                          'Share',
                                          style: figtreeRegular.copyWith(
                                              fontSize: 14,
                                              color: const Color(0xFF727272)),
                                          softWrap: true,
                                        ),
                                      ],
                                    ),
                                  ),
                                  0.horizontalSpace(),
                                ],
                              ),
                            ),
                          );
                        }
                      ),
                      if(!widget.fromHome)
                        10.verticalSpace(),
                    ],
                  ),
                )),
          ),
          if(BlocProvider.of<CommunityCubit>(context).sharedPreferences.containsKey(AppConstants.userType))
            if(BlocProvider.of<CommunityCubit>(context).sharedPreferences.getString(AppConstants.userId).toString() != widget.userId.toString())
            if(widget.isFriend == 0)
              Positioned(
                  right: 15,
                  top: 15,
                  child: InkWell(
                    onTap: () {
                      BlocProvider.of<CommunityCubit>(context).addFriendApi(context, widget.id.toString());
                    },
                    child: Padding(
                      padding: const EdgeInsets.all(5),
                      child: 'Add as Friend'.textMedium(
                          color: ColorResources.maroon,
                          fontSize: 12,
                          underLine: TextDecoration.underline),
                    ),
                  ))
          else
              Positioned(
                right: 20,
                top: 20,
                child: 'Friend'.textMedium(
                    color: const Color(0xFF727272),
                    fontSize: 12)),
        ],
      ),
    );
  }
}