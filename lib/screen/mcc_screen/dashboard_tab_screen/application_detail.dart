import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:expandable_text/expandable_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:glad/cubit/dde_enquiry_cubit/dde_enquiry_cubit.dart';
import 'package:glad/cubit/landing_page_cubit/landing_page_cubit.dart';
import 'package:glad/cubit/profile_cubit/profile_cubit.dart';
import 'package:glad/cubit/project_cubit/project_cubit.dart';
import 'package:glad/data/model/frontend_kpi_model.dart';
import 'package:glad/data/model/response_project_data_firebase.dart';
import 'package:glad/screen/chat/firebase_chat_screen.dart';
import 'package:glad/screen/custom_widget/custom_appbar.dart';
import 'package:glad/screen/custom_widget/custom_methods.dart';
import 'package:glad/screen/dde_screen/project_kyc/view_loan_kyc.dart';
import 'package:glad/screen/farmer_screen/dashboard/milk_production_yield.dart';
import 'package:glad/screen/livestock/loan_livestock_detail.dart';
import 'package:glad/screen/mcc_screen/view_mcc_loan.dart';
import 'package:glad/screen/supplier_screen/milestone_detail.dart';
import 'package:glad/screen/supplier_screen/supplier_farmer_detail.dart';
import 'package:glad/utils/app_constants.dart';
import 'package:glad/utils/color_resources.dart';
import 'package:glad/utils/extension.dart';
import 'package:glad/utils/images.dart';
import 'package:glad/utils/sharedprefrence.dart';
import 'package:glad/utils/styles.dart';

import '../../../data/model/farmer_project_detail_model.dart';


class ApplicationDetail extends StatefulWidget {
  const ApplicationDetail({super.key,
    required this.projectId,
    required this.selectedFilter,
  });

  final int projectId;
  final String selectedFilter;

  @override
  State<ApplicationDetail> createState() => _ApplicationDetailState();
}

class _ApplicationDetailState extends State<ApplicationDetail> {

  TextEditingController controller = TextEditingController();

