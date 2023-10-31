import 'package:flutter/material.dart';
import 'package:glad/screen/custom_widget/custom_methods.dart';
import 'package:glad/screen/custom_widget/show_all_button.dart';
import 'package:glad/screen/farmer_screen/online_training.dart';
import 'package:glad/utils/extension.dart';
import 'package:glad/utils/images.dart';
import 'package:glad/utils/styles.dart';

class FeaturedTrainings extends StatefulWidget {
  const FeaturedTrainings({super.key});

  @override
  State<FeaturedTrainings> createState() => _FeaturedTrainingsState();
}

class _FeaturedTrainingsState extends State<FeaturedTrainings> {
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
              Text('Featured Trainings',
                  style: figtreeMedium.copyWith(
                      fontSize: 18, color: Colors.black)),
              ShowAllButton(onTap: () {
                const OnlineTraining(isBottomAppBar: false,).navigate();
              })
            ],
          ),
        ),
        Padding(
          padding: const EdgeInsets.fromLTRB(20.0, 20, 0, 20),
          child: SizedBox(
            height: 130,
            child: ListView.separated(
              clipBehavior: Clip.none,
              itemCount: 10,
              scrollDirection: Axis.horizontal,
              itemBuilder: (context, index) {
                return customShadowContainer(
                  margin: 0,
                  backColor: Colors.grey.withOpacity(0.4),
                  child: Container(
                    width: screenWidth() * 0.9,
                    padding: const EdgeInsets.all(10.0),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(16),
                      color: Colors.white,
                    ),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Image.asset(Images.sampleLivestock),
                        Expanded(
                          child: Padding(
                            padding: const EdgeInsets.only(
                                left: 10.0, top: 10, bottom: 10),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text('How to start dairy business...',
                                        style: figtreeMedium.copyWith(
                                          color: Colors.black,
                                          fontSize: 18,
                                          overflow: TextOverflow.ellipsis,
                                        ),
                                        maxLines: 2,
                                        softWrap: true),
                                    Text('10 months ago',
                                        style: figtreeMedium.copyWith(
                                            color: const Color(0xFF727272),
                                            fontSize: 12))
                                  ],
                                ),
                                Row(
                                  children: [
                                    RichText(
                                        text: TextSpan(children: [
                                      TextSpan(
                                          text: '04k ',
                                          style: figtreeMedium.copyWith(
                                              fontSize: 12,
                                              color: const Color(0xFF727272))),
                                      TextSpan(
                                          text: 'views',
                                          style: figtreeMedium.copyWith(
                                              fontSize: 12,
                                              color: const Color(0xFF727272))),
                                    ])),
                                    4.horizontalSpace(),
                                    Container(
                                      height: 5,
                                      width: 5,
                                      decoration: const BoxDecoration(
                                          color: Color(0xFF727272),
                                          shape: BoxShape.circle),
                                    ),
                                    4.horizontalSpace(),
                                    RichText(
                                        text: TextSpan(children: [
                                      TextSpan(
                                          text: '245 ',
                                          style: figtreeMedium.copyWith(
                                              fontSize: 12,
                                              color: const Color(0xFF727272))),
                                      TextSpan(
                                          text: 'comments',
                                          style: figtreeMedium.copyWith(
                                              fontSize: 12,
                                              color: const Color(0xFF727272)))
                                    ])),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              },
              separatorBuilder: (context, index) {
                return 10.horizontalSpace();
              },
            ),
          ),
        ),
      ],
    );
  }
}
