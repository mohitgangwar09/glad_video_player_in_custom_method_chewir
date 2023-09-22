import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:glad/cubit/dde_enquiry_cubit/dde_enquiry_cubit.dart';
import 'package:glad/screen/custom_widget/custom_appbar.dart';
import 'package:glad/screen/custom_widget/custom_methods.dart';
import 'package:glad/screen/dde_screen/dde_farmer_filter.dart';
import 'package:glad/screen/dde_screen/enquiry_details.dart';
import 'package:glad/screen/dde_screen/project_widget.dart';
import 'package:glad/screen/farmer_screen/dashboard/dashboard_farmer.dart';
import 'package:glad/screen/farmer_screen/profile/farmer_profile.dart';
import 'package:glad/utils/color_resources.dart';
import 'package:glad/utils/extension.dart';
import 'package:glad/utils/helper.dart';
import 'package:glad/utils/images.dart';
import 'package:glad/utils/styles.dart';
import 'package:intl/intl.dart';

class EnquiryScreen extends StatelessWidget {
  const EnquiryScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    BlocProvider.of<DdeEnquiryCubit>(context).enquiryListApi(context,"Pending");

    return BlocBuilder<DdeEnquiryCubit,DdeEnquiryState>(
      builder: (context,state) {
        return Stack(
          children: [
            landingBackground(),
            Column(
              children: [
                CustomAppBar(
                  context: context,
                  titleText1: 'Enquiry',
                  titleText1Style:
                      figtreeMedium.copyWith(fontSize: 20, color: Colors.black),
                  centerTitle: true,
                  leading: openDrawer(
                      onTap: () {
                        farmerLandingKey.currentState?.openDrawer();
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
                                                    color: const Color(0xff6A0030),
                                                    fontSize: 14)),
                                            "Sort By".textMedium(fontSize: 22),
                                            TextButton(
                                                onPressed: () {},
                                                child: "Reset".textMedium(
                                                    color: const Color(0xff6A0030),
                                                    fontSize: 14))
                                          ],
                                        ),
                                      ),
                                      const Padding(
                                        padding:
                                            EdgeInsets.only(left: 20.0, right: 20),
                                        child: Divider(),
                                      ),
                                      Expanded(
                                        child: customList(
                                            list: [1, 2, 22, 2, 22, 2, 2, 22, 2],
                                            child: (index) {
                                              return Padding(
                                                  padding: const EdgeInsets.only(
                                                      left: 30,
                                                      right: 30,
                                                      top: 30,
                                                      bottom: 10),
                                                  child: "ROI Highest to Lowest"
                                                      .textRegular(fontSize: 16));
                                            }),
                                      ),
                                      10.verticalSpace(),
                                      Container(
                                          margin: 20.marginAll(),
                                          height: 55,
                                          width: screenWidth(),
                                          child: customButton("Apply",
                                              fontColor: 0xffffffff, onTap: () {}))
                                    ],
                                  ),
                                ));
                          },
                          child: SvgPicture.asset(Images.filter2)),
                      13.horizontalSpace(),
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
                Container(
                  height: 50,
                  margin: 20.marginHorizontal(),
                  width: screenWidth(),
                  decoration: boxDecoration(
                      borderRadius: 62,
                      borderColor: const Color(0xffDCDCDC),
                      backgroundColor: Colors.white),
                  child: Row(
                    children: [
                      Expanded(
                        child: InkWell(
                          onTap: (){
                            context.read<DdeEnquiryCubit>().filterStatus("Pending");
                            context.read<DdeEnquiryCubit>().enquiryListApi(context,'Pending');
                          },
                          child: Container(
                            height: screenHeight(),
                            margin: const EdgeInsets.all(6),
                            decoration: boxDecoration(
                                backgroundColor: state.enquiryStatus == "Pending"?ColorResources.maroon:Colors.white,
                                borderRadius: 62),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                "Pending".textMedium(
                                    color: state.enquiryStatus == "Pending"?ColorResources.white:Colors.black, fontSize: 14),
                                5.horizontalSpace(),
                                SvgPicture.asset(Images.pendingSelected,
                                color: state.enquiryStatus == "Pending"?Colors.white:ColorResources.maroon,)
                              ],
                            ),
                          ),
                        ),
                      ),
                      Expanded(
                        child: InkWell(
                          onTap: (){
                            context.read<DdeEnquiryCubit>().filterStatus("Closed");
                            context.read<DdeEnquiryCubit>().enquiryListApi(context,'Closed');
                          },
                          child: Container(
                            height: screenHeight(),
                            margin: const EdgeInsets.all(6),
                            decoration: boxDecoration(
                                backgroundColor: state.enquiryStatus == "Closed"?ColorResources.maroon:Colors.white, borderRadius: 62),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                "Closed"
                                    .textMedium(color: state.enquiryStatus == "Closed"?ColorResources.white:Colors.black, fontSize: 14),
                                5.horizontalSpace(),
                                SvgPicture.asset(Images.completed,
                                  color: state.enquiryStatus == "Closed"?Colors.white:null)
                              ],
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                Expanded(
                  child: SingleChildScrollView(
                    padding: const EdgeInsets.only(
                        bottom: 120, left: 20, right: 20, top: 20),
                    child: state.responseEnquiryModel!=null&&state.responseEnquiryModel!.data!=null&&state.responseEnquiryModel!.data!.isNotEmpty?customList(
                      list: state.responseEnquiryModel!.data!,
                        child: (index) => InkWell(
                          onTap: () {
                            if(state.responseEnquiryModel!.data![index].status.toString() == "pending"){
                              BlocProvider.of<DdeEnquiryCubit>(context).emit(state.copyWith(markAsClosed: ""));
                            }
                            EnquiryDetailsScreen(state.responseEnquiryModel!.data![index].id.toString()).navigate();
                          },
                          child: Stack(
                                alignment: Alignment.center,
                                children: [
                                  SizedBox(
                                      height: 150,
                                      width: MediaQuery.of(context).size.width * 0.8),
                                  Padding(
                                    padding:
                                        const EdgeInsets.only(bottom: 20, top: 20),
                                    child: Container(
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(20),
                                        border: Border.all(
                                            color:
                                                ColorResources.grey.withOpacity(0.5)),
                                        boxShadow: [
                                          BoxShadow(
                                              color: Colors.grey.withOpacity(0.5),
                                              blurRadius: 16.0,
                                              offset: const Offset(0, 1))
                                        ],
                                        color: Colors.white,
                                      ),
                                      padding: const EdgeInsets.all(15.0),
                                      child: Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          Text(state.responseEnquiryModel!.data![index].name.toString(),
                                              style: figtreeMedium.copyWith(
                                                  fontSize: 18, color: Colors.black)),
                                          10.verticalSpace(),
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              Text(state.responseEnquiryModel!.data![index].mobile.toString(),
                                                  style: figtreeRegular.copyWith(
                                                      fontSize: 14,
                                                      color: Colors.black)),
                                              Row(
                                                children: [
                                                  SvgPicture.asset(
                                                    Images.calender,
                                                    color: Colors.black,
                                                  ),
                                                  4.horizontalSpace(),
                                                  Text('${DateFormat('dd MMM, yyyy').format(DateTime.parse(state.responseEnquiryModel!.data![index].createdAt.toString()))}${state.responseEnquiryModel!.data![index].closedAt!=null?"-":""}${state.responseEnquiryModel!.data![index].closedAt!=null?DateFormat('dd MMM, yyyy').format(DateTime.parse(state.responseEnquiryModel!.data![index].closedAt.toString())):""}',
                                                      style: figtreeRegular.copyWith(
                                                          fontSize: 14,
                                                          color: Colors.black)),
                                                ],
                                              ),
                                            ],
                                          ),
                                          10.verticalSpace(),
                                          SizedBox(
                                            width: MediaQuery.of(context).size.width *
                                                0.7,
                                            child: Text(
                                              state.responseEnquiryModel!.data![index].comment.toString(),
                                              style: figtreeRegular.copyWith(
                                                  fontSize: 14, color: Colors.black),
                                              maxLines: 1,
                                              overflow: TextOverflow.ellipsis,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                  Positioned(
                                      top: 0,
                                      right: 10,
                                      child: Row(
                                        children: [
                                          InkWell(
                                              onTap: () async {
                                                await callOnMobile(state.responseEnquiryModel!.data![index].mobile.toString());
                                              },
                                              child: SvgPicture.asset(
                                                  Images.callPrimary)),
                                          6.horizontalSpace(),
                                          InkWell(
                                              onTap: () async {
                                                await launchWhatsApp(state.responseEnquiryModel!.data![index].mobile.toString());
                                              },
                                              child:
                                                  SvgPicture.asset(Images.whatsapp)),
                                          6.horizontalSpace(),
                                          InkWell(
                                              onTap: () async {},
                                              child:
                                              SvgPicture.asset(Images.redirectLocation)),
                                          16.horizontalSpace(),
                                        ],
                                      )),
                                ],
                              ),
                        )):Center(child: errorText('No enquiry found')),
                  ),
                )
              ],
            ),
          ],
        );
      }
    );
  }
}
