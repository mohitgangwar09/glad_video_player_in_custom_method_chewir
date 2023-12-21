import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:glad/cubit/dde_farmer_cubit/dde_farmer_cubit.dart';
import 'package:glad/cubit/livestock_cubit/livestock_cubit.dart';
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

import 'loan_application_detail.dart';

class LoanApplication extends StatefulWidget {
  const LoanApplication({Key? key}) : super(key: key);

  @override
  State<LoanApplication> createState() => _LoanApplicationState();
}

class _LoanApplicationState extends State<LoanApplication> {
  bool search = false;
  TextEditingController searchEditingController = TextEditingController();

  @override
  void initState() {
    BlocProvider.of<LivestockCubit>(context)
        .loanListApi(context);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    BlocProvider.of<DdeFarmerCubit>(context).selectRagRating('');

    return Scaffold(
      body: BlocBuilder<LivestockCubit, LivestockCubitState>(builder: (context, state) {
        if (state.status == LivestockStatus.submit) {
          return const Center(
              child: CircularProgressIndicator(
                color: ColorResources.maroon,
              ));
        } else if (state.responseLoanApplicationList == null) {
          return Center(child: Text("${state.responseLoanApplicationList} Api Error"));
        } else {
          return Stack(
            children: [
              landingBackground(),
              Column(
                children: [
                  CustomAppBar(
                    context: context,
                    titleText1: 'Loan Application',
                    titleText1Style:
                    figtreeMedium.copyWith(fontSize: 20, color: Colors.black),
                    centerTitle: true,
                    leading: arrowBackButton(),
                  ),
                  10.verticalSpace(),
                  state.responseLoanApplicationList!.data!.isNotEmpty
                      ? Expanded(
                    child: SingleChildScrollView(
                      padding: const EdgeInsets.only(bottom: 120, left: 10),
                      child: customList(
                          list: List.generate(state.responseLoanApplicationList!.data!
                              .length, (index) => null),
                          child: (int index) {

                            return Padding(
                              padding: const EdgeInsets.only(right: 20.0),
                              child: customProjectContainer(
                                  child: Padding(
                                    padding: const EdgeInsets.all(15.0),
                                    child: InkWell(
                                      onTap: () {
                                        LoanApplicationDetail(projectId:state.responseLoanApplicationList!.data![index].id).navigate();
                                      },
                                      child: Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [

                                          Padding(
                                            padding: const EdgeInsets.only(right: 15),
                                            child: Row(
                                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                              children: [
                                                Container(
                                                  height: 70,
                                                  width: MediaQuery.of(context).size.width * 0.6,
                                                  padding: 15.paddingHorizontal(),
                                                  child: Row(
                                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                    children: [
                                                      networkImage(text: state.responseLoanApplicationList!.data![index].liveStockCart!.seller!.profilePic.toString(),height: 46,width: 46,radius: 40),
                                                      10.horizontalSpace(),
                                                      Expanded(
                                                        child: Column(
                                                          mainAxisAlignment: MainAxisAlignment.center,
                                                          crossAxisAlignment: CrossAxisAlignment.start,
                                                          children: [
                                                            state.responseLoanApplicationList!.data![index].liveStockCart!.seller!.name!.toString().textMedium(
                                                                color: Colors.black,
                                                                fontSize: 14,
                                                                maxLines: 1,
                                                                overflow: TextOverflow.ellipsis),
                                                            1.verticalSpace(),
                                                            state.responseLoanApplicationList!.data![index].liveStockCart!.seller!.mobile!.toString().textRegular(
                                                                fontSize: 12, color: Colors.black),
                                                            4.verticalSpace(),
                                                            state.responseLoanApplicationList!.data![index].liveStockCart!.seller!.farmerMaster!.address!.address!.textRegular(
                                                                fontSize: 12,
                                                                color: Colors.black,
                                                                maxLines: 1,
                                                                overflow: TextOverflow.ellipsis),
                                                          ],
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                          20.verticalSpace(),
                                          Container(
                                            height: 60,
                                            padding: 20.paddingHorizontal(),
                                            decoration: boxDecoration(
                                                backgroundColor: const Color(0xffFFF3F4),
                                                borderRadius: 10),
                                            child: Row(
                                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                              children: [
                                                Column(
                                                  mainAxisAlignment: MainAxisAlignment.center,
                                                  crossAxisAlignment: CrossAxisAlignment.start,
                                                  children: [
                                                    getCurrencyString(state.responseLoanApplicationList!.data![index].investmentAmount)
                                                        .textSemiBold(color: Colors.black, fontSize: 16),
                                                    "Investment".textMedium(
                                                        fontSize: 12, color: const Color(0xFF808080)),
                                                  ],
                                                ),
                                                Column(
                                                  mainAxisAlignment: MainAxisAlignment.center,
                                                  crossAxisAlignment: CrossAxisAlignment.start,
                                                  children: [
                                                    getCurrencyString(state.responseLoanApplicationList!.data![index].revenuePerMonth)
                                                        .textSemiBold(color: Colors.black, fontSize: 16),
                                                    "Revenue".textMedium(
                                                        fontSize: 12, color: const Color(0xFF808080)),
                                                  ],
                                                ),
                                                Column(
                                                  mainAxisAlignment: MainAxisAlignment.center,
                                                  crossAxisAlignment: CrossAxisAlignment.start,
                                                  children: [
                                                    "${double.parse(state.responseLoanApplicationList!.data![index].roiPerYear.toString().toString()).toStringAsFixed(2)}%".textSemiBold(color: Colors.black, fontSize: 16),
                                                    "ROI".textMedium(
                                                        fontSize: 12, color: const Color(0xFF808080)),
                                                  ],
                                                ),
                                              ],
                                            ),
                                          ),
                                          20.verticalSpace(),
                                          Row(
                                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                            children: [
                                              RichText(
                                                  text: TextSpan(children: [
                                                    TextSpan(
                                                        text: 'Loan: ',
                                                        style: figtreeMedium.copyWith(
                                                            fontSize: 12, color: const Color(0xFF808080))),
                                                    TextSpan(
                                                        text: getCurrencyString(state.responseLoanApplicationList!.data![index].loanAmount),
                                                        style: figtreeMedium.copyWith(
                                                            fontSize: 12, color: Colors.black))
                                                  ])),
                                              RichText(
                                                  text: TextSpan(children: [
                                                    TextSpan(
                                                        text: 'Buyer Participation: ',
                                                        style: figtreeMedium.copyWith(
                                                            fontSize: 12, color: const Color(0xFF808080))),
                                                    TextSpan(
                                                        text: getCurrencyString(state.responseLoanApplicationList!.data![index].farmerParticipation),
                                                        style: figtreeMedium.copyWith(
                                                            fontSize: 12, color: Colors.black))
                                                  ])),

                                            ],
                                          ),
                                          15.verticalSpace(),
                                        ],
                                      ),
                                    ),
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
      }),
    );
  }
}
