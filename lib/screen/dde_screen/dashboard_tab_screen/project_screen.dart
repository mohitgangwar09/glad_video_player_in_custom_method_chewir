import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:glad/cubit/dde_farmer_cubit/dde_farmer_cubit.dart';
import 'package:glad/cubit/project_cubit/project_cubit.dart';
import 'package:glad/screen/custom_widget/custom_appbar.dart';
import 'package:glad/screen/custom_widget/custom_methods.dart';
import 'package:glad/screen/dde_screen/dashboard/dashboard_dde.dart';
import 'package:glad/screen/dde_screen/dde_farmer_filter.dart';
import 'package:glad/screen/dde_screen/project_filter.dart';
import 'package:glad/screen/dde_screen/project_widget.dart';
import 'package:glad/utils/color_resources.dart';
import 'package:glad/utils/extension.dart';
import 'package:glad/utils/images.dart';
import 'package:glad/utils/styles.dart';

class ProjectScreen extends StatefulWidget {
  const ProjectScreen({Key? key}) : super(key: key);

  @override
  State<ProjectScreen> createState() => _ProjectScreenState();
}

class _ProjectScreenState extends State<ProjectScreen> {
  String selectedFilter = 'suggested';
  bool search = false;
  TextEditingController searchEditingController = TextEditingController();

