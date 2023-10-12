import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:glad/cubit/dde_farmer_cubit/dde_farmer_cubit.dart';
import 'package:glad/cubit/project_cubit/project_cubit.dart';
import 'package:glad/screen/custom_widget/custom_appbar.dart';
import 'package:glad/screen/custom_widget/custom_methods.dart';
import 'package:glad/screen/dde_screen/dde_farmer_filter.dart';
import 'package:glad/screen/dde_screen/project_widget.dart';
import 'package:glad/screen/farmer_screen/dashboard/dashboard_farmer.dart';
import 'package:glad/screen/farmer_screen/profile/farmer_profile.dart';
import 'package:glad/utils/color_resources.dart';
import 'package:glad/utils/extension.dart';
import 'package:glad/utils/helper.dart';
import 'package:glad/utils/images.dart';
import 'package:glad/utils/styles.dart';

class ProjectScreen extends StatefulWidget {
  const ProjectScreen({Key? key}) : super(key: key);

  @override
  State<ProjectScreen> createState() => _ProjectScreenState();
}

class _ProjectScreenState extends State<ProjectScreen> {
  String selectedStatus = 'active';

  @override
  void initState() {
    BlocProvider.of<ProjectCubit>(context)
        .ddeProjectsApi(context, selectedStatus, true);
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
                  centerTitle: true,
                  leading: openDrawer(
                      onTap: () {
                        farmerLandingKey.currentState?.openDrawer();
                      },
                      child: SvgPicture.asset(Images.drawer)),
                  action: Row(
                    children: [
                      InkWell(
                          onTap: () {
                            modalBottomSheetMenu(context,
                                child: SizedBox(
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
                                                onPressed: () {},
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
                                            list: [
                                              1,
                                              2,
                                              22,
                                              2,
                                              22,
                                              2,
                                              2,
                                              22,
                                              2
                                            ],
                                            child: (index) {
                                              return Padding(
                                                  padding: const EdgeInsets
                                                      .only(
                                                      left: 30,
                                                      right: 30,
                                                      top: 30,
                                                      bottom: 10),
                                                  child: "ROI Highest to Lowest"
                                                      .textRegular(
                                                      fontSize: 16));
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
                                ));
                          },
                          child: SvgPicture.asset(Images.filter2)),
                      13.horizontalSpace(),
                      InkWell(
                          onTap: () {
                            const FilterDDEFarmer().navigate();
                          },
                          child: SvgPicture.asset(Images.filter1)),
                      18.horizontalSpace(),
                    ],
                  ),
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
                            if (selectedStatus != 'active') {
                              selectedStatus = 'active';
                              setState(() {});
                              BlocProvider.of<ProjectCubit>(context)
                                  .ddeProjectsApi(
                                  context, selectedStatus, false);
                            }
                          },
                          child: Container(
                            height: screenHeight(),
                            margin: const EdgeInsets.all(6),
                            decoration: boxDecoration(
                                backgroundColor: selectedStatus == 'active'
                                    ? const Color(0xff6A0030)
                                    : Colors.white,
                                borderRadius: 62),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                "Active".textMedium(
                                    color: selectedStatus == 'active'
                                        ? Colors.white
                                        : ColorResources.black,
                                    fontSize: 14),
                                5.horizontalSpace(),
                                SvgPicture.asset(selectedStatus == 'active'
                                    ? Images.activeSelected
                                    : Images.active
                                )
                              ],
                            ),
                          ),
                        ),
                      ),
                      Expanded(
                        child: InkWell(
                          onTap: () {
                            if (selectedStatus != 'pending') {
                              selectedStatus = 'pending';
                              setState(() {});
                              BlocProvider.of<ProjectCubit>(context)
                                  .ddeProjectsApi(
                                  context, selectedStatus, false);
                            }
                          },
                          child: Container(
                            height: screenHeight(),
                            margin: const EdgeInsets.all(6),
                            decoration: boxDecoration(
                                backgroundColor: selectedStatus == 'pending'
                                    ? const Color(0xff6A0030)
                                    : Colors.white,
                                borderRadius: 62),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                "Pending".textMedium(
                                    color: selectedStatus == 'pending'
                                        ? Colors.white
                                        : ColorResources.black,
                                    fontSize: 14),
                                5.horizontalSpace(),
                                SvgPicture.asset(selectedStatus == 'pending'
                                    ? Images.pendingSelected
                                    : Images.pending)
                              ],
                            ),
                          ),
                        ),
                      ),
                      Expanded(
                        child: InkWell(
                          onTap: () {
                            if (selectedStatus != 'completed') {
                              selectedStatus = 'completed';
                              setState(() {});
                              BlocProvider.of<ProjectCubit>(context)
                                  .ddeProjectsApi(
                                  context, selectedStatus, false);
                            }
                          },
                          child: Container(
                            height: screenHeight(),
                            margin: const EdgeInsets.all(6),
                            decoration: boxDecoration(
                                backgroundColor: selectedStatus == 'completed'
                                    ? const Color(0xff6A0030)
                                    : Colors.white,
                                borderRadius: 62),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                "Completed".textMedium(
                                    color: selectedStatus == 'completed'
                                        ? Colors.white
                                        : ColorResources.black,
                                    fontSize: 14),
                                5.horizontalSpace(),
                                SvgPicture.asset(selectedStatus == 'completed'
                                    ? Images.completedSelected
                                    : Images.completed)
                              ],
                            ),
                          ),
                        ),
                      ),
                    ],
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
                                  projectStatus: state.responseDdeProject!.data!
                                      .projectList![i].projectStatus ?? '',
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
                                      .projectList![i].roiPerYear ?? 0,
                                  loan: state.responseDdeProject!.data!
                                      .projectList![i].loanAmount ?? 0,
                                  emi: state.responseDdeProject!.data!
                                      .projectList![i].emiAmount ?? 0,
                                  balance: 0,
                                  farmerName: state.responseDdeProject!.data!
                                      .projectList![i].farmerMaster!.name ?? '',
                                  farmerAddress: state.responseDdeProject!.data!
                                      .projectList![i].farmerMaster!.fAddress ??
                                      '',
                                  farmerImage: state.responseDdeProject!.data!
                                      .projectList![i].farmerMaster!.photo ??
                                      '',
                                  farmerPhone: state.responseDdeProject!.data!
                                      .projectList![i].farmerMaster!.phone ??
                                      '',
                                  projectPercent: 0,
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
