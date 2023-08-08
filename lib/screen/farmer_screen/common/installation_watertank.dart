import 'package:flutter/material.dart';
import 'package:glad/screen/custom_widget/custom_methods.dart';
import 'package:glad/utils/color_resources.dart';
import 'package:glad/utils/extension.dart';
import 'package:glad/utils/styles.dart';

class InstallationOfWaterTank extends StatelessWidget {
  const InstallationOfWaterTank({super.key});

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
                Stack(
                  alignment: Alignment.centerLeft,
                  children: [
                    Center(
                      child: Text(
                        'Installation of water tank...',
                        style: figtreeMedium.copyWith(fontSize: 22),
                      ),
                    ),
                    Positioned(
                        child: IconButton(
                            onPressed: () {
                              Navigator.pop(context);
                            },
                            icon: const Icon(Icons.arrow_back))),
                  ],
                ),
                Expanded(
                    child: SingleChildScrollView(
                        child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    description(),
                    dividerValue(),
                    attributes(),
                    mileStoneDeliverable(),
                  ],
                )))
              ],
            ),
          )
        ],
      ),
    );
  }

  ///////DescriptionDetails///////////
  Widget description() {
    return Padding(
      padding: const EdgeInsets.fromLTRB(24, 20, 24, 0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Description',
            style: figtreeMedium.copyWith(fontSize: 18),
          ),
          05.horizontalSpace(),
          10.verticalSpace(),
          Text(
            "Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries dummy text ever since the 1500s.",
            style: figtreeMedium.copyWith(fontSize: 14),
          )
        ],
      ),
    );
  }

///////DividerValue///////////
  Widget dividerValue() {
    return Padding(
      padding: const EdgeInsets.fromLTRB(24, 0, 24, 0),
      child: Column(
        children: [
          30.verticalSpace(),
          const Divider(
            thickness: 1,
          ),
          10.verticalSpace(),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Value',
                style: figtreeMedium.copyWith(fontSize: 14),
              ),
              Text(
                'Duration',
                style: figtreeMedium.copyWith(fontSize: 14),
              ),
            ],
          ),
          05.verticalSpace(),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'UGX 700K',
                style: figtreeSemiBold.copyWith(
                    fontSize: 16, color: ColorResources.maroon),
              ),
              Text(
                '12 days',
                style: figtreeSemiBold.copyWith(fontSize: 16),
              ),
            ],
          ),
          10.verticalSpace(),
          const Divider(
            thickness: 1,
          ),
        ],
      ),
    );
  }

  ////////Attributes///////////
  Widget attributes() {
    return Column(
      children: [
        20.verticalSpace(),
        Padding(
          padding: const EdgeInsets.fromLTRB(24, 0, 24, 0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Attributes',
                style: figtreeMedium.copyWith(fontSize: 18),
              ),
              05.horizontalSpace(),
              Container(
                padding:
                    const EdgeInsets.symmetric(vertical: 8, horizontal: 15),
                decoration: boxDecoration(
                  backgroundColor: ColorResources.white,
                  borderWidth: 1,
                  borderRadius: 160,
                  borderColor: const Color(0xff6A0030),
                ),
                child: Text(
                  "Edit",
                  textAlign: TextAlign.center,
                  style: figtreeMedium.copyWith(
                      color: const Color(0xff6A0030), fontSize: 10),
                ),
              )
            ],
          ),
        ),
        20.verticalSpace(),
        Padding(
          padding: const EdgeInsets.fromLTRB(15, 0, 15, 0),
          child: customShadowContainer(
              backColor: ColorResources.grey,
              child: Padding(
                padding: const EdgeInsets.fromLTRB(20, 18, 20, 0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    customAttribute("Type", "Plastic"),
                    10.verticalSpace(),
                    customAttribute("Size/capacity", "5000Ltr"),
                    10.verticalSpace(),
                    customAttribute("Quantity", "02 NOS"),
                    10.verticalSpace(),
                    customAttribute("Price", "UGX 100K"),
                    40.verticalSpace(),
                  ],
                ),
              )),
        )
      ],
    );
  }

  ////////Milestone Deliverable//////////////
  Widget mileStoneDeliverable() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        30.verticalSpace(),
        Text(
          'Milestone deliverables',
          style: figtreeMedium.copyWith(fontSize: 18),
        ),
        customList(child: (int index) {
          return Padding(
            padding: const EdgeInsets.fromLTRB(20, 0, 20, 0),
            child: Container(
              decoration: BoxDecoration(
                  color: Colors.white,
                  border: Border.all(width: 1, color: ColorResources.grey),
                  borderRadius: BorderRadius.circular(14)),
              height: 80,
            ),
          );
        })
      ],
    );
  }

  Widget customAttribute(String attributeName, String attributeData) {
    return Container(
      height: 32,
      padding: const EdgeInsets.only(left: 20, right: 20),
      decoration: BoxDecoration(
          color: ColorResources.containerColor,
          borderRadius: BorderRadius.circular(06)),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            child: Text(
              attributeName,
              style: figtreeMedium.copyWith(fontSize: 14),
            ),
          ),
          Expanded(
            child: Text(
              attributeData,
              style: figtreeMedium.copyWith(fontSize: 14),
            ),
          ),
        ],
      ),
    );
  }
}
