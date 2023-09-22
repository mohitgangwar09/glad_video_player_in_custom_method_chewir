import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:glad/cubit/landing_page_cubit/landing_page_cubit.dart';
import 'package:glad/screen/custom_widget/custom_appbar.dart';
import 'package:glad/screen/custom_widget/custom_methods.dart';
import 'package:glad/utils/color_resources.dart';
import 'package:glad/utils/extension.dart';
import 'package:glad/utils/styles.dart';
import 'package:intl/intl.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

class SuppliedToPDFL extends StatefulWidget {
  const SuppliedToPDFL({super.key});

  @override
  State<SuppliedToPDFL> createState() => _SuppliedToPDFLState();
}

class _SuppliedToPDFLState extends State<SuppliedToPDFL> {
  String duration = "6months";
  @override
  void initState() {
    SchedulerBinding.instance.addPostFrameCallback((_) {
      BlocProvider.of<LandingPageCubit>(context)
          .getMilkProductionChart(context);
    });
    super.initState();
  }

  dynamic totalProduction(LandingPageState state) {
    switch (duration) {
      case '6months':
        return state
            .milkProductionChartResponse!.data!.totalSixMonthMilkProduction;
      case 'lastmonth':
        return state
            .milkProductionChartResponse!.data!.totalLastMonthMilkProduction;
      case 'lastweek':
        return state
            .milkProductionChartResponse!.data!.totalLastWeekMilkProduction;
      case 'yesterday':
        return state
            .milkProductionChartResponse!.data!.totalYesterdayMilkProduction;
      default:
        return 0;
    }
  }

  List<SalesData>? getDurationData(LandingPageState state) {
    switch (duration) {
      case '6months':
        dynamic data = state.milkProductionChartResponse!.data!.monthWiseData;
        return List.generate(
          data!.length,
          (index) => SalesData(
              DateTime(
                  data![index].year ?? DateTime.now().year, data![index].month),
              double.parse((data![index].suppliedToPdfl ?? 0).toString())),
        );
      case 'lastmonth':
        dynamic data = state.milkProductionChartResponse!.data!.lastMonth!;
        return List.generate(
          data!.length,
          (index) => SalesData(DateTime.parse(data[index].date),
              double.parse((data![index].suppliedToPdfl ?? 0).toString())),
        );
      case 'lastweek':
        dynamic data = state.milkProductionChartResponse!.data!.lastWeekData;
        return List.generate(
          data!.length,
          (index) => SalesData(
              DateTime.parse(data![index].date),
              double.parse((data![index].suppliedToPdfl ?? 0).toString())),
        );
      case 'yesterday':
        dynamic data = state.milkProductionChartResponse!.data!.previousDay;
        return List.generate(
          data!.length,
          (index) => SalesData(
              DateTime.parse(data![index].date),
              double.parse((data![index].suppliedToPdfl ?? 0).toString())),
        );
      default:
        return null;
    }
  }

  DateFormat? getDateFormat(LandingPageState state) {
    switch (duration) {
      case '6months':
        return DateFormat('MMM, yy');
      case 'lastmonth':
        return DateFormat('d');
      case 'lastweek':
        return DateFormat('EEE');
      case 'yesterday':
        return DateFormat('dd MMM, yy');
      default:
        return null;
    }
  }

