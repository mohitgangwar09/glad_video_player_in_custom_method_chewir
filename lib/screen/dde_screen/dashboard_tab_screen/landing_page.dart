import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:glad/cubit/dashboard_cubit/dashboard_cubit.dart';
import 'package:glad/screen/common/community_forum.dart';
import 'package:glad/screen/common/featured_trainings.dart';
import 'package:glad/screen/common/landing_carousel.dart';
import 'package:glad/screen/common/livestock_marketplace.dart';
import 'package:glad/screen/common/mcc_in_area.dart';
import 'package:glad/screen/common/trending_news.dart';
import 'package:glad/screen/custom_widget/custom_appbar.dart';
import 'package:glad/screen/custom_widget/custom_methods.dart';
import 'package:glad/screen/farmer_screen/drawer_screen/earnings.dart';
import 'package:glad/screen/guest_user/drawer_screen.dart';
import 'package:glad/screen/dde_screen/dde_profile.dart';
import 'package:glad/utils/color_resources.dart';
import 'package:glad/utils/extension.dart';
import 'package:glad/utils/helper.dart';
import 'package:glad/utils/images.dart';
import 'package:glad/utils/styles.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import 'package:table_calendar/table_calendar.dart';
import '../../auth_screen/login_with_password.dart';
import '../dashboard/dashboard_dde.dart';

class DDELandingPage extends StatefulWidget {
  const DDELandingPage({super.key});

  @override
  State<DDELandingPage> createState() => _DDELandingPageState();
}

class _DDELandingPageState extends State<DDELandingPage> {

  List<_ChartData> data2 = [
    _ChartData('Completed', 12),
    _ChartData('Active', 15),
    _ChartData('Pending', 02),
  ];

  @override
  Widget build(BuildContext context) {

    CalendarFormat calendarFormat = CalendarFormat.week;
    RangeSelectionMode rangeSelectionMode = RangeSelectionMode.toggledOff;

    return Container(
      color: Colors.white,
      child: Stack(
        children: [

          landingBackground(),

          Column(
            children: [
              CustomAppBar(
                context: context,
                titleText1: 'Hello ',
                titleText2: 'Abdullah',
                leading: openDrawer(
                    onTap: () {
                      ddeLandingKey.currentState?.openDrawer();
                    },
                    child: SvgPicture.asset(Images.drawer)),
                action: Row(
                  children: [
                    InkWell(onTap: () {}, child: SvgPicture.asset(Images.call)),
                    7.horizontalSpace(),
                    InkWell(
                        onTap: () {
                          const DDEProfile().navigate();
                        },
                        child: SvgPicture.asset(Images.person)),
                    8.horizontalSpace(),
                  ],
                ),
              ),
              landingPage(calendarFormat, context),

            ],
          ),

        ],
      ),
    );
  }

  Widget landingPage(calendarFormat, BuildContext context){
    return Expanded(
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const LandingCarousel(),
            10.verticalSpace(),

          farmersNearMe(context),

          Container(
            margin: const EdgeInsets.only(left: 20,right: 20),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              color: const Color(0xffE4FFE3),
              border: Border.all(color: const Color(0xffECECFF))
            ),
            child: Column(
              children: [

                Padding(
                  padding: const EdgeInsets.only(left: 5,right: 5,bottom: 5),
                  child: TableCalendar(
                    headerStyle: const HeaderStyle(
                      leftChevronIcon: Icon(Icons.arrow_back,
                      color: Colors.black,),
                      rightChevronIcon: CircleAvatar(
                        radius: 18,
                        backgroundColor: Colors.grey,
                        child: Icon(Icons.arrow_forward_rounded,
                          color: Colors.black,),
                      ),
                      formatButtonVisible: false
                    ),
                    firstDay: DateTime.utc(2010, 10, 16),
                    lastDay: DateTime.utc(2030, 3, 14),
                    focusedDay: DateTime.now(),
                    calendarFormat: calendarFormat,
                    startingDayOfWeek: StartingDayOfWeek.sunday,
                    calendarStyle: CalendarStyle(
                      selectedDecoration: BoxDecoration(
                          color: ColorResources.primary,
                          borderRadius: BorderRadiusDirectional.circular(30)),
                    ),
                  ),
                ),

                Stack(
                  children: [
                    Container(
                      // height: 105,
                      // padding: 10.paddingAll(),
                      width: screenWidth(),
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(20)),
                      child: Padding(
                        padding: const EdgeInsets.fromLTRB(12.0, 20, 12, 22),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Image.asset(Images.sampleUser),
                            15.horizontalSpace(),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text("Begumanya Charles",
                                    style: figtreeMedium.copyWith(
                                        fontSize: 16, color: Colors.black)),
                                4.verticalSpace(),

                                "Visit schedule for today".textRegular(fontSize: 12),

                                10.verticalSpace(),

                                Row(
                                  crossAxisAlignment: CrossAxisAlignment.end,
                                  children: [
                                    'Project: '.textRegular(color: Colors.grey,
                                    fontSize: 12),
                                    Text("Dam Construction",
                                        style: figtreeRegular.copyWith(
                                            fontSize: 12, color: Colors.black)),
                                  ],
                                ),
                                4.verticalSpace(),
                                Row(
                                  crossAxisAlignment: CrossAxisAlignment.end,
                                  children: [
                                    const Icon(
                                      Icons.location_on,
                                      color: Colors.black,
                                      size: 16,
                                    ),
                                    SizedBox(
                                      width:
                                      screenWidth() * 0.5,
                                      child: Text(
                                        "Plot 11, Street 09, Luwum St.Rwo",
                                        style: figtreeRegular.copyWith(
                                          fontSize: 12,
                                          color: Colors.black,
                                          overflow: TextOverflow.ellipsis,
                                        ),
                                      ),
                                    ),
                                  ],
                                )
                              ],
                            )
                          ],
                        ),
                      ),
                    ),

                    Padding(
                      padding: const EdgeInsets.all(12.0),
                      child: Align(alignment: Alignment.topRight,
                        child: "9:00 am".textRegular(color: Colors.grey,
                        fontSize: 12),),
                    )
                  ],
                ),

              ],
            ),
          ),

          30.verticalSpace(),

          pendingApplications(context),

          20.verticalSpace(),

          earningCardDetails(context),

          LiveStockMarketplace(onTapShowAll: () {},),
            10.verticalSpace(),
            CommunityForum(
              name: 'Begumanya Charles',
              location: 'Kampala, Uganda',
              image: '',
              caption: 'Lorem Ipsum has been the industry\'s standard dummy text ever since the 1500s, when an unknown printer took a galley.',
              video: '',
              timeAgo: '5 Hrs ago',
              onTapShowAll: () {},
            ),
            10.verticalSpace(),
            const FeaturedTrainings(),
            10.verticalSpace(),
            const MCCInArea(
              name: 'Begumanya Charles',
              phone: '+256 758711344',
              address:
              'Plot 11, street 09, Luwum St. Rwooz Plot 11, street 09, Luwum St. Rwooz',
              image: '',
            ),
            10.verticalSpace(),
            const TrendingNewsAndEvents(),
            100.verticalSpace(),
          ],
        ),
      ),
    );
  }

  Widget pendingApplications(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.fromLTRB(25, 0, 0, 0),
          child: Row(
            children: [
              Text(
                'Pending applications',
                style: figtreeMedium.copyWith(fontSize: 18),
              ),
              10.horizontalSpace(),
              'View All'.textSemiBold(color: ColorResources.maroon, fontSize: 12, underLine: TextDecoration.underline)
            ],
          ),
        ),

        Container(
                margin: const EdgeInsets.only(left: 10, right: 20),
                height: 220,
                child: customList(
                    list: List.generate(
                        3, (index) => index),
                    axis: Axis.horizontal,
                    child: (int i) {
                      return SizedBox(
                        width: screenWidth() * 0.9,
                        child: Stack(
                          children: [
                            InkWell(
                              onTap: (){
                              },
                              child: customProjectContainer(
                                child: Padding(
                                  padding:
                                  const EdgeInsets.all(20),
                                  child: Column(
                                    children: [
                                      Row(
                                        crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                        children: [
                                          Image.asset(Images.sampleUser),
                                          15.horizontalSpace(),
                                          Column(
                                            crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                            children: [
                                              Text('Hurton Elizabeth',
                                                  style: figtreeMedium.copyWith(
                                                      fontSize: 16,
                                                      color: Colors.black)),
                                              4.verticalSpace(),
                                              Text('+256 758711344',
                                                  style:
                                                  figtreeRegular.copyWith(
                                                      fontSize: 12,
                                                      color: Colors.black)),
                                              4.verticalSpace(),
                                              Row(
                                                crossAxisAlignment:
                                                CrossAxisAlignment.end,
                                                children: [
                                                  SizedBox(
                                                    width: MediaQuery.of(context)
                                                        .size
                                                        .width *
                                                        0.5,
                                                    child: Text(
                                                      "Luwum St. Rwoozi, Kampala...",
                                                      style:
                                                      figtreeRegular.copyWith(
                                                        fontSize: 12,
                                                        color: Colors.black,
                                                        overflow:
                                                        TextOverflow.ellipsis,
                                                      ),
                                                    ),
                                                  ),
                                                ],
                                              )
                                            ],
                                          )
                                        ],
                                      ),
                                      20.verticalSpace(),
                                      Row(
                                        mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                        children: [
                                          Column(
                                            mainAxisAlignment:
                                            MainAxisAlignment.center,
                                            crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                            children: [
                                              'UGX 100M'.textSemiBold(
                                                  color: Colors.black,
                                                  fontSize: 16),
                                              'Investment'.textMedium(
                                                  fontSize: 10,
                                                  color: const Color(
                                                      0xff808080)),
                                            ],
                                          ),
                                          Column(
                                            mainAxisAlignment:
                                            MainAxisAlignment.center,
                                            crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                            children: [
                                              'UGX 20M'.textSemiBold(
                                                  color: Colors.black,
                                                  fontSize: 16),
                                              'Revenue'.textMedium(
                                                  fontSize: 10,
                                                  color: const Color(
                                                      0xff808080)),
                                            ],
                                          ),
                                          Column(
                                            mainAxisAlignment:
                                            MainAxisAlignment.center,
                                            crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                            children: [
                                              ' 200%'.textSemiBold(
                                                  color: Colors.black,
                                                  fontSize: 16),
                                              'ROI'.textMedium(
                                                  fontSize: 10,
                                                  color: const Color(
                                                      0xff808080)),
                                            ],
                                          ),
                                        ],
                                      ),
                                      20.verticalSpace(),
                                      Row(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        mainAxisAlignment: MainAxisAlignment.start,
                                        children: [
                                          Column(
                                            crossAxisAlignment: CrossAxisAlignment.start,
                                            children: [
                                            "Dam Construction"
                                                .textMedium(fontSize: 12),
                                            2.verticalSpace(),
                                            'Suggested project'.textMedium(color: Color(0xFF808080), fontSize: 10)
                                          ],),
                                          Container(
                                            margin: 9.marginOnly(top: 0, bottom: 9),
                                            padding:
                                            const EdgeInsets.symmetric(
                                                vertical: 4,
                                                horizontal: 7),
                                            decoration: boxDecoration(
                                              borderRadius: 30,
                                              borderColor:
                                              const Color(0xff6A0030),
                                            ),
                                            child: Text(
                                              "Suggested",
                                              textAlign: TextAlign.center,
                                              style: figtreeMedium.copyWith(
                                                  color:
                                                  const Color(0xff6A0030),
                                                  fontSize: 10),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                            Positioned(
                                top: 0,
                                right: 0,
                                child: Row(
                                  children: [
                                    SvgPicture.asset(Images.callPrimary),
                                    6.horizontalSpace(),
                                    SvgPicture.asset(Images.whatsapp),
                                    6.horizontalSpace(),
                                    SvgPicture.asset(Images.redirectLocation),
                                    4.horizontalSpace(),
                                  ],
                                )),
                          ],
                        ),
                      );
                    }),
              ),

        Padding(
          padding: const EdgeInsets.all(20),
          child: customShadowContainer(
            margin: 0,
            child: Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text('Total projects',
                          style:
                          figtreeMedium.copyWith(fontSize: 14)),
                      'View Details'.textSemiBold(color: ColorResources.maroon, fontSize: 12, underLine: TextDecoration.underline)
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        child: SizedBox(
                          height: 120,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              '29'.textBold(fontSize: 39),
                              Wrap(
                                spacing: 5,
                                runSpacing: 5,
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
                                              fontSize: 14)),
                                      Text(data2[0].y.toInt().toString(),
                                          style: figtreeBold.copyWith(
                                              fontSize: 14)),
                                    ],
                                  ),
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
                                              fontSize: 14)),
                                      Text(data2[1].y.toInt().toString(),
                                          style: figtreeBold.copyWith(
                                              fontSize: 14)),
                                    ],
                                  ),
                                  Row(
                                    children: [
                                      Container(
                                        height: 13,
                                        width: 9,
                                        decoration: BoxDecoration(
                                            color: Color(0xFFFC5E60),
                                            borderRadius:
                                            BorderRadius.circular(10)),
                                      ),
                                      7.horizontalSpace(),
                                      Text('${data2[2].x}: ',
                                          style: figtreeRegular.copyWith(
                                              fontSize: 14)),
                                      Text(data2[2].y.toInt().toString(),
                                          style: figtreeBold.copyWith(
                                              fontSize: 14)),
                                    ],
                                  )
                                ],
                              ),

                            ],
                          ),
                        ),
                      ),
                      Expanded(
                        child: Stack(
                          alignment: Alignment.center,
                          children: [
                            SizedBox(
                              height: 140,
                              child: SfCircularChart(
                                  palette: const [
                                    ColorResources.maroon,
                                    ColorResources.mustard,
                                    Color(0xFFFC5E60)
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
                                child: Column(
                                  children: [
                                    Row(
                                      mainAxisAlignment:
                                      MainAxisAlignment.center,
                                      children: [
                                        "33".textBold(
                                            color: Colors.black, fontSize: 26),
                                        "%".textBold(
                                            color: Colors.black, fontSize: 12)
                                      ],
                                    ),
                                    "Complete".textRegular(
                                        color: Colors.black, fontSize: 10),
                                  ],
                                )),
                          ],
                        ),
                      ),
                    ],
                  ),

                ],
              ),
            ),
          ),
        )
      ],
    );
  }

  Widget farmersNearMe(BuildContext context){
    return Padding(
      padding: const EdgeInsets.only(left: 20.0,right: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          15.verticalSpace(),

          "Farmers near me".textMedium(fontSize: 18),

          10.verticalSpace(),

          InkWell(
            onTap: () =>  BlocProvider.of<DashboardCubit>(context).selectedIndex(1),
            child: Row(
              children: [
                Expanded(
                  child: customShadowContainer(
                      margin: 0,
                      backColor: const Color(0xffFF8A8B),
                      width: 105,
                      child: Padding(
                        padding: const EdgeInsets.fromLTRB(8, 4, 4, 8),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [

                            Align(
                              alignment: Alignment.centerRight,
                              child: SvgPicture.asset(Images.critical),
                            ),

                            Padding(
                              padding: const EdgeInsets.only(left: 8.0, bottom: 8),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [

                                  "04".textSemiBold(fontSize: 26),
                                  3.verticalSpace(),
                                  "Critical".textRegular(fontSize: 12),

                                ],
                              ),
                            )

                          ],
                        ),
                      )),
                ),
                10.horizontalSpace(),
                Expanded(
                  child: customShadowContainer(
                      margin: 0,
                      backColor: const Color(0xffFFC640),
                      width: 105,
                      child: Padding(
                        padding: const EdgeInsets.fromLTRB(8, 4, 4, 8),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [

                            Align(
                              alignment: Alignment.centerRight,
                              child: SvgPicture.asset(Images.average),
                            ),

                            Padding(
                              padding: const EdgeInsets.only(left: 8.0, bottom: 8),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [

                                  "05".textSemiBold(fontSize: 26),
                                  3.verticalSpace(),
                                  "Average".textRegular(fontSize: 12),

                                ],
                              ),
                            )

                          ],
                        ),
                      )),
                ),
                10.horizontalSpace(),
                Expanded(
                  child: customShadowContainer(
                      margin: 0,
                      backColor: const Color(0xff4BC56F),
                      width: 105,
                      child: Padding(
                        padding: const EdgeInsets.fromLTRB(8, 4, 4, 8),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [

                            Align(
                              alignment: Alignment.centerRight,
                              child: SvgPicture.asset(Images.satisfactory),
                            ),

                            Padding(
                              padding: const EdgeInsets.only(left: 8.0, bottom: 8),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [

                                  "02".textSemiBold(fontSize: 26),
                                  3.verticalSpace(),
                                  "Satisfactory".textRegular(fontSize: 12),

                                ],
                              ),
                            )

                          ],
                        ),
                      )),
                ),
              ],
            ),
          ),

          37.verticalSpace(),

        ],
      ),
    );
  }

  Widget earningCardDetails(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.fromLTRB(25, 0, 0, 0),
          child: Text(
            'Earning (30 days)',
            style: figtreeMedium.copyWith(fontSize: 18),
          ),
        ),
        10.verticalSpace(),
        InkWell(
          onTap: () {
            const Earnings().navigate();
          },
          child: Padding(
            padding: const EdgeInsets.fromLTRB(18, 0, 24, 0),
            child: Column(
              children: [
                Stack(
                  children: [
                    SizedBox(
                      height: 152,
                      child: Column(
                        children: [
                          Container(
                            decoration: BoxDecoration(boxShadow: [
                              BoxShadow(
                                  color: Colors.grey.withOpacity(.100),
                                  blurRadius: 15),
                            ]),
                            child: Card(
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(20)),
                              color: const Color(0xffFFB300),
                              child: Column(children: [
                                Row(
                                  mainAxisAlignment:
                                  MainAxisAlignment.spaceBetween,
                                  children: [
                                    Padding(
                                      padding:
                                      const EdgeInsets.fromLTRB(10, 0, 0, 0),
                                      child: Text(
                                        'UGX 3.2M',
                                        style: figtreeBold.copyWith(fontSize: 28),
                                      ),
                                    ),
                                    SvgPicture.asset(Images.arrowPercent)
                                  ],
                                ),
                                Padding(
                                  padding:
                                  const EdgeInsets.fromLTRB(10, 10, 20, 20),
                                  child: Row(
                                    mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                    children: [
                                      Row(
                                        children: [
                                          Container(
                                            width: 82,
                                            height: 38,
                                            decoration: BoxDecoration(
                                                border: Border.all(
                                                    width: 2,
                                                    color: Colors.white),
                                                color: const Color(0xff12CE57),
                                                borderRadius:
                                                BorderRadius.circular(40)),
                                            child: Padding(
                                              padding: const EdgeInsets.fromLTRB(
                                                  3, 0, 4, 0),
                                              child: Row(
                                                children: [
                                                  const Icon(Icons.trending_up,
                                                      size: 25, color: Colors.white),
                                                  Text(
                                                    '+5.0%',
                                                    style: figtreeBold.copyWith(
                                                        fontSize: 13, color: Colors.white),
                                                  )
                                                ],
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                      Row(
                                        children: [
                                          Row(
                                            children: [
                                              Text(
                                                'Due:',
                                                style: figtreeSemiBold.copyWith(
                                                    fontSize: 14),
                                              ),
                                              05.horizontalSpace(),
                                              Text(
                                                '150K',
                                                style: figtreeSemiBold.copyWith(
                                                    fontSize: 14),
                                              ),
                                            ],
                                          ),
                                          10.horizontalSpace(),
                                          const CircleAvatar(
                                            radius: 4,
                                            backgroundColor: Colors.black,
                                          ),
                                          10.horizontalSpace(),
                                          Row(
                                            children: [
                                              Text(
                                                'Pending:',
                                                style: figtreeSemiBold.copyWith(
                                                    fontSize: 14),
                                              ),
                                              05.horizontalSpace(),
                                              Text(
                                                '150K',
                                                style: figtreeSemiBold.copyWith(
                                                    fontSize: 14),
                                              )
                                            ],
                                          )
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                              ]),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Positioned(
                      bottom: 0,
                      right: 10,
                      left: 10,
                      child: SvgPicture.asset(Images.cardImage),
                    )
                  ],
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}

class _ChartData {
  _ChartData(this.x, this.y);

  final String x;
  final double y;
}