import 'package:flutter/material.dart';
import 'package:glad/data/model/auth_models/introslider_model.dart';
import 'package:glad/screen/auth_screen/upload_profile_picture.dart';
import 'package:glad/screen/custom_widget/custom_methods.dart';
import 'package:glad/screen/dashboard/bottom_navigation_bar.dart';
import 'package:glad/screen/guest_user/landing_page.dart';
import 'package:glad/utils/extension.dart';
import 'package:glad/utils/images.dart';
import 'package:glad/utils/styles.dart';

class IntroSlider extends StatefulWidget {
  const IntroSlider({super.key});

  @override
  State<IntroSlider> createState() => _IntroSliderState();
}

class _IntroSliderState extends State<IntroSlider> {
  late PageController controller;
  int currentPage = 0;

  @override
  void initState() {
    super.initState();
    controller = PageController();
  }

  @override
  void dispose() {
    super.dispose();
    controller.dispose();
  }

  String imageOnPage() {
    switch (currentPage) {
      case 0:
        return Images.sliderOne;
      case 1:
        return Images.sliderTwo;
      default:
        return '';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Container(
            decoration: BoxDecoration(
                image: DecorationImage(
                    image: AssetImage(imageOnPage()), fit: BoxFit.fill)),
            child: PageView.builder(
                controller: controller,
                itemCount: introSliderContents.length,
                onPageChanged: (page) {
                  setState(() {
                    currentPage = page;
                  });
                },
                itemBuilder: (context, index) {
                  return Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text(''),
                      Container(
                        width: MediaQuery.of(context).size.width,
                        height: 330,
                        decoration: BoxDecoration(
                            color: introSliderContents[index]
                                .color
                                .withOpacity(0.8),
                            borderRadius: index == 1
                                ? const BorderRadius.only(
                                    topLeft: Radius.circular(80))
                                : const BorderRadius.only(
                                    topRight: Radius.circular(80))),
                        padding: const EdgeInsets.fromLTRB(40, 40, 10, 20),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            15.verticalSpace(),
                            Text(
                              introSliderContents[index].title1,
                              style: figtreeMedium.copyWith(
                                  fontSize: 34, color: Colors.white),
                            ),
                            10.verticalSpace(),
                            Text(
                              introSliderContents[index].title2,
                              style: figtreeRegular.copyWith(
                                  fontSize: 20, color: Colors.white),
                            ),
                          ],
                        ),
                      )
                    ],
                  );
                }),
          ),
          Positioned(
            bottom: 285,
            right: 0,
            left: 40,
            child: Row(
              children: [
                if (currentPage == 0)
                  Row(
                    children: [
                      Container(
                        height: 9,
                        width: 9,
                        decoration: const BoxDecoration(
                            shape: BoxShape.circle, color: Colors.white),
                      ),
                      6.horizontalSpace(),
                    ],
                  ),
                Container(
                  height: 5,
                  width: 5,
                  decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: Colors.white.withOpacity(.49)),
                ),
                if (currentPage == 1)
                  Row(
                    children: [
                      6.horizontalSpace(),
                      Container(
                        height: 9,
                        width: 9,
                        decoration: const BoxDecoration(
                            shape: BoxShape.circle, color: Colors.white),
                      ),
                    ],
                  ),
              ],
            ),
          ),
          Positioned(
            bottom: 0,
            right: 0,
            left: 0,
            child: Container(
              padding: const EdgeInsets.only(left: 20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  currentPage == 0
                      ? Padding(
                          padding: const EdgeInsets.only(left: 20),
                          child: Text(
                            'SKIP',
                            style: figtreeRegular.copyWith(
                                fontSize: 18,
                                color: Colors.white,
                                decoration: TextDecoration.underline),
                          ),
                        )
                      : const Text(''),
                  svgIconWithOnTap(
                    image: Images.sliderNext,
                    onTap: () {
                      if (controller.page!.toInt() == 1) {
                        const BottomNavigationScreen().navigate(isRemove: true);
                      }
                      controller.animateToPage(
                        controller.page!.toInt() + 1,
                        duration: const Duration(milliseconds: 400),
                        curve: Curves.easeInOut,
                      );
                      setState(() {});
                    },
                  )
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
