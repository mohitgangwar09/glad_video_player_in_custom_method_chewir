import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:glad/cubit/dde_farmer_cubit/dde_farmer_cubit.dart';
import 'package:glad/cubit/project_cubit/project_cubit.dart';
import 'package:glad/screen/custom_widget/custom_appbar.dart';
import 'package:glad/screen/custom_widget/custom_methods.dart';
import 'package:glad/utils/color_resources.dart';
import 'package:glad/utils/extension.dart';
import 'package:glad/utils/images.dart';
import 'package:glad/utils/styles.dart';

import 'application_widget.dart';

class ApplicationScreen extends StatefulWidget {
  const ApplicationScreen({Key? key}) : super(key: key);

  @override
  State<ApplicationScreen> createState() => _ApplicationScreenState();
}

class _ApplicationScreenState extends State<ApplicationScreen> {

  String selectedFilter = 'pending';

  @override
  void initState() {
    selectedFilter = BlocProvider.of<ProjectCubit>(context).state.selectedFilterMCCApplication!;
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
                  titleText1: 'Loan Applications',
                  titleText1Style: figtreeMedium.copyWith(
                      fontSize: 20, color: Colors.black),
                  centerTitle: true,
                  leading: const SizedBox.shrink(),
                ),

                10.verticalSpace(),


                Container(
                  height: 50,
                  margin: 20.marginHorizontal(),
                  width: screenWidth(),
                  decoration: boxDecoration(
                      borderRadius: 62,
                      borderColor: const Color(0xffDCDCDC),
                      backgroundColor: Colors.white
                  ),
                  child: Row(
                    children: [

                      Expanded(
                        child: InkWell(
                          onTap: () {
                            if (selectedFilter != 'pending') {
                              selectedFilter = 'pending';
                              setState(() {});
                              BlocProvider.of<ProjectCubit>(context)
                                  .ddeProjectsApi(
                                  context, selectedFilter, false);
                              BlocProvider.of<ProjectCubit>(context).emit(BlocProvider.of<ProjectCubit>(context).state.copyWith(selectedFilterMCCApplication: 'pending'));
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
                            if (selectedFilter != 'approved') {
                              selectedFilter = 'approved';
                              setState(() {});
                              BlocProvider.of<ProjectCubit>(context)
                                  .ddeProjectsApi(
                                  context, selectedFilter, false);
                              BlocProvider.of<ProjectCubit>(context).emit(BlocProvider.of<ProjectCubit>(context).state.copyWith(selectedFilterMCCApplication: 'approved'));
                            }
                          },
                          child: Container(
                            height: screenHeight(),
                            margin: const EdgeInsets.all(6),
                            decoration: boxDecoration(
                                backgroundColor: selectedFilter == 'approved'
                                    ? const Color(0xff6A0030)
                                    : Colors.white,
                                borderRadius: 62),
                            padding: const EdgeInsets.symmetric(horizontal: 10),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                "Approved".textMedium(
                                    color: selectedFilter == 'approved'
                                        ? Colors.white
                                        : ColorResources.black,
                                    fontSize: 14),
                                5.horizontalSpace(),
                                SvgPicture.asset(selectedFilter == 'approved'
                                    ? Images.pendingSelected
                                    : Images.pending)
                              ],
                            ),
                          ),
                        ),
                      ),

                      /*Expanded(
                        child: Container(
                          height: screenHeight(),
                          margin: const EdgeInsets.all(6),
                          decoration: boxDecoration(
                              backgroundColor: const Color(0xff6A0030),
                              borderRadius: 62
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [

                              "Pending".textMedium(color: Colors.white,fontSize: 14),

                              5.horizontalSpace(),

                              SvgPicture.asset(Images.pendingSelected)

                            ],
                          ),
                        ),
                      ),

                      Expanded(
                        child: Container(
                          height: screenHeight(),
                          margin: const EdgeInsets.all(6),
                          decoration: boxDecoration(
                              backgroundColor: Colors.white,
                              borderRadius: 62
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [

                              "Approved".textMedium(color: Colors.black,fontSize: 14),

                              5.horizontalSpace(),

                              SvgPicture.asset(Images.completed,)

                            ],
                          ),
                        ),
                      ),*/
                    ],
                  ),
                ),

                state.responseDdeProject!.data!.projectList!.isNotEmpty
                    ?
                Expanded(
                  child: SingleChildScrollView(
                    child: Padding(
                      padding: const EdgeInsets.only(bottom: 120.0),
                      child: customList(
                          list: state.responseDdeProject!.data!
                              .projectList!,
                          child: (i){
                            return Padding(
                              padding: const EdgeInsets.only(right: 20.0),
                              child: customProjectContainer(
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
                                      selectedFilter: selectedFilter

                                  ),
                                  width: screenWidth()),
                            );
                          }),
                    ),
                  ),
                ):
                const SizedBox(
                  height: 350,
                    child: Center(child: Text("No data found"))),
              ],
            ),
          ],
        );
      }
    });
  }
}
