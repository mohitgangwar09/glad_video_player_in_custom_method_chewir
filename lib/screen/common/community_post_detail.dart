import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:glad/cubit/community_cubit/community_cubit.dart';
import 'package:glad/screen/common/community_comment_list.dart';
import 'package:glad/screen/common/community_like_list.dart';
import 'package:glad/screen/custom_widget/custom_methods.dart';
import 'package:glad/screen/dde_screen/preview_screen.dart';
import 'package:glad/utils/color_resources.dart';
import 'package:glad/utils/extension.dart';
import 'package:glad/utils/helper.dart';
import 'package:glad/utils/images.dart';
import 'package:glad/utils/styles.dart';
import 'package:glad/data/model/response_community_list_model.dart';
import 'package:like_button/like_button.dart';

class CommunityPostDetail extends StatelessWidget {
  const CommunityPostDetail({super.key, required this.data, required this.index});
  final Data data;
  final int index;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
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
                            imageUrl: data.user!.profilePic ?? '',
                            errorWidget: (_, __, ___) =>
                                Image.asset(Images.sampleUser),
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                      10.horizontalSpace(),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(data.user!.name ?? '',
                              style: figtreeMedium.copyWith(
                                  fontSize: 18, color: Colors.black)),
                          Row(
                            children: [
                              SizedBox(
                                width: screenWidth() * 0.3,
                                child: Text(data.user!.address != null
                                    ? data.user!.address!.address != null && data.user!.address!.subCounty != null
                                    ? data.user!.address!.subCounty! + data.user!.address!.address!
                                    : ''
                                    : '',
                                    style: figtreeRegular.copyWith(
                                        fontSize: 12, color: Colors.black),
                                    maxLines: 1,),
                              ),
                              10.horizontalSpace(),
                              Text('${getAge(DateTime.parse(data.createdAt ?? ''))} ago',
                                  style: figtreeMedium.copyWith(
                                      fontSize: 12, color: Colors.black)),
                            ],
                          ),
                        ],
                      ),
                    ],
                  ),
                  SvgPicture.asset(Images.chat),
                ],
              ),
            ),
          ),
          listviewDetails(data),
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
                      const CircleColor(start: Colors.blue, end: Colors.blueAccent),
                      bubblesColor: const BubblesColor(
                        dotPrimaryColor: Colors.blue,
                        dotSecondaryColor: Colors.blueAccent,
                      ),
                      isLiked: state.responseCommunityList!.data![index].isLiked > 0,
                      likeBuilder: (bool isLiked) {
                        return SvgPicture.asset(
                            Images.likeButton,
                            colorFilter: ColorFilter.mode(
                                isLiked ? const Color(0xFFFFB300) : Colors.grey,
                                BlendMode.srcIn)
                        );
                      },
                      likeCount: state.responseCommunityList!.data![index].communityLikesCount,
                      countBuilder: (int? count, bool isLiked, String text) {
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
                              CommunityLikeList(communityId: data.id.toString()).navigate();
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
                      onTap: (tap) async{
                        context.read<CommunityCubit>().addLikeApi(context, data.id.toString());
                        return tap;
                      },
                    ),
                    InkWell(
                      onTap: () {
                        CommunityCommentList(communityId: data.id.toString()).navigate();
                      },
                      child: Row(
                        children: [
                          SvgPicture.asset(Images.commentButton, color: Colors.white,),
                          4.horizontalSpace(),
                          Text(
                            'Comment',
                            style: figtreeRegular.copyWith(
                                fontSize: 14,
                                color: Colors.white),
                            softWrap: true,
                          ),
                          state.responseCommunityList!.data![index].communityCommentsCount != 0 ? RichText(
                              text: TextSpan(children: [
                                TextSpan(
                                  text: ':',
                                  style: figtreeRegular.copyWith(
                                      fontSize: 14,
                                      color: Colors.white),
                                ),
                                TextSpan(
                                  text: ' ${state.responseCommunityList!.data![index].communityCommentsCount}',
                                  style: figtreeSemiBold.copyWith(
                                      fontSize: 14, color: Colors.white),
                                ),
                              ])) : const SizedBox.shrink(),
                        ],
                      ),
                    ),
                    Row(
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

                  ],
                ),
              );
            }
          ),
        ],
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
                // Positioned(
                //   right: 10,
                //     top: 10,
                //     child: customButton(
                //   'Add as Friend',
                //   onTap: () {},
                //   width: 110,
                //   height: 30,
                //       style: figtreeMedium.copyWith(color: Colors.white, fontSize: 12)
                // ))
              ],
            ),
            20.verticalSpace(),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child:
                      data.remark.toString()
                          .textRegular(fontSize: 16, color: Colors.black),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
