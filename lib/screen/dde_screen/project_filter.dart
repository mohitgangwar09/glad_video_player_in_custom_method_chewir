import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:glad/cubit/project_cubit/project_cubit.dart';
import 'package:glad/screen/custom_widget/custom_appbar.dart';
import 'package:glad/screen/custom_widget/custom_methods.dart';
import 'package:glad/utils/color_resources.dart';
import 'package:glad/utils/extension.dart';
import 'package:glad/utils/styles.dart';

class ProjectFilter extends StatefulWidget {
  const ProjectFilter(this.selectedFilter,{Key? key,}) : super(key: key);
  final String selectedFilter;

  @override
  State<ProjectFilter> createState() => _ProjectFilterState();
}

class _ProjectFilterState extends State<ProjectFilter> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: BlocBuilder<ProjectCubit, ProjectState>(builder: (context, state) {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CustomAppBar(
                context: context,
                centerTitle: true,
                titleText1: 'Filters',
                titleText1Style: figtreeMedium.copyWith(fontSize: 20, color: Colors.black),
                leading: TextButton(
                    onPressed: () {
                      BlocProvider.of<ProjectCubit>(context).roiFilterClear();
                      BlocProvider.of<ProjectCubit>(context)
                          .ddeProjectsApi(
                          context, widget.selectedFilter, false);
                      pressBack();
                    },
                    child: "Cancel"
                        .textMedium(color: ColorResources.maroon, fontSize: 12)),
                action: TextButton(
                    onPressed: () {
                      BlocProvider.of<ProjectCubit>(context).roiFilterClear();
                      BlocProvider.of<ProjectCubit>(context)
                          .ddeProjectsApi(
                          context, widget.selectedFilter, false);

                      pressBack();

                    }, child: "Reset"
                        .textMedium(color: ColorResources.maroon, fontSize: 12)),
              ),
              Expanded(
                child: SingleChildScrollView(
                  child: Padding(
                    padding: const EdgeInsets.only(left: 18.0, right: 18, top: 31),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        "Improvement areas".textMedium(fontSize: 18),

                        15.verticalSpace(),

                        state.responseImprovementAreaFilterList!=null?
                        Wrap(
                          children: state.responseImprovementAreaFilterList!.data!.map((item) => InkWell(
                            onTap: (){
                              context.read<ProjectCubit>().emit(state.copyWith(
                                  filterImprovementAreaName: item.name));
                            },
                            child: Container(
                                margin: 5.marginAll(),
                                padding: const EdgeInsets.only(
                                    left: 14, right: 14, bottom: 10, top: 10),
                                decoration: boxDecoration(
                                    borderColor: state.filterImprovementAreaName == item.name ?
                                    const Color(0xff6A0030):const Color(0xffDCDCDC),
                                    backgroundColor: state.filterImprovementAreaName == item.name ?const Color(0xffFFF3F4):Colors.transparent,
                                    borderRadius: 30),
                                child: Text(item.name.toString())),
                          ))
                              .toList()
                              .cast<Widget>(),
                        ):const SizedBox.shrink(),

                        33.verticalSpace(),

                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            "Revenue".textMedium(fontSize: 18),
                            "In Numbers".textSemiBold(
                                fontSize: 12, color: const Color(0xff727272))
                          ],
                        ),

                        customProjectContainer(
                            marginLeft: 0,
                            marginTop: 8,
                            height: 124,
                            child: Stack(
                              children: [
                                Row(
                                  children: [
                                    31.horizontalSpace(),
                                    Expanded(
                                      child: Column(
                                        mainAxisAlignment: MainAxisAlignment.center,
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          "From".textSemiBold(
                                            fontSize: 14,
                                          ),
                                          Container(
                                              margin: const EdgeInsets.only(top: 5),
                                              padding: const EdgeInsets.only(left: 10),
                                              decoration: boxDecoration(
                                                  borderRadius: 10,
                                                  borderColor: const Color(0xff767676)),
                                              height: 50,
                                              child: TextField(
                                                keyboardType: TextInputType.phone,
                                                maxLines: 1,
                                                maxLength: 10,
                                                controller: state.revenueFromController,
                                                onChanged: (value) {
                                                  setState(() {});
                                                },
                                                inputFormatters: [FilteringTextInputFormatter.digitsOnly, LengthLimitingTextInputFormatter(10)],
                                                decoration: const InputDecoration(
                                                    border: InputBorder.none,
                                                  counterText: ''
                                                ),
                                              ))
                                        ],
                                      ),
                                    ),
                                    18.horizontalSpace(),
                                    Expanded(
                                      child: Column(
                                        mainAxisAlignment: MainAxisAlignment.center,
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          "To".textSemiBold(
                                            fontSize: 14,
                                          ),
                                          Container(
                                              padding: const EdgeInsets.only(left: 10),
                                              margin: const EdgeInsets.only(top: 5),
                                              decoration: boxDecoration(
                                                  borderRadius: 10,
                                                  borderColor: const Color(0xff767676)),
                                              height: 50,
                                              child: TextField(
                                                keyboardType: TextInputType.phone,
                                                maxLines: 1,
                                                maxLength: 10,
                                                controller: state.revenueToController,
                                                onChanged: (value) {
                                                  setState(() {});
                                                },
                                                inputFormatters: [FilteringTextInputFormatter.digitsOnly, LengthLimitingTextInputFormatter(10)],
                                                decoration: const InputDecoration(
                                                    border: InputBorder.none,counterText: ''),
                                              ))
                                        ],
                                      ),
                                    ),
                                    31.horizontalSpace(),
                                  ],
                                ),
                                if(state.revenueToController.text.isNotEmpty&&state.revenueFromController.text.isNotEmpty)
                                  if(int.parse(state.revenueToController.text)<int.parse(state.revenueFromController.text))
                                    Positioned(
                                        left: 30,
                                        bottom: 6,
                                        child: "Revenue UpTo must be greater than Revenue From".textRegular(color: Colors.red,
                                            fontSize: 12))
                              ],
                            )),

                        33.verticalSpace(),

                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            "Investment".textMedium(fontSize: 18),
                            "In Number".textSemiBold(
                                fontSize: 12, color: const Color(0xff727272))
                          ],
                        ),

                        customProjectContainer(
                            marginLeft: 0,
                            marginTop: 8,
                            height: 124,
                            child: Stack(
                              children: [
                                Row(
                                  children: [
                                    31.horizontalSpace(),
                                    Expanded(
                                      child: Column(
                                        mainAxisAlignment: MainAxisAlignment.center,
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          "From".textSemiBold(
                                            fontSize: 14,
                                          ),
                                          Container(
                                              margin: const EdgeInsets.only(top: 5),
                                              padding: const EdgeInsets.only(left: 10),
                                              decoration: boxDecoration(
                                                  borderRadius: 10,
                                                  borderColor: const Color(0xff767676)),
                                              height: 50,
                                              child: TextField(
                                                keyboardType: TextInputType.phone,
                                                maxLines: 1,
                                                controller: state.investmentFromController,
                                                maxLength: 10,
                                                onChanged: (value) {
                                                  setState(() {});
                                                },
                                                inputFormatters: [FilteringTextInputFormatter.digitsOnly, LengthLimitingTextInputFormatter(10)],
                                                decoration: const InputDecoration(
                                                    border: InputBorder.none,counterText: '',),
                                              ))
                                        ],
                                      ),
                                    ),
                                    18.horizontalSpace(),
                                    Expanded(
                                      child: Column(
                                        mainAxisAlignment: MainAxisAlignment.center,
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          "UpTo".textSemiBold(
                                            fontSize: 14,
                                          ),
                                          Container(
                                              padding: const EdgeInsets.only(left: 10),
                                              margin: const EdgeInsets.only(top: 5),
                                              decoration: boxDecoration(
                                                  borderRadius: 10,
                                                  borderColor: const Color(0xff767676)),
                                              height: 50,
                                              child: TextField(
                                                keyboardType: TextInputType.phone,
                                                maxLines: 1,
                                                controller: state.investmentUpToController,
                                                maxLength: 10,
                                                onChanged: (value) {
                                                  setState(() {});
                                                },
                                                inputFormatters: [FilteringTextInputFormatter.digitsOnly, LengthLimitingTextInputFormatter(10)],
                                                decoration: const InputDecoration(
                                                    border: InputBorder.none,counterText: '',),
                                              ))
                                        ],
                                      ),
                                    ),
                                    31.horizontalSpace(),
                                  ],
                                ),
                                if(state.investmentUpToController.text.isNotEmpty&&state.investmentFromController.text.isNotEmpty)
                                  if(int.parse(state.investmentUpToController.text)<int.parse(state.investmentFromController.text))
                                    Positioned(
                                        left: 30,
                                        bottom: 6,
                                        child: "Investment UpTo must be greater than Investment From".textRegular(color: Colors.red,
                                            fontSize: 12))
                              ],
                            )),

                        33.verticalSpace(),

                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            "ROI".textMedium(fontSize: 18),
                            "In Numbers".textSemiBold(
                                fontSize: 12, color: const Color(0xff727272))
                          ],
                        ),

                        customProjectContainer(
                            marginLeft: 0,
                            marginTop: 8,
                            height: 124,
                            child: Stack(
                              children: [
                                Row(
                                  children: [
                                    31.horizontalSpace(),
                                    Expanded(
                                      child: Column(
                                        mainAxisAlignment: MainAxisAlignment.center,
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          "From".textSemiBold(
                                            fontSize: 14,
                                          ),
                                          Container(
                                              margin: const EdgeInsets.only(top: 5),
                                              padding: const EdgeInsets.only(left: 10),
                                              decoration: boxDecoration(
                                                  borderRadius: 10,
                                                  borderColor: const Color(0xff767676)),
                                              height: 50,
                                              child: TextField(
                                                keyboardType: TextInputType.phone,
                                                maxLines: 1,
                                                maxLength: 10,
                                                onChanged: (value) {
                                                  setState(() {});
                                                },
                                                controller: state.roiFromController,
                                                inputFormatters: [FilteringTextInputFormatter.digitsOnly, LengthLimitingTextInputFormatter(10)],
                                                decoration: const InputDecoration(
                                                  counterText: '',
                                                    border: InputBorder.none),
                                              ))
                                        ],
                                      ),
                                    ),
                                    18.horizontalSpace(),
                                    Expanded(
                                      child: Column(
                                        mainAxisAlignment: MainAxisAlignment.center,
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          "UpTo".textSemiBold(
                                            fontSize: 14,
                                          ),
                                          Container(
                                              padding: const EdgeInsets.only(left: 10),
                                              margin: const EdgeInsets.only(top: 5),
                                              decoration: boxDecoration(
                                                  borderRadius: 10,
                                                  borderColor: const Color(0xff767676)),
                                              height: 50,
                                              child: TextField(
                                                keyboardType: TextInputType.phone,
                                                maxLines: 1,
                                                maxLength: 10,
                                                onChanged: (value) {
                                                  setState(() {});
                                                },
                                                controller: state.roiUpToController,
                                                inputFormatters: [FilteringTextInputFormatter.digitsOnly, LengthLimitingTextInputFormatter(10)],
                                                decoration: const InputDecoration(
                                                    border: InputBorder.none,counterText: '',),
                                              ))
                                        ],
                                      ),
                                    ),
                                    31.horizontalSpace(),
                                  ],
                                ),
                                if(state.roiUpToController.text.isNotEmpty&&state.roiFromController.text.isNotEmpty)
                                  if(int.parse(state.roiUpToController.text)<int.parse(state.roiFromController.text))
                                    Positioned(
                                        left: 30,
                                        bottom: 6,
                                        child: "ROI UpTo must be greater than ROI From".textRegular(color: Colors.red,
                                            fontSize: 12))
                              ],
                            )),

                        33.verticalSpace(),

                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            "Loan Amount".textMedium(fontSize: 18),
                            "In Numbers".textSemiBold(
                                fontSize: 12, color: const Color(0xff727272))
                          ],
                        ),

                        customProjectContainer(
                            marginLeft: 0,
                            marginTop: 8,
                            height: 124,
                            child: Stack(
                              children: [
                                Row(
                                  children: [
                                    31.horizontalSpace(),
                                    Expanded(
                                      child: Column(
                                        mainAxisAlignment: MainAxisAlignment.center,
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          "From".textSemiBold(
                                            fontSize: 14,
                                          ),
                                          Container(
                                              margin: const EdgeInsets.only(top: 5),
                                              padding: const EdgeInsets.only(left: 10),
                                              decoration: boxDecoration(
                                                  borderRadius: 10,
                                                  borderColor: const Color(0xff767676)),
                                              height: 50,
                                              child: TextField(
                                                keyboardType: TextInputType.phone,
                                                maxLines: 1,
                                                maxLength: 10,
                                                onChanged: (value) {
                                                  setState(() {});
                                                },
                                                controller: state.loanAmountFromController,
                                                inputFormatters: [FilteringTextInputFormatter.digitsOnly, LengthLimitingTextInputFormatter(10)],
                                                decoration: const InputDecoration(
                                                    border: InputBorder.none,counterText: '',),
                                              ))
                                        ],
                                      ),
                                    ),
                                    18.horizontalSpace(),
                                    Expanded(
                                      child: Column(
                                        mainAxisAlignment: MainAxisAlignment.center,
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          "UpTo".textSemiBold(
                                            fontSize: 14,
                                          ),
                                          Container(
                                              padding: const EdgeInsets.only(left: 10),
                                              margin: const EdgeInsets.only(top: 5),
                                              decoration: boxDecoration(
                                                  borderRadius: 10,
                                                  borderColor: const Color(0xff767676)),
                                              height: 50,
                                              child: TextField(
                                                keyboardType: TextInputType.phone,
                                                maxLines: 1,
                                                maxLength: 10,
                                                onChanged: (value) {
                                                  setState(() {});
                                                },
                                                controller: state.loanAmountUpToController,
                                                inputFormatters: [FilteringTextInputFormatter.digitsOnly, LengthLimitingTextInputFormatter(10)],
                                                decoration: const InputDecoration(
                                                    border: InputBorder.none,counterText: '',),
                                              ))
                                        ],
                                      ),
                                    ),
                                    31.horizontalSpace(),
                                  ],
                                ),
                                if(state.loanAmountUpToController.text.isNotEmpty&&state.loanAmountFromController.text.isNotEmpty)
                                  if(int.parse(state.loanAmountUpToController.text)<int.parse(state.loanAmountFromController.text))
                                    Positioned(
                                        left: 30,
                                        bottom: 6,
                                        child: "Loan Amount UpTo must be greater than Loan Amount From".textRegular(color: Colors.red,
                                            fontSize: 12))
                              ],
                            )),

                        10.verticalSpace(),

                        Container(
                            margin: 20.marginAll(),
                            height: 55,
                            width: screenWidth(),
                            child: customButton("Apply",
                                fontColor: 0xffffffff, onTap: () {
                                  if(state.revenueFromController.text.isNotEmpty && state.revenueToController.text.isNotEmpty && (int.parse(state.revenueToController.text) < int.parse(state.revenueFromController.text))) {
                                    showCustomToast(context, "Revenue UpTo must be greater than Revenue From");
                                  } else if(state.investmentFromController.text.isNotEmpty && state.investmentUpToController.text.isNotEmpty && (int.parse(state.investmentUpToController.text)<int.parse(state.investmentFromController.text))) {
                                    showCustomToast(context, "Investment UpTo must be greater than Investment From");
                                  } else if(state.roiUpToController.text.isNotEmpty && state.revenueFromController.text.isNotEmpty && (int.parse(state.roiUpToController.text)<int.parse(state.roiFromController.text))) {
                                    showCustomToast(context, "ROI UpTo must be greater than ROI From");
                                  } else if(state.loanAmountUpToController.text.isNotEmpty && state.loanAmountFromController.text.isNotEmpty && (int.parse(state.loanAmountUpToController.text)<int.parse(state.loanAmountFromController.text))) {
                                    showCustomToast(context, "Loan Amount UpTo must be greater than Loan Amount From");
                                  } else {
                                    BlocProvider.of<ProjectCubit>(context)
                                        .ddeProjectsApi(
                                        context, widget.selectedFilter, false);
                                    pressBack();
                                  }
                                }))

                        // ,10.verticalSpace(),
                      ],
                    ),
                  ),
                ),
              )
            ],
          );
        }
      ),
    );
  }
}
