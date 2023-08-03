import 'package:flutter/material.dart';
import 'package:glad/screen/common/community_forum.dart';
import 'package:glad/screen/common/featured_trainings.dart';
import 'package:glad/screen/common/landing_carousel.dart';
import 'package:glad/screen/common/trending_news.dart';
import 'package:glad/screen/custom_widget/custom_methods.dart';
import 'package:glad/screen/supplier_screen/profile/service_provider_profile.dart';
import 'package:glad/utils/color_resources.dart';
import 'package:glad/utils/extension.dart';
import 'package:glad/utils/helper.dart';
import 'package:glad/utils/styles.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

import 'package:glad/screen/supplier_screen/dashboard/dashboard_supplier.dart';

class SupplierLandingPage extends StatelessWidget {
  SupplierLandingPage({super.key});

  List<_ChartData> data = [
    _ChartData('Completed', 12),
    _ChartData('Pending', 6),
  ];

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      child: Stack(
        children: [
          landingBackground(),
          Padding(
            padding: EdgeInsets.only(top: appBarHeight()),
            child: Column(
              children: [
                customAppBar('Hello ', ' Hurton,', onTapDrawer: () {
                  landingKey.currentState?.openDrawer();
                }, onTapProfile: () {
                  const ServiceProvider().navigate();
                }, drawerVisibility: true),
                landingPage(),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget landingPage() {
    return Expanded(
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const LandingCarousel(),
            20.verticalSpace(),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Row(
                children: [
                  Expanded(
                    child: customShadowContainer(
                      child: Stack(
                        children: [
                          SfCircularChart(
                              title: ChartTitle(
                                  text: 'Surveys',
                                  textStyle:
                                      figtreeMedium.copyWith(fontSize: 16)),
                              palette: [
                                ColorResources.maroon,
                                ColorResources.fieldGrey
                              ],
                              centerY: '40%',
                              series: <CircularSeries<_ChartData, String>>[
                                DoughnutSeries<_ChartData, String>(
                                    dataSource: data,
                                    xValueMapper: (_ChartData data, _) =>
                                        data.x,
                                    yValueMapper: (_ChartData data, _) =>
                                        data.y,
                                    radius: '50',
                                    innerRadius: '30')
                              ]),
                          Positioned(
                              bottom: 15,
                              right: 20,
                              left: 20,
                              child: Column(
                                children: [
                                  Row(
                                    children: [
                                      Container(
                                        height: 13,
                                        width: 9,
                                        decoration: BoxDecoration(
                                            color: ColorResources.maroon,
                                            borderRadius:
                                                BorderRadius.circular(10)),
                                      ),
                                      5.horizontalSpace(),
                                      Text('${data[0].x}: ',
                                          style: figtreeRegular.copyWith(
                                              fontSize: 12)),
                                      Text(data[0].y.toInt().toString(),
                                          style: figtreeBold.copyWith(
                                              fontSize: 12)),
                                    ],
                                  ),
                                  5.verticalSpace(),
                                  Row(
                                    children: [
                                      Container(
                                        height: 13,
                                        width: 9,
                                        decoration: BoxDecoration(
                                            color: ColorResources.fieldGrey,
                                            borderRadius:
                                                BorderRadius.circular(10)),
                                      ),
                                      5.horizontalSpace(),
                                      Text('${data[1].x}: ',
                                          style: figtreeRegular.copyWith(
                                              fontSize: 12)),
                                      Text(data[1].y.toInt().toString(),
                                          style: figtreeBold.copyWith(
                                              fontSize: 12)),
                                    ],
                                  )
                                ],
                              ))
                        ],
                      ),
                    ),
                  ),
                  10.horizontalSpace(),
                  Expanded(
                    child: customShadowContainer(
                      child: Stack(
                        children: [
                          SfCircularChart(
                              title: ChartTitle(
                                  text: 'Projects',
                                  textStyle:
                                      figtreeMedium.copyWith(fontSize: 16)),
                              palette: [
                                ColorResources.maroon,
                                ColorResources.fieldGrey
                              ],
                              centerY: '40%',
                              series: <CircularSeries<_ChartData, String>>[
                                DoughnutSeries<_ChartData, String>(
                                    dataSource: data,
                                    xValueMapper: (_ChartData data, _) =>
                                        data.x,
                                    yValueMapper: (_ChartData data, _) =>
                                        data.y,
                                    radius: '50',
                                    innerRadius: '30')
                              ]),
                          Positioned(
                              bottom: 15,
                              right: 20,
                              left: 20,
                              child: Column(
                                children: [
                                  Row(
                                    children: [
                                      Container(
                                        height: 13,
                                        width: 9,
                                        decoration: BoxDecoration(
                                            color: ColorResources.maroon,
                                            borderRadius:
                                                BorderRadius.circular(10)),
                                      ),
                                      5.horizontalSpace(),
                                      Text('${data[0].x}: ',
                                          style: figtreeRegular.copyWith(
                                              fontSize: 12)),
                                      Text(data[0].y.toInt().toString(),
                                          style: figtreeBold.copyWith(
                                              fontSize: 12)),
                                    ],
                                  ),
                                  5.verticalSpace(),
                                  Row(
                                    children: [
                                      Container(
                                        height: 13,
                                        width: 9,
                                        decoration: BoxDecoration(
                                            color: ColorResources.fieldGrey,
                                            borderRadius:
                                                BorderRadius.circular(10)),
                                      ),
                                      5.horizontalSpace(),
                                      Text('${data[1].x}: ',
                                          style: figtreeRegular.copyWith(
                                              fontSize: 12)),
                                      Text(data[1].y.toInt().toString(),
                                          style: figtreeBold.copyWith(
                                              fontSize: 12)),
                                    ],
                                  )
                                ],
                              ))
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
            // SfCartesianChart(
            //     primaryXAxis: DateTimeAxis(),
            //     series: <ChartSeries>[
            //       // Renders line chart
            //       LineSeries<SalesData, DateTime>(
            //           dataSource: chartData,
            //           xValueMapper: (SalesData sales, _) => sales.year,
            //           yValueMapper: (SalesData sales, _) => sales.sales
            //       )
            //     ]
            // )
            10.verticalSpace(),
            const CommunityForum(
              name: 'Begumanya Charles',
              location: 'Kampala, Uganda',
              image: '',
              caption:
                  'Lorem Ipsum has been the industry\'s standard dummy text ever since the 1500s, when an unknown printer took a galley.',
              video: '',
              timeAgo: '5 Hrs ago',
            ),
            10.verticalSpace(),
            const FeaturedTrainings(),
            10.verticalSpace(),
            const TrendingNewsAndEvents(),
            100.verticalSpace(),
          ],
        ),
      ),
    );
  }
}

class _ChartData {
  _ChartData(this.x, this.y);

  final String x;
  final double y;
}
