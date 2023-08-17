import 'package:flutter/material.dart';
import 'package:glad/screen/custom_widget/custom_appbar.dart';
import 'package:glad/screen/custom_widget/custom_methods.dart';
import 'package:glad/utils/extension.dart';
import 'package:glad/utils/styles.dart';

import 'application_widget.dart';

class ApplicationScreen extends StatelessWidget {
  const ApplicationScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        landingBackground(),
        Column(
          children: [
            CustomAppBar(
              context: context,
              titleText1: 'Loan Applications',
              titleText1Style: figtreeMedium.copyWith(
                  fontSize: 20, color: Colors.black),
              centerTitle: true,
              leading: arrowBackButton(),
            ),
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    20.verticalSpace(),
                    customList(child: (index){
                      return const Padding(
                        padding: EdgeInsets.only(right: 20.0,left: 10),
                        child: MCCApplicationScreen(bottom: 25,),
                      );}),
                    100.verticalSpace(),
                  ],
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }
}
