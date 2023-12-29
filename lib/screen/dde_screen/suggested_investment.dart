import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dio/dio.dart';
import 'package:dropdown_search/dropdown_search.dart';
import 'package:expandable_text/expandable_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_svg/svg.dart';
import 'package:glad/cubit/dde_enquiry_cubit/dde_enquiry_cubit.dart';
import 'package:glad/cubit/landing_page_cubit/landing_page_cubit.dart';
import 'package:glad/cubit/profile_cubit/profile_cubit.dart';
import 'package:glad/cubit/project_cubit/project_cubit.dart';
import 'package:glad/data/model/farmer_project_detail_model.dart';
import 'package:glad/data/model/frontend_kpi_model.dart';
import 'package:glad/data/model/response_project_data_firebase.dart';
import 'package:glad/screen/chat/firebase_chat_screen.dart';
import 'package:glad/screen/common/add_remarks_dispute_screen.dart';
import 'package:glad/screen/custom_widget/circular_percent_indicator.dart';
import 'package:glad/screen/custom_widget/custom_appbar.dart';
import 'package:glad/screen/custom_widget/custom_methods.dart';
import 'package:glad/screen/custom_widget/custom_textfield2.dart';
import 'package:glad/screen/dde_screen/dde_farmer_detail.dart';
import 'package:glad/screen/dde_screen/dde_milestone_detail.dart';
import 'package:glad/screen/dde_screen/edit_project_milestone.dart';
import 'package:glad/screen/dde_screen/preview_screen.dart';
import 'package:glad/screen/dde_screen/project_detail_statement.dart';
import 'package:glad/screen/dde_screen/project_kyc/kyc_update.dart';
import 'package:glad/screen/dde_screen/termsandcondition.dart';
import 'package:glad/screen/dde_screen/track_progress.dart';
import 'package:glad/screen/dde_screen/project_kyc/view_loan_kyc.dart';
import 'package:glad/screen/dde_screen/widget/add_remark_revoke.dart';
import 'package:glad/screen/farmer_screen/common/add_remark.dart';
import 'package:glad/screen/farmer_screen/common/suggested_project_milestone_detail.dart';
import 'package:glad/screen/farmer_screen/profile/kyc_update.dart';
import 'package:glad/screen/livestock/loan_livestock_detail.dart';
import 'package:glad/screen/supplier_screen/dispute_screen.dart';
import 'package:glad/utils/app_constants.dart';
import 'package:glad/utils/color_resources.dart';
import 'package:glad/utils/extension.dart';
import 'package:glad/utils/images.dart';
import 'package:glad/utils/sharedprefrence.dart';
import 'package:glad/utils/styles.dart';
import 'package:info_popup/info_popup.dart';
import 'package:intl/intl.dart';
import 'package:open_file_safe_plus/open_file_safe_plus.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';

import 'add_project_milestone.dart';
import 'add_remark_confirm_loan.dart';

class DDeFarmerInvestmentDetails extends StatefulWidget {
  const DDeFarmerInvestmentDetails({
    super.key,
    required this.projectId,
    // this.farmerData
  });
  final int projectId;
  // final FarmerMaster? farmerDetail;
  // final Farmer? farmerData;

  @override
  State<DDeFarmerInvestmentDetails> createState() =>
      _DDeFarmerInvestmentDetailsState();
}

