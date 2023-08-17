import 'package:flutter/material.dart';
import 'package:glad/screen/custom_widget/custom_appbar.dart';
import 'package:glad/screen/custom_widget/custom_dropdown.dart';
import 'package:glad/screen/custom_widget/custom_methods.dart';
import 'package:glad/screen/custom_widget/custom_textfield.dart';
import 'package:glad/utils/color_resources.dart';
import 'package:glad/utils/extension.dart';
import 'package:glad/utils/images.dart';
import 'package:glad/utils/styles.dart';

class FilterSurvey extends StatelessWidget {
  const FilterSurvey({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CustomAppBar(
            context: context,
            centerTitle: true,
            titleText1: 'Filters',
            titleText1Style:
                figtreeMedium.copyWith(fontSize: 20, color: Colors.black),
            leading: TextButton(
                onPressed: () {
                  pressBack();
                },
                child: "Cancel"
                    .textMedium(color: ColorResources.maroon, fontSize: 12)),
            action: TextButton(
                onPressed: () {},
                child: "Reset"
                    .textMedium(color: ColorResources.maroon, fontSize: 12)),
          ),
          Expanded(
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.only(left: 18.0, right: 18, top: 31),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        "Farmer".textMedium(fontSize: 18),
                      ],
                    ),
                    10.verticalSpace(),
                    CustomDropdown(
                      dropdownValue: null,
                      itemList: [' ', ' '],
                      onChanged: (String) {},
                      hint: 'Select Farmer',
                      icon: Images.arrowDropdown,
                      iconColor: Colors.black,
                      hintStyle: figtreeMedium.copyWith(color: Colors.grey, fontSize: 18),
                    ),
                    33.verticalSpace(),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        "Project".textMedium(fontSize: 18),
                      ],
                    ),
                    10.verticalSpace(),
                    CustomDropdown(
                      dropdownValue: null,
                      itemList: [' ', ' '],
                      onChanged: (String) {},
                      hint: 'Select Project',
                      icon: Images.arrowDropdown,
                      iconColor: Colors.black,
                      hintStyle: figtreeMedium.copyWith(color: Colors.grey, fontSize: 18),
                    ),
                    33.verticalSpace(),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        "Project value".textMedium(fontSize: 18),
                        "Amount in UGX".textSemiBold(
                            fontSize: 12, color: const Color(0xff727272))
                      ],
                    ),

                    customProjectContainer(
                        marginLeft: 0,
                        marginTop: 8,
                        height: 124,
                        child: Row(
                          children: [
                            31.horizontalSpace(),
                            Expanded(
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  "From".textSemiBold(
                                    fontSize: 14,
                                  ),
                                  Container(
                                      margin: const EdgeInsets.only(top: 5),
                                      padding: const EdgeInsets.only(left: 10),
                                      decoration: boxDecoration(
                                          borderRadius: 10,
                                          borderColor: const Color(0xff767676)),
                                      height: 50,
                                      child: const TextField(
                                        decoration: InputDecoration(
                                            border: InputBorder.none),
                                      ))
                                ],
                              ),
                            ),
                            18.horizontalSpace(),
                            Expanded(
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  "Upto".textSemiBold(
                                    fontSize: 14,
                                  ),
                                  Container(
                                      padding: const EdgeInsets.only(left: 10),
                                      margin: const EdgeInsets.only(top: 5),
                                      decoration: boxDecoration(
                                          borderRadius: 10,
                                          borderColor: const Color(0xff767676)),
                                      height: 50,
                                      child: const TextField(
                                        decoration: InputDecoration(
                                            border: InputBorder.none),
                                      ))
                                ],
                              ),
                            ),
                            31.horizontalSpace(),
                          ],
                        )),
                    33.verticalSpace(),

                    "Project status".textMedium(fontSize: 18),

                    15.verticalSpace(),

                    Wrap(
                      children: [
                        "Applied",
                        "Processing",
                        "Survey Completed",
                        'Verified',
                        'Approved'
                      ]
                          .map((item) => Container(
                              margin: 5.marginAll(),
                              padding: const EdgeInsets.only(
                                  left: 14, right: 14, bottom: 10, top: 10),
                              decoration: boxDecoration(
                                  borderColor: const Color(0xffDCDCDC),
                                  borderRadius: 30),
                              child: Text(item)))
                          .toList()
                          .cast<Widget>(),
                    ),

                    33.verticalSpace(),

                    "Improvement areas".textMedium(fontSize: 18),

                    15.verticalSpace(),

                    Wrap(
                      children: [
                        "Water Management",
                        "pasture & Fodder",
                        "Medicine & Vaccination",
                      ]
                          .map((item) => Container(
                              margin: 5.marginAll(),
                              padding: const EdgeInsets.only(
                                  left: 14, right: 14, bottom: 10, top: 10),
                              decoration: boxDecoration(
                                  borderColor: const Color(0xffDCDCDC),
                                  borderRadius: 30),
                              child: Text(item)))
                          .toList()
                          .cast<Widget>(),
                    ),

                    33.verticalSpace(),

                    10.verticalSpace(),

                    Container(
                        margin: 20.marginAll(),
                        height: 55,
                        width: screenWidth(),
                        child: customButton("Apply",
                            fontColor: 0xffffffff, onTap: () {}))

                    // ,10.verticalSpace(),
                  ],
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
