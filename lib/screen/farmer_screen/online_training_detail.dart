import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:glad/cubit/training_cubit/training_cubit.dart';
import 'package:glad/screen/custom_widget/custom_methods.dart';
import 'package:glad/utils/color_resources.dart';
import 'package:glad/utils/extension.dart';
import 'package:glad/utils/helper.dart';
import 'package:glad/utils/images.dart';
import 'package:glad/utils/styles.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

import '../custom_widget/custom_appbar.dart';

// class TrianglePainter extends CustomPainter {
//   @override
//   void paint(Canvas canvas, Size size) {
//     final paint = Paint()
//       ..color = Colors.grey
//       ..style = PaintingStyle.stroke;
//
//     final path = Path()
//       ..moveTo(size.width / 2, 5) // Top vertex
//       ..lineTo(0, size.height) // Bottom-left vertex
//       ..lineTo(size.width, size.height) // Bottom-right vertex
//       ..close();
//
//     canvas.drawPath(path, paint);
//   }
//
//   @override
//   bool shouldRepaint(CustomPainter oldDelegate) {
//     return false;
//   }
// }

class OnlineTrainingDetails extends StatefulWidget {
  const OnlineTrainingDetails({super.key, required this.categoryId});
  final String categoryId;

  @override
  State<OnlineTrainingDetails> createState() => _OnlineTrainingDetailsState();
}

class _OnlineTrainingDetailsState extends State<OnlineTrainingDetails> {
  YoutubePlayerController? controller;
  bool fullScreen = false;

  @override
  void initState() {
    func();
    super.initState();
  }

  func() async {
    await BlocProvider.of<TrainingCubit>(context)
        .trainingDetailApi(context, widget.categoryId);
    String videoId = YoutubePlayer.convertUrlToId(
        BlocProvider.of<TrainingCubit>(context)
            .state
            .responseTrainingDetail!
            .data!
            .videoUrl
            .toString())
        .toString();
    BlocProvider.of<TrainingCubit>(context)
        .getVideoStatistics(context, videoId);
    controller = YoutubePlayerController(
      initialVideoId: videoId,
      flags: const YoutubePlayerFlags(
        autoPlay: true,
        mute: true,
      ),
    );
  }

  @override
  void dispose() {
    controller!.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async{
        await SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
        return true;
      },
      child: Scaffold(
        backgroundColor: Colors.white,
        body: BlocBuilder<TrainingCubit, TrainingCubitState>(
            builder: (context, state) {
          if (state.status == TrainingStatus.submit) {
            return const Center(
                child: CircularProgressIndicator(
              color: ColorResources.maroon,
            ));
          } else if (state.responseTrainingDetail == null) {
            return Center(
                child: Text("${state.responseTrainingDetail} Api Error"));
          } else {
            return Stack(
              children: [
                fullScreen ? const SizedBox.shrink() :landingBackground(),
                Column(
                  children: [
                    if(!fullScreen)
                      CustomAppBar(
                        context: context,
                        titleText1: 'Online training',
                        leading: arrowBackButton(onTap: () async{
                          await SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
                          pressBack();
                        }),
                        centerTitle: true,
                        titleText1Style: figtreeMedium.copyWith(
                            fontSize: 20, color: Colors.black),
                      ),
                    Expanded(
                      child: SingleChildScrollView(
                        child: Padding(
                          padding: EdgeInsets.fromLTRB(0, fullScreen ? 0 : 20, 0, 0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              YoutubePlayerBuilder(
                                player: YoutubePlayer(
                                  controller: controller!,
                                  // aspectRatio: 4/3,
                                ),
                                builder: (context, player) {
                                  return player;
                                },
                                onEnterFullScreen: () {
                                  setState(() {
                                    fullScreen = true;
                                  });
                                },
                                onExitFullScreen: () {
                                  setState(() {
                                    fullScreen = false;
                                  });
                                },
                              ),
                              !fullScreen ? Padding(
                                padding: const EdgeInsets.fromLTRB(
                                    22, 15, 25, 20),
                                child: Column(
                                  children: [
                                    Row(
                                      mainAxisAlignment:
                                      MainAxisAlignment
                                          .spaceBetween,
                                      children: [
                                        Text(
                                          state.responseTrainingDetail!
                                              .data!.title ??
                                              '',
                                          style: figtreeMedium
                                              .copyWith(fontSize: 18),
                                        ),
                                      ],
                                    ),
                                    // 10.verticalSpace(),
                                    // Row(
                                    //   mainAxisAlignment: MainAxisAlignment.start,
                                    //   children: [
                                    //     Text(
                                    //       '${getAge(DateTime.parse(state.responseTrainingDetail!.data!.validFrom.toString()))} ago',
                                    //       style: figtreeMedium
                                    //           .copyWith(fontSize: 12),
                                    //     ),
                                    //   ],
                                    // ),
                                  ],
                                ),
                              ) : const SizedBox.shrink(),
                              if(!fullScreen && state.responseVideoStatistics != null && state.responseVideoStatistics!.items != null && state.responseVideoStatistics!.items!.isNotEmpty)
                              Padding(
                                padding: const EdgeInsets.only(left: 20.0),
                                child: Column(
                                  children: [
                                    Row(
                                      // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text(
                                          '${state.responseVideoStatistics!.items![0].statistics!.viewCount ?? 0} views',
                                          style: figtreeMedium.copyWith(fontSize: 12),
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
                                          '${getAge(DateTime.parse(state.responseTrainingDetail!.data!.validFrom.toString()))} ago',
                                          style: figtreeMedium.copyWith(fontSize: 12),
                                        ),
                                      ],
                                    ),
                                    20.verticalSpace(),
                                    Row(children: [
                                      Text(
                                        '${state.responseVideoStatistics!.items![0].statistics!.commentCount ?? 0} comments',
                                        style: figtreeMedium.copyWith(fontSize: 12),
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
                                        '${state.responseVideoStatistics!.items![0].statistics!.likeCount ?? 0} likes',
                                        style: figtreeMedium.copyWith(fontSize: 12),
                                      ),
                                    ],)
                                  ],
                                ),
                              ),
                              // imageCard(state),
                              // comment(),
                              // commentList(),
                            ],
                          ),
                        ),
                      ),
                    )
                  ],
                )
              ],
            );
          }
        }),
      ),
    );
  }

