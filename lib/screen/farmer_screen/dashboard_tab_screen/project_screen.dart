import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:glad/cubit/project_cubit/project_cubit.dart';
import 'package:glad/screen/custom_widget/custom_appbar.dart';
import 'package:glad/screen/custom_widget/custom_methods.dart';
import 'package:glad/screen/farmer_screen/common/widegt/project_widget.dart';
import 'package:glad/screen/farmer_screen/dashboard/dashboard_farmer.dart';
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

  @override
  void initState() {
    BlocProvider.of<ProjectCubit>(context).farmerProjectsApi(context, selectedFilter, true);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
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
              centerTitle: true,
              leading: openDrawer(
                  onTap: () {
                    farmerLandingKey.currentState?.openDrawer();
                  },
                  child: SvgPicture.asset(Images.drawer)),
            ),
            10.verticalSpace(),
            Container(
              height: 50,
              margin: 20.marginHorizontal(),
              width: screenWidth(),
              decoration: boxDecoration(
                  borderRadius: 62,
                  borderColor: const Color(0xffDCDCDC),
                  backgroundColor: Colors.white),
              child: Row(
                children: [
                  Expanded(
                    child: InkWell(
                      onTap: () {
                        if (selectedFilter != 'active') {
                          selectedFilter = 'active';
                          setState(() {});
                          BlocProvider.of<ProjectCubit>(context)
                              .farmerProjectsApi(
                              context, selectedFilter, true);
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
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            "Active"
                                .textMedium(
                                color: selectedFilter == 'active' ? Colors
                                    .white : ColorResources.black,
                                fontSize: 14),
                            5.horizontalSpace(),
                            SvgPicture.asset(
                                selectedFilter == 'suggested' ? Images
                                    .activeSelected : Images.activeSelected)
                          ],
                        ),
                      ),
                    ),
                  ),
                  Expanded(
                    child: InkWell(
                      onTap: () {
                        if (selectedFilter != 'suggested') {
                          selectedFilter = 'suggested';
                          setState(() {});
                          BlocProvider.of<ProjectCubit>(context)
                              .farmerProjectsApi(
                              context, selectedFilter, true);
                        }
                      },
                      child: Container(
                        height: screenHeight(),
                        margin: const EdgeInsets.all(6),
                        decoration: boxDecoration(
                            backgroundColor: selectedFilter == 'suggested'
                                ? const Color(0xff6A0030)
                                : Colors.white, borderRadius: 62),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            "Suggested".textMedium(
                                color: selectedFilter == 'suggested'
                                    ? Colors.white
                                    : ColorResources.black, fontSize: 14),
                            5.horizontalSpace(),
                            SvgPicture.asset(
                              selectedFilter == 'suggested' ? Images
                                  .completedSelected : Images.completed,
                            )
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),

            BlocBuilder<ProjectCubit, ProjectState>(
              builder: (context, state) {
              if (state.status == ProjectStatus.loading) {
                return const SizedBox(
                  height: 350,
                  child: Center(
                      child: CircularProgressIndicator(
                        color: ColorResources.maroon,
                      )),
                );
              } else if (state.responseFarmerProject == null) {
                return Center(child: Text("${state.responseFarmerProject} Api Error"));
              } else {
                return Expanded(
                  child: SingleChildScrollView(
                    padding: const EdgeInsets.only(bottom: 120, left: 10),
                    child: state.responseFarmerProject!.data!.projectList!
                        .isNotEmpty ? customList(
                        list: List.generate(state.responseFarmerProject!.data!
                            .projectList!.length, (index) => ''),
                        child: (int i) {
                          return Padding(
                            padding: const EdgeInsets.only(right: 20.0),
                            child: customProjectContainer(
                                child: ProjectWidget(
                                  showStatus: true,
                                  status: formatProjectStatus(state.responseFarmerProject!.data!
                                      .projectList![i].projectStatus ?? ''),
                                  image: state.responseFarmerProject!.data!
                                      .projectList![i].project['image'] ?? '',
                                  name: state.responseFarmerProject!.data!
                                      .projectList![i].name ?? '',
                                  targetYield: state.responseFarmerProject!
                                      .data!.projectList![i].targetYield ?? 0,
                                  investment: state.responseFarmerProject!.data!
                                      .projectList![i].investmentAmount ?? 0,
                                  revenue: state.responseFarmerProject!.data!
                                      .projectList![i].revenuePerYear ?? 0,
                                  index: i + 1,
                                  incrementalProduction: state
                                      .responseFarmerProject!.data!
                                      .projectList![i].incrementalProduction ??
                                      0,
                                  roi: state.responseFarmerProject!.data!
                                      .projectList![i].roiPerYear ?? 0,
                                  category: state.responseDdeProject!.data!
                                      .projectList![i].farmerImprovementArea !=
                                      null ? state.responseDdeProject!.data!
                                      .projectList![i].farmerImprovementArea!
                                      .improvementArea!=null?state.responseDdeProject!.data!
                                      .projectList![i].farmerImprovementArea!
                                      .improvementArea!.name ?? '':'' : '',
                                  projectId: state.responseFarmerProject!.data!
                                      .projectList![i].id ?? 0,
                                  selectedFilter: selectedFilter,
                                ),
                                width: screenWidth()),
                          );
                        }) :
                    SizedBox(
                      width: screenWidth(),
                      height: 350,
                      child: Padding(
                        padding: EdgeInsets.only(top: screenWidth() / 2),
                        child: const Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text('No data found'),
                          ],
                        ),
                      ),
                    ),
                  ),
                );
              }
              }
            ),
          ],
        ),
      ],
    );
  }
}
