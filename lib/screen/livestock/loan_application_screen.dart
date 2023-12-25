import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:glad/cubit/dde_farmer_cubit/dde_farmer_cubit.dart';
import 'package:glad/cubit/livestock_cubit/livestock_cubit.dart';
import 'package:glad/cubit/project_cubit/project_cubit.dart';
import 'package:glad/data/model/response_loan_application_list.dart';
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
  const LoanApplication({super.key, required this.type});
  final String type;

  @override
  State<LoanApplication> createState() => _LoanApplicationState();
}

class _LoanApplicationState extends State<LoanApplication> {
  bool search = false;
  TextEditingController searchEditingController = TextEditingController();

  @override
  void initState() {
    BlocProvider.of<LivestockCubit>(context)
        .loanListApi(context,widget.type);
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
        }else {
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
                  state.responseLoanApplicationList!.data!=null
                      ? Expanded(
                    child: SingleChildScrollView(
                      padding: const EdgeInsets.only(bottom: 120, left: 10),
                      child: customList(
                          list: List.generate(state.responseLoanApplicationList!.data!
                              .length, (index) => null),
                          child: (int index) {

                            return Stack(
                              children: [

                                Padding(
                                  padding: const EdgeInsets.only(right: 20.0),
                                  child: customProjectContainer(
                                      child: Padding(
                                        padding: const EdgeInsets.all(15.0),
                                        child: InkWell(
                                          onTap: () {
                                            LoanApplicationDetail(projectId:state.responseLoanApplicationList!.data![index].id,type: widget.type,).navigate();
                                          },
                                          child: Column(
                                            crossAxisAlignment: CrossAxisAlignment.start,
                                            children: [

                                              widget.type.toString() == "buyer"?
                                                  sellerCard(state.responseLoanApplicationList!.data![index]):buyerCard(state.responseLoanApplicationList!.data![index]),

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
                                                            text: getCurrencyString(state.responseLoanApplicationList!.data![index].investmentAmount-state.responseLoanApplicationList!.data![index].farmerParticipation),
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
                                ),

                                Positioned(
                                  top: 30,
                                  right: 25,
                                  bottom: 0,
                                  child: Align(
                                    alignment: Alignment.topRight,
                                    child: Container(
                                      margin: 10.marginAll(),
                                      padding: const EdgeInsets.symmetric(vertical: 4, horizontal: 7),
                                      decoration: boxDecoration(
                                        borderRadius: 30,
                                        borderColor: const Color(0xff6A0030),
                                      ),
                                      child: Text(
                                        state.responseLoanApplicationList!.data![index].rejectStatus! == 0 ? state.responseLoanApplicationList!.data![index].projectStatus!.capitalizeFirst.toString():"Rejected",
                                        textAlign: TextAlign.center,
                                        style: figtreeMedium.copyWith(
                                            color: const Color(0xff6A0030), fontSize: 10),
                                      ),
                                    ),
                                  ),
                                ),

                              ],
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

  Widget sellerCard(DataLoanApplication sellerData){
    return Padding(
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
                networkImage(text: sellerData.liveStockCart!.seller!.profilePic.toString(),height: 46,width: 46,radius: 40),
                10.horizontalSpace(),
                Expanded(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      sellerData.liveStockCart!.seller!.name!.toString().textMedium(
                          color: Colors.black,
                          fontSize: 14,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis),
                      1.verticalSpace(),
                      sellerData.liveStockCart!.seller!.mobile!.toString().textRegular(
                          fontSize: 12, color: Colors.black),
                      4.verticalSpace(),
                      sellerData.liveStockCart!.seller!.farmerMaster!.address!.address!.textRegular(
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
    );
  }

  Widget buyerCard(DataLoanApplication buyerData){
    return Padding(
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
                networkImage(text: buyerData.liveStockCart!.user!.profilePic.toString(),height: 46,width: 46,radius: 40),
                10.horizontalSpace(),
                Expanded(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      buyerData.liveStockCart!.user!.name!.toString().textMedium(
                          color: Colors.black,
                          fontSize: 14,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis),
                      1.verticalSpace(),
                      buyerData.liveStockCart!.user!.mobile!.toString().textRegular(
                          fontSize: 12, color: Colors.black),
                      4.verticalSpace(),
                      buyerData.liveStockCart!.user!.farmerMaster!.address!.address!.textRegular(
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
    );
  }

}