////////////ImageCard///////////////
  Widget imageCard(TrainingCubitState state) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12.0),
      child: customShadowContainer(
          margin: 0,
          backColor: Colors.grey.withOpacity(0.4),
          child: Stack(
            children: [
              Column(
                children: [
                  Container(
                    height: 150,
                    decoration: BoxDecoration(
                        image: const DecorationImage(
                          fit: BoxFit.cover,
                          image: AssetImage(Images.cowBig),
                        ),
                        borderRadius: BorderRadius.circular(20)),
                  ),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(22, 15, 25, 20),
                    child: Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              'How to start dairy business...',
                              style: figtreeMedium.copyWith(fontSize: 18),
                            ),
                            SvgPicture.asset(
                              Images.menuIcon,
                              height: 20,
                              width: 20,
                            )
                          ],
                        ),
                        10.verticalSpace(),
                        Row(
                          // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              '04k views',
                              style: figtreeMedium.copyWith(fontSize: 12),
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
                              '10 months ago',
                              style: figtreeMedium.copyWith(fontSize: 12),
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
                              '245 comments',
                              style: figtreeMedium.copyWith(fontSize: 12),
                            ),
                          ],
                        ),
                      ],
                    ),
                  )
                ],
              ),
              Positioned(
                right: 10,
                top: 10,
                child: SvgPicture.asset(
                  Images.newsI,
                  width: 35,
                  height: 35,
                ),
              )
            ],
          )),
    );
  }

  // /////////AddComment////////
  // Widget comment() {
  //   return Column(
  //     crossAxisAlignment: CrossAxisAlignment.start,
  //     children: [
  //       40.verticalSpace(),
  //       Text(
  //         'Add comment',
  //         style: figtreeRegular.copyWith(fontSize: 16),
  //       ),
  //       Stack(
  //         children: [
  //           SizedBox(
  //             height: 105,
  //             width: screenWidth(),
  //           ),
  //           Positioned(
  //               left: 0,
  //               right: 0,
  //               top: 0,
  //               bottom: 0,
  //               child: Center(
  //                   child: Stack(
  //                 children: [
  //                   const CustomTextField(
  //                     hint: 'Write..',
  //                   ),
  //                   Positioned(
  //                       top: 0,
  //                       bottom: 0,
  //                       right: 20,
  //                       child: SvgPicture.asset(
  //                         Images.commentSend,
  //                         width: 30,
  //                         height: 30,
  //                       ))
  //                 ],
  //               ))),
  //           Padding(
  //             padding: const EdgeInsets.only(left: 20.0),
  //             child: CustomPaint(
  //               painter: TrianglePainter(),
  //               size: const Size(20, 20),
  //             ),
  //           ),
  //           Positioned(
  //               top: 19,
  //               left: 20,
  //               child: Container(
  //                 decoration: BoxDecoration(
  //                     borderRadius: BorderRadius.circular(20),
  //                     color: Colors.white),
  //                 width: 20,
  //                 height: 3,
  //               )),
  //         ],
  //       ),
  //     ],
  //   );
  // }
  //
  // ////////CommentList//////////
  // Widget commentList() {
  //   return customList(
  //       child: (index) => Padding(
  //             padding: const EdgeInsets.only(bottom: 10),
  //             child: InkWell(
  //               onTap: () {},
  //               child: Stack(
  //                 children: [
  //                   Container(
  //                       padding: const EdgeInsets.fromLTRB(20, 10, 20, 15),
  //                       decoration: BoxDecoration(
  //                           color: ColorResources.grey,
  //                           borderRadius: const BorderRadius.only(
  //                               topLeft: Radius.circular(0),
  //                               topRight: Radius.circular(24),
  //                               bottomLeft: Radius.circular(24),
  //                               bottomRight: Radius.circular(24)),
  //                           border: Border.all(
  //                               color: ColorResources.grey, width: 1)),
  //                       child: Column(
  //                         children: [
  //                           Text(
  //                             'What is the status of my loan application versions have evolved?',
  //                             style: figtreeRegular.copyWith(fontSize: 16),
  //                           ),
  //                           15.verticalSpace(),
  //                           Row(
  //                             mainAxisAlignment: MainAxisAlignment.spaceBetween,
  //                             children: [
  //                               Text(
  //                                 'Charles Begumanya',
  //                                 style: figtreeSemiBold.copyWith(
  //                                     fontSize: 12,
  //                                     color: ColorResources.maroon),
  //                               ),
  //                               Text(
  //                                 '2 days ago',
  //                                 style: figtreeRegular.copyWith(fontSize: 10),
  //                               ),
  //                             ],
  //                           ),
  //                         ],
  //                       )),
  //                 ],
  //               ),
  //             ),
  //           ),
  //       list: [1, 1, 1, 1]);
  // }
}
