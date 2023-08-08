import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:glad/screen/custom_widget/custom_appbar.dart';
import 'package:glad/screen/custom_widget/custom_methods.dart';
import 'package:glad/screen/custom_widget/custom_textfield.dart';
import 'package:glad/screen/farmer_screen/common/widegt/project_widget.dart';
import 'package:glad/screen/farmer_screen/dashboard/dashboard_farmer.dart';
import 'package:glad/utils/extension.dart';
import 'package:glad/utils/helper.dart';
import 'package:glad/utils/images.dart';
import 'package:glad/utils/styles.dart';

class FarmerDdeTabScreen extends StatelessWidget {
  const FarmerDdeTabScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        landingBackground(),
        hideKeyboard(
          context,
          child: Column(
            children: [
              CustomAppBar(
                context: context,
                richTitle: false,
                titleText1: "Farmers",
                action: Row(
                  children: [
                    InkWell(
                        onTap: () {}, child: SvgPicture.asset(Images.filter2)),
                    13.horizontalSpace(),
                    InkWell(
                        onTap: () {}, child: SvgPicture.asset(Images.filter1)),
                    18.horizontalSpace(),
                  ],
                ),
                leading: openDrawer(
                    onTap: () {
                      // onTapDrawer();
                    },
                    child: SvgPicture.asset(Images.drawer)),
                centerTitle: true,
              ),
              Container(
                margin: const EdgeInsets.only(
                    left: 20, right: 20, bottom: 13, top: 23),
                height: 50,
                decoration: boxDecoration(
                    borderColor: Colors.grey,
                    borderRadius: 62,
                    backgroundColor: Colors.white),
                width: screenWidth(),
                child: Row(
                  children: [
                    13.horizontalSpace(),
                    SvgPicture.asset(Images.searchLeft),
                    13.horizontalSpace(),
                    const Expanded(
                        child: TextField(
                      decoration: InputDecoration(
                          border: InputBorder.none, hintText: "Search"),
                    )),
                  ],
                ),
              ),
              Container(
                margin: const EdgeInsets.only(
                    left: 18, right: 7, bottom: 20, top: 10),
                height: 36,
                child: customList(
                    axis: Axis.horizontal,
                    child: (int index) {
                      return Container(
                        margin: const EdgeInsets.only(right: 12, left: 0),
                        padding: const EdgeInsets.only(left: 10, right: 10),
                        decoration: boxDecoration(
                            borderColor: const Color(0xffDCDCDC),
                            borderWidth: 1.1,
                            borderRadius: 62,
                            backgroundColor: Colors.white),
                        child: Row(
                          children: [
                            "Critical".textMedium(fontSize: 14),
                            6.horizontalSpace(),
                            "04".textSemiBold(
                                fontSize: 12, color: const Color(0xffFC5E60)),
                          ],
                        ),
                      );
                    }),
              ),
              Expanded(
                child: SingleChildScrollView(
                  padding: const EdgeInsets.only(bottom: 120, left: 0),
                  child: customList(child: (int i) {
                    return Padding(
                      padding: const EdgeInsets.only(
                          left: 10, right: 20, bottom: 12),
                      child: Stack(
                        children: [
                          customProjectContainer(
                            child: Padding(
                              padding:
                                  const EdgeInsets.fromLTRB(15.0, 20, 0, 0),
                              child: Column(
                                children: [
                                  Row(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Image.asset(Images.sampleUser),
                                      15.horizontalSpace(),
                                      Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text("Matts Francesca",
                                              style: figtreeMedium.copyWith(
                                                  fontSize: 16,
                                                  color: Colors.black)),
                                          4.verticalSpace(),
                                          Row(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.end,
                                            children: [
                                              const Icon(
                                                Icons.call,
                                                color: Colors.black,
                                                size: 16,
                                              ),
                                              Text("+22112 3232 3223",
                                                  style:
                                                      figtreeRegular.copyWith(
                                                          fontSize: 12,
                                                          color: Colors.black)),
                                            ],
                                          ),
                                          4.verticalSpace(),
                                          Row(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.end,
                                            children: [
                                              const Icon(
                                                Icons.location_on,
                                                color: Colors.black,
                                                size: 16,
                                              ),
                                              SizedBox(
                                                width: MediaQuery.of(context)
                                                        .size
                                                        .width *
                                                    0.5,
                                                child: Text(
                                                  "Luwum St. Rwoozi, Kampala...",
                                                  style:
                                                      figtreeRegular.copyWith(
                                                    fontSize: 12,
                                                    color: Colors.black,
                                                    overflow:
                                                        TextOverflow.ellipsis,
                                                  ),
                                                ),
                                              ),
                                            ],
                                          )
                                        ],
                                      )
                                    ],
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(
                                        left: 12.0, right: 22, top: 18),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text.rich(
                                          TextSpan(
                                            children: [
                                              TextSpan(
                                                  text: 'Farm: ',
                                                  style:
                                                      figtreeRegular.copyWith(
                                                          color: const Color(
                                                              0xff808080),
                                                          fontSize: 12)),
                                              TextSpan(
                                                text: '50 Acres',
                                                style: figtreeRegular.copyWith(
                                                    fontSize: 12),
                                              ),
                                            ],
                                          ),
                                        ),
                                        Text.rich(
                                          TextSpan(
                                            children: [
                                              TextSpan(
                                                  text: 'Milking/Cows: ',
                                                  style:
                                                      figtreeRegular.copyWith(
                                                          color: const Color(
                                                              0xff808080),
                                                          fontSize: 12)),
                                              TextSpan(
                                                text: '50',
                                                style: figtreeRegular.copyWith(
                                                    fontSize: 12),
                                              ),
                                            ],
                                          ),
                                        ),
                                        Text.rich(
                                          TextSpan(
                                            children: [
                                              TextSpan(
                                                  text: 'Yield/Cow: ',
                                                  style:
                                                      figtreeRegular.copyWith(
                                                          color: const Color(
                                                              0xff808080),
                                                          fontSize: 12)),
                                              TextSpan(
                                                text: '50 ltr',
                                                style: figtreeRegular.copyWith(
                                                    fontSize: 12),
                                              ),
                                            ],
                                          ),
                                        )
                                      ],
                                    ),
                                  ),
                                  20.verticalSpace(),
                                  Container(
                                    height: 80,
                                    padding: 20.paddingHorizontal(),
                                    decoration: boxDecoration(
                                        backgroundColor:
                                            const Color(0xffFFF3F4),
                                        borderRadius: 10),
                                    child: Column(
                                      children: [
                                        Row(
                                          children: [
                                            "Dam Construction"
                                                .textMedium(fontSize: 12),
                                            Container(
                                              margin: 9.marginAll(),
                                              padding:
                                                  const EdgeInsets.symmetric(
                                                      vertical: 4,
                                                      horizontal: 7),
                                              decoration: boxDecoration(
                                                borderRadius: 30,
                                                borderColor:
                                                    const Color(0xff6A0030),
                                              ),
                                              child: Text(
                                                "Suggested",
                                                textAlign: TextAlign.center,
                                                style: figtreeMedium.copyWith(
                                                    color:
                                                        const Color(0xff6A0030),
                                                    fontSize: 10),
                                              ),
                                            ),
                                          ],
                                        ),
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Column(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                "UGX 3.2M".textSemiBold(
                                                    color: Colors.black,
                                                    fontSize: 16),
                                                "Investment".textMedium(
                                                    fontSize: 12,
                                                    color: const Color(
                                                        0xff808080)),
                                              ],
                                            ),
                                            Column(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                "UGX 4.5M".textSemiBold(
                                                    color: Colors.black,
                                                    fontSize: 16),
                                                "Revenue".textMedium(
                                                    fontSize: 12,
                                                    color: const Color(
                                                        0xff808080)),
                                              ],
                                            ),
                                            Column(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                "40%".textSemiBold(
                                                    color: Colors.black,
                                                    fontSize: 16),
                                                "ROI".textMedium(
                                                    fontSize: 12,
                                                    color: const Color(
                                                        0xff808080)),
                                              ],
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ),
                                  15.verticalSpace(),
                                  Container(
                                    width: 140,
                                    height: 3,
                                    decoration: boxDecoration(
                                        borderRadius: 10,
                                        backgroundColor: Colors.green),
                                  )
                                ],
                              ),
                            ),
                          ),
                          Positioned(
                              top: 0,
                              right: 0,
                              child: Row(
                                children: [
                                  SvgPicture.asset(Images.callPrimary),
                                  6.horizontalSpace(),
                                  SvgPicture.asset(Images.whatsapp),
                                  6.horizontalSpace(),
                                  SvgPicture.asset(Images.redirectLocation),
                                  4.horizontalSpace(),
                                ],
                              )),
                        ],
                      ),
                    );
                  }),
                ),
              )
            ],
          ),
        ),
      ],
    );
  }
}
