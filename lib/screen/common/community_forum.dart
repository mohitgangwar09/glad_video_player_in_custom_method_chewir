import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:glad/screen/custom_widget/show_all_button.dart';
import 'package:glad/utils/color_resources.dart';
import 'package:glad/utils/extension.dart';
import 'package:glad/utils/images.dart';
import 'package:glad/utils/styles.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class CommunityForum extends StatefulWidget {
  const CommunityForum(
      {super.key,
      required this.name,
      required this.location,
      required this.image,
      required this.caption,
      required this.video,
      required this.timeAgo});
  final String name;
  final String location;
  final String image;
  final String caption;
  final String video;
  final String timeAgo;

  @override
  State<CommunityForum> createState() => _CommunityForumState();
}

class _CommunityForumState extends State<CommunityForum> {
  int activeIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.fromLTRB(20, 10, 20, 2),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text('Community Forum',
                  style: figtreeMedium.copyWith(
                      fontSize: 18, color: Colors.black)),
              ShowAllButton(onTap: () {})
            ],
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(top: 20),
          child: CarouselSlider(
              items: ['', '', '']
                  .map<Widget>(
                    (e) => Padding(
                      padding: const EdgeInsets.only(right: 10),
                      child: Container(
                        decoration: BoxDecoration(
                            border: Border.all(color: const Color(0xFFDCDCDC)),
                            borderRadius: BorderRadius.circular(20),
                        color: Colors.white),
                        padding: const EdgeInsets.all(12),
                        child: Column(
                          children: [
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Image.asset(Images.sampleUser),
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
                                        Text(widget.location,
                                            style: figtreeMedium.copyWith(
                                                fontSize: 12,
                                                color: Colors.black)),
                                        10.horizontalSpace(),
                                        Text(widget.timeAgo,
                                            style: figtreeMedium.copyWith(
                                                fontSize: 12,
                                                color: Colors.black)),
                                      ],
                                    ),
                                  ],
                                ),
                              ],
                            ),
                            10.verticalSpace(),
                            Text(
                              widget.caption,
                              style: figtreeRegular.copyWith(
                                  fontSize: 16, color: Colors.black),
                              softWrap: true,
                            ),
                            10.verticalSpace(),
                            Image.asset(Images.sampleVideo),
                            10.verticalSpace(),
                            Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 12.0),
                              child: Row(
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
                                    ],
                                  ),
                                  15.horizontalSpace(),
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
                                    ],
                                  ),
                                  15.horizontalSpace(),
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
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  )
                  .toList(),
              options: CarouselOptions(
                autoPlay: true,
                enableInfiniteScroll: false,
                viewportFraction: 0.9,
                height: screenHeight() * 0.58,
                onPageChanged: (index, reason) {
                  setState(() {
                    activeIndex = index;
                  });
                },
              )),
        ),
        Center(
          child: Padding(
            padding: const EdgeInsets.all(5),
            child: AnimatedSmoothIndicator(
              activeIndex: activeIndex,
              count: 3,
              effect: const WormEffect(
                  activeDotColor: ColorResources.maroon,
                  dotHeight: 7,
                  dotWidth: 7,
                  dotColor: ColorResources.grey),
            ),
          ),
        ),
      ],
    );
  }
}
