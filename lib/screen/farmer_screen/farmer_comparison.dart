import 'package:flutter/material.dart';
import 'package:glad/screen/custom_widget/custom_appbar.dart';
import 'package:glad/screen/custom_widget/custom_methods.dart';
import 'package:glad/utils/color_resources.dart';
import 'package:glad/utils/extension.dart';
import 'package:glad/utils/styles.dart';

class FarmerComparison extends StatelessWidget {
  const FarmerComparison({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          CustomAppBar(
            centerTitle: true,
            context: context,
            titleText1: 'Farmer comparison',
            leading: arrowBackButton(),
          ),
          farmerSummary(),
        ],
      ),
    );
  }

  Widget farmerSummary() {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          width: 100,
          height: 400,
          decoration: const BoxDecoration(
              color: ColorResources.mustard,
              borderRadius: BorderRadius.only(
                  topRight: Radius.circular(20),
                  bottomRight: Radius.circular(20))),
          child: Column(
            children: [
              20.verticalSpace(),
              SizedBox(
                width: 60,
                height: 80,
                child: Center(
                  child: Text(
                    "Farmer's summary",
                    style: figtreeSemiBold.copyWith(fontSize: 14),
                  ),
                ),
              ),
              40.verticalSpace(),
              SizedBox(
                width: 60,
                height: 70,
                child: Center(
                  child: Text(
                    "Farm Size",
                    style: figtreeSemiBold.copyWith(fontSize: 14),
                  ),
                ),
              ),
              SizedBox(
                width: 60,
                height:30,
                child: Center(
                  child: Text(
                    "Dairy Area",
                    style: figtreeSemiBold.copyWith(fontSize: 14),
                  ),
                ),
              ),
              20.verticalSpace(),
              SizedBox(
                width: 60,
                height:30,
                child: Text(
                  "Breeds",
                  style: figtreeSemiBold.copyWith(fontSize: 14),
                ),
              ),
              10.verticalSpace(),
              SizedBox(
                width: 60,
                height:30,
                child: Text(
                  "Herd\nsize",
                  style: figtreeSemiBold.copyWith(fontSize: 14),
                ),
              ),
              20.verticalSpace(),
              SizedBox(
                width: 80,
                height:30,
                child: Center(
                  child: Text(
                    "Milk\nProduction",
                    style: figtreeSemiBold.copyWith(fontSize: 14),
                  ),
                ),
              ),
            ],
          ),
        ),
        10.horizontalSpace(),
        Container(
          height: 400,
          width: 150,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(14),
              border: Border.all(width: 1, color: ColorResources.grey)),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              30.verticalSpace(),
              SizedBox(
                height: 100,
                child: Center(
                  child: Column(
                    children: [
                      Text(
                        'Hurton Elizabeth',
                        style: figtreeMedium.copyWith(fontSize: 16),
                      ),
                      5.verticalSpace(),
                      Text(
                        'Kampala,Kampala',
                        style: figtreeRegular.copyWith(
                            fontSize: 12, color: ColorResources.fieldGrey),
                      ),
                      Text(
                        'Exp. 2.5 yrs',
                        style: figtreeSemiBold.copyWith(
                            fontSize: 12, color: ColorResources.maroon),
                      ),
                      10.verticalSpace(),
                      RichText(
                          text: TextSpan(children: [
                        TextSpan(
                            text: 'Milking Cows:',
                            style: figtreeRegular.copyWith(
                                color: ColorResources.fieldGrey, fontSize: 12)),
                        TextSpan(
                            text: ' 30',
                            style: figtreeSemiBold.copyWith(
                                color: Colors.black, fontSize: 12))
                      ])),
                      5.verticalSpace(),
                      RichText(
                          text: TextSpan(children: [
                        TextSpan(
                            text: 'Yield:',
                            style: figtreeRegular.copyWith(
                                color: ColorResources.fieldGrey, fontSize: 12)),
                        TextSpan(
                            text: ' 08 Ltr.',
                            style: figtreeSemiBold.copyWith(
                                color: Colors.black, fontSize: 12))
                      ])),
                    ],
                  ),
                ),
              ),
              Divider(),
              Padding(
                padding: const EdgeInsets.only(left:10.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                  20.verticalSpace(),
                  SizedBox(
                    height:50,
                    child: Text(
                      "150 Acres",
                      style: figtreeSemiBold.copyWith(fontSize: 14),
                    ),
                  ),
                  SizedBox(
                    height:40,
                    child: Text(
                      "80 Acres",
                      style: figtreeSemiBold.copyWith(fontSize: 14),
                    ),
                  ),
                  SizedBox(
                    height: 50,
                    child: Text(
                      "Ankole, Friesian,\nJersey",
                      style: figtreeSemiBold.copyWith(fontSize: 14),
                    ),
                  ),
                  SizedBox(
                    height:50,
                    child: Text(
                      "30",
                      style: figtreeSemiBold.copyWith(fontSize: 14),
                    ),
                  ),
                  SizedBox(
                    child: Text(
                      "2000 Ltr/day",
                      style: figtreeSemiBold.copyWith(fontSize: 14),
                    ),
                  ),
                ],),
              )


            ],
          ),
        )
      ],
    );
  }
}
