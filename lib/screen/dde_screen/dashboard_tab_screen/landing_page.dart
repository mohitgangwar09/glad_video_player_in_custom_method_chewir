import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:glad/cubit/dashboard_cubit/dashboard_cubit.dart';
import 'package:glad/cubit/dde_enquiry_cubit/dde_enquiry_cubit.dart';
import 'package:glad/cubit/dde_farmer_cubit/dde_farmer_cubit.dart';
import 'package:glad/cubit/landing_page_cubit/landing_page_cubit.dart';
import 'package:glad/cubit/profile_cubit/profile_cubit.dart';
import 'package:glad/cubit/project_cubit/project_cubit.dart';
import 'package:glad/data/model/dde_visitor_details.dart';
import 'package:glad/screen/common/community_forum.dart';
import 'package:glad/screen/common/featured_trainings.dart';
import 'package:glad/screen/common/landing_carousel.dart';
import 'package:glad/screen/custom_loan/custom_loan_list.dart';
import 'package:glad/screen/dde_livestock/dde_livestock_screen.dart';
import 'package:glad/screen/livestock/livestock_marketplace.dart';
import 'package:glad/screen/common/mcc_in_area.dart';
import 'package:glad/screen/common/trending_news.dart';
import 'package:glad/screen/custom_widget/custom_appbar.dart';
import 'package:glad/screen/custom_widget/custom_methods.dart';
import 'package:glad/screen/dde_screen/dde_earning_statement.dart';
import 'package:glad/screen/dde_screen/dde_farmer_detail.dart';
import 'package:glad/screen/dde_screen/suggested_investment.dart';
import 'package:glad/screen/farmer_screen/dashboard_tab_screen/statement.dart';
import 'package:glad/screen/farmer_screen/drawer_screen/earnings.dart';
import 'package:glad/screen/dde_screen/dde_profile.dart';
import 'package:glad/screen/farmer_screen/online_training.dart';
import 'package:glad/screen/guest_user/dashboard_tab_screen/news_and_event.dart';
import 'package:glad/screen/livestock/livestock_screen.dart';
import 'package:glad/utils/color_resources.dart';
import 'package:glad/utils/extension.dart';
import 'package:glad/utils/images.dart';
import 'package:glad/utils/styles.dart';
import 'package:intl/intl.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import 'package:table_calendar/table_calendar.dart';
import '../dashboard/dashboard_dde.dart';

class DDELandingPage extends StatefulWidget {
  const DDELandingPage({super.key});

  @override
  State<DDELandingPage> createState() => _DDELandingPageState();
}


class _DDELandingPageState extends State<DDELandingPage> {

  int activeIndex = 0;

  // List<_ChartData> data2 = [
  //   _ChartData('Completed', 12),
  //   _ChartData('Active', 15),
  //   _ChartData('Pending', 02),
  // ];