  @override
  void initState() {
    BlocProvider.of<ProjectCubit>(context)
        .ddeProjectsApi(context, selectedFilter, true);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    BlocProvider.of<DdeFarmerCubit>(context).selectRagRating('');

    return BlocBuilder<ProjectCubit, ProjectState>(builder: (context, state) {
      if (state.status == ProjectStatus.loading) {
        return const Center(
            child: CircularProgressIndicator(
              color: ColorResources.maroon,
            ));
      } else if (state.responseDdeProject == null) {
        return Center(child: Text("${state.responseDdeProject} Api Error"));
      } else {
        return Stack(
          children: [
            landingBackground(),
            Column(
              children: [
                CustomAppBar(
                  context: context,
                  titleText1: 'Projects',
                  titleText1Style:
                  figtreeMedium.copyWith(fontSize: 20, color: Colors.black),
                  // centerTitle: true,
                  leading: openDrawer(
                      onTap: () {
                        ddeLandingKey.currentState?.openDrawer();
                      },
                      child: SvgPicture.asset(Images.drawer)),
                  action: Row(
                    children: [
                      InkWell(
                          onTap: () {
                            List<String> roiList = [
                              'Default',
                              'ROI Highest to Lowest',
                              'ROI Lowest to Highest',
                              'Revenue Highest to Lowest',
                              'Revenue Lowest to Highest',
                              'Investment Highest to Lowest',
                              'Investment Lowest to Highest',
                            ];
                            List<String> roiRequestToApi = [
                             '',
                             'roi_highest_desc',
                              'roi_lowest_asc',
                              'revenue_highest_desc',
                              'revenue_lowest_asc',
                              'investment_highest_desc',
                              'investment_lowest_asc'
                            ];
                            modalBottomSheetMenu(context,
                                child: StatefulBuilder(builder: (context, setStates) {
                                  return SizedBox(
                                    height: screenHeight() * 0.65,
                                    child: Column(
                                      children: [
                                        Padding(
                                          padding: const EdgeInsets.only(
                                              left: 8.0, right: 8),
                                          child: Row(
                                            mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                            children: [
                                              TextButton(
                                                  onPressed: () {
                                                    pressBack();
                                                  },
                                                  child: "Cancel".textMedium(
                                                      color:
                                                      const Color(0xff6A0030),
                                                      fontSize: 14)),
                                              "Sort By".textMedium(fontSize: 22),
                                              TextButton(
                                                  onPressed: () {
                                                    setState(() {});
                                                    BlocProvider.of<ProjectCubit>(context).roiFilter('');
                                                    BlocProvider.of<ProjectCubit>(context)
                                                        .ddeProjectsApi(
                                                        context, selectedFilter, false);
                                                    pressBack();
                                                  },
                                                  child: "Reset".textMedium(
                                                      color:
                                                      const Color(0xff6A0030),
                                                      fontSize: 14))
                                            ],
                                          ),
                                        ),
                                        const Padding(
                                          padding: EdgeInsets.only(
                                              left: 20.0, right: 20),
                                          child: Divider(),
                                        ),
                                        Expanded(
                                          child: customList(
                                              list: roiList,
                                              child: (index) {
                                                return Padding(
                                                    padding: const EdgeInsets
                                                        .only (
                                                        left: 30,
                                                        right: 30,
                                                        top: 30,
                                                        bottom: 10),
                                                    child: Row(
                                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                      children: [
                                                        InkWell(onTap: (){
                                                          setState(() {});
                                                          BlocProvider.of<ProjectCubit>(context).roiFilter(roiRequestToApi[index].toString());
                                                          BlocProvider.of<ProjectCubit>(context)
                                                              .ddeProjectsApi(
                                                              context, selectedFilter, false);
                                                          pressBack();
                                                        }, child: roiList[index].toString()
                                                            .textRegular(
                                                            fontSize: 16)),
                                                        state.roiFilter == roiRequestToApi[index].toString()?
                                                        const Icon(Icons.check,color: Colors.red,):const SizedBox.shrink()
                                                      ],
                                                    ));
                                              }),
                                        ),
                                        10.verticalSpace(),
                                        Container(
                                            margin: 20.marginAll(),
                                            height: 55,
                                            width: screenWidth(),
                                            child: customButton("Apply",
                                                fontColor: 0xffffffff,
                                                onTap: () {}))
                                      ],
                                    ),
                                  );
                                },
                                ));
                          },
                          child: SvgPicture.asset(Images.filter2)),
                      13.horizontalSpace(),
                      InkWell(
                          onTap: () {
                            BlocProvider.of<ProjectCubit>(context).responseAreaImprovementListApi(context);
                            ProjectFilter(selectedFilter).navigate();
                          },
                          child: SvgPicture.asset(Images.filter1)),
                      18.horizontalSpace(),
                      search == true?
                      Stack(
                        children: [
                          Container(
                            height: 50,
                            decoration: boxDecoration(
                                borderColor: Colors.grey,
                                borderRadius: 62,
                                backgroundColor: Colors.white),
                            width: screenWidth()-16,
                            child: Row(
                              children: [
                                13.horizontalSpace(),
                                SvgPicture.asset(Images.searchLeft),
                                13.horizontalSpace(),
                                Expanded(
                                    child: TextField(
                                      controller: searchEditingController,
                                      onChanged: (value){
                                        BlocProvider.of<ProjectCubit>(context).ddeProjectsApi(context, selectedFilter, false,searchQuery:value.toString());
                                      },
                                      decoration: const InputDecoration(
                                          border: InputBorder.none, hintText: "Search"),
                                    )),
                              ],
                            ),
                          ),
                          Positioned(top: 0,bottom: 0,right:7,child: IconButton(
                              onPressed: () {
                                setState(() {
                                  search = false;
                                  searchEditingController.clear();
                                  BlocProvider.of<ProjectCubit>(context).ddeProjectsApi(context, selectedFilter, false,searchQuery:'');
                                });
                              },
                              icon: const Icon(Icons.clear)))
                        ],
                      ):const SizedBox.shrink(),

                      search == false?
                      InkWell(
                        onTap: (){
                          setState(() {
                            search = true;
                            // BlocProvider.of<ProjectCubit>(context).ddeProjectsApi(context, selectedFilter, false,searchQuery:'');
                          });
                        },
                        child: Container(
                            width: 35,
                            height: 35,
                            decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                border: Border.all(color: const Color(0xffDCDCDC))
                            ),
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: SvgPicture.asset(Images.search,width: 23,height: 23,),
                            )
                        ),
                      ):const SizedBox.shrink()
                    ],
                  ),
                ),
                10.verticalSpace(),
                SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Container(
                    height: 50,
                    margin: 20.marginLeft(),
                    decoration: boxDecoration(
                        borderRadius: 62,
                        borderColor: const Color(0xffDCDCDC),
                        backgroundColor: Colors.white),
                    child: Row(
                      children: [
                        InkWell(
                          onTap: () {
                            if (selectedFilter != 'suggested') {
                              selectedFilter = 'suggested';
                              setState(() {});
                              BlocProvider.of<ProjectCubit>(context)
                                  .ddeProjectsApi(
                                  context, selectedFilter, false);
                            }
                          },
                          child: Container(
                            height: screenHeight(),
                            margin: const EdgeInsets.all(6),
                            decoration: boxDecoration(
                                backgroundColor: selectedFilter == 'suggested'
                                    ? const Color(0xff6A0030)
                                    : Colors.white,
                                borderRadius: 62),
                            padding: const EdgeInsets.symmetric(horizontal: 10),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                "Suggested".textMedium(
                                    color: selectedFilter == 'suggested'
                                        ? Colors.white
                                        : ColorResources.black,
                                    fontSize: 14),
                                5.horizontalSpace(),
                                SvgPicture.asset(selectedFilter == 'suggested'
                                    ? Images.activeSelected
                                    : Images.active
                                )
                              ],
                            ),
                          ),
                        ),
                        InkWell(
                          onTap: () {
                            if (selectedFilter != 'pending') {
                              selectedFilter = 'pending';
                              setState(() {});
                              BlocProvider.of<ProjectCubit>(context)
                                  .ddeProjectsApi(
                                  context, selectedFilter, false);
                            }
                          },
                          child: Container(
                            height: screenHeight(),
                            margin: const EdgeInsets.all(6),
                            decoration: boxDecoration(
                                backgroundColor: selectedFilter == 'pending'
                                    ? const Color(0xff6A0030)
                                    : Colors.white,
                                borderRadius: 62),
                            padding: const EdgeInsets.symmetric(horizontal: 10),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                "Pending".textMedium(
                                    color: selectedFilter == 'pending'
                                        ? Colors.white
                                        : ColorResources.black,
                                    fontSize: 14),
                                5.horizontalSpace(),
                                SvgPicture.asset(selectedFilter == 'pending'
                                    ? Images.pendingSelected
                                    : Images.pending)
                              ],
                            ),
                          ),
                        ),
                        InkWell(
                          onTap: () {
                            if (selectedFilter != 'active') {
                              selectedFilter = 'active';
                              setState(() {});
                              BlocProvider.of<ProjectCubit>(context)
                                  .ddeProjectsApi(
                                  context, selectedFilter, false);
                            }
                          },
                          child: Container(
                            height: screenHeight(),
                            margin: const EdgeInsets.all(6),
                            decoration: boxDecoration(
                                backgroundColor: selectedFilter == 'active'
                                    ? const Color(0xff6A0030)
                                    : Colors.white,
                                borderRadius: 62),
                            padding: const EdgeInsets.symmetric(horizontal: 10),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                "Active".textMedium(
                                    color: selectedFilter == 'active'
                                        ? Colors.white
                                        : ColorResources.black,
                                    fontSize: 14),
                                5.horizontalSpace(),
                                SvgPicture.asset(selectedFilter == 'active'
                                    ? Images.activeSelected
                                    : Images.active
                                )
                              ],
                            ),
                          ),
                        ),
                        InkWell(
                          onTap: () {
                            if (selectedFilter != 'completed') {
                              selectedFilter = 'completed';
                              setState(() {});
                              BlocProvider.of<ProjectCubit>(context)
                                  .ddeProjectsApi(
                                  context, selectedFilter, false);
                            }
                          },
                          child: Container(
                            height: screenHeight(),
                            margin: const EdgeInsets.all(6),
                            decoration: boxDecoration(
                                backgroundColor: selectedFilter == 'completed'
                                    ? const Color(0xff6A0030)
                                    : Colors.white,
                                borderRadius: 62),
                            padding: const EdgeInsets.symmetric(horizontal: 10),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                "Completed".textMedium(
                                    color: selectedFilter == 'completed'
                                        ? Colors.white
                                        : ColorResources.black,
                                    fontSize: 14),
                                5.horizontalSpace(),
                                SvgPicture.asset(selectedFilter == 'completed'
                                    ? Images.completedSelected
                                    : Images.completed)
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                state.responseDdeProject!.data!.projectList!.isNotEmpty
                    ? Expanded(
                  child: SingleChildScrollView(
                    padding: const EdgeInsets.only(bottom: 120, left: 10),
                    child: customList(
                        list: List.generate(state.responseDdeProject!.data!
                            .projectList!.length, (index) => null),
                        child: (int i) {

                          return Padding(
                            padding: const EdgeInsets.only(right: 20.0),
                            child: customProjectContainer(
                                child: ProjectWidget(
                                  status: true,
                                  projectStatus: formatProjectStatus(state.responseDdeProject!.data!
                                      .projectList![i].projectStatus ?? ''),
                                  name: state.responseDdeProject!.data!
                                      .projectList![i].name ?? '',
                                  category: state.responseDdeProject!.data!
                                      .projectList![i].farmerImprovementArea !=
                                      null ? state.responseDdeProject!.data!
                                      .projectList![i].farmerImprovementArea!
                                      .improvementArea!=null?state.responseDdeProject!.data!
                                      .projectList![i].farmerImprovementArea!
                                      .improvementArea!.name ?? '':'' : '',
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
                                    farmerDetail: state.responseDdeProject!.data!
                                        .projectList![i].farmerMaster!,
                                  rejectStatus: state.responseDdeProject!.data!
                                      .projectList![i].rejectStatus ?? '',
                                  milestones: state.responseDdeProject!.data!
                                    .projectList![i].farmerProjectMilestones!,
                                  selectedFilter: selectedFilter,
                                ),
                                width: screenWidth()),
                          );
                        }),
                  ),
                )
                    : Padding(
                  padding: EdgeInsets.only(top: screenWidth() / 2),
                  child: const Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text('No data found'),
                    ],
                  ),
                )
              ],
            ),
          ],
        );
      }
    });
  }
}
