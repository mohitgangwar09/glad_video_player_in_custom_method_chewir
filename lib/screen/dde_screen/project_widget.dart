import 'package:flutter/material.dart';
import 'package:glad/screen/custom_widget/circular_percent_indicator.dart';
import 'package:glad/screen/custom_widget/custom_methods.dart';
import 'package:glad/screen/dde_screen/project_details.dart';
import 'package:glad/utils/extension.dart';
import 'package:glad/utils/images.dart';
import 'package:glad/utils/styles.dart';

class ProjectWidget extends StatelessWidget {
  final bool status;
  const ProjectWidget({Key? key, required this.status}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Padding(
          padding: const EdgeInsets.all(15.0),
          child: InkWell(
            onTap: () {
              const ProjectDetails().navigate();
            },
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                "Dam Construction".textMedium(
                  fontSize: 18,
                ),
                5.verticalSpace(),
                "Water Management"
                    .textMedium(fontSize: 12, color: const Color(0xFF808080)),
                10.verticalSpace(),
                "Construct a water tank and water trough in night paddock plus water pump"
                    .textMedium(
                        fontSize: 14, color: const Color(0xFF808080), maxLines: 2),
                15.verticalSpace(),
                Container(
                  height: 60,
                  padding: 20.paddingHorizontal(),
                  decoration: boxDecoration(
                      backgroundColor: const Color(0xffFFF3F4),
                      borderRadius: 10),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          "UGX 3.2M"
                              .textSemiBold(color: Colors.black, fontSize: 16),
                          "Investment".textMedium(
                              fontSize: 12, color: const Color(0xFF808080)),
                        ],
                      ),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          "UGX 4.5M"
                              .textSemiBold(color: Colors.black, fontSize: 16),
                          "Revenue".textMedium(
                              fontSize: 12, color: const Color(0xFF808080)),
                        ],
                      ),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          "40%".textSemiBold(color: Colors.black, fontSize: 16),
                          "ROI".textMedium(
                              fontSize: 12, color: const Color(0xFF808080)),
                        ],
                      ),
                    ],
                  ),
                ),
                20.verticalSpace(),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    RichText(
                        text: TextSpan(children: [
                      TextSpan(
                          text: 'Loan: ',
                          style: figtreeMedium.copyWith(
                              fontSize: 12, color: const Color(0xFF808080))),
                      TextSpan(
                          text: 'UGX 3.7M',
                          style: figtreeMedium.copyWith(
                              fontSize: 12, color: Colors.black))
                    ])),
                    RichText(
                        text: TextSpan(children: [
                      TextSpan(
                          text: 'EMI/Mo: ',
                          style: figtreeMedium.copyWith(
                              fontSize: 12, color: const Color(0xFF808080))),
                      TextSpan(
                          text: 'UGX 4.5K',
                          style: figtreeMedium.copyWith(
                              fontSize: 12, color: Colors.black))
                    ])),
                    RichText(
                        text: TextSpan(children: [
                      TextSpan(
                          text: 'Balance: ',
                          style: figtreeMedium.copyWith(
                              fontSize: 12, color: const Color(0xFF808080))),
                      TextSpan(
                          text: '40%',
                          style: figtreeMedium.copyWith(
                              fontSize: 12, color: Colors.black))
                    ])),
                  ],
                ),
                15.verticalSpace(),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      height: 70,
                      width: MediaQuery.of(context).size.width * 0.6,
                      padding: 15.paddingHorizontal(),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          CircleAvatar(
                            radius: 24,
                            child: Image.asset(
                              Images.sampleUser,
                              fit: BoxFit.cover,
                              width: 53,
                              height: 53,
                            ),
                          ),
                          10.horizontalSpace(),
                          Expanded(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                "Begumanya Charles".textMedium(
                                    color: Colors.black,
                                    fontSize: 14,
                                    maxLines: 1,
                                    overflow: TextOverflow.ellipsis),
                                1.verticalSpace(),
                                "+256 758711344".textRegular(
                                    fontSize: 12, color: Colors.black),
                                4.verticalSpace(),
                                "Luwum St. Rwoozi, Kampala...".textRegular(
                                    fontSize: 12,
                                    color: Colors.black,
                                    maxLines: 1,
                                    overflow: TextOverflow.ellipsis),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                    CircularPercentIndicator(
                      radius: 30,
                      percent: 0.25,
                      progressColor: const Color(0xFF12CE57),
                      backgroundColor: const Color(0xFFDCEAE5),
                      center: RichText(
                        text: TextSpan(children: [
                          TextSpan(
                              text: '25',
                              style: figtreeBold.copyWith(
                                  color: Colors.black, fontSize: 16)),
                          TextSpan(
                              text: '%\n',
                              style: figtreeBold.copyWith(
                                  color: Colors.black, fontSize: 9)),
                          TextSpan(
                              text: 'completed',
                              style: figtreeBold.copyWith(
                                  color: const Color(0xFF808080), fontSize: 6))
                        ]),
                        textAlign: TextAlign.center,
                      ),
                    ),
                    1.horizontalSpace()
                  ],
                ),
              ],
            ),
          ),
        ),
        Visibility(
          visible: status,
          child: Align(
            alignment: Alignment.topRight,
            child: Container(
              margin: 10.marginAll(),
              padding: const EdgeInsets.symmetric(vertical: 4, horizontal: 7),
              decoration: boxDecoration(
                borderRadius: 30,
                borderColor: const Color(0xff6A0030),
              ),
              child: Text(
                "Active",
                textAlign: TextAlign.center,
                style: figtreeMedium.copyWith(
                    color: const Color(0xff6A0030), fontSize: 10),
              ),
            ),
          ),
        )
      ],
    );
  }
}
