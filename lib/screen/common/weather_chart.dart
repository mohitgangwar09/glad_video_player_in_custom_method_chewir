import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:glad/cubit/weather_cubit/weather_cubit.dart';
import 'package:glad/data/model/respone_weather.dart';
import 'package:glad/screen/custom_widget/custom_appbar.dart';
import 'package:glad/screen/custom_widget/custom_methods.dart';
import 'package:glad/utils/color_resources.dart';
import 'package:glad/utils/extension.dart';
import 'package:glad/utils/styles.dart';
import 'package:intl/intl.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

class WeatherChart extends StatefulWidget {
  const WeatherChart({super.key, required this.lat, required this.long});
  final double lat;
  final double long;

  @override
  State<WeatherChart> createState() => _WeatherChartState();
}

class _WeatherChartState extends State<WeatherChart> {

  @override
  void initState() {
    if(BlocProvider.of<WeatherCubit>(context).state.responseWeather == null) {
      BlocProvider.of<WeatherCubit>(context).weatherApi(context, widget.lat, widget.long);
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocBuilder<WeatherCubit, WeatherState>(
          builder: (context, state) {
        if (state.status == WeatherStatus.submit) {
          return const Center(
              child: CircularProgressIndicator(
            color: ColorResources.maroon,
          ));
        } else if (state.responseWeather == null) {
          return Center(
              child: Text("${state.responseWeather} Api Error"));
        } else {
          List<Daily>? detailedData =
              state.responseWeather!.daily;
          List<SalesData>? chartData;
            chartData = List.generate(
              state.responseWeather!.daily!.length,
                  (index) =>
                  SalesData(DateTime.fromMillisecondsSinceEpoch(state.responseWeather!.daily![index].dt * 1000),
                      state.responseWeather!.daily![index].temp!),
            );
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CustomAppBar(
                context: context,
                titleText1: 'Weather Forecast',
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
                              'Today\'s weather: ${state.responseWeather!.current!.temp!}° ${state.responseWeather!.current!.weather != null ? state.responseWeather!.current!.weather![0].description! : ""}',
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
                                    dateFormat: DateFormat('d MMM'),
                                    labelStyle: figtreeRegular.copyWith(
                                        fontSize: 10, color: Colors.white),
                                    majorGridLines:
                                        const MajorGridLines(width: 0),
                                    // maximumLabels: 6,
                                    interval: 1,
                                    axisLine: const AxisLine(width: 0),
                                    majorTickLines:
                                        const MajorTickLines(width: 0)),
                                primaryYAxis: NumericAxis(
                                    // interval: 10,
                                    minimum: 5,
                                    labelStyle: figtreeRegular.copyWith(
                                        fontSize: 10, color: Colors.white),
                                    axisLine: const AxisLine(width: 0),
                                    majorGridLines:
                                        const MajorGridLines(dashArray: [5, 5]),
                                    majorTickLines:
                                        const MajorTickLines(width: 0)),
                                series: <ChartSeries>[
                                  AreaSeries<SalesData, DateTime>(
                                    dataSource: chartData,
                                    xValueMapper: (SalesData sales, _) =>
                                        sales.date,
                                    yValueMapper: (SalesData sales, _) =>
                                       double.parse(((sales.temp.max + sales.temp.min ) / 2).toStringAsFixed(2)),
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
                                    header: 'Average Temp',
                                    format: 'point.y°'),
                              ),
                            ),
                          ],
                        ),
                      ),
                      20.verticalSpace(),
                      state.responseWeather!.alerts != null ? Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 20.0),
                        child: Container(
                          decoration: BoxDecoration(
                              color: ColorResources.mustard,
                              borderRadius: BorderRadius.circular(14)),
                          padding: const EdgeInsets.all(20),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                  '${state.responseWeather!.alerts![0].event} from ${DateFormat('d MMM, yy hh:mm').format(DateTime.fromMillisecondsSinceEpoch(state.responseWeather!.alerts![0].start * 1000))} to ${DateFormat('d MMM, yy hh:mm').format(DateTime.fromMillisecondsSinceEpoch(state.responseWeather!.alerts![0].end * 1000))}',
                                  style:
                                      figtreeMedium.copyWith(fontSize: 16)),
                              20.verticalSpace(),
                              Text(state.responseWeather!.alerts![0].description ?? '',
                                  style: figtreeMedium.copyWith(
                                    fontSize: 14,
                                  )),
                            ],
                          ),
                        ),
                      ) : const SizedBox.shrink(),
                      20.verticalSpace(),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 20.0),
                        child: ListView.separated(
                            shrinkWrap: true,
                            controller: ScrollController(),
                            itemBuilder: (context, index) => Padding(
                              padding: const EdgeInsets.only(bottom: 8.0, top: 18),
                              child: Container(
                                padding: const EdgeInsets.all(10),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(DateFormat('d MMMM').format(DateTime.fromMillisecondsSinceEpoch(state.responseWeather!.daily![index].dt * 1000)),
                                        style: figtreeSemiBold.copyWith(fontSize: 16)),
                                    Text('${state.responseWeather!.daily![index].weather != null ? state.responseWeather!.daily![index].weather![0].main : ''}',
                                        style: figtreeMedium.copyWith(fontSize: 14, color: const Color(0xFF707070))),
                                    networkImage(text: 'https://openweathermap.org/img/wn/${state.responseWeather!.daily![index].weather != null ? state.responseWeather!.daily![index].weather![0].icon : ''}.png', height: 32, width: 32),
                                    Row(
                                      children: [
                                        Text('${state.responseWeather!.daily![index].temp!.max.toStringAsFixed(1)}°',
                                            style: figtreeMedium.copyWith(fontSize: 18)),
                                        Text('  -  ',
                                            style: figtreeMedium.copyWith(fontSize: 18, color: const Color(0xFF707070))),
                                        Text('${state.responseWeather!.daily![index].temp!.min.toStringAsFixed(1)}°',
                                            style: figtreeMedium.copyWith(fontSize: 14)),
                                      ],
                                    ),

                                  ],
                                ),
                              ),
                            ),
                            separatorBuilder: (context, index) => SizedBox(
                                height: 0,
                                width: screenWidth(),
                                child: horizontalPaint()),
                            itemCount: state.responseWeather!.daily!.length),
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
  SalesData(this.date, this.temp);
  final DateTime date;
  final Temp temp;
}
