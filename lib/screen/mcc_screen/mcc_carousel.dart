import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:glad/screen/custom_widget/custom_methods.dart';
import 'package:glad/utils/color_resources.dart';
import 'package:glad/utils/extension.dart';
import 'package:glad/utils/images.dart';
import 'package:glad/utils/styles.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class MccLandingCarousel extends StatefulWidget {

  const MccLandingCarousel({super.key});

  @override
  State<MccLandingCarousel> createState() => _MccLandingCarouselState();
}

class _MccLandingCarouselState extends State<MccLandingCarousel> {
  int activeIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        20.verticalSpace(),
        CarouselSlider(
            items: [
              weatherWidget(),
              Image.asset(Images.training),
              Image.asset(Images.livestock),
              Image.asset(Images.community)
            ],
            options: CarouselOptions(
              autoPlay: true,
              enableInfiniteScroll: false,
              viewportFraction: 1,
              // enlargeCenterPage: true,
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
              count: 4,
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
