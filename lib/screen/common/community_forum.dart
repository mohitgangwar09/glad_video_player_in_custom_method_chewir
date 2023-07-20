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
  const CommunityForum({super.key, required this.name, required this.location, required this.image, required this.caption, required this.video, required this.timeAgo});
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
        CarouselSlider(
            items: ['', '', ''].map<Widget>((e) => Padding(
              padding: const EdgeInsets.only(right: 20),
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
                          Text(
                              'Kampala, Uganda',
                              style: figtreeMedium.copyWith(
                                  fontSize: 12,
                                  color: Colors.black)),
                        ],
                      ),
                    ],
                  ),
                ],
              ),
            ),).toList(),
            options: CarouselOptions(
              autoPlay: true,
              enableInfiniteScroll: false,
              viewportFraction: 0.86,
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
                  activeDotColor: ColorResources.purple,
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
