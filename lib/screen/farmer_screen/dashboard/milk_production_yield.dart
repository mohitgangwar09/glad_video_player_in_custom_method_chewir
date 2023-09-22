import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:glad/cubit/landing_page_cubit/landing_page_cubit.dart';
import 'package:glad/data/model/milk_production_chart.dart';
import 'package:glad/screen/custom_widget/custom_appbar.dart';
import 'package:glad/screen/custom_widget/custom_methods.dart';
import 'package:glad/utils/color_resources.dart';
import 'package:glad/utils/extension.dart';
import 'package:glad/utils/helper.dart';
import 'package:glad/utils/styles.dart';
import 'package:intl/intl.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

class MilkProductionYield extends StatefulWidget {
  const MilkProductionYield({super.key, required this.type});
  final String type;

  @override
  State<MilkProductionYield> createState() => _MilkProductionYieldState();
}

class _MilkProductionYieldState extends State<MilkProductionYield> {
  @override
  void initState() {
    SchedulerBinding.instance.addPostFrameCallback((_) {
      BlocProvider.of<LandingPageCubit>(context)
          .getMilkProductionChart(context);
    });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocBuilder<LandingPageCubit, LandingPageState>(
          builder: (context, state) {
        if (state.status == LandingPageStatus.loading) {
          return const Center(
              child: CircularProgressIndicator(
            color: ColorResources.maroon,
          ));
        } else if (state.milkProductionChartResponse == null) {
          return Center(
              child: Text("${state.milkProductionChartResponse} Api Error"));
        } else {
          Data data  = state.milkProductionChartResponse!.data!;
          List<MonthWiseData> detailedData =
              state.milkProductionChartResponse!.data!.monthWiseData!;
          String? labelFormat;
          List<SalesData>? chartData;
          if(widget.type == 'yield') {
            chartData = List.generate(
              state.milkProductionChartResponse!.data!.monthWiseData!.length,
                  (index) =>
                  SalesData(DateTime(
                      detailedData[index].year, detailedData[index].month),
                      double.parse(detailedData[index].yieldPerCow.toString())),
            );
            labelFormat = '{value}Ltr.';
          } else if(widget.type == 'milking_cows'){
            chartData = List.generate(
              state.milkProductionChartResponse!.data!.monthWiseData!.length,
                  (index) =>
                  SalesData(DateTime(
                      detailedData[index].year, detailedData[index].month),
                      double.parse((detailedData[index].milkingCow ?? 40).toString())),
            );
            labelFormat = '{value} Cows';
          } else if(widget.type == 'milk_production'){
            chartData = List.generate(
              state.milkProductionChartResponse!.data!.monthWiseData!.length,
                  (index) =>
                  SalesData(DateTime(
                      detailedData[index].year, detailedData[index].month),
                      double.parse((detailedData[index].totalMilkProduction ?? 0).toString())),
            );
            labelFormat = '{value}Ltr.';
          }
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CustomAppBar(
                context: context,
                titleText1: 'Milk production & yield',
                centerTitle: true,
                leading: arrowBackButton(color: Colors.white),
                backgroundColor: ColorResources.maroon,
                titleText1Style:
                    figtreeMedium.copyWith(fontSize: 20, color: Colors.white),
              ),
              Expanded(
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      Container(
                        decoration: const BoxDecoration(
                            color: ColorResources.maroon,
                            borderRadius: BorderRadius.only(
                                bottomLeft: Radius.circular(70))),
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
                                    majorGridLines:
                                        const MajorGridLines(width: 0),
                                    // maximumLabels: 6,
                                    axisLine: const AxisLine(width: 0),
                                    majorTickLines:
                                        const MajorTickLines(width: 0)),
                                primaryYAxis: NumericAxis(
                                    interval: 10,
                                    labelStyle: figtreeRegular.copyWith(
                                        fontSize: 10, color: Colors.white),
                                    axisLine: const AxisLine(width: 0),
                                    majorGridLines:
                                        const MajorGridLines(dashArray: [5, 5]),
                                    majorTickLines:
                                        const MajorTickLines(width: 0),
                                    labelFormat: labelFormat),
                                series: <ChartSeries>[
                                  AreaSeries<SalesData, DateTime>(
                                    dataSource: chartData!,
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
                                        const Color(0xFFFC5E60)
                                            .withOpacity(0.12),
                                        const Color(0xFFFFFFFF)
                                            .withOpacity(0.12)
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
                                  Text(
                                      '${data.totalSixMonthMilkProduction}K Ltr.',
                                      style:
                                          figtreeMedium.copyWith(fontSize: 22)),
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
                                      style:
                                          figtreeMedium.copyWith(fontSize: 22)),
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
                        child: ListView.separated(
                            shrinkWrap: true,
                            itemBuilder: (context, index) => monthData(
                                month:
                                    '${detailedData[index].monthname}, ${detailedData[index].year}',
                                milkingCows: (detailedData[index].milkingCow ?? 0).toString(),
                                production:
                                (detailedData[index].totalMilkProduction ?? 0).toString(),
                                yield: (detailedData[index].yieldPerCow ?? 0).toString(),
                              selfUse: (detailedData[index].selfUse ?? 0).toString(),
                              supplyToPDFL: (detailedData[index].suppliedToPdfl ?? 0).toString(),
                              supplyToOthers: (detailedData[index].suppliedToOthers ?? 0).toString(),
                            ),
                            separatorBuilder: (context, index) => SizedBox(
                                height: 0,
                                width: screenWidth(),
                                child: horizontalPaint()),
                            itemCount: detailedData.length),
                      ),
                    ],
                  ),
                ),
              )
            ],
          );
        }
      }),
    );
  }

  Widget monthData(
      {required String month,
      required String milkingCows,
      required String production,
      required String yield,
      required String selfUse,
      required String supplyToPDFL,
      required String supplyToOthers}) {
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
              // mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(milkingCows, style: figtreeSemiBold.copyWith(fontSize: 18)),
                      Text('Milking cows',
                          style: figtreeRegular.copyWith(
                              fontSize: 12, color: ColorResources.fieldGrey)),
                    ],
                  ),
                ),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('$production Ltr.',
                          style: figtreeSemiBold.copyWith(fontSize: 18)),
                      Text('Production',
                          style: figtreeRegular.copyWith(
                              fontSize: 12, color: ColorResources.fieldGrey)),
                    ],
                  ),
                ),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('$yield Ltr.',
                          style: figtreeSemiBold.copyWith(fontSize: 18)),
                      Text('Yield /day',
                          style: figtreeRegular.copyWith(
                              fontSize: 12, color: ColorResources.fieldGrey)),
                    ],
                  ),
                ),
              ],
            ),
          ),
          Container(
            padding: const EdgeInsets.all(20),
            child: Row(
              // mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('$selfUse Ltr.',
                          style: figtreeSemiBold.copyWith(fontSize: 18)),
                      Text('Self use',
                          style: figtreeRegular.copyWith(
                              fontSize: 12, color: ColorResources.fieldGrey)),
                    ],
                  ),
                ),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('$supplyToPDFL Ltr.',
                          style: figtreeSemiBold.copyWith(fontSize: 18)),
                      Text('Supply to PDFL',
                          style: figtreeRegular.copyWith(
                              fontSize: 12, color: ColorResources.fieldGrey)),
                    ],
                  ),
                ),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('$supplyToOthers Ltr.',
                          style: figtreeSemiBold.copyWith(fontSize: 18)),
                      Text('Supply to others',
                          style: figtreeRegular.copyWith(
                              fontSize: 12, color: ColorResources.fieldGrey)),
                    ],
                  ),
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
