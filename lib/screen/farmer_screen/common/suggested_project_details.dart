import 'package:cached_network_image/cached_network_image.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:currency_text_input_formatter/currency_text_input_formatter.dart';
import 'package:dio/dio.dart';
import 'package:expandable_text/expandable_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_svg/svg.dart';
import 'package:glad/cubit/project_cubit/project_cubit.dart';
import 'package:glad/data/model/frontend_kpi_model.dart';
import 'package:glad/data/model/response_project_data_firebase.dart';
import 'package:glad/screen/chat/firebase_chat_screen.dart';
import 'package:glad/screen/custom_widget/circular_percent_indicator.dart';
import 'package:glad/screen/custom_widget/custom_appbar.dart';
import 'package:glad/screen/custom_widget/custom_methods.dart';
import 'package:glad/screen/custom_widget/custom_textfield2.dart';
import 'package:glad/screen/dde_screen/add_remark_confirm_loan.dart';
import 'package:glad/screen/dde_screen/preview_screen.dart';
import 'package:glad/screen/dde_screen/termsandcondition.dart';
import 'package:glad/screen/dde_screen/widget/add_remark_revoke.dart';
import 'package:glad/screen/farmer_screen/common/suggested_project_milestone_detail.dart';
import 'package:glad/utils/app_constants.dart';
import 'package:glad/utils/color_resources.dart';
import 'package:glad/utils/extension.dart';
import 'package:glad/utils/images.dart';
import 'package:glad/utils/sharedprefrence.dart';
import 'package:glad/utils/styles.dart';
import 'package:intl/intl.dart';
import 'package:open_file_safe_plus/open_file_safe_plus.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';

import '../../../data/model/farmer_project_detail_model.dart';
import '../project_farmer_statment.dart';

class SuggestedProjectDetails extends StatefulWidget {
  const SuggestedProjectDetails({super.key, required this.projectId});
  final int projectId;

  @override
  State<SuggestedProjectDetails> createState() =>
      _SuggestedProjectDetailsState();
}

class _SuggestedProjectDetailsState extends State<SuggestedProjectDetails> {

  bool paymentTerms = false;

