import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:glad/cubit/profile_cubit/profile_cubit.dart';
import 'package:glad/cubit/training_cubit/training_cubit.dart';
import 'package:glad/screen/custom_widget/custom_appbar.dart';
import 'package:glad/screen/custom_widget/custom_methods.dart';
import 'package:glad/screen/farmer_screen/online_training_detail.dart';
import 'package:glad/screen/guest_user/dashboard/dashboard_guest.dart';
import 'package:glad/utils/app_constants.dart';
import 'package:glad/utils/color_resources.dart';
import 'package:glad/utils/extension.dart';
import 'package:glad/utils/helper.dart';
import 'package:glad/utils/images.dart';
import 'package:glad/utils/styles.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

class OnlineTraining extends StatefulWidget {
  const OnlineTraining({super.key, required this.isBottomAppBar});
  final bool isBottomAppBar;

  @override
  State<OnlineTraining> createState() => _OnlineTrainingState();
}

class _OnlineTrainingState extends State<OnlineTraining> {
  @override
  void initState() {
    BlocProvider.of<TrainingCubit>(context).trainingCategoriesApi(context);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          landingBackground(),
          BlocBuilder<TrainingCubit, TrainingCubitState>(
              builder: (context, state) {
            if (state.status == TrainingStatus.submit) {
              return const Center(
                  child: CircularProgressIndicator(
                color: ColorResources.maroon,
              ));
            } else if (state.responseTrainingCategories == null) {
              return Center(
                  child: Text("${state.responseTrainingCategories} Api Error"));
            }  else if (state.responseTrainingList == null) {
              return Center(
                  child: Text("${state.responseTrainingList} Api Error"));
            } else {
              return Column(

                children: [
                  widget.isBottomAppBar ?
                  CustomAppBar(
                    context: context,
                    titleText1: 'Online trainings',
                    centerTitle: true,
                    leading: BlocProvider.of<ProfileCubit>(context).sharedPreferences.getString(AppConstants.userType) == 'mcc' ?
                    const SizedBox.shrink()
                        : openDrawer(
                        onTap: () {
                          landingKey.currentState?.openDrawer();
                        },
                        child: SvgPicture.asset(Images.drawer)),
                    // action: Row(
                    //   children: [
                    //     InkWell(
                    //         onTap: () {
                    //           modalBottomSheetMenu(
                    //               context, child:
                    //           SizedBox(
                    //             height: screenHeight()*0.65,
                    //             child: Column(
                    //               children: [
                    //
                    //                 Padding(
                    //                   padding: const EdgeInsets.only(left: 8.0,right: 8),
                    //                   child: Row(
                    //                     mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    //                     children: [
                    //
                    //                       TextButton(onPressed: (){
                    //                         pressBack();
                    //                       }, child: "Cancel".textMedium(color: const Color(0xff6A0030),fontSize: 14)),
                    //
                    //                       "Sort By".textMedium(fontSize: 22),
                    //
                    //                       TextButton(onPressed: (){},child: "Reset".textMedium(color: const Color(0xff6A0030),fontSize: 14))
                    //
                    //                     ],
                    //                   ),
                    //                 ),
                    //
                    //                 const Padding(
                    //                   padding: EdgeInsets.only(left: 20.0,right: 20),
                    //                   child: Divider(),
                    //                 ),
                    //
                    //                 Expanded(
                    //                   child: customList(list: [1,2,22,2,22,2,2,22,2],child: (index){
                    //                     return Padding(padding: const EdgeInsets.only(left: 30,right: 30,top:30,bottom: 10),
                    //                         child: "ROI Highest to Lowest".textRegular(fontSize: 16));
                    //                   }),
                    //                 ),
                    //
                    //                 10.verticalSpace(),
                    //
                    //                 Container(margin: 20.marginAll(),height: 55,width: screenWidth(),child: customButton("Apply",fontColor: 0xffffffff, onTap: (){}))
                    //
                    //
                    //               ],
                    //             ),
                    //           ));
                    //         }, child: SvgPicture.asset(Images.filter2)),
                    //     18.horizontalSpace(),
                    //   ],
                    // ),
                  ) :
                  CustomAppBar(
                    context: context,
                    titleText1: 'Online trainings',
                    centerTitle: true,
                    leading: arrowBackButton(),
                  ),
                  fourOptions(state),
                  imageWithDetails(state)
                ],
              );
            }
          })
        ],
      ),
    );
  }

