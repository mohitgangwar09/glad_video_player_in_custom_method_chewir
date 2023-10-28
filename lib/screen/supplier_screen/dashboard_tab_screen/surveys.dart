import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:glad/cubit/dde_farmer_cubit/dde_farmer_cubit.dart';
import 'package:glad/cubit/project_cubit/project_cubit.dart';
import 'package:glad/screen/custom_widget/custom_appbar.dart';
import 'package:glad/screen/custom_widget/custom_methods.dart';
import 'package:glad/screen/dde_screen/dashboard/dashboard_dde.dart';
import 'package:glad/screen/dde_screen/dde_farmer_filter.dart';
import 'package:glad/screen/supplier_screen/widegt/project_supplier_widget.dart';
import 'package:glad/utils/color_resources.dart';
import 'package:glad/utils/extension.dart';
import 'package:glad/utils/images.dart';
import 'package:glad/utils/styles.dart';

class SurveysScreen extends StatefulWidget {
  const SurveysScreen({Key? key}) : super(key: key);

  @override
  State<SurveysScreen> createState() => _SurveysScreenState();
}

class _SurveysScreenState extends State<SurveysScreen> {
  String selectedFilter = 'new';

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
                  titleText1: 'Surveys',
                  titleText1Style:
                  figtreeMedium.copyWith(fontSize: 20, color: Colors.black),
                  centerTitle: true,
                  leading: openDrawer(
                      onTap: () {
                        ddeLandingKey.currentState?.openDrawer();
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
                SingleChildScrollView(
                  child: Container(
                    height: 50,
                    margin: const EdgeInsets.only(left: 20,right: 20),
                    width: screenWidth(),
                    decoration: boxDecoration(
                        borderRadius: 62,
                        borderColor: const Color(0xffDCDCDC),
                        backgroundColor: Colors.white),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [

                        Expanded(
                          child: InkWell(
                            onTap: () {
                              if (selectedFilter != 'new') {
                                selectedFilter = 'new';
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
                                  backgroundColor: selectedFilter == 'new'
                                      ? const Color(0xff6A0030)
                                      : Colors.white,
                                  borderRadius: 62),
                              padding: const EdgeInsets.symmetric(horizontal: 10),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  "New".textMedium(
                                      color: selectedFilter == 'new'
                                          ? Colors.white
                                          : ColorResources.black,
                                      fontSize: 14),
                                  5.horizontalSpace(),
                                  SvgPicture.asset(selectedFilter == 'new'
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
                        ),

                        Expanded(
                          child: InkWell(
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
                              margin: const EdgeInsets.only(left: 0,right: 4,top: 6,bottom: 6),
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
                                child: ProjectSupplierWidget(
                                    status: true,
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
                                    farmerDetail: state.responseDdeProject!.data!
                                        .projectList![i].farmerMaster!

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
