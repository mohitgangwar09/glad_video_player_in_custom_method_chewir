import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:glad/cubit/profile_cubit/profile_cubit.dart';
import 'package:glad/screen/custom_widget/custom_appbar.dart';
import 'package:glad/screen/custom_widget/custom_methods.dart';
import 'package:glad/screen/dde_screen/edit_improvement_area.dart';
import 'package:glad/utils/color_resources.dart';
import 'package:glad/utils/extension.dart';
import 'package:glad/utils/images.dart';
import 'package:glad/utils/styles.dart';
import 'package:stepper_list_view/stepper_list_view.dart';

class ImprovementArea extends StatefulWidget {
  const ImprovementArea({super.key, required this.index, required this.fromDDE, required this.farmerId});
  final int index;
  final bool fromDDE;
  final int farmerId;

  @override
  State<ImprovementArea> createState() => _ImprovementAreaState();
}

class _ImprovementAreaState extends State<ImprovementArea> {
  @override
  void initState() {
    BlocProvider.of<ProfileCubit>(context).getStepperData(widget.index);
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocBuilder<ProfileCubit, ProfileCubitState>(
          builder: (context, state) {
            if (state.status == ProfileStatus.loading) {
              return const Center(
                  child: CircularProgressIndicator(
                    color: ColorResources.maroon,
                  ));
            } else if (state.improvementAreaListResponse == null) {
              return Center(child: Text("${state.improvementAreaListResponse} Api Error"));
            } else {
              return Stack(
                children: [
                  landingBackground(),
                  Column(
                    children: [
                      CustomAppBar(
                        context: context,
                        titleText1: state.improvementAreaListResponse!
                                      .data!
                                      .improvementAreaList![
                                  widget.index]
                                      .name ??
                                      '',
                        description: 'Survey details',
                        leading: arrowBackButton(),
                        action: Row(children: [
                          if(widget.fromDDE)
                            InkWell(
                                onTap: () {
                                  EditImprovementArea(
                                      improvementIndex: widget.index,
                                      farmerId: widget.farmerId)
                                      .navigate();
                                },
                                child:
                                SvgPicture.asset(Images.profileEdit)),
                        ],),
                        centerTitle: true,
                      ),
                      Expanded(
                        child: SingleChildScrollView(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              // 30.verticalSpace(),
                              // Center(
                              //   child: Stack(
                              //     children: [
                              //       ClipRRect(
                              //         borderRadius:
                              //         BorderRadius.circular(16.0),
                              //         child: CachedNetworkImage(
                              //           imageUrl: state
                              //               .improvementAreaListResponse!
                              //               .data!
                              //               .improvementAreaList![
                              //           widget.index]
                              //               .image ??
                              //               '',
                              //           errorWidget: (_, __, ___) =>
                              //               Image.asset(
                              //                 Images.facilities,
                              //                 width: screenWidth() * 0.7,
                              //                 height: screenWidth() * 0.6,
                              //                 fit: BoxFit.cover,
                              //                 alignment: Alignment.center,
                              //               ),
                              //           width: screenWidth() * 0.7,
                              //           height: screenWidth() * 0.6,
                              //           fit: BoxFit.cover,
                              //           alignment: Alignment.center,
                              //         ),
                              //       ),
                              //       Positioned(
                              //         bottom: 20,
                              //         right: 10,
                              //         left: 10,
                              //         child: Text(
                              //           state
                              //               .improvementAreaListResponse!
                              //               .data!
                              //               .improvementAreaList![
                              //           widget.index]
                              //               .name ??
                              //               '',
                              //           style: figtreeMedium.copyWith(
                              //               color: Colors.white,
                              //               fontSize: 18),
                              //           textAlign: TextAlign.center,
                              //         ),
                              //       )
                              //     ],
                              //   ),
                              // ),
                              // 30.verticalSpace(),
                              // Padding(
                              //   padding: const EdgeInsets.symmetric(horizontal: 20),
                              //   child: Row(
                              //     mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              //     children: [
                              //       'Survey details'
                              //           .textMedium(color: Colors.black, fontSize: 18),
                              //       if(widget.fromDDE)
                              //       InkWell(
                              //           onTap: () {
                              //             EditImprovementArea(
                              //                 improvementIndex: widget.index,
                              //                 farmerId: widget.farmerId)
                              //                 .navigate();
                              //           },
                              //           child:
                              //           SvgPicture.asset(Images.profileEdit)),
                              //     ],
                              //   ),
                              // ),
                              20.verticalSpace(),
                              Padding(
                                padding: const EdgeInsets.symmetric(horizontal: 20),
                                child:
                                'Details captured by dairy development expert (DDE) during the survey of the farm.'
                                    .textRegular(
                                    color: Colors.black, fontSize: 14),
                              ),
                              20.verticalSpace(),
                              Padding(
                                padding: const EdgeInsets.only(left: 12),
                                child: Stack(
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.only(left: 30),
                                      child: StepperListView(
                                        shrinkWrap: true,
                                        showStepperInLast: true,
                                        stepperData: state.stepperData,
                                        stepAvatar: (_, data) {
                                          return
                                            // data.id == '0'
                                            //   ? const PreferredSize(
                                            //       preferredSize: Size.fromRadius(3),
                                            //       child: SizedBox(),
                                            //     )
                                            //   :
                                            PreferredSize(
                                              preferredSize:
                                              const Size.fromRadius(3),
                                              child: Container(
                                                height: 7,
                                                width: 7,
                                                decoration: const BoxDecoration(
                                                    color: Color(0xFFDCDCDC),
                                                    shape: BoxShape.circle),
                                              ),
                                            );
                                        },
                                        stepContentWidget: (_, data) {
                                          return Container(
                                            height: 80,
                                            padding:
                                            const EdgeInsets.only(left: 40),
                                            child: Column(
                                              crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                              children: [
                                                Text(data.content["title"],
                                                    style: figtreeRegular.copyWith(
                                                        fontSize: 12,
                                                        color: ColorResources
                                                            .fieldGrey)),
                                                10.verticalSpace(),
                                                Row(
                                                  children: [
                                                    Visibility(
                                                      visible: data.content["uom"] == 'ugx',
                                                      child: Text("UGX ",
                                                          style: figtreeMedium.copyWith(
                                                              fontSize: 16,
                                                              color: Colors.black)),
                                                    ),
                                                    Text(data.content["description"],
                                                        style: figtreeMedium.copyWith(
                                                            fontSize: 16,
                                                            color: Colors.black)),
                                                    Visibility(
                                                      visible: data.content["uom"] != 'ugx' && data.content["uom"] != null,
                                                      child: Text(" ${data.content["uom"]}" ,
                                                          style: figtreeMedium.copyWith(
                                                              fontSize: 16,
                                                              color: Colors.black)),
                                                    ),
                                                  ],
                                                ),
                                              ],
                                            ),
                                          );
                                        },
                                        stepperThemeData: const StepperThemeData(
                                            lineWidth: 1,
                                            lineColor: Color(0xFFDCDCDC)),
                                        physics: const BouncingScrollPhysics(),
                                      ),
                                    ),
                                    // Positioned(
                                    //     top: 30,
                                    //     child: SvgPicture.asset(Images.waterDrop)),
                                  ],
                                ),
                              ),
                              20.verticalSpace(),
                              Padding(
                                padding: const EdgeInsets.symmetric(horizontal: 20),
                                child: customProjectContainer(
                                    marginLeft: 0,
                                    marginTop: 0,
                                    width: screenWidth(),
                                    child: Container(
                                      padding: const EdgeInsets.all(20),
                                      child: Column(
                                        crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                        children: [

                                          state.improvementAreaListResponse!
                                              .data!
                                              .improvementAreaList![
                                          widget.index]
                                              .id == 2?
                                          Column(
                                            crossAxisAlignment: CrossAxisAlignment.start,
                                            children: [
                                              Text('Suggested Pasture Area',
                                                  style: figtreeRegular.copyWith(
                                                      fontSize: 12,
                                                      color: ColorResources
                                                          .fieldGrey)),
                                              5.verticalSpace(),
                                              Text("${state.resultData!.suggestedPastureArea}",
                                                  style: figtreeMedium.copyWith(
                                                      fontSize: 16,
                                                      color: Colors.black)),
                                            ],
                                          ):Column(
                                            crossAxisAlignment: CrossAxisAlignment.start,
                                            children: [
                                              Text('Total Distance Travelled',
                                                  style: figtreeRegular.copyWith(
                                                      fontSize: 12,
                                                      color: ColorResources
                                                          .fieldGrey)),
                                              5.verticalSpace(),
                                              Text("${state.resultData!.totalDistanceTravelled} km",
                                                  style: figtreeMedium.copyWith(
                                                      fontSize: 16,
                                                      color: Colors.black)),
                                            ],
                                          ),

                                          20.verticalSpace(),

                                          Text('Yield incremental /cow /day',
                                              style: figtreeRegular.copyWith(
                                                  fontSize: 12,
                                                  color: ColorResources
                                                      .fieldGrey)),

                                          10.verticalSpace(),

                                          Row(
                                            children: [
                                              Expanded(
                                                child: Column(
                                                  crossAxisAlignment: CrossAxisAlignment.start,
                                                  children: [
                                                    Text('Loss of Milk',
                                                        style: figtreeRegular.copyWith(
                                                            fontSize: 12,
                                                            color: ColorResources
                                                                .fieldGrey)),
                                                    5.verticalSpace(),
                                                    Text('${getCurrencyString(state.resultData!.lossOfMilkPerCow, unit: '')} Ltr.',
                                                        style: figtreeMedium.copyWith(
                                                            fontSize: 16,
                                                            color: Colors.black)),
                                                  ],
                                                ),
                                              ),
                                              Expanded(
                                                child: Column(
                                                  crossAxisAlignment: CrossAxisAlignment.start,
                                                  children: [
                                                    Text('Current Yield',
                                                        style: figtreeRegular.copyWith(
                                                            fontSize: 12,
                                                            color: ColorResources
                                                                .fieldGrey)),
                                                    5.verticalSpace(),
                                                    Text('${getCurrencyString(0, unit: '')} Ltr.',
                                                        style: figtreeMedium.copyWith(
                                                            fontSize: 16,
                                                            color: Colors.black)),
                                                  ],
                                                ),
                                              ),
                                              // 20.verticalSpace(),
                                              Expanded(
                                                child: Column(
                                                  crossAxisAlignment: CrossAxisAlignment.start,
                                                  children: [
                                                    Text('Expected Yield',
                                                        style: figtreeRegular.copyWith(
                                                            fontSize: 12,
                                                            color: ColorResources
                                                                .fieldGrey)),
                                                    5.verticalSpace(),
                                                    Text('${getCurrencyString(state.resultData!.expectedYieldPerCow, unit: '')} Ltr.',
                                                        style: figtreeMedium.copyWith(
                                                            fontSize: 16,
                                                            color: Colors.black)),
                                                  ],
                                                ),
                                              ),
                                            ],
                                          ),

                                          /*  Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          Text('Loss of Milk Yield /cow /day',
                                              style: figtreeRegular.copyWith(
                                                  fontSize: 12,
                                                  color: ColorResources
                                                      .fieldGrey)),
                                          5.verticalSpace(),
                                          Text('${getCurrencyString(state.resultData!.lossOfMilkPerCow, unit: '')} Ltr.',
                                              style: figtreeMedium.copyWith(
                                                  fontSize: 16,
                                                  color: Colors.black)),
                                        ],
                                      ),
                                      // 20.verticalSpace(),
                                      Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          Text('Expected Yield /cow /day',
                                              style: figtreeRegular.copyWith(
                                                  fontSize: 12,
                                                  color: ColorResources
                                                      .fieldGrey)),
                                          5.verticalSpace(),
                                          Text('${getCurrencyString(state.resultData!.expectedYieldPerCow, unit: '')} Ltr.',
                                              style: figtreeMedium.copyWith(
                                                  fontSize: 16,
                                                  color: Colors.black)),
                                        ],
                                      ),*/
                                          20.verticalSpace(),
                                          Column(
                                            crossAxisAlignment: CrossAxisAlignment.start,
                                            children: [
                                              Text('Expected incremental production',
                                                  style: figtreeRegular.copyWith(
                                                      fontSize: 12,
                                                      color: ColorResources
                                                          .fieldGrey)),
                                              15.verticalSpace(),
                                              Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                children: [
                                                  Column(crossAxisAlignment: CrossAxisAlignment.start,children: [
                                                    Text('Per day',
                                                        style: figtreeRegular.copyWith(
                                                            fontSize: 12,
                                                            color: ColorResources
                                                                .fieldGrey)),
                                                    5.verticalSpace(),
                                                    Text('${getCurrencyString(double.parse(state.resultData!.incrementalProduction.toStringAsFixed(2)), unit: '')} Ltr.',
                                                        style: figtreeMedium.copyWith(
                                                            fontSize: 16,
                                                            color: Colors.black)),
                                                  ],),
                                                  Column(crossAxisAlignment: CrossAxisAlignment.start,children: [
                                                    Text('Per month',
                                                        style: figtreeRegular.copyWith(
                                                            fontSize: 12,
                                                            color: ColorResources
                                                                .fieldGrey)),
                                                    5.verticalSpace(),
                                                    Text('${getCurrencyString(state.resultData!.incrementalProduction * 30, unit: '')} Ltr.',
                                                        style: figtreeMedium.copyWith(
                                                            fontSize: 16,
                                                            color: Colors.black)),
                                                  ],),
                                                  Column(crossAxisAlignment: CrossAxisAlignment.start,children: [
                                                    Text('Per year',
                                                        style: figtreeRegular.copyWith(
                                                            fontSize: 12,
                                                            color: ColorResources
                                                                .fieldGrey)),
                                                    5.verticalSpace(),
                                                    Text('${getCurrencyString(state.resultData!.incrementalProduction * 365, unit: '')} Ltr.',
                                                        style: figtreeMedium.copyWith(
                                                            fontSize: 16,
                                                            color: Colors.black)),
                                                  ],)
                                                ],)
                                            ],
                                          ),
                                          20.verticalSpace(),
                                          Column(
                                            crossAxisAlignment: CrossAxisAlignment.start,
                                            children: [
                                              Text('Expected incremental earning',
                                                  style: figtreeRegular.copyWith(
                                                      fontSize: 12,
                                                      color: ColorResources
                                                          .fieldGrey)),
                                              15.verticalSpace(),
                                              Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                children: [
                                                  Column(crossAxisAlignment: CrossAxisAlignment.start,children: [
                                                    Text('Per day',
                                                        style: figtreeRegular.copyWith(
                                                            fontSize: 12,
                                                            color: ColorResources
                                                                .fieldGrey)),
                                                    5.verticalSpace(),
                                                    Text(getCurrencyString(state.resultData!.incrementalEarning),
                                                        style: figtreeMedium.copyWith(
                                                            fontSize: 16,
                                                            color: Colors.black)),
                                                  ],),
                                                  Column(crossAxisAlignment: CrossAxisAlignment.start,children: [
                                                    Text('Per month',
                                                        style: figtreeRegular.copyWith(
                                                            fontSize: 12,
                                                            color: ColorResources
                                                                .fieldGrey)),
                                                    5.verticalSpace(),
                                                    Text(getCurrencyString(state.resultData!.incrementalEarning * 30),
                                                        style: figtreeMedium.copyWith(
                                                            fontSize: 16,
                                                            color: Colors.black)),
                                                  ],),
                                                  Column(crossAxisAlignment: CrossAxisAlignment.start,children: [
                                                    Text('Per year',
                                                        style: figtreeRegular.copyWith(
                                                            fontSize: 12,
                                                            color: ColorResources
                                                                .fieldGrey)),
                                                    5.verticalSpace(),
                                                    Text(getCurrencyString(state.resultData!.incrementalEarning * 365),
                                                        style: figtreeMedium.copyWith(
                                                            fontSize: 16,
                                                            color: Colors.black)),
                                                  ],)
                                                ],)
                                            ],
                                          )
                                        ],
                                      ),
                                    )),
                              ),
                              30.verticalSpace(),
                              // state.improvementAreaListResponse!.data!.improvementAreaList![widget.index]
                              //     .projects!.isNotEmpty
                              //     ? Column(
                              //   crossAxisAlignment: CrossAxisAlignment.start,
                              //   children: [
                              //     Padding(
                              //       padding: const EdgeInsets.symmetric(
                              //           horizontal: 20),
                              //       child: 'Suggested investment'.textMedium(
                              //           color: Colors.black, fontSize: 18),
                              //     ),
                              //     10.verticalSpace(),
                              //     Padding(
                              //       padding: const EdgeInsets.symmetric(
                              //           horizontal: 20),
                              //       child: InkWell(
                              //         onTap: () {
                              //           DDeFarmerInvestmentDetails(projectId: state.improvementAreaListResponse!.data!.improvementAreaList![widget.index].projects![0].projectId!,)
                              //               .navigate();
                              //           /*const SuggestedInvestment()
                              //               .navigate();*/
                              //         },
                              //         child: customProjectContainer(
                              //             marginLeft: 0,
                              //             marginTop: 0,
                              //             width: screenWidth(),
                              //             child: Container(
                              //               padding: const EdgeInsets.all(20),
                              //               child: Column(
                              //                 crossAxisAlignment:
                              //                 CrossAxisAlignment.start,
                              //                 children: [
                              //                   (state.improvementAreaListResponse!.data!.improvementAreaList![widget.index]
                              //                       .projects![0]
                              //                       .name ??
                              //                       '')
                              //                       .textMedium(
                              //                       color: Colors.black,
                              //                       fontSize: 18),
                              //                   10.verticalSpace(),
                              //                   (state.improvementAreaListResponse!.data!.improvementAreaList![widget.index]
                              //                       .projects![0]
                              //                       .description ??
                              //                       '')
                              //                       .textRegular(
                              //                       color: const Color(
                              //                           0xFF808080),
                              //                       fontSize: 14),
                              //                   20.verticalSpace(),
                              //                   Container(
                              //                     decoration: BoxDecoration(
                              //                         color: const Color(
                              //                             0xFFFFF3F4),
                              //                         borderRadius:
                              //                         BorderRadius
                              //                             .circular(10)),
                              //                     padding:
                              //                     const EdgeInsets.all(
                              //                         20),
                              //                     child: Row(
                              //                       mainAxisAlignment:
                              //                       MainAxisAlignment
                              //                           .spaceBetween,
                              //                       children: [
                              //                         Column(
                              //                           crossAxisAlignment:
                              //                           CrossAxisAlignment
                              //                               .start,
                              //                           children: [
                              //                             Text(
                              //                                 'UGX ${(state.improvementAreaListResponse!.data!.improvementAreaList![widget.index].projects![0].investmentAmount ?? '')}',
                              //                                 style: figtreeSemiBold
                              //                                     .copyWith(
                              //                                     fontSize:
                              //                                     16)),
                              //                             Text('Investment',
                              //                                 style: figtreeRegular
                              //                                     .copyWith(
                              //                                     fontSize:
                              //                                     12,
                              //                                     color: const Color(
                              //                                         0xFF808080))),
                              //                           ],
                              //                         ),
                              //                         10.horizontalSpace(),
                              //                         Column(
                              //                           crossAxisAlignment:
                              //                           CrossAxisAlignment
                              //                               .start,
                              //                           children: [
                              //                             Text(
                              //                                 'UGX ${(state.improvementAreaListResponse!.data!.improvementAreaList![widget.index].projects![0].revenuePerYear ?? '')}',
                              //                                 style: figtreeSemiBold
                              //                                     .copyWith(
                              //                                     fontSize:
                              //                                     16)),
                              //                             Text('Revenue',
                              //                                 style: figtreeRegular
                              //                                     .copyWith(
                              //                                     fontSize:
                              //                                     12,
                              //                                     color: const Color(
                              //                                         0xFF808080))),
                              //                           ],
                              //                         ),
                              //                         10.horizontalSpace(),
                              //                         Column(
                              //                           crossAxisAlignment:
                              //                           CrossAxisAlignment
                              //                               .start,
                              //                           children: [
                              //                             Text(
                              //                                 '${(state.improvementAreaListResponse!.data!.improvementAreaList![widget.index].projects![0].roiPerYear ?? '')}%',
                              //                                 style: figtreeSemiBold
                              //                                     .copyWith(
                              //                                     fontSize:
                              //                                     16)),
                              //                             Text('ROI',
                              //                                 style: figtreeRegular
                              //                                     .copyWith(
                              //                                     fontSize:
                              //                                     12,
                              //                                     color: const Color(
                              //                                         0xFF808080))),
                              //                           ],
                              //                         ),
                              //                       ],
                              //                     ),
                              //                   ),
                              //                   20.verticalSpace(),
                              //                   Row(
                              //                     mainAxisAlignment:
                              //                     MainAxisAlignment
                              //                         .spaceBetween,
                              //                     children: [
                              //                       Column(
                              //                         crossAxisAlignment:
                              //                         CrossAxisAlignment
                              //                             .start,
                              //                         children: [
                              //                           Text('UGX ${state.improvementAreaListResponse!.data!.improvementAreaList![widget.index].projects![0].loanAmount ?? ''}',
                              //                               style: figtreeMedium
                              //                                   .copyWith(
                              //                                   fontSize:
                              //                                   12)),
                              //                           Text('Loan',
                              //                               style: figtreeRegular
                              //                                   .copyWith(
                              //                                   fontSize:
                              //                                   12,
                              //                                   color: ColorResources
                              //                                       .fieldGrey)),
                              //                         ],
                              //                       ),
                              //                       10.horizontalSpace(),
                              //                       Column(
                              //                         crossAxisAlignment:
                              //                         CrossAxisAlignment
                              //                             .start,
                              //                         children: [
                              //                           Text('UGX ${state.improvementAreaListResponse!.data!.improvementAreaList![widget.index].projects![0].farmerParticipation ?? ''}',
                              //                               style: figtreeMedium
                              //                                   .copyWith(
                              //                                   fontSize:
                              //                                   12)),
                              //                           Text('Farmer share',
                              //                               style: figtreeRegular
                              //                                   .copyWith(
                              //                                   fontSize:
                              //                                   12,
                              //                                   color: ColorResources
                              //                                       .fieldGrey)),
                              //                         ],
                              //                       ),
                              //                       10.horizontalSpace(),
                              //                       Column(
                              //                         crossAxisAlignment:
                              //                         CrossAxisAlignment
                              //                             .start,
                              //                         children: [
                              //                           Text('${state.improvementAreaListResponse!.data!.improvementAreaList![widget.index].projects![0].repaymentMonths ?? ''} Months',
                              //                               style: figtreeMedium
                              //                                   .copyWith(
                              //                                   fontSize:
                              //                                   12)),
                              //                           Text('Repayment',
                              //                               style: figtreeRegular
                              //                                   .copyWith(
                              //                                   fontSize:
                              //                                   12,
                              //                                   color: ColorResources
                              //                                       .fieldGrey)),
                              //                         ],
                              //                       ),
                              //                       10.horizontalSpace(),
                              //                       Column(
                              //                         crossAxisAlignment:
                              //                         CrossAxisAlignment
                              //                             .start,
                              //                         children: [
                              //                           Text('UGX ${state.improvementAreaListResponse!.data!.improvementAreaList![widget.index].projects![0].emiAmount ?? ''}',
                              //                               style: figtreeMedium
                              //                                   .copyWith(
                              //                                   fontSize:
                              //                                   12)),
                              //                           Text('EMI',
                              //                               style: figtreeRegular
                              //                                   .copyWith(
                              //                                   fontSize:
                              //                                   12,
                              //                                   color: ColorResources
                              //                                       .fieldGrey)),
                              //                         ],
                              //                       ),
                              //                     ],
                              //                   ),
                              //                 ],
                              //               ),
                              //             )),
                              //       ),
                              //     ),
                              //     40.verticalSpace()
                              //   ],
                              // )
                              //     : const SizedBox.shrink(),
                            ],
                          ),
                        ),
                      )
                    ],
                  )
                ],
              );
            }
          }),
    );
  }
}
