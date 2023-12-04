import 'dart:async';

import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:glad/cubit/community_cubit/community_cubit.dart';
import 'package:glad/data/model/dashboard_community.dart';
import 'package:glad/screen/common/community_post_detail.dart';
import 'package:glad/screen/custom_widget/community_widget.dart';
import 'package:glad/screen/custom_widget/show_all_button.dart';
import 'package:glad/utils/color_resources.dart';
import 'package:glad/utils/extension.dart';
import 'package:glad/utils/helper.dart';
import 'package:glad/utils/styles.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class CommunityForum extends StatefulWidget {
  const CommunityForum(
      {super.key,
      required this.onTapShowAll});

  final Function() onTapShowAll;

  @override
  State<CommunityForum> createState() => _CommunityForumState();
}

class _CommunityForumState extends State<CommunityForum> {
  int activeIndex = 0;
  late ScrollController controller;

  late Timer _timer;
  @override
  void initState() {
    super.initState();
    BlocProvider.of<CommunityCubit>(context).communityListApi(context);
    controller = PageController();
    _timer = Timer.periodic(const Duration(seconds: 5), (Timer timer) {
      if (activeIndex < 2) {
        activeIndex++;
      } else {
        activeIndex = 0;
      }
      /*controller.animateTo(
        // activeIndex,
        duration: const Duration(milliseconds: 350),
        curve: Curves.easeIn,
      );*/
    });
  }

  @override
  void dispose() {
    super.dispose();
    controller.dispose();
    _timer.cancel();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CommunityCubit, CommunityCubitState>(
      builder: (context, state) {
      if (state.status == CommunityStatus.submit) {
        return const SizedBox.shrink();
      } else if (state.responseCommunityList == null) {
        return const SizedBox.shrink();
      } else {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(20, 10, 20, 2),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text('Community Forum',
                      style: figtreeMedium.copyWith(
                          fontSize: 18, color: Colors.black)),
                  ShowAllButton(onTap: widget.onTapShowAll)
                ],
              ),
            ),
            10.verticalSpace(),
            CarouselSlider(
                items: List.generate(5, (index) =>
                    CommunityWidget(
                      name: state.responseCommunityList!.data![index].user!.name ?? '',
                      location: state.responseCommunityList!.data![index].user!.address != null
                          ? state.responseCommunityList!.data![index].user!.address!.address != null
                          &&
                          state.responseCommunityList!.data![index].user!.address!.subCounty != null
                          ? state.responseCommunityList!.data![index].user!.address!.subCounty! +
                          state.responseCommunityList!.data![index].user!.address!.address!
                          : ''
                          : '',
                      image: state.responseCommunityList!.data![index].user!.profilePic ?? '',
                      caption: state.responseCommunityList!.data![index].remark ?? '',
                      video: state.responseCommunityList!.data![index].communityDocumentFiles![0]
                          .originalUrl ?? '',
                      timeAgo: getPostAge(
                          DateTime.parse(state.responseCommunityList!.data![index].createdAt ?? '')),
                      likeCount: state.responseCommunityList!.data![index].communityLikesCount ?? 0,
                      commentCount: state.responseCommunityList!.data![index].communityCommentsCount,
                      isLiked: state.responseCommunityList!.data![index].isLiked ?? 0,
                      id: state.responseCommunityList!.data![index].id,
                      onTap: () {
                        CommunityPostDetail(id: state.responseCommunityList!.data![index].id.toString()).navigate();
                      },
                      index: index,
                      fromHome: true,)),
                options: CarouselOptions(
                  // autoPlay: true,
                  clipBehavior: Clip.none,
                  enableInfiniteScroll: false,
                  viewportFraction: 1,
                  height: deviceSize(),
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
    );
  }
}