  @override
  void initState() {
    BlocProvider.of<ProjectCubit>(context)
        .farmerProjectDetailApi(context, widget.projectId);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {

    final MediaQueryData mediaData = MediaQuery.of(context);

    return Scaffold(
      body: BlocBuilder<ProjectCubit, ProjectState>(builder: (context, state) {
        if (state.status == ProjectStatus.loading) {
          return const Center(
              child: CircularProgressIndicator(
            color: ColorResources.maroon,
          ));
        } else if (state.responseFarmerProjectDetail == null) {
          return Center(child: Text("${state.responseFarmerProjectDetail} Api Error"));
        } else {
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
                            20.verticalSpace(),
                            dde(context, state),
                            if(state.responseFarmerProjectDetail!.data!.supplierDetail != null)
                              supplier(context, state),

                            state.responseFarmerProjectDetail!.data!.farmerProject![0].kpi!=null?
                            kpi(context,state,mediaData):const SizedBox.shrink(),
                            projectMilestones(context, state),
                            if(state.responseFarmerProjectDetail!.data!.farmerProject![0].projectStatus != null)
                            state.responseFarmerProjectDetail!.data!.farmerProject![0].projectStatus.toString() == "suggested" ?
                            inviteExpert(context, state):const SizedBox.shrink(),

                            state.responseFarmerProjectDetail!.data!.farmerProject![0].projectStatus!=null?
                            state.responseFarmerProjectDetail!.data!.farmerProject![0].projectStatus.toString().toUpperCase() == "survey_completed".toUpperCase() ?
                            Center(
                              child: customButton(
                                  'Confirm The Loan',
                                  style: figtreeMedium.copyWith(fontSize: 16, color: Colors.white),
                                  onTap: (){
                                    AddRemarkConfirmLoan(projectData:state.responseFarmerProjectDetail!.data!.farmerProject![0].farmerMaster!,farmerProjectId:widget.projectId).navigate();
                                  }

                              ),
                            ):const SizedBox.shrink():const SizedBox.shrink(),

                            state.responseFarmerProjectDetail!.data!.farmerProject![0].projectStatus!=null?
                            state.responseFarmerProjectDetail!.data!.farmerProject![0].projectStatus.toString().toUpperCase() == "approved".toUpperCase() ?
                            Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
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
                                            padding:
                                            const EdgeInsets.symmetric(horizontal: 8.0),
                                            child: Row(
                                              mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                              children: [
                                                Text(
                                                  'Agreement',
                                                  style:
                                                  figtreeMedium.copyWith(fontSize: 18),
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

                                          paymentTerms == true?
                                          customList(
                                              list: state.responseFarmerProjectDetail!.data!.farmerProject![0].farmerLoanDocument!,
                                              child: (index){
                                                return customList(list: state.responseFarmerProjectDetail!.data!.farmerProject![0].farmerLoanDocument![index].loanDocumentFile!,child: (int childIndex) {
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
                                                            childIndex]
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
                                                            childIndex]
                                                                .fullUrl
                                                                .toString(),
                                                            "${"${dir.path}/fileName"}.pdf");
                                                        await OpenFileSafePlus.open(
                                                            "${"${dir.path}/fileName"}.pdf");
                                                      }
                                                    },
                                                    child: Container(
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

                                                          const Icon(Icons.file_copy,size: 22,
                                                            color: Colors.grey,),

                                                          5.horizontalSpace(),

                                                          Expanded(
                                                            child: Column(
                                                              crossAxisAlignment: CrossAxisAlignment.start,
                                                              children: [

                                                                Text(
                                                                  '${state.responseFarmerProjectDetail!.data!.farmerProject![0].farmerLoanDocument![index].documentName} ${childIndex+1}'??"",
                                                                  style:
                                                                  figtreeMedium.copyWith(fontSize: 16),
                                                                ),

                                                                5.verticalSpace(),

                                                                Text(
                                                                  DateFormat('dd MMM, yyyy').format(DateTime.parse(state.responseFarmerProjectDetail!.data!.farmerProject![0].farmerLoanDocument![index].createdAt.toString())),
                                                                  style:
                                                                  figtreeMedium.copyWith(fontSize: 12),
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
                                                              childIndex].originalUrl!.endsWith('pdf')) {
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
                                                                    childIndex]
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
                                                                    childIndex]
                                                                        .fullUrl
                                                                        .toString(),
                                                                    "${"${dir.path}/fileName"}.pdf");
                                                                await OpenFileSafePlus
                                                                    .open(
                                                                    "${"${dir.path}/fileName"}.pdf");
                                                              }
                                                            }, child: Container(
                                                            padding: const EdgeInsets.symmetric(
                                                                horizontal: 20, vertical: 8),
                                                            decoration: BoxDecoration(
                                                                color: Colors.white,
                                                                borderRadius:
                                                                BorderRadius.circular(30),
                                                                border:
                                                                Border.all(color: Colors.grey)),
                                                            child: Text(
                                                              'Download',
                                                              style: figtreeMedium.copyWith(
                                                                  fontSize: 12),
                                                            ),
                                                          ),
                                                          ),
                                                        ],
                                                      ),
                                                    ),
                                                  );
                                                }
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
                                          fontSize: 10, color: ColorResources.fieldGrey),
                                    )),

                                10.verticalSpace(),

                                Center(
                                  child: SizedBox(
                                    width: 230,
                                    child: customButton(
                                        'Terms and Conditions',
                                        style: figtreeMedium.copyWith(fontSize: 16, color: Colors.white),
                                        onTap: (){
                                          TermsAndCondition(projectData:state.responseFarmerProjectDetail!.data!.farmerProject![0].farmerMaster!,farmerProjectId:widget.projectId,navigateFrom: context.read<ProjectCubit>().sharedPreferences.getString(AppConstants.userType)!).navigate();
                                        }
                                    ),
                                  ),
                                ),

                                20.verticalSpace()

                              ],
                            ):const SizedBox.shrink():const SizedBox.shrink(),

                            state.responseFarmerProjectDetail!.data!.farmerProject![0].projectStatus!=null?
                            state.responseFarmerProjectDetail!.data!.farmerProject![0].projectStatus.toString().capitalized() == "not_interested".capitalized()?
                            inviteExpert(context, state) :const SizedBox.shrink():const SizedBox.shrink(),

                            state.responseFarmerProjectDetail!.data!.farmerProject![0].projectStatus!=null?
                            state.responseFarmerProjectDetail!.data!.farmerProject![0].projectStatus.toString().toUpperCase() == "applied".toUpperCase()
                                || state.responseFarmerProjectDetail!.data!.farmerProject![0].projectStatus.toString().toUpperCase() == "doc_verified".toUpperCase()
                                || state.responseFarmerProjectDetail!.data!.farmerProject![0].projectStatus.toString().toUpperCase() == "survey_requested".toUpperCase()
                                || state.responseFarmerProjectDetail!.data!.farmerProject![0].projectStatus.toString().toUpperCase() == "survey_accepted".toUpperCase()
                                || state.responseFarmerProjectDetail!.data!.farmerProject![0].projectStatus.toString().toUpperCase() == "survey_completed".toUpperCase()
                                || state.responseFarmerProjectDetail!.data!.farmerProject![0].projectStatus.toString().toUpperCase() == "verified".toUpperCase()
                                || state.responseFarmerProjectDetail!.data!.farmerProject![0].projectStatus.toString().toUpperCase() == "approved".toUpperCase() ?
                            Column(
                              children: [
                                20.verticalSpace(),
                                Center(
                                  child: customButton(
                                      'Revoke',
                                      color: 0xffFC5E60,
                                      style: figtreeMedium.copyWith(fontSize: 16, color: Colors.white),
                                      onTap: (){
                                        AddRemarkRevoke(projectData:state.responseFarmerProjectDetail!.data!.farmerProject![0].farmerMaster!,farmerProjectId:widget.projectId).navigate();
                                      }

                                  ),
                                ),

                                5.verticalSpace(),

                                "Tap above to revoke the loan application.".textMedium(color: const Color(0xff727272)),

                              ],
                            ):const SizedBox.shrink():const SizedBox.shrink(),

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
                        'project_image': state.responseFarmerProjectDetail!.data!.farmerProject![0].project["image"].toString(),
                        'created_at': Timestamp.now(),
                        'farmer_name': state.responseFarmerProjectDetail!.data!.farmerProject![0].farmerMaster!.name.toString(),
                        'farmer_address': state.responseFarmerProjectDetail!.data!.farmerProject![0].farmerMaster!.address!=null?state.responseFarmerProjectDetail!.data!.farmerProject![0].farmerMaster!.address!.address!=null?state.responseFarmerProjectDetail!.data!.farmerProject![0].farmerMaster!.address!.address!.toString():'':'',
                        // 'user_type': 'farmer',
                      }, SetOptions(merge: true));


                      ResponseProjectDataForFirebase response = ResponseProjectDataForFirebase(
                          projectName: state.responseFarmerProjectDetail!.data!.farmerProject![0].name!.toString(),
                          farmerProjectId: state.responseFarmerProjectDetail!.data!.farmerProject![0].id,
                          userName: await SharedPrefManager.getPreferenceString(AppConstants.userName),
                          userType: 'farmer',
                      farmerId: state.responseFarmerProjectDetail!.data!.farmerProject![0].farmerMaster!.id.toString(),
                      ddeId: state.responseFarmerProjectDetail!.data!.farmerProject!=null?state.responseFarmerProjectDetail!.data!.farmerProject![0].ddeId.toString():'',
                      mccId: state.responseFarmerProjectDetail!.data!.farmerProject![0].farmerMaster!=null?state.responseFarmerProjectDetail!.data!.farmerProject![0].farmerMaster!.mccId.toString():'',
                      supplierId: state.responseFarmerProjectDetail!.data!.supplierDetail!=null?state.responseFarmerProjectDetail!.data!.supplierDetail!.id.toString():'',
                      farmerName: state.responseFarmerProjectDetail!.data!.farmerProject![0].farmerMaster!.name.toString(),
                      farmerAddress: state.responseFarmerProjectDetail!.data!.farmerProject![0].farmerMaster!.address!=null?state.responseFarmerProjectDetail!.data!.farmerProject![0].farmerMaster!.address!.address.toString():'',
                          projectImage: state.responseFarmerProjectDetail!.data!
                              .farmerProject![0].project["image"]
                              .toString());

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
                  ))
            ],
          );
        }
      }),
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
                  padding: const EdgeInsets.symmetric(vertical: 4, horizontal: 7),
                  decoration: boxDecoration(
                    borderWidth: 1,
                    borderRadius: 30,
                    borderColor: const Color(0xff6A0030),
                  ),
                  child: Text(
                    formatProjectStatus(state.responseFarmerProjectDetail!.data!.farmerProject![0].projectStatus ?? '') ,
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
                if (state.responseFarmerProjectDetail!.data!.farmerProject![0]
                    .projectStatus ==
                    'active' ||
                    state.responseFarmerProjectDetail!.data!.farmerProject![0]
                        .projectStatus ==
                        'hold')
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
                  if(state.responseFarmerProjectDetail!.data!.farmerProject![0].paymentStatus != null &&state.responseFarmerProjectDetail!.data!.farmerProject![0].paymentStatus == "paid")
                    SvgPicture.asset(Images.paid)
                  else
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


  ///////////SupplierContainerTimeline/////////////
  Widget supplier(contexts, ProjectState state) {
    return state.responseFarmerProjectDetail!.data!.farmerProject![0].projectStatus == "completed"?
    Stack(
      alignment: Alignment.center,
      children: [
        SizedBox(
            height: state.responseFarmerProjectDetail!.data!.farmerRatingForSupplier == null?
            state.responseFarmerProjectDetail!.data!.farmerRatingForSupplier != null && state.responseFarmerProjectDetail!.data!.supplierRatingForFarmer == null?170:200:242,
            width: screenWidth()),
        Container(
          height: state.responseFarmerProjectDetail!.data!.farmerRatingForSupplier == null?
          state.responseFarmerProjectDetail!.data!.farmerRatingForSupplier != null && state.responseFarmerProjectDetail!.data!.supplierRatingForFarmer == null?110:138:178,
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
                          imageUrl: state.responseFarmerProjectDetail!.data!.supplierDetail!.photo.toString() == false.toString() ? '': state.responseFarmerProjectDetail!.data!.supplierDetail!.photo ?? '',
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
                        Text(state.responseFarmerProjectDetail!.data!.supplierDetail!.name ?? '',
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
                            Text(state.responseFarmerProjectDetail!.data!.supplierDetail!.phone ?? '',
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
                                state.responseFarmerProjectDetail!.data!.supplierDetail!.address != null
                                    ? state.responseFarmerProjectDetail!.data!.supplierDetail!.address["address"] != null
                                    && state.responseFarmerProjectDetail!.data!.supplierDetail!.address["sub_county"] != null
                                    ? state.responseFarmerProjectDetail!.data!.supplierDetail!.address["sub_county"] +
                                    state.responseFarmerProjectDetail!.data!.supplierDetail!.address["address"]
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

                if(state.responseFarmerProjectDetail!.data!.farmerRatingForSupplier == null)
                  Column(
                    children: [
                      15.verticalSpace(),
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
                                                          context.read<ProjectCubit>().projectRatingApi(context, widget.projectId.toString(),'supplier' ,state.responseFarmerProjectDetail!.data!.supplierDetail!.id.toString() ,rating.toString() , controller.text.toString());
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
                      ),
                    ],
                  )
                else if(state.responseFarmerProjectDetail!.data!.farmerRatingForSupplier != null && state.responseFarmerProjectDetail!.data!.supplierRatingForFarmer == null)
                    const SizedBox.shrink()
                else
                    Container(
                      width: screenWidth(),
                      height: 72,
                      padding: const EdgeInsets.all(10),
                      margin: const EdgeInsets.only(right: 12,top: 5),
                      decoration: boxDecoration(
                        backgroundColor: const Color(0xffFFF3F4),
                        borderRadius: 10,
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              "Feedback for you:".toString().textMedium(
                                  color: Colors.black,
                                  fontSize: 14
                              ),

                              Padding(
                                padding: const EdgeInsets.only(right: 10.0),
                                child: RatingBar.builder(
                                  initialRating: double.parse(state.responseFarmerProjectDetail!.data!.supplierRatingForFarmer![0].rating.toString()),
                                  minRating: 0,
                                  itemSize: 20,
                                  direction: Axis.horizontal,
                                  allowHalfRating: false,
                                  itemCount: 5,
                                  ignoreGestures: true,
                                  tapOnlyMode: false,
                                  updateOnDrag: false,
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


                          state.responseFarmerProjectDetail!.data!.supplierRatingForFarmer![0].feedback!=null?state.responseFarmerProjectDetail!.data!.supplierRatingForFarmer![0].feedback.toString().textRegular(fontSize: 12,
                              maxLines: 2,overflow: TextOverflow.ellipsis):const SizedBox.shrink()
                        ],
                      ),
                    ),



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
                    onTap: (){
                      callOnMobile(state.responseFarmerProjectDetail!.data!.supplierDetail!.phone ?? '');
                    }, child: SvgPicture.asset(Images.callPrimary)),
                6.horizontalSpace(),
                InkWell(onTap: ()async{
                  await launchWhatsApp(state.responseFarmerProjectDetail!.data!.supplierDetail!.phone ?? '');
                },child: SvgPicture.asset(Images.whatsapp)),
                6.horizontalSpace(),
              ],
            )),
      ],
    ):
    Stack(
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
                      imageUrl: state.responseFarmerProjectDetail!.data!.supplierDetail!.photo.toString() == false.toString() ? '': state.responseFarmerProjectDetail!.data!.supplierDetail!.photo ?? '',
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
                    Text(state.responseFarmerProjectDetail!.data!.supplierDetail!.name ?? '',
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
                        Text(state.responseFarmerProjectDetail!.data!.supplierDetail!.phone ?? '',
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
                            state.responseFarmerProjectDetail!.data!.supplierDetail!.address != null
                                ? state.responseFarmerProjectDetail!.data!.supplierDetail!.address["address"] != null
                                && state.responseFarmerProjectDetail!.data!.supplierDetail!.address["sub_county"] != null
                                ? state.responseFarmerProjectDetail!.data!.supplierDetail!.address["sub_county"] +
                                state.responseFarmerProjectDetail!.data!.supplierDetail!.address["address"]
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
                    onTap: (){
                      callOnMobile(state.responseFarmerProjectDetail!.data!.supplierDetail!.phone ?? '');
                    }, child: SvgPicture.asset(Images.callPrimary)),
                6.horizontalSpace(),
                InkWell(onTap: ()async{
                  await launchWhatsApp(state.responseFarmerProjectDetail!.data!.supplierDetail!.phone ?? '');
                },child: SvgPicture.asset(Images.whatsapp)),
                6.horizontalSpace(),
              ],
            )),
      ],
    );
  }

