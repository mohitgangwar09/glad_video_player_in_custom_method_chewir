import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:glad/screen/custom_widget/custom_methods.dart';
import 'package:glad/utils/color_resources.dart';
import 'package:glad/utils/extension.dart';
import 'package:glad/utils/images.dart';
import 'package:glad/utils/styles.dart';

class CommunityWidget extends StatefulWidget {
  final String name;
  final String location;
  final String image;
  final String caption;
  final String video;
  final String timeAgo;
  final int likeCount;
  final int commentCount;
  final void Function()? onTap;

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
      required this.commentCount});

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
                                      width: screenWidth() * 0.5,
                                      child: Text(widget.location,
                                          style: figtreeMedium.copyWith(
                                              fontSize: 12, color: Colors.black)),
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
                            Text(
                              widget.caption,
                              maxLines: 3,
                              style: figtreeRegular.copyWith(
                                  fontSize: 16, color: Colors.black),
                              softWrap: true,
                            ),
                          ],
                        ),
                      ),
                      10.verticalSpace(),
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
                      ),
                      10.verticalSpace(),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: .0),
                        child: Padding(
                          padding: const EdgeInsets.only(right: .0, left: 20),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Row(
                                children: [
                                  SvgPicture.asset(Images.likeButton),
                                  4.horizontalSpace(),
                                  Text(
                                    'Like',
                                    style: figtreeRegular.copyWith(
                                        fontSize: 14,
                                        color: const Color(0xFF727272)),
                                    softWrap: true,
                                  ),
                                  widget.likeCount != 0 ? RichText(
                                      text: TextSpan(children: [
                                    TextSpan(
                                      text: ':',
                                      style: figtreeRegular.copyWith(
                                          fontSize: 14,
                                          color: const Color(0xFF727272)),
                                    ),
                                    TextSpan(
                                      text: ' ${widget.likeCount}',
                                      style: figtreeSemiBold.copyWith(
                                          fontSize: 14, color: Colors.black),
                                    ),
                                  ])) : const SizedBox.shrink(),
                                ],
                              ),
                              Row(
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
                              Row(
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
                              0.horizontalSpace(),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                )),
          ),
          // widget.showAll
          //     ? Positioned(
          //         right: 20,
          //         top: 20,
          //         child: 'Add as Friend'.textMedium(
          //             color: ColorResources.maroon,
          //             fontSize: 12,
          //             underLine: TextDecoration.underline))
          //     : const SizedBox.shrink(),
        ],
      ),
    );
  }
}
