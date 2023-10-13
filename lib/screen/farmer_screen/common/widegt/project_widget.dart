import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:glad/screen/custom_widget/custom_methods.dart';
import 'package:glad/screen/farmer_screen/common/suggested_project_details.dart';
import 'package:glad/utils/extension.dart';
import 'package:glad/utils/images.dart';
import 'package:glad/utils/styles.dart';

class ProjectWidget extends StatelessWidget {
  final bool showStatus;
  final String name;
  final int targetYield;
  final int investment;
  final int revenue;
  final int index;
  final int incrementalProduction;
  final int roi;
  final String category;
  final String image;
  final String status;
  final int projectId;

  const ProjectWidget(
      {Key? key,
      required this.showStatus,
      required this.name,
      required this.targetYield,
      required this.investment,
      required this.revenue,
      required this.index,
      required this.incrementalProduction,
      required this.roi,
      required this.category,
      required this.image,
      required this.status,
      required this.projectId})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Padding(
          padding: const EdgeInsets.all(15.0),
          child: InkWell(
            onTap: () {
              SuggestedProjectDetails(projectId: projectId).navigate();
            },
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    CircleAvatar(
                        radius: 30,
                        child: CachedNetworkImage(
                          imageUrl: image,
                          errorWidget: (_, __, ___) {
                            return Image.asset(
                              Images.sampleUser,
                              fit: BoxFit.cover,
                              width: 80,
                              height: 80,
                            );
                          },
                          fit: BoxFit.cover,
                          width: 80,
                          height: 80,
                        )),
                    12.horizontalSpace(),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          name.textMedium(
                              fontSize: 18,
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis),
                          5.verticalSpace(),
                          category.textMedium(
                            fontSize: 12,
                          ),
                        ],
                      ),
                    ),
                  ],
                ),

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
                          "$targetYield Ltr./day"
                              .textSemiBold(color: Colors.black, fontSize: 16),
                          3.verticalSpace(),
                          "Target yield /cow"
                              .textRegular(fontSize: 12, color: Colors.black),
                        ],
                      ),
                      SizedBox(
                        height: 45,
                        child: customPaint(Colors.grey),
                      ),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          "$incrementalProduction Ltr./day"
                              .textSemiBold(color: Colors.black, fontSize: 16),
                          3.verticalSpace(),
                          "Incremental production"
                              .textRegular(fontSize: 12, color: Colors.black)
                        ],
                      ),
                    ],
                  ),
                ),

                10.verticalSpace(),

                Container(
                  margin: 4.marginTop(),
                  padding: 20.paddingHorizontal(),
                  decoration: boxDecoration(borderRadius: 10),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          getCurrencyString(investment).toString()
                              .textSemiBold(color: Colors.black, fontSize: 16),
                          "Investment".textMedium(fontSize: 12),
                        ],
                      ),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          getCurrencyString(revenue).toString()
                              .textSemiBold(color: Colors.black, fontSize: 16),
                          "Revenue"
                              .textMedium(fontSize: 12, color: Colors.black),
                        ],
                      ),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          "$roi%"
                              .textSemiBold(color: Colors.black, fontSize: 16),
                          "ROI".textMedium(
                            fontSize: 12,
                          ),
                        ],
                      ),
                    ],
                  ),
                ),

                // 30.verticalSpace()
              ],
            ),
          ),
        ),
        Visibility(
          visible: showStatus,
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
                status.toString(),
                textAlign: TextAlign.center,
                style: figtreeMedium.copyWith(
                    color: const Color(0xff6A0030), fontSize: 10),
              ),
            ),
          ),
        ),
        Visibility(
          visible: !showStatus,
          child: Align(
            alignment: Alignment.topRight,
            child: Container(
              padding: const EdgeInsets.all(16),
              decoration: const BoxDecoration(
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(30),
                      bottomLeft: Radius.circular(30),
                      topRight: Radius.circular(30)),
                  color: Color(0xFFE4FFE3)),
              child: Text(
                index.toString(),
                textAlign: TextAlign.center,
                style: figtreeMedium.copyWith(
                    color: const Color(0xff6A0030), fontSize: 16),
              ),
            ),
          ),
        )
      ],
    );
  }
}
