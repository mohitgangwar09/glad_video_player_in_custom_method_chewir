import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:glad/cubit/dashboard_cubit/dashboard_cubit.dart';
import 'package:glad/cubit/landing_page_cubit/landing_page_cubit.dart';
import 'package:glad/cubit/profile_cubit/profile_cubit.dart';
import 'package:glad/cubit/project_cubit/project_cubit.dart';
import 'package:glad/screen/common/community_forum.dart';
import 'package:glad/screen/common/featured_trainings.dart';
import 'package:glad/screen/common/landing_carousel.dart';
import 'package:glad/screen/common/trending_news.dart';
import 'package:glad/screen/custom_widget/custom_appbar.dart';
import 'package:glad/screen/custom_widget/custom_methods.dart';
import 'package:glad/screen/mcc_screen/dashboard_tab_screen/application_screen.dart';
import 'package:glad/screen/mcc_screen/profile/mcc_profile.dart';
import 'package:glad/utils/color_resources.dart';
import 'package:glad/utils/extension.dart';
import 'package:glad/utils/images.dart';
import 'package:glad/utils/styles.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class MCCLandingPage extends StatefulWidget {
  const MCCLandingPage({super.key});

  @override
  State<MCCLandingPage> createState() => _MCCLandingPageState();
}

class _MCCLandingPageState extends State<MCCLandingPage> {

