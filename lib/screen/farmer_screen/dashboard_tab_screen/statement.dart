import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:glad/cubit/project_cubit/project_cubit.dart';
import 'package:glad/screen/custom_widget/custom_appbar.dart';
import 'package:glad/screen/custom_widget/custom_methods.dart';
import 'package:glad/screen/farmer_screen/dashboard/dashboard_farmer.dart';
import 'package:glad/utils/color_resources.dart';
import 'package:glad/utils/extension.dart';
import 'package:glad/utils/images.dart';
import 'package:glad/utils/styles.dart';

class FarmerStatement extends StatefulWidget {
  const FarmerStatement({super.key});

  @override
  State<FarmerStatement> createState() => _FarmerStatementState();
}

class _FarmerStatementState extends State<FarmerStatement> {

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      BlocProvider.of<ProjectCubit>(context).statusColor('');
      BlocProvider.of<ProjectCubit>(context).accountStatementApi(context, '');
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocBuilder<ProjectCubit,ProjectState>(
        builder: (context,state) {
          return LayoutBuilder(
            builder: (context, constraints) {
              bool smallDevice = constraints.maxWidth < 350;
              return Stack(
                  children: [
                    landingBackground(),
                    Column(
                      children: [
                        CustomAppBar(
                          context: context,
                          titleText1: 'Statement',
                          titleText1Style: figtreeMedium.copyWith(
                              fontSize: 20, color: Colors.black),
                          centerTitle: true,
                          leading: openDrawer(
                              onTap: () {
                                farmerLandingKey.currentState?.openDrawer();
                              }, child: SvgPicture.asset(Images.drawer)),
                          /*action: InkWell(
                              onTap: () {},
                              child: SvgPicture.asset(Images.filter2)),*/
                        ),
                        MediaQuery(
                          data: screenWidth()<380 ? MediaQuery.of(context).copyWith(textScaleFactor: 0.87):MediaQuery.of(context).copyWith(textScaleFactor: 0.95),
                          child: Padding(
                            padding: const EdgeInsets.only(left: 1.0,right: 1),
                            child: Container(
                              padding: const EdgeInsets.symmetric(horizontal: 10),
                              child: Row(
                                children: [
                                  10.horizontalSpace(),
                                  Expanded(
                                    child: InkWell(
                                      onTap: (){
                                        BlocProvider.of<ProjectCubit>(context).statusColor('paid');
                                        BlocProvider.of<ProjectCubit>(context).accountStatementApi(context, 'paid');
                                      },
                                      child: Container(
                                        padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 10),
                                        decoration: BoxDecoration(
                                            color: Colors.white,
                                            border: Border.all(
                                                width: state.statusLoan == 'paid'?2:1, color: state.statusLoan == 'paid'?ColorResources.paidGreen:const Color(0xffDCDCDC)),
                                            borderRadius: BorderRadius.circular(15)),
                                        child: Column(
                                            crossAxisAlignment: CrossAxisAlignment.center,
                                            mainAxisAlignment: MainAxisAlignment.center,
                                            children: [
                                              BlocBuilder<ProjectCubit,ProjectState>(
                                                  builder: (context,state) {
                                                    return Text(
                                                      getCurrencyString(state.paidAmount??0),
                                                      textAlign: TextAlign.center,
                                                      style: figtreeSemiBold.copyWith(fontSize: smallDevice ? 13 : 14),
                                                    );
                                                  }
                                              ),
                                              05.verticalSpace(),
                                              Text(
                                                'Paid',
                                                style: figtreeMedium.copyWith(
                                                    fontSize: smallDevice ? 11 : 12, color: ColorResources.fieldGrey),
                                              )
                                            ]),
                                      ),
                                    ),
                                  ),
                                  10.horizontalSpace(),
                                  Expanded(
                                    child: InkWell(
                                      onTap: (){
                                        BlocProvider.of<ProjectCubit>(context).statusColor('due');
                                        BlocProvider.of<ProjectCubit>(context).accountStatementApi(context, 'due');
                                      },
                                      child: Container(
                                        padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 10),
                                        decoration: BoxDecoration(
                                            color: Colors.white,
                                            border: Border.all(
                                                width: state.statusLoan == 'due'?1:1, color: state.statusLoan == 'due'?const Color(0xffF6B51D):const Color(0xffDCDCDC)),
                                            borderRadius: BorderRadius.circular(20)),
                                        child: Column(
                                            crossAxisAlignment: CrossAxisAlignment.center,
                                            mainAxisAlignment: MainAxisAlignment.center,
                                            children: [
                                              BlocBuilder<ProjectCubit,ProjectState>(
                                                  builder: (context,state) {
                                                    return Text(
                                                      getCurrencyString(state.dueAmount??0),
                                                      textAlign: TextAlign.center,
                                                      style: figtreeSemiBold.copyWith(fontSize: smallDevice ? 13 : 14),
                                                    );
                                                  }
                                              ),
                                              05.verticalSpace(),
                                              Text(
                                                'Due',
                                                style: figtreeMedium.copyWith(
                                                    fontSize: smallDevice ? 11 : 12, color: ColorResources.fieldGrey),
                                              )
                                            ]),
                                      ),
                                    ),
                                  ),
                                  10.horizontalSpace(),
                                  Expanded(
                                    child: InkWell(
                                      onTap: (){
                                        BlocProvider.of<ProjectCubit>(context).statusColor('pending');
                                        BlocProvider.of<ProjectCubit>(context).accountStatementApi(context, 'pending');
                                      },
                                      child: Container(
                                        padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 10),
                                        decoration: BoxDecoration(
                                            color: Colors.white,
                                            border: Border.all(
                                                width: state.statusLoan == 'pending'?1:1, color: state.statusLoan == 'pending'?const Color(0xff6A0030):const Color(0xffDCDCDC)),
                                            borderRadius: BorderRadius.circular(20)),
                                        child: Column(
                                            crossAxisAlignment: CrossAxisAlignment.center,
                                            mainAxisAlignment: MainAxisAlignment.center,
                                            children: [
                                              BlocBuilder<ProjectCubit,ProjectState>(
                                                  builder: (context,state) {
                                                    return Text(
                                                      getCurrencyString(state.pendingAmount??0),
                                                      textAlign: TextAlign.center,
                                                      style: figtreeSemiBold.copyWith(fontSize: smallDevice ? 13 : 14),
                                                    );
                                                  }
                                              ),
                                              05.verticalSpace(),
                                              Text(
                                                'Pending',
                                                style: figtreeMedium.copyWith(
                                                    fontSize: smallDevice ? 11 : 12, color: ColorResources.fieldGrey),
                                              )
                                            ]),
                                      ),
                                    ),
                                  ),
                                  10.horizontalSpace(),
                                ],
                              ),
                            ),
                          ),
                        ),
                        20.verticalSpace(),
                        listviewDetails(state),
                      ],
                    ),
                  ],
                );
            }
          );
        }
      ),
    );
  }

  Widget listviewDetails(ProjectState state) {
    return BlocBuilder<ProjectCubit,ProjectState>(
      builder: (context,state) {
        if (state.status == ProjectStatus.loading) {
          return const Center(
              child: CircularProgressIndicator(
                color: ColorResources.maroon,
              ));
        } else if (state.responseAccountStatement == null) {
          return const Center(child: Text("Please check your internet connection"));
        } else {
          return Expanded(
            child: SingleChildScrollView(
              child: LayoutBuilder(
                builder: (context, constraints) {
                  bool smallDevice = constraints.maxWidth < 350;
                  return Padding(
                    padding: const EdgeInsets.fromLTRB(18, 0, 18, 120),
                    child: Container(
                      padding: const EdgeInsets.all(25),
                      decoration: BoxDecoration(
                          color: Colors.white,
                          border: Border.all(color: const Color(0xffDCDCDC)),
                          borderRadius: BorderRadius.circular(20)),
                      child: state.responseAccountStatement!.data!.farmerProjectFinancial!.isNotEmpty
                          ? ListView.separated(
                              shrinkWrap: true,
                              itemCount: state.responseAccountStatement!.data!.farmerProjectFinancial!.length,
                              controller: ScrollController(),
                              padding: EdgeInsets.zero,
                              itemBuilder: (context, index) => Column(
                                  crossAxisAlignment:
                                  CrossAxisAlignment.start,
                                  children: [
                                    Row(
                                      mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                      children: [
                                        state.responseAccountStatement!.data!.farmerProjectFinancial![index].farmerProject!=null?
                                        state.responseAccountStatement!.data!.farmerProjectFinancial![index].farmerProject!.name.toString().textSemiBold(
                                            fontSize: 18,
                                            color: ColorResources.black):const SizedBox.shrink(),

                                        Expanded(
                                          child: Column(
                                            crossAxisAlignment: CrossAxisAlignment.end,
                                            children: [
                                              state.responseAccountStatement!.data!.farmerProjectFinancial![index].dueDate.toString().textMedium(
                                                  fontSize: 14,
                                                  color: ColorResources.black),

                                              state.responseAccountStatement!.data!.farmerProjectFinancial![index].paymentStatus.toString().textMedium(
                                                color: state.responseAccountStatement!.data!.farmerProjectFinancial![index].paymentStatus == 'pending'?const Color(0xff6A0030):
                                                state.responseAccountStatement!.data!.farmerProjectFinancial![index].paymentStatus == 'paid'?const Color(0xff12CE57):const Color(0xff6A0030)
                                              )

                                            ],
                                          ),
                                        )
                                      ],
                                    ),
                                    15.verticalSpace(),
                                    Row(
                                      mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                      children: [
                                        Expanded(
                                          child: Row(
                                            children: [
                                              ClipRRect(
                                                borderRadius: BorderRadius.circular(1000),
                                                child: Container(
                                                  height: AppBar().preferredSize.height * 0.7,
                                                  width: AppBar().preferredSize.height * 0.7,
                                                  decoration:
                                                  const BoxDecoration(shape: BoxShape.circle),
                                                  child: state.responseAccountStatement!.data!.farmerProjectFinancial![index].farmerMaster!.photo!=null?CachedNetworkImage(
                                                    imageUrl:
                                                    state.responseAccountStatement!.data!.farmerProjectFinancial![index].farmerMaster!.photo!.toString(),
                                                    errorWidget: (_, __, ___) =>
                                                        SvgPicture.asset(Images.person),
                                                    fit: BoxFit.cover,
                                                  ):SvgPicture.asset(Images.person),
                                                ),
                                              ),
                                              10.horizontalSpace(),
                                              Expanded(
                                                child: Column(
                                                  crossAxisAlignment:
                                                  CrossAxisAlignment
                                                      .start,
                                                  children: [
                                                    state.responseAccountStatement!.data!.farmerProjectFinancial![index].farmerMaster!.name.toString()
                                                        .textMedium(
                                                        fontSize: 14,
                                                        color:
                                                        ColorResources
                                                            .black),
                                                    SizedBox(
                                                      width: screenWidth() * 0.4,
                                                      child: state.responseAccountStatement!.data!.farmerProjectFinancial![index].farmerMaster!.address!.address.toString()
                                                          .textMedium(
                                                          fontSize: 14,
                                                          maxLines: 2,
                                                          overflow: TextOverflow.ellipsis,
                                                          color:
                                                          ColorResources
                                                              .black),
                                                    )
                                                  ],
                                                ),
                                              )
                                            ],
                                          ),
                                        ),
                                        Container(
                                          padding: const EdgeInsets.all(10),
                                          decoration: boxDecoration(
                                              backgroundColor:
                                              const Color(0xFFFFF3F4),
                                              borderColor:
                                              const Color(0xffF6B51D),
                                              borderRadius: 40,
                                              borderWidth: 1),
                                          child: getCurrencyString(state.responseAccountStatement!.data!.farmerProjectFinancial![index].payableAmount+state.responseAccountStatement!.data!.farmerProjectFinancial![index].receivableAmount).toString().textBold(
                                              fontSize: smallDevice ? 16 : 18,
                                              color:
                                              ColorResources.black),
                                        )
                                      ],
                                    ),
                                  ]),
                              separatorBuilder: (context, index) =>
                              const Padding(
                                padding:
                                EdgeInsets.symmetric(vertical: 10.0),
                                child: Divider(),
                              ),
                            )
                          : SizedBox(width: screenWidth(),height: 300,
                              child: const Center(child: Text("No data found")),),
                    ),
                  );
                }
              ),
            ),
          );
        }
      }
    );
  }
}
