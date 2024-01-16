import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:glad/screen/custom_widget/custom_methods.dart';
import 'package:glad/screen/dde_screen/preview_screen.dart';
import 'package:glad/utils/color_resources.dart';
import 'package:glad/utils/extension.dart';
import 'package:glad/utils/styles.dart';
import 'package:intl/intl.dart';

class MessageBubble extends StatelessWidget {

  MessageBubble(
      this.message,
      this.username,
      this.createdAt,
      this.userType,
      this.isMe,
      this.messageType,
      this.file,
      {super.key});

  final String message;
  final String createdAt;
  final String userType;
  final String isMe;
  final String username;
  final String messageType;
  final String file;

  @override
  Widget build(BuildContext context) {
   print(isMe);
    return Stack(
      children:[
        userType == isMe?
        Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Stack(
              children: [
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 25,vertical: 20),
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
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      messageType == 'text'?
                      Text(message,
                        style: figtreeMedium
                            .copyWith(
                            fontSize: 16,
                            color: ColorResources.white),softWrap: true, ):
                      InkWell(
                        onTap: (){
                          PreviewScreen(previewImage:file).navigate();
                        },
                        child: networkImage(text: file,height: 220,width: screenWidth()),
                      ),

                      Text(createdAt.toString(),
                          style:
                          figtreeRegular.copyWith(
                              fontSize: 10,
                              color: ColorResources
                                  .white))
                    ],
                  ),
                ),
              ],
            ),
          ],
        ):
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
                      Text('$username ${!userType.isAlphabetOnly ? '' : '($userType)'}',
                          style: figtreeSemiBold
                              .copyWith(
                              fontSize: 10,
                              color: ColorResources.maroon)),
                      4.verticalSpace(),
                      messageType == 'text'?
                      Text(message.toString(),
                        style: figtreeMedium
                            .copyWith(
                            fontSize: 16,
                            color: ColorResources.black),softWrap: true, ):
                      InkWell(
                        onTap: (){
                          PreviewScreen(previewImage:file).navigate();
                        },
                        child: networkImage(text: file,height: 220,width: screenWidth()),
                      )

                    ],
                  ),
                ),
                Positioned(
                  bottom: 10,
                  right: 10,
                  child: Text(createdAt.toString(),
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
      ]
    );
  }
}