  String? getDesc(LandingPageState state) {
    switch (duration) {
      case '6months':
        return 'Last 6 months';
      case 'lastmonth':
        return 'Last month';
      case 'lastweek':
        return 'Last week';
      case 'yesterday':
        return 'Yesterday';
      default:
        return null;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
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
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CustomAppBar(
                context: context,
                titleText1: 'Milk supplied to PDFL',
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
                            Text(
                              getDesc(state)!,
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
                                    dateFormat: getDateFormat(state),
                                    labelStyle: figtreeRegular.copyWith(
                                        fontSize: 10, color: Colors.white),
                                    majorGridLines:
                                        const MajorGridLines(width: 0),
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
                                    labelFormat: '{value}Ltr.'),
                                series: <ChartSeries>[
                                  AreaSeries<SalesData, DateTime>(
                                    dataSource: getDurationData(state)!,
                                    xValueMapper: (SalesData sales, _) =>
                                        sales.year,
                                    yValueMapper: (SalesData sales, _) =>
                                        sales.sales,
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
                      Container(
                        height: 50,
                        margin: 20.marginHorizontal(),
                        width: screenWidth(),
                        decoration: boxDecoration(
                            borderRadius: 62,
                            borderColor: const Color(0xff999999),
                            backgroundColor: Colors.white),
                        child: Row(
                          children: [
                            Expanded(
                              child: InkWell(
                                onTap: () {
                                  setState(() {
                                    duration = 'yesterday';
                                  });
                                },
                                child: Container(
                                  height: screenHeight(),
                                  margin: const EdgeInsets.all(6),
                                  decoration: boxDecoration(
                                      backgroundColor: duration == 'yesterday'
                                          ? const Color(0xff6A0030)
                                          : Colors.white,
                                      borderRadius: 62),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      "Yesterday".textMedium(
                                          color: duration == 'yesterday'
                                              ? Colors.white
                                              : Colors.black,
                                          fontSize: 10),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                            Expanded(
                              child: InkWell(
                                onTap: () {
                                  setState(() {
                                    duration = 'lastweek';
                                  });
                                },
                                child: Container(
                                  height: screenHeight(),
                                  margin: const EdgeInsets.all(6),
                                  decoration: boxDecoration(
                                      backgroundColor: duration == 'lastweek'
                                          ? const Color(0xff6A0030)
                                          : Colors.white,
                                      borderRadius: 62),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      "Last week".textMedium(
                                          color: duration == 'lastweek'
                                              ? Colors.white
                                              : Colors.black,
                                          fontSize: 10),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                            Expanded(
                              child: InkWell(
                                onTap: () {
                                  setState(() {
                                    duration = 'lastmonth';
                                  });
                                },
                                child: Container(
                                  height: screenHeight(),
                                  margin: const EdgeInsets.all(6),
                                  decoration: boxDecoration(
                                      backgroundColor: duration == 'lastmonth'
                                          ? const Color(0xff6A0030)
                                          : Colors.white,
                                      borderRadius: 62),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      "Last month".textMedium(
                                          color: duration == 'lastmonth'
                                              ? Colors.white
                                              : Colors.black,
                                          fontSize: 10),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                            Expanded(
                              child: InkWell(
                                onTap: () {
                                  setState(() {
                                    duration = '6months';
                                  });
                                },
                                child: Container(
                                  height: screenHeight(),
                                  margin: const EdgeInsets.all(6),
                                  decoration: boxDecoration(
                                      backgroundColor: duration == '6months'
                                          ? const Color(0xff6A0030)
                                          : Colors.white,
                                      borderRadius: 62),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      "Last 6 months".textMedium(
                                          color: duration == '6months'
                                              ? Colors.white
                                              : Colors.black,
                                          fontSize: 10),
                                    ],
                                  ),
                                ),
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
                                  Text('${totalProduction(state)}K Ltr.',
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
                      duration == '6months'
                          ? Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 20.0),
                              child: ListView.separated(
                                  shrinkWrap: true,
                                  itemBuilder: (context, index) => Container(
                                        color: index % 2 != 0
                                            ? const Color(0xFFFFF3F4)
                                            : Colors.transparent,
                                        padding: const EdgeInsets.symmetric(
                                            vertical: 25, horizontal: 20),
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            '${state.milkProductionChartResponse!.data!.monthWiseData![index].suppliedToPdfl ?? 0} Litre'
                                                .textMedium(
                                                    color: Colors.black,
                                                    fontSize: 18),
                                            '${state.milkProductionChartResponse!.data!.monthWiseData![index].monthname}, ${state.milkProductionChartResponse!.data!.monthWiseData![index].year}'
                                                .toString()
                                                .textMedium(
                                                    color: Colors.black,
                                                    fontSize: 14),
                                          ],
                                        ),
                                      ),
                                  separatorBuilder: (context, index) =>
                                      SizedBox(
                                          height: 0,
                                          width: screenWidth(),
                                          child: horizontalPaint()),
                                  itemCount: state.milkProductionChartResponse!
                                      .data!.monthWiseData!.length),
                            )
                          : duration == 'lastmonth'
                              ? Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 20.0),
                                  child: ListView.separated(
                                      shrinkWrap: true,
                                      itemBuilder: (context, index) =>
                                          Container(
                                            color: index % 2 != 0
                                                ? const Color(0xFFFFF3F4)
                                                : Colors.transparent,
                                            padding: const EdgeInsets.symmetric(
                                                vertical: 25, horizontal: 20),
                                            child: Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: [
                                                '${state.milkProductionChartResponse!.data!.lastMonth![index].suppliedToPdfl ?? 0} Litre'
                                                    .textMedium(
                                                        color: Colors.black,
                                                        fontSize: 18),
                                                DateFormat('dd MMMM, yyyy')
                                                    .format(DateTime.parse(state
                                                        .milkProductionChartResponse!
                                                        .data!
                                                        .lastMonth![index]
                                                        .date!))
                                                    .toString()
                                                    .textMedium(
                                                        color: Colors.black,
                                                        fontSize: 14),
                                              ],
                                            ),
                                          ),
                                      separatorBuilder: (context, index) =>
                                          SizedBox(
                                              height: 0,
                                              width: screenWidth(),
                                              child: horizontalPaint()),
                                      itemCount: state
                                          .milkProductionChartResponse!
                                          .data!
                                          .lastMonth!
                                          .length),
                                )
                              : const SizedBox.shrink(),
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
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(milkingCows,
                        style: figtreeSemiBold.copyWith(fontSize: 18)),
                    Text('Milking cows',
                        style: figtreeRegular.copyWith(
                            fontSize: 12, color: ColorResources.fieldGrey)),
                  ],
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('$production Ltr.',
                        style: figtreeSemiBold.copyWith(fontSize: 18)),
                    Text('Production',
                        style: figtreeRegular.copyWith(
                            fontSize: 12, color: ColorResources.fieldGrey)),
                  ],
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('$yield Ltr.',
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
                    Text('$selfUse Ltr.',
                        style: figtreeSemiBold.copyWith(fontSize: 18)),
                    Text('Self use',
                        style: figtreeRegular.copyWith(
                            fontSize: 12, color: ColorResources.fieldGrey)),
                  ],
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('$supplyToPDFL Ltr.',
                        style: figtreeSemiBold.copyWith(fontSize: 18)),
                    Text('Supply to PDFL',
                        style: figtreeRegular.copyWith(
                            fontSize: 12, color: ColorResources.fieldGrey)),
                  ],
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('$supplyToOthers Ltr.',
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
