import 'dart:io';

import 'package:flutter/material.dart';
import 'package:glad/screen/custom_widget/custom_appbar.dart';
import 'package:glad/screen/custom_widget/custom_methods.dart';
import 'package:glad/utils/extension.dart';
import 'package:glad/utils/styles.dart';

class PreviewScreen extends StatelessWidget {
  final String previewImage;
  const PreviewScreen({Key? key,required this.previewImage}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [

          CustomAppBar(
            context: context,
            titleText1: '',
            titleText1Style:
            figtreeMedium.copyWith(fontSize: 20, color: Colors.black),
            centerTitle: true,
            leading: InkWell(onTap: ()async{
              pressBack();
            },child: const SizedBox(child: Icon(Icons.arrow_back))),
          ),

          Expanded(
            child: Padding(
              padding: const EdgeInsets.only(bottom: 40.0,left: 15,right: 15),
              child: isUrl(previewImage) ? networkImage(text: previewImage): Image.file(File(previewImage)),
            ),
          ),

        ],
      ),
    );
  }
}