  @override
  void initState() {
    super.initState();
    BlocProvider.of<LandingPageCubit>(context).getMCCDashboard(context);
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      BlocProvider.of<ProjectCubit>(context)
          .ddeProjectsApi(context, "pending", true);
      BlocProvider.of<ProfileCubit>(context).profileApi(context);
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
        } else if (state.responseMCCDashboard == null) {
          return Center(child: Text("${state.responseMCCDashboard} Api Error"));
        } else {
          return Container(
            color: Colors.white,
            child: Stack(
              children: [
                landingBackground(),
                Column(
                  children: [

                    BlocBuilder<ProfileCubit,ProfileCubitState>(
                      builder: (context,states) {
                        return CustomAppBar(
                          context: context,
                          titleText1: 'Welcome to ',
                          titleText2: states.responseProfile!=null?states.responseProfile!.data!.user!.name.toString():'',
                          leading: null,
                          action: Row(
                            children: [
                              phoneCall(256758711344),
                              7.horizontalSpace(),
                              InkWell(
                                  onTap: () {
                                    const MccProfile().navigate();
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
                                        (state.responseMCCDashboard!.data != null) ? (state.responseMCCDashboard!.data!.mcc!.photo ?? '') : '',
                                        errorWidget: (_, __, ___) =>
                                            SvgPicture.asset(Images.person),
                                        fit: BoxFit.cover,
                                      ),
                                    ),
                                  )),
                              8.horizontalSpace(),
                            ],
                          ),
                        );
                      }
                    ),
                    landingPage(context, state),
                  ],
                ),
              ],
            ),
          );
        }
      }
    );
  }

  Widget landingPage(context, LandingPageState state) {
    return Expanded(
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const LandingCarousel(),
            10.verticalSpace(),

            Padding(
              padding: const EdgeInsets.only(right: 20.0,bottom: 25,left: 10),
              child: Row(children: [
                Expanded(
                  child: InkWell(
                    onTap: () {
                    BlocProvider.of<DashboardCubit>(context).selectedIndex(1);
                    BlocProvider.of<ProjectCubit>(context).emit(BlocProvider.of<ProjectCubit>(context).state.copyWith(selectedFilterMCCApplication: 'pending'));
                    },
                    child: customProjectContainer(
                        width: screenWidth(),
                        height: 140,
                        child: Padding(
                          padding: const EdgeInsets.all(16),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [

                              state.responseMCCDashboard!.data!.farmerProject!.pending.toString().textMedium(fontSize: 32,
                                  color: const Color(0xffFC5E60)),
                              12.verticalSpace(),
                              'Pending'.textMedium(fontSize: 16),
                              7.verticalSpace(),
                              "Loans pending for approval".textMedium(fontSize: 12,color: const Color(0xff727272),
                                  maxLines: 2,overflow: TextOverflow.ellipsis,textAlign: TextAlign.center),


                            ],
                          ),
                        )),
                  ),
                ),

                Expanded(
                  child: InkWell(
                    onTap: () {
                      BlocProvider.of<DashboardCubit>(context).selectedIndex(1);
                      BlocProvider.of<ProjectCubit>(context).emit(BlocProvider.of<ProjectCubit>(context).state.copyWith(selectedFilterMCCApplication: 'approved'));
                    },
                    child: customProjectContainer(
                        height: 140,
                        width: screenWidth(),
                        child: Padding(
                          padding: const EdgeInsets.all(20),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [

                              state.responseMCCDashboard!.data!.farmerProject!.approved.toString().textMedium(fontSize: 32,
                                  color: const Color(0xff12CE57)),

                              12.verticalSpace(),

                              'Approved'.textMedium(fontSize: 16),
                              7.verticalSpace(),
                              'Loans approved'.textMedium(fontSize: 12,color: const Color(0xff727272),
                                  maxLines: 2,overflow: TextOverflow.ellipsis,textAlign: TextAlign.center),

                            ],
                          ),
                        )),
                  ),
                )
              ],),
            ),


            Padding(
              padding: const EdgeInsets.only(left: 24.0,right: 24,top: 10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  "Pending Application".textMedium(fontSize: 18),

                  "View All".textSemiBold(underLine: TextDecoration.underline,
                      fontSize: 12,color: const Color(0xff6A0030))
                ],
              ),
            ),

            /*SizedBox(
              height: 250,
              child: BlocBuilder<ProjectCubit, ProjectState>(builder: (context, state) {
               if (state.responseDdeProject == null) {
                  return Center(child: Text("${state.responseDdeProject} Api Error"));
                }*//*else if (state.responseDdeProject!.data!.projectList!.isEmpty) {
                  return const Center(child: Text("No Data found"));
                } else if (state.responseDdeProject!.data!.projectList== null) {
                  return const Center(child: Text("No Data found"));
                }*//*else {
                  return Container(
                    margin: const EdgeInsets.only(left: 8),
                    height: 235,
                    child: state.responseDdeProject!.data!.projectList!.isNotEmpty
                        ?
                    Expanded(
                      child: customList(
                          list: state.responseDdeProject!.data!
                              .projectList!,
                        scrollPhysics: const BouncingScrollPhysics(),

                          axis: Axis.horizontal,child: (i){
                        return Padding(
                          padding: const EdgeInsets.only(right: 5.0,left: 0),
                          child: MCCApplicationScreen(
                              status: false,
                              projectStatus: formatProjectStatus(state.responseDdeProject!.data!
                                  .projectList![i].projectStatus ?? ''),
                              name: state.responseDdeProject!.data!
                                  .projectList![i].name ?? '',
                              category: state.responseDdeProject!.data!
                                  .projectList![i].farmerImprovementArea !=
                                  null ? state.responseDdeProject!.data!
                                  .projectList![i].farmerImprovementArea!
                                  .improvementArea!.name ?? '' : '',
                              description: state.responseDdeProject!.data!
                                  .projectList![i].description ?? '',
                              investment: state.responseDdeProject!.data!
                                  .projectList![i].investmentAmount ?? 0,
                              revenue: state.responseDdeProject!.data!
                                  .projectList![i].revenuePerYear ?? 0,
                              roi: state.responseDdeProject!.data!
                                  .projectList![i].roiPerYear ?? 0.0,
                              loan: state.responseDdeProject!.data!
                                  .projectList![i].loanAmount ?? 0,
                              emi: state.responseDdeProject!.data!
                                  .projectList![i].emiAmount ?? 0,
                              balance: 0,
                              farmerName: state.responseDdeProject!.data!
                                  .projectList![i].farmerMaster!= null ? state.responseDdeProject!.data!
                                  .projectList![i].farmerMaster!.name ?? '' : '',
                              farmerAddress:  state.responseDdeProject!.data!
                                  .projectList![i].farmerMaster!= null ? state.responseDdeProject!.data!
                                  .projectList![i].farmerMaster!.address!=null?state.responseDdeProject!.data!
                                  .projectList![i].farmerMaster!.address!.address.toString():"" ??
                                  '' : '',
                              farmerImage:  state.responseDdeProject!.data!
                                  .projectList![i].farmerMaster!= null ? state.responseDdeProject!.data!
                                  .projectList![i].farmerMaster!.photo ??
                                  ''  : '',
                              farmerPhone:  state.responseDdeProject!.data!
                                  .projectList![i].farmerMaster!= null ? state.responseDdeProject!.data!
                                  .projectList![i].farmerMaster!.phone ??
                                  ''  : '',
                              projectPercent: 0,
                              projectId: state.responseDdeProject!.data!
                                  .projectList![i].id ?? 0,
                              farmerDetail: "farmer",
                              // farmerDetail: state.responseDdeProject!.data!
                              //     .projectList![i].farmerMaster!,
                              selectedFilter: "pending"

                          ),
                        );}),
                    ):const SizedBox.shrink(),
                  );
                }
              },
              ),
            ),*/

            30.verticalSpace(),

            ddeProfileSlider(context, state),

            CommunityForum(
              onTapShowAll: () {
                BlocProvider.of<DashboardCubit>(context).selectedIndex(2);
              },
            ),
            10.verticalSpace(),
            // FeaturedTrainings(
            //   trainingList: state.responseMCCDashboard!.data!.trainingList ?? [],
            //   onTapShowAll: () {
            //     BlocProvider.of<DashboardCubit>(context).selectedIndex(4);
            //   },
            // ),
            // 10.verticalSpace(),
            TrendingNewsAndEvents(
              newsList: state.responseMCCDashboard!.data!.newsEvent ?? [],
              onTapShowAll: () {
                BlocProvider.of<DashboardCubit>(context).selectedIndex(3);
              },
            ),
            100.verticalSpace(),
          ],
        ),
      ),
    );
  }

  Widget ddeProfileSlider(context, LandingPageState state){
    return Padding(
      padding: const EdgeInsets.only(left: 10.0,right: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [

          Padding(padding: const EdgeInsets.only(left: 10),
          child: 'DDE'.textMedium(fontSize: 18),),

          SizedBox(
            height: 180,
            child: ListView.builder(
                itemCount: state.responseMCCDashboard!.data!.mcc!.dairyDevelopmentExecutive!.length,
                shrinkWrap: true,
                scrollDirection: Axis.horizontal,
                itemBuilder: (context, index) =>
                    Stack(
              alignment: Alignment.center,
              children: [
                SizedBox(
                    height: 100,
                    width: MediaQuery.of(context).size.width * 0.8),
                customProjectContainer(
                  // height: 115,
                  width: MediaQuery.of(context).size.width * 0.8,
                  child: Column(
                    children: [

                      Padding(
                        padding: const EdgeInsets.fromLTRB(15.0, 20, 0, 10),
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
                                  imageUrl: state.responseMCCDashboard!.data!.mcc!.dairyDevelopmentExecutive![index].photo ?? '',
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
                                Text(state.responseMCCDashboard!.data!.mcc!.dairyDevelopmentExecutive![index].name ?? '',
                                    style: figtreeMedium.copyWith(
                                        fontSize: 16, color: Colors.black)),
                                4.verticalSpace(),
                                Row(
                                  crossAxisAlignment: CrossAxisAlignment.end,
                                  children: [
                                    const Icon(
                                      Icons.call,
                                      color: Colors.black,
                                      size: 16,
                                    ),
                                    Text(state.responseMCCDashboard!.data!.mcc!.dairyDevelopmentExecutive![index].phone ?? '',
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
                                      MediaQuery.of(context).size.width * 0.5,
                                      child: Text('',
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

                      const Padding(
                          padding: EdgeInsets.symmetric(horizontal: 24),
                          child: Divider(thickness: 1.2,color: Color(0xffDCDCDC))),
                      if(state.responseMCCDashboard!.data!.mcc!.dairyDevelopmentExecutive![index].farmerMaster!.isNotEmpty)
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [

                          'Farmers Managed'.textMedium(fontSize: 14),

                          12.horizontalSpace(),
                          if(state.responseMCCDashboard!.data!.mcc!.dairyDevelopmentExecutive![index].farmerMaster!.length > 3)
                            Stack(
                              children: [
                                // CircleAvatar(
                                //     radius: 20,
                                //     child: Image.asset(Images.sampleUser,fit: BoxFit.cover,width: 40,height: 40)),

                                for(int i= 0; i < 3;i++)
                                  Padding(
                                    padding: EdgeInsets.only(left: 30.0 * i),
                                    child: ClipRRect(
                                      borderRadius: BorderRadius.circular(1000),
                                      child: Container(
                                        height: AppBar().preferredSize.height * 0.7,
                                        width: AppBar().preferredSize.height * 0.7,
                                        decoration:
                                        const BoxDecoration(shape: BoxShape.circle),
                                        child: CachedNetworkImage(
                                          imageUrl: state.responseMCCDashboard!.data!.mcc!.dairyDevelopmentExecutive![index].farmerMaster![i].photo?? '',
                                          errorWidget: (_, __, ___) =>
                                              Image.asset(Images.sampleUser),
                                          fit: BoxFit.cover,
                                        ),
                                      ),
                                    ),
                                  ),
                                Padding(
                                  padding: const EdgeInsets.only(left: 30.0 * 3),
                                  child: CircleAvatar(
                                    radius: 20,
                                    backgroundColor: Colors.yellow,
                                    child: '+${state.responseMCCDashboard!.data!.mcc!.dairyDevelopmentExecutive![index].farmerMaster!.length - 3}'.textMedium(),
                                  ),
                                ),
                                // Padding(
                                //   padding: const EdgeInsets.only(left: 30.0),
                                //   child: CircleAvatar(
                                //       radius: 20,
                                //       child: Image.asset(Images.sampleUser,fit: BoxFit.cover,width: 70,height: 70)),
                                // ),
                                //
                                // Padding(
                                //   padding: const EdgeInsets.only(left: 60),
                                //   child: CircleAvatar(
                                //       radius: 20,
                                //       child: Image.asset(Images.sampleUser,fit: BoxFit.cover,width: 70,height: 70)),
                                // ),

                              ],
                            ),

                          if(state.responseMCCDashboard!.data!.mcc!.dairyDevelopmentExecutive![index].farmerMaster!.length <= 3)
                            Stack(
                              children: [
                                for(int i= 0; i < state.responseMCCDashboard!.data!.mcc!.dairyDevelopmentExecutive![index].farmerMaster!.length;i++)
                                  Padding(
                                    padding: EdgeInsets.only(left: 30.0 * i),
                                    child: ClipRRect(
                                      borderRadius: BorderRadius.circular(1000),
                                      child: Container(
                                        height: AppBar().preferredSize.height * 0.7,
                                        width: AppBar().preferredSize.height * 0.7,
                                        decoration:
                                        const BoxDecoration(shape: BoxShape.circle),
                                        child: CachedNetworkImage(
                                          imageUrl: state.responseMCCDashboard!.data!.mcc!.dairyDevelopmentExecutive![index].farmerMaster![i].photo?? '',
                                          errorWidget: (_, __, ___) =>
                                              Image.asset(Images.sampleUser),
                                          fit: BoxFit.cover,
                                        ),
                                      ),
                                    ),
                                  ),
                              ],)
                        ],
                      )

                    ],
                  ),
                ),
                Positioned(
                    top: 0,
                    right: 10,
                    child: Row(
                      children: [
                        SvgPicture.asset(Images.callPrimary),
                        6.horizontalSpace(),
                        SvgPicture.asset(Images.whatsapp),
                        4.horizontalSpace(),
                      ],
                    )),
              ],
            ),
            ),
          ),

          // CarouselSlider(
          //   items: ,
          //   options: CarouselOptions(
          //     autoPlay: true,
          //     clipBehavior: Clip.none,
          //     enableInfiniteScroll: false,
          //     viewportFraction: 1,
          //     height: 180,
          //     onPageChanged: (index, reason) {
          //
          //     },
          //   )
          // ),

          // 5.verticalSpace(),
          //
          // const Center(
          //   child: Padding(
          //     padding: EdgeInsets.all(5),
          //     child: AnimatedSmoothIndicator(
          //       activeIndex: 3,
          //       count: 3,
          //       effect: WormEffect(
          //           activeDotColor: ColorResources.maroon,
          //           dotHeight: 7,
          //           dotWidth: 7,
          //           dotColor: ColorResources.grey),
          //     ),
          //   ),
          // ),

          15.verticalSpace(),

        ],
      ),
    );
  }
}