///////////DDEContainerTimeline/////////////
  Widget dde(contexts, ProjectState state) {

    return state.responseFarmerProjectDetail!.data!.farmerProject![0].projectStatus == "completed"?
    Stack(
      alignment: Alignment.center,
      children: [
        SizedBox(height: state.responseFarmerProjectDetail!.data!.farmerRatingForDde == null?
        state.responseFarmerProjectDetail!.data!.farmerRatingForDde != null && state.responseFarmerProjectDetail!.data!.ddeRatingForFarmer == null?210:265:265, width: screenWidth()),
        Container(
          height: state.responseFarmerProjectDetail!.data!.farmerRatingForDde==null?
          state.responseFarmerProjectDetail!.data!.farmerRatingForDde != null && state.responseFarmerProjectDetail!.data!.ddeRatingForFarmer == null?150:205:215,
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
                          imageUrl: state.responseFarmerProjectDetail!.data!.farmerProject![0].dairyDevelopMentExecutive!.photo ?? '',
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
                        Text(state.responseFarmerProjectDetail!.data!.farmerProject![0].dairyDevelopMentExecutive!.name ?? '',
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
                            Text(state.responseFarmerProjectDetail!.data!.farmerProject![0].dairyDevelopMentExecutive!.phone ?? '',
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
                                state.responseFarmerProjectDetail!.data!.farmerProject![0].dairyDevelopMentExecutive!.address != null
                                    ? state.responseFarmerProjectDetail!.data!.farmerProject![0].dairyDevelopMentExecutive!.address["address"]
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
                const Padding(
                  padding: EdgeInsets.only(right: 15.0),
                  child: Divider(),
                ),
                Padding(
                  padding: const EdgeInsets.only(right: 15.0),
                  child: Text(
                    'You may contact our Dairy Development Executive (DDE) for any assistance related to application processing.',
                    style: figtreeRegular.copyWith(fontSize: 12),
                    textAlign: TextAlign.center,
                  ),
                ),

                if(state.responseFarmerProjectDetail!.data!.ddeRatingForFarmer == null)
                  Column(
                    children: [
                      13.verticalSpace(),
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
                                                          context.read<ProjectCubit>().projectRatingApi(context, widget.projectId.toString(),'dde' ,state.responseFarmerProjectDetail!.data!.farmerProject![0].dairyDevelopMentExecutive!.id.toString() ,rating.toString() , controller.text.toString());
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
                      ),
                    ],
                  )
                 else if(state.responseFarmerProjectDetail!.data!.ddeRatingForFarmer != null && state.responseFarmerProjectDetail!.data!.farmerRatingForDde == null)
                  const SizedBox.shrink()
                else
                  Container(
                    width: screenWidth(),
                    height: 73,
                    padding: const EdgeInsets.all(10),
                    margin: const EdgeInsets.only(right: 12,top: 5),
                    decoration: boxDecoration(
                      backgroundColor: const Color(0xffFFF3F4),
                      borderRadius: 10,
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(

                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            "Feedback for you:".toString().textMedium(
                                color: Colors.black,
                                fontSize: 14
                            ),

                            Padding(
                              padding: const EdgeInsets.only(right: 10.0),
                              child: RatingBar.builder(
                                initialRating: double.parse(state.responseFarmerProjectDetail!.data!.ddeRatingForFarmer![0].rating!=null?state.responseFarmerProjectDetail!.data!.ddeRatingForFarmer![0].rating!.toString():'0'),
                                minRating: 0,
                                itemSize: 20,
                                direction: Axis.horizontal,
                                allowHalfRating: false,
                                itemCount: 5,
                                ignoreGestures: true,
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
                        state.responseFarmerProjectDetail!.data!.ddeRatingForFarmer![0].feedback!=null?state.responseFarmerProjectDetail!.data!.ddeRatingForFarmer![0].feedback!.toString().textRegular(fontSize: 12,
                            maxLines: 2,overflow: TextOverflow.ellipsis):const SizedBox.shrink()
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
              'DDE',
              style: figtreeMedium.copyWith(fontSize: 20),
            )),
        Positioned(
            top: 0,
            right: 10,
            child: Row(
              children: [
                InkWell(
                    onTap: (){
                      callOnMobile(state.responseFarmerProjectDetail!.data!.farmerProject![0].dairyDevelopMentExecutive!.phone ?? '');
                    }, child: SvgPicture.asset(Images.callPrimary)),
                6.horizontalSpace(),
                InkWell(onTap: ()async{
                  await launchWhatsApp(state.responseFarmerProjectDetail!.data!.farmerProject![0].dairyDevelopMentExecutive!.phone ?? '');
                },child: SvgPicture.asset(Images.whatsapp)),
                6.horizontalSpace(),
              ],
            )),
      ],
    ):
    Stack(
      alignment: Alignment.center,
      children: [
        SizedBox(height: 220, width: screenWidth()),
        Container(
          height: 170,
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
                          imageUrl: state.responseFarmerProjectDetail!.data!.farmerProject![0].dairyDevelopMentExecutive!.photo ?? '',
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
                        Text(state.responseFarmerProjectDetail!.data!.farmerProject![0].dairyDevelopMentExecutive!.name ?? '',
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
                            Text(state.responseFarmerProjectDetail!.data!.farmerProject![0].dairyDevelopMentExecutive!.phone ?? '',
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
                                state.responseFarmerProjectDetail!.data!.farmerProject![0].dairyDevelopMentExecutive!.address != null
                                    ? state.responseFarmerProjectDetail!.data!.farmerProject![0].dairyDevelopMentExecutive!.address["address"] ?? ''
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
                const Padding(
                  padding: EdgeInsets.only(right: 15.0),
                  child: Divider(),
                ),
                Padding(
                  padding: const EdgeInsets.only(right: 15.0),
                  child: Text(
                    'You may contact our Dairy Development Executive (DDE) for any assistance related to application processing.',
                    style: figtreeRegular.copyWith(fontSize: 12),
                    textAlign: TextAlign.center,
                  ),
                ),
              ],
            ),
          ),
        ),
        Positioned(
            top: -1,
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
                InkWell(
                  onTap: (){
                    callOnMobile(state.responseFarmerProjectDetail!.data!.farmerProject![0].dairyDevelopMentExecutive!.phone ?? '');
                  }, child: SvgPicture.asset(Images.callPrimary)),
                6.horizontalSpace(),
                InkWell(onTap: ()async{
                  await launchWhatsApp(state.responseFarmerProjectDetail!.data!.farmerProject![0].dairyDevelopMentExecutive!.phone ?? '');
                },child: SvgPicture.asset(Images.whatsapp)),
                6.horizontalSpace(),
              ],
            )),
      ],
    );
  }

/////////KPI///////////////////////
  Widget kpi(contexts,ProjectState state,MediaQueryData mediaData) {
    List<FrontendKpiModel> kpiData = [];
    if (state.responseFarmerProjectDetail!.data!.farmerProject![0].kpi!
        .investment != null) {
      kpiData.add(FrontendKpiModel(name: 'Project Cost',
          image: Images.investmentKpi,
          value: getCurrencyString(
              state.responseFarmerProjectDetail!.data!.farmerProject![0].kpi!
                  .investment!)));
    }

    if (state.responseFarmerProjectDetail!.data!.farmerProject![0].kpi!
        .farmerParticipation != null) {
      kpiData.add(FrontendKpiModel(name: 'Farmer Participation',
          image: Images.farmerParticipationKpi,
          actionImage: ["suggested","interested","rejected","deferred","survey_completed","survey_requested","survey_pending"].contains(state.responseFarmerProjectDetail!.data!.farmerProject![0].projectStatus)?Images.imageEdit:null,
          value: getCurrencyString(
              state.responseFarmerProjectDetail!.data!.farmerProject![0].kpi!
                  .farmerParticipation!)));
    }

    if (state.responseFarmerProjectDetail!.data!.farmerProject![0].kpi!.principleAmount !=
        null) {
      kpiData.add(FrontendKpiModel(name: 'GLAD Participation',
          image: Images.loanKpi,
          value: getCurrencyString(
              state.responseFarmerProjectDetail!.data!.farmerProject![0].kpi!
                  .principleAmount!)));
    }

    if (state.responseFarmerProjectDetail!.data!.farmerProject![0].kpi!.loan !=
        null) {
      kpiData.add(FrontendKpiModel(name: 'Total Repayment',
          image: Images.loanKpi,
          value: getCurrencyString(
              state.responseFarmerProjectDetail!.data!.farmerProject![0].kpi!
                  .loan!)));
    }

    if (state.responseFarmerProjectDetail!.data!.farmerProject![0].kpi!
        .revenue != null) {
      kpiData.add(FrontendKpiModel(name: 'Annual Incremental Income',
          image: Images.revenueKpi,
          value: getCurrencyString(
              state.responseFarmerProjectDetail!.data!.farmerProject![0].kpi!
                  .revenue!)));
    }

    if (state.responseFarmerProjectDetail!.data!.farmerProject![0].kpi!.roi !=
        null) {
      kpiData.add(FrontendKpiModel(name: 'ROI',
          image: Images.roiKpi,
          value: "${state.responseFarmerProjectDetail!.data!.farmerProject![0]
              .kpi!.roi!}%"));
    }


    if (state.responseFarmerProjectDetail!.data!.farmerProject![0].kpi!
        .repayment != null) {
      kpiData.add(FrontendKpiModel(name: 'Repayment Tenure',
          image: Images.repaymentKpi,
          actionImage: ["suggested","interested","rejected","deferred","survey_completed","survey_requested","survey_pending"].contains(state.responseFarmerProjectDetail!.data!.farmerProject![0].projectStatus)?Images.imageEdit:null,
          value: "${state.responseFarmerProjectDetail!.data!.farmerProject![0]
              .kpi!.repayment!} MO"));
    }

    if(['active', 'hold', "paid", 'completed'].contains(state.responseFarmerProjectDetail!.data!.farmerProject![0].projectStatus)) {
      if(state.responseFarmerProjectDetail!.data!.farmerProject![0].kpi!.repaymentStartDate!=null){
        kpiData.add(FrontendKpiModel(name: 'Repayment Start Date',
            image: Images.yieldKpi,
            value: DateFormat('dd MMM, yyyy').format(DateTime.parse(state.responseFarmerProjectDetail!.data!.farmerProject![0].kpi!.repaymentStartDate!))
        ));
      }
    }

    if(state.responseFarmerProjectDetail!.data!.farmerProject![0].kpi!.emi!=null){
      kpiData.add(FrontendKpiModel(name: 'EMI',
          image: Images.emiKpi,
          value: getCurrencyString(state.responseFarmerProjectDetail!.data!.farmerProject![0].kpi!.emi!)));
    }

    if(['active', 'hold', "paid", 'completed'].contains(state.responseFarmerProjectDetail!.data!.farmerProject![0].projectStatus)) {


      if(state.responseFarmerProjectDetail!.data!.farmerProject![0].kpi!.paidEmis!=null){
        kpiData.add(FrontendKpiModel(name: 'Paid EMIs',
            image: Images.yieldKpi,
            actionImage: Images.menuIcon,
            value: "${state.responseFarmerProjectDetail!.data!.farmerProject![0].kpi!.paidEmis!}"
        ));
      }

      if(state.responseFarmerProjectDetail!.data!.farmerProject![0].kpi!.remainingEmiValue!=null){
        kpiData.add(FrontendKpiModel(name: 'Remaining Amount',
            image: Images.yieldKpi,
            actionImage: Images.menuIcon,
            value: getCurrencyString(state.responseFarmerProjectDetail!.data!.farmerProject![0].kpi!.remainingEmiValue!)
        ));
      }
    }

    if(state.responseFarmerProjectDetail!.data!.farmerProject![0].kpi!.currentYield!=null){
      kpiData.add(FrontendKpiModel(name: 'Current Yield',
        image: Images.yieldKpi,
        // actionImage: Images.menuIcon,
        value: '${state.responseFarmerProjectDetail!.data!.farmerProject![0].kpi!.currentYield!} Ltr.',
      ));
    }

    if(state.responseFarmerProjectDetail!.data!.farmerProject![0].kpi!.expectedYield!=null){
      kpiData.add(FrontendKpiModel(name: 'Target Yield',
        image: Images.yieldKpi,
        value: '${state.responseFarmerProjectDetail!.data!.farmerProject![0].kpi!.expectedYield!} Ltr.',
      ));
    }

    if(state.responseFarmerProjectDetail!.data!.farmerProject![0].kpi!.idealYield!=null){
      kpiData.add(FrontendKpiModel(name: 'Ideal Yield',
          image: Images.idealKpi,
          value: "${state.responseFarmerProjectDetail!.data!.farmerProject![0].kpi!.idealYield!} Ltr."
      ));
    }

    if(state.responseFarmerProjectDetail!.data!.farmerProject![0].kpi!.targetFarmProduction!=null){
      kpiData.add(FrontendKpiModel(name: 'Target Farm Production',
          image: Images.yieldKpi,
          value: getCurrencyString(
              state.responseFarmerProjectDetail!.data!.farmerProject![0].kpi!
                  .targetFarmProduction!)
          // value: "${state.responseFarmerProjectDetail!.data!.farmerProject![0].kpi!.targetFarmProduction!} Ltr."
      ));
    }

    if(state.responseFarmerProjectDetail!.data!.farmerProject![0].kpi!.milkMsp!=null){
      kpiData.add(FrontendKpiModel(name: 'MSP',
          image: Images.yieldKpi,
          value: "${state.responseFarmerProjectDetail!.data!.farmerProject![0].kpi!.milkMsp!} Ltr"
      ));
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
            mainAxisExtent: 130,
            child: (index){
              return MediaQuery(
                data: screenWidth()<380 ? mediaData.copyWith(textScaleFactor: 0.91):mediaData.copyWith(textScaleFactor: 1),
                child: InkWell(
                  onTap: (){
                    if(kpiData[index].name.toString() == "Paid EMIs"){
                      ProjectDetailFarmerStatement(userRoleId: state.responseFarmerProjectDetail!.data!.farmerProject![0].farmerMaster!.id.toString(),farmerProjectId: widget.projectId.toString(),status: 'paid',).navigate();
                    }else if(kpiData[index].name.toString() == "Remaining Payable"){
                      ProjectDetailFarmerStatement(userRoleId: state.responseFarmerProjectDetail!.data!.farmerProject![0].farmerMaster!.id.toString(),farmerProjectId: widget.projectId.toString(),status: 'due',).navigate();
                    }
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
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              SvgPicture.asset(
                                kpiData[index].image.toString(),
                                width: 30,
                                height: 30,
                              ),

                              kpiData[index].actionImage!=null?
                              kpiData[index].name.toString() == "Farmer Participation" || kpiData[index].name.toString() == "Repayment Tenure"?
                              state.responseFarmerProjectDetail!.data!.farmerProject![0].farmerParticipationStatus.toString() == 'pending'?
                              state.responseFarmerProjectDetail!.data!.farmerProject![0].projectStatus.toString() == "hold"||state.responseFarmerProjectDetail!.data!.farmerProject![0].projectStatus.toString() == "completed"?
                              const Align(alignment: Alignment.centerRight,child: Icon(Icons.watch_later,color: Colors.amber,size: 20,)):
                              InkWell(
                                  onTap: (){
                                    TextEditingController controller = TextEditingController();
                                    controller.text = currencyFormatter().format(state.responseFarmerProjectDetail!.data!.farmerProject![0].kpi!.farmerParticipation!.toString());
                                    if(kpiData[index].name.toString() == "Farmer Participation"){
                                      modalBottomSheetMenu(context,
                                          radius: 40,
                                          child: StatefulBuilder(
                                              builder: (context, setState) {
                                                return SizedBox(
                                                  height: 320,
                                                  child: Padding(
                                                    padding: const EdgeInsets.fromLTRB(23, 40, 25, 10),
                                                    child: Column(
                                                        crossAxisAlignment: CrossAxisAlignment.start,
                                                        children: [
                                                          Center(
                                                            child: Text(
                                                              'Farmer Participation',
                                                              style: figtreeMedium.copyWith(fontSize: 22),
                                                            ),
                                                          ),
                                                          30.verticalSpace(),

                                                          Column(
                                                            crossAxisAlignment: CrossAxisAlignment.start,
                                                            children: [
                                                              Text(
                                                                'Participation Value',
                                                                style: figtreeMedium.copyWith(fontSize: 12),
                                                              ),
                                                              5.verticalSpace(),
                                                              TextField(
                                                                controller: controller,
                                                                maxLines: 1,
                                                                keyboardType: TextInputType.number,
                                                                inputFormatters: [
                                                                  currencyFormatter()
                                                                  // FilteringTextInputFormatter.digitsOnly
                                                                ],
                                                                minLines: 1,
                                                                decoration: InputDecoration(
                                                                    hintText: 'Enter participation value',
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
                                                                    if(controller.text.isEmpty){
                                                                      showCustomToast(context, "Please enter participation value");
                                                                    }else{
                                                                      BlocProvider.of<ProjectCubit>(context).farmerParticipationApi(context,state.responseFarmerProjectDetail!.data!.farmerProject![0].farmerId.toString(),state.responseFarmerProjectDetail!.data!.farmerProject![0].id.toString(), controller.text.replaceAll(",", ""),widget.projectId);
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
                                    }

                                    if (kpiData[index]
                                        .name
                                        .toString() ==
                                        "Repayment Tenure") {
                                      int quantity;
                                      if(state
                                          .responseFarmerProjectDetail!
                                          .data!
                                          .farmerProject![0].minRepaymentMonths !=null){
                                        quantity = int.parse(state
                                            .responseFarmerProjectDetail!
                                            .data!
                                            .farmerProject![0].minRepaymentMonths.toString());
                                      }else{
                                        quantity = 0;
                                      }
                                      modalBottomSheetMenu(context,
                                          radius: 40, child:
                                          StatefulBuilder(builder:
                                              (context,
                                              setState) {
                                            return SizedBox(
                                              height: 200,
                                              width: screenWidth(),
                                              child: Column(
                                                children: [
                                                  20.verticalSpace(),
                                                  Container(
                                                    height: 52,
                                                    decoration: BoxDecoration(
                                                        border: Border.all(color: Colors.black,width: 1.5),
                                                        borderRadius: BorderRadius.circular(10),
                                                        color: Colors.white
                                                    ),
                                                    width: screenWidth()-50,
                                                    padding: const EdgeInsets.symmetric(horizontal: 20),
                                                    child: Row(
                                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                      children: [
                                                        InkWell(
                                                            onTap: () {
                                                              if(quantity == 0) {
                                                                return;
                                                              }
                                                              if(state
                                                                  .responseFarmerProjectDetail!
                                                                  .data!
                                                                  .farmerProject![0].minRepaymentMonths!=null){

                                                                if(quantity>state
                                                                    .responseFarmerProjectDetail!
                                                                    .data!
                                                                    .farmerProject![0].minRepaymentMonths){
                                                                  quantity--;
                                                                }else{

                                                                  showCustomToast(context, "Minimum repayment month can be ${state
                                                                      .responseFarmerProjectDetail!
                                                                      .data!
                                                                      .farmerProject![0].minRepaymentMonths.toString()}");
                                                                }
                                                              }else{
                                                                quantity--;
                                                              }
                                                              // }
                                                              setState(() {

                                                              });
                                                            },
                                                            child: SvgPicture.asset(Images.minusQuant)),
                                                        quantity.toString().textMedium(fontSize: 16, color: Colors.black),
                                                        InkWell(
                                                            onTap: () {
                                                              if(quantity == 1000) {
                                                                return;
                                                              }
                                                              if(quantity<state
                                                                  .responseFarmerProjectDetail!
                                                                  .data!
                                                                  .farmerProject![0].maxRepaymentMonths){
                                                                quantity++;
                                                              }else{
                                                                showCustomToast(context, "Repayment month should not be greater than ${state
                                                                    .responseFarmerProjectDetail!
                                                                    .data!
                                                                    .farmerProject![0].maxRepaymentMonths.toString()} month");
                                                              }
                                                              setState(() {

                                                              });
                                                            },
                                                            child: SvgPicture.asset(Images.addQuant)),

                                                      ],),
                                                  ),
                                                  20.verticalSpace(),
                                                  SizedBox(
                                                    width: screenWidth()-50,
                                                    child: customButton("Submit", fontColor: 0xFFFFFFFF,onTap: (){
                                                      BlocProvider.of<ProjectCubit>(context).updateFarmerRepaymentMonthsApi(context,
                                                          state.responseFarmerProjectDetail!.data!.farmerProject![0].farmerId.toString(),
                                                          state.responseFarmerProjectDetail!.data!.farmerProject![0].id.toString(),
                                                          quantity.toString(),
                                                          widget.projectId);
                                                    }),
                                                  )
                                                ],
                                              ),
                                            );
                                          }));
                                    }


                                  }, child: SvgPicture.asset(kpiData[index].actionImage.toString())):
                              const Align(alignment: Alignment.centerRight,child: Icon(Icons.check_circle,color: Colors.green,size: 20,))
                                  :SvgPicture.asset(kpiData[index].actionImage.toString()):const SizedBox.shrink()
                              /*kpiData[index].actionImage!=null?
                              SvgPicture.asset(kpiData[index].actionImage.toString()):
                                  const SizedBox.shrink()*/
                            ],
                          ),
                          15.verticalSpace(),
                          Text(
                            '${kpiData[index].value}',
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: figtreeMedium.copyWith(fontSize: 12),
                          ),
                          05.verticalSpace(),
                          Text(
                            kpiData[index].name.toString(),
                            maxLines: 3,
                            overflow: TextOverflow.ellipsis,
                            style: figtreeRegular.copyWith(
                              fontSize: 10,
                            ),
                          )
                        ],
                      ),
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
      Text(
        'Project milestones',
        style: figtreeMedium.copyWith(fontSize: 18),
      ),
      15.verticalSpace(),
      customList(
        list: List.generate(state.responseFarmerProjectDetail!.data!.farmerProject![0].farmerProjectMilestones!.length, (index) => null),
          axis: Axis.vertical,
          child: (int index) {
            return Padding(
              padding: const EdgeInsets.only(
                bottom: 20,
              ),
              child: InkWell(
                onTap: () {
                  SuggestedProjectMilestoneDetail(milestoneId:
                  state.responseFarmerProjectDetail!.data!.farmerProject![0].farmerProjectMilestones![index].id,
                  projectStatus:state.responseFarmerProjectDetail!.data!.farmerProject![0].projectStatus.toString()
                  // projectId:state.responseFarmerProjectDetail!.data!.farmerProject![0].id
                  ,farmerLogin:"farmer").navigate();
                },
                child: customProjectContainer(
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
                                state.responseFarmerProjectDetail!.data!.farmerProject![0].farmerProjectMilestones![index].milestoneTitle ?? '',
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

      20.verticalSpace(),
    ]);
  }

  /////////////InviteExpert/////////
  Widget inviteExpert(BuildContext contexts, ProjectState  state) {
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
                                      controller: TextEditingController()..text = date,
                                        onTap: () async{
                                          var selectDate = await selectedFutureDate(context);
                                          date = "${selectDate.year}/${selectDate.month}/${selectDate.day}";
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
                                      padding: const EdgeInsets.fromLTRB(28, 0, 29, 0),
                                      child: customButton(
                                        'Submit',
                                        fontColor: 0xffFFFFFF,
                                        onTap: () {
                                          if(state.responseFarmerProjectDetail!.data!.farmerProject![0].projectStatus.toString() == "not_interested" ){
                                            context.read<ProjectCubit>().inviteExpertForSurvey(context,
                                                state.responseFarmerProjectDetail!.data!.farmerProject![0].id,
                                                date,
                                                controller.text ?? '',
                                                'interested',state.responseFarmerProjectDetail!.data!.farmerProject![0].farmerId.toString()
                                            );
                                          }else{
                                          if(date == ""){
                                            showCustomToast(context, "Please select date");
                                          }else{
                                            context.read<ProjectCubit>().inviteExpertForSurvey(context,
                                                state.responseFarmerProjectDetail!.data!.farmerProject![0].id,
                                                date,
                                                controller.text ?? '',
                                                'interested',state.responseFarmerProjectDetail!.data!.farmerProject![0].farmerId.toString()
                                            );
                                          }}

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
          ),
        )),
        20.verticalSpace(),
        if(state.responseFarmerProjectDetail!.data!.farmerProject![0].projectStatus.toString() != "not_interested")
        InkWell(
          onTap: () {
            TextEditingController controller = TextEditingController();
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
                                      enabled: false,
                                      controller: TextEditingController(),
                                      onTap: () async{
                                        // var selectDate = await selectedFutureDate(context);
                                        // date = "${selectDate.year}/${selectDate.month}/${selectDate.day}";
                                        // setState(() {});
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
                                      padding: const EdgeInsets.fromLTRB(28, 0, 29, 0),
                                      child: customButton(
                                        'Submit',
                                        fontColor: 0xffFFFFFF,
                                        onTap: () {
                                          context.read<ProjectCubit>().inviteExpertForSurvey(context,
                                              state.responseFarmerProjectDetail!.data!.farmerProject![0].id,
                                              '',
                                              '',
                                              'not_interested',state.responseFarmerProjectDetail!.data!.farmerProject![0].farmerId.toString()
                                          );
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
            // customDialog(
            //     widget: Center(
            //       child: Material(
            //         borderRadius: BorderRadius.circular(15),
            //         child: Container(
            //           height: 135,
            //           width: screenWidth()-30,
            //           decoration: BoxDecoration(
            //             borderRadius: BorderRadius.circular(15),
            //           ),
            //           child: Column(
            //             mainAxisAlignment: MainAxisAlignment.center,
            //             children: [
            //
            //               "Are you sure u are not interested?".textMedium(
            //                   fontSize: 19,
            //                   color: Colors.black
            //               ),
            //
            //               20.verticalSpace(),
            //
            //               Row(
            //                 children: [
            //
            //                   20.horizontalSpace(),
            //
            //                   Expanded(
            //                     child: customButton("No",
            //                         borderColor: 0xFF6A0030,
            //                         color: 0xFFffffff,onTap: (){
            //                           pressBack();
            //                         }),
            //                   ),
            //
            //                   20.horizontalSpace(),
            //
            //                   Expanded(
            //                     child: customButton("Yes",fontColor: 0xFFffffff, onTap: (){
            //                       // context.read<ProjectCubit>().updateSuggestedProjectStatus(context, 'Not Interested' , state.responseFarmerProjectDetail!.data!.farmerProject![0].id);
            //                       context.read<ProjectCubit>().inviteExpertForSurvey(context,
            //                           state.responseFarmerProjectDetail!.data!.farmerProject![0].id,
            //                           '',
            //                           '',
            //                           'Not Interested',state.responseFarmerProjectDetail!.data!.farmerProject![0].farmerId.toString()
            //                       );
            //                     }),
            //                   ),
            //
            //                   20.horizontalSpace(),
            //
            //                 ],
            //               ),
            //
            //             ],
            //           ),
            //         ),
            //       ),
            //     )
            // );
          },
            child: Text('Not Interested', style: figtreeMedium.copyWith(fontSize: 16, color: Colors.grey, decoration: TextDecoration.underline), )),
        20.verticalSpace(),
      ],
    );
  }
}
