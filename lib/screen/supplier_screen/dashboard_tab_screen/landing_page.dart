import 'dart:convert';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:glad/cubit/dashboard_cubit/dashboard_cubit.dart';
import 'package:glad/cubit/landing_page_cubit/landing_page_cubit.dart';
import 'package:glad/cubit/profile_cubit/profile_cubit.dart';
import 'package:glad/cubit/project_cubit/project_cubit.dart';
import 'package:glad/cubit/weather_cubit/weather_cubit.dart';
import 'package:glad/screen/common/community_forum.dart';
import 'package:glad/screen/common/featured_trainings.dart';
import 'package:glad/screen/common/landing_carousel.dart';
import 'package:glad/screen/common/trending_news.dart';
import 'package:glad/screen/custom_widget/custom_appbar.dart';
import 'package:glad/screen/custom_widget/custom_methods.dart';
import 'package:glad/screen/farmer_screen/online_training.dart';
import 'package:glad/screen/guest_user/dashboard_tab_screen/news_and_event.dart';
import 'package:glad/screen/mcc_screen/mcc_carousel.dart';
import 'package:glad/screen/supplier_screen/profile/kyc_update.dart';
import 'package:glad/screen/supplier_screen/profile/service_provider_profile.dart';
import 'package:glad/screen/supplier_screen/supplier_update_kyc.dart';
import 'package:glad/screen/supplier_screen/widget/survey_supplier_widget.dart';
import 'package:glad/utils/app_constants.dart';
import 'package:glad/utils/color_resources.dart';
import 'package:glad/utils/extension.dart';
import 'package:glad/utils/images.dart';
import 'package:glad/utils/styles.dart';
import 'package:intl/intl.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

import 'package:glad/screen/supplier_screen/dashboard/dashboard_supplier.dart';
import 'package:weather/weather.dart';
import 'package:http/http.dart' as http;

class SupplierLandingPage extends StatefulWidget {
  const SupplierLandingPage({super.key});

  @override
  State<SupplierLandingPage> createState() => _SupplierLandingPageState();
}

class _SupplierLandingPageState extends State<SupplierLandingPage> {
  // List<_ChartData> data = [
  //   _ChartData('Completed', 12),
  //   _ChartData('Pending', 6),
  // ];

  String surveyPercentage = "0";
  String surveyText = 'completed';
  String projectPercentage = "0";
  String projectText = 'completed';

  // List<_ChartData> data2 = [
  //   _ChartData('Completed', 07),
  //   _ChartData('Active', 15),
  // ];

  final List<SalesData> chartData = [
    SalesData(DateTime(2022, 11), 2),
    SalesData(DateTime(2022, 12), 2.6),
    SalesData(DateTime(2023, 1), 2.7),
    SalesData(DateTime(2023, 2), 3),
    SalesData(DateTime(2023, 3), 3.4),
    SalesData(DateTime(2023, 4), 3.5)
  ];

  /*void weatherDetail() async{
    WeatherFactory wf = WeatherFactory('52a17d91b3ed0697b05a7dd6fdc708c4');
    Weather w = await wf.currentWeatherByLocation(28.5355, 77.3910);
    print(w.);
  }*/

  Future<dynamic> getForecast({double? lat = 28.4986, double lon = 77.3999}) async {
    try {
      String api = 'https://api.openweathermap.org/data/2.5/onecall';
      String appId = '52a17d91b3ed0697b05a7dd6fdc708c4';
      String units = 'metric';
      String cnt = '4';
      String url = '$api?lat=$lat&cnt=$cnt&lon=$lon&appid=$appId&units=$units';

      final response = await http.get(Uri.parse(url));
      final json = jsonDecode(response.body);
      print(json);
      return json;
    } catch (e) {
      rethrow;
    }
  }