  @override
  void initState() {
    BlocProvider.of<ProjectCubit>(context)
        .farmerProjectDetailApi(context, widget.projectId);
    super.initState();
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocBuilder<ProjectCubit, ProjectState>(builder: (context, state) {
        if (state.status == ProjectStatus.loading) {
          return const Center(
              child: CircularProgressIndicator(
                color: ColorResources.maroon,
              ));
        } else if (state.responseFarmerProjectDetail == null) {
          return Center(child: Text("${state.responseFarmerProjectDetail} Api Error"));
        }else{
          return Stack(
            children: [
              landingBackground(),
              Column(
                children: [
                  CustomAppBar(
                    context: context,
                    titleText1: state.responseFarmerProjectDetail!.data!.farmerProject![0].name ?? '',
                    leading: arrowBackButton(),
                    centerTitle: true,
                    titleText1Style:
                    figtreeMedium.copyWith(fontSize: 20, color: Colors.black),
                  ),
                  Expanded(
                    child: SingleChildScrollView(
                      child: Padding(
                        padding: const EdgeInsets.fromLTRB(24, 20, 24, 0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            description(state),
                            20.verticalSpace(),
                            dividerValue(state),
                            20.verticalSpace(),
                            state.responseFarmerProjectDetail!.data!.farmerProject![0].farmerMaster!=null?
                            farmerDetail(context, state.responseFarmerProjectDetail!.data!.farmerProject![0].farmerMaster!):const SizedBox.shrink(),
                            state.responseFarmerProjectDetail!.data!.farmerProject![0].dairyDevelopMentExecutive!=null?
                            dde(context,state.responseFarmerProjectDetail!.data!.farmerProject![0].dairyDevelopMentExecutive!):const SizedBox.shrink(),
                            state.responseFarmerProjectDetail!.data!.farmerProject![0].kpi!=null?
                            kpi(context,state):const SizedBox.shrink(),

                            if(state.responseFarmerProjectDetail!.data!
                                .farmerProject![0].category.toString() == "6")
                              livestockList(context, state)
                           else if(state.responseFarmerProjectDetail!.data!
                                .farmerProject![0].category.toString() == "7")
                             const SizedBox.shrink()
                            else
                              projectMilestones(context,state),
                            6.verticalSpace(),
                           /* customProjectContainer(
                                marginLeft: 0,
                                marginTop: 0,
                                borderRadius: 14,
                                child: Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 8.0, vertical: 12),
                                  child: Column(
                                    children: [
                                      Padding(
                                        padding:
                                        const EdgeInsets.symmetric(horizontal: 8.0),
                                        child: Row(
                                          mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                          children: [
                                            Text(
                                              'Payment Terms',
                                              style:
                                              figtreeMedium.copyWith(fontSize: 18),
                                            ),
                                            SvgPicture.asset(Images.drop)
                                          ],
                                        ),
                                      ),
                                      customList(
                                          list: state.responseFarmerProjectDetail!.data!.farmerProject![0].farmerProjectPaymentTerms!,
                                          child: (index){
                                            return Container(
                                              margin: const EdgeInsets.only(top: 10),
                                              padding: const EdgeInsets.symmetric(
                                                  vertical: 8, horizontal: 14),
                                              decoration: BoxDecoration(
                                                  color: const Color(0xFFE4FFE3),
                                                  borderRadius: BorderRadius.circular(10)),
                                              child: Row(
                                                mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                                children: [
                                                  Expanded(
                                                    child: Text(
                                                      state.responseFarmerProjectDetail!.data!.farmerProject![0].farmerProjectPaymentTerms![index].paymentTerm??"",
                                                      style:
                                                      figtreeMedium.copyWith(fontSize: 16),
                                                    ),
                                                  ),
                                                  Container(
                                                    padding: const EdgeInsets.symmetric(
                                                        horizontal: 20, vertical: 10),
                                                    decoration: BoxDecoration(
                                                        color: Colors.white,
                                                        borderRadius:
                                                        BorderRadius.circular(14),
                                                        border:
                                                        Border.all(color: Colors.grey)),
                                                    child: Text(
                                                      '${state.responseFarmerProjectDetail!.data!.farmerProject![0].farmerProjectPaymentTerms![index].paymentPercentage!=null?state.responseFarmerProjectDetail!.data!.farmerProject![0].farmerProjectPaymentTerms![index].paymentPercentage!.toString():""}%',
                                                      style: figtreeMedium.copyWith(
                                                          fontSize: 12),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            );
                                          })
                                    ],
                                  ),
                                )),
                            20.verticalSpace(),
                            Padding(
                              padding: const EdgeInsets.symmetric(horizontal: 35.0),
                              child: Text(
                                'This survey is required to be completed before 16 June, 2023.',
                                style: figtreeMedium.copyWith(fontSize: 18),
                                textAlign: TextAlign.center,
                              ),
                            ),*/


                            widget.selectedFilter == "pending"?
                            Row(
                              children: [
                                Expanded(
                                  child: Container(
                                      margin: 18.marginAll(),
                                      height: 55,
                                      width: screenWidth(),
                                      child: customButton("Farmer Document",
                                          fontColor: 0xffffffff, onTap: () {

                                        if(state.responseFarmerProjectDetail!.data!.farmerProject![0].farmerProjectKycDocument!=null){
                                          ViewLoanKycMcc(farmerDocuments: state.responseFarmerProjectDetail!.data!.farmerProject![0].farmerProjectKycDocument!,
                                              farmerMaster:state.responseFarmerProjectDetail!.data!.farmerProject![0].farmerMaster!).navigate();
                                        }else{
                                          'There is no document available'.toast();
                                        }
                                      })),
                                )
                              ],
                            ):const SizedBox.shrink(),

                            40.verticalSpace(),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              Positioned(
                  bottom: 0,
                  right: 0,
                  child: InkWell(
                    onTap: ()async{
                      FirebaseFirestore.instance.collection('projects_chats')
                          .doc(widget.projectId.toString())
                          .set({
                        'farmer_project_id': state.responseFarmerProjectDetail!.data!.farmerProject![0].id.toString(),
                        'farmer_id': state.responseFarmerProjectDetail!.data!.farmerProject![0].farmerMaster!.id.toString(),
                        'dde_id': state.responseFarmerProjectDetail!.data!.farmerProject![0].farmerMaster!.ddeId.toString(),
                        'supplier_id': state.responseFarmerProjectDetail!.data!.supplierDetail!=null?state.responseFarmerProjectDetail!.data!.supplierDetail!.id.toString():"",
                        'mcc_id': state.responseFarmerProjectDetail!.data!.farmerProject![0].farmerMaster!.mccId.toString(),
                        'admin_id': '',
                        'project_name': state.responseFarmerProjectDetail!.data!.farmerProject![0].name.toString(),
                        'project_image': state.responseFarmerProjectDetail!.data!.farmerProject![0].category.toString() == "7"
                            ? state.responseFarmerProjectDetail!.data!.farmerProject![0].improvementArea!=null?state.responseFarmerProjectDetail!.data!.farmerProject![0].improvementArea!.image??'':''
                            : state.responseFarmerProjectDetail!.data!.farmerProject![0].project!=null?state.responseFarmerProjectDetail!.data!.farmerProject![0].project!["image"]??'':'',
                        'created_at': Timestamp.now(),
                        'farmer_name': state.responseFarmerProjectDetail!.data!.farmerProject![0].farmerMaster!.name.toString(),
                        'farmer_address': state.responseFarmerProjectDetail!.data!.farmerProject![0].farmerMaster!.address!=null?state.responseFarmerProjectDetail!.data!.farmerProject![0].farmerMaster!.address!.address!=null?state.responseFarmerProjectDetail!.data!.farmerProject![0].farmerMaster!.address!.address!.toString():'':'',
                        // 'user_type': 'farmer',
                      });


                      ResponseProjectDataForFirebase response = ResponseProjectDataForFirebase(
                          projectName: state.responseFarmerProjectDetail!.data!.farmerProject![0].name!.toString(),
                          farmerProjectId: state.responseFarmerProjectDetail!.data!.farmerProject![0].id,
                          userName: await SharedPrefManager.getPreferenceString(AppConstants.userName),
                          userType: 'mcc',
                          farmerId: state.responseFarmerProjectDetail!.data!.farmerProject![0].farmerMaster!.id.toString(),
                          ddeId: state.responseFarmerProjectDetail!.data!.farmerProject!=null?state.responseFarmerProjectDetail!.data!.farmerProject![0].ddeId.toString():'',
                          mccId: state.responseFarmerProjectDetail!.data!.farmerProject![0].farmerMaster!=null?state.responseFarmerProjectDetail!.data!.farmerProject![0].farmerMaster!.mccId.toString():'',
                          supplierId: state.responseFarmerProjectDetail!.data!.supplierDetail!=null?state.responseFarmerProjectDetail!.data!.supplierDetail!.id.toString():'',
                          farmerName: state.responseFarmerProjectDetail!.data!.farmerProject![0].farmerMaster!.name.toString(),
                          farmerAddress: state.responseFarmerProjectDetail!.data!.farmerProject![0].farmerMaster!.address!=null?state.responseFarmerProjectDetail!.data!.farmerProject![0].farmerMaster!.address!.address.toString():'',
                          projectImage: state.responseFarmerProjectDetail!.data!.farmerProject![0].category.toString() == "7"
                              ? state.responseFarmerProjectDetail!.data!.farmerProject![0].improvementArea!=null?state.responseFarmerProjectDetail!.data!.farmerProject![0].improvementArea!.image??'':''
                              : state.responseFarmerProjectDetail!.data!.farmerProject![0].project!=null?state.responseFarmerProjectDetail!.data!.farmerProject![0].project!["image"]??'':'',);

                      FirebaseChatScreen(responseProjectDataForFirebase: response,).navigate();

                      // ResponseProjectDataForFirebase response = ResponseProjectDataForFirebase(
                      //     projectName: state.responseFarmerProjectDetail!.data!.farmerProject![0].name!.toString(),
                      //     farmerProjectId: state.responseFarmerProjectDetail!.data!.farmerProject![0].id,
                      //     userName: state.responseFarmerProjectDetail!.data!.farmerProject![0].farmerMaster!.name.toString(),
                      //     userType: 'farmer', userId: state.responseFarmerProjectDetail!.data!.farmerProject![0].farmerMaster!.id);
                      // FirebaseChatScreen(responseProjectDataForFirebase: response,).navigate();
                      // ChatScreen().navigate();
                    },
                    child: Image.asset(
                      Images.messageChat,
                      width: 100,
                      height: 100,
                    ),
                  )),
            ],
          );
        }
      }),
    );
  }

  /////////KPI///////////////////////
  Widget kpi(contexts,ProjectState state) {
    List<FrontendKpiModel> kpiData = [];

    if(state.responseFarmerProjectDetail!.data!.farmerProject![0].kpi!.milkSupplySixMonth!=null){
      kpiData.add(FrontendKpiModel(name: 'Milk Supply Six Month',
          image: Images.investmentKpi,
          value: "${state.responseFarmerProjectDetail!.data!.farmerProject![0].kpi!.milkSupplySixMonth!.toString()} LTR"));
    }

    if(state.responseFarmerProjectDetail!.data!.farmerProject![0].kpi!.milkSupplyOneMonth!=null){
      kpiData.add(FrontendKpiModel(name: 'Milk Supply One Month',
          image: Images.revenueKpi,
          value: "${state.responseFarmerProjectDetail!.data!.farmerProject![0].kpi!.milkSupplyOneMonth!} LTR"));
    }

    if(state.responseFarmerProjectDetail!.data!.farmerProject![0].kpi!.milkSupplyTwoWeek!=null){
      kpiData.add(FrontendKpiModel(name: 'Milk Supply Two Week',
          image: Images.roiKpi,
          value: "${state.responseFarmerProjectDetail!.data!.farmerProject![0].kpi!.milkSupplyTwoWeek!} LTR"));
    }


    return Column(
      mainAxisAlignment: MainAxisAlignment.end,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "KPI's",
          style: figtreeMedium.copyWith(
            fontSize: 18,
          ),
        ),
        10.verticalSpace(),

        customGrid(context,
            list: kpiData,
            crossAxisCount: 3,
            mainAxisSpacing: 15,
            crossAxisSpacing: 13,
            mainAxisExtent: 123,
            child: (index){
              return InkWell(
                onTap: () {
                  /*if(double.parse(kpiData[index].value!.replaceAll(' LTR', '')) > 0) {
                    MilkProductionYield(type: 'milk_production',
                        farmerId: state.responseFarmerProjectDetail!.data!
                            .farmerProject![0].farmerId.toString()).navigate();
                  }*/
                },
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(14),
                    border: Border.all(color: const Color(0xffDCDCDC),width: 1),
                    boxShadow:[
                      BoxShadow(
                          color: Colors.grey.withOpacity(0.2),
                          blurRadius: 2.0,
                          offset: const Offset(0, 2))],
                  ),
                  child: Padding(
                    // padding: 0.paddingAll(),
                    padding: const EdgeInsets.fromLTRB(8, 10, 8, 2),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SvgPicture.asset(
                          kpiData[index].image.toString(),
                          width: 30,
                          height: 30,
                        ),
                        15.verticalSpace(),
                        Text(
                          '${kpiData[index].value}',
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: figtreeMedium.copyWith(fontSize: 14.3),
                        ),
                        05.verticalSpace(),
                        Text(
                          kpiData[index].name.toString(),
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                          style: figtreeRegular.copyWith(
                            fontSize: 12.5,
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              );
            }),


      ],
    );
  }

  ///////DividerValue///////////
  Widget dividerValue(ProjectState state) {
    return Column(
      children: [
        const Divider(
          thickness: 1,
        ),
        10.verticalSpace(),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'Value',
              style: figtreeMedium.copyWith(fontSize: 14),
            ),

            Text(
              getCurrencyString(state.responseFarmerProjectDetail!.data!.farmerProject![0].kpi!.investment!),
              style: figtreeSemiBold.copyWith(
                  fontSize: 16, color: ColorResources.maroon),
            ),

          ],
        ),
        10.verticalSpace(),
        const Divider(
          thickness: 1,
        ),
      ],
    );
  }

///////DescriptionDetails///////////
  Widget description(ProjectState state) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Text(
              'Description',
              style: figtreeMedium.copyWith(fontSize: 18),
            ),
            05.horizontalSpace(),
            Container(
              padding: const EdgeInsets.symmetric(vertical: 4, horizontal: 7),
              decoration: boxDecoration(
                borderWidth: 1,
                borderRadius: 30,
                borderColor: const Color(0xff6A0030),
              ),
              child: Text(
                state.responseFarmerProjectDetail!.data!.farmerProject![0].projectStatus.toString() ,
                textAlign: TextAlign.center,
                style: figtreeMedium.copyWith(
                    color: const Color(0xff6A0030), fontSize: 10),
              ),
            )
          ],
        ),
        10.verticalSpace(),
        ExpandableText(
          state.responseFarmerProjectDetail!.data!.farmerProject![0].description ?? '',
          expandText: 'Read More',
          linkColor: ColorResources.maroon,
          style: figtreeMedium.copyWith(fontSize: 14),
          collapseText: 'Show Less',
        )
      ],
    );
  }

