import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:glad/cubit/community_cubit/community_cubit.dart';
import 'package:glad/screen/custom_widget/container_border.dart';
import 'package:glad/screen/custom_widget/custom_appbar.dart';
import 'package:glad/screen/custom_widget/custom_methods.dart';
import 'package:glad/screen/custom_widget/custom_textfield2.dart';
import 'package:glad/utils/color_resources.dart';
import 'package:glad/utils/extension.dart';
import 'package:glad/utils/helper.dart';
import 'package:glad/utils/images.dart';
import 'package:glad/utils/styles.dart';
import 'package:path_provider/path_provider.dart';
import 'package:video_thumbnail/video_thumbnail.dart';

class CommunityPostAdd extends StatefulWidget {
  const CommunityPostAdd({super.key});

  @override
  State<CommunityPostAdd> createState() => _CommunityPostAddState();
}

class _CommunityPostAddState extends State<CommunityPostAdd> {
  TextEditingController description = TextEditingController();
  String? type;
  String? path;
  String? videoThumbnail;

  getThumbnail(String path) async {
    final x = await VideoThumbnail.thumbnailFile(
        video: path,
        thumbnailPath: (await getTemporaryDirectory()).path,
        imageFormat: ImageFormat.JPEG,
        quality: 100);
    setState(() {
      videoThumbnail = x!;
    });
  }

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
                titleText1: 'Add New Post',
                titleText1Style:
                figtreeMedium.copyWith(fontSize: 20, color: Colors.black),
                centerTitle: true,
                leading: arrowBackButton(),
              ),
              listviewDetails(),
            ],
          ),
        ],
      ),
    );
  }

  Widget listviewDetails() {
    return Expanded(
      child: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            children: [
              20.verticalSpace(),
              CustomTextField2(
                title: 'What do you want to talk about...',
                hint: 'Write..',
                maxLine: 7,
                minLine: 7,
                height: null,
                controller: description,
              ),
              20.verticalSpace(),
              Visibility(
                  visible: path == null,
                child: Row(
                  children: [
                    5.horizontalSpace(),
                    'Add Photo/Video'.textMedium(color: Colors.black, fontSize: 12),
                  ],
                ),
              ),
              5.verticalSpace(),
              // Visibility(
              //   visible: path == null,
              //   child: Stack(
              //     children: [
              //       ContainerBorder(
              //         margin: 0.marginVertical(),
              //         padding:
              //         10.paddingOnly(top: 15, bottom: 15),
              //         borderColor: 0xffD9D9D9,
              //         backColor: 0xffFFFFFF,
              //         radius: 10,
              //         widget: Row(
              //           mainAxisAlignment:
              //           MainAxisAlignment.center,
              //           crossAxisAlignment:
              //           CrossAxisAlignment.center,
              //           children: [
              //             5.horizontalSpace(),
              //             Expanded(
              //               child: Padding(
              //                 padding: const EdgeInsets.only(
              //                     left: 10.0, top: 2, bottom: 2),
              //                 child: Column(
              //                   crossAxisAlignment:
              //                   CrossAxisAlignment.start,
              //                   children: [
              //                     RichText(
              //                         text: TextSpan(children: [
              //                           TextSpan(
              //                               text: 'Choose ',
              //                               style: figtreeMedium
              //                                   .copyWith(
              //                                   fontSize: 16,
              //                                   color: const Color(
              //                                       0xFFFC5E60))),
              //                           TextSpan(
              //                               text: 'you file here',
              //                               style: figtreeMedium
              //                                   .copyWith(
              //                                   fontSize: 16,
              //                                   color:
              //                                   ColorResources
              //                                       .fieldGrey))
              //                         ])),
              //                     Text('Max size 5 MB',
              //                         style:
              //                         figtreeMedium.copyWith(
              //                             fontSize: 12,
              //                             color:
              //                             ColorResources
              //                                 .fieldGrey))
              //                   ],
              //                 ),
              //               ),
              //             ),
              //           ],
              //         ),
              //       ),
              //       Positioned(
              //         right: 13,
              //         top: 0,
              //         bottom: 0,
              //         child: Row(
              //           children: [
              //             InkWell(
              //               onTap: () async {
              //                   path = await imgFromGallery();
              //                   setState(() {});
              //               },
              //               child: SvgPicture.asset(
              //                 Images.attachment,
              //                 colorFilter: const ColorFilter.mode(
              //                     ColorResources.fieldGrey,
              //                     BlendMode.srcIn),
              //               ),
              //             ),
              //               Row(children: [
              //                 10.horizontalSpace(),
              //                 InkWell(
              //                   onTap: () async{
              //                     path = await imgFromCamera();
              //                     setState(() {});
              //                   },
              //                   child: SvgPicture.asset(
              //                     Images.camera,
              //                     colorFilter: const ColorFilter.mode(
              //                         ColorResources.fieldGrey,
              //                         BlendMode.srcIn),
              //                   ),
              //                 )
              //               ],),
              //           ],
              //         ),
              //       ),
              //     ],
              //   ),
              // ),
              Visibility(
                visible: path == null,
                child: InkWell(
                  onTap: () async{
                    showTestimonialPicker(context, videoFunction: () async {
                      type = 'video';
                      path = await videoFromGallery(memoryValidation: true, context: context);
                      if(path == '') {
                        return;
                      }
                      await getThumbnail(path!);
                      setState(() {});
                      pressBack();
                    }, photoFunction: () async {
                      path = await imgFromGallery();
                      type = 'image';
                      setState(() {});
                      pressBack();
                    });
                  },
                  child: Stack(
                    children: [
                      ContainerBorder(
                        margin: 0.marginVertical(),
                        padding: 10.paddingOnly(top: 15, bottom: 15),
                        borderColor: 0xffD9D9D9,
                        backColor: 0xffFFFFFF,
                        radius: 10,
                        widget: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            5.horizontalSpace(),
                            Expanded(
                              child: Padding(
                                padding: const EdgeInsets.only(
                                    left: 10.0, top: 2, bottom: 2),
                                child: Column(
                                  crossAxisAlignment:
                                  CrossAxisAlignment.start,
                                  children: [
                                    RichText(
                                        text: TextSpan(children: [
                                          TextSpan(
                                              text: 'Upload ',
                                              style: figtreeMedium.copyWith(
                                                  fontSize: 16,
                                                  color:
                                                  const Color(0xFFFC5E60))),
                                          TextSpan(
                                              text: 'video/photo here',
                                              style: figtreeMedium.copyWith(
                                                  fontSize: 16,
                                                  color: ColorResources
                                                      .fieldGrey))
                                        ])),
                                    Text('Max size 20 MB',
                                        style: figtreeMedium.copyWith(
                                            fontSize: 12,
                                            color: ColorResources
                                                .fieldGrey))
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      Positioned(
                        right: 13,
                        top: 0,
                        bottom: 0,
                        child: Row(
                          children: [
                            SvgPicture.asset(
                              Images.attachment,
                              colorFilter: const ColorFilter.mode(
                                  ColorResources.fieldGrey,
                                  BlendMode.srcIn),
                            ),
                            10.horizontalSpace(),
                            SvgPicture.asset(
                              Images.camera,
                              colorFilter: const ColorFilter.mode(
                                  ColorResources.fieldGrey,
                                  BlendMode.srcIn),
                            )
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              20.verticalSpace(),
              // path != null ?
              // Stack(
              //   children: [
              //     ClipRRect(
              //         borderRadius: BorderRadius.circular(20),
              //         child: Image.file(File(path!), fit: BoxFit.fitWidth, width: screenWidth(), height: 200,)),
              //     Positioned(
              //       right: 5,
              //       top: 5,
              //       child: InkWell(
              //         onTap: () {
              //           setState(() {
              //             path = null;
              //           });
              //         },
              //         child: Container(
              //           decoration: BoxDecoration(
              //               borderRadius: BorderRadius.circular(200),
              //               color: Colors.white),
              //           child: SvgPicture.asset(
              //             Images.cancelImage,
              //           ),
              //         ),
              //       ),
              //     ),
              //   ],
              // ) : const SizedBox.shrink(),
              path != null || videoThumbnail != null ?
              Stack(
                children: [
                  ClipRRect(
                      borderRadius: BorderRadius.circular(20),
                      child: Image.file(File(type == 'image' ?path! : videoThumbnail!), fit: BoxFit.fitWidth, width: screenWidth(), height: 200,)),
                  Positioned(
                    right: 5,
                    top: 5,
                    child: InkWell(
                      onTap: () {
                        setState(() {
                          path = null;
                          type = null;
                          videoThumbnail = null;
                        });
                      },
                      child: Container(
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(200),
                            color: Colors.white),
                        child: SvgPicture.asset(
                          Images.cancelImage,
                        ),
                      ),
                    ),
                  ),
                ],
              ) : const SizedBox.shrink(),
              40.verticalSpace(),
              customButton('Post', onTap: (){
                  if(description.text.isEmpty) {
                    showCustomToast(context, 'Description required');
                  } else if(path == null) {
                    showCustomToast(context, 'Video/Image is required');
                  } else {
                    context.read<CommunityCubit>()
                        .addPostApi(context, description.text, path!, type!);
                  }
              }, fontColor: 0xFFFFFFFF, width: screenWidth(), height: 60)
            ],
          ),
        ),
      ),
    );
  }
}
