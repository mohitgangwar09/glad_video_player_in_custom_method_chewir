import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:glad/screen/custom_widget/custom_appbar.dart';
import 'package:glad/screen/custom_widget/custom_methods.dart';
import 'package:glad/utils/color_resources.dart';
import 'package:glad/utils/extension.dart';
import 'package:glad/utils/images.dart';
import 'package:glad/utils/styles.dart';

class FarmerNotification extends StatelessWidget {
  const FarmerNotification({super.key});

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
                titleText1: "Notifications",
                action: Padding(
                  padding: const EdgeInsets.fromLTRB(0, 20, 10, 0),
                  child: Text(
                    'Mark all as read',
                    style: figtreeMedium.copyWith(
                        fontSize: 14, color: ColorResources.maroon),
                  ),
                ),
                leading: Padding(
                  padding: const EdgeInsets.only(left: 8.0),
                  child: InkWell(
                      onTap: () {}, child: SvgPicture.asset(Images.arrowBack)),
                ),
                centerTitle: false,
              ),
              notification()
            ],
          )
        ],
      ),
    );
  }

  //////////Notification//////////////
  Widget notification() {
    return customList(
        list: [1, 2, 3, 4],
        child: (index) {
          return Container(
            margin: EdgeInsets.fromLTRB(10,10,10,5),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(14),
              border: Border.all(
                color: ColorResources.mustard,
                width: 1,
              ),
            ),
            child: Row(
              children: [
                Container(
                  width: 8,
                  height: 95,
                  decoration: const BoxDecoration(
                      color: ColorResources.mustard,
                      borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(18),
                          bottomLeft: Radius.circular(18))),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 18.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'Farmer Sam Huel sent you a message',
                            maxLines: 4,
                            style: figtreeMedium.copyWith(fontSize: 14),
                          ),
                          SvgPicture.asset(Images.farmerNotification),
                        ],
                      ),
                      10.verticalSpace(),
                      Row(
                        children: [
                          Text(
                            '04k views',
                            style: figtreeMedium.copyWith(
                                fontSize: 14, color: ColorResources.fieldGrey),
                          ),
                          8.horizontalSpace(),
                          Container(
                            height: 5,
                            width: 5,
                            decoration: const BoxDecoration(
                                color: Colors.black, shape: BoxShape.circle),
                          ),
                          8.horizontalSpace(),
                          Text(
                            'Farmer',
                            style: figtreeMedium.copyWith(
                                fontSize: 14, color: ColorResources.fieldGrey),
                          ),
                          8.horizontalSpace(),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          );
        });
  }
}