////////////FourOptions///////////////
  Widget fourOptions(TrainingCubitState state) {
    return SizedBox(
      height: 45,
      child: customList(
          list: List.generate(
              state.responseTrainingCategories!.data!.length, (index) => null),
          axis: Axis.horizontal,
          child: (index) {
            return Row(
              children: [
                index == 0
                    ? Padding(
                        padding: const EdgeInsets.only(left: 20),
                        child: InkWell(
                          onTap: () {
                            BlocProvider.of<TrainingCubit>(context)
                                .emit(state.copyWith(selectedCategoryId: ''));
                            BlocProvider.of<TrainingCubit>(context)
                                .trainingListApi(context, '');
                          },
                          child: Container(
                              padding: const EdgeInsets.all(14),
                              decoration: boxDecoration(
                                borderColor: state.selectedCategoryId == ''
                                    ? ColorResources.maroon
                                    : const Color(0xffDCDCDC),
                                borderRadius: 50,
                                backgroundColor: state.selectedCategoryId == ''
                                    ? const Color(0xFFFFF3F4)
                                    : Colors.white,
                              ),
                              child: Text(
                                'All',
                                style: figtreeMedium.copyWith(
                                    fontSize: 12,
                                    color: state.selectedCategoryId == ''
                                        ? ColorResources.maroon
                                        : Colors.black),
                              )),
                        ),
                      )
                    : const SizedBox.shrink(),
                Padding(
                  padding:
                      EdgeInsets.only(right: 10, left: index == 0 ? 10 : 0),
                  child: InkWell(
                    onTap: () {
                      BlocProvider.of<TrainingCubit>(context).emit(
                          state.copyWith(
                              selectedCategoryId: state
                                      .responseTrainingCategories!
                                      .data![index]
                                      .id.toString() ??
                                  ''));
                      BlocProvider.of<TrainingCubit>(context).trainingListApi(
                          context,
                          state.responseTrainingCategories!.data![index].id.toString() ??
                              '');
                    },
                    child: Container(
                        padding: const EdgeInsets.all(14),
                        decoration: boxDecoration(
                          borderColor: state.selectedCategoryId ==
                                  state.responseTrainingCategories!.data![index]
                                      .id.toString()
                              ? ColorResources.maroon
                              : const Color(0xffDCDCDC),
                          borderRadius: 50,
                          backgroundColor: state.selectedCategoryId ==
                                  state.responseTrainingCategories!.data![index]
                                      .id.toString()
                              ? const Color(0xFFFFF3F4)
                              : Colors.white,
                        ),
                        child: Text(
                          state.responseTrainingCategories!.data![index].name ??
                              '',
                          style: figtreeMedium.copyWith(
                              fontSize: 12,
                              color: state.selectedCategoryId ==
                                      state.responseTrainingCategories!
                                          .data![index].id.toString()
                                  ? ColorResources.maroon
                                  : Colors.black),
                        )),
                  ),
                ),
              ],
            );
          }),
    );
  }

  //////ImageWithDetails////////////////
  Widget imageWithDetails(TrainingCubitState state) {
    return state.responseTrainingList!.data != null
        ? Expanded(
            child: SingleChildScrollView(
              child: customList(
                  padding: const EdgeInsets.fromLTRB(20, 17, 20, 120),
                  list: List.generate(state.responseTrainingList!.data!.length,
                      (index) => null),
                  child: (index) {
                    return Column(
                      children: [
                        InkWell(
                          onTap: () {
                            print(state.responseTrainingList!.data![index].videoUrl);
                            showDialog(
                                context: context,
                                builder: (context) => OverlayVideoPlayer(
                                    url: state.responseTrainingList!.data![index].videoUrl ?? ''));
                            // OnlineTrainingDetails(categoryId: state.responseTrainingList!.data![index].id.toString()).navigate();
                          },
                          child: Padding(
                            padding: const EdgeInsets.only(bottom: 12.0),
                            child: customShadowContainer(
                                margin: 0,
                                backColor: Colors.grey.withOpacity(0.4),
                                child: Stack(
                                  children: [
                                    Column(
                                      children: [
                                        SizedBox(
                                            height: 150,
                                            width: screenWidth(),
                                            child: ClipRRect(
                                              borderRadius:
                                                  BorderRadius.circular(20),
                                              child: CachedNetworkImage(
                                                imageUrl: state
                                                        .responseTrainingList!
                                                        .data![index]
                                                        .image ??
                                                    '',
                                                fit: BoxFit.fitWidth,
                                                errorWidget: (_, __, ___) {
                                                  return Image.asset(
                                                    Images.cowBig,
                                                    fit: BoxFit.cover,
                                                  );
                                                },
                                              ),
                                            )),
                                        Padding(
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
                                                    state.responseTrainingList!
                                                            .data![index].title ??
                                                        '',
                                                    style: figtreeMedium
                                                        .copyWith(fontSize: 18),
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
                                                mainAxisAlignment: MainAxisAlignment.start,
                                                children: [
                                                  Text(
                                                    '${getAge(DateTime.parse(state.responseTrainingList!.data![index].validFrom.toString()))} ago',
                                                    style: figtreeMedium
                                                        .copyWith(fontSize: 12),
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
                          ),
                        ),
                      ],
                    );
                  }),
            ),
          )
        : const SizedBox.shrink();
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

  func() {
    String? videoId = YoutubePlayer.convertUrlToId(widget.url);
    controller = YoutubePlayerController(
      initialVideoId: videoId ?? '',
      flags: const YoutubePlayerFlags(
        autoPlay: true,
        mute: true,
      ),
    );

    if(videoId == null) {

      Future.delayed(Duration(seconds: 2), () {
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