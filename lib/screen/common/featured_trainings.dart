import 'dart:math';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:glad/cubit/dashboard_cubit/dashboard_cubit.dart';
import 'package:glad/cubit/profile_cubit/profile_cubit.dart';
import 'package:glad/data/model/dashboard_training.dart';
import 'package:glad/screen/custom_widget/custom_methods.dart';
import 'package:glad/screen/custom_widget/show_all_button.dart';
import 'package:glad/screen/farmer_screen/online_training.dart';
import 'package:glad/utils/app_constants.dart';
import 'package:glad/utils/extension.dart';
import 'package:glad/utils/helper.dart';
import 'package:glad/utils/images.dart';
import 'package:glad/utils/styles.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

class FeaturedTrainings extends StatefulWidget {
  const FeaturedTrainings({super.key, required this.trainingList, required this.onTapShowAll});
  final List<TrainingList> trainingList;
  final Function() onTapShowAll;

  @override
  State<FeaturedTrainings> createState() => _FeaturedTrainingsState();
}

class _FeaturedTrainingsState extends State<FeaturedTrainings> {
  @override
  Widget build(BuildContext context) {
    return
      widget.trainingList.isEmpty ? const SizedBox.shrink() :
    Column(
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
              ShowAllButton(onTap: widget.onTapShowAll)
            ],
          ),
        ),
        Padding(
          padding: const EdgeInsets.fromLTRB(20.0, 20, 10, 20),
          child: SizedBox(
            height: 130,
            child: ListView.separated(
              clipBehavior: Clip.none,
              itemCount: widget.trainingList.length,
              scrollDirection: Axis.horizontal,
              itemBuilder: (context, index) {
                return InkWell(
                  onTap: () {
                    showDialog(
                        context: context,
                        builder: (context) => OverlayVideoPlayer(
                            url: widget.trainingList[index].videoUrl ?? ''));
                  },
                  child: customShadowContainer(
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
                          ClipRRect(
                            borderRadius:
                            BorderRadius.circular(20),
                            child: CachedNetworkImage(
                              imageUrl: widget
                                  .trainingList[index]
                                  .image ??
                                  '',
                              fit: BoxFit.fitHeight,
                              width: screenWidth() * 0.35,
                              height: screenHeight(),
                              errorWidget: (_, __, ___) {
                                return Image.asset(
                                  Images.sampleLivestock,
                                  fit: BoxFit.fitHeight,
                                  width: screenWidth() * 0.35,
                                  height: screenHeight(),
                                );
                              },
                            ),
                          ),
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
                                      Text(widget.trainingList[index].title ?? '',
                                          style: figtreeMedium.copyWith(
                                            color: Colors.black,
                                            fontSize: 18,
                                            overflow: TextOverflow.ellipsis,
                                          ),
                                          maxLines: 2,
                                          softWrap: true),
                                      10.verticalSpace(),
                                      if(widget.trainingList[index].youtube !=null)
                                        Row(
                                        mainAxisAlignment: MainAxisAlignment.start,
                                        children: [
                                          Text(
                                            '${getCurrencyString(int.parse(widget.trainingList[index].youtube!.viewCount ?? "0"), unit: '')} views',
                                            style: figtreeMedium
                                                .copyWith(fontSize: 12, color: Color(0xFF727272)),
                                          ),
                                          8.horizontalSpace(),
                                          Container(
                                            height: 5,
                                            width: 5,
                                            decoration: const BoxDecoration(
                                                color: Colors.black, shape: BoxShape.circle),
                                          ),
                                          8.horizontalSpace(),
                                          Text(
                                            '${getCurrencyString(int.parse(widget.trainingList[index].youtube!.commentCount ?? "0"), unit: '')} comments',
                                            style: figtreeMedium
                                                .copyWith(fontSize: 12, color: Color(0xFF727272)),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                  // Row(
                                  //   children: [
                                  //     RichText(
                                  //         text: TextSpan(children: [
                                  //       TextSpan(
                                  //           text: '04k ',
                                  //           style: figtreeMedium.copyWith(
                                  //               fontSize: 12,
                                  //               color: const Color(0xFF727272))),
                                  //       TextSpan(
                                  //           text: 'views',
                                  //           style: figtreeMedium.copyWith(
                                  //               fontSize: 12,
                                  //               color: const Color(0xFF727272))),
                                  //     ])),
                                  //     4.horizontalSpace(),
                                  //     Container(
                                  //       height: 5,
                                  //       width: 5,
                                  //       decoration: const BoxDecoration(
                                  //           color: Color(0xFF727272),
                                  //           shape: BoxShape.circle),
                                  //     ),
                                  //     4.horizontalSpace(),
                                  //     RichText(
                                  //         text: TextSpan(children: [
                                  //       TextSpan(
                                  //           text: '245 ',
                                  //           style: figtreeMedium.copyWith(
                                  //               fontSize: 12,
                                  //               color: const Color(0xFF727272))),
                                  //       TextSpan(
                                  //           text: 'comments',
                                  //           style: figtreeMedium.copyWith(
                                  //               fontSize: 12,
                                  //               color: const Color(0xFF727272)))
                                  //     ])),
                                  //   ],
                                  // ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
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


class OverlayVideoPlayer extends StatefulWidget {
  const OverlayVideoPlayer({
    Key? key,
    required this.url,
  }) : super(key: key);

  final String url;

  @override
  State<OverlayVideoPlayer> createState() => _OverlayVideoPlayerState();
}

class _OverlayVideoPlayerState extends State<OverlayVideoPlayer> {
  YoutubePlayerController? controller;

  @override
  void initState() {
    func();
    super.initState();
  }

  func() async {
    String? videoId = getYoutubeVideoId(widget.url);
    controller = YoutubePlayerController(
      initialVideoId: videoId ?? '',
      flags: const YoutubePlayerFlags(
        autoPlay: true,
      ),
    );
    if(videoId == null) {

      Future.delayed(const Duration(seconds: 2), () {
        showCustomToast(context, 'Not a valid url');
        print("pressBack");
        pressBack();
      });

    }
  }

  @override
  void dispose() {
    controller!.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return YoutubePlayerBuilder(
          player: YoutubePlayer(
            controller: controller!,
            topActions: [
              arrowBackButton(color: Colors.white),
            ],
            // aspectRatio: 4/3,
          ),
          builder: (context, player) {
            return player;
          },
          // onEnterFullScreen: () {
          //   setState(() {
          //     fullScreen = true;
          //   });
          // },
          // onExitFullScreen: () {
          //   setState(() {
          //     fullScreen = false;
          //   });
          // },
        );
  }
}