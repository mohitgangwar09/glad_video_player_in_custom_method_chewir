import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:glad/utils/color_resources.dart';
import 'package:glad/utils/extension.dart';
import 'package:glad/utils/images.dart';
import 'package:glad/utils/styles.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class GladReview extends StatefulWidget {
  const GladReview({super.key});

  @override
  State<GladReview> createState() => _GladReviewState();
}

class _GladReviewState extends State<GladReview> {
  int activeIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.fromLTRB(20, 10, 20, 2),
          child: Text('GLAD makes you Happier!',
              style: figtreeMedium.copyWith(fontSize: 18, color: Colors.black)),
        ),
        Padding(
          padding: const EdgeInsets.only(top: 20),
          child: CarouselSlider(
              items: ['', '', '']
                  .map<Widget>(
                    (e) => Padding(
                      padding: const EdgeInsets.only(right: 10),
                      child: Stack(
                        children: [
                          Container(
                            decoration: BoxDecoration(
                                border:
                                    Border.all(color: const Color(0xFFDCDCDC)),
                                borderRadius: const BorderRadius.only(
                                    topLeft: Radius.circular(20),
                                    bottomLeft: Radius.circular(60)),
                                color: Colors.white),
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Expanded(
                                  child: Padding(
                                    padding: const EdgeInsets.fromLTRB(
                                        10.0, 20, 10, 0),
                                    child: Text(
                                      'Lorem is simply dummy of the printing and industry. Lorem Ipsum has industry\'s standard dummy.',
                                      style: figtreeMedium.copyWith(
                                          fontSize: 16, color: Colors.black),
                                    ),
                                  ),
                                ),
                                ClipRRect(
                                  borderRadius: const BorderRadius.only(
                                      topLeft: Radius.circular(20),
                                      bottomLeft: Radius.circular(20)),
                                  child: Image.asset(Images.sampleVideo,
                                      width: 120,
                                      height: 200,
                                      fit: BoxFit.cover),
                                )
                              ],
                            ),
                          ),
                          Positioned(
                              bottom: -10,
                              child: Row(
                                children: [
                                  Container(
                                    decoration: const BoxDecoration(shape: BoxShape.circle, color: ColorResources.mustard),
                                      padding: const EdgeInsets.fromLTRB(7, 0, 7, 20),
                                      child: Image.asset(Images.comma, height: 60,)),

                                  6.horizontalSpace(),
                                  Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text('John Smith, Farmer',
                                          style: figtreeMedium.copyWith(
                                              fontSize: 14, color: Colors.black)),
                                      4.verticalSpace(),
                                      Text('Kampala, Uganda',
                                          style: figtreeMedium.copyWith(
                                              fontSize: 12,
                                              color: Colors.black)),
                                    ],
                                  ),
                                ],
                              ))
                        ],
                      ),

                    ),
                  )
                  .toList(),
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
