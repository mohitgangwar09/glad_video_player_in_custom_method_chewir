
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:glad/cubit/dde_enquiry_cubit/dde_enquiry_cubit.dart';
import 'package:glad/cubit/dde_farmer_cubit/dde_farmer_cubit.dart';
import 'package:glad/cubit/profile_cubit/profile_cubit.dart';
import 'package:glad/screen/custom_widget/custom_appbar.dart';
import 'package:glad/screen/custom_widget/custom_methods.dart';
import 'package:glad/screen/dde_screen/dashboard/dashboard_dde.dart';
import 'package:glad/screen/dde_screen/enquiry_details.dart';
import 'package:glad/utils/color_resources.dart';
import 'package:glad/utils/extension.dart';
import 'package:glad/utils/images.dart';
import 'package:glad/utils/styles.dart';
import 'package:intl/intl.dart';

class EnquiryScreen extends StatelessWidget {
  const EnquiryScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    BlocProvider.of<DdeFarmerCubit>(context).selectRagRating('');
    BlocProvider.of<DdeEnquiryCubit>(context).enquiryListApi(context,"Pending");

    String countryCode = "";

    void getCountryCode() async{
     String countryCodes = await BlocProvider.of<ProfileCubit>(context).getCountryCode();
     countryCode = countryCodes;
    }

    return BlocBuilder<DdeEnquiryCubit,DdeEnquiryState>(
      builder: (context,state) {

        getCountryCode();

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
                        ddeLandingKey.currentState?.openDrawer();
                      },
                      child: SvgPicture.asset(Images.drawer)),
                  /*action: Row(
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
                  ),*/
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
                                SvgPicture.asset(state.enquiryStatus == "Pending"? Images.pendingSelected : Images.pending)
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
                                    .textMedium(color: state.enquiryStatus == "Closed"? ColorResources.white : Colors.black, fontSize: 14),
                                5.horizontalSpace(),
                                SvgPicture.asset(state.enquiryStatus == "Closed"? Images.completedSelected : Images.completed)
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
                        bottom: 120, left: 10, right: 20, top: 20),
                    child: state.responseEnquiryModel!=null&&state.responseEnquiryModel!.data!=null&&state.responseEnquiryModel!.data!.isNotEmpty?
                    customList(
                      list: state.responseEnquiryModel!.data!,
                        child: (index) => InkWell(
                          onTap: () {
                            if(state.responseEnquiryModel!.data![index].status.toString() == "pending"){
                              BlocProvider.of<DdeEnquiryCubit>(context).emit(state.copyWith(markAsClosed: ""));
                            }else{
                              BlocProvider.of<DdeEnquiryCubit>(context).emit(state.copyWith(pendingFromClose: ""));
                            }
                            EnquiryDetailsScreen(state.responseEnquiryModel!.data![index].id.toString()
                                ,state.enquiryStatus.toString(),
                                state.responseEnquiryModel!.data![index].lat.toString(),
                                state.responseEnquiryModel!.data![index].lang.toString(),
                                state.responseEnquiryModel!.data![index].closedAt.toString(),
                            ).navigate();
                          },
                          child: Stack(
                                alignment: Alignment.center,
                                children: [
                                  SizedBox(
                                      height: 150,
                                      width: MediaQuery.of(context).size.width ),
                                  Padding(
                                    padding:
                                        const EdgeInsets.only(bottom: 0, top: 0),
                                    child: customProjectContainer(
                                      child: Container(
                                        padding: EdgeInsets.all(state.enquiryStatus == "Pending"?15:22.0),
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

                                                Text("${countryCode == ""? "":countryCode!=null?countryCode.toString():""} ${state.responseEnquiryModel!.data![index].mobile}",
                                                    style: figtreeRegular.copyWith(
                                                        fontSize: 14,
                                                        color: Colors.black)),
                                                Row(
                                                  children: [
                                                    SvgPicture.asset(
                                                      Images.calender,
                                                      color: Colors.black,
                                                      width: 12,height: 12,
                                                    ),
                                                    4.horizontalSpace(),
                                                    Text('${DateFormat('dd MMM, yy').format(DateTime.parse(state.responseEnquiryModel!.data![index].createdAt.toString()))}${state.responseEnquiryModel!.data![index].closedAt!=null?"-":""}${state.responseEnquiryModel!.data![index].closedAt!=null?DateFormat('dd MMM, yy').format(DateTime.parse(state.responseEnquiryModel!.data![index].closedAt.toString())):""}',
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
                                                state.responseEnquiryModel!.data![index].address.toString(),
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
                                  ),
                                  state.enquiryStatus == "Pending"?
                                  Positioned(
                                      top: 7,
                                      right: 0,
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
                                              onTap: () async {
                                                context.read<DdeEnquiryCubit>().launchURL(state.responseEnquiryModel!.data![index].lat.toString(),state.responseEnquiryModel!.data![index].lang.toString(),context);
                                              },
                                              child:
                                              SvgPicture.asset(Images.redirectLocation)),
                                          16.horizontalSpace(),
                                        ],
                                      ))
                                      :const SizedBox(width: 0,height: 0,),
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
