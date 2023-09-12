import 'dart:async';

import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:glad/screen/custom_widget/community_widget.dart';
import 'package:glad/screen/custom_widget/custom_methods.dart';
import 'package:glad/screen/custom_widget/livestock_details.dart';
import 'package:glad/screen/custom_widget/show_all_button.dart';
import 'package:glad/utils/color_resources.dart';
import 'package:glad/utils/extension.dart';
import 'package:glad/utils/helper.dart';
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
      required this.timeAgo,
        required this.onTapShowAll});
  final String name;
  final String location;
  final String image;
  final String caption;
  final String video;
  final String timeAgo;
  final Function() onTapShowAll;

  @override
  State<CommunityForum> createState() => _CommunityForumState();
}

class _CommunityForumState extends State<CommunityForum> {
  int activeIndex = 0;
  late ScrollController controller;

  late Timer _timer;
  @override
  void initState() {
    super.initState();
    controller = PageController();
    _timer = Timer.periodic(const Duration(seconds: 5), (Timer timer) {
      if (activeIndex < 2) {
        activeIndex++;
      } else {
        activeIndex = 0;
      }
      /*controller.animateTo(
        // activeIndex,
        duration: const Duration(milliseconds: 350),
        curve: Curves.easeIn,
      );*/
    });
  }

  @override
  void dispose() {
    super.dispose();
    controller.dispose();
    _timer.cancel();
  }

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
              ShowAllButton(onTap: widget.onTapShowAll)
            ],
          ),
        ),
        10.verticalSpace(),
        CarouselSlider(
            items: ['', '', '']
                .map<Widget>((e) => CommunityWidget(
                    name: widget.name,
                    location: widget.location,
                    image: widget.image,
                    caption: widget.caption,
                    video: widget.video,
                    timeAgo: widget.timeAgo,
                    showAll: false))
                .toList(),
            options: CarouselOptions(
              autoPlay: true,
              clipBehavior: Clip.none,
              enableInfiniteScroll: false,
              viewportFraction: 1,
              height: deviceSize(),
              onPageChanged: (index, reason) {
                setState(() {
                  activeIndex = index;
                });
              },
            )),
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
