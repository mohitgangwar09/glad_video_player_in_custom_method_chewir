import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:glad/screen/custom_widget/custom_appbar.dart';
import 'package:glad/screen/custom_widget/custom_methods.dart';
import 'package:glad/utils/color_resources.dart';
import 'package:glad/utils/images.dart';
import 'package:glad/utils/styles.dart';

class Faq extends StatefulWidget {
  const Faq({super.key});

  @override
  State<Faq> createState() => _FaqState();
}

class _FaqState extends State<Faq> {
  int defaultIndex = 0;
  List viewList = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          landingBackground(),
          Column(
            children: [
              CustomAppBar(
                context: context,
                titleText1: "FAQ's",
                centerTitle: true,
                leading: arrowBackButton(),
              ),
              fourOptions(),
              listDetails(),
            ],
          )
        ],
      ),
    );
  }

  Widget fourOptions() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
            padding: const EdgeInsets.all(14),
            decoration: boxDecoration(
              borderColor: const Color(0xffDCDCDC),
              borderRadius: 50,
              backgroundColor: Colors.white,
            ),
            child: Text(
              'All',
              style: figtreeMedium.copyWith(fontSize: 12, color: Colors.black),
            )),
        const SizedBox(
          width: 10,
        ),
        Container(
            padding: const EdgeInsets.all(14),
            decoration: boxDecoration(
              borderColor: const Color(0xffDCDCDC),
              borderRadius: 50,
              backgroundColor: Colors.white,
            ),
            child: Text(
              'Trending',
              style: figtreeMedium.copyWith(fontSize: 12, color: Colors.black),
            )),
        const SizedBox(
          width: 10,
        ),
        Container(
            padding: const EdgeInsets.all(14),
            decoration: boxDecoration(
              borderColor: const Color(0xffDCDCDC),
              borderRadius: 50,
              backgroundColor: Colors.white,
            ),
            child: Text(
              'Technology',
              style: figtreeMedium.copyWith(fontSize: 12, color: Colors.black),
            )),
        const SizedBox(
          width: 10,
        ),
        Container(
            padding: const EdgeInsets.all(14),
            decoration: boxDecoration(
              borderColor: const Color(0xffDCDCDC),
              borderRadius: 50,
              backgroundColor: Colors.white,
            ),
            child: Text(
              'Featured',
              style: figtreeMedium.copyWith(fontSize: 12, color: Colors.black),
            )),
      ],
    );
  }

  Widget listDetails() {
    return customList(
        list: [1, 2, 3],
        child: (index) {
          return Padding(
            padding: const EdgeInsets.only(left: 15, right: 15),
            child: Container(
              margin: const EdgeInsets.only(top: 15),
              decoration: BoxDecoration(
                  border: Border.all(width: 1, color: ColorResources.colorGrey),
                  borderRadius: BorderRadius.circular(14)),
              child: Padding(
                padding: const EdgeInsets.only(
                    left: 15, right: 10, top: 15, bottom: 15),
                child: Column(
                  children: [
                    Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Expanded(
                            child: Text(
                              'Lorem is simply dummy of the printing and industry?',
                              maxLines: 4,
                              style: figtreeMedium.copyWith(fontSize: 18),
                            ),
                          ),
                          InkWell(
                              onTap: () {
                                setState(() {
                                  defaultIndex = index;
                                });
                              },

                              child: defaultIndex == index?SvgPicture.asset(

                                Images.lessFaq,
                                height: 40,
                                width: 40,
                              ):SvgPicture.asset(Images.addFaq)
                          )
                        ]),
                    defaultIndex == index
                        ? Column(
                      children: [

                        const SizedBox(
                          height: 20,
                        ),
                        Text(
                          "Lorem is simply dummy of the printing industry. Lorem Ipsum has industry's standard dummy. Lorem is simply dummy of the printing and industry. Lorem Ipsum has industry's standard dummy",
                          style: figtreeMedium.copyWith(
                              fontSize: 16,
                              color: ColorResources.colorGrey),
                        ),
                      ],
                    )
                        : const SizedBox.shrink()
                  ],
                ),
              ),
            ),
          );
        });
  }
}