import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:glad/screen/custom_widget/custom_methods.dart';
import 'package:glad/screen/supplier_screen/dashboard/dashboard_supplier.dart';
import 'package:glad/utils/color_resources.dart';
import 'package:glad/utils/extension.dart';
import 'package:glad/utils/images.dart';
import 'package:glad/utils/styles.dart';
import '../../data/model/farmer_project_detail_model.dart';

class SurveyFinishedScreen extends StatelessWidget {
  const SurveyFinishedScreen({super.key,required this.farmerProjectSurvey});
  final FarmerProject farmerProjectSurvey;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Stack(
        children: [
          Positioned(left: 80, child: SvgPicture.asset(Images.addRemark1)),
          Positioned(
              bottom: 0, right: 0, child: SvgPicture.asset(Images.otpBack1)),
          Padding(
            padding: const EdgeInsets.only(top: 80, right: 20, left: 20),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    SvgPicture.asset(Images.addRemark),
                  ],
                ),
                SvgPicture.asset(
                  Images.done,
                  height: 78,
                  width: 78,
                ),
                'Thank you!'
                    .textMedium(fontSize: 30, color: ColorResources.black),
                10.verticalSpace(),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 35),
                  child: 'Survey has been completed successfully.'
                      .textRegular(
                          fontSize: 16,
                          color: Colors.black,
                          textAlign: TextAlign.center),
                ),
                30.verticalSpace(),
                Container(
                  width: screenWidth(),
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(16),
                      border: Border.all(color: ColorResources.grey)),
                  child: Padding(
                    padding: const EdgeInsets.all(15),
                    child: Column(
                      children: [
                        Container(
                          width: screenWidth(),
                          padding: const EdgeInsets.symmetric(
                              vertical: 8, horizontal: 14),
                          decoration: BoxDecoration(
                              color: const Color(0xFFFFF3F4),
                              borderRadius: BorderRadius.circular(10)),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                farmerProjectSurvey.name??"",
                                style: figtreeMedium.copyWith(fontSize: 16),
                              ),
                              Text(
                                farmerProjectSurvey.category??"",
                                style: figtreeRegular.copyWith(
                                    fontSize: 12, color: const Color(0xFF808080)),
                              ),
                            ],
                          ),
                        ),
                        10.verticalSpace(),
                        farmerProjectSurvey.farmerMaster!=null?
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Image.asset(Images.sampleUser),
                            15.horizontalSpace(),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(farmerProjectSurvey.farmerMaster!.name??"",
                                    style: figtreeMedium.copyWith(
                                        fontSize: 16, color: Colors.black)),
                                10.verticalSpace(),
                                Row(
                                  crossAxisAlignment: CrossAxisAlignment.end,
                                  children: [
                                    const Icon(
                                      Icons.call,
                                      color: Colors.black,
                                      size: 16,
                                    ),
                                    Text('+256 ${farmerProjectSurvey.farmerMaster!.phone??""}',
                                        style: figtreeRegular.copyWith(
                                            fontSize: 12, color: Colors.black)),
                                  ],
                                ),
                                4.verticalSpace(),
                                Row(
                                  crossAxisAlignment: CrossAxisAlignment.end,
                                  children: [
                                    const Icon(
                                      Icons.location_on,
                                      color: Colors.black,
                                      size: 16,
                                    ),
                                    SizedBox(
                                      width: MediaQuery.of(context).size.width *
                                          0.5,
                                      child: Text(
                                        farmerProjectSurvey.farmerMaster!.address!=null?farmerProjectSurvey.farmerMaster!.address!.address.toString():"",
                                        style: figtreeRegular.copyWith(
                                          fontSize: 12,
                                          color: Colors.black,
                                          overflow: TextOverflow.ellipsis,
                                        ),
                                      ),
                                    ),
                                  ],
                                )
                              ],
                            )
                          ],
                        ):const SizedBox.shrink(),
                      ],
                    ),
                  ),
                ),
                40.verticalSpace(),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 35),
                  child: 'You can track the status of your application from surveys section.'
                      .textRegular(
                          fontSize: 16,
                          color: Colors.black,
                          textAlign: TextAlign.center),
                ),
                40.verticalSpace(),
                customButton("Go to Home",
                    fontColor: 0xffffffff, onTap: () {
                      const DashboardSupplier().navigate();
                    })
              ],
            ),
          )
        ],
      ),
    );
  }
}