class _DDeFarmerInvestmentDetailsState
    extends State<DDeFarmerInvestmentDetails> {

  bool paymentTerms = false;

  @override
  void initState() {
    BlocProvider.of<ProjectCubit>(context)
        .farmerProjectDetailApi(context, widget.projectId);
    super.initState();
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
          return Center(
              child: Text("${state.responseFarmerProjectDetail} Api Error"));
        } else {
          return Stack(
            children: [
              landingBackground(),
              Column(
                children: [
                  CustomAppBar(
                    context: context,
                    titleText1: state.responseFarmerProjectDetail!.data!
                                .farmerProject !=
                            null
                        ? state.responseFarmerProjectDetail!.data!
                                .farmerProject![0].name ??
                            ''
                        : '',
                    // titleText1: state.responseFarmerProjectDetail!.data!.farmerProject![0].name ?? '',
                    leading: arrowBackButton(),
                    centerTitle: true,
                    titleText1Style: figtreeMedium.copyWith(
                        fontSize: 20, color: Colors.black),
                  ),
                  Expanded(
                    child: SingleChildScrollView(
                      child: Padding(
                        padding: const EdgeInsets.fromLTRB(22, 20, 22, 0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            description(state),
                            30.verticalSpace(),
                            state.responseFarmerProjectDetail!.data!
                                        .farmerProject![0].farmerMaster !=
                                    null
                                ? farmerDetail(
                                    context,
                                    state.responseFarmerProjectDetail!.data!
                                        .farmerProject![0].farmerMaster!,
                                    state)
                                : const SizedBox.shrink(),
                            20.verticalSpace(),
                            if (state.responseFarmerProjectDetail!.data!
                                    .supplierDetail !=
                                null)
                              supplier(context, state),
                            state.responseFarmerProjectDetail!.data!
                                        .farmerProject![0].kpi !=
                                    null
                                ? kpi(context, state)
                                : const SizedBox.shrink(),
                            if(state.responseFarmerProjectDetail!.data!
                                .farmerProject![0].category.toString() == "6")
                              livestockList(context, state)
                            else
                            state.responseFarmerProjectDetail!.data!
                                            .farmerProject![0].projectStatus ==
                                        'active' ||
                                    state.responseFarmerProjectDetail!.data!
                                            .farmerProject![0].projectStatus ==
                                        'hold'
                                ? activeProjectMilestones(context, state)
                                : projectMilestones(context, state),
                            InkWell(
                                onTap: () {
                                  const TrackProgress().navigate();
                                },
                                child: Center(
                                  child: 'View Timeline'.textSemiBold(
                                      fontSize: 16,
                                      color: ColorResources.maroon,
                                      underLine: TextDecoration.underline),
                                )),

                            20.verticalSpace(),

                            state.responseFarmerProjectDetail!.data!
                                        .farmerProject![0].projectStatus !=
                                    null
                                ? state.responseFarmerProjectDetail!.data!
                                            .farmerProject![0].projectStatus
                                            .toString()
                                            .capitalized() ==
                                        "suggested".capitalized()
                                    ? Center(
                                        child: customButton(
                                          'Farmer Feedback',
                                          style: figtreeMedium.copyWith(
                                              fontSize: 16,
                                              color: Colors.white),
                                          onTap: () {
                                            AddRemark(
                                                    projectData: state
                                                        .responseFarmerProjectDetail!
                                                        .data!
                                                        .farmerProject![0]
                                                        .farmerMaster!,
                                                    farmerProjectId:
                                                        widget.projectId)
                                                .navigate();
                                          },
                                        ),
                                      )
                                    : const SizedBox.shrink()
                                : const SizedBox.shrink(),

                            state.responseFarmerProjectDetail!.data!
                                        .farmerProject![0].projectStatus !=
                                    null
                                ? state.responseFarmerProjectDetail!.data!
                                            .farmerProject![0].projectStatus
                                            .toString()
                                            .capitalized() ==
                                        "not_interested".capitalized()
                                    ? Center(
                                        child: customButton(
                                          'Farmer Feedback',
                                          style: figtreeMedium.copyWith(
                                              fontSize: 16,
                                              color: Colors.white),
                                          onTap: () {
                                            AddRemark(
                                                    projectData: state
                                                        .responseFarmerProjectDetail!
                                                        .data!
                                                        .farmerProject![0]
                                                        .farmerMaster!,
                                                    farmerProjectId:
                                                        widget.projectId)
                                                .navigate();
                                          },
                                        ),
                                      )
                                    : const SizedBox.shrink()
                                : const SizedBox.shrink(),

                            state.responseFarmerProjectDetail!.data!
                                        .farmerProject![0].rejectStatus ==
                                    1
                                ? Padding(
                                    padding:
                                        const EdgeInsets.only(bottom: 15.0),
                                    child: customProjectContainer(
                                      marginLeft: 0,
                                      marginTop: 0,
                                      borderRadius: 14,
                                      child: Padding(
                                        padding: const EdgeInsets.all(10),
                                        child: Row(
                                          children: [
                                            Text(
                                              "Rejection Remarks:-  ",
                                              style: figtreeMedium.copyWith(
                                                  color: Colors.red),
                                            ),
                                            Expanded(
                                              child: Text(
                                                state
                                                        .responseFarmerProjectDetail!
                                                        .data!
                                                        .farmerProject![0]
                                                        .rejectRemark ??
                                                    '',
                                                style: figtreeMedium.copyWith(
                                                    color: Colors.black),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  )
                                : const SizedBox.shrink(),

                            state.responseFarmerProjectDetail!.data!
                                        .farmerProject![0].projectStatus !=
                                    null
                                ? state.responseFarmerProjectDetail!.data!
                                            .farmerProject![0].projectStatus
                                            .toString()
                                            .toUpperCase() ==
                                        "interested".toUpperCase()
                                    ? Center(
                                        child: customButton(
                                            state
                                                        .responseFarmerProjectDetail!
                                                        .data!
                                                        .farmerProject![0]
                                                        .rejectStatus ==
                                                    0
                                                ? "Apply for Loan"
                                                : 'View Document',
                                            // state.responseFarmerProjectDetail!.data!.farmerProject![0].farmerProjectKycDocument!=null?state.responseFarmerProjectDetail!.data!.farmerProject![0].rejectStatus == 1?"Apply for Loan":'View Document':'Apply for Loan',
                                            style: figtreeMedium.copyWith(
                                                fontSize: 16,
                                                color: Colors.white),
                                            onTap: () {
                                              if(state
                                                  .responseFarmerProjectDetail!
                                                  .data!
                                                  .farmerProject![0].farmerMaster!.farmerDocuments!=null){

                                          if (state
                                                  .responseFarmerProjectDetail!
                                                  .data!
                                                  .farmerProject![0]
                                                  .farmerProjectKycDocument ==
                                              null) {
                                            ProjectKYC(
                                                    farmerId: state
                                                        .responseFarmerProjectDetail!
                                                        .data!
                                                        .farmerProject![0]
                                                        .farmerMaster!
                                                        .id!,
                                                    userId: state
                                                        .responseFarmerProjectDetail!
                                                        .data!
                                                        .farmerProject![0]
                                                        .farmerMaster!
                                                        .userId
                                                        .toString(),
                                                    farmerMaster: state
                                                        .responseFarmerProjectDetail!
                                                        .data!
                                                        .farmerProject![0]
                                                        .farmerMaster!,
                                                    farmerProjectId: state
                                                        .responseFarmerProjectDetail!
                                                        .data!
                                                        .farmerProject![0]
                                                        .id
                                                        .toString())
                                                .navigate();
                                          } else {
                                            ViewLoanKyc(
                                                    farmerDocuments: state
                                                        .responseFarmerProjectDetail!
                                                        .data!
                                                        .farmerProject![0]
                                                        .farmerProjectKycDocument!,
                                                    rejectStatus: state
                                                        .responseFarmerProjectDetail!
                                                        .data!
                                                        .farmerProject![0]
                                                        .rejectStatus,
                                                    farmerId: state
                                                        .responseFarmerProjectDetail!
                                                        .data!
                                                        .farmerProject![0]
                                                        .farmerMaster!
                                                        .id!,
                                                    farmerMaster: state
                                                        .responseFarmerProjectDetail!
                                                        .data!
                                                        .farmerProject![0]
                                                        .farmerMaster!,
                                                    farmerProjectId: state
                                                        .responseFarmerProjectDetail!
                                                        .data!
                                                        .farmerProject![0]
                                                        .id
                                                        .toString())
                                                .navigate();
                                          }
                                        }else{
                                                showCustomToast(context, "You cannot apply for loan until Farmer KYC is approved");
                                              }
                                            }),
                                      )
                                    : const SizedBox.shrink()
                                : const SizedBox.shrink(),

                            state.responseFarmerProjectDetail!.data!
                                        .farmerProject![0].projectStatus !=
                                    null
                                ? state.responseFarmerProjectDetail!.data!
                                            .farmerProject![0].projectStatus
                                            .toString()
                                            .toUpperCase() ==
                                        "survey_completed".toUpperCase()
                                    ? Center(
                                        child: customButton('Confirm The Loan',
                                            // state.responseFarmerProjectDetail!.data!.farmerProject![0].farmerProjectKycDocument!=null?state.responseFarmerProjectDetail!.data!.farmerProject![0].rejectStatus == 1?"Apply for Loan":'View Document':'Apply for Loan',
                                            style: figtreeMedium.copyWith(
                                                fontSize: 16,
                                                color: Colors.white),
                                            onTap: () {
                                          AddRemarkConfirmLoan(
                                                  projectData: state
                                                      .responseFarmerProjectDetail!
                                                      .data!
                                                      .farmerProject![0]
                                                      .farmerMaster!,
                                                  farmerProjectId:
                                                      widget.projectId)
                                              .navigate();
                                        }),
                                      )
                                    : const SizedBox.shrink()
                                : const SizedBox.shrink(),

                            state.responseFarmerProjectDetail!.data!.farmerProject![0].projectStatus!=null?
                            state.responseFarmerProjectDetail!.data!.farmerProject![0].projectStatus.toString().toUpperCase() == "approved".toUpperCase() ?
                            Column(
                              children: [
                                customProjectContainer(
                                    marginLeft: 0,
                                    marginTop: 0,
                                    borderRadius: 14,
                                    child: Padding(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 8.0, vertical: 12),
                                      child: Column(
                                        children: [
                                          Padding(
                                            padding: const EdgeInsets.symmetric(
                                                horizontal: 8.0),
                                            child: Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: [
                                                Text(
                                                  'Loan Document',
                                                  style: figtreeMedium.copyWith(
                                                      fontSize: 18),
                                                ),
                                                InkWell(onTap: (){
                                                  setState(() {
                                                    if(paymentTerms == false){
                                                      paymentTerms = true;
                                                    }else{
                                                      paymentTerms = false;
                                                    }
                                                  });
                                                },child: paymentTerms == false?Container(width: 30,height: 30,
                                                    decoration: BoxDecoration(
                                                        borderRadius: BorderRadius.circular(4),
                                                        border: Border.all(color: const Color(0xffDCDCDC),width: 1)
                                                    ),child: const Center(child: Icon(Icons.keyboard_arrow_down_sharp,size: 22,))) :SvgPicture.asset(Images.drop))
                                              ],
                                            ),
                                          ),
                                          paymentTerms?
                                          customList(
                                              list: state
                                                  .responseFarmerProjectDetail!
                                                  .data!
                                                  .farmerProject![0]
                                                  .farmerLoanDocument!,
                                              child: (index) {
                                                return InkWell(
                                                  onTap: () async {
                                                    print(state
                                                        .responseFarmerProjectDetail!
                                                        .data!
                                                        .farmerProject![0]
                                                        .farmerLoanDocument![
                                                            index]
                                                        .loanDocumentFile![0]
                                                        .mimeType
                                                        .toString());
                                                    if (!state
                                                            .responseFarmerProjectDetail!
                                                            .data!
                                                            .farmerProject![0]
                                                            .farmerLoanDocument![
                                                                index]
                                                            .loanDocumentFile![
                                                                0].originalUrl!.endsWith('pdf')) {
                                                      PreviewScreen(
                                                              previewImage: state
                                                                      .responseFarmerProjectDetail!
                                                                      .data!
                                                                      .farmerProject![
                                                                          0]
                                                                      .farmerLoanDocument![
                                                                          index]
                                                                      .loanDocumentFile![
                                                                          0]
                                                                      .fullUrl ??
                                                                  '')
                                                          .navigate();
                                                    } else {
                                                      var dir =
                                                          await getApplicationDocumentsDirectory();
                                                      await Permission
                                                          .manageExternalStorage
                                                          .request();
                                                      await Dio().download(
                                                          state
                                                              .responseFarmerProjectDetail!
                                                              .data!
                                                              .farmerProject![0]
                                                              .farmerLoanDocument![
                                                                  index]
                                                              .loanDocumentFile![
                                                                  0]
                                                              .fullUrl
                                                              .toString(),
                                                          "${"${dir.path}/fileName"}.pdf");
                                                      await OpenFileSafePlus.open(
                                                          "${"${dir.path}/fileName"}.pdf");
                                                    }
                                                  },
                                                  child: Container(
                                                    margin:
                                                        const EdgeInsets.only(
                                                            top: 10),
                                                    padding: const EdgeInsets
                                                        .symmetric(
                                                        vertical: 8,
                                                        horizontal: 14),
                                                    decoration: BoxDecoration(
                                                        color: const Color(
                                                            0xFFE4FFE3),
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(10)),
                                                    child: Row(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .spaceBetween,
                                                      children: [
                                                        const Icon(
                                                          Icons.file_copy,
                                                          size: 22,
                                                          color: Colors.grey,
                                                        ),
                                                        5.horizontalSpace(),
                                                        Expanded(
                                                          child: Column(
                                                            crossAxisAlignment:
                                                                CrossAxisAlignment
                                                                    .start,
                                                            children: [
                                                              Text(
                                                                state
                                                                        .responseFarmerProjectDetail!
                                                                        .data!
                                                                        .farmerProject![
                                                                            0]
                                                                        .farmerLoanDocument![
                                                                            index]
                                                                        .documentName ??
                                                                    "",
                                                                style: figtreeMedium
                                                                    .copyWith(
                                                                        fontSize:
                                                                            16),
                                                              ),
                                                              5.verticalSpace(),
                                                              Text(
                                                                DateFormat('dd MMM, yyyy').format(DateTime.parse(state
                                                                    .responseFarmerProjectDetail!
                                                                    .data!
                                                                    .farmerProject![
                                                                        0]
                                                                    .farmerLoanDocument![
                                                                        index]
                                                                    .createdAt
                                                                    .toString())),
                                                                style: figtreeMedium
                                                                    .copyWith(
                                                                        fontSize:
                                                                            12),
                                                              ),
                                                            ],
                                                          ),
                                                        ),
                                                        InkWell(
                                                          onTap: () async {
                                                            if (!state
                                                                    .responseFarmerProjectDetail!
                                                                    .data!
                                                                    .farmerProject![
                                                                        0]
                                                                    .farmerLoanDocument![
                                                                        index]
                                                                    .loanDocumentFile![
                                                                        0]
                                                                .originalUrl!.endsWith('pdf')) {
                                                              var dir =
                                                                  await getApplicationDocumentsDirectory();
                                                              await Permission
                                                                  .manageExternalStorage
                                                                  .request();
                                                              await Dio().download(
                                                                  state
                                                                      .responseFarmerProjectDetail!
                                                                      .data!
                                                                      .farmerProject![
                                                                          0]
                                                                      .farmerLoanDocument![
                                                                          index]
                                                                      .loanDocumentFile![
                                                                          0]
                                                                      .fullUrl
                                                                      .toString(),
                                                                  "${"${dir.path}/image"}.png");
                                                              await OpenFileSafePlus
                                                                  .open(
                                                                      "${"${dir.path}/image"}.png");
                                                            } else {
                                                              var dir =
                                                                  await getApplicationDocumentsDirectory();
                                                              await Permission
                                                                  .manageExternalStorage
                                                                  .request();
                                                              await Dio().download(
                                                                  state
                                                                      .responseFarmerProjectDetail!
                                                                      .data!
                                                                      .farmerProject![
                                                                          0]
                                                                      .farmerLoanDocument![
                                                                          index]
                                                                      .loanDocumentFile![
                                                                          0]
                                                                      .fullUrl
                                                                      .toString(),
                                                                  "${"${dir.path}/fileName"}.pdf");
                                                              await OpenFileSafePlus
                                                                  .open(
                                                                      "${"${dir.path}/fileName"}.pdf");
                                                            }
                                                          },
                                                          child: Container(
                                                            padding:
                                                                const EdgeInsets
                                                                    .symmetric(
                                                                    horizontal:
                                                                        20,
                                                                    vertical:
                                                                        8),
                                                            decoration: BoxDecoration(
                                                                color: Colors
                                                                    .white,
                                                                borderRadius:
                                                                    BorderRadius
                                                                        .circular(
                                                                            30),
                                                                border: Border.all(
                                                                    color: Colors
                                                                        .grey)),
                                                            child: Text(
                                                              'Download',
                                                              style: figtreeMedium
                                                                  .copyWith(
                                                                      fontSize:
                                                                          12),
                                                            ),
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                );
                                              }):const SizedBox.shrink()
                                        ],
                                      ),
                                    )),
                                20.verticalSpace(),
                                Center(
                                    child: Text(
                                  'Tap below to read and agree to the terms and \nconditions of the loan agreement!',
                                  textAlign: TextAlign.center,
                                  style: figtreeMedium.copyWith(
                                      fontSize: 14, color: Colors.black),
                                )),
                                10.verticalSpace(),
                                Center(
                                  child: SizedBox(
                                    width: 230,
                                    child: customButton('Terms and Conditions',
                                        style: figtreeMedium.copyWith(
                                            fontSize: 16,
                                            color: Colors.white), onTap: () {
                                      TermsAndCondition(
                                              projectData: state
                                                  .responseFarmerProjectDetail!
                                                  .data!
                                                  .farmerProject![0]
                                                  .farmerMaster!,
                                              farmerProjectId: widget.projectId,
                                              navigateFrom: context
                                                  .read<ProjectCubit>()
                                                  .sharedPreferences
                                                  .getString(
                                                      AppConstants.userType)!)
                                          .navigate();
                                    }),
                                  ),
                                ),
                              ],
                            )
                            :const SizedBox.shrink():const SizedBox.shrink(),

                            state.responseFarmerProjectDetail!.data!
                                        .farmerProject![0].projectStatus !=
                                    null
                                ? state.responseFarmerProjectDetail!.data!
                                                .farmerProject![0].projectStatus
                                                .toString()
                                                .toUpperCase() ==
                                            "applied".toUpperCase() ||
                                        state.responseFarmerProjectDetail!.data!
                                                .farmerProject![0].projectStatus
                                                .toString()
                                                .toUpperCase() ==
                                            "doc_verified".toUpperCase() ||
                                        state.responseFarmerProjectDetail!.data!
                                                .farmerProject![0].projectStatus
                                                .toString()
                                                .toUpperCase() ==
                                            "survey_requested".toUpperCase() ||
                                        state.responseFarmerProjectDetail!.data!
                                                .farmerProject![0].projectStatus
                                                .toString()
                                                .toUpperCase() ==
                                            "survey_accepted".toUpperCase() ||
                                        state.responseFarmerProjectDetail!.data!
                                                .farmerProject![0].projectStatus
                                                .toString()
                                                .toUpperCase() ==
                                            "survey_completed".toUpperCase() ||
                                        state.responseFarmerProjectDetail!.data!
                                                .farmerProject![0].projectStatus
                                                .toString()
                                                .toUpperCase() ==
                                            "verified".toUpperCase() ||
                                        state.responseFarmerProjectDetail!.data!
                                                .farmerProject![0].projectStatus
                                                .toString()
                                                .toUpperCase() ==
                                            "approved".toUpperCase()
                                    ? Column(
                                        children: [
                                          20.verticalSpace(),
                                          Center(
                                            child: customButton('Revoke',
                                                color: 0xffFC5E60,
                                                style: figtreeMedium.copyWith(
                                                    fontSize: 16,
                                                    color: Colors.white),
                                                onTap: () {
                                              AddRemarkRevoke(
                                                      projectData: state
                                                          .responseFarmerProjectDetail!
                                                          .data!
                                                          .farmerProject![0]
                                                          .farmerMaster!,
                                                      farmerProjectId:
                                                          widget.projectId)
                                                  .navigate();
                                            }),
                                          ),
                                          5.verticalSpace(),
                                          "Tap above to revoke the loan application."
                                              .textMedium(
                                                  color:
                                                      const Color(0xff727272)),
                                        ],
                                      )
                                    : const SizedBox.shrink()
                                : const SizedBox.shrink(),

                            state.responseFarmerProjectDetail!.data!
                                        .farmerProject![0].projectStatus !=
                                    null
                                ? state.responseFarmerProjectDetail!.data!
                                            .farmerProject![0].projectStatus
                                            .toString()
                                            .toUpperCase() ==
                                        "active".toUpperCase()
                                    ? Column(
                                        children: [
                                          40.verticalSpace(),
                                          Center(
                                            child: customButton("Raise dispute",
                                                fontColor: 0xffffffff,
                                                color: 0xFFFC5E60,
                                                width: screenWidth(),
                                                height: 60, onTap: () {
                                              AddRemarkDisputeScreen(
                                                      project: state
                                                          .responseFarmerProjectDetail!
                                                          .data!
                                                          .farmerProject![0],
                                                      farmerProjectId: state
                                                          .responseFarmerProjectDetail!
                                                          .data!
                                                          .farmerProject![0]
                                                          .id)
                                                  .navigate();
                                            }),
                                          ),
                                          10.verticalSpace(),
                                          Padding(
                                            padding: const EdgeInsets.symmetric(
                                                horizontal: 35.0),
                                            child: Text(
                                              'Tap above to raise dispute on this project. Glad legal department will look into it.',
                                              style: figtreeRegular.copyWith(
                                                  fontSize: 10,
                                                  color:
                                                      ColorResources.fieldGrey),
                                              textAlign: TextAlign.center,
                                            ),
                                          ),
                                          40.verticalSpace(),
                                        ],
                                      )
                                    : const SizedBox.shrink()
                                : const SizedBox.shrink(),

                            30.verticalSpace(),
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
                    onTap: () async {
                      FirebaseFirestore.instance
                          .collection('projects_chats')
                          .doc(widget.projectId.toString())
                          .set({
                        'farmer_project_id': state.responseFarmerProjectDetail!
                            .data!.farmerProject![0].id
                            .toString(),
                        'farmer_id': state.responseFarmerProjectDetail!.data!
                            .farmerProject![0].farmerMaster!.id
                            .toString(),
                        'dde_id': state.responseFarmerProjectDetail!.data!
                            .farmerProject![0].farmerMaster!.ddeId
                            .toString(),
                        'supplier_id': state.responseFarmerProjectDetail!.data!
                                    .supplierDetail !=
                                null
                            ? state.responseFarmerProjectDetail!.data!
                                .supplierDetail!.id
                                .toString()
                            : "",
                        'mcc_id': state.responseFarmerProjectDetail!.data!
                            .farmerProject![0].farmerMaster!.mccId
                            .toString(),
                        'admin_id': '',
                        'project_name': state.responseFarmerProjectDetail!.data!
                            .farmerProject![0].name
                            .toString(),
                        'created_at': Timestamp.now(),
                        'farmer_name': state.responseFarmerProjectDetail!.data!
                            .farmerProject![0].farmerMaster!.name
                            .toString(),
                        'farmer_address': state
                                    .responseFarmerProjectDetail!
                                    .data!
                                    .farmerProject![0]
                                    .farmerMaster!
                                    .address !=
                                null
                            ? state
                                        .responseFarmerProjectDetail!
                                        .data!
                                        .farmerProject![0]
                                        .farmerMaster!
                                        .address!
                                        .address !=
                                    null
                                ? state
                                    .responseFarmerProjectDetail!
                                    .data!
                                    .farmerProject![0]
                                    .farmerMaster!
                                    .address!
                                    .address!
                                    .toString()
                                : ''
                            : '',
                        // 'user_type': 'dde',
                      });

                      ResponseProjectDataForFirebase response = ResponseProjectDataForFirebase(
                          projectName: state.responseFarmerProjectDetail!.data!
                              .farmerProject![0].name!
                              .toString(),
                          farmerProjectId: state.responseFarmerProjectDetail!
                              .data!.farmerProject![0].id,
                          userName: await SharedPrefManager.getPreferenceString(
                              AppConstants.userName),
                          userType: 'dde',
                          farmerId: state.responseFarmerProjectDetail!.data!
                              .farmerProject![0].farmerMaster!.id
                              .toString(),
                          ddeId: state.responseFarmerProjectDetail!.data!.farmerProject != null
                              ? state.responseFarmerProjectDetail!.data!
                                  .farmerProject![0].ddeId
                                  .toString()
                              : '',
                          mccId: state.responseFarmerProjectDetail!.data!.farmerProject![0].farmerMaster != null
                              ? state.responseFarmerProjectDetail!.data!.farmerProject![0].farmerMaster!.mccId.toString()
                              : '',
                          supplierId: state.responseFarmerProjectDetail!.data!.supplierDetail != null ? state.responseFarmerProjectDetail!.data!.supplierDetail!.id.toString() : '',
                          farmerName: state.responseFarmerProjectDetail!.data!.farmerProject![0].farmerMaster!.name.toString(),
                          farmerAddress: state.responseFarmerProjectDetail!.data!.farmerProject![0].farmerMaster!.address != null ? state.responseFarmerProjectDetail!.data!.farmerProject![0].farmerMaster!.address!.address.toString() : '');

                      FirebaseChatScreen(
                        responseProjectDataForFirebase: response,
                      ).navigate();
                    },
                    child: Image.asset(
                      Images.messageChat,
                      width: 100,
                      height: 100,
                    ),
                  ))
            ],
          );
        }
      }),
    );
  }

///////DescriptionDetails///////////
  Widget description(ProjectState state) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                Text(
                  'Description',
                  style: figtreeMedium.copyWith(fontSize: 18),
                ),
                05.horizontalSpace(),
                Container(
                  padding:
                      const EdgeInsets.symmetric(vertical: 4, horizontal: 7),
                  decoration: boxDecoration(
                    borderWidth: 1,
                    borderRadius: 30,
                    borderColor: const Color(0xff6A0030),
                  ),
                  child: Text(
                    formatProjectStatus(state.responseFarmerProjectDetail!.data!
                            .farmerProject![0].projectStatus ??
                        ''),
                    textAlign: TextAlign.center,
                    style: figtreeMedium.copyWith(
                        color: const Color(0xff6A0030), fontSize: 10),
                  ),
                )
              ],
            ),

            if(state.responseFarmerProjectDetail!.data!.farmerProject![0]
                .category.toString() == "6")
              const SizedBox.shrink()
            else
              if(state.responseFarmerProjectDetail!.data!.farmerProject![0].paymentStatus == null ||state.responseFarmerProjectDetail!.data!.farmerProject![0].paymentStatus == "paid")
                SvgPicture.asset(Images.paid)
            else
            if (state.responseFarmerProjectDetail!.data!.farmerProject![0]
                        .projectStatus ==
                    'active' ||
                state.responseFarmerProjectDetail!.data!.farmerProject![0]
                        .projectStatus ==
                    'hold' ||
                state.responseFarmerProjectDetail!.data!.farmerProject![0]
                        .projectStatus ==
                    'completed')
              Builder(builder: (context) {
                int count = 0;
                for (FarmerProjectMilestones mile in state
                    .responseFarmerProjectDetail!
                    .data!
                    .farmerProject![0]
                    .farmerProjectMilestones!) {
                  if (mile.milestoneStatus != "pending") {
                    count++;
                  }
                }
                return Stack(
                  alignment: Alignment.center,
                  children: [
                    CircularPercentIndicator(
                      radius: 30,
                      percent: count /
                          state
                              .responseFarmerProjectDetail!
                              .data!
                              .farmerProject![0]
                              .farmerProjectMilestones!
                              .length,
                      progressColor: const Color(0xFF12CE57),
                      backgroundColor: const Color(0xFFDCEAE5),
                    ),
                    RichText(
                      softWrap: false,
                      text: TextSpan(children: [
                        TextSpan(
                            text: removeZeroesInFraction(((count /
                                        state
                                            .responseFarmerProjectDetail!
                                            .data!
                                            .farmerProject![0]
                                            .farmerProjectMilestones!
                                            .length) *
                                    100)
                                .toString()),
                            style: figtreeBold.copyWith(
                                color: Colors.black, fontSize: 16)),
                        TextSpan(
                            text: '%\n',
                            style: figtreeBold.copyWith(
                                color: Colors.black, fontSize: 9)),
                        TextSpan(
                            text: 'completed',
                            style: figtreeBold.copyWith(
                                color: const Color(0xFF808080), fontSize: 6))
                      ]),
                      textAlign: TextAlign.center,
                    )
                  ],
                );
              })
            else if (state.responseFarmerProjectDetail!.data!.farmerProject![0]
                    .projectStatus ==
                "completed")
              SvgPicture.asset(Images.paid)
          ],
        ),
        10.verticalSpace(),
        ExpandableText(
          state.responseFarmerProjectDetail!.data!.farmerProject![0]
                  .description ??
              '',
          expandText: 'Read More',
          linkColor: ColorResources.maroon,
          style: figtreeMedium.copyWith(fontSize: 14),
          collapseText: 'Show Less',
        )
      ],
    );
  }

  ///////////SupplierContainerTimeline/////////////
  Widget supplier(contexts, ProjectState state) {
    return state.responseFarmerProjectDetail!.data!.farmerProject![0]
                .projectStatus ==
            "completed"
        ? Stack(
            alignment: Alignment.center,
            children: [
              SizedBox(
                  height: state.responseFarmerProjectDetail!.data!
                              .ddeRatingForSupplier ==
                          null
                      ? state.responseFarmerProjectDetail!.data!
                                      .ddeRatingForSupplier !=
                                  null &&
                              state.responseFarmerProjectDetail!.data!
                                      .supplierRatingForDde ==
                                  null
                          ? 170
                          : 200
                      : 242,
                  width: screenWidth()),
              Container(
                height: state.responseFarmerProjectDetail!.data!
                            .ddeRatingForSupplier ==
                        null
                    ? state.responseFarmerProjectDetail!.data!
                                    .ddeRatingForSupplier !=
                                null &&
                            state.responseFarmerProjectDetail!.data!
                                    .supplierRatingForDde ==
                                null
                        ? 110
                        : 138
                    : 178,
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
                          CircleAvatar(
                              radius: 30,
                              child: CachedNetworkImage(
                                imageUrl: state.responseFarmerProjectDetail!
                                            .data!.supplierDetail!.photo
                                            .toString() ==
                                        false.toString()
                                    ? ''
                                    : state.responseFarmerProjectDetail!.data!
                                            .supplierDetail!.photo ??
                                        '',
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
                          15.horizontalSpace(),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                  state.responseFarmerProjectDetail!.data!
                                          .supplierDetail!.name ??
                                      '',
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
                                  Text(
                                      state.responseFarmerProjectDetail!.data!
                                              .supplierDetail!.phone ??
                                          '',
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
                                    width:
                                        MediaQuery.of(context).size.width * 0.5,
                                    child: Text(
                                      state.responseFarmerProjectDetail!.data!
                                                  .supplierDetail!.address !=
                                              null
                                          ? state
                                                          .responseFarmerProjectDetail!
                                                          .data!
                                                          .supplierDetail!
                                                          .address["address"] !=
                                                      null &&
                                                  state
                                                              .responseFarmerProjectDetail!
                                                              .data!
                                                              .supplierDetail!
                                                              .address[
                                                          "sub_county"] !=
                                                      null
                                              ? state
                                                      .responseFarmerProjectDetail!
                                                      .data!
                                                      .supplierDetail!
                                                      .address["sub_county"] +
                                                  state
                                                      .responseFarmerProjectDetail!
                                                      .data!
                                                      .supplierDetail!
                                                      .address["address"]
                                              : ''
                                          : '',
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
                      if (state.responseFarmerProjectDetail!.data!
                              .ddeRatingForSupplier ==
                          null)
                        Column(
                          children: [
                            17.verticalSpace(),
                            InkWell(
                              onTap: () {
                                TextEditingController controller =
                                    TextEditingController();
                                double rating = 1;
                                modalBottomSheetMenu(context, radius: 40, child:
                                    StatefulBuilder(
                                        builder: (context, setState) {
                                  return SizedBox(
                                    height: 450,
                                    child: Padding(
                                      padding: const EdgeInsets.fromLTRB(
                                          23, 40, 25, 10),
                                      child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Center(
                                              child: Text(
                                                'Give your feedback',
                                                style: figtreeMedium.copyWith(
                                                    fontSize: 22),
                                              ),
                                            ),
                                            30.verticalSpace(),
                                            Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.center,
                                              mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                              children: [
                                                Padding(
                                                  padding:
                                                      const EdgeInsets.only(
                                                          right: 10.0),
                                                  child: RatingBar.builder(
                                                    initialRating: 1,
                                                    minRating: 0,
                                                    itemSize: 40,
                                                    direction: Axis.horizontal,
                                                    allowHalfRating: false,
                                                    itemCount: 5,
                                                    itemPadding:
                                                        const EdgeInsets
                                                            .symmetric(
                                                            horizontal: 0.0,
                                                            vertical: 0),
                                                    itemBuilder: (context, _) =>
                                                        const Icon(
                                                      Icons.star,
                                                      color: Color(0xffFFAA00),
                                                    ),
                                                    onRatingUpdate: (ratings) {
                                                      rating = ratings;
                                                      // print(ratings);
                                                      // onRatingUpdate!(ratings);
                                                      // rating = ratings.toString();
                                                    },
                                                  ),
                                                ),
                                                20.verticalSpace(),
                                                Align(
                                                  alignment:
                                                      Alignment.centerLeft,
                                                  child: Text(
                                                    'Tell us more',
                                                    style: figtreeMedium
                                                        .copyWith(fontSize: 15),
                                                  ),
                                                ),
                                                5.verticalSpace(),
                                                TextField(
                                                  controller: controller,
                                                  maxLines: 4,
                                                  minLines: 4,
                                                  decoration: InputDecoration(
                                                      hintText: 'Write...',
                                                      hintStyle: figtreeMedium
                                                          .copyWith(
                                                              fontSize: 18),
                                                      border:
                                                          OutlineInputBorder(
                                                              borderRadius:
                                                                  BorderRadius
                                                                      .circular(
                                                                          12),
                                                              borderSide:
                                                                  const BorderSide(
                                                                width: 1,
                                                                color: Color(
                                                                    0xff999999),
                                                              ))),
                                                ),
                                                30.verticalSpace(),
                                                Padding(
                                                  padding:
                                                      const EdgeInsets.fromLTRB(
                                                          28, 0, 29, 0),
                                                  child: customButton(
                                                    'Submit',
                                                    fontColor: 0xffFFFFFF,
                                                    onTap: () {
                                                      if (rating == 0) {
                                                        showCustomToast(context,
                                                            'Please give rating',
                                                            isSuccess: true);
                                                      } else if (controller
                                                          .text.isEmpty) {
                                                        showCustomToast(context,
                                                            'Please enter your feedback');
                                                      } else {
                                                        context
                                                            .read<
                                                                ProjectCubit>()
                                                            .projectRatingApi(
                                                                context,
                                                                widget.projectId
                                                                    .toString(),
                                                                'supplier',
                                                                state
                                                                    .responseFarmerProjectDetail!
                                                                    .data!
                                                                    .supplierDetail!
                                                                    .id
                                                                    .toString(),
                                                                rating
                                                                    .toString(),
                                                                controller.text
                                                                    .toString());
                                                      }
                                                    },
                                                    height: 60,
                                                    width: screenWidth(),
                                                  ),
                                                )
                                              ],
                                            )
                                          ]),
                                    ),
                                  );
                                }));
                              },
                              child: Container(
                                decoration: boxDecoration(
                                    borderRadius: 15,
                                    backgroundColor: const Color(0xffFFF3F4),
                                    borderColor: const Color(0xff6A0030)
                                    // c: const Color(0xff6A0030),
                                    ),
                                child: Padding(
                                  padding:
                                      const EdgeInsets.fromLTRB(8, 2, 8, 2),
                                  child: Text(
                                    'Give your feedback',
                                    style: figtreeSemiBold.copyWith(
                                        color: const Color(0xff000000),
                                        fontSize: 14),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        )
                      else if (state.responseFarmerProjectDetail!.data!
                                  .ddeRatingForSupplier !=
                              null &&
                          state.responseFarmerProjectDetail!.data!
                                  .supplierRatingForDde ==
                              null)
                        const SizedBox.shrink()
                      else
                        Container(
                          width: screenWidth(),
                          height: 80,
                          padding: const EdgeInsets.all(10),
                          margin: const EdgeInsets.only(right: 12, top: 5),
                          decoration: boxDecoration(
                            backgroundColor: const Color(0xffFFF3F4),
                            borderRadius: 10,
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  "Feedback for you:".toString().textMedium(
                                      color: Colors.black, fontSize: 14),
                                  Padding(
                                    padding: const EdgeInsets.only(right: 10.0),
                                    child: RatingBar.builder(
                                      initialRating: double.parse(state
                                                  .responseFarmerProjectDetail!
                                                  .data!
                                                  .supplierRatingForDde![0]
                                                  .rating !=
                                              null
                                          ? state
                                              .responseFarmerProjectDetail!
                                              .data!
                                              .supplierRatingForDde![0]
                                              .rating!
                                              .toString()
                                          : '0'),
                                      minRating: 0,
                                      itemSize: 20,
                                      direction: Axis.horizontal,
                                      allowHalfRating: false,
                                      itemCount: 5,
                                      ignoreGestures: true,
                                      itemPadding: const EdgeInsets.symmetric(
                                          horizontal: 0.0, vertical: 0),
                                      itemBuilder: (context, _) => const Icon(
                                        Icons.star,
                                        color: Color(0xffFFAA00),
                                      ),
                                      onRatingUpdate: (ratings) {
                                        // print(ratings);
                                        // onRatingUpdate!(ratings);
                                        // rating = ratings.toString();
                                      },
                                    ),
                                  ),
                                ],
                              ),
                              4.verticalSpace(),
                              state.responseFarmerProjectDetail!.data!
                                  .supplierRatingForDde![0].feedback
                                  .toString()
                                  .textRegular(
                                      fontSize: 12,
                                      maxLines: 2,
                                      overflow: TextOverflow.ellipsis)
                            ],
                          ),
                        )
                    ],
                  ),
                ),
              ),
              Positioned(
                  top: -1,
                  left: 0,
                  child: Text(
                    'Supplier',
                    style: figtreeMedium.copyWith(fontSize: 20),
                  )),
              Positioned(
                  top: 0,
                  right: 10,
                  child: Row(
                    children: [
                      InkWell(
                          onTap: () {
                            callOnMobile(state.responseFarmerProjectDetail!
                                    .data!.supplierDetail!.phone ??
                                '');
                          },
                          child: SvgPicture.asset(Images.callPrimary)),
                      6.horizontalSpace(),
                      InkWell(
                          onTap: () async {
                            await launchWhatsApp(state
                                    .responseFarmerProjectDetail!
                                    .data!
                                    .supplierDetail!
                                    .phone ??
                                '');
                          },
                          child: SvgPicture.asset(Images.whatsapp)),
                      6.horizontalSpace(),
                    ],
                  )),
            ],
          )
        : Stack(
            alignment: Alignment.center,
            children: [
              SizedBox(height: 150, width: screenWidth()),
              Container(
                height: 100,
                width: screenWidth(),
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(16),
                    border: Border.all(color: ColorResources.grey)),
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(15.0, 16, 0, 10),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      CircleAvatar(
                          radius: 30,
                          child: CachedNetworkImage(
                            imageUrl: state.responseFarmerProjectDetail!.data!
                                        .supplierDetail!.photo
                                        .toString() ==
                                    false.toString()
                                ? ''
                                : state.responseFarmerProjectDetail!.data!
                                        .supplierDetail!.photo ??
                                    '',
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
                      15.horizontalSpace(),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                              state.responseFarmerProjectDetail!.data!
                                      .supplierDetail!.name ??
                                  '',
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
                              Text(
                                  state.responseFarmerProjectDetail!.data!
                                          .supplierDetail!.phone ??
                                      '',
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
                                width: MediaQuery.of(context).size.width * 0.5,
                                child: Text(
                                  state.responseFarmerProjectDetail!.data!
                                              .supplierDetail!.address !=
                                          null
                                      ? state
                                                      .responseFarmerProjectDetail!
                                                      .data!
                                                      .supplierDetail!
                                                      .address["address"] !=
                                                  null &&
                                              state
                                                      .responseFarmerProjectDetail!
                                                      .data!
                                                      .supplierDetail!
                                                      .address["sub_county"] !=
                                                  null
                                          ? state
                                                  .responseFarmerProjectDetail!
                                                  .data!
                                                  .supplierDetail!
                                                  .address["sub_county"] +
                                              state
                                                  .responseFarmerProjectDetail!
                                                  .data!
                                                  .supplierDetail!
                                                  .address["address"]
                                          : ''
                                      : '',
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
                ),
              ),
              Positioned(
                  top: -1,
                  left: 0,
                  child: Text(
                    'Supplier',
                    style: figtreeMedium.copyWith(fontSize: 20),
                  )),
              Positioned(
                  top: 0,
                  right: 10,
                  child: Row(
                    children: [
                      InkWell(
                          onTap: () {
                            callOnMobile(state.responseFarmerProjectDetail!
                                    .data!.supplierDetail!.phone ??
                                '');
                          },
                          child: SvgPicture.asset(Images.callPrimary)),
                      6.horizontalSpace(),
                      InkWell(
                          onTap: () async {
                            await launchWhatsApp(state
                                    .responseFarmerProjectDetail!
                                    .data!
                                    .supplierDetail!
                                    .phone ??
                                '');
                          },
                          child: SvgPicture.asset(Images.whatsapp)),
                      6.horizontalSpace(),
                    ],
                  )),
            ],
          );
  }

///////////farmerDetail/////////////
  Widget farmerDetail(contexts, FarmerMaster farmerDetail, ProjectState state) {
    return state.responseFarmerProjectDetail!.data!.farmerProject![0]
                .projectStatus ==
            "completed"
        ? Stack(
            alignment: Alignment.center,
            children: [
              SizedBox(
                  // height: state.responseFarmerProjectDetail!.data!.ddeRatingForFarmer == null? 210,
                  height: state.responseFarmerProjectDetail!.data!
                              .ddeRatingForFarmer ==
                          null
                      ? 190
                      : state.responseFarmerProjectDetail!.data!
                                      .ddeRatingForFarmer !=
                                  null &&
                              state.responseFarmerProjectDetail!.data!
                                      .farmerRatingForDde ==
                                  null
                          ? 160
                          : 235,
                  width: screenWidth()),
              InkWell(
                onTap: () {
                  BlocProvider.of<LandingPageCubit>(context)
                      .getCurrentLocation();
                  BlocProvider.of<ProfileCubit>(context)
                      .emit(ProfileCubitState.initial());
                  DdeFarmerDetail(
                          userId: farmerDetail.userId!,
                          farmerId: farmerDetail.id!)
                      .navigate();
                },
                child: Container(
                  // height: 150,
                  height: state.responseFarmerProjectDetail!.data!
                              .ddeRatingForFarmer ==
                          null
                      ? 140
                      : state.responseFarmerProjectDetail!.data!
                                      .ddeRatingForFarmer !=
                                  null &&
                              state.responseFarmerProjectDetail!.data!
                                      .farmerRatingForDde ==
                                  null
                          ? 100
                          : 180,
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
                            farmerDetail.photo != null
                                ? CircleAvatar(
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
                                    ))
                                : CircleAvatar(
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
                                      child: Text(
                                        farmerDetail.address != null
                                            ? farmerDetail.address!.address !=
                                                    null
                                                ? farmerDetail.address!.address!
                                                    .toString()
                                                : ""
                                            : "",
                                        maxLines: 1,
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
                        if (state.responseFarmerProjectDetail!.data!
                                .ddeRatingForFarmer ==
                            null)
                          Column(
                            children: [
                              20.verticalSpace(),
                              InkWell(
                                onTap: () {
                                  TextEditingController controller =
                                      TextEditingController();
                                  double rating = 1;
                                  modalBottomSheetMenu(context, radius: 40,
                                      child: StatefulBuilder(
                                          builder: (context, setState) {
                                    return SizedBox(
                                      height: 450,
                                      child: Padding(
                                        padding: const EdgeInsets.fromLTRB(
                                            23, 40, 25, 10),
                                        child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Center(
                                                child: Text(
                                                  'Give your feedback',
                                                  style: figtreeMedium.copyWith(
                                                      fontSize: 22),
                                                ),
                                              ),
                                              30.verticalSpace(),
                                              Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.center,
                                                mainAxisAlignment:
                                                    MainAxisAlignment.center,
                                                children: [
                                                  Padding(
                                                    padding:
                                                        const EdgeInsets.only(
                                                            right: 10.0),
                                                    child: RatingBar.builder(
                                                      initialRating: 1,
                                                      minRating: 0,
                                                      itemSize: 40,
                                                      direction:
                                                          Axis.horizontal,
                                                      allowHalfRating: false,
                                                      itemCount: 5,
                                                      itemPadding:
                                                          const EdgeInsets
                                                              .symmetric(
                                                              horizontal: 0.0,
                                                              vertical: 0),
                                                      itemBuilder:
                                                          (context, _) =>
                                                              const Icon(
                                                        Icons.star,
                                                        color:
                                                            Color(0xffFFAA00),
                                                      ),
                                                      onRatingUpdate:
                                                          (ratings) {
                                                        rating = ratings;
                                                        // print(ratings);
                                                        // onRatingUpdate!(ratings);
                                                        // rating = ratings.toString();
                                                      },
                                                    ),
                                                  ),
                                                  20.verticalSpace(),
                                                  Align(
                                                    alignment:
                                                        Alignment.centerLeft,
                                                    child: Text(
                                                      'Tell us more',
                                                      style: figtreeMedium
                                                          .copyWith(
                                                              fontSize: 15),
                                                    ),
                                                  ),
                                                  5.verticalSpace(),
                                                  TextField(
                                                    controller: controller,
                                                    maxLines: 4,
                                                    minLines: 4,
                                                    decoration: InputDecoration(
                                                        hintText: 'Write...',
                                                        hintStyle: figtreeMedium
                                                            .copyWith(
                                                                fontSize: 18),
                                                        border:
                                                            OutlineInputBorder(
                                                                borderRadius:
                                                                    BorderRadius
                                                                        .circular(
                                                                            12),
                                                                borderSide:
                                                                    const BorderSide(
                                                                  width: 1,
                                                                  color: Color(
                                                                      0xff999999),
                                                                ))),
                                                  ),
                                                  30.verticalSpace(),
                                                  Padding(
                                                    padding: const EdgeInsets
                                                        .fromLTRB(28, 0, 29, 0),
                                                    child: customButton(
                                                      'Submit',
                                                      fontColor: 0xffFFFFFF,
                                                      onTap: () {
                                                        if (rating == 0) {
                                                          showCustomToast(
                                                              context,
                                                              'Please give rating',
                                                              isSuccess: true);
                                                        } else if (controller
                                                            .text.isEmpty) {
                                                          showCustomToast(
                                                              context,
                                                              'Please enter your feedback');
                                                        } else {
                                                          context
                                                              .read<
                                                                  ProjectCubit>()
                                                              .projectRatingApi(
                                                                  context,
                                                                  widget
                                                                      .projectId
                                                                      .toString(),
                                                                  'farmer',
                                                                  farmerDetail
                                                                      .id!
                                                                      .toString(),
                                                                  rating
                                                                      .toString(),
                                                                  controller
                                                                      .text
                                                                      .toString());
                                                        }
                                                      },
                                                      height: 60,
                                                      width: screenWidth(),
                                                    ),
                                                  )
                                                ],
                                              )
                                            ]),
                                      ),
                                    );
                                  }));
                                },
                                child: Container(
                                  decoration: boxDecoration(
                                      borderRadius: 15,
                                      backgroundColor: const Color(0xffFFF3F4),
                                      borderColor: const Color(0xff6A0030)
                                      // c: const Color(0xff6A0030),
                                      ),
                                  child: Padding(
                                    padding:
                                        const EdgeInsets.fromLTRB(8, 2, 8, 2),
                                    child: Text(
                                      'Give your feedback',
                                      style: figtreeSemiBold.copyWith(
                                          color: const Color(0xff000000),
                                          fontSize: 14),
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          )
                        else if (state.responseFarmerProjectDetail!.data!
                                    .ddeRatingForFarmer !=
                                null &&
                            state.responseFarmerProjectDetail!.data!
                                    .farmerRatingForDde ==
                                null)
                          const SizedBox.shrink()
                        else
                          Container(
                            width: screenWidth(),
                            height: 74,
                            padding: const EdgeInsets.all(10),
                            margin: const EdgeInsets.only(right: 12, top: 5),
                            decoration: boxDecoration(
                              backgroundColor: const Color(0xffFFF3F4),
                              borderRadius: 10,
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    "Feedback for you:".toString().textMedium(
                                        color: Colors.black, fontSize: 14),
                                    Padding(
                                      padding:
                                          const EdgeInsets.only(right: 10.0),
                                      child: RatingBar.builder(
                                        initialRating: double.parse(state
                                                    .responseFarmerProjectDetail!
                                                    .data!
                                                    .farmerRatingForDde![0]
                                                    .rating !=
                                                null
                                            ? state
                                                .responseFarmerProjectDetail!
                                                .data!
                                                .farmerRatingForDde![0]
                                                .rating!
                                                .toString()
                                            : '0'),
                                        minRating: 0,
                                        itemSize: 20,
                                        direction: Axis.horizontal,
                                        allowHalfRating: false,
                                        ignoreGestures: true,
                                        itemCount: 5,
                                        itemPadding: const EdgeInsets.symmetric(
                                            horizontal: 0.0, vertical: 0),
                                        itemBuilder: (context, _) => const Icon(
                                          Icons.star,
                                          color: Color(0xffFFAA00),
                                        ),
                                        onRatingUpdate: (ratings) {
                                          // print(ratings);
                                          // onRatingUpdate!(ratings);
                                          // rating = ratings.toString();
                                        },
                                      ),
                                    ),
                                  ],
                                ),
                                4.verticalSpace(),
                                state.responseFarmerProjectDetail!.data!
                                            .farmerRatingForDde![0].feedback !=
                                        null
                                    ? state.responseFarmerProjectDetail!.data!
                                        .farmerRatingForDde![0].feedback!
                                        .textRegular(
                                            fontSize: 12,
                                            maxLines: 2,
                                            overflow: TextOverflow.ellipsis)
                                    : const SizedBox.shrink()
                              ],
                            ),
                          ),
                        /* state.responseFarmerProjectDetail!.data!.farmerRatingForDde == null?
                  state.responseFarmerProjectDetail!.data!.ddeRatingForFarmer == null?
                  Column(
                  children: [
                    20.verticalSpace(),
                    InkWell(
                      onTap: (){
                        TextEditingController controller = TextEditingController();
                        double rating = 1;
                        modalBottomSheetMenu(context,
                            radius: 40,
                            child: StatefulBuilder(
                                builder: (context, setState) {
                                  return SizedBox(
                                    height: 450,
                                    child: Padding(
                                      padding: const EdgeInsets.fromLTRB(23, 40, 25, 10),
                                      child: Column(
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: [
                                            Center(
                                              child: Text(
                                                'Give your feedback',
                                                style: figtreeMedium.copyWith(fontSize: 22),
                                              ),
                                            ),
                                            30.verticalSpace(),
                                            Column(
                                              crossAxisAlignment: CrossAxisAlignment.center,
                                              mainAxisAlignment: MainAxisAlignment.center,
                                              children: [
                                                Padding(
                                                  padding: const EdgeInsets.only(right: 10.0),
                                                  child: RatingBar.builder(
                                                    initialRating: 1,
                                                    minRating: 0,
                                                    itemSize: 40,
                                                    direction: Axis.horizontal,
                                                    allowHalfRating: false,
                                                    itemCount: 5,
                                                    itemPadding: const EdgeInsets.symmetric(horizontal: 0.0,vertical: 0),
                                                    itemBuilder: (context, _) => const Icon(
                                                      Icons.star,
                                                      color: Color(0xffFFAA00),
                                                    ),
                                                    onRatingUpdate: (ratings) {
                                                      rating = ratings;
                                                      // print(ratings);
                                                      // onRatingUpdate!(ratings);
                                                      // rating = ratings.toString();
                                                    },
                                                  ),
                                                ),
                                                20.verticalSpace(),
                                                Align(
                                                  alignment: Alignment.centerLeft,
                                                  child: Text(
                                                    'Tell us more',
                                                    style: figtreeMedium.copyWith(fontSize: 15),
                                                  ),
                                                ),
                                                5.verticalSpace(),
                                                TextField(
                                                  controller: controller,
                                                  maxLines: 4,
                                                  minLines: 4,
                                                  decoration: InputDecoration(
                                                      hintText: 'Write...',
                                                      hintStyle:
                                                      figtreeMedium.copyWith(fontSize: 18),
                                                      border: OutlineInputBorder(
                                                          borderRadius: BorderRadius.circular(12),
                                                          borderSide: const BorderSide(
                                                            width: 1,
                                                            color: Color(0xff999999),
                                                          ))),
                                                ),
                                                30.verticalSpace(),
                                                Padding(
                                                  padding: const EdgeInsets.fromLTRB(28, 0, 29, 0),
                                                  child: customButton(
                                                    'Submit',
                                                    fontColor: 0xffFFFFFF,
                                                    onTap: () {
                                                      if(rating == 0){
                                                        showCustomToast(context, 'Please give rating',isSuccess: true);
                                                      }else if(controller.text.isEmpty){
                                                        showCustomToast(context, 'Please enter your feedback');
                                                      }else{
                                                        context.read<ProjectCubit>().projectRatingApi(context, widget.projectId.toString(),'farmer' ,farmerDetail.id!.toString() ,rating.toString() , controller.text.toString());
                                                      }
                                                    },
                                                    height: 60,
                                                    width: screenWidth(),
                                                  ),
                                                )
                                              ],
                                            )
                                          ]),
                                    ),
                                  );
                                }
                            ));
                      },
                      child: Container(
                        decoration: boxDecoration(
                            borderRadius: 15,
                            backgroundColor: const Color(0xffFFF3F4),
                            borderColor: const Color(0xff6A0030)
                          // c: const Color(0xff6A0030),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.fromLTRB(8, 2, 8, 2),
                          child: Text('Give your feedback',
                            style: figtreeSemiBold.copyWith(
                                color: const Color(0xff000000),
                                fontSize: 14
                            ),),
                        ),
                      ),
                    ),],
                  ):const SizedBox.shrink():
                  Container(
                    width: screenWidth(),
                    padding: const EdgeInsets.all(10),
                    margin: const EdgeInsets.only(right: 12,top: 5),
                    decoration: boxDecoration(
                      backgroundColor: const Color(0xffFFF3F4),
                      borderRadius: 10,
                    ),
                    child: Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            "Your feedback:".toString().textMedium(
                                color: Colors.black,
                                fontSize: 14
                            ),

                            Padding(
                              padding: const EdgeInsets.only(right: 10.0),
                              child: RatingBar.builder(
                                initialRating: 4,
                                minRating: 0,
                                itemSize: 20,
                                direction: Axis.horizontal,
                                allowHalfRating: false,
                                itemCount: 5,
                                itemPadding: const EdgeInsets.symmetric(horizontal: 0.0,vertical: 0),
                                itemBuilder: (context, _) => const Icon(
                                  Icons.star,
                                  color: Color(0xffFFAA00),
                                ),
                                onRatingUpdate: (ratings) {
                                  // print(ratings);
                                  // onRatingUpdate!(ratings);
                                  // rating = ratings.toString();
                                },
                              ),
                            ),

                          ],
                        ),
                        4.verticalSpace(),
                        "Many desktop publishing packages and web page editors...dd fd fd fd".textRegular(fontSize: 12,
                            maxLines: 2,overflow: TextOverflow.ellipsis)
                      ],
                    ),
                  )*/
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
                          onTap: () {
                            callOnMobile(farmerDetail.phone ?? '');
                          },
                          child: SvgPicture.asset(Images.callPrimary)),
                      6.horizontalSpace(),
                      InkWell(
                          onTap: () async {
                            await launchWhatsApp(farmerDetail.phone ?? '');
                          },
                          child: SvgPicture.asset(Images.whatsapp)),
                      6.horizontalSpace(),
                      InkWell(
                          onTap: () async {
                            if(farmerDetail.address!=null){
                              BlocProvider.of<DdeEnquiryCubit>(context).launchURL(
                                  farmerDetail.address!.latitude.toString(),
                                  farmerDetail.address!.longitude.toString(),context);
                            }
                            // await launchWhatsApp(farmerDetail.phone ?? '');
                          },
                          child: SvgPicture.asset(Images.redirectLocation)),
                      6.horizontalSpace(),
                    ],
                  )),
            ],
          )
        : Stack(
            alignment: Alignment.center,
            children: [
              SizedBox(height: 150, width: screenWidth()),
              InkWell(
                onTap: () {
                  BlocProvider.of<LandingPageCubit>(context)
                      .getCurrentLocation();
                  BlocProvider.of<ProfileCubit>(context)
                      .emit(ProfileCubitState.initial());
                  DdeFarmerDetail(
                          userId: farmerDetail.userId!,
                          farmerId: farmerDetail.id!)
                      .navigate();
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
                            farmerDetail.photo != null
                                ? CircleAvatar(
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
                                    ))
                                : CircleAvatar(
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
                                      child: Text(
                                        farmerDetail.address != null
                                            ? farmerDetail.address!.address !=
                                                    null
                                                ? farmerDetail.address!.address!
                                                    .toString()
                                                : ""
                                            : "",
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
                          onTap: () {
                            callOnMobile(farmerDetail.phone ?? '');
                          },
                          child: SvgPicture.asset(Images.callPrimary)),
                      6.horizontalSpace(),
                      InkWell(
                          onTap: () async {
                            await launchWhatsApp(farmerDetail.phone ?? '');
                          },
                          child: SvgPicture.asset(Images.whatsapp)),
                      6.horizontalSpace(),
                      InkWell(
                          onTap: () async {
                            if(farmerDetail.address!=null){
                              BlocProvider.of<DdeEnquiryCubit>(context).launchURL(
                                  farmerDetail.address!.address.latitude.toString(),
                                  farmerDetail.address!.address.latitude.toString(),context);
                            }
                            // await launchWhatsApp(farmerDetail.phone ?? '');
                          },
                          child: SvgPicture.asset(Images.redirectLocation)),
                      6.horizontalSpace(),
                    ],
                  )),
            ],
          );
  }

/////////KPI///////////////////////
  Widget kpi(contexts, ProjectState state) {
    List<FrontendKpiModel> kpiData = [];

    if (state.responseFarmerProjectDetail!.data!.farmerProject![0].kpi!
            .investment !=
        null) {
      kpiData.add(FrontendKpiModel(
          name: 'Investment',
          image: Images.investmentKpi,
          value: getCurrencyString(state.responseFarmerProjectDetail!.data!
              .farmerProject![0].kpi!.investment!)));
    }

    if (state.responseFarmerProjectDetail!.data!.farmerProject![0].kpi!
            .revenue !=
        null) {
      kpiData.add(FrontendKpiModel(
          name: 'Revenue',
          image: Images.revenueKpi,
          value: getCurrencyString(state.responseFarmerProjectDetail!.data!
              .farmerProject![0].kpi!.revenue!)));
    }

    if (state.responseFarmerProjectDetail!.data!.farmerProject![0].kpi!.roi !=
        null) {
      kpiData.add(FrontendKpiModel(
          name: 'ROI',
          image: Images.roiKpi,
          value:
              "${state.responseFarmerProjectDetail!.data!.farmerProject![0].kpi!.roi!}%"));
    }

    if (state.responseFarmerProjectDetail!.data!.farmerProject![0].kpi!
            .farmerParticipation !=
        null) {
      kpiData.add(FrontendKpiModel(
          name: 'Farmer Participation',
          image: Images.farmerParticipationKpi,
          actionImage: Images.imageEdit,
          value: getCurrencyString(state.responseFarmerProjectDetail!.data!
              .farmerProject![0].kpi!.farmerParticipation!)));
    }

    if (state.responseFarmerProjectDetail!.data!.farmerProject![0].kpi!.loan !=
        null) {
      kpiData.add(FrontendKpiModel(
          name: 'Loan',
          image: Images.loanKpi,
          value: getCurrencyString(state.responseFarmerProjectDetail!.data!
              .farmerProject![0].kpi!.loan!)));
    }

    if (state.responseFarmerProjectDetail!.data!.farmerProject![0].kpi!
            .repayment !=
        null) {
      kpiData.add(FrontendKpiModel(
          name: 'Repayment',
          image: Images.repaymentKpi,
          value:
              "${state.responseFarmerProjectDetail!.data!.farmerProject![0].kpi!.repayment!} MO"));
    }

    if (['active', 'hold', "paid", 'completed'].contains(state
        .responseFarmerProjectDetail!.data!.farmerProject![0].projectStatus)) {
      if (state.responseFarmerProjectDetail!.data!.farmerProject![0].kpi!
              .repaymentStartDate !=
          null) {
        kpiData.add(FrontendKpiModel(
            name: 'Repayment Start Date',
            image: Images.yieldKpi,
            value: DateFormat('dd MMM, yyyy').format(DateTime.parse(state
                .responseFarmerProjectDetail!
                .data!
                .farmerProject![0]
                .kpi!
                .repaymentStartDate!))));
      }
    }

    if (['active', 'hold', "paid", 'completed'].contains(state
        .responseFarmerProjectDetail!.data!.farmerProject![0].projectStatus)) {
      if (state.responseFarmerProjectDetail!.data!.farmerProject![0].kpi!.emi !=
          null) {
        kpiData.add(FrontendKpiModel(
            name: 'EMI',
            image: Images.emiKpi,
            value: getCurrencyString(state.responseFarmerProjectDetail!.data!
                .farmerProject![0].kpi!.emi!)));
      }

      if (state.responseFarmerProjectDetail!.data!.farmerProject![0].kpi!
              .paidEmis !=
          null) {
        kpiData.add(FrontendKpiModel(
            name: 'Paid EMIs',
            image: Images.yieldKpi,
            actionImage: Images.menuIcon,
            value:
                "${state.responseFarmerProjectDetail!.data!.farmerProject![0].kpi!.paidEmis!}"));
      }

      if (state.responseFarmerProjectDetail!.data!.farmerProject![0].kpi!
              .remainingEmiValue !=
          null) {
        kpiData.add(FrontendKpiModel(
            name: 'Remaining Payable',
            image: Images.yieldKpi,
            actionImage: Images.menuIcon,
            value: getCurrencyString(state.responseFarmerProjectDetail!.data!
                .farmerProject![0].kpi!.remainingEmiValue!)));
      }
    }

    if (state.responseFarmerProjectDetail!.data!.farmerProject![0].kpi!
            .currentYield !=
        null) {
      kpiData.add(FrontendKpiModel(
        name: 'Current Yield',
        image: Images.yieldKpi,
        actionImage: Images.menuIcon,
        value:
            '${state.responseFarmerProjectDetail!.data!.farmerProject![0].kpi!.currentYield!} Ltr.',
      ));
    }

    if (state.responseFarmerProjectDetail!.data!.farmerProject![0].kpi!
            .expectedYield !=
        null) {
      kpiData.add(FrontendKpiModel(
        name: 'Target Yield',
        image: Images.yieldKpi,
        value:
            '${state.responseFarmerProjectDetail!.data!.farmerProject![0].kpi!.expectedYield!} Ltr.',
      ));
    }

    if (state.responseFarmerProjectDetail!.data!.farmerProject![0].kpi!
            .idealYield !=
        null) {
      kpiData.add(FrontendKpiModel(
          name: 'Ideal Yield',
          image: Images.idealKpi,
          value:
              "${state.responseFarmerProjectDetail!.data!.farmerProject![0].kpi!.idealYield!} Ltr."));
    }

    if (state.responseFarmerProjectDetail!.data!.farmerProject![0].kpi!
            .targetFarmProduction !=
        null) {
      kpiData.add(FrontendKpiModel(
          name: 'Target Farm Production',
          image: Images.yieldKpi,
          value:
              "${state.responseFarmerProjectDetail!.data!.farmerProject![0].kpi!.targetFarmProduction!} Ltr."));
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
            mainAxisExtent: 123, child: (index) {
          return InkWell(
            onTap: () {
              if (kpiData[index].name.toString() == "Paid EMIs") {
                ProjectDetailStatement(
                  userRoleId: state.responseFarmerProjectDetail!.data!
                      .farmerProject![0].farmerMaster!.id
                      .toString(),
                  farmerProjectId: widget.projectId.toString(),
                  status: 'paid',
                ).navigate();
              } else if (kpiData[index].name.toString() ==
                  "Remaining Payable") {
                ProjectDetailStatement(
                  userRoleId: state.responseFarmerProjectDetail!.data!
                      .farmerProject![0].farmerMaster!.id
                      .toString(),
                  farmerProjectId: widget.projectId.toString(),
                  status: 'due',
                ).navigate();
              }
            },
            child: Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(14),
                border: Border.all(color: const Color(0xffDCDCDC), width: 1),
                boxShadow: [
                  BoxShadow(
                      color: Colors.grey.withOpacity(0.2),
                      blurRadius: 2.0,
                      offset: const Offset(0, 2))
                ],
              ),
              child: Padding(
                // padding: 0.paddingAll(),
                padding: const EdgeInsets.fromLTRB(8, 10, 8, 2),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        SvgPicture.asset(
                          kpiData[index].image.toString(),
                          width: 30,
                          height: 30,
                        ),
                        kpiData[index].actionImage != null
                            ? kpiData[index].name.toString() ==
                                    "Farmer Participation"
                                ? state
                                            .responseFarmerProjectDetail!
                                            .data!
                                            .farmerProject![0]
                                            .farmerParticipationStatus
                                            .toString() ==
                                        'pending'
                                    ? state
                                                    .responseFarmerProjectDetail!
                                                    .data!
                                                    .farmerProject![0]
                                                    .projectStatus
                                                    .toString() ==
                                                "hold" ||
                                            state
                                                    .responseFarmerProjectDetail!
                                                    .data!
                                                    .farmerProject![0]
                                                    .projectStatus
                                                    .toString() ==
                                                "completed"
                                        ? const Align(
                                            alignment: Alignment.centerRight,
                                            child: Icon(
                                              Icons.watch_later,
                                              color: Colors.amber,
                                              size: 20,
                                            ))
                                        : InkWell(
                                            onTap: () {
                                              TextEditingController controller =
                                                  TextEditingController();
                                              controller.text = state
                                                  .responseFarmerProjectDetail!
                                                  .data!
                                                  .farmerProject![0]
                                                  .kpi!
                                                  .farmerParticipation!
                                                  .toString();
                                              if (kpiData[index]
                                                      .name
                                                      .toString() ==
                                                  "Farmer Participation") {
                                                modalBottomSheetMenu(context,
                                                    radius: 40, child:
                                                        StatefulBuilder(builder:
                                                            (context,
                                                                setState) {
                                                  return SizedBox(
                                                    height: 320,
                                                    child: Padding(
                                                      padding: const EdgeInsets
                                                          .fromLTRB(
                                                          23, 40, 25, 10),
                                                      child: Column(
                                                          crossAxisAlignment:
                                                              CrossAxisAlignment
                                                                  .start,
                                                          children: [
                                                            Center(
                                                              child: Text(
                                                                'Farmer Participation',
                                                                style: figtreeMedium
                                                                    .copyWith(
                                                                        fontSize:
                                                                            22),
                                                              ),
                                                            ),
                                                            30.verticalSpace(),
                                                            Column(
                                                              crossAxisAlignment:
                                                                  CrossAxisAlignment
                                                                      .start,
                                                              children: [
                                                                Text(
                                                                  'Participation Value',
                                                                  style: figtreeMedium
                                                                      .copyWith(
                                                                          fontSize:
                                                                              12),
                                                                ),
                                                                5.verticalSpace(),
                                                                TextField(
                                                                  controller:
                                                                      controller,
                                                                  maxLines: 1,
                                                                  keyboardType:
                                                                      TextInputType
                                                                          .number,
                                                                  inputFormatters: [
                                                                    FilteringTextInputFormatter
                                                                        .digitsOnly
                                                                  ],
                                                                  minLines: 1,
                                                                  decoration: InputDecoration(
                                                                      hintText: 'Enter participation value',
                                                                      hintStyle: figtreeMedium.copyWith(fontSize: 18),
                                                                      border: OutlineInputBorder(
                                                                          borderRadius: BorderRadius.circular(12),
                                                                          borderSide: const BorderSide(
                                                                            width:
                                                                                1,
                                                                            color:
                                                                                Color(0xff999999),
                                                                          ))),
                                                                ),
                                                                30.verticalSpace(),
                                                                Padding(
                                                                  padding:
                                                                      const EdgeInsets
                                                                          .fromLTRB(
                                                                          28,
                                                                          0,
                                                                          29,
                                                                          0),
                                                                  child:
                                                                      customButton(
                                                                    'Submit',
                                                                    fontColor:
                                                                        0xffFFFFFF,
                                                                    onTap: () {
                                                                      if (controller
                                                                          .text
                                                                          .isEmpty) {
                                                                        showCustomToast(
                                                                            context,
                                                                            "Please enter participation value");
                                                                      } else {
                                                                        BlocProvider.of<ProjectCubit>(context).farmerParticipationApi(
                                                                            context,
                                                                            state.responseFarmerProjectDetail!.data!.farmerProject![0].farmerId.toString(),
                                                                            state.responseFarmerProjectDetail!.data!.farmerProject![0].id.toString(),
                                                                            controller.text,
                                                                            widget.projectId);
                                                                      }
                                                                    },
                                                                    height: 60,
                                                                    width:
                                                                        screenWidth(),
                                                                  ),
                                                                )
                                                              ],
                                                            )
                                                          ]),
                                                    ),
                                                  );
                                                }));
                                              }
                                            },
                                            child: SvgPicture.asset(
                                                kpiData[index]
                                                    .actionImage
                                                    .toString()))
                                    : const Align(
                                        alignment: Alignment.centerRight,
                                        child: Icon(
                                          Icons.check_circle,
                                          color: Colors.green,
                                          size: 20,
                                        ))
                                : SvgPicture.asset(
                                    kpiData[index].actionImage.toString())
                            : const SizedBox.shrink()
                      ],
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

  ///////////ProjectMilestones///////////
  Widget projectMilestones(context, ProjectState state) {
    return Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      50.verticalSpace(),
      Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            'Project milestones',
            style: figtreeMedium.copyWith(fontSize: 18),
          ),
          state.responseFarmerProjectDetail!.data!.farmerProject![0]
                      .projectStatus !=
                  null
              ? state.responseFarmerProjectDetail!.data!.farmerProject![0]
                          .projectStatus
                          .toString()
                          .toUpperCase() ==
                      "interested".toUpperCase()
                  ? InkWell(
                      onTap: () {
                        BlocProvider.of<ProjectCubit>(context).emit(
                            state.copyWith(
                                milestoneTitle: TextEditingController(text: ''),
                                milestoneDuration:
                                    TextEditingController(text: ''),
                                milestoneDescription:
                                    TextEditingController(text: '')));
                        AddProjectMileStone(
                                farmerId: state.responseFarmerProjectDetail!
                                    .data!.farmerProject![0].farmerId
                                    .toString(),
                                farmerProjectId: state
                                    .responseFarmerProjectDetail!
                                    .data!
                                    .farmerProject![0]
                                    .id
                                    .toString(),
                                projectId: widget.projectId,
                                projectStatus: state
                                    .responseFarmerProjectDetail!
                                    .data!
                                    .farmerProject![0]
                                    .projectStatus
                                    .toString())
                            .navigate();
                      },
                      child: Container(
                        padding: const EdgeInsets.symmetric(
                            vertical: 8, horizontal: 15),
                        decoration: boxDecoration(
                          backgroundColor: ColorResources.white,
                          borderWidth: 1,
                          borderRadius: 160,
                          borderColor: const Color(0xff6A0030),
                        ),
                        child: Text(
                          "Add",
                          textAlign: TextAlign.center,
                          style: figtreeMedium.copyWith(
                              color: const Color(0xff6A0030), fontSize: 10),
                        ),
                      ),
                    )
                  : const SizedBox.shrink()
              : const SizedBox.shrink()
        ],
      ),

      15.verticalSpace(),

      customList(
          list: List.generate(
              state.responseFarmerProjectDetail!.data!.farmerProject![0]
                  .farmerProjectMilestones!.length,
              (index) => null),
          axis: Axis.vertical,
          child: (int index) {
            return Padding(
              padding: const EdgeInsets.only(
                bottom: 20,
              ),
              child: InkWell(
                onTap: () {
                  DdeMilestoneDetail(
                    milestoneId: state.responseFarmerProjectDetail!.data!
                        .farmerProject![0].farmerProjectMilestones![index].id,
                    projectStatus: state.responseFarmerProjectDetail!.data!
                        .farmerProject![0].projectStatus
                        .toString(),
                    navigateScreen: '',
                    projectId: widget.projectId,
                  ).navigate();
                  /*SuggestedProjectMilestoneDetail(milestoneId:
                  state.responseFarmerProjectDetail!.data!.farmerProject![0].farmerProjectMilestones![index].id,
                    projectStatus:state.responseFarmerProjectDetail!.data!.farmerProject![0].projectStatus.toString(),
                  ).navigate();*/
                },
                child: Stack(
                  children: [
                    customProjectContainer(
                        marginLeft: 0,
                        marginTop: 0,
                        borderRadius: 14,
                        child: Padding(
                          padding: const EdgeInsets.all(20),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  Text(
                                    state
                                            .responseFarmerProjectDetail!
                                            .data!
                                            .farmerProject![0]
                                            .farmerProjectMilestones![index]
                                            .milestoneTitle ??
                                        '',
                                    style: figtreeMedium.copyWith(fontSize: 18),
                                  ),
                                  // checkBox(
                                  //   value: true,
                                  // )
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
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        'Value',
                                        style: figtreeMedium.copyWith(
                                            fontSize: 12,
                                            color: ColorResources.fieldGrey),
                                      ),
                                      Text(
                                        state
                                                    .responseFarmerProjectDetail!
                                                    .data!
                                                    .farmerProject![0]
                                                    .farmerProjectMilestones![
                                                        index]
                                                    .milestoneValue !=
                                                null
                                            ? getCurrencyString(state
                                                .responseFarmerProjectDetail!
                                                .data!
                                                .farmerProject![0]
                                                .farmerProjectMilestones![index]
                                                .milestoneValue)
                                            : '',
                                        style: figtreeSemiBold.copyWith(
                                            fontSize: 16,
                                            color: ColorResources.maroon),
                                      )
                                    ],
                                  ),
                                  40.horizontalSpace(),
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
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
                    state.responseFarmerProjectDetail!.data!.farmerProject![0]
                                .projectStatus !=
                            null
                        ? state.responseFarmerProjectDetail!.data!
                                    .farmerProject![0].projectStatus
                                    .toString()
                                    .toUpperCase() ==
                                "interested".toUpperCase()
                            ? Positioned(
                                right: 2,
                                child: Row(
                                  children: [
                                    InkWell(
                                        onTap: () {
                                          BlocProvider.of<ProjectCubit>(context)
                                              .emit(state.copyWith(
                                                  milestoneTitle: TextEditingController(
                                                      text: state
                                                              .responseFarmerProjectDetail!
                                                              .data!
                                                              .farmerProject![0]
                                                              .farmerProjectMilestones![
                                                                  index]
                                                              .milestoneTitle ??
                                                          ''),
                                                  milestoneDuration: TextEditingController(
                                                      text: state
                                                              .responseFarmerProjectDetail!
                                                              .data!
                                                              .farmerProject![0]
                                                              .farmerProjectMilestones![
                                                                  index]
                                                              .milestoneDuration
                                                              .toString() ??
                                                          ''),
                                                  milestoneDescription:
                                                      TextEditingController(
                                                    text: state
                                                            .responseFarmerProjectDetail!
                                                            .data!
                                                            .farmerProject![0]
                                                            .farmerProjectMilestones![
                                                                index]
                                                            .milestoneDescription ??
                                                        '',
                                                  ),
                                                  projectId: state
                                                      .responseFarmerProjectDetail!
                                                      .data!
                                                      .farmerProject![0]
                                                      .farmerProjectMilestones![
                                                          index]
                                                      .id
                                                      .toString()));
                                          EditProjectMilestone(
                                            farmerId: state
                                                .responseFarmerProjectDetail!
                                                .data!
                                                .farmerProject![0]
                                                .farmerId
                                                .toString(),
                                            farmerProjectId: state
                                                .responseFarmerProjectDetail!
                                                .data!
                                                .farmerProject![0]
                                                .id
                                                .toString(),
                                            projectId: widget.projectId,
                                            projectStatus: state
                                                .responseFarmerProjectDetail!
                                                .data!
                                                .farmerProject![0]
                                                .projectStatus
                                                .toString(),
                                          ).navigate();
                                        },
                                        child: Image.asset(
                                          Images.editIcon,
                                          width: 24,
                                          height: 24,
                                        )),
                                    Padding(
                                      padding: const EdgeInsets.all(14.0),
                                      child: InkWell(
                                          onTap: () {
                                            BlocProvider.of<ProjectCubit>(
                                                    context)
                                                .milestoneDeleteApi(
                                                    context,
                                                    state
                                                        .responseFarmerProjectDetail!
                                                        .data!
                                                        .farmerProject![0]
                                                        .farmerProjectMilestones![
                                                            index]
                                                        .id,
                                                    widget.projectId);
                                          },
                                          child: Image.asset(
                                            Images.deleteIcon,
                                            width: 24,
                                            height: 24,
                                          )),
                                    )
                                  ],
                                ),
                              )
                            : const SizedBox.shrink()
                        : const SizedBox.shrink()
                  ],
                ),
              ),
            );
          }),
      // 20.verticalSpace(),
      // Center(
      //     child: Padding(
      //   padding: const EdgeInsets.only(left: 50, right: 50),
      //   child: customButton('Revoke',
      //       width: screenWidth(),
      //       style: figtreeMedium.copyWith(fontSize: 16, color: Colors.white),
      //       onTap: () {
      //     const AddRemark().navigate();
      //   }, radius: 88, color: 0xffFC5E60),
      // )),
      // 05.verticalSpace(),
      // Center(
      //     child: Text(
      //   'Tap above to revoke the loan application.',
      //   style: figtreeMedium.copyWith(
      //       fontSize: 10, color: ColorResources.fieldGrey),
      // )),
      20.verticalSpace(),
    ]);
  }

  ///////////ProjectMilestones///////////
  Widget activeProjectMilestones(context, ProjectState state) {
    return Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      30.verticalSpace(),
      Text(
        'Project milestones',
        style: figtreeMedium.copyWith(fontSize: 18),
      ),

      15.verticalSpace(),

      customList(
          list: List.generate(
              state.responseFarmerProjectDetail!.data!.farmerProject![0]
                  .farmerProjectMilestones!.length,
              (index) => null),
          axis: Axis.vertical,
          child: (int index) {
            return Padding(
              padding: const EdgeInsets.only(
                bottom: 20,
              ),
              child: InkWell(
                onTap: () {
                  DdeMilestoneDetail(
                    milestoneId: state.responseFarmerProjectDetail!.data!
                        .farmerProject![0].farmerProjectMilestones![index].id,
                    projectStatus: state.responseFarmerProjectDetail!.data!
                        .farmerProject![0].projectStatus
                        .toString(),
                    navigateScreen: '',
                    projectId: widget.projectId,
                  ).navigate();
                  /*SuggestedProjectMilestoneDetail(milestoneId:
                  state.responseFarmerProjectDetail!.data!.farmerProject![0].farmerProjectMilestones![index].id,
                    projectStatus:state.responseFarmerProjectDetail!.data!.farmerProject![0].projectStatus.toString(),
                  ).navigate();*/
                },
                child: customShadowContainer(
                    margin: 0,
                    color: state
                                .responseFarmerProjectDetail!
                                .data!
                                .farmerProject![0]
                                .farmerProjectMilestones![index]
                                .milestoneStatus !=
                            "pending"
                        ? const Color(0xFFFFF3F4)
                        : Colors.white,
                    backColor: state
                                .responseFarmerProjectDetail!
                                .data!
                                .farmerProject![0]
                                .farmerProjectMilestones![index]
                                .milestoneStatus !=
                            "pending"
                        ? ColorResources.maroon
                        : ColorResources.grey,
                    // backColor: ColorResources.grey,
                    child: Padding(
                      padding: const EdgeInsets.fromLTRB(20, 20, 20, 20),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                state
                                        .responseFarmerProjectDetail!
                                        .data!
                                        .farmerProject![0]
                                        .farmerProjectMilestones![index]
                                        .milestoneTitle ??
                                    '',
                                style: figtreeMedium.copyWith(fontSize: 18),
                              ),
                              state
                                          .responseFarmerProjectDetail!
                                          .data!
                                          .farmerProject![0]
                                          .farmerProjectMilestones![index]
                                          .milestoneStatus !=
                                      "pending"
                                  ? checkBox2(value: true)
                                  : Builder(builder: (context) {
                                      int count = 0;
                                      for (FarmerProjectTask task in state
                                          .responseFarmerProjectDetail!
                                          .data!
                                          .farmerProject![0]
                                          .farmerProjectMilestones![index]
                                          .farmerProjectTask!) {
                                        if (task.taskStatus!.toLowerCase() ==
                                            "approved") {
                                          count++;
                                        }
                                      }
                                      return Stack(
                                        alignment: Alignment.center,
                                        children: [
                                          CircularPercentIndicator(
                                            radius: 30,
                                            percent: count /
                                                state
                                                    .responseFarmerProjectDetail!
                                                    .data!
                                                    .farmerProject![0]
                                                    .farmerProjectMilestones![
                                                        index]
                                                    .farmerProjectTask!
                                                    .length,
                                            progressColor:
                                                const Color(0xFF12CE57),
                                            backgroundColor:
                                                const Color(0xFFDCEAE5),
                                          ),
                                          RichText(
                                            softWrap: false,
                                            text: TextSpan(children: [
                                              TextSpan(
                                                  text: removeZeroesInFraction(((count /
                                                              state
                                                                  .responseFarmerProjectDetail!
                                                                  .data!
                                                                  .farmerProject![
                                                                      0]
                                                                  .farmerProjectMilestones![
                                                                      index]
                                                                  .farmerProjectTask!
                                                                  .length) *
                                                          100)
                                                      .toString()),
                                                  style: figtreeBold.copyWith(
                                                      color: Colors.black,
                                                      fontSize: 16)),
                                              TextSpan(
                                                  text: '%\n',
                                                  style: figtreeBold.copyWith(
                                                      color: Colors.black,
                                                      fontSize: 9)),
                                              TextSpan(
                                                  text: 'completed',
                                                  style: figtreeBold.copyWith(
                                                      color: const Color(
                                                          0xFF808080),
                                                      fontSize: 6))
                                            ]),
                                            textAlign: TextAlign.center,
                                          )
                                        ],
                                      );
                                    })
                            ],
                          ),
                          Row(
                            children: [
                              Text(
                                '${state.responseFarmerProjectDetail!.data!.farmerProject![0].farmerProjectMilestones![index].farmerProjectTaskCount ?? 0} tasks included in this milestone.',
                                style: figtreeMedium.copyWith(fontSize: 12),
                              ),
                              if (state
                                      .responseFarmerProjectDetail!
                                      .data!
                                      .farmerProject![0]
                                      .farmerProjectMilestones![index]
                                      .milestoneStatus ==
                                  'approved')
                                InfoPopupWidget(
                                  contentTitle: state
                                          .responseFarmerProjectDetail!
                                          .data!
                                          .farmerProject![0]
                                          .farmerProjectMilestones![index]
                                          .approvalRemarks ??
                                      '',
                                  arrowTheme: const InfoPopupArrowTheme(
                                    color: ColorResources.mustard,
                                    arrowDirection: ArrowDirection.up,
                                  ),
                                  contentTheme: InfoPopupContentTheme(
                                    infoContainerBackgroundColor:
                                        ColorResources.mustard,
                                    infoTextStyle: figtreeMedium.copyWith(
                                        fontSize: 12, color: Colors.black),
                                    contentPadding: const EdgeInsets.all(12),
                                    contentBorderRadius: const BorderRadius.all(
                                        Radius.circular(10)),
                                    infoTextAlign: TextAlign.start,
                                  ),
                                  dismissTriggerBehavior:
                                      PopupDismissTriggerBehavior.anyWhere,
                                  areaBackgroundColor: Colors.transparent,
                                  indicatorOffset: Offset.zero,
                                  contentOffset: Offset.zero,
                                  child: Row(
                                    children: [
                                      10.horizontalSpace(),
                                      Text('Remarks',
                                          style: figtreeRegular.copyWith(
                                              fontSize: 12,
                                              color: ColorResources.maroon,
                                              decoration:
                                                  TextDecoration.underline)),
                                      const Icon(Icons.info,
                                          color: ColorResources.mustard,
                                          size: 18),
                                    ],
                                  ),
                                ),
                            ],
                          ),
                          20.verticalSpace(),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
                                    state
                                                .responseFarmerProjectDetail!
                                                .data!
                                                .farmerProject![0]
                                                .farmerProjectMilestones![index]
                                                .milestoneValue !=
                                            null
                                        ? getCurrencyString(state
                                            .responseFarmerProjectDetail!
                                            .data!
                                            .farmerProject![0]
                                            .farmerProjectMilestones![index]
                                            .milestoneValue)
                                        : '',
                                    style: figtreeSemiBold.copyWith(
                                        fontSize: 16,
                                        color: ColorResources.maroon),
                                  )
                                ],
                              ),
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
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    'Due Date',
                                    style: figtreeMedium.copyWith(
                                        fontSize: 12,
                                        color: ColorResources.fieldGrey),
                                  ),
                                  Text(
                                    state
                                                .responseFarmerProjectDetail!
                                                .data!
                                                .farmerProject![0]
                                                .farmerProjectMilestones![index]
                                                .milestoneDueDate !=
                                            null
                                        ? DateFormat('dd MMM, yyyy').format(
                                            DateTime.parse(state
                                                .responseFarmerProjectDetail!
                                                .data!
                                                .farmerProject![0]
                                                .farmerProjectMilestones![index]
                                                .milestoneDueDate
                                                .toString()))
                                        : '',
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
      // 20.verticalSpace(),
      // Center(
      //     child: Padding(
      //   padding: const EdgeInsets.only(left: 50, right: 50),
      //   child: customButton('Revoke',
      //       width: screenWidth(),
      //       style: figtreeMedium.copyWith(fontSize: 16, color: Colors.white),
      //       onTap: () {
      //     const AddRemark().navigate();
      //   }, radius: 88, color: 0xffFC5E60),
      // )),
      // 05.verticalSpace(),
      // Center(
      //     child: Text(
      //   'Tap above to revoke the loan application.',
      //   style: figtreeMedium.copyWith(
      //       fontSize: 10, color: ColorResources.fieldGrey),
      // )),
      20.verticalSpace(),
    ]);
  }

  /////////////InviteExpert/////////
  Widget inviteExpert(BuildContext context, ProjectState state) {
    return Column(
      children: [
        Center(
            child: Padding(
          padding: const EdgeInsets.only(left: 50, right: 50),
          child: customButton(
            'Invite expert for survey',
            width: screenWidth(),
            style: figtreeMedium.copyWith(fontSize: 16, color: Colors.white),
            onTap: () {
              TextEditingController controller = TextEditingController();
              String date = '';
              modalBottomSheetMenu(context, radius: 40,
                  child: StatefulBuilder(builder: (context, setState) {
                return SizedBox(
                  height: 450,
                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(23, 40, 25, 10),
                    child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Center(
                            child: Text(
                              'Farmer feedback',
                              style: figtreeMedium.copyWith(fontSize: 22),
                            ),
                          ),
                          30.verticalSpace(),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              CustomTextField2(
                                title: 'Preferred date',
                                image2: Images.calender,
                                image2Colors: ColorResources.maroon,
                                readOnly: true,
                                controller: TextEditingController()
                                  ..text = date,
                                onTap: () async {
                                  var selectDate =
                                      await selectedFutureDate(context);
                                  date =
                                      "${selectDate.year}/${selectDate.month}/${selectDate.day}";
                                  setState(() {});
                                },
                                focusNode: FocusNode(),
                              ),
                              20.verticalSpace(),
                              Text(
                                'Remarks',
                                style: figtreeMedium.copyWith(fontSize: 12),
                              ),
                              5.verticalSpace(),
                              TextField(
                                controller: controller,
                                maxLines: 4,
                                minLines: 4,
                                decoration: InputDecoration(
                                    hintText: 'Write...',
                                    hintStyle:
                                        figtreeMedium.copyWith(fontSize: 18),
                                    border: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(12),
                                        borderSide: const BorderSide(
                                          width: 1,
                                          color: Color(0xff999999),
                                        ))),
                              ),
                              30.verticalSpace(),
                              Padding(
                                padding:
                                    const EdgeInsets.fromLTRB(28, 0, 29, 0),
                                child: customButton(
                                  'Submit',
                                  fontColor: 0xffFFFFFF,
                                  onTap: () {
                                    context
                                        .read<ProjectCubit>()
                                        .inviteExpertForSurvey(
                                            context,
                                            state.responseFarmerProjectDetail!
                                                .data!.farmerProject![0].id,
                                            date,
                                            controller.text ?? '',
                                            'interested',
                                            state
                                                .responseFarmerProjectDetail!
                                                .data!
                                                .farmerProject![0]
                                                .farmerId
                                                .toString());
                                  },
                                  height: 60,
                                  width: screenWidth(),
                                ),
                              )
                            ],
                          )
                        ]),
                  ),
                );
              }));
            },
          ),
        )),
        20.verticalSpace(),
        InkWell(
            onTap: () {
              customDialog(
                  widget: Center(
                child: Material(
                  borderRadius: BorderRadius.circular(15),
                  child: Container(
                    height: 135,
                    width: screenWidth() - 30,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(15),
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        "Are you sure u are not interested?"
                            .textMedium(fontSize: 19, color: Colors.black),
                        20.verticalSpace(),
                        Row(
                          children: [
                            20.horizontalSpace(),
                            Expanded(
                              child: customButton("No",
                                  borderColor: 0xFF6A0030,
                                  color: 0xFFffffff, onTap: () {
                                pressBack();
                              }),
                            ),
                            20.horizontalSpace(),
                            Expanded(
                              child: customButton("Yes", fontColor: 0xFFffffff,
                                  onTap: () {
                                // context.read<ProjectCubit>().updateSuggestedProjectStatus(context, 'Not Interested' , state.responseFarmerProjectDetail!.data!.farmerProject![0].id);
                                context
                                    .read<ProjectCubit>()
                                    .inviteExpertForSurvey(
                                        context,
                                        state.responseFarmerProjectDetail!.data!
                                            .farmerProject![0].id,
                                        '',
                                        '',
                                        'Not Interested',
                                        state.responseFarmerProjectDetail!.data!
                                            .farmerProject![0].farmerId
                                            .toString());
                              }),
                            ),
                            20.horizontalSpace(),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ));
            },
            child: Text(
              'Not Interested',
              style: figtreeMedium.copyWith(
                  fontSize: 16,
                  color: Colors.grey,
                  decoration: TextDecoration.underline),
            )),
        20.verticalSpace(),
      ],
    );
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
        return Stack(
          children: [
            InkWell(
              onTap: () {
                LoanLivestockDetail(id: state.responseFarmerProjectDetail!.data!.farmerProject![0].dataLivestock!.liveStockCartDetails![index].liveStockId.toString(), isMyLivestock: false,
                  cowQty:state.responseFarmerProjectDetail!.data!.farmerProject![0].dataLivestock!.liveStockCartDetails![index].cowQty.toString(),
                  status:state.responseFarmerProjectDetail!.data!.farmerProject![0].projectStatus.toString(),
                  farmerProjectId:state.responseFarmerProjectDetail!.data!.farmerProject![0].id,
                  cartId:state.responseFarmerProjectDetail!.data!.farmerProject![0].dataLivestock!.liveStockCartDetails![index].id!,
                  deliveryStatus:state.responseFarmerProjectDetail!.data!.farmerProject![0].dataLivestock!.liveStockCartDetails![index].deliveryStatus!,
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
        );
      }),

      20.verticalSpace(),
    ]);
  }

}
