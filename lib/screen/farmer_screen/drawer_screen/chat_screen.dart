import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:glad/screen/custom_widget/custom_methods.dart';
import 'package:glad/utils/color_resources.dart';
import 'package:glad/utils/extension.dart';
import 'package:glad/utils/helper.dart';
import 'package:glad/utils/images.dart';
import 'package:glad/utils/styles.dart';

class ChatScreen extends StatelessWidget {
  const ChatScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF9F9F9),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Padding(
            padding: EdgeInsets.only(top: getStatusBarHeight(context)),
            child: Container(
              height: AppBar().preferredSize.height,
              width: screenWidth(),
              padding: const EdgeInsets.symmetric(horizontal: 8),
              decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: const BorderRadius.only(
                      bottomLeft: Radius.circular(24),
                      bottomRight: Radius.circular(24)),
                  border: Border.all(color: ColorResources.grey)),
              child: Row(
                children: [
                  arrowBackButton(),
                  14.horizontalSpace(),
                  Image.asset(Images.sampleUser),
                  10.horizontalSpace(),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text('Dam Constructions',
                          style: figtreeMedium.copyWith(
                              fontSize: 18, color: Colors.black)),
                      Text('Begumanya Charles',
                          style: figtreeRegular.copyWith(
                              fontSize: 12, color: ColorResources.fieldGrey)),
                    ],
                  ),
                ],
              ),
            ),
          ),
          Expanded(
              child: SingleChildScrollView(
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                    Stack(
                      children: [
                        Container(
                          padding: const EdgeInsets.all(20),
                          decoration: const BoxDecoration(
                              color: Colors.white,
                              borderRadius:
                              BorderRadius.only(
                                  bottomRight:
                                  Radius.circular(24),
                                  topRight:
                                  Radius.circular(24),
                                  bottomLeft:
                                  Radius.circular(24))),
                          constraints: BoxConstraints(maxWidth: screenWidth() * 0.7),
                          child: Column(
                            crossAxisAlignment:
                            CrossAxisAlignment.start,
                            children: [
                              Text('Begumanya Charles (Farmer)',
                                  style: figtreeSemiBold
                                      .copyWith(
                                      fontSize: 10,
                                      color: ColorResources.maroon)),
                              4.verticalSpace(),
                              Text('Hi Charles, what is the status of my loan application?',
                                  style: figtreeMedium
                                      .copyWith(
                                      fontSize: 16,
                                      color: ColorResources.black),softWrap: true, ),
                            ],
                          ),
                        ),
                        Positioned(
                          bottom: 10,
                          right: 10,
                          child: Text('09:32 PM',
                              style:
                              figtreeRegular.copyWith(
                                  fontSize: 10,
                                  color: ColorResources
                                      .black)),
                        ),
                      ],
                    ),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Stack(
                    children: [
                      Container(
                        padding: const EdgeInsets.all(20),
                        decoration: const BoxDecoration(
                            color: ColorResources.maroon,
                            borderRadius:
                            BorderRadius.only(
                                topLeft:
                                Radius.circular(24),
                                topRight:
                                Radius.circular(24),
                                bottomLeft:
                                Radius.circular(24))),
                        constraints: BoxConstraints(maxWidth: screenWidth() * 0.7),
                        child: Text('Thanks for your response!',
                          style: figtreeMedium
                              .copyWith(
                              fontSize: 16,
                              color: ColorResources.white),softWrap: true, ),
                      ),
                      Positioned(
                        bottom: 10,
                        right: 10,
                        child: Text('09:32 PM',
                            style:
                            figtreeRegular.copyWith(
                                fontSize: 10,
                                color: ColorResources
                                    .white)),
                      ),
                    ],
                  ),
                ],
              ),
            ],
          ),
                  ))),
          Container(
            height: AppBar().preferredSize.height * 1.5,
            width: screenWidth(),
            padding: const EdgeInsets.symmetric(horizontal: 16),
            decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(24),
                    topRight: Radius.circular(24)),
                border: Border.all(color: ColorResources.grey)),
            child: Row(
              children: [
                const Expanded(
                    child: TextField(
                  decoration: InputDecoration(
                      border: InputBorder.none,
                      focusedBorder: InputBorder.none,
                      enabledBorder: InputBorder.none,
                      hintText: 'Message...'),
                )),
                SvgPicture.asset(
                  Images.attachment,
                  colorFilter: const ColorFilter.mode(
                      ColorResources.fieldGrey, BlendMode.srcIn),
                ),
                10.horizontalSpace(),
                SvgPicture.asset(
                  Images.camera,
                  colorFilter: const ColorFilter.mode(
                      ColorResources.fieldGrey, BlendMode.srcIn),
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}