  String projectPercentage = "0";
  String projectText = 'completed';

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {

      BlocProvider.of<LandingPageCubit>(context).ddeDashboardApi(context).then((value) {
        LandingPageState state = BlocProvider.of<LandingPageCubit>(context).state;
        int projectsSum = state.responseDdeDashboard!.data!.projectSummary!.completed!.toInt() +
            state.responseDdeDashboard!.data!.projectSummary!.active!.toInt() +
            state.responseDdeDashboard!.data!.projectSummary!.pending!.toInt();
        int projectActive = state.responseDdeDashboard!.data!.projectSummary!.active!.toInt();
        int projectCompleted = state.responseDdeDashboard!.data!.projectSummary!.completed!.toInt();
        int projectPending = state.responseDdeDashboard!.data!.projectSummary!.pending!.toInt();
        if(projectsSum != 0) {
          if(projectCompleted != 0) {
            projectPercentage = removeZeroesInFraction(((projectCompleted / projectsSum) * 100).toString());
            projectText = 'completed';
          } else if(projectActive != 0) {
            projectPercentage = removeZeroesInFraction(((projectActive / projectsSum) * 100).toString());
            projectText = 'active';
          } else {
            projectPercentage = removeZeroesInFraction(((projectPending / projectsSum) * 100).toString());
            projectText = "pending";
          }
        }
      });
      if(BlocProvider.of<ProfileCubit>(context).state.responseProfile == null) {
        BlocProvider.of<ProfileCubit>(context).profileApi(context);
      }
      BlocProvider.of<ProjectCubit>(context).accountStatementApi(context, '');
      BlocProvider.of<DdeFarmerCubit>(context).selectRagRating('');
      BlocProvider.of<ProfileCubit>(context).userRatingApi(context);
      BlocProvider.of<ProfileCubit>(context).ddeTargetMonthsApi(context);
      BlocProvider.of<ProjectCubit>(context).ddeProjectsApi(context, 'pending', false);

    });
  }

  @override
  Widget build(BuildContext context) {

    CalendarFormat calendarFormat = CalendarFormat.week;
    RangeSelectionMode rangeSelectionMode = RangeSelectionMode.toggledOff;

    return BlocBuilder<LandingPageCubit, LandingPageState>(
      builder: (context, state) {
        if (state.status == LandingPageStatus.loading) {
          return const Center(
              child: CircularProgressIndicator(
                color: ColorResources.maroon,
              ));
        } else if (state.responseDdeDashboard == null) {
          return const Center(child: Text("Low Connectivity. Please check your internet Connection"));
          // return Center(child: Text("${state.responseDdeDashboard} Api Error"));
        } else {
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
                      titleText2: (state.responseDdeDashboard!.data != null) ? (state.responseDdeDashboard!.data!.dde!.name ?? '') : '',
                      leading: openDrawer(
                          onTap: () {
                            ddeLandingKey.currentState?.openDrawer();
                          },
                          child: SvgPicture.asset(Images.drawer)),
                      action: Row(
                        children: [
                          phoneCall(256758711344),
                          7.horizontalSpace(),
                          InkWell(
                              onTap: () {
                                const DDEProfile().navigate();
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
                                    (state.responseDdeDashboard!.data != null) ? (state.responseDdeDashboard!.data!.dde!.photo ?? '') : '',
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
                    landingPage(calendarFormat, context, state),

                  ],
                ),

              ],
            ),
          );
        }
      }
    );
  }

  Widget landingPage(calendarFormat, BuildContext context, LandingPageState state){
    return Expanded(
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            LandingCarousel(todayMilkPrice:state.responseDdeDashboard!.data!.todayMilkPrice!=null?state.responseDdeDashboard!.data!.todayMilkPrice!.milkPrice??0:0),
            10.verticalSpace(),

          farmersNearMe(context, state),

          state.responseFarmerVisitor != null ? Container(
            margin: const EdgeInsets.only(left: 20,right: 20),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              color: const Color(0xffE4FFE3),
              border: Border.all(color: const Color(0xffECECFF))
            ),
            child: Column(
              children: [
                if(state.responseFarmerVisitor!.data != null)
                Padding(
                  padding: const EdgeInsets.only(left: 5,right: 5,bottom: 5),
                  child: TableCalendar<DDEVisitorDetails>(
                    headerStyle: const HeaderStyle(
                      leftChevronIcon: Icon(Icons.arrow_back,
                      color: Colors.black),
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
                    focusedDay: state.selectedFarmerVisitDate!,
                    currentDay: state.selectedFarmerVisitDate,
                    calendarFormat: calendarFormat,
                    startingDayOfWeek: StartingDayOfWeek.sunday,
                    calendarStyle: CalendarStyle(
                      selectedDecoration: BoxDecoration(
                          color: ColorResources.maroon,
                          borderRadius: BorderRadiusDirectional.circular(12),
                      shape: BoxShape.rectangle),
                      markersMaxCount: 1,
                      markerSize: 5,
                      markerDecoration: const BoxDecoration(color: ColorResources.maroon, shape: BoxShape.circle),
                    ),
                    eventLoader: (date) {
                      Map<String, dynamic> data = state.responseFarmerVisitor!.data as Map<String, dynamic>;
                      String eventDate = DateFormat('yyyy-MM-dd').format(date);
                      if(data.containsKey(eventDate)) {
                        List<DDEVisitorDetails> dataData = [];
                        for (var element in data[eventDate]) {
                          dataData.add(DDEVisitorDetails.fromJson(element));
                        }
                        return dataData;
                      } else {
                        return [];
                      }
                    },
                    onDaySelected: (date, _) {
                      context.read<LandingPageCubit>().emit(state.copyWith(selectedFarmerVisitDate: date));
                      if(state.selectedFarmerVisitDate!.compareTo(date) != 0){
                        setState(() {
                          activeIndex = 0;
                        });
                      }
                    },
                    selectedDayPredicate: (date) {
                      Map<String, dynamic> data = state.responseFarmerVisitor!.data as Map<String, dynamic>;
                      String eventDate = DateFormat('yyyy-MM-dd').format(date);
                      if(data.containsKey(eventDate) && state.selectedFarmerVisitDate!.compareTo(date) == 0) {
                        return true;
                      } else {
                        return false;
                      }
                    },
                  ),
                ),
                if(state.responseFarmerVisitor!.data != null)
                (state.responseFarmerVisitor!.data as Map<String, dynamic>).containsKey(DateFormat('yyyy-MM-dd').format(state.selectedFarmerVisitDate!))
                    ? Builder(
                  builder: (context) {
                    List<DDEVisitorDetails> data = [];
                    for (var element in (state.responseFarmerVisitor!.data as Map<String, dynamic>)[DateFormat('yyyy-MM-dd').format(state.selectedFarmerVisitDate!)]) {
                      data.add(DDEVisitorDetails.fromJson(element));
                    }
                    return Container(
                      color: Colors.white,
                      child: Column(
                        children: [
                          SizedBox(
                            height: 130,
                            width: screenWidth(),
                            child: CarouselSlider(
                                items: data.map((detail) => InkWell(
                                  onTap: (){
                                    BlocProvider.of<LandingPageCubit>(context).getCurrentLocation();
                                    BlocProvider.of<ProfileCubit>(context).emit(ProfileCubitState.initial());
                                    DDeFarmerInvestmentDetails(projectId: detail.farmerProject!.id,
                                      // farmerDetail:farmerDetail
                                    ).navigate();

                                    // DdeFarmerDetail(userId: detail.farmerMaster!.userId!,farmerId:detail.farmerMaster!.id!).navigate();
                                  },

                                  child: Container(
                                    width: screenWidth(),
                                    decoration: BoxDecoration(
                                        color: Colors.white,
                                        borderRadius: BorderRadius.circular(20)),
                                    child: Padding(
                                      padding: const EdgeInsets.fromLTRB(12.0, 20, 12, 22),
                                      child: Row(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          ClipRRect(
                                            borderRadius: BorderRadius.circular(1000),
                                            child: Container(
                                              height: AppBar().preferredSize.height * 0.7,
                                              width: AppBar().preferredSize.height * 0.7,
                                              decoration:
                                              const BoxDecoration(shape: BoxShape.circle),
                                              child: CachedNetworkImage(
                                                imageUrl: detail.farmerMaster != null ? detail.farmerMaster!.photo ?? '' : '',
                                                errorWidget: (_, __, ___) =>
                                                    Image.asset(Images.sampleUser),
                                                fit: BoxFit.cover,
                                              ),
                                            ),
                                          ),
                                          15.horizontalSpace(),
                                          Column(
                                            crossAxisAlignment: CrossAxisAlignment.start,
                                            children: [
                                              Text(detail.farmerMaster != null ? detail.farmerMaster!.name ?? '' : '',
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
                                                  Text(detail.farmerProject != null ? detail.farmerProject!.name ?? '' : '',
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
                                                      detail.farmerMaster != null ? detail.farmerMaster!.address ?? '' : '',
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
                                )).toList(),
                                options: CarouselOptions(
                              autoPlay: false,
                              enableInfiniteScroll: false,
                              viewportFraction: 1,
                              // enlargeCenterPage: true,
                              onPageChanged: (index, reason) {
                                setState(() {
                                  activeIndex = index;
                                });
                              },
                            )),
                          ),
                          Center(
                            child: Padding(
                              padding: const EdgeInsets.all(5),
                              child: AnimatedSmoothIndicator(
                                activeIndex: activeIndex,
                                count: data.length,
                                effect: const WormEffect(
                                    activeDotColor: ColorResources.maroon,
                                    dotHeight: 7,
                                    dotWidth: 7,
                                    dotColor: ColorResources.grey),
                              ),
                            ),
                          ),
                        ],
                      ),
                    );
                  }
                ) : Container(
                    height: 130,
                    width: screenWidth(),
                    padding: const EdgeInsets.fromLTRB(12.0, 20, 12, 22),
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(20)),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text('No Visit Schedule available for today', style: figtreeMedium.copyWith(fontSize: 14),),
                      ],
                    )),

              ],
            ),
          ) : const SizedBox.shrink(),

          30.verticalSpace(),

          pendingApplications(context, state),

          20.verticalSpace(),

          earningCardDetails(context),

            20.verticalSpace(),
            ddeTarget(context, BlocProvider.of<ProfileCubit>(context).state),
            30.verticalSpace(),
            InkWell(
                onTap: () {
                  const CustomLoanList().navigate();
                },
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Image.asset(Images.customLoan),
                )),

            LiveStockMarketplace(onTapShowAll: () {
              const DdeLiveStockScreen().navigate();
            },),

            10.verticalSpace(),
            CommunityForum(
              onTapShowAll: () {
                BlocProvider.of<DashboardCubit>(context).selectedIndex(4);
              },
            ),
            10.verticalSpace(),
            FeaturedTrainings(trainingList: state.responseDdeDashboard!.data!.trainingList ?? [], onTapShowAll: () {
              const OnlineTraining(isBottomAppBar: false).navigate();
            },),
            10.verticalSpace(),
            MCCInArea(
              name: state.responseDdeDashboard!.data!.mcc!.name ?? '',
              phone: state.responseDdeDashboard!.data!.mcc!.phone ?? '',
              address: state.responseDdeDashboard!.data!.mcc!.address != null ? state.responseDdeDashboard!.data!.mcc!.address["address"] ?? '' : '',
              image: state.responseDdeDashboard!.data!.mcc!.photo ?? '',
              lat: state.responseDdeDashboard!.data!.mcc!.address != null ? state.responseDdeDashboard!.data!.mcc!.address["latitude"] ?? '' : '',
              long: state.responseDdeDashboard!.data!.mcc!.address != null ? state.responseDdeDashboard!.data!.mcc!.address["longitude"] ?? '' : '',
            ),
            10.verticalSpace(),
            TrendingNewsAndEvents(newsList: state.responseDdeDashboard!.data!.newsEvent ?? [], onTapShowAll: () {
              const NewsAndEvent(isBottomAppBar: false,).navigate();
            },),
            100.verticalSpace(),
          ],
        ),
      ),
    );
  }

  Widget pendingApplications(BuildContext context, LandingPageState landingState) {
    ProjectState state = BlocProvider.of<ProjectCubit>(context).state;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if(state.responseDdeProject!=null)
        state.responseDdeProject!.data!.projectList!.isNotEmpty
            ? Column(
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
                  InkWell(
                    onTap: () {
                      BlocProvider.of<DashboardCubit>(context).selectedIndex(2);
                    },
                    child: 'View All'.textSemiBold(color: ColorResources.maroon, fontSize: 12, underLine: TextDecoration.underline),
                  )
                ],
              ),
            ),

            Container(
              margin: const EdgeInsets.only(left: 10, right: 20),
              height: 220,
              child: customList(
                  list: List.generate(
                      state.responseDdeProject!.data!
                          .projectList!.length < 5 ? state.responseDdeProject!.data!
                          .projectList!.length : 5, (index) => index),
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
                                        networkImage(text: state.responseDdeProject!.data!
                                            .projectList![i].farmerMaster!= null ? state.responseDdeProject!.data!
                                            .projectList![i].farmerMaster!.photo ??
                                            ''  : '',height: 46,width: 46,radius: 40),
                                        15.horizontalSpace(),
                                        Column(
                                          crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                          children: [
                                            Text(state.responseDdeProject!.data!
                                                .projectList![i].farmerMaster!= null ? state.responseDdeProject!.data!
                                                .projectList![i].farmerMaster!.name ?? '' : '',
                                                style: figtreeMedium.copyWith(
                                                    fontSize: 16,
                                                    color: Colors.black)),
                                            4.verticalSpace(),
                                            Text(state.responseDdeProject!.data!
                                                .projectList![i].farmerMaster!= null ? state.responseDdeProject!.data!
                                                .projectList![i].farmerMaster!.phone ??
                                                ''  : '',
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
                                                    state.responseDdeProject!.data!
                                                        .projectList![i].farmerMaster!= null ? state.responseDdeProject!.data!
                                                        .projectList![i].farmerMaster!.address!=null?state.responseDdeProject!.data!
                                                        .projectList![i].farmerMaster!.address!.address.toString():"" ??
                                                        '' : '',
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
                                            (getCurrencyString(state.responseDdeProject!.data!
                                                .projectList![i].investmentAmount ?? 0)).textSemiBold(
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
                                            (getCurrencyString(state.responseDdeProject!.data!
                                                .projectList![i].revenuePerYear ?? 0)).textSemiBold(
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
                                            ('${state.responseDdeProject!.data!
                                                .projectList![i].roiPerYear ?? 0.0}%').textSemiBold(
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
                                            state.responseDdeProject!.data!
                                                .projectList![i].name.toString()
                                                .textMedium(fontSize: 12),
                                            2.verticalSpace(),
                                            'Suggested project'.textMedium(color: const Color(0xFF808080), fontSize: 10)
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
                                            formatProjectStatus(state.responseDdeProject!.data!
                                                .projectList![i].projectStatus ?? ''),
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
                                  InkWell(
                                      onTap: () async {
                                        await callOnMobile(state.responseDdeProject!.data!
                                            .projectList![i].farmerMaster!.phone ?? 12345678);
                                      },
                                      child: SvgPicture.asset(Images.callPrimary)),
                                  6.horizontalSpace(),
                                  InkWell(
                                      onTap: () async {
                                        await launchWhatsApp(state.responseDdeProject!.data!
                                            .projectList![i].farmerMaster!.phone ?? 12345678);
                                      },
                                      child: SvgPicture.asset(Images.whatsapp)),
                                  6.horizontalSpace(),
                                  InkWell(onTap: (){
                                    if(state.responseDdeProject!.data!
                                        .projectList![i].farmerMaster!.address!=null){
                                      BlocProvider.of<DdeEnquiryCubit>(context).launchURL(
                                          state.responseDdeProject!.data!
                                              .projectList![i].farmerMaster!.address!.latitude.toString(),
                                          state.responseDdeProject!.data!
                                              .projectList![i].farmerMaster!.address!.longitude.toString(),context);
                                    }
                                  },child: SvgPicture.asset(Images.redirectLocation)),
                                  4.horizontalSpace(),
                                ],
                              )),
                        ],
                      ),
                    );
                  }),
            ),
          ],
        ) : const SizedBox.shrink(),

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
                      InkWell(onTap: () {
                        BlocProvider.of<DashboardCubit>(context).selectedIndex(2);
                      },child: 'View Details'.textSemiBold(color: ColorResources.maroon, fontSize: 12, underLine: TextDecoration.underline),)
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
                              landingState.responseDdeDashboard!.data!.projectSummary!.totalProject.toString().textBold(fontSize: 39),
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
                                      Text('Completed: ',
                                          style: figtreeRegular.copyWith(
                                              fontSize: 14)),
                                      Text(landingState.responseDdeDashboard!.data!.projectSummary!.completed!.toString(),
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
                                      Text('Active: ',
                                          style: figtreeRegular.copyWith(
                                              fontSize: 14)),
                                      Text(landingState.responseDdeDashboard!.data!.projectSummary!.active!.toString(),
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
                                            color: const Color(0xFFFC5E60),
                                            borderRadius:
                                            BorderRadius.circular(10)),
                                      ),
                                      7.horizontalSpace(),
                                      Text('Pending: ',
                                          style: figtreeRegular.copyWith(
                                              fontSize: 14)),
                                      Text(landingState.responseDdeDashboard!.data!.projectSummary!.pending!.toString(),
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
                                        dataSource: [
                                          _ChartData('Completed', landingState.responseDdeDashboard!.data!.projectSummary!.completed!.toDouble()),
                                          _ChartData('Active', landingState.responseDdeDashboard!.data!.projectSummary!.active!.toDouble()),
                                          _ChartData('Pending', landingState.responseDdeDashboard!.data!.projectSummary!.pending!.toDouble()),
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
                                          projectPercentage = removeZeroesInFraction(((double.parse((detail.dataPoints![detail.pointIndex!] as ChartPoint).text.toString()).toInt() / (double.parse((detail.dataPoints![0] as ChartPoint).text.toString()).toInt() + double.parse((detail.dataPoints![1] as ChartPoint).text.toString()).toInt() + double.parse((detail.dataPoints![2] as ChartPoint).text.toString()).toInt())) * 100).toString());
                                          if(detail.pointIndex == 0) {
                                            projectText = 'completed';
                                          } else if(detail.pointIndex == 1) {
                                            projectText = 'active';
                                          } else {
                                            projectText = 'pending';
                                          }
                                          setState(() {});
                                        }),
                                  ]),
                            ),
                            Positioned(
                                child: Column(
                                  children: [
                                    Row(
                                      mainAxisAlignment:
                                      MainAxisAlignment.center,
                                      children: [
                                        projectPercentage.textBold(
                                            color: Colors.black, fontSize: 26),
                                        "%".textBold(
                                            color: Colors.black, fontSize: 12)
                                      ],
                                    ),
                                    projectText.textRegular(
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

  Widget farmersNearMe(BuildContext context, LandingPageState state){
    return Padding(
      padding: const EdgeInsets.only(left: 20.0,right: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          15.verticalSpace(),

          "Farmers near me".textMedium(fontSize: 18),

          10.verticalSpace(),

          Row(
            children: [
              Expanded(
                child: InkWell(
                  onTap: (){
                    BlocProvider.of<DashboardCubit>(context).selectedIndex(1);
                    BlocProvider.of<DdeFarmerCubit>(context).selectRagRating('Critical'.toLowerCase());
                  },
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

                                  "${state.responseDdeDashboard!.data!=null?state.responseDdeDashboard!.data!.ragratingTypeStatus!.critical:''}".textSemiBold(fontSize: 26),
                                  3.verticalSpace(),
                                  "Critical".textRegular(fontSize: 12),

                                ],
                              ),
                            )

                          ],
                        ),
                      )),
                ),
              ),
              10.horizontalSpace(),
              Expanded(
                child: InkWell(
                  onTap: (){
                    BlocProvider.of<DashboardCubit>(context).selectedIndex(1);
                    BlocProvider.of<DdeFarmerCubit>(context).selectRagRating('Average'.toLowerCase());
                  },
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

                                  "${state.responseDdeDashboard!.data!=null?state.responseDdeDashboard!.data!.ragratingTypeStatus!.average:''}".textSemiBold(fontSize: 26),
                                  3.verticalSpace(),
                                  "Average".textRegular(fontSize: 12),

                                ],
                              ),
                            )

                          ],
                        ),
                      )),
                ),
              ),
              10.horizontalSpace(),
              Expanded(
                child: InkWell(
                  onTap: (){
                    BlocProvider.of<DashboardCubit>(context).selectedIndex(1);
                    BlocProvider.of<DdeFarmerCubit>(context).selectRagRating('Satisfactory'.toLowerCase());
                  },
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

                                  "${state.responseDdeDashboard!.data!=null?state.responseDdeDashboard!.data!.ragratingTypeStatus!.satisfactory:''}".textSemiBold(fontSize: 26),
                                  3.verticalSpace(),
                                  "Satisfactory".textRegular(fontSize: 12),

                                ],
                              ),
                            )

                          ],
                        ),
                      )),
                ),
              ),
            ],
          ),

          37.verticalSpace(),

        ],
      ),
    );
  }

  ///////////EarningCardDetails/////////
  Widget earningCardDetails(BuildContext context) {
    return BlocBuilder<ProjectCubit,ProjectState>(
        builder: (context,state) {
          if (state.status == ProjectStatus.loading) {
            return const Center(
                child: CircularProgressIndicator(
                  color: ColorResources.maroon,
                ));
          } else if (state.responseAccountStatement == null) {
            return const SizedBox.shrink();
          }else{
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.fromLTRB(25, 0, 0, 0),
                  child: Text(
                    'Earning',
                    style: figtreeMedium.copyWith(fontSize: 18),
                  ),
                ),
                10.verticalSpace(),
                Padding(
                  padding: const EdgeInsets.fromLTRB(18, 0, 24, 0),
                  child: InkWell(
                    onTap: (){
                      const DdeEarningDetails().navigate();
                    },
                    child: Column(
                      children: [
                        Stack(
                          children: [
                            SizedBox(
                              height: 170,
                              child: Column(
                                children: [
                                  Container(
                                    // padding: const EdgeInsets.only(left: 10),
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
                                                getCurrencyString(state.responseAccountStatement!.data!.summary!.paidAmount!=null?state.responseAccountStatement!.data!.summary!.paidAmount!:0),
                                                style: figtreeBold.copyWith(fontSize: 28),
                                              ),
                                            ),
                                            SvgPicture.asset(Images.arrowPercent)
                                          ],
                                        ),
                                        Row(
                                          children: [
                                            Container(
                                              width: 82,
                                              height: 38,
                                              margin: const EdgeInsets.only(left: 10),
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
                                                      '+${state.responseAccountStatement!.data!.summary!.earningIncrement!=null?state.responseAccountStatement!.data!.summary!.earningIncrement!:0}%',
                                                      style: figtreeBold.copyWith(
                                                          fontSize: 13, color: Colors.white),
                                                    )
                                                  ],
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                        5.verticalSpace(),
                                        Padding(
                                          padding:
                                          const EdgeInsets.fromLTRB(10, 10, 20, 20),
                                          child: Row(
                                            mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                            children: [
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
                                                        getCurrencyString(state.responseAccountStatement!.data!.summary!.dueAmount!=null?state.responseAccountStatement!.data!.summary!.dueAmount!:0),
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
                                                        getCurrencyString(state.responseAccountStatement!.data!.summary!.pendingAmount!=null?state.responseAccountStatement!.data!.summary!.pendingAmount!:0),
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
    );
  }

  /*Widget earningCardDetails(BuildContext context) {
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
            // const Earnings().navigate();
            const FarmerStatement().navigate();

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
  }*/
}

class _ChartData {
  _ChartData(this.x, this.y);

  final String x;
  final double y;
}