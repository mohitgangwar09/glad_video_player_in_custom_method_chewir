
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart' as g;
import 'package:glad/cubit/auth_cubit/auth_cubit.dart';
import 'package:glad/cubit/dde_farmer_cubit/dde_farmer_cubit.dart';
import 'package:glad/cubit/landing_page_cubit/landing_page_cubit.dart';
import 'package:glad/cubit/profile_cubit/profile_cubit.dart';
import 'package:glad/cubit/project_cubit/project_cubit.dart';
import 'package:glad/screen/custom_loan/apply_custom_loan.dart';
import 'package:glad/screen/custom_loan/custom_loan_detail.dart';
import 'package:glad/screen/custom_loan/custom_loan_farmer_detail.dart';
import 'package:glad/screen/custom_widget/custom_appbar.dart';
import 'package:glad/screen/custom_widget/custom_methods.dart';
import 'package:glad/screen/dde_screen/dde_farmer_detail.dart';
import 'package:glad/screen/farmer_screen/dashboard/dashboard_farmer.dart';
import 'package:glad/utils/app_constants.dart';
import 'package:glad/utils/color_resources.dart';
import 'package:glad/utils/extension.dart';
import 'package:glad/utils/images.dart';
import 'package:glad/utils/styles.dart';

class CustomLoanList extends StatefulWidget {
  const CustomLoanList({Key? key,this.navigateFrom}) : super(key: key);
  final String? navigateFrom;

  @override
  State<CustomLoanList> createState() => _CustomLoanListState();
}

class _CustomLoanListState extends State<CustomLoanList> {

