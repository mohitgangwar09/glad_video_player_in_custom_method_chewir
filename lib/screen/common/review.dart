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
                    (e) => Stack(
                      clipBehavior: Clip.none,
                      children: [
                        Container(
                          margin: const EdgeInsets.only(left: 22),
                          decoration: BoxDecoration(
                              border: Border.all(color:  const Color(0xFFDCDCDC).withOpacity(0.4),
                              // borderRadius: BorderRadius.circular(radius),
                              ),
                              color: Colors.white,
                              borderRadius: const BorderRadius.only(
                                  topLeft: Radius.circular(20),
                                  bottomLeft: Radius.circular(60)),
                              boxShadow:[
                              BoxShadow(
                                  color: Colors.grey.withOpacity(0.5),
                                  blurRadius: 16.0,
                                  offset: const Offset(0, 5)
                              )],),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Expanded(
                                      child: Padding(
                                        padding: const EdgeInsets.fromLTRB(
                                            10.0, 20, 10, 0),
                                        child: Text(
                                          maxLines: 4,
                                          'Lorem is simply dummy of the printing and industry. Lorem Ipsum has industry\'s standard dummy.',
                                          style: figtreeMedium.copyWith(
                                              overflow: TextOverflow.ellipsis,
                                              fontSize: 16, color: Colors.black),
                                        ),
                                      ),
                                    ),

                                    Padding(
                                      padding: const EdgeInsets.fromLTRB(45.0,0,35,20),
                                      child: Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          Text('John Smith, Farmer',
                                              maxLines: 1,
                                              style: figtreeMedium.copyWith(
                                                overflow: TextOverflow.ellipsis,
                                                  fontSize: 14, color: Colors.black)),
                                          4.verticalSpace(),
                                          Text('Kampala, Uganda',
                                              maxLines: 1,
                                              style: figtreeMedium.copyWith(
                                                  overflow: TextOverflow.ellipsis,
                                                  fontSize: 12,
                                                  color: Colors.black)),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ),

                              ClipRRect(
                                borderRadius: const BorderRadius.only(
                                    topLeft: Radius.circular(20),
                                    bottomLeft: Radius.circular(20)),
                                child: Image.asset(Images.sampleVideo,
                                    width: 120,
                                    height: screenHeight(),
                                    fit: BoxFit.cover),
                              )
                            ],
                          ),
                        ),
                        Positioned(
                            bottom: -5,
                            left: 15,
                            child: Container(
                              decoration: const BoxDecoration(shape: BoxShape.circle, color: ColorResources.mustard),
                                padding: const EdgeInsets.fromLTRB(7, 0, 7, 20),
                                child: Image.asset(Images.comma, height: 64,))),
                      ],
                    ),
                  )
                  .toList(),
              options: CarouselOptions(
                autoPlay: true,
                enableInfiniteScroll: false,
                viewportFraction: 1,
                clipBehavior: Clip.none,
                enlargeCenterPage: true,
                height: screenHeight() < 750 ? screenHeight() * 0.285:screenHeight() * 0.22,
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
