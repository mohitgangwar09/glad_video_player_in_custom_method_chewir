import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:glad/screen/common/community_forum.dart';
import 'package:glad/screen/common/featured_trainings.dart';
import 'package:glad/screen/common/landing_carousel.dart';
import 'package:glad/screen/common/trending_news.dart';
import 'package:glad/screen/custom_widget/custom_methods.dart';
import 'package:glad/screen/supplier_screen/profile/service_provider_profile.dart';
import 'package:glad/utils/color_resources.dart';
import 'package:glad/utils/extension.dart';
import 'package:glad/utils/helper.dart';
import 'package:glad/utils/images.dart';
import 'package:glad/utils/styles.dart';
import 'package:intl/intl.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

import 'package:glad/screen/supplier_screen/dashboard/dashboard_supplier.dart';

class SupplierLandingPage extends StatelessWidget {
  SupplierLandingPage({super.key});

  List<_ChartData> data = [
    _ChartData('Completed', 12),
    _ChartData('Pending', 6),
  ];

  List<_ChartData> data2 = [
    _ChartData('Completed', 07),
    _ChartData('Active', 15),
  ];

  final List<SalesData> chartData = [
    SalesData(DateTime(2022, 11), 2),
    SalesData(DateTime(2022, 12), 2.6),
    SalesData(DateTime(2023, 1), 2.7),
    SalesData(DateTime(2023, 2), 3),
    SalesData(DateTime(2023, 3), 3.4),
    SalesData(DateTime(2023, 4), 3.5)
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
              padding: const EdgeInsets.symmetric(horizontal: 20.0),
              child: Row(
                children: [
                  Expanded(
                    child: customShadowContainer(
                      margin: 0,
                      child: Stack(
                        children: [
                          Padding(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 10, vertical: 16),
                            child: Column(
                              children: [
                                Text('Surveys',
                                    style:
                                        figtreeMedium.copyWith(fontSize: 16)),
                                10.verticalSpace(),
                                Stack(
                                  alignment: Alignment.center,
                                  children: [
                                    SizedBox(
                                      height: 140,
                                      child: SfCircularChart(
                                          palette: const [
                                            ColorResources.maroon,
                                            ColorResources.fieldGrey
                                          ],
                                          margin: EdgeInsets.zero,
                                          // centerY: '40%',
                                          series: <CircularSeries<_ChartData,
                                              String>>[
                                            DoughnutSeries<_ChartData, String>(
                                                dataSource: data,
                                                xValueMapper:
                                                    (_ChartData data, _) =>
                                                        data.x,
                                                yValueMapper:
                                                    (_ChartData data, _) =>
                                                        data.y,
                                                radius: '60',
                                                innerRadius: '40')
                                          ]),
                                    ),
                                    Positioned(
                                        child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        "66".textBold(
                                            color: Colors.black, fontSize: 26),
                                        "%".textBold(
                                            color: Colors.black, fontSize: 12)
                                      ],
                                    )),
                                  ],
                                ),
                                10.verticalSpace(),
                                Padding(
                                  padding: const EdgeInsets.only(left: 25),
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
                                          7.horizontalSpace(),
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
                                          7.horizontalSpace(),
                                          Text('${data[1].x}: ',
                                              style: figtreeRegular.copyWith(
                                                  fontSize: 12)),
                                          Text(data[1].y.toInt().toString(),
                                              style: figtreeBold.copyWith(
                                                  fontSize: 12)),
                                        ],
                                      )
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Positioned(
                              right: 15,
                              top: 15,
                              child: SvgPicture.asset(Images.menuIcon))
                        ],
                      ),
                    ),
                  ),
                  10.horizontalSpace(),
                  Expanded(
                    child: customShadowContainer(
                      margin: 0,
                      child: Stack(
                        children: [
                          Padding(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 10, vertical: 16),
                            child: Column(
                              children: [
                                Text('Projects',
                                    style:
                                        figtreeMedium.copyWith(fontSize: 16)),
                                10.verticalSpace(),
                                Stack(
                                  alignment: Alignment.center,
                                  children: [
                                    SizedBox(
                                      height: 140,
                                      child: SfCircularChart(
                                          palette: const [
                                            ColorResources.maroon,
                                            ColorResources.mustard
                                          ],
                                          margin: EdgeInsets.zero,
                                          series: <CircularSeries<_ChartData,
                                              String>>[
                                            DoughnutSeries<_ChartData, String>(
                                                dataSource: data2,
                                                xValueMapper:
                                                    (_ChartData data, _) =>
                                                        data.x,
                                                yValueMapper:
                                                    (_ChartData data, _) =>
                                                        data.y,
                                                radius: '60',
                                                innerRadius: '40')
                                          ]),
                                    ),
                                    Positioned(
                                        child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        "33".textBold(
                                            color: Colors.black, fontSize: 26),
                                        "%".textBold(
                                            color: Colors.black, fontSize: 12)
                                      ],
                                    )),
                                  ],
                                ),
                                10.verticalSpace(),
                                Padding(
                                  padding: const EdgeInsets.only(left: 25),
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
                                          7.horizontalSpace(),
                                          Text('${data2[0].x}: ',
                                              style: figtreeRegular.copyWith(
                                                  fontSize: 12)),
                                          Text(data2[0].y.toInt().toString(),
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
                                                color: ColorResources.mustard,
                                                borderRadius:
                                                    BorderRadius.circular(10)),
                                          ),
                                          7.horizontalSpace(),
                                          Text('${data2[1].x}: ',
                                              style: figtreeRegular.copyWith(
                                                  fontSize: 12)),
                                          Text(data2[1].y.toInt().toString(),
                                              style: figtreeBold.copyWith(
                                                  fontSize: 12)),
                                        ],
                                      )
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Positioned(
                              right: 15,
                              top: 15,
                              child: SvgPicture.asset(Images.menuIcon))
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
            20.verticalSpace(),
            Padding(
              padding: const EdgeInsets.all(20),
              child: Stack(
                children: [
                  customShadowContainer(
                      child: Padding(
                    padding: const EdgeInsets.all(16),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        "Total Revenue"
                            .textMedium(fontSize: 14, color: Colors.black),
                        "UGX 3.4M".textBold(fontSize: 22, color: Colors.black),
                        20.verticalSpace(),
                        SfCartesianChart(
                          plotAreaBorderWidth: 0,
                          primaryXAxis: DateTimeAxis(
                              dateFormat: DateFormat('MMM, yy'),
                              labelStyle: figtreeRegular.copyWith(
                                  fontSize: 10, color: Colors.black),
                              majorGridLines: const MajorGridLines(width: 0),
                              maximumLabels: 6,
                              axisLine: const AxisLine(width: 0),
                              majorTickLines: const MajorTickLines(width: 0)),
                          primaryYAxis: NumericAxis(
                              interval: 1,
                              labelStyle: figtreeRegular.copyWith(
                                  fontSize: 10, color: Colors.black),
                              axisLine: const AxisLine(width: 0),
                              majorGridLines:
                                  const MajorGridLines(dashArray: [5, 5]),
                              majorTickLines: const MajorTickLines(width: 0),
                              labelFormat: '{value}M'),
                          series: <ChartSeries>[
                            AreaSeries<SalesData, DateTime>(
                              dataSource: chartData,
                              xValueMapper: (SalesData sales, _) => sales.year,
                              yValueMapper: (SalesData sales, _) => sales.sales,
                              // color: const Color(0xFFFC5E60),
                              borderGradient: const LinearGradient(
                                colors: <Color>[
                                  Color(0xFFFC5E60),
                                  Color(0xFFFC5E60),
                                ],
                              ),
                              borderWidth: 2,
                              markerSettings: const MarkerSettings(
                                  isVisible: true,
                                  height: 9,
                                  width: 9,
                                  color: ColorResources.maroon,
                                  borderColor: Colors.white),
                              gradient: LinearGradient(
                                colors: <Color>[
                                  const Color(0xFFFC5E60).withOpacity(0.12),
                                  const Color(0xFFFFFFFF).withOpacity(0.12)
                                ],
                                begin: Alignment.topCenter,
                                end: Alignment.bottomCenter,
                              ),
                            ),
                          ],
                          tooltipBehavior: TooltipBehavior(
                              enable: true,
                              color: ColorResources.maroon,
                              canShowMarker: false,
                              textStyle: figtreeMedium.copyWith(
                                  color: Colors.white, fontSize: 10),
                              header: '',
                              format: 'UGX point.y'),
                        ),
                      ],
                    ),
                  )),
                  Positioned(
                      right: 20,
                      top: 15,
                      child: SvgPicture.asset(Images.menuIcon))
                ],
              ),
            ),
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

class SalesData {
  SalesData(this.year, this.sales);
  final DateTime year;
  final double sales;
}