  @override
  void initState() {
    BlocProvider.of<ProjectCubit>(context).customLoanListApi(context, '');
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocBuilder<ProjectCubit,ProjectState>(
          builder: (context,state) {
      if (state.status == ProjectStatus.loading) {
        return const SizedBox(
          height: 350,
          child: Center(
              child: CircularProgressIndicator(
                color: ColorResources.maroon,
              )),
        );
      } else if (state.responseCustomLoanList == null) {
        return Center(child: Text("${state.responseCustomLoanList} Api Error"));
      } else {
        return Stack(
          children: [
            landingBackground(),
            Column(
              children: [
                CustomAppBar(
                  context: context,
                  titleText1: 'Custom Loan',
                  titleText1Style:
                  figtreeMedium.copyWith(fontSize: 20, color: Colors.black),
                  centerTitle: true,
                  leading: arrowBackButton(
                    onTap: (){
                      if(widget.navigateFrom !=null){
                        const DashboardFarmer().navigate(isInfinity: true, transition: g.Transition.leftToRight);
                      }else{
                        pressBack();
                      }
                    }
                  ),
                ),
                Expanded(
                  child: SingleChildScrollView(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 20),
                    child: Column(children: [
                      state.responseCustomLoanList!.data != null ? customList(
                          list: List.generate(state.responseCustomLoanList!.data!.length, (index) => ''),
                          child: (int index) {
                            return customProjectContainer(
                                child: Stack(
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.all(15.0),
                                      child: InkWell(
                                        onTap: () {
                                          if(BlocProvider.of<AuthCubit>(context).sharedPreferences.getString(AppConstants.userType) == "dde"){
                                            CustomLoanDetail(projectId: state.responseCustomLoanList!.data![index].id,).navigate();
                                          }else{
                                            CustomLoanFarmerDetail(projectId: state.responseCustomLoanList!.data![index].id,).navigate();
                                            // CustomLoanFarmerDetail
                                          }
                                        },
                                        child: Column(
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: [
                                            Row(
                                              children: [
                                                CircleAvatar(
                                                    radius: 30,
                                                    child: CachedNetworkImage(
                                                      imageUrl: state.responseCustomLoanList!.data![index].improvementArea!.image ?? '',
                                                      errorWidget: (_, __, ___) {
                                                        return Image.asset(
                                                          Images.sampleUser,
                                                          fit: BoxFit.cover,
                                                          width: 80,
                                                          height: 80,
                                                        );
                                                      },
                                                      fit: BoxFit.cover,
                                                      width: 80,
                                                      height: 80,
                                                    )),
                                                12.horizontalSpace(),
                                                Expanded(
                                                  child: Column(
                                                    crossAxisAlignment: CrossAxisAlignment.start,
                                                    children: [
                                                      state.responseCustomLoanList!.data![index].name.toString().textMedium(
                                                          fontSize: 18,
                                                          maxLines: 1,
                                                          overflow: TextOverflow.ellipsis),
                                                      5.verticalSpace(),
                                                      state.responseCustomLoanList!.data![index].improvementArea!.name.toString().textMedium(
                                                        fontSize: 12,
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                              ],
                                            ),

                                            15.verticalSpace(),

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
                                                      getCurrencyString(state.responseCustomLoanList!.data![index].investmentAmount)
                                                          .textSemiBold(color: Colors.black, fontSize: 16),
                                                      3.verticalSpace(),
                                                      "Loan Amount"
                                                          .textRegular(fontSize: 12, color: Colors.black),
                                                    ],
                                                  ),
                                                  SizedBox(
                                                    height: 45,
                                                    child: customPaint(Colors.grey),
                                                  ),
                                                  Column(
                                                    mainAxisAlignment: MainAxisAlignment.center,
                                                    crossAxisAlignment: CrossAxisAlignment.start,
                                                    children: [
                                                      getCurrencyString(state.responseCustomLoanList!.data![index].emiAmount)
                                                          .textSemiBold(color: Colors.black, fontSize: 16),
                                                      3.verticalSpace(),
                                                      "EMI/ month"
                                                          .textRegular(fontSize: 12, color: Colors.black)
                                                    ],
                                                  ),
                                                ],
                                              ),
                                            ),

                                            10.verticalSpace(),

                                            Container(
                                              margin: 4.marginTop(),
                                              padding: 20.paddingHorizontal(),
                                              decoration: boxDecoration(borderRadius: 10),
                                              child: Row(
                                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                children: [
                                                  Column(
                                                    mainAxisAlignment: MainAxisAlignment.center,
                                                    crossAxisAlignment: CrossAxisAlignment.start,
                                                    children: [
                                                      state.responseCustomLoanList!.data![index].repaymentMonths.toString()
                                                          .textSemiBold(color: Colors.black, fontSize: 16),
                                                      "Total EMI's".textMedium(fontSize: 12),
                                                    ],
                                                  ),
                                                  Column(
                                                    mainAxisAlignment: MainAxisAlignment.center,
                                                    crossAxisAlignment: CrossAxisAlignment.start,
                                                    children: [
                                                      state.responseCustomLoanList!.data![index].paidEmi.toString()
                                                          .textSemiBold(color: Colors.black, fontSize: 16),
                                                      "Paid EMI"
                                                          .textMedium(fontSize: 12, color: Colors.black),
                                                    ],
                                                  ),
                                                  Column(
                                                    mainAxisAlignment: MainAxisAlignment.center,
                                                    crossAxisAlignment: CrossAxisAlignment.start,
                                                    children: [
                                                      (state.responseCustomLoanList!.data![index].repaymentMonths - state.responseCustomLoanList!.data![index].paidEmi).toString()
                                                          .textSemiBold(color: Colors.black, fontSize: 16),
                                                      "Remaining EMI".textMedium(
                                                        fontSize: 12,
                                                      ),
                                                    ],
                                                  ),
                                                ],
                                              ),
                                            ),
                                            if(context.read<ProjectCubit>().sharedPreferences.getString(AppConstants.userType) == 'dde')
                                            Column(children: [
                                              15.verticalSpace(),
                                              Padding(
                                                padding: const EdgeInsets.only(right: 15),
                                                child: Row(
                                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                  children: [
                                                    InkWell(
                                                      onTap: () {
                                                        BlocProvider.of<LandingPageCubit>(context).getCurrentLocation();
                                                        BlocProvider.of<ProfileCubit>(context).emit(ProfileCubitState.initial());
                                                        DdeFarmerDetail(userId: state.responseCustomLoanList!.data![index].farmerMaster!.userId,farmerId:state.responseCustomLoanList!.data![index].id!).navigate();
                                                      },
                                                      child: Container(
                                                        height: 70,
                                                        width: MediaQuery.of(context).size.width * 0.6,
                                                        padding: 15.paddingHorizontal(),
                                                        child: Row(
                                                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                          children: [
                                                            networkImage(text: state.responseCustomLoanList!.data![index].farmerMaster!.photo ?? '',height: 46,width: 46,radius: 40),
                                                            10.horizontalSpace(),
                                                            Expanded(
                                                              child: Column(
                                                                mainAxisAlignment: MainAxisAlignment.center,
                                                                crossAxisAlignment: CrossAxisAlignment.start,
                                                                children: [
                                                                  state.responseCustomLoanList!.data![index].farmerMaster!.name.toString().textMedium(
                                                                      color: Colors.black,
                                                                      fontSize: 14,
                                                                      maxLines: 1,
                                                                      overflow: TextOverflow.ellipsis),
                                                                  1.verticalSpace(),
                                                                  (state.responseCustomLoanList!.data![index].farmerMaster!.phone ?? '').textRegular(
                                                                      fontSize: 12, color: Colors.black),
                                                                  4.verticalSpace(),
                                                                  (state.responseCustomLoanList!.data![index].farmerMaster!.address != null ? state.responseCustomLoanList!.data![index].farmerMaster!.address!.address ?? '' : '').textRegular(
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
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            ],)

                                            // 30.verticalSpace()
                                          ],
                                        ),
                                      ),
                                    ),
                                    Align(
                                      alignment: Alignment.topRight,
                                      child: Container(
                                        margin: 10.marginAll(),
                                        padding: const EdgeInsets.symmetric(vertical: 4, horizontal: 7),
                                        decoration: boxDecoration(
                                          borderRadius: 30,
                                          borderColor: const Color(0xff6A0030),
                                        ),
                                        child: Text(
                                          formatProjectStatus(state.responseCustomLoanList!.data![index].projectStatus.toString()).toString(),
                                          textAlign: TextAlign.center,
                                          style: figtreeMedium.copyWith(
                                              color: const Color(0xff6A0030), fontSize: 10),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                                width: screenWidth());
                          }) :
                      const SizedBox.shrink(),
                      Container(
                          margin: 20.marginAll(),
                          height: 55,
                          width: screenWidth(),
                          child: customButton("Apply New Loan",
                              fontColor: 0xffffffff,
                              onTap: () async{
                                if(context.read<ProjectCubit>().sharedPreferences.getString(AppConstants.userType) == 'dde') {
                                  await BlocProvider.of<DdeFarmerCubit>(context).getFarmer(context, '${BlocProvider.of<DdeFarmerCubit>(context).state.selectedRagRatingType}'.toLowerCase(), true);
                                  modalBottomSheetMenu(context,
                                      radius: 40,
                                      child: SizedBox(
                                          height: screenHeight()-220,
                                          child: selectFarmerAddDdeLivestock(isCustomLoan: true)));
                                } else {
                                  const ApplyCustomLoan().navigate();
                                }
                              }))
                    ],),
                  ),
                )
              ],
            ),
          ],
        );
      }
          }
      ),
    );
  }
}