  @override
  void initState() {
    // getForecast();
    BlocProvider.of<ProfileCubit>(context).userRatingApi(context);
    BlocProvider.of<LandingPageCubit>(context).getSupplierDashboard(context).then((value) {
      LandingPageState state = BlocProvider.of<LandingPageCubit>(context).state;
      int projectsSum = state.responseSupplierDashboard!.data!.farmerProject!.completed!.toInt() +
          state.responseSupplierDashboard!.data!.farmerProject!.active!.toInt();
      int projectActive = state.responseSupplierDashboard!.data!.farmerProject!.active!.toInt();
      int projectCompleted = state.responseSupplierDashboard!.data!.farmerProject!.completed!.toInt();
      if(projectsSum != 0) {
        if(projectCompleted != 0) {
          projectPercentage = removeZeroesInFraction(((projectCompleted / projectsSum) * 100).toString());
          projectText = 'completed';
        } else {
          projectPercentage = removeZeroesInFraction(((projectActive / projectsSum) * 100).toString());
          projectText = "active";
        }
      }

      int surveysSum = state.responseSupplierDashboard!.data!.farmerProjectSurvey!.completed!.toInt() +
          state.responseSupplierDashboard!.data!.farmerProjectSurvey!.pending!.toInt();
      int surveyPending = state.responseSupplierDashboard!.data!.farmerProjectSurvey!.pending!.toInt();
      int surveyCompleted = state.responseSupplierDashboard!.data!.farmerProjectSurvey!.completed!.toInt();
      if(surveysSum != 0) {
        if(surveyCompleted != 0) {
          surveyPercentage = removeZeroesInFraction(((surveyCompleted / surveysSum) * 100).toString());
          surveyText = 'completed';
        } else {
          surveyPercentage = removeZeroesInFraction(((surveyPending / surveysSum) * 100).toString());
          surveyText = 'pending';
        }
      }

      setState(() {});
    });
    super.initState();
    SchedulerBinding.instance.addPostFrameCallback((_) {
      BlocProvider.of<ProfileCubit>(context).profileApi(context);
      BlocProvider.of<ProjectCubit>(context)
          .supplierProjectsApi(context, 'new', true);
    });
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LandingPageCubit, LandingPageState>(
      builder: (context, state) {
        if (state.status == LandingPageStatus.loading) {
          return const Center(
              child: CircularProgressIndicator(
                color: ColorResources.maroon,
              ));
        } else if (state.responseSupplierDashboard == null) {
          return Center(child: Text("${state.responseSupplierDashboard} Api Error"));
        } else {
          return Container(
            color: Colors.white,
            child: Stack(
              children: [
                landingBackground(),
                Column(
                  children: [
                    BlocBuilder<ProfileCubit,ProfileCubitState>(
                      builder: (context,stateprofile) {
                        return Column(
                          children: [
                            CustomAppBar(
                              context: context,
                              titleText1: 'Hello ',
                              titleText2: stateprofile.responseProfile!=null?stateprofile.responseProfile!.data!.user!.name.toString():'',
                              leading: openDrawer(
                                  onTap: () {
                                    supplierLandingKey.currentState?.openDrawer();
                                  },
                                  child: SvgPicture.asset(Images.drawer)),
                              action: Row(
                                children: [
                                  phoneCall(256758711344),
                                  7.horizontalSpace(),
                                  InkWell(
                                      onTap: () {
                                        const SupplierProfile().navigate();
                                      },
                                      child: ClipRRect(
                                        borderRadius: BorderRadius.circular(1000),
                                        child: Container(
                                          height: AppBar().preferredSize.height * 0.7,
                                          width: AppBar().preferredSize.height * 0.7,
                                          decoration:
                                          const BoxDecoration(shape: BoxShape.circle),
                                          child: CachedNetworkImage(
                                            imageUrl:
                                            (state.responseSupplierDashboard!.data != null) ? (state.responseSupplierDashboard!.data!.supplier!.photo ?? '') : '',
                                            errorWidget: (_, __, ___) =>
                                                SvgPicture.asset(Images.person),
                                            fit: BoxFit.cover,
                                          ),
                                        ),
                                      )),
                                  8.horizontalSpace(),
                                ],
                              ),
                            ),

                            stateprofile.responseProfile!.data!.user!.kycStatus == "verified"?
                            const SizedBox.shrink():
                            Container(
                              width: screenWidth(),
                              margin: const EdgeInsets.symmetric(horizontal: 20),
                              height: 45,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(80),
                                color: const Color(0xffFC5E60),
                              ),
                              child: Row(
                                children: [

                                  if(stateprofile.responseProfile!.data!.user!.kycStatus == null)
                                    Row(
                                      children: [
                                        14.horizontalSpace(),
                                        SvgPicture.asset(Images.kyc),
                                        4.horizontalSpace(),
                                        "Your KYC is pending.".textSemiBold(fontSize: 12,color: Colors.white),
                                        10.horizontalSpace(),
                                        Text(
                                          'Upload Documents',
                                          style: figtreeMedium.copyWith(
                                              fontSize: 12, color: ColorResources.white,decoration: TextDecoration.underline),
                                        )
                                      ],
                                    )
                                  else if(stateprofile.responseProfile!.data!.user!.kycStatus == "pending")
                                    Row(
                                      children: [
                                        14.horizontalSpace(),
                                        SvgPicture.asset(Images.kyc),
                                        4.horizontalSpace(),
                                        "Your KYC is pending.".textSemiBold(fontSize: 12,color: Colors.white),
                                        10.horizontalSpace(),
                                        InkWell(
                                          onTap: (){
                                            const KYCUpdate().navigate();
                                          },
                                          child: Text(
                                            'Upload Documents',
                                            style: figtreeMedium.copyWith(
                                                fontSize: 12, color: ColorResources.white,decoration: TextDecoration.underline),
                                          ),
                                        )
                                      ],
                                    )
                                  else if(stateprofile.responseProfile!.data!.user!.kycStatus == "applied")
                                    Row(
                                        children: [

                                          14.horizontalSpace(),
                                          const Icon(Icons.watch_later_outlined,size: 15,color: Colors.white,),
                                          4.horizontalSpace(),
                                          "Your KYC is not verified.".textSemiBold(fontSize: 12,color: Colors.white),
                                          10.horizontalSpace(),
                                          InkWell(
                                            onTap: (){
                                              const SupplierUpdateKyc().navigate();
                                            },
                                            child: Text(
                                              'Documents',
                                              style: figtreeMedium.copyWith(
                                                  fontSize: 12, color: ColorResources.white,decoration: TextDecoration.underline),
                                            ),
                                          )
                                        ],
                                      )
                                  else if(stateprofile.responseProfile!.data!.user!.kycStatus == "expired")
                                    Row(
                                          children: [
                                            14.horizontalSpace(),
                                            const Icon(Icons.watch_later_outlined,size: 15,color: Colors.white,),
                                            4.horizontalSpace(),
                                            "Your KYC expired.".textSemiBold(fontSize: 12,color: Colors.white),
                                            10.horizontalSpace(),
                                            InkWell(
                                              onTap: (){
                                                const SupplierUpdateKyc().navigate();
                                              },
                                              child: Text(
                                                'Documents',
                                                style: figtreeMedium.copyWith(
                                                    fontSize: 12, color: ColorResources.white,decoration: TextDecoration.underline),
                                              ),
                                            )
                                          ],
                                        )
                                ],
                              ),
                            )

                          ],
                        );
                      }
                    ),
                    landingPage(state),
                  ],
                ),
              ],
            ),
          );
        }
      }
    );
  }

  Widget landingPage(LandingPageState state) {
    return Expanded(
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const MccLandingCarousel(),
            20.verticalSpace(),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0),
              child: Row(
                children: [
                  Expanded(
                    child: customShadowContainer(
                      margin: 0,
                      child: InkWell(
                        onTap: () {
                          BlocProvider.of<DashboardCubit>(context).selectedIndex(1);
                        },
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
                                            series: <CircularSeries<_ChartData,
                                                String>>[
                                              DoughnutSeries<_ChartData, String>(
                                                  dataSource: [
                                                    _ChartData('completed', state.responseSupplierDashboard!.data!.farmerProjectSurvey!.completed!.toDouble()),
                                                    _ChartData('pending', state.responseSupplierDashboard!.data!.farmerProjectSurvey!.pending!.toDouble())
                                                  ],
                                                  xValueMapper:
                                                      (_ChartData data, _) =>
                                                          data.x,
                                                  yValueMapper:
                                                      (_ChartData data, _) =>
                                                          data.y,
                                                  radius: '60',
                                                  innerRadius: '40',
                                                  selectionBehavior: SelectionBehavior(
                                                    enable: true,
                                                    unselectedOpacity: 0.7
                                                  ),
                                                  onPointTap: (detail) {
                                                    surveyPercentage = removeZeroesInFraction(((double.parse((detail.dataPoints![detail.pointIndex!] as ChartPoint).text.toString()).toInt() / (double.parse((detail.dataPoints![0] as ChartPoint).text.toString()).toInt() + double.parse((detail.dataPoints![1] as ChartPoint).text.toString()).toInt())) * 100).toString());
                                                    if(detail.pointIndex == 0) {
                                                      surveyText = 'completed';
                                                    } else{
                                                      surveyText = 'pending';
                                                    }
                                                    setState(() {});
                                                  })
                                            ]),
                                      ),
                                      Positioned(
                                          child: Column(
                                            children: [
                                              Row(
                                        mainAxisAlignment:
                                                MainAxisAlignment.center,
                                        children: [
                                              surveyPercentage.toString().textBold(
                                                  color: Colors.black, fontSize: 26),
                                              "%".textBold(
                                                  color: Colors.black, fontSize: 12)
                                        ],
                                      ),
                                              surveyText.textRegular(
                                                  color: Colors.black, fontSize: 10)
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
                                            Text('Completed: ',
                                                style: figtreeRegular.copyWith(
                                                    fontSize: 12)),
                                            Text(state.responseSupplierDashboard!.data!.farmerProjectSurvey!.completed!.toInt().toString(),
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
                                            Text('Pending: ',
                                                style: figtreeRegular.copyWith(
                                                    fontSize: 12)),
                                            Text(state.responseSupplierDashboard!.data!.farmerProjectSurvey!.pending!.toInt().toString(),
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
                  ),
                  10.horizontalSpace(),
                  Expanded(
                    child: customShadowContainer(
                      margin: 0,
                      child: InkWell(
                        onTap: () {
                          BlocProvider.of<DashboardCubit>(context).selectedIndex(2);
                        },
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
                                                  dataSource: [
                                                    _ChartData('completed', state.responseSupplierDashboard!.data!.farmerProject!.completed!.toDouble()),
                                                    _ChartData('active', state.responseSupplierDashboard!.data!.farmerProject!.active!.toDouble())
                                                  ],
                                                  xValueMapper:
                                                      (_ChartData data, _) =>
                                                          data.x,
                                                  yValueMapper:
                                                      (_ChartData data, _) =>
                                                          data.y,
                                                  radius: '60',
                                                  innerRadius: '40',
                                                  selectionBehavior: SelectionBehavior(
                                            enable: true,
                                            unselectedOpacity: 0.7
                                        ),
                                                  onPointTap: (detail) {
                                          projectPercentage = removeZeroesInFraction(((double.parse((detail.dataPoints![detail.pointIndex!] as ChartPoint).text.toString()).toInt() / (double.parse((detail.dataPoints![0] as ChartPoint).text.toString()).toInt() + double.parse((detail.dataPoints![1] as ChartPoint).text.toString()).toInt())) * 100).toString());
                                          if(detail.pointIndex == 0) {
                                            projectText = 'completed';
                                          } else{
                                            projectText = 'active';
                                          }
                                          setState(() {});
                                        })
                                            ]),
                                      ),
                                      Positioned(
                                          child: Column(
                                            children: [
                                              Row(
                                        mainAxisAlignment:
                                                MainAxisAlignment.center,
                                        children: [
                                              projectPercentage.toString().textBold(
                                                  color: Colors.black, fontSize: 26),
                                              "%".textBold(
                                                  color: Colors.black, fontSize: 12)
                                        ],
                                      ),
                                              projectText.textRegular(
                                                  color: Colors.black, fontSize: 10)
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
                                            Text('Completed: ',
                                                style: figtreeRegular.copyWith(
                                                    fontSize: 12)),
                                            Text(state.responseSupplierDashboard!.data!.farmerProject!.completed!.toInt().toString(),
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
                                            Text('Active: ',
                                                style: figtreeRegular.copyWith(
                                                    fontSize: 12)),
                                            Text(state.responseSupplierDashboard!.data!.farmerProject!.active!.toInt().toString(),
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
                  ),
                ],
              ),
            ),
            BlocBuilder<ProjectCubit, ProjectState>(
              builder: (contexts, state){
                if (state.responseSupplierProject == null) {
                  return const SizedBox.shrink();
                }else {
                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      23.verticalSpace(),
                      Padding(
                        padding: const EdgeInsets.only(left: 24.0),
                        child: Text('New Survey',
                            style: figtreeMedium.copyWith(
                                fontSize: 18, color: Colors.black)),
                      ),
                      Container(
                        height: 240,
                        margin: const EdgeInsets.only(left: 12,right: 6),
                        child: customList(
                          padding: const EdgeInsets.all(0),
                            axis: Axis.horizontal,
                            list: List.generate(state.responseSupplierProject!.data!
                                .projectList!.length, (index) => null),
                            child: (int i) {

                              return state.responseSupplierProject!.data!
                                  .projectList![i].farmerProjectSurvey!.isNotEmpty?
                              Padding(
                                padding: const EdgeInsets.only(right: 10.0),
                                child: customProjectContainer(
                                  marginTop: 10,
                                    child: SurveySupplierWidget(
                                        status: state.responseSupplierProject!.data!
                                            .projectList![i].farmerProjectSurvey![0].surveyStatus==null?false:true,
                                        projectStatus: formatProjectStatus(state.responseSupplierProject!.data!
                                            .projectList![i].projectStatus ?? ''),
                                        name: state.responseSupplierProject!.data!
                                            .projectList![i].name ?? '',
                                        category: state.responseSupplierProject!.data!
                                            .projectList![i].farmerImprovementArea !=
                                            null ? state.responseSupplierProject!.data!
                                            .projectList![i].farmerImprovementArea!
                                            .improvementArea != null ? state.responseSupplierProject!.data!
                                            .projectList![i].farmerImprovementArea!
                                            .improvementArea!.name ?? '' : '' : '',
                                        description: state.responseSupplierProject!.data!
                                            .projectList![i].description ?? '',
                                        investment: state.responseSupplierProject!.data!
                                            .projectList![i].investmentAmount ?? 0,
                                        revenue: state.responseSupplierProject!.data!
                                            .projectList![i].revenuePerYear ?? 0,
                                        roi: state.responseSupplierProject!.data!
                                            .projectList![i].roiPerYear ?? 0.0,
                                        loan: state.responseSupplierProject!.data!
                                            .projectList![i].loanAmount ?? 0,
                                        emi: state.responseSupplierProject!.data!
                                            .projectList![i].emiAmount ?? 0,
                                        balance: 0,
                                        farmerName: state.responseSupplierProject!.data!
                                            .projectList![i].farmerMaster!= null ? state.responseSupplierProject!.data!
                                            .projectList![i].farmerMaster!.name ?? '' : '',
                                        farmerAddress:  state.responseSupplierProject!.data!
                                            .projectList![i].farmerMaster!= null ? state.responseSupplierProject!.data!
                                            .projectList![i].farmerMaster!.address!=null?state.responseSupplierProject!.data!
                                            .projectList![i].farmerMaster!.address!.address.toString():"" ??
                                            '' : '',
                                        farmerImage:  state.responseSupplierProject!.data!
                                            .projectList![i].farmerMaster!= null ? state.responseSupplierProject!.data!
                                            .projectList![i].farmerMaster!.photo ??
                                            ''  : '',
                                        farmerPhone:  state.responseSupplierProject!.data!
                                            .projectList![i].farmerMaster!= null ? state.responseSupplierProject!.data!
                                            .projectList![i].farmerMaster!.phone ??
                                            ''  : '',
                                        projectPercent: 0,
                                        projectId: state.responseSupplierProject!.data!
                                            .projectList![i].id ?? 0,
                                        selectedFilter: 'new'

                                    ),
                                    width: screenWidth()-60),
                              ):const SizedBox.shrink();
                            }),
                      ),
                    ],
                  );
                }
              }
            ),
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
            CommunityForum(
              onTapShowAll: () {
                BlocProvider.of<DashboardCubit>(context).selectedIndex(4);
              },
            ),
            10.verticalSpace(),
            FeaturedTrainings(trainingList: state.responseSupplierDashboard!.data!.trainingList ?? [], onTapShowAll: () {
              const OnlineTraining(isBottomAppBar: false).navigate();
            },),
            10.verticalSpace(),
            TrendingNewsAndEvents(newsList: state.responseSupplierDashboard!.data!.newsEvent ?? [], onTapShowAll: () {
              const NewsAndEvent(isBottomAppBar: false).navigate();
            },),
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
