import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:glad/screen/custom_widget/custom_methods.dart';
import 'package:glad/utils/color_resources.dart';
import 'package:glad/utils/extension.dart';
import 'package:glad/utils/helper.dart';
import 'package:glad/utils/images.dart';
import 'package:glad/utils/styles.dart';

class CommunityPostDetail extends StatelessWidget {
  const CommunityPostDetail({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Padding(
            padding: EdgeInsets.only(top: getStatusBarHeight(context)),
            child: Container(
              height: AppBar().preferredSize.height,
              width: screenWidth(),
              padding: const EdgeInsets.symmetric(horizontal: 8),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      arrowBackButton(),
                      14.horizontalSpace(),
                      Image.asset(Images.sampleUser),
                      10.horizontalSpace(),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text('Begumanya Charles',
                              style: figtreeMedium.copyWith(
                                  fontSize: 18, color: Colors.black)),
                          Row(
                            children: [
                              Text('Kampala, Uganda',
                                  style: figtreeRegular.copyWith(
                                      fontSize: 12, color: Colors.black)),
                              10.horizontalSpace(),
                              Text('5 Hrs ago',
                                  style: figtreeMedium.copyWith(
                                      fontSize: 12, color: Colors.black)),
                            ],
                          ),
                        ],
                      ),
                    ],
                  ),
                  SvgPicture.asset(Images.chat),
                ],
              ),
            ),
          ),
          listviewDetails(),
          Container(
            height: AppBar().preferredSize.height * 1.4,
            width: screenWidth(),
            color: ColorResources.maroon,
            padding: const EdgeInsets.symmetric(horizontal: 40),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    SvgPicture.asset(Images.likeButton, color: Colors.white,),
                    4.horizontalSpace(),
                    Text(
                      'Like',
                      style: figtreeRegular.copyWith(
                          fontSize: 14,
                          color: Colors.white),
                      softWrap: true,
                    ),
                  ],
                ),
                Row(
                  children: [
                    SvgPicture.asset(Images.commentButton, color: Colors.white,),
                    4.horizontalSpace(),
                    Text(
                      'Comment',
                      style: figtreeRegular.copyWith(
                          fontSize: 14,
                          color: Colors.white),
                      softWrap: true,
                    ),
                  ],
                ),
                Row(
                  children: [
                    const Icon(
                      Icons.share_outlined,
                      color: Colors.white,
                      size: 19,
                    ),
                    4.horizontalSpace(),
                    Text(
                      'Share',
                      style: figtreeRegular.copyWith(
                          fontSize: 14,
                          color: Colors.white),
                      softWrap: true,
                    ),
                  ],
                ),

              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget listviewDetails() {
    return Expanded(
      child: SingleChildScrollView(
        child: Column(
          children: [
            20.verticalSpace(),
            Stack(
              children: [
                Image.asset(
                  Images.sampleVideo,
                  width: screenWidth(),
                  fit: BoxFit.cover,
                ),
                Positioned(
                  right: 10,
                    top: 10,
                    child: customButton(
                  'Add as Friend',
                  onTap: () {},
                  width: 110,
                  height: 30,
                      style: figtreeMedium.copyWith(color: Colors.white, fontSize: 12)
                ))
              ],
            ),
            20.verticalSpace(),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child:
                  """Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley.Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley.Lorem Ipsum has been the industry's.Standard dummy text ever since the 1500s, when an unknown printer took a galley."""
                      .textRegular(fontSize: 16, color: Colors.black),
            )
          ],
        ),
      ),
    );
  }
}
