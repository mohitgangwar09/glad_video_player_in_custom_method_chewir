import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:glad/cubit/dde_farmer_cubit/dde_farmer_cubit.dart';
import 'package:glad/cubit/project_cubit/project_cubit.dart';
import 'package:glad/screen/custom_widget/custom_appbar.dart';
import 'package:glad/screen/custom_widget/custom_methods.dart';
import 'package:glad/screen/dde_screen/dashboard/dashboard_dde.dart';
import 'package:glad/screen/dde_screen/dde_farmer_filter.dart';
import 'package:glad/screen/supplier_screen/dashboard/dashboard_supplier.dart';
import 'package:glad/screen/supplier_screen/widget/project_supplier_widget.dart';
import 'package:glad/utils/color_resources.dart';
import 'package:glad/utils/extension.dart';
import 'package:glad/utils/images.dart';
import 'package:glad/utils/styles.dart';

class Projects extends StatefulWidget {
  const Projects({Key? key}) : super(key: key);

  @override
  State<Projects> createState() => _ProjectsState();
}

class _ProjectsState extends State<Projects> {
  String selectedFilter = 'active';

  @override
  void initState() {
    BlocProvider.of<ProjectCubit>(context)
        .supplierProjectsApi(context, selectedFilter, true);
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
      } else if (state.responseSupplierProject == null) {
        return const Center(child: Text("Please check your internet connection"));
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
                        supplierLandingKey.currentState?.openDrawer();
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
                      10.horizontalSpace(),
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
                Padding(
                  padding: const EdgeInsets.only(left: 20.0,right: 20),
                  child: Container(
                    height: 50,
                    // margin: 30.marginRight(),
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
                                    .supplierProjectsApi(
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
                                      : Images.active)
                                ],
                              ),
                            ),
                          ),
                        ),
                        Expanded(
                          child: InkWell(
                            onTap: () {
                              if (selectedFilter != 'completed_project') {
                                selectedFilter = 'completed_project';
                                setState(() {});
                                BlocProvider.of<ProjectCubit>(context)
                                    .supplierProjectsApi(
                                    context, selectedFilter, false);
                              }
                            },
                            child: Container(
                              height: screenHeight(),
                              margin: const EdgeInsets.all(6),
                              decoration: boxDecoration(
                                  backgroundColor: selectedFilter == 'completed_project'
                                      ? const Color(0xff6A0030)
                                      : Colors.white,
                                  borderRadius: 62),
                              padding: const EdgeInsets.symmetric(horizontal: 10),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  "Completed".textMedium(
                                      color: selectedFilter == 'completed_project'
                                          ? Colors.white
                                          : ColorResources.black,
                                      fontSize: 14),
                                  5.horizontalSpace(),
                                  SvgPicture.asset(selectedFilter == 'completed_project'
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
                ),
                state.responseSupplierProject!.data!.projectList!.isNotEmpty
                    ? Expanded(
                  child: SingleChildScrollView(
                    padding: const EdgeInsets.only(bottom: 120, left: 10),
                    child: customList(
                        list: List.generate(state.responseSupplierProject!.data!
                            .projectList!.length, (index) => null),
                        child: (int i) {
                          return Padding(
                            padding: const EdgeInsets.only(right: 20.0),
                            child: customProjectContainer(
                                child: ProjectSupplierWidget(
                                    status: true,
                                    projectStatus: formatProjectStatus(state.responseSupplierProject!.data!
                                        .projectList![i].projectStatus ?? ''),
                                    name: state.responseSupplierProject!.data!
                                        .projectList![i].name ?? '',
                                    category: state.responseSupplierProject!.data!
                                        .projectList![i].improvementArea !=
                                        null ? state.responseSupplierProject!.data!
                                        .projectList![i]
                                        .improvementArea!.name ?? '' : '',
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
                                    // farmerDetail: state.responseSupplierProject!.data!
                                    //     .projectList![i].farmerMaster!,
                                  selectedFilter: selectedFilter,
                                  milestones: state.responseSupplierProject!.data!.projectList![i].farmerProjectMilestones!,

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
