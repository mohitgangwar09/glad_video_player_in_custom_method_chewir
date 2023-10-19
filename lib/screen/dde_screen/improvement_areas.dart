import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:glad/cubit/improvement_area_cubit/improvement_area_cubit.dart';
import 'package:glad/screen/custom_widget/custom_appbar.dart';
import 'package:glad/screen/custom_widget/custom_methods.dart';
import 'package:glad/screen/dde_screen/edit_improvement_area.dart';
import 'package:glad/screen/dde_screen/suggested_investment.dart';
import 'package:glad/utils/color_resources.dart';
import 'package:glad/utils/extension.dart';
import 'package:glad/utils/images.dart';
import 'package:glad/utils/styles.dart';
import 'package:stepper_list_view/stepper_list_view.dart';

class ImprovementAreas extends StatefulWidget {
  const ImprovementAreas({super.key, required this.farmerId});
  final int farmerId;

  @override
  State<ImprovementAreas> createState() => _ImprovementAreasState();
}

class _ImprovementAreasState extends State<ImprovementAreas> {
  int pageIndex = 0;
  @override
  void initState() {
    super.initState();
    SchedulerBinding.instance.addPostFrameCallback((timeStamp) {
      BlocProvider.of<ImprovementAreaCubit>(context)
          .improvementAreaListApi(context, widget.farmerId, true, 0);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocBuilder<ImprovementAreaCubit, ImprovementAreaState>(
          builder: (context, state) {
        if (state.status == ImprovementAreaStatus.loading) {
          return const Center(
              child: CircularProgressIndicator(
            color: ColorResources.maroon,
          ));
        } else if (state.response == null) {
          return Center(child: Text("${state.response} Api Error"));
        } else {
          return Stack(
            children: [
              landingBackground(),
              Column(
                children: [
                  CustomAppBar(
                    context: context,
                    titleText1: "Improvement areas",
                    description: 'See the details of 06 improvement areas.',
                    leading: arrowBackButton(),
                    centerTitle: true,
                  ),
                  Expanded(
                    child: SingleChildScrollView(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          30.verticalSpace(),
                          CarouselSlider(
                              items: [
                                for (int index = 0;
                                    index <
                                        state.response!.data!
                                            .improvementAreaList!.length
                                            .toInt();
                                    index++)
                                  Stack(
                                    children: [
                                      ClipRRect(
                                        borderRadius:
                                            BorderRadius.circular(16.0),
                                        child: CachedNetworkImage(
                                          imageUrl: state
                                                  .response!
                                                  .data!
                                                  .improvementAreaList![index]
                                                  .image ??
                                              '',
                                          errorWidget: (_, __, ___) =>
                                              Image.asset(
                                            Images.facilities,
                                            width: screenWidth() *
                                                (pageIndex == index
                                                    ? 0.75
                                                    : 0.68),
                                            height: screenWidth() *
                                                (pageIndex == index
                                                    ? 0.65
                                                    : 0.58),
                                            fit: BoxFit.cover,
                                            alignment: Alignment.center,
                                          ),
                                          width: screenWidth() *
                                              (pageIndex == index
                                                  ? 0.75
                                                  : 0.68),
                                          height: screenWidth() *
                                              (pageIndex == index
                                                  ? 0.65
                                                  : 0.58),
                                          fit: BoxFit.cover,
                                          alignment: Alignment.center,
                                        ),
                                      ),
                                      Positioned(
                                        bottom: pageIndex == index ? 20 : 40,
                                        right: 10,
                                        left: 10,
                                        child: Text(
                                          state
                                                  .response!
                                                  .data!
                                                  .improvementAreaList![index]
                                                  .name ??
                                              '',
                                          style: figtreeMedium.copyWith(
                                              color: Colors.white,
                                              fontSize: 18),
                                          textAlign: TextAlign.center,
                                        ),
                                      )
                                    ],
                                  ),
                              ],
                              options: CarouselOptions(
                                autoPlay: false,
                                enableInfiniteScroll: false,
                                // viewportFraction: 1,
                                clipBehavior: Clip.none,
                                // enlargeCenterPage: true,
                                height: screenWidth() * 0.65,
                                onPageChanged: (index, reason) {
                                  context
                                      .read<ImprovementAreaCubit>()
                                      .getStepperData(index);
                                  pageIndex = index;
                                  setState(() {});
                                },
                              )),
                          30.verticalSpace(),
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 20),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                'Survey details'.textMedium(
                                    color: Colors.black, fontSize: 18),
                                InkWell(
                                    onTap: () {
                                      EditImprovementArea(
                                              improvementIndex: pageIndex,
                                              farmerId: widget.farmerId)
                                          .navigate();
                                    },
                                    child:
                                        SvgPicture.asset(Images.profileEdit)),
                              ],
                            ),
                          ),
                          10.verticalSpace(),
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
                                        preferredSize: const Size.fromRadius(3),
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
                                            Text(data.content["title"] ?? '',
                                                style: figtreeRegular.copyWith(
                                                    fontSize: 12,
                                                    color: ColorResources
                                                        .fieldGrey)),
                                            10.verticalSpace(),
                                            Row(
                                              children: [
                                                Visibility(
                                                  visible:
                                                      data.content["uom"] ==
                                                          'ugx',
                                                  child: Text("UGX ",
                                                      style: figtreeMedium
                                                          .copyWith(
                                                              fontSize: 16,
                                                              color: Colors
                                                                  .black)),
                                                ),
                                                Text(
                                                    data.content["description"] ?? '',
                                                    style:
                                                        figtreeMedium.copyWith(
                                                            fontSize: 16,
                                                            color:
                                                                Colors.black)),
                                                Visibility(
                                                  visible:
                                                      data.content["uom"] !=
                                                              'ugx' &&
                                                          data.content["uom"] !=
                                                              null,
                                                  child: Text(
                                                      " ${data.content["uom"]}",
                                                      style: figtreeMedium
                                                          .copyWith(
                                                              fontSize: 16,
                                                              color: Colors
                                                                  .black)),
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
                                      Column(
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
                                      10.verticalSpace(),
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
                                      ),
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
                                                Text('${getCurrencyString(state.resultData!.incrementalProduction, unit: '')} Ltr.',
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
                          state.response!.data!.improvementAreaList![pageIndex]
                                  .projects!.isNotEmpty
                              ? Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 20),
                                      child: 'Suggested investment'.textMedium(
                                          color: Colors.black, fontSize: 18),
                                    ),
                                    10.verticalSpace(),
                                    Padding(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 20),
                                      child: InkWell(
                                        onTap: () {
                                          const SuggestedInvestment()
                                              .navigate();
                                        },
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
                                                  (state
                                                              .response!
                                                              .data!
                                                              .improvementAreaList![
                                                                  pageIndex]
                                                              .projects![0]
                                                              .name ??
                                                          '')
                                                      .textMedium(
                                                          color: Colors.black,
                                                          fontSize: 18),
                                                  10.verticalSpace(),
                                                  (state
                                                              .response!
                                                              .data!
                                                              .improvementAreaList![
                                                                  pageIndex]
                                                              .projects![0]
                                                              .description ??
                                                          '')
                                                      .textRegular(
                                                          color: const Color(
                                                              0xFF808080),
                                                          fontSize: 14),
                                                  20.verticalSpace(),
                                                  Container(
                                                    decoration: BoxDecoration(
                                                        color: const Color(
                                                            0xFFFFF3F4),
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(10)),
                                                    padding:
                                                        const EdgeInsets.all(
                                                            20),
                                                    child: Row(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .spaceBetween,
                                                      children: [
                                                        Column(
                                                          crossAxisAlignment:
                                                              CrossAxisAlignment
                                                                  .start,
                                                          children: [
                                                            Text(
                                                                getCurrencyString(state.response!.data!.improvementAreaList![pageIndex].projects![0].investmentAmount ?? 0),
                                                                style: figtreeSemiBold
                                                                    .copyWith(
                                                                        fontSize:
                                                                            16)),
                                                            Text('Investment',
                                                                style: figtreeRegular
                                                                    .copyWith(
                                                                        fontSize:
                                                                            12,
                                                                        color: const Color(
                                                                            0xFF808080))),
                                                          ],
                                                        ),
                                                        10.horizontalSpace(),
                                                        Column(
                                                          crossAxisAlignment:
                                                              CrossAxisAlignment
                                                                  .start,
                                                          children: [
                                                            Text(
                                                                getCurrencyString(state.response!.data!.improvementAreaList![pageIndex].projects![0].revenuePerYear ?? 0),
                                                                style: figtreeSemiBold
                                                                    .copyWith(
                                                                        fontSize:
                                                                            16)),
                                                            Text('Revenue',
                                                                style: figtreeRegular
                                                                    .copyWith(
                                                                        fontSize:
                                                                            12,
                                                                        color: const Color(
                                                                            0xFF808080))),
                                                          ],
                                                        ),
                                                        10.horizontalSpace(),
                                                        Column(
                                                          crossAxisAlignment:
                                                              CrossAxisAlignment
                                                                  .start,
                                                          children: [
                                                            Text(
                                                                '${(state.response!.data!.improvementAreaList![pageIndex].projects![0].roiPerYear ?? '')}%',
                                                                style: figtreeSemiBold
                                                                    .copyWith(
                                                                        fontSize:
                                                                            16)),
                                                            Text('ROI',
                                                                style: figtreeRegular
                                                                    .copyWith(
                                                                        fontSize:
                                                                            12,
                                                                        color: const Color(
                                                                            0xFF808080))),
                                                          ],
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                  20.verticalSpace(),
                                                  Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .spaceBetween,
                                                    children: [
                                                      Column(
                                                        crossAxisAlignment:
                                                            CrossAxisAlignment
                                                                .start,
                                                        children: [
                                                          Text(getCurrencyString(state.response!.data!.improvementAreaList![pageIndex].projects![0].loanAmount ?? 0),
                                                              style: figtreeMedium
                                                                  .copyWith(
                                                                      fontSize:
                                                                          12)),
                                                          Text('Loan',
                                                              style: figtreeRegular
                                                                  .copyWith(
                                                                      fontSize:
                                                                          12,
                                                                      color: ColorResources
                                                                          .fieldGrey)),
                                                        ],
                                                      ),
                                                      10.horizontalSpace(),
                                                      Column(
                                                        crossAxisAlignment:
                                                            CrossAxisAlignment
                                                                .start,
                                                        children: [
                                                          Text(getCurrencyString(state.response!.data!.improvementAreaList![pageIndex].projects![0].farmerParticipation ?? 0),
                                                              style: figtreeMedium
                                                                  .copyWith(
                                                                      fontSize:
                                                                          12)),
                                                          Text('Farmer share',
                                                              style: figtreeRegular
                                                                  .copyWith(
                                                                      fontSize:
                                                                          12,
                                                                      color: ColorResources
                                                                          .fieldGrey)),
                                                        ],
                                                      ),
                                                      10.horizontalSpace(),
                                                      Column(
                                                        crossAxisAlignment:
                                                            CrossAxisAlignment
                                                                .start,
                                                        children: [
                                                          Text('${state.response!.data!.improvementAreaList![pageIndex].projects![0].repaymentMonths ?? ''} Months',
                                                              style: figtreeMedium
                                                                  .copyWith(
                                                                      fontSize:
                                                                          12)),
                                                          Text('Repayment',
                                                              style: figtreeRegular
                                                                  .copyWith(
                                                                      fontSize:
                                                                          12,
                                                                      color: ColorResources
                                                                          .fieldGrey)),
                                                        ],
                                                      ),
                                                      10.horizontalSpace(),
                                                      Column(
                                                        crossAxisAlignment:
                                                            CrossAxisAlignment
                                                                .start,
                                                        children: [
                                                          Text(getCurrencyString(state.response!.data!.improvementAreaList![pageIndex].projects![0].emiAmount ?? 0),
                                                              style: figtreeMedium
                                                                  .copyWith(
                                                                      fontSize:
                                                                          12)),
                                                          Text('EMI',
                                                              style: figtreeRegular
                                                                  .copyWith(
                                                                      fontSize:
                                                                          12,
                                                                      color: ColorResources
                                                                          .fieldGrey)),
                                                        ],
                                                      ),
                                                    ],
                                                  ),
                                                ],
                                              ),
                                            )),
                                      ),
                                    ),
                                    40.verticalSpace()
                                  ],
                                )
                              : const SizedBox.shrink(),
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
