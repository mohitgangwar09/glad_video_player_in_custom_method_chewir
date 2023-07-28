import 'package:flutter/material.dart';
import 'package:glad/screen/custom_widget/custom_methods.dart';
import 'package:glad/utils/color_resources.dart';
import 'package:glad/utils/extension.dart';
import 'package:glad/utils/styles.dart';

import 'dashboard/dashboard_farmer.dart';

class FarmerStatement extends StatelessWidget {
  const FarmerStatement({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          landingBackground(),
          Padding(
            padding: const EdgeInsets.only(top: 40.0),
            child: Column(
              children: [
                customAppBar('Loan ', 'statement', onTapDrawer: () {
                  // farmerLandingKey.currentState?.openDrawer();
                }, onTapProfile: () {}, drawerVisibility: true),
                listviewDetails(),
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
            SizedBox(
              height: 106,
              child: customList(
                  axis: Axis.horizontal,
                  child: (int index) {
                    return Container(
                      width: 120,
                      margin: const EdgeInsets.all(12),
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
                                  fontSize: 14,
                                  color: ColorResources.fieldGrey),
                            )
                          ]),
                    );
                  }),
            ),
            Padding(
              padding: const EdgeInsets.all(18.0),
              child: Column(
                children: [
                  Container(
                    decoration: BoxDecoration(
                        border:
                            Border.all(width: 1, color: ColorResources.grey),
                        borderRadius: BorderRadius.circular(20),
                        color: Colors.white),
                    child: customList(
                      padding: const EdgeInsets.fromLTRB(31, 20, 31, 20),
                        child: (int index) {
                      return Column(
                        children: [
                          Row(
                            mainAxisAlignment:
                                MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                'Dam construction',
                                style: figtreeMedium.copyWith(fontSize: 16),
                              ),
                              Text(
                                'UGX 100K',
                                style:
                                    figtreeSemiBold.copyWith(fontSize: 18),
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
                                style: figtreeMedium.copyWith(fontSize: 12),
                              ),
                              Text(
                                'Paid',
                                style: figtreeMedium.copyWith(
                                    fontSize: 12,
                                    color: ColorResources.paidGreenText),
                              ),
                            ],
                          )
                        ],
                      );
                    }),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
