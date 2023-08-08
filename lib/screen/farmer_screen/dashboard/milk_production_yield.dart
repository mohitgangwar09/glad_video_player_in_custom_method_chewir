import 'package:flutter/material.dart';
import 'package:glad/screen/custom_widget/custom_methods.dart';
import 'package:glad/utils/color_resources.dart';
import 'package:glad/utils/extension.dart';
import 'package:glad/utils/helper.dart';
import 'package:glad/utils/styles.dart';
import 'package:intl/intl.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

class MilkProductionYield extends StatefulWidget {
  const MilkProductionYield({super.key});

  @override
  State<MilkProductionYield> createState() => _MilkProductionYieldState();
}

class _MilkProductionYieldState extends State<MilkProductionYield> {
  List<SalesData> chartData = [
    SalesData(DateTime(2022, 11), 18),
    SalesData(DateTime(2022, 12), 20.5),
    SalesData(DateTime(2023, 1), 21),
    SalesData(DateTime(2023, 2), 22),
    SalesData(DateTime(2023, 3), 25),
    SalesData(DateTime(2023, 4), 28)
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            color: ColorResources.maroon,
            padding: EdgeInsets.only(top: getStatusBarHeight(context), bottom: 10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                arrowBackButton(color: Colors.white),
                Text(
                  'Milk production & yield',
                  style:
                      figtreeMedium.copyWith(fontSize: 20, color: Colors.white),
                ),
                const Text(''),
              ],
            ),
          ),
          Expanded(
            child: SingleChildScrollView(
              child: Column(
                children: [
                  Container(
                    decoration: const BoxDecoration(
                        color: ColorResources.maroon,
                        borderRadius:
                            BorderRadius.only(bottomLeft: Radius.circular(70))),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        // 10.verticalSpace(),
                        Text(
                          'Last 6 months',
                          style: figtreeRegular.copyWith(
                              fontSize: 14, color: Colors.white),
                        ),
                        10.verticalSpace(),
                        Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 8.0, vertical: 16),
                          child: SfCartesianChart(
                            plotAreaBorderWidth: 0,
                            primaryXAxis: DateTimeAxis(
                                dateFormat: DateFormat('MMM, yy'),
                                labelStyle: figtreeRegular.copyWith(
                                    fontSize: 10, color: Colors.white),
                                majorGridLines: const MajorGridLines(width: 0),
                                // maximumLabels: 6,
                                axisLine: const AxisLine(width: 0),
                                majorTickLines: const MajorTickLines(width: 0)),
                            primaryYAxis: NumericAxis(
                                interval: 10,
                                labelStyle: figtreeRegular.copyWith(
                                    fontSize: 10, color: Colors.white),
                                axisLine: const AxisLine(width: 0),
                                majorGridLines:
                                    const MajorGridLines(dashArray: [5, 5]),
                                majorTickLines: const MajorTickLines(width: 0),
                                labelFormat: '{value}Ltr.'),
                            series: <ChartSeries>[
                              AreaSeries<SalesData, DateTime>(
                                dataSource: chartData,
                                xValueMapper: (SalesData sales, _) =>
                                    sales.year,
                                yValueMapper: (SalesData sales, _) =>
                                    sales.sales,
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
                                color: ColorResources.mustard,
                                canShowMarker: false,
                                textStyle: figtreeMedium.copyWith(
                                    color: Colors.white, fontSize: 10),
                                header: '',
                                format: 'point.y/day'),
                          ),
                        ),
                      ],
                    ),
                  ),
                  20.verticalSpace(),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20.0),
                    child: Container(
                      decoration: BoxDecoration(
                          color: ColorResources.mustard,
                          borderRadius: BorderRadius.circular(14)),
                      padding: const EdgeInsets.all(20),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text('45K Ltr.',
                                  style: figtreeMedium.copyWith(fontSize: 22)),
                              Text('Total production.',
                                  style: figtreeMedium.copyWith(
                                    fontSize: 12,
                                  )),
                            ],
                          ),
                          SizedBox(
                            height: 35,
                            child: customPaint(Colors.black),
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text('UGX 22.5M',
                                  style: figtreeMedium.copyWith(fontSize: 22)),
                              Text('Worth',
                                  style: figtreeMedium.copyWith(
                                    fontSize: 12,
                                  )),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                  20.verticalSpace(),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20.0),
                    child: Column(
                      children: [
                        monthData(month: 'April, 2023'),
                        SizedBox(
                            height: 0,
                            width: screenWidth(),
                            child: horizontalPaint()),
                        monthData(month: 'March, 2023'),
                        SizedBox(
                            height: 0,
                            width: screenWidth(),
                            child: horizontalPaint()),
                        monthData(month: 'February, 2023'),
                        SizedBox(
                            height: 0,
                            width: screenWidth(),
                            child: horizontalPaint()),
                        monthData(month: 'January, 2023'),
                        SizedBox(
                            height: 0,
                            width: screenWidth(),
                            child: horizontalPaint()),
                        monthData(month: 'December, 2022'),
                        SizedBox(
                            height: 0,
                            width: screenWidth(),
                            child: horizontalPaint()),
                        monthData(month: 'November, 2022')
                      ],
                    ),
                  ),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }

  Widget monthData({required String month}) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8.0, top: 18),
      child: Column(
        children: [
          Text(month, style: figtreeMedium.copyWith(fontSize: 14)),
          10.verticalSpace(),
          Container(
            decoration: BoxDecoration(
                color: const Color(0xFFFFF3F4),
                borderRadius: BorderRadius.circular(14)),
            padding: const EdgeInsets.all(20),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('20', style: figtreeSemiBold.copyWith(fontSize: 18)),
                    Text('Milking cows',
                        style: figtreeRegular.copyWith(
                            fontSize: 12, color: ColorResources.fieldGrey)),
                  ],
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('5580 Ltr.',
                        style: figtreeSemiBold.copyWith(fontSize: 18)),
                    Text('Production',
                        style: figtreeRegular.copyWith(
                            fontSize: 12, color: ColorResources.fieldGrey)),
                  ],
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('06 Ltr.',
                        style: figtreeSemiBold.copyWith(fontSize: 18)),
                    Text('Yield /day',
                        style: figtreeRegular.copyWith(
                            fontSize: 12, color: ColorResources.fieldGrey)),
                  ],
                ),
              ],
            ),
          ),
          Container(
            padding: const EdgeInsets.all(20),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('180 Ltr.',
                        style: figtreeSemiBold.copyWith(fontSize: 18)),
                    Text('Self use',
                        style: figtreeRegular.copyWith(
                            fontSize: 12, color: ColorResources.fieldGrey)),
                  ],
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('4000 Ltr.',
                        style: figtreeSemiBold.copyWith(fontSize: 18)),
                    Text('Supply to PDFL',
                        style: figtreeRegular.copyWith(
                            fontSize: 12, color: ColorResources.fieldGrey)),
                  ],
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('1400 Ltr.',
                        style: figtreeSemiBold.copyWith(fontSize: 18)),
                    Text('Supply to others',
                        style: figtreeRegular.copyWith(
                            fontSize: 12, color: ColorResources.fieldGrey)),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class SalesData {
  SalesData(this.year, this.sales);
  final DateTime year;
  final double sales;
}
