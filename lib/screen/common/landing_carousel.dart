import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:glad/screen/custom_widget/custom_methods.dart';
import 'package:glad/utils/color_resources.dart';
import 'package:glad/utils/extension.dart';
import 'package:glad/utils/images.dart';
import 'package:glad/utils/styles.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class LandingCarousel extends StatefulWidget {

  const LandingCarousel({super.key,this.todayMilkPrice});
  final dynamic todayMilkPrice;

  @override
  State<LandingCarousel> createState() => _LandingCarouselState();
}

class _LandingCarouselState extends State<LandingCarousel> {
  int activeIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        20.verticalSpace(),
        CarouselSlider(
            items: [
              Stack(
                  children: [
                    Image.asset(Images.milkPrice),
                    Container(
                      margin: const EdgeInsets.only(top: 35),
                      width: screenWidth()-40,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [

                          Text("Today's Milk Price",style: figtreeRegular.copyWith(
                              fontSize: 16
                          ),),

                          Text('UGX ${widget.todayMilkPrice ?? ''}/Ltr.',style: figtreeBold.copyWith(
                              fontSize: 30
                          ),),

                        ],
                      ),
                    )

                  ],
                ),
              weatherWidget(),
              Image.asset(Images.training),
              Image.asset(Images.livestock),
              Image.asset(Images.community)
            ],
            options: CarouselOptions(
              // autoPlay: true,
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
