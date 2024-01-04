import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:glad/cubit/community_cubit/community_cubit.dart';
import 'package:glad/screen/auth_screen/login_with_password.dart';
import 'package:glad/screen/common/community_comment_list.dart';
import 'package:glad/screen/common/community_like_list.dart';
import 'package:glad/screen/common/friend_chat.dart';
import 'package:glad/screen/custom_widget/custom_methods.dart';
import 'package:glad/screen/dde_screen/preview_screen.dart';
import 'package:glad/utils/app_constants.dart';
import 'package:glad/utils/color_resources.dart';
import 'package:glad/utils/extension.dart';
import 'package:glad/utils/helper.dart';
import 'package:glad/utils/images.dart';
import 'package:glad/utils/styles.dart';
import 'package:glad/data/model/response_community_list_model.dart';
import 'package:like_button/like_button.dart';

class CommunityPostDetail extends StatefulWidget {
  const CommunityPostDetail({super.key, required this.id});
  final String id;

  @override
  State<CommunityPostDetail> createState() => _CommunityPostDetailState();
}

class _CommunityPostDetailState extends State<CommunityPostDetail> {

  @override
  void initState() {
    BlocProvider.of<CommunityCubit>(context).communityDetailApi(context, widget.id);
    super.initState();
    print(widget.id);
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocBuilder<CommunityCubit, CommunityCubitState>(
        builder: (context, state) {
      if (state.status == CommunityStatus.submit) {
        return const Center(
            child: CircularProgressIndicator(
              color: ColorResources.maroon,
            ));
      } else if (state.responseCommunityDetailList == null) {
        return Center(
            child: Text("${state.responseCommunityDetailList} Api Error"));
      } else {
        return Column(
          children: [
            Padding(
              padding: EdgeInsets.only(top: getStatusBarHeight(context)),
              child: Container(
                height: AppBar().preferredSize.height,
                width: screenWidth(),
                padding: const EdgeInsets.symmetric(horizontal: 8),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        arrowBackButton(),
                        14.horizontalSpace(),
                        ClipRRect(
                          borderRadius: BorderRadius.circular(1000),
                          child: Container(
                            height: AppBar().preferredSize.height * 0.7,
                            width: AppBar().preferredSize.height * 0.7,
                            decoration:
                            const BoxDecoration(shape: BoxShape.circle),
                            child: CachedNetworkImage(
                              imageUrl: state.responseCommunityDetailList!.data![0].user!.profilePic ?? '',
                              errorWidget: (_, __, ___) =>
                                  Image.asset(Images.sampleUser),
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                        10.horizontalSpace(),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            Text(state.responseCommunityDetailList!.data![0].user!.name ?? '',
                                style: figtreeMedium.copyWith(
                                    fontSize: 18, color: Colors.black)),
                            Row(
                              children: [
                                SizedBox(
                                  width: screenWidth() * 0.4,
                                  child: Text(state.responseCommunityDetailList!.data![0].user!.address != null
                                      ? state.responseCommunityDetailList!.data![0].user!.address!.address ?? ''
                                      : '',
                                    style: figtreeRegular.copyWith(
                                        fontSize: 12, color: Colors.black),
                                    maxLines: 2,),
                                ),
                                10.horizontalSpace(),
                                Text(getPostAge(
                                    DateTime.parse(state.responseCommunityDetailList!.data![0].createdAt ?? '')),
                                    style: figtreeMedium.copyWith(
                                        fontSize: 12, color: Colors.black)),
                              ],
                            ),
                          ],
                        ),
                      ],
                    ),
                   if(context.read<CommunityCubit>().sharedPreferences.containsKey(AppConstants.userType))
                     if(state.responseCommunityDetailList!.data![0].isFriend != 0)
                        InkWell(
                            onTap: () {
                              CommunityFriendChatScreen(
                                userId: int.parse(context.read<CommunityCubit>().sharedPreferences.getString(AppConstants.userId).toString()),
                                friendId: state.responseCommunityDetailList!.data![0].user!.id,
                                friendName: state.responseCommunityDetailList!.data![0].user!.name ?? '',
                                friendImage: state.responseCommunityDetailList!.data![0].user!.profilePic ?? '',
                                friendAddress: state.responseCommunityDetailList!.data![0].user!.address != null ? state.responseCommunityDetailList!.data![0].user!.address!.address ??
                                    '' : '',
                              ).navigate();
                            },
                            child: SvgPicture.asset(Images.chat)),
                  ],
                ),
              ),
            ),
            listviewDetails(state.responseCommunityDetailList!.data![0]),
            BlocBuilder<CommunityCubit, CommunityCubitState>(
                builder: (context, state) {
                  return Container(
                    height: AppBar().preferredSize.height * 1.4,
                    width: screenWidth(),
                    color: ColorResources.maroon,
                    padding: const EdgeInsets.symmetric(horizontal: 40),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        // Row(
                        //   children: [
                        //     SvgPicture.asset(Images.likeButton, color: Colors.white,),
                        //     4.horizontalSpace(),
                        //     Text(
                        //       'Like',
                        //       style: figtreeRegular.copyWith(
                        //           fontSize: 14,
                        //           color: Colors.white),
                        //       softWrap: true,
                        //     ),
                        //   ],
                        // ),
                        LikeButton(
                          size: 20,
                          circleColor:
                          const CircleColor(
                              start: Colors.blue, end: Colors.blueAccent),
                          bubblesColor: const BubblesColor(
                            dotPrimaryColor: Colors.blue,
                            dotSecondaryColor: Colors.blueAccent,
                          ),
                          isLiked: (state.responseCommunityDetailList!.data![0].isLiked ?? 0) > 0,
                          likeBuilder: (bool isLiked) {
                            return SvgPicture.asset(
                                Images.likeButton,
                                colorFilter: ColorFilter.mode(
                                    isLiked ? const Color(0xFFFFB300) : Colors
                                        .white,
                                    BlendMode.srcIn)
                            );
                          },
                          likeCount: state.responseCommunityDetailList!.data![0].communityLikesCount,
                          countBuilder: (int? count, bool isLiked,
                              String text) {
                            Widget result;
                            if (count == 0) {
                              result = Text(
                                "Like",
                                style: figtreeRegular.copyWith(
                                    fontSize: 14,
                                    color: Colors.white),
                              );
                            } else {
                              result = InkWell(
                                onTap: () {
                                  if (!context
                                      .read<CommunityCubit>()
                                      .sharedPreferences
                                      .containsKey(AppConstants.userType)) {
                                    const LoginWithPassword().navigate();
                                  } else {
                                    CommunityLikeList(
                                        communityId: state.responseCommunityDetailList!.data![0].id.toString())
                                        .navigate();
                                  }
                                },
                                child: RichText(
                                    text: TextSpan(children: [
                                      TextSpan(
                                        text: 'Like:',
                                        style: figtreeRegular.copyWith(
                                            fontSize: 14,
                                            color: Colors.white),
                                      ),
                                      TextSpan(
                                        text: ' $text',
                                        style: figtreeSemiBold.copyWith(
                                            fontSize: 14, color: Colors.white),
                                      ),
                                    ])),
                              );
                            }
                            return result;
                          },
                          onTap: (tap) async {
                            if (!context
                                .read<CommunityCubit>()
                                .sharedPreferences
                                .containsKey(AppConstants.userType)) {
                              const LoginWithPassword().navigate();
                            } else {
                              context.read<CommunityCubit>().addLikeApi(
                                  context, state.responseCommunityDetailList!.data![0].id.toString());
                            }
                            return tap;
                          },
                        ),
                        InkWell(
                          onTap: () {
                            CommunityCommentList(
                                communityId: state.responseCommunityDetailList!.data![0].id.toString()).navigate();
                          },
                          child: Row(
                            children: [
                              SvgPicture.asset(
                                Images.commentButton, color: Colors.white,),
                              4.horizontalSpace(),
                              Text(
                                'Comment',
                                style: figtreeRegular.copyWith(
                                    fontSize: 14,
                                    color: Colors.white),
                                softWrap: true,
                              ),
                              state.responseCommunityDetailList!.data![0].communityCommentsCount != 0 ? RichText(
                                  text: TextSpan(children: [
                                    TextSpan(
                                      text: ':',
                                      style: figtreeRegular.copyWith(
                                          fontSize: 14,
                                          color: Colors.white),
                                    ),
                                    TextSpan(
                                      text: ' ${state.responseCommunityDetailList!.data![0].communityCommentsCount}',
                                      style: figtreeSemiBold.copyWith(
                                          fontSize: 14, color: Colors.white),
                                    ),
                                  ])) : const SizedBox.shrink(),
                            ],
                          ),
                        ),
                        InkWell(
                          onTap: () {
                            sharePost(state.responseCommunityDetailList!.data![0].communityDocumentFiles![0].originalUrl ?? '', state.responseCommunityDetailList!.data![0].remark ?? '', state.responseCommunityDetailList!.data![0].user!.name ?? '');
                          },
                          child: Row(
                            children: [
                              const Icon(
                                Icons.share_outlined,
                                color: Colors.white,
                                size: 19,
                              ),
                              4.horizontalSpace(),
                              Text(
                                'Share',
                                style: figtreeRegular.copyWith(
                                    fontSize: 14,
                                    color: Colors.white),
                                softWrap: true,
                              ),
                            ],
                          ),
                        ),

                      ],
                    ),
                  );
                }
            ),
          ],
        );
      }
        }
      ),
    );
  }

  Widget listviewDetails(Data data) {
    return Expanded(
      child: SingleChildScrollView(
        child: Column(
          children: [
            20.verticalSpace(),
            Stack(
              children: [
                InkWell(
                  onTap: () {
                    PreviewScreen(previewImage: data.communityDocumentFiles![0].originalUrl ?? '',).navigate();
                  },
                  child: CachedNetworkImage(
                    imageUrl: data.communityDocumentFiles![0].originalUrl ?? '',
                    errorWidget: (_, __, ___) =>
                        Image.asset(
                          Images.sampleVideo,
                          width: screenWidth(),
                          fit: BoxFit.cover,
                            height: 300
                        ),
                    width: screenWidth(),
                    fit: BoxFit.cover,
                      height: 300
                  ),
                ),
                if(BlocProvider.of<CommunityCubit>(context).sharedPreferences.containsKey(AppConstants.userType))
                  if(data.isFriend == 0)
                    Positioned(
                        right: 20,
                        top: 20,
                        child: customButton(
                            'Add as Friend',
                            onTap: () {
                              BlocProvider.of<CommunityCubit>(context).addFriendApi(context, widget.id.toString());
                            },
                            width: 110,
                            height: 30,
                            style: figtreeMedium.copyWith(color: Colors.white, fontSize: 12)
                        ))
              ],
            ),
            20.verticalSpace(),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child:
                        data.remark.toString()
                            .textRegular(fontSize: 16, color: Colors.black),
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
