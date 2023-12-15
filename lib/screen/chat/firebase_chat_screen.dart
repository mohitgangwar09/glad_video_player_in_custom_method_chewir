import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:glad/data/model/response_project_data_firebase.dart';
import 'package:glad/screen/chat/messages.dart';
import 'package:glad/screen/chat/new_messages.dart';
import 'package:glad/screen/custom_widget/custom_methods.dart';
import 'package:glad/utils/color_resources.dart';
import 'package:glad/utils/extension.dart';
import 'package:glad/utils/helper.dart';
import 'package:glad/utils/images.dart';
import 'package:glad/utils/styles.dart';

class FirebaseChatScreen extends StatelessWidget {
  const FirebaseChatScreen({super.key,required this.responseProjectDataForFirebase});

  final ResponseProjectDataForFirebase responseProjectDataForFirebase;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      top: false,
      bottom: true,
      child: Scaffold(
        backgroundColor: const Color(0xffF9F9F9),
        appBar: PreferredSize(
          preferredSize: Size(screenWidth(),100),
          child: Padding(
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
                      Text(responseProjectDataForFirebase.projectName.toString(),
                          style: figtreeMedium.copyWith(
                              fontSize: 18, color: Colors.black)),
                      Text(responseProjectDataForFirebase.farmerName.toString(),
                          style: figtreeRegular.copyWith(
                              fontSize: 12, color: ColorResources.fieldGrey)),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
        body: SizedBox(
          child: Column(
            children: <Widget>[

              Expanded(child: Messages(responseProjectDataForFirebase: responseProjectDataForFirebase,)),

              NewMessage(responseProjectDataForFirebase: responseProjectDataForFirebase,)

        ],),),
      ),
    );
  }
}