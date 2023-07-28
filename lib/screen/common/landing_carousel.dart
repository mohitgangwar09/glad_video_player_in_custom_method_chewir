import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:glad/utils/color_resources.dart';
import 'package:glad/utils/images.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class LandingCarousel extends StatefulWidget {
  const LandingCarousel({super.key});

  @override
  State<LandingCarousel> createState() => _LandingCarouselState();
}

class _LandingCarouselState extends State<LandingCarousel> {
  int activeIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        CarouselSlider(
            items: [
              Padding(
                padding: const EdgeInsets.only(right: 20),
                child: Image.asset(Images.milkPrice),
              ),
              Padding(
                padding: const EdgeInsets.only(right: 20),
                child: Image.asset(Images.weather),
              ),
              Padding(
                padding: const EdgeInsets.only(right: 20),
                child: Image.asset(Images.training),
              ),
              Padding(
                padding: const EdgeInsets.only(right: 20),
                child: Image.asset(Images.livestock),
              ),
              Image.asset(Images.community)
            ],
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
              count: 5,
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
