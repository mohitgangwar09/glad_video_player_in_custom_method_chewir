import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:glad/screen/custom_widget/custom_appbar.dart';
import 'package:glad/screen/custom_widget/custom_methods.dart';
import 'package:glad/utils/color_resources.dart';
import 'package:glad/utils/extension.dart';
import 'package:glad/utils/images.dart';
import 'package:glad/utils/styles.dart';

class FarmerStatement extends StatelessWidget {
  const FarmerStatement({super.key});

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
                titleText1: 'Loan statement',
                titleText1Style: figtreeMedium.copyWith(
                    fontSize: 20, color: Colors.black),
                centerTitle: true,
                leading: openDrawer(
                    onTap: () {}, child: SvgPicture.asset(Images.drawer)),
                action: InkWell(
                    onTap: () {}, child: SvgPicture.asset(Images.filter2)),
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
        child: Column(
          children: [
            20.verticalSpace(),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                for (int i in [1, 2, 3])
                  Container(
                    margin: i == 3
                        ? const EdgeInsets.only(right: 12)
                        : i==1 ? const EdgeInsets.only(left: 12) : null,
                    padding: EdgeInsets.symmetric(vertical: 20, horizontal: 10),
                    decoration: BoxDecoration(
                        color: Colors.white,
                        border: Border.all(
                            width: 1, color: ColorResources.paidGreen),
                        borderRadius: BorderRadius.circular(20)),
                    child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            'UGX 400K',
                            style: figtreeSemiBold.copyWith(fontSize: 18),
                          ),
                          05.verticalSpace(),
                          Text(
                            'Paid',
                            style: figtreeMedium.copyWith(
                                fontSize: 14, color: ColorResources.fieldGrey),
                          )
                        ]),
                  ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(18, 18, 18, 0),
              child: Column(
                children: [
                  Container(
                    decoration: BoxDecoration(
                        border:
                            Border.all(width: 1, color: ColorResources.grey),
                        borderRadius: BorderRadius.circular(20),
                        color: Colors.white),
                    child: ListView.separated(
                        shrinkWrap: true,
                        padding: 0.paddingAll(),
                        physics: const BouncingScrollPhysics(),
                        itemBuilder: (context, index) {
                          final color = index % 2 == 0
                              ? Colors.white
                              : ColorResources.pinkMain;
                          return Container(
                            color: color,
                            margin: const EdgeInsets.only(left: 20, right: 20),
                            padding: const EdgeInsets.fromLTRB(10, 15, 10, 15),
                            child: Column(
                              children: [
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Expanded(
                                      child: Text(
                                        'Dam construction',
                                        maxLines: 1,
                                        overflow: TextOverflow.ellipsis,
                                        style: figtreeMedium.copyWith(
                                            fontSize: 16),
                                      ),
                                    ),
                                    Text(
                                      'UGX 100K',
                                      style: figtreeSemiBold.copyWith(
                                          fontSize: 18),
                                    ),
                                  ],
                                ),
                                5.verticalSpace(),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      '01/04/2023',
                                      style:
                                          figtreeMedium.copyWith(fontSize: 12),
                                    ),
                                    Text(
                                      'Paid',
                                      style: figtreeMedium.copyWith(
                                          fontSize: 12,
                                          color: ColorResources.paidGreenText),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          );
                        },
                        separatorBuilder: (context, index) {
                          return Padding(
                            padding: const EdgeInsets.fromLTRB(20, 0, 20, 0),
                            child: SizedBox(
                                height: 0, width: 30, child: horizontalPaint()),
                          );
                        },
                        itemCount: 8),
                  ),
                ],
              ),
            ),
            100.verticalSpace(),
          ],
        ),
      ),
    );
  }
}
