import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:glad/screen/custom_widget/custom_appbar.dart';
import 'package:glad/screen/custom_widget/custom_methods.dart';
import 'package:glad/utils/extension.dart';
import 'package:glad/utils/images.dart';
import 'package:glad/utils/styles.dart';

class OnlineTraining extends StatelessWidget {
  const OnlineTraining({super.key});

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
                titleText1: 'Online trainings',
                leading: arrowBackButton(),
                centerTitle: true,
                titleText1Style:
                    figtreeMedium.copyWith(fontSize: 20, color: Colors.black),
              ),
              fourOptions(),
              imageWithDetails()
            ],
          )
        ],
      ),
    );
  }

////////////FourOptions///////////////
  Widget fourOptions() {
    return SizedBox(
      height: 45,
      child: customList(
          list: [1, 2, 3, 4],
          axis: Axis.horizontal,
          child: (index) {
            return Container(
                margin: 5.marginAll(),
                padding: const EdgeInsets.only(
                    left: 14, right: 14, bottom: 10, top: 10),
                decoration: boxDecoration(
                    borderColor: const Color(0xffDCDCDC), borderRadius: 30),
                child: const Text("Trending"));
          }),
    );
  }

  //////ImageWithDetails////////////////
  Widget imageWithDetails() {
    return Expanded(
      child: SingleChildScrollView(
        child: customList(
            padding: const EdgeInsets.fromLTRB(13, 13, 13, 120),
            list: [1, 2, 3, 4, 5, 6, 7],
            child: (index) {
              return Padding(
                padding: const EdgeInsets.only(bottom: 12.0),
                child: customShadowContainer(
                  margin: 0,
                  backColor: Colors.grey.withOpacity(0.4),
                  child: Column(
                    children: [
                      Stack(
                        children: [
                          Container(
                            height:150,
                            decoration:  BoxDecoration(
                              image: const DecorationImage(
                                fit: BoxFit.cover,
                                image: AssetImage(Images.cowBig),
                              ),
                              borderRadius: BorderRadius.circular(20)
                            ),
                          ),
                        ],
                      ),

                    ],
                  )
                ),
              );
            }),
      ),
    );
  }
}