///////////DDEContainerTimeline/////////////
  Widget dde(context,DairyDevelopMentExecutive dde) {
    return Column(
      children: [
        Column(
          children: [
            Stack(
              alignment: Alignment.center,
              children: [
                SizedBox(height: 153, width: screenWidth()),
                Container(
                  height: 100,
                  width: screenWidth(),
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(16),
                      border: Border.all(color: ColorResources.grey)),
                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(15.0, 20, 0, 10),
                    child: Column(
                      children: [
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            dde.photo!=null?
                            CircleAvatar(
                                radius: 33,
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(40),
                                  child: CachedNetworkImage(
                                    imageUrl: dde.photo ?? '',
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
                                  ),
                                )) :
                            CircleAvatar(
                              radius: 30,
                              child: Image.asset(
                                Images.sampleUser,
                                fit: BoxFit.cover,
                                width: 80,
                                height: 80,
                              ),
                            ),
                            15.horizontalSpace(),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(dde.name!=null?dde.name!.toString():"",
                                    style: figtreeMedium.copyWith(
                                        fontSize: 16, color: Colors.black)),
                                10.verticalSpace(),
                                Row(
                                  crossAxisAlignment: CrossAxisAlignment.end,
                                  children: [
                                    const Icon(
                                      Icons.call,
                                      color: Colors.black,
                                      size: 16,
                                    ),
                                    Text('+256 ${dde.phone!}',
                                        style: figtreeRegular.copyWith(
                                            fontSize: 12, color: Colors.black)),
                                  ],
                                ),
                                4.verticalSpace(),
                                Row(
                                  crossAxisAlignment: CrossAxisAlignment.end,
                                  children: [
                                    const Icon(
                                      Icons.location_on,
                                      color: Colors.black,
                                      size: 16,
                                    ),
                                    SizedBox(
                                      width: MediaQuery.of(context).size.width *
                                          0.5,
                                      child: Text(
                                        dde.address != null ?
                                        dde.address["address"] != null && dde.address["sub_county"] != null
                                            ? dde.address["sub_county"] + dde.address["address"] : '' : '',
                                        style: figtreeRegular.copyWith(
                                          fontSize: 12,
                                          color: Colors.black,
                                          overflow: TextOverflow.ellipsis,
                                        ),
                                      ),
                                    ),
                                  ],
                                )
                              ],
                            )
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
                Positioned(
                    top: -5,
                    left: 0,
                    child: Text(
                      'DDE',
                      style: figtreeMedium.copyWith(fontSize: 20),
                    )),
                Positioned(
                    top: 0,
                    right: 10,
                    child: Row(
                      children: [

                        InkWell(onTap: () async {
                          await callOnMobile(dde.phone);
                        },
                            child:
                            SvgPicture.asset(Images.callPrimary)),
                        6.horizontalSpace(),
                        whatsapp(dde.phone),
                        6.horizontalSpace(),
                        InkWell(
                            onTap: (){
                              if(dde.address!=null){
                                BlocProvider.of<DdeEnquiryCubit>(context).launchURL(
                                    dde.address!['latitude'].toString(),
                                    dde.address!['longitude'].toString(),context);
                              }
                            },child: SvgPicture.asset(Images.redirectLocation)),
                        6.horizontalSpace(),
                      ],
                    )),
              ],
            ),
          ],
        ),
      ],
    );
  }

  ///////////farmerDetail/////////////
  Widget farmerDetail(context, FarmerMaster farmerDetail) {
    return Stack(
      alignment: Alignment.center,
      children: [
        SizedBox(height: 153, width: screenWidth()),
        InkWell(
          onTap: (){
            BlocProvider.of<LandingPageCubit>(context).getCurrentLocation();
            BlocProvider.of<ProfileCubit>(context).emit(ProfileCubitState.initial());
            SupplierFarmerDetail(userId: farmerDetail.userId!,farmerId:farmerDetail.id!).navigate();
          },
          child: Container(
            height: 100,
            width: screenWidth(),
            decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(16),
                border: Border.all(color: ColorResources.grey)),
            child: Padding(
              padding: const EdgeInsets.fromLTRB(15.0, 16, 0, 10),
              child: Column(
                children: [
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      farmerDetail.photo!=null?
                      CircleAvatar(
                          radius: 33,
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(40),
                            child: CachedNetworkImage(
                              imageUrl: farmerDetail.photo ?? '',
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
                            ),
                          )) :
                      CircleAvatar(
                        radius: 30,
                        child: Image.asset(
                          Images.sampleUser,
                          fit: BoxFit.cover,
                          width: 80,
                          height: 80,
                        ),
                      ),
                      15.horizontalSpace(),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(farmerDetail.name ?? '',
                              style: figtreeMedium.copyWith(
                                  fontSize: 16, color: Colors.black)),
                          10.verticalSpace(),
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                              const Icon(
                                Icons.call,
                                color: Colors.black,
                                size: 16,
                              ),
                              Text(farmerDetail.phone ?? '',
                                  style: figtreeRegular.copyWith(
                                      fontSize: 12, color: Colors.black)),
                            ],
                          ),
                          4.verticalSpace(),
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                              const Icon(
                                Icons.location_on,
                                color: Colors.black,
                                size: 16,
                              ),
                              SizedBox(
                                width: MediaQuery.of(context).size.width *
                                    0.5,
                                child: Text(farmerDetail.address!=null?
                                farmerDetail.address!.address!=null ?farmerDetail.address!.address!.toString():"":"",
                                  style: figtreeRegular.copyWith(
                                    fontSize: 12,
                                    color: Colors.black,
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                ),
                              ),
                            ],
                          ),

                        ],
                      )
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
        Positioned(
            top: -5,
            left: 0,
            child: Text(
              'Farmer',
              style: figtreeMedium.copyWith(fontSize: 20),
            )),
        Positioned(
            top: 0,
            right: 10,
            child: Row(
              children: [
                InkWell(
                    onTap: (){
                      callOnMobile(farmerDetail.phone ?? '');
                    }, child: SvgPicture.asset(Images.callPrimary)),
                6.horizontalSpace(),
                InkWell(onTap: ()async{
                  await launchWhatsApp(farmerDetail.phone ?? '');
                },child: SvgPicture.asset(Images.whatsapp)),

                6.horizontalSpace(),
                InkWell(onTap: ()async{
                  if(farmerDetail.address!=null){
                    BlocProvider.of<DdeEnquiryCubit>(context).launchURL(
                        farmerDetail.address!.latitude.toString(),
                        farmerDetail.address!.longitude.toString(),context);
                  }
                },child: SvgPicture.asset(Images.redirectLocation)),
                6.horizontalSpace(),
              ],
            )),
      ],
    );
  }

  ///////////ProjectMilestones///////////
  Widget projectMilestones(context, ProjectState state) {
    return Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      30.verticalSpace(),
      Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            'Project milestones',
            style: figtreeMedium.copyWith(fontSize: 18),
          ),
        ],
      ),
      15.verticalSpace(),
      customList(
          list: state.responseFarmerProjectDetail!.data!.farmerProject![0].farmerProjectMilestones!,
          axis: Axis.vertical,
          child: (int index) {
            return Padding(
              padding: const EdgeInsets.only(
                bottom: 20,
              ),
              child: InkWell(
                onTap: (){
                  // const MilestoneDetail().navigate();
                  SupplierMilestoneDetail(milestoneId:
                  state.responseFarmerProjectDetail!.data!.farmerProject![0].farmerProjectMilestones![index].id,
                      projectStatus:state.responseFarmerProjectDetail!.data!.farmerProject![0].projectStatus.toString(),
                    projectId: 0,navigateScreen: '',
                  ).navigate();
                  /*SuggestedProjectMilestoneDetail(milestoneId:
                  state.responseFarmerProjectDetail!.data!.farmerProject![0].farmerProjectMilestones![index].id,
                      projectStatus:state.responseFarmerProjectDetail!.data!.farmerProject![0].projectStatus.toString()
                  ).navigate();*/
                },
                child: customProjectContainer(
                    marginLeft: 0,
                    marginTop: 0,
                    borderRadius: 14,
                    child: Padding(
                      padding: const EdgeInsets.fromLTRB(20, 20, 10, 20),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                state.responseFarmerProjectDetail!.data!.farmerProject![0].farmerProjectMilestones![index].milestoneTitle ?? '',
                                style: figtreeMedium.copyWith(fontSize: 18),
                              ),
                            ],
                          ),
                          5.verticalSpace(),
                          Text(
                            '${state.responseFarmerProjectDetail!.data!.farmerProject![0].farmerProjectMilestones![index].farmerProjectTaskCount ?? 0} tasks included in this milestone.',
                            style: figtreeMedium.copyWith(fontSize: 12),
                          ),
                          20.verticalSpace(),
                          Row(
                            children: [
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    'Value',
                                    style: figtreeMedium.copyWith(
                                        fontSize: 12,
                                        color: ColorResources.fieldGrey),
                                  ),
                                  Text(
                                    state.responseFarmerProjectDetail!.data!.farmerProject![0].farmerProjectMilestones![index].milestoneValue!=null?getCurrencyString(state.responseFarmerProjectDetail!.data!.farmerProject![0].farmerProjectMilestones![index].milestoneValue):'',
                                    // 'UGX ${state.responseFarmerProjectDetail!.data!.farmerProject![0].farmerProjectMilestones![index].milestoneValue ?? ''}',
                                    style: figtreeSemiBold.copyWith(
                                        fontSize: 16,
                                        color: ColorResources.maroon),
                                  )
                                ],
                              ),
                              40.horizontalSpace(),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    'Duration',
                                    style: figtreeMedium.copyWith(
                                        fontSize: 12,
                                        color: ColorResources.fieldGrey),
                                  ),
                                  Text(
                                    '${state.responseFarmerProjectDetail!.data!.farmerProject![0].farmerProjectMilestones![index].milestoneDuration ?? ''} Days',
                                    style: figtreeSemiBold.copyWith(
                                        fontSize: 16,
                                        color: ColorResources.black),
                                  )
                                ],
                              ),
                            ],
                          ),
                        ],
                      ),
                    )),
              ),
            );
          }),
    ]);
  }


  ///////////ProjectMilestones///////////
  Widget livestockList(contexts, ProjectState state) {
    return Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      50.verticalSpace(),
      Text(
        'Livestock',
        style: figtreeMedium.copyWith(fontSize: 18),
      ),
      15.verticalSpace(),
      customGrid(
        // padding: const EdgeInsets.fromLTRB(0,13,0,120),
          list: state.responseFarmerProjectDetail!.data!.farmerProject![0].dataLivestock!.liveStockCartDetails ?? [],
          crossAxisSpacing: 13,
          mainAxisSpacing: 13,
          mainAxisExtent: 250,
          context, child: (index){
        return state.responseFarmerProjectDetail!.data!.farmerProject![0].dataLivestock!.liveStockCartDetails![index].liveStock!=null?
        Stack(
          children: [
            InkWell(
              onTap: () {
                LoanLivestockDetail(id: state.responseFarmerProjectDetail!.data!.farmerProject![0].dataLivestock!.liveStockCartDetails![index].liveStockId.toString(), isMyLivestock: false,
                  cowQty:state.responseFarmerProjectDetail!.data!.farmerProject![0].dataLivestock!.liveStockCartDetails![index].cowQty.toString(),
                  status:state.responseFarmerProjectDetail!.data!.farmerProject![0].projectStatus.toString(),
                  farmerProjectId:state.responseFarmerProjectDetail!.data!.farmerProject![0].id,
                  cartId:state.responseFarmerProjectDetail!.data!.farmerProject![0].dataLivestock!.liveStockCartDetails![index].id!,
                  deliveryStatus:state.responseFarmerProjectDetail!.data!.farmerProject![0].dataLivestock!.liveStockCartDetails![index].deliveryStatus!,
                  remarks:state.responseFarmerProjectDetail!.data!.farmerProject![0].dataLivestock!.liveStockCartDetails![index].remarks,
                  mediaLivestock: state.responseFarmerProjectDetail!.data!.farmerProject![0].dataLivestock!.liveStockCartDetails![index].media!=null?state.responseFarmerProjectDetail!.data!.farmerProject![0].dataLivestock!.liveStockCartDetails![index].media!:[],
                  type:"",
                  cowPrice:state.responseFarmerProjectDetail!.data!.farmerProject![0].dataLivestock!.liveStockCartDetails![index].cowPrice.toString(),
                ).navigate();
              },
              child: customShadowContainer(
                margin: 0,
                color: /*state.responseFarmerProjectDetail!.data!.farmerProject![0].dataLivestock!.liveStockCartDetails![index].deliveryStatus == "completed" ||*/ state.responseFarmerProjectDetail!.data!.farmerProject![0].dataLivestock!.liveStockCartDetails![index].deliveryStatus == "approved"?const Color(0xffFFF3F4):Colors.white,
                backColor: /*state.responseFarmerProjectDetail!.data!.farmerProject![0].dataLivestock!.liveStockCartDetails![index].deliveryStatus == "completed" ||*/ state.responseFarmerProjectDetail!.data!.farmerProject![0].dataLivestock!.liveStockCartDetails![index].deliveryStatus == "approved"? const Color(0xff6A0030):Colors.grey.withOpacity(0.4),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Stack(
                      alignment: Alignment.bottomRight,
                      children: [
                        if(state.responseFarmerProjectDetail!.data!.farmerProject![0].dataLivestock!.liveStockCartDetails![index].liveStock!.liveStockDocumentFiles!.isNotEmpty)
                          SizedBox(
                            // padding: 2.marginAll(),
                              width: screenWidth(),
                              height:140,child: ClipRRect(borderRadius: const BorderRadius.only(topLeft: Radius.circular(20),topRight: Radius.circular(20)),child: CachedNetworkImage(imageUrl: state.responseFarmerProjectDetail!.data!.farmerProject![0].dataLivestock!.liveStockCartDetails![index].liveStock!.liveStockDocumentFiles![0].originalUrl ?? '',fit: BoxFit.cover,)))
                        else
                          const SizedBox(height: 140,),

                        if(state.responseFarmerProjectDetail!.data!.farmerProject![0].dataLivestock!.liveStockCartDetails![index].liveStock!.liveStockDocumentFiles!.length > 1)
                          customShadowContainer(
                            backColor: Colors.transparent,
                            color: Colors.transparent,
                            child: Row(
                              mainAxisSize: MainAxisSize.min,
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                (state.responseFarmerProjectDetail!.data!.farmerProject![0].dataLivestock!.liveStockCartDetails![index].liveStock!.liveStockDocumentFiles!.length).toString().textRegular(fontSize: 14, color: Colors.white),
                                const Icon(Icons.image_outlined, color: Colors.white,)
                              ],),
                          )
                      ],
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 9.0, right: 9, top: 6),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          RichText(
                              text: TextSpan(children: [
                                TextSpan(
                                    text: '${state.responseFarmerProjectDetail!.data!.farmerProject![0].dataLivestock!.liveStockCartDetails![index].liveStock!.cowBreed!.name ?? ''} cow ',
                                    style: figtreeMedium.copyWith(
                                        fontSize: 12, color: Colors.black)),
                                TextSpan(
                                    text: '(${state.responseFarmerProjectDetail!.data!.farmerProject![0].dataLivestock!.liveStockCartDetails![index].liveStock!.advertisementNo ?? ''})',
                                    style: figtreeMedium.copyWith(
                                        fontSize: 12, color: const Color(0xFF727272)))
                              ])),
                          6.verticalSpace(),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(getCurrencyString(double.parse(state.responseFarmerProjectDetail!.data!.farmerProject![0].dataLivestock!.liveStockCartDetails![index].cowPrice.toString())),
                                  style: figtreeSemiBold.copyWith(
                                      fontSize: 18, color: Colors.black)),
                              RichText(
                                  text: TextSpan(children: [
                                    TextSpan(
                                        text: 'Qty: ',
                                        style: figtreeMedium.copyWith(
                                            fontSize: 12, color: const Color(0xFF727272))),
                                    TextSpan(
                                        text: state.responseFarmerProjectDetail!.data!.farmerProject![0].dataLivestock!.liveStockCartDetails![index].cowQty.toString(),
                                        style: figtreeMedium.copyWith(
                                            fontSize: 12, color: Colors.black)),
                                  ])),
                            ],
                          ),
                          12.verticalSpace(),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              RichText(
                                  text: TextSpan(children: [
                                    TextSpan(
                                        text: 'Age: ',
                                        style: figtreeMedium.copyWith(
                                            fontSize: 12, color: const Color(0xFF727272))),
                                    TextSpan(
                                        text: '${state.responseFarmerProjectDetail!.data!.farmerProject![0].dataLivestock!.liveStockCartDetails![index].liveStock!.age ?? ''} yrs',
                                        style: figtreeMedium.copyWith(
                                            fontSize: 12, color: Colors.black)),
                                  ])),
                              // 10.horizontalSpace(),
                              Container(
                                height: 5,
                                width: 5,
                                decoration: const BoxDecoration(
                                    color: Colors.black, shape: BoxShape.circle),
                              ),
                              // 10.horizontalSpace(),
                              RichText(
                                  text: TextSpan(children: [
                                    TextSpan(
                                        text: 'Milk: ',
                                        style: figtreeMedium.copyWith(
                                            fontSize: 12, color: const Color(0xFF727272))),
                                    TextSpan(
                                        text: '${double.parse(state.responseFarmerProjectDetail!.data!.farmerProject![0].dataLivestock!.liveStockCartDetails![index].liveStock!.yield ?? '').toInt()}L/day',
                                        style: figtreeMedium.copyWith(
                                            fontSize: 12, color: Colors.black))
                                  ])),
                            ],
                          ),
                          6.verticalSpace(),
                          Text(state.responseFarmerProjectDetail!.data!.farmerProject![0].dataLivestock!.liveStockCartDetails![index].liveStock!.user != null
                              ? state.responseFarmerProjectDetail!.data!.farmerProject![0].dataLivestock!.liveStockCartDetails![index].liveStock!.user!.farmerMaster!.address!.address ?? ''
                              : '',
                            style: figtreeMedium.copyWith(
                                fontSize: 12, color: Colors.black), maxLines: 1,),
                          // 12.verticalSpace(),
                          // Row(
                          //   children: [
                          //     Container(
                          //       decoration: BoxDecoration(
                          //         borderRadius: BorderRadius.circular(26),
                          //         border: Border.all(color: const Color(0xFFFC5E60)),
                          //       ),
                          //       padding: const EdgeInsets.symmetric(
                          //           horizontal: 16, vertical: 9.5),
                          //       child: SvgPicture.asset(Images.chatBubble),
                          //     ),
                          //     6.horizontalSpace(),
                          //     Container(
                          //       decoration: BoxDecoration(
                          //         borderRadius: BorderRadius.circular(50),
                          //         border: Border.all(color: const Color(0xffF6B51D)),
                          //       ),
                          //       padding: const EdgeInsets.symmetric(
                          //           vertical: 10.0, horizontal: 9.5),
                          //       child: Text('Add to Cart',
                          //           style: figtreeMedium.copyWith(
                          //               fontSize: 13.5, color: Colors.black)),
                          //     )
                          //   ],
                          // )
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
            state.responseFarmerProjectDetail!.data!.farmerProject![0].dataLivestock!.liveStockCartDetails![index].deliveryStatus == "completed" || state.responseFarmerProjectDetail!.data!.farmerProject![0].dataLivestock!.liveStockCartDetails![index].deliveryStatus == "approved"?
            Align(
              alignment: Alignment.topRight,
              child: Container(
                  width: 24,
                  margin: const EdgeInsets.all(10),
                  height: 24,
                  decoration: BoxDecoration(
                      color: Colors.white,
                      border: Border.all(color: const Color(0xff6A0030)),
                      borderRadius: BorderRadius.circular(6)
                  ),
                  child: const Center(child: Icon(Icons.check,size: 16,color: Color(0xff6A0030),))
              ),
            ):const SizedBox.shrink()
          ],
        ):const SizedBox.shrink();
      }),

      20.verticalSpace(),
    ]);
  }


}
