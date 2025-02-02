import 'dart:io';
import 'package:get/get.dart';
import 'package:glad/data/model/loan_purpose_list.dart' as loan;
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:glad/cubit/livestock_cubit/livestock_cubit.dart';
import 'package:glad/data/model/auth_models/mail_login_model.dart';
import 'package:glad/data/model/dde_project_model.dart';
import 'package:glad/data/model/farmer_project_detail_model.dart' as dde;
import 'package:glad/data/model/farmer_project_milestone_detail_model.dart';
import 'package:glad/data/model/farmer_project_model.dart';
import 'package:glad/data/model/farmers_list.dart';
import 'package:glad/data/model/loan_purpose_list.dart';
import 'package:glad/data/model/response_account_statement.dart';
import 'package:glad/data/model/response_area_filter_list.dart';
import 'package:glad/data/model/response_capacity_list.dart';
import 'package:glad/data/model/response_custom_loan_list.dart';
import 'package:glad/data/model/response_farmer_filter_list.dart';
import 'package:glad/data/model/response_loan_calculation.dart';
import 'package:glad/data/model/response_loan_form.dart';
import 'package:glad/data/model/response_milestone_name.dart';
import 'package:glad/data/model/response_project_supplier_filter_list.dart';
import 'package:glad/data/model/response_resource_name.dart';
import 'package:glad/data/model/response_resource_type.dart';
import 'package:glad/data/model/supplier_project_model.dart';
import 'package:glad/data/repository/project_repo.dart';
import 'package:glad/screen/common/congratulation_screen.dart';
import 'package:glad/screen/common/thankyou_loan_livestock.dart';
import 'package:glad/screen/custom_loan/thankyou_custom_loan.dart';
import 'package:glad/screen/custom_widget/custom_methods.dart';
import 'package:glad/screen/dde_screen/add_remark.dart';
import 'package:glad/screen/dde_screen/dde_milestone_detail.dart';
import 'package:glad/screen/dde_screen/project_kyc/add_loan_remarks.dart';
import 'package:glad/screen/farmer_screen/common/suggested_project_milestone_detail.dart';
import 'package:glad/screen/farmer_screen/thankyou_screen.dart';
import 'package:glad/screen/livestock/thankyou_status_remark.dart';
import 'package:glad/screen/mcc_screen/thankyou_mcc.dart';
import 'package:glad/screen/supplier_screen/accept_screen.dart';
import 'package:glad/screen/supplier_screen/dispute_screen.dart';
import 'package:glad/screen/supplier_screen/milestone_detail.dart';
import 'package:glad/screen/supplier_screen/reject_screen.dart';
import 'package:glad/screen/supplier_screen/survey_finished.dart';
import 'package:glad/screen/supplier_screen/thankyou_confirm_participation.dart';
import 'package:glad/utils/app_constants.dart';
import 'package:glad/utils/extension.dart';
import 'package:glad/utils/helper.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../data/model/livestock_cart_list.dart' as live;

part 'project_state.dart';

class ProjectCubit extends Cubit<ProjectState> {
  final SharedPreferences sharedPreferences;
  final ProjectRepository apiRepository;

  ProjectCubit(
      {required this.apiRepository, required this.sharedPreferences})
      : super(ProjectState.initial());

  void getSelectedAttribute(String materialName,String resourceType,
      String resourceCapacityName,String uom,String requiredQty,String pricePerUnit){
    emit(state.copyWith(
        selectMaterialName: materialName,
        selectResourceType: resourceType,
        selectSizeCapacity: resourceCapacityName,
        selectProjectUOM: uom,
        requiredQtyController: TextEditingController(text: requiredQty),
        pricePerUnitController: TextEditingController(text: pricePerUnit),
        resourceTypeController: TextEditingController(text: resourceType),
        resourceCapacityController: TextEditingController(text: resourceCapacityName),
        uomController: TextEditingController(text: uom),
    ));

  }

  void roiFilter(String filter) async{
      emit(state.copyWith(roiFilter: filter));
  }

  void roiFilterClear(){
    emit(state.copyWith(
      roiFromController: TextEditingController(text: ''),
      roiUpToController: TextEditingController(text: ''),
      revenueFromController: TextEditingController(text: ''),
      revenueToController: TextEditingController(text: ''),
      investmentFromController: TextEditingController(text: ''),
      investmentUpToController: TextEditingController(text: ''),
      loanAmountFromController: TextEditingController(text: ''),
      loanAmountUpToController: TextEditingController(text: ''),
      filterImprovementAreaName: '',
      selectProjectFilter: 'Select Project Name',
      selectFarmerFilter: 'Select Farmer Name',
    ));
  }

  // farmerProjectsApi
  void farmerProjectsApi(context, String projectFilter, bool showLoader,{String? searchQuery}) async {
    if (showLoader) {
      emit(state.copyWith(status: ProjectStatus.loading));
    }
    // customDialog(widget: launchProgress());
    var response = await apiRepository.getFarmerProjectsApi(projectFilter,state.roiFilter.toString(),search: searchQuery);
    if (response.status == 200) {
      // disposeProgress();
      emit(state.copyWith(status: ProjectStatus.success, responseFarmerProject: response));
    } else {
      emit(state.copyWith(status: ProjectStatus.error));
      showCustomToast(context, response.message.toString());
    }
  }

  // farmerProjectsApi
  void ddeProjectsWithFarmerIdApi(context,String farmerId) async {
    // customDialog(widget: launchProgress());
    var response = await apiRepository.getDdeWithFarmerIdProjectsApi(farmerId);
    if (response.status == 200) {
      // disposeProgress();
      emit(state.copyWith(responseDdeProject: response));
    } else {
      // emit(state.copyWith(status: ProjectStatus.error));
      showCustomToast(context, response.message.toString());
    }
  }

  // farmerProjectsApi
  Future<void> ddeProjectsApi(context, String projectStatus, bool showLoader,{String? searchQuery}) async {
    if (showLoader) {
      emit(state.copyWith(status: ProjectStatus.loading));
    }
    var response = await apiRepository.getDdeProjectsApi(projectStatus,
      orderBy:state.roiFilter.toString(),
      revenueFromController: state.revenueFromController.text,
      revenueUpToController: state.revenueToController.text,
      investmentFromController: state.investmentFromController.text,
      investmentUpToController: state.investmentUpToController.text,
      roiFromController: state.roiFromController.text,
      roiUpToController: state.roiUpToController.text,
      loanAmountFromController: state.loanAmountFromController.text,
      loanAmountUpToController: state.loanAmountUpToController.text,
      improvementArea: state.filterImprovementAreaName,
      searchQuery:searchQuery
    );
    if (response.status == 200) {
      emit(state.copyWith(status: ProjectStatus.success, responseDdeProject: response));
    } else {
      emit(state.copyWith(status: ProjectStatus.error));
      if(response!=null){
        showCustomToast(context, response.message.toString());
      }
    }
  }

  // supplierProjectsApi
  Future<void> supplierProjectsApi(context, String projectStatus, bool showLoader) async {
    if (showLoader) {
      emit(state.copyWith(status: ProjectStatus.loading));
    }
    var response = await apiRepository.getSupplierProjectsApi(projectStatus,
      orderBy:state.roiFilter.toString(),
      revenueFromController: state.revenueFromController.text,
      revenueUpToController: state.revenueToController.text,
      investmentFromController: state.investmentFromController.text,
      investmentUpToController: state.investmentUpToController.text,
      roiFromController: state.roiFromController.text,
      roiUpToController: state.roiUpToController.text,
      loanAmountFromController: state.loanAmountFromController.text,
      loanAmountUpToController: state.loanAmountUpToController.text,
      improvementArea: state.filterImprovementAreaName,
      projectName: state.selectProjectFilter == "Select Project Name"?'':state.selectProjectFilter,
      farmerName: state.selectFarmerFilter == "Select Farmer Name"?'':state.selectFarmerFilter,
    );
    if (response.status == 200) {
      emit(state.copyWith(status: ProjectStatus.success, responseSupplierProject: response));
    } else {
      emit(state.copyWith(status: ProjectStatus.error));
      showCustomToast(context, response.message.toString());
    }
  }

  Future<void> farmerProjectDetailApi(context, int projectId) async {
    emit(state.copyWith(status: ProjectStatus.loading));
    var response = await apiRepository.getFarmerProjectDetailApi(projectId);
    if (response.status == 200) {
      emit(state.copyWith(status: ProjectStatus.success, responseFarmerProjectDetail: response));
    } else {
      emit(state.copyWith(status: ProjectStatus.error));
      showCustomToast(context ?? Get.key.currentContext, response.message.toString());
    }
  }

  Future<void> loanStatusUpdateApi(context, int id,String loanStatus, String remarks,dde.FarmerMaster profileData) async {
    emit(state.copyWith(status: ProjectStatus.loading));
    var response = await apiRepository.livestockLoanStatusUpdateApi(id, loanStatus, remarks);
    if (response.status == 200) {

      ThankStatusRemarkYou(
          profileData:profileData,loanStatus: loanStatus,
      ).navigate(isInfinity: true);
    } else {
      emit(state.copyWith(status: ProjectStatus.error));
      showCustomToast(context, response.message.toString());
    }
  }

  Future<void> farmerProjectMilestoneDetailApi(context, int milestoneId) async {
    emit(state.copyWith(status: ProjectStatus.loading));
    var response = await apiRepository.getFarmerProjectMilestoneDetailApi(milestoneId);
    if (response.status == 200) {

      // response.data!.milestoneDetails.isNotEmpty
      if(response.data!.milestoneDetails![0].resourceQty!=null){
        state.requiredQtyController.text = response.data!.milestoneDetails![0].resourceQty.toString();
      }

      if(response.data!.milestoneDetails![0].resourcePrice!=null){
        state.pricePerUnitController.text = response.data!.milestoneDetails![0].resourcePrice.toString();
      }


      emit(state.copyWith(status: ProjectStatus.success,
          responseFarmerProjectMilestoneDetail: response,
      ));
    //   selectResourceType: response.data!.milestoneDetails![0].resourceType!=null?response.data!.milestoneDetails![0].resourceType!:'Select Type',
    // selectSizeCapacity: response.data!.milestoneDetails![0].resourceCapcity!=null?response.data!.milestoneDetails![0].resourceCapcity!:'Select Size Capacity',
    // selectProjectUOM: response.data!.milestoneDetails![0].resourceUom!=null?response.data!.milestoneDetails![0].resourceUom!:'Select UOM',
    } else {
      emit(state.copyWith(status: ProjectStatus.error));
      showCustomToast(context, response.message.toString());
    }
  }

  Future<void> farmerProjectMilestoneTaskUpdateApi(context, int farmerId, int farmerProjectId, int farmerMilestoneId, int taskId, String taskStatus, String remarks, List<String> pictures, String otp) async {

    if (sharedPreferences.getString(AppConstants.userType) == 'dde') {
      customDialog(widget: launchProgress());
      var response = await apiRepository.verifyProjectStatusApi(otp, state.userIdForOtpValidate.toString());
      if(response.status == 200) {
        var response = await apiRepository.getFarmerProjectMilestoneTaskUpdateApi(
            farmerId,
            farmerProjectId,
            farmerMilestoneId,
            taskId,
            taskStatus,
            remarks,
            pictures);
        if (response.status == 200) {
          farmerProjectMilestoneDetailApi(context, farmerMilestoneId);
          farmerProjectDetailApi(context, farmerProjectId);
          disposeProgress();
          pressBack();
          pressBack();
          showCustomToast(context, response.message.toString(), isSuccess: true);
        } else {
          disposeProgress();
          showCustomToast(context, response.message.toString());
        }
      }
      else {
        showCustomToast(context, response.message.toString());
      }
    } else {
      customDialog(widget: launchProgress());
      var response = await apiRepository.getFarmerProjectMilestoneTaskUpdateApi(
          farmerId,
          farmerProjectId,
          farmerMilestoneId,
          taskId,
          taskStatus,
          remarks,
          pictures);
      if (response.status == 200) {
        farmerProjectMilestoneDetailApi(context, farmerMilestoneId);
        farmerProjectDetailApi(context, farmerProjectId);
        disposeProgress();
        pressBack();
        showCustomToast(context, response.message.toString(), isSuccess: true);
      } else {
        disposeProgress();
        showCustomToast(context, response.message.toString());
      }
    }
  }

  Future<void> farmerProjectMilestoneApproveApi(context, int farmerId, int farmerProjectId, int farmerMilestoneId, String milestoneStatus, String remarks, String otp) async {
    var response = await apiRepository.verifyProjectStatusApi(otp, state.userIdForOtpValidate.toString());
    if(response.status == 200) {
      var response = await apiRepository.getFarmerProjectMilestoneApproveApi(farmerId, farmerProjectId, farmerMilestoneId, milestoneStatus, remarks);
      if (response.status == 200) {
        farmerProjectMilestoneDetailApi(context, farmerMilestoneId);
        farmerProjectDetailApi(context, farmerProjectId);
        disposeProgress();
        pressBack();
        showCustomToast(context, response.message.toString(), isSuccess: true);
      } else {
        disposeProgress();
        showCustomToast(context, response.message.toString());
      }
    }
    else {
      showCustomToast(context, response.message.toString());
    }
  }

  void inviteExpertForSurvey(context, int projectId, String date,
      String remark,String projectStatus,String farmerId) async {
    customDialog(widget: launchProgress());
    var response = await apiRepository.inviteExpertForSurveyApi(projectId, date,
        remark,projectStatus,farmerId,surveyQuotation: File(""));
    if (response.status == 200) {
      disposeProgress();
      showCustomToast(context, response.message.toString(), isSuccess: true);
      if(projectStatus == "hold") {
        DisputeScreen(project: state.responseFarmerProjectDetail!.data!).navigate();
      } else {
        pressBack();
        farmerProjectsApi(context, 'Suggested', false);
        await farmerProjectDetailApi(context, projectId);
      }

    } else {
      emit(state.copyWith(status: ProjectStatus.error));
      showCustomToast(context, response.message.toString());
    }
  }

  // surveyStatusApi
  void surveyStatusApi(context, int projectId,
      String remark,String projectStatus,String farmerId,dde.FarmerProject projectSurvey, String selectedFilter,{String? surveyQuotationImage}) async {
    // customDialog(widget: launchProgress());
    var response = await apiRepository.inviteExpertForSurveyApi(projectId, "",
        remark,projectStatus,farmerId,surveyQuotation: File(surveyQuotationImage ?? ''));
    if (response.status == 200) {
      // disposeProgress();
      if(projectStatus == "survey_rejected"){
        RejectScreen(farmerProjectSurvey: projectSurvey,).navigate(isInfinity: true);
      }else if(projectStatus == "survey_accepted"){
        AcceptScreen(farmerProjectSurvey: projectSurvey,).navigate(isInfinity: true);
      }else{
        SurveyFinishedScreen(farmerProjectSurvey: projectSurvey,).navigate(isInfinity: true);
      }
      supplierProjectsApi(context, selectedFilter, true);
      // farmerProjectDetailApi(context,projectId);

    } else {
      // disposeProgress();
      pressBack();
      emit(state.copyWith(status: ProjectStatus.error));
      showCustomToast(context, response.message.toString());
    }
  }

  // updateProfilePicImage
  Future<void> projectKycApi(context, String farmerId, String farmerProjectId, String addressDocName, String addressDocNo, String addressDocExpiryDate,
      List<String> documentFiles,String idDocName,
      String idDocTypeNo, String idDocTypeExpiryDate, List<String> documentTypeFiles, String farmerPhoto,dde.FarmerMaster farmerProject) async {
    customDialog(widget: launchProgress());
    var response = await apiRepository.projectKycApi(farmerId, farmerProjectId, addressDocName, addressDocNo, addressDocExpiryDate, documentFiles.map((e) => File(e)).toList(), idDocName, idDocTypeNo, idDocTypeExpiryDate, documentTypeFiles.map((e) => File(e)).toList(), File(farmerPhoto));
    disposeProgress();
    if (response.status == 200) {
      // AddRemark(tag: ,).navigate();
      AddLoanRemark(projectData: farmerProject,farmerProjectId:farmerProjectId).navigate();
      // ThankYou(profileData: farmerProject,).navigate();
      showCustomToast(context, response.message.toString(), isSuccess: true);
    } else {
      showCustomToast(context, response.message.toString());
    }
  }

  Future<void> liveStockKycApi(context, String farmerId, String farmerProjectId, String addressDocName, String addressDocNo, String addressDocExpiryDate,
      List<String> documentFiles,String idDocName,
      String idDocTypeNo, String idDocTypeExpiryDate, List<String> documentTypeFiles, String farmerPhoto,live.FarmerMaster farmerMaster) async {
    customDialog(widget: launchProgress());
    var response = await apiRepository.projectKycApi(farmerId, farmerProjectId, addressDocName, addressDocNo, addressDocExpiryDate, documentFiles.map((e) => File(e)).toList(), idDocName, idDocTypeNo, idDocTypeExpiryDate, documentTypeFiles.map((e) => File(e)).toList(), File(farmerPhoto));
    disposeProgress();
    if (response.status == 200) {
      // AddRemark(tag: ,).navigate();
      // AddLoanRemark(projectData: farmerProject,farmerProjectId:farmerProjectId).navigate();
      ThankYouLivestockLoan(response: farmerMaster).navigate(isInfinity: true);
      showCustomToast(context, response.message.toString(), isSuccess: true);
    } else {
      if(response.message!=null){
        showCustomToast(context, response.message.toString());
      }
      // showCustomToast(context, response.message.toString());
    }
  }

  // updateProfilePicImage
  Future<void> projectKycUpdateApi(context, String farmerId, int? id, String farmerProjectId, String addressDocName, String addressDocNo, String addressDocExpiryDate,
      List<String> documentFiles,String idDocName,
      String idDocTypeNo, String idDocTypeExpiryDate, List<String> documentTypeFiles, String farmerPhoto,dde.FarmerMaster farmerProject) async {
    customDialog(widget: launchProgress());
    var response = await apiRepository.projectKycUpdateApi(farmerId, id, farmerProjectId, addressDocName, addressDocNo, addressDocExpiryDate, documentFiles.map((e) => File(e)).toList(), idDocName, idDocTypeNo, idDocTypeExpiryDate, documentTypeFiles.map((e) => File(e)).toList(), farmerPhoto);
    disposeProgress();
    if (response.status == 200) {
      // AddRemark(tag: ,).navigate();
      AddLoanRemark(projectData: farmerProject,farmerProjectId:farmerProjectId).navigate();
      // ThankYou(profileData: farmerProject,).navigate();
      showCustomToast(context, response.message.toString(), isSuccess: true);
    } else {
      if(response.message!=null){
        showCustomToast(context, response.message.toString());
      }
      // showCustomToast(context, response.message.toString());
    }
  }



  // sendProjectStatusOtpApi
  Future<void> sendProjectStatusOtpApi(context,String mobile) async{
      customDialog(widget: launchProgress());
      var response = await apiRepository.sendOtpApi(mobile);
      disposeProgress();
      // print(response);
      if(response.status == 200){

        showCustomToast(context, "We have sent otp on your registered email ${response.data!.otp.toString()}");
        emit(state.copyWith(userIdForOtpValidate: response.data!.id.toString()));
      }
      else{
        // emit(state.copyWith(status: ProjectStatus.error));
        if(response.message!=null){
          showCustomToast(context, response.message.toString());
        }
        // showCustomToast(context, response.message.toString());
      }
  }

  ///// verifyProjectStatusApi /////
  Future<void> verifyProjectStatus(context,String otp,String projectId,
      String date,String remarks,String selectStatus,String farmerId,dde.FarmerMaster profileData) async{

    customDialog(widget: launchProgress());
    // emit(state.copyWith(status: ProjectStatus.loading));
    var response = await apiRepository.verifyProjectStatusApi(otp, state.userIdForOtpValidate.toString());
    disposeProgress();

    if(response.status == 200){

      await inviteExpertForSurveyDDe(context,
          int.parse(projectId),
          date,
          remarks,
          selectStatus,
          farmerId.toString(),
          profileData,sharedPreferences.getString(AppConstants.userType)!
      );
    }
    else
    {
      if(response.message!=null){
        showCustomToast(context, response.message.toString());
      }
      // emit(state.copyWith(status: ProjectStatus.error));
      // showCustomToast(context, response.message.toString());
    }
  }

  ///// verifyProjectStatusApi /////
  Future<void> verifyProjectStatusFarmerApi(context,String otp,String projectId,
      String date,String remarks,String selectStatus,String farmerId,dde.FarmerMaster profileData) async{

    customDialog(widget: launchProgress());
    // emit(state.copyWith(status: ProjectStatus.loading));
    var response = await apiRepository.verifyProjectStatusApi(otp, state.userIdForOtpValidate.toString());
    disposeProgress();

    if(response.status == 200){

      await inviteExpertForSurveyDDe(context,
          int.parse(projectId),
          date,
          remarks,
          selectStatus,
          farmerId.toString(),
          profileData,sharedPreferences.getString(AppConstants.userType)!,
      );
    }
    else
    {
      // emit(state.copyWith(status: ProjectStatus.error));
      if(response.message!=null){
        showCustomToast(context, response.message.toString());
      }
      // showCustomToast(context, response.message.toString());
    }
  }


  ///// verifyProjectStatusApi /////
  Future<void> verifyProjectStatusLoanApprovalApi(context,String otp,String projectId,
      String date,String remarks,String selectStatus,String farmerId,dde.FarmerMaster profileData) async{

    customDialog(widget: launchProgress());
    // emit(state.copyWith(status: ProjectStatus.loading));
    var response = await apiRepository.verifyProjectStatusApi(otp, state.userIdForOtpValidate.toString());

    disposeProgress();

    if(response.status == 200){

      await inviteExpertForSurveyDDeLoanApprovalApi(context,
          int.parse(projectId),
          date,
          remarks,
          selectStatus,
          farmerId.toString(),
          profileData,sharedPreferences.getString(AppConstants.userType)!,

      );
    }
    else
    {
      // emit(state.copyWith(status: ProjectStatus.error));
      if(response.message!=null){
        showCustomToast(context, response.message.toString());
      }
      // showCustomToast(context, response.message.toString());
    }
  }

  ///// verifyProjectStatusApi /////
  Future<void> verifyDdeMarkAsDeliveryApi(context,String otp,String userId,
      String cartId,String farmerProjectId,String controller,String status,List<String> docOneFile) async{

    customDialog(widget: launchProgress());
    // emit(state.copyWith(status: ProjectStatus.loading));
    var response = await apiRepository.verifyProjectStatusApi(otp, userId);

    disposeProgress();

    if(response.status == 200){
      BlocProvider.of<LivestockCubit>(context).livestockDeliveryStatusApi(context, int.parse(cartId.toString()), farmerProjectId.toString(), controller, status, docOneFile);
      pressBack();
    }
    else
    {
      // emit(state.copyWith(status: ProjectStatus.error));
      if(response.message!=null){
        showCustomToast(context, response.message.toString());
      }
      // showCustomToast(context, response.message.toString());
    }
  }

  ///// verifyProjectStatusApi /////
  Future<void> verifyRemoveThisAdApi(context,String otp,String userId,int id) async{

    customDialog(widget: launchProgress());
    // emit(state.copyWith(status: ProjectStatus.loading));
    var response = await apiRepository.verifyProjectStatusApi(otp, userId);

    disposeProgress();

    if(response.status == 200){
      pressBack();

      BlocProvider.of<LivestockCubit>(context).removeLivestockAPi(context, id);
    } else {
      // emit(state.copyWith(status: ProjectStatus.error));
      if(response.message!=null){
        showCustomToast(context, response.message.toString());
      }
      // showCustomToast(context, response.message.toString());
    }
  }

  Future<void> verifyNegotiatePriceApi(context,String otp,String userId, String livestockId, String negotiatedPrice, String userIdBuyer) async{

    customDialog(widget: launchProgress());
    // emit(state.copyWith(status: ProjectStatus.loading));
    var response = await apiRepository.verifyProjectStatusApi(otp, userId);

    disposeProgress();

    if(response.status == 200){
      pressBack();
      BlocProvider.of<LivestockCubit>(context).updateNegotiateApi(context, livestockId, negotiatedPrice, userIdBuyer);
      FirebaseFirestore.instance.collection('livestock_enquiry').doc(livestockId)
          .collection('enquiries')
          .doc(userIdBuyer)
          .update(
          {
            'created_at': Timestamp
                .now(),
            'negotiated_price': negotiatedPrice
            // "${currentUser}messageCount":FieldValue.increment(1),
          })
          .then((value) => print("Negotiation Added"))
          .catchError((error) => print("Failed to add user: $error"));
    } else {
      // emit(state.copyWith(status: ProjectStatus.error));
      if(response.message!=null){
        showCustomToast(context, response.message.toString());
      }
      // showCustomToast(context, response.message.toString());
    }
  }

  ///// verifyProjectStatusApi /////
  Future<void> verifyFarmerParticipationApi(context,String otp,String userId,String farmerId, String farmerProjectID,
      String controller,String projectId) async{

    customDialog(widget: launchProgress());

    var response = await apiRepository.verifyProjectStatusApi(otp, userId);

    disposeProgress();

    if(response.status == 200){
      pressBack();

      await farmerParticipationApi(context,farmerId.toString(),farmerProjectID.toString(), controller,int.parse(projectId));

    } else {
      // emit(state.copyWith(status: ProjectStatus.error));
      if(response.message!=null){
        showCustomToast(context, response.message.toString());
      }
      // showCustomToast(context, response.message.toString());
    }
  }


  ///// verifyProjectStatusApi /////
  Future<void> verifyProjectStatusFarmerLoanApprovalApi(context,String otp,String projectId,
      String date,String remarks,String selectStatus,String farmerId,dde.FarmerMaster profileData) async{

    customDialog(widget: launchProgress());
    // emit(state.copyWith(status: ProjectStatus.loading));
    var response = await apiRepository.verifyProjectStatusApi(otp, state.userIdForOtpValidate.toString());
    disposeProgress();

    if(response.status == 200){

      await inviteExpertForSurveyDDeLoanApprovalApi(context,
          int.parse(projectId),
          date,
          remarks,
          selectStatus,
          farmerId.toString(),
          profileData,sharedPreferences.getString(AppConstants.userType)!
      );
    }
    else
    {
      // emit(state.copyWith(status: ProjectStatus.error));
      if(response.message!=null){
        showCustomToast(context, response.message.toString());
      }
      // showCustomToast(context, response.message.toString());
    }
  }

  Future<void> inviteExpertForSurveyDDeLoanApprovalApi(context, int projectId, String date,
      String remark,String projectStatus,String farmerId,dde.FarmerMaster profileData,String navigateFrom) async {
    customDialog(widget: launchProgress());
    var response = await apiRepository.inviteExpertForSurveyApi(projectId, date,
        remark,projectStatus,farmerId,surveyQuotation: File(""));
    if (response.status == 200) {

      CongratulationScreen(navigateFrom: navigateFrom).navigate(isInfinity: true);

      showCustomToast(context, response.message.toString(), isSuccess: true);
    } else {
      emit(state.copyWith(status: ProjectStatus.error));
      if(response.message!=null){
        showCustomToast(context, response.message.toString());
      }
      // showCustomToast(context, response.message.toString());
    }
  }


  Future<void> inviteExpertForSurveyDDe(context, int projectId, String date,
      String remark,String projectStatus,String farmerId,dde.FarmerMaster profileData,String navigateFrom) async {
    customDialog(widget: launchProgress());
    var response = await apiRepository.inviteExpertForSurveyApi(projectId, date,
        remark,projectStatus,farmerId,surveyQuotation: File(''));
    if (response.status == 200) {

      ThankYou(
          profileData:profileData,navigateFrom: navigateFrom,projectStatus:projectStatus
      ).navigate(isInfinity: true);
      if(response.data['warning']!=null){
        showCustomToast(context, response.data['warning'].toString(), isSuccess: true);
      }else{
        if(response.message!=null){
          showCustomToast(context, response.message.toString(), isSuccess: true);
        }
      }

    } else {
      emit(state.copyWith(status: ProjectStatus.error));
      showCustomToast(context, response.message.toString());
    }
  }

  Future<void> inviteExpertForSurveyMcc(context, int projectId, String date,
      String remark,String projectStatus,String farmerId,dde.FarmerMaster profileData) async {
    customDialog(widget: launchProgress());
    var response = await apiRepository.inviteExpertForSurveyApi(projectId, date,
        remark,projectStatus,farmerId,surveyQuotation: File(''));

    if (response.status == 200) {

      ThankYouMcc(
          profileData:profileData,projectStatus:projectStatus
      ).navigate(isInfinity: true);
      showCustomToast(context, response.message.toString(), isSuccess: true);

      await ddeProjectsApi(context, 'pending', true);

    } else {
      emit(state.copyWith(status: ProjectStatus.error));
      if(response.message!=null){
        showCustomToast(context, response.message.toString());
      }
    }
  }


  // void updateSuggestedProjectStatus(context, String status, int projectId) async {
  //   customDialog(widget: launchProgress());
  //   var response = await apiRepository.suggestedProjectUpdateStatus(status, projectId);
  //   if (response.status == 200) {
  //     disposeProgress();
  //     pressBack();
  //     farmerProjectsApi(context, 'Suggested', false);
  //     await farmerProjectDetailApi(context, projectId);
  //     showCustomToast(context, response.message ?? '', isSuccess: true);
  //   } else {
  //     emit(state.copyWith(status: ProjectStatus.error));
  //     showCustomToast(context, response.message.toString());
  //   }
  // }

  void getResourceNameApi(context,String farmerId,String farmerProjectId,String farmerMileStoneId) async {
    // emit(state.copyWith(status: ProjectStatus.loading));
    var response = await apiRepository.getResourceNameApi(farmerId,farmerProjectId,farmerMileStoneId);
    if (response.status == 200) {
      List<DataResourceName> dataResourceType = [];
      if(response.data!=null){
        dataResourceType = response.data!;
      }
      emit(state.copyWith(responseMaterialType: dataResourceType));
      searchMaterialName('', dataResourceType);
    } else {
      if(response.message!=null){
        showCustomToast(context, response.message.toString());
      }
      // showCustomToast(context, response.message.toString());
    }
  }

  void getResourceTypeApi(context,String mileStoneId,String resourceName) async {
    // emit(state.copyWith(status: ProjectStatus.loading));
    var response = await apiRepository.getResourceTypeApi(mileStoneId,resourceName);
    if (response.status == 200) {
      // print(response.data![0].name);
      List<DataResourceType> dataResourceType = [];
      if(response.data!=null){
        dataResourceType = response.data!;
      }

      emit(state.copyWith(responseResourceType: dataResourceType));
    } else {
      if(response.message!=null){
        showCustomToast(context, response.message.toString());
      }
      // emit(state.copyWith(status: ProjectStatus.error));
      // showCustomToast(context, response.message.toString());
    }
  }

  void getResourceCapacityApi(context,String mileStoneId,resourceName,resourceType) async {
    // emit(state.copyWith(status: ProjectStatus.loading));
    var response = await apiRepository.getResourceCapacityApi(mileStoneId, resourceName, resourceType);
    if (response.status == 200) {
      List<DataCapacityList> dataResourceType = [];
      if(response.data!=null){
        dataResourceType = response.data!;
      }
      emit(state.copyWith(responseResourceCapacityType: dataResourceType));
    } else {
      // emit(state.copyWith(status: ProjectStatus.error));
      if(response.message!=null){
        showCustomToast(context, response.message.toString());
      }
      // showCustomToast(context, response.message.toString());
    }
  }

  void projectUOMListApi(context) async {
    // emit(state.copyWith(status: ProjectStatus.loading));
    var response = await apiRepository.projectUOMListApi();
    if (response.status == 200) {
      List<DataResourceType> dataResourceType = [];
      if(response.data!=null){
        dataResourceType = response.data!;
      }
      emit(state.copyWith(responseProjectUOM: dataResourceType));
    } else {
      // emit(state.copyWith(status: ProjectStatus.error));
      if(response.message!=null){
        showCustomToast(context, response.message.toString());
      }
      // showCustomToast(context, response.message.toString());
    }
  }

  void notRequiredApi(context,String id) async {
    // emit(state.copyWith(status: ProjectStatus.loading));
    var response = await apiRepository.notRequiredDataApi(id);
    if (response.status == 200) {

      getSelectedAttribute(
        response.data!.resourceName??'',
        response.data!.resourceType??'',
        response.data!.resourceCapacity??'',
        response.data!.resourceUom??'',
        response.data!.resourceSize.toString() ?? '0',
        response.data!.resourcePrice.toString()??'0',);
      state.valueController.text = response.data!.resourceValue.toString()??'0';
      getResourceCapacityApi(context, response.data!.milestoneId.toString(), response.data!.resourceName.toString(), response.data!.resourceType.toString());
      emit(state.copyWith(primaryId: response.data!.id.toString()??"0"));
    } else {
      // emit(state.copyWith(status: ProjectStatus.error));
      if(response.message!=null){
        showCustomToast(context, response.message.toString());
      }
      // showCustomToast(context, response.message.toString());
    }
  }

  void updateAttributeApi(context,String id,String farmerProjectId,String farmerMileStoneId,String primaryId) async {
    if(state.requiredQtyController.text.isEmpty){
      showCustomToast(context, "Please enter quantity");
    }else{
      customDialog(
          widget: launchProgress()
      );
      var response = await apiRepository.updateAttributeApi(
          id,
          farmerProjectId,
          farmerMileStoneId,
          state.selectMaterialName.toString(),
          state.selectResourceType.toString(),
          state.selectSizeCapacity.toString(),
          state.requiredQtyController.text.toString(),
          state.selectProjectUOM.toString(),
          state.pricePerUnitController.text, primaryId);

      disposeProgress();

      if (response.status == 200) {

        pressBack();
        farmerProjectMilestoneDetailApi(context,int.parse(farmerMileStoneId));
        showCustomToast(context, response.message.toString());

      } else {
        showCustomToast(context, response.message.toString());
      }
    }
  }

  void updateDdeAttributeApi(context,String id,String farmerProjectId,String farmerMileStoneId) async {
    if(state.requiredQtyController.text.isEmpty){
      showCustomToast(context, "Please enter quantity");
    }else{
      customDialog(
          widget: launchProgress()
      );
      var response = await apiRepository.updateAttributeApi(
          id,
          farmerProjectId,
          farmerMileStoneId,
          state.materialNameController.text.toString(),
          state.resourceTypeController.text.toString(),
          state.resourceCapacityController.text.toString(),
          state.requiredQtyController.text.toString(),
          state.uomController.text.toString(),
          state.pricePerUnitController.text, state.primaryId.toString());

      disposeProgress();

      if (response.status == 200) {

        pressBack();
        farmerProjectMilestoneDetailApi(context,int.parse(farmerMileStoneId));
        showCustomToast(context, response.message.toString());

      } else {
        if(response.message!=null){
          showCustomToast(context, response.message.toString());
        }
        // showCustomToast(context, response.message.toString());
      }
    }
  }

  void addAttributeApi(context,farmerProjectId,farmerMileStoneId) async {

    if(state.selectMaterialName == 'Select Material Name'){
      showCustomToast(context, 'Please select material name');
    }else if(state.selectResourceType == 'Select Type'){
      showCustomToast(context, 'Please select type.');
    }else if(state.selectSizeCapacity == 'Select Size Capacity'){
      showCustomToast(context, 'Please size capacity.');
    }else if(state.requiredQtyController.text.isEmpty){
      showCustomToast(context, 'Please enter required qty.');
    }else if(state.pricePerUnitController.text.isEmpty){
      showCustomToast(context, 'Please enter price per unit.');
    }else{
      customDialog(
          widget: launchProgress()
      );
      var response = await apiRepository.addAttributeApi(
          farmerProjectId,
          farmerMileStoneId,
          state.selectMaterialName.toString(),
          state.selectResourceType.toString(),
          state.selectSizeCapacity.toString(),
          state.requiredQtyController.text.toString(),
          state.selectProjectUOM.toString());

      disposeProgress();

      if (response.status == 200) {
        pressBack();
        showCustomToast(context, response.message.toString());

      } else {
        if(response.message!=null){
          showCustomToast(context, response.message.toString());
        }
        // showCustomToast(context, response.message.toString());
      }
    }

  }

  void getPriceAttributeApi(context,String projectId,String mileStoneId) async {
    var response = await apiRepository.getPriceAttributeApi(
        state.selectMaterialName.toString(),
        state.selectResourceType.toString(),
        state.selectSizeCapacity.toString(),
        state.requiredQtyController.text.toString(),
      projectId,mileStoneId
    );

    if (response.status == 200) {

      if(response.data!.resourcePrice!=null){
        state.pricePerUnitController.text = double.parse(response.data!.resourcePrice.toString()).toStringAsFixed(2);
      }

      if(state.requiredQtyController.text.isNotEmpty){

        state.valueController.text = (double.parse(state.requiredQtyController.text)*(double.parse(response.data!.resourcePrice.toString()??'0'))).toStringAsFixed(2);

      }

    } else {
      /*state.pricePerUnitController.clear();
      state.valueController.clear();*/

      // showCustomToast(context, response.message.toString());
    }
  }

  void deleteAttributeApi(context,String id,String mileStoneId) async {
    customDialog(widget: launchProgress());
    var response = await apiRepository.deleteAttributeApi(
        id);

    disposeProgress();

    if (response.status == 200) {

      await farmerProjectMilestoneDetailApi(context, int.parse(mileStoneId));
      // farmerProjectDetailApi(context, widget.projectId);
      showCustomToast(context, response.message.toString());
    } else {
      if(response.message!=null){
        showCustomToast(context, response.message.toString());
      }
      // showCustomToast(context, response.message.toString());
    }
  }

  // mileStoneDeleteApi
  void milestoneDeleteApi(context,int id,int projectId) async {
    customDialog(widget: launchProgress());
    var response = await apiRepository.mileStoneDeleteApi(id);

    disposeProgress();

    if (response.status == 200) {

      await farmerProjectDetailApi(context,projectId);
      showCustomToast(context, response.message.toString());
    } else {
      showCustomToast(context, response.message.toString());
    }
  }

  // mileStoneNameApi
  Future<void> milestoneNameApi(context,String farmerId,String farmerProjectId) async {
    var response = await apiRepository.mileStoneNameApi(farmerId,farmerProjectId);

    if (response.status == 200) {
      List<DataMileStoneName> dataMilestoneName = [];
      if(response.data!=null){
        dataMilestoneName = response.data!;
      }

      emit(state.copyWith(responseMilestoneName: dataMilestoneName));
      milestoneId('');
      searchMilestoneFilter('', dataMilestoneName);
    } else {
      if(response.message!=null){
        showCustomToast(context, response.message.toString());
      }
      // showCustomToast(context, response.message.toString());
    }
  }

  // farmerParticipationApi
  Future<void> farmerParticipationApi(context,String farmerId,String farmerProjectId,String farmerParticipation,int projectId) async {
    var response = await apiRepository.farmerParticipationApi(farmerId,farmerProjectId,farmerParticipation);

    if (response.status == 200) {
      disposeProgress();
      showCustomToast(context, response.message.toString());
      await farmerProjectDetailApi(context,projectId);
    } else {
      if(response.message!=null){
        showCustomToast(context, response.message.toString());
      }
      // showCustomToast(context, response.message.toString());
    }
  }

  // farmerParticipationApi
  Future<void> updateFarmerRepaymentMonthsApi(context,String farmerId,String farmerProjectId,String farmerRepaymentMonths,int projectId) async {
    var response = await apiRepository.farmerRepaymentMonthsApi(farmerId,farmerProjectId,farmerRepaymentMonths);

    if (response.status == 200) {
      disposeProgress();
      showCustomToast(context, response.message.toString());
      await farmerProjectDetailApi(context,projectId);
    } else {
      if(response.message!=null){
        showCustomToast(context, response.message.toString());
      }
      // showCustomToast(context, response.message.toString());
    }
  }


  void statusColor(String status){
    emit(state.copyWith(statusLoan: status));
  }

  // accountStatementApi
  Future<void> accountStatementSupplierProjectDetailApi(context,String paymentStatus,String farmerProjectId) async {

    emit(state.copyWith(status: ProjectStatus.loading));

    var response = await apiRepository.accountStatementSupplierProjectDetailApi(paymentStatus,farmerProjectId);

    if (response.status == 200) {

      emit(state.copyWith(status: ProjectStatus.success,responseAccountStatement: response,paidAmount: response.data!.summary!.paidAmount??0,
          pendingAmount: response.data!.summary!.pendingAmount??0,dueAmount: response.data!.summary!.dueAmount??0));

    } else {
      if(response.message!=null){
        showCustomToast(context, response.message.toString());
      }
      // showCustomToast(context, response.message.toString());
    }
  }

  // accountStatementDdeFarmerDetailApi
  Future<void> accountStatementProjectDdeDetailApi(context,String paymentStatus,String userRoleId,String farmerProjectId) async {

    emit(state.copyWith(status: ProjectStatus.loading));

    var response = await apiRepository.accountStatementProjectDdeDetailApi(paymentStatus,userRoleId,farmerProjectId);

    if (response.status == 200) {

      emit(state.copyWith(status: ProjectStatus.success,responseAccountStatement: response,paidAmount: response.data!.summary!.paidAmount??0,
          pendingAmount: response.data!.summary!.pendingAmount??0,dueAmount: response.data!.summary!.dueAmount??0));

    } else {
      if(response.message!=null){
        showCustomToast(context, response.message.toString());
      }
      // showCustomToast(context, response.message.toString());
    }
  }

  // accountStatementApi
  Future<void> accountStatementProjectDetailApi(context,String paymentStatus,String userRoleId,String farmerProjectId) async {

    emit(state.copyWith(status: ProjectStatus.loading));

    var response = await apiRepository.accountStatementProjectDetailApi(paymentStatus,userRoleId,farmerProjectId);

    if (response.status == 200) {

      emit(state.copyWith(status: ProjectStatus.success,responseAccountStatement: response,paidAmount: response.data!.summary!.paidAmount??0,
          pendingAmount: response.data!.summary!.pendingAmount??0,dueAmount: response.data!.summary!.dueAmount??0));

    } else {
      if(response.message!=null){
        showCustomToast(context, response.message.toString());
      }
      // showCustomToast(context, response.message.toString());
    }
  }

  // accountStatementApi
  Future<void> accountStatementApi(context,String paymentStatus) async {

    emit(state.copyWith(status: ProjectStatus.loading));

    var response = await apiRepository.accountStatementApi(paymentStatus,'');

    if (response.status == 200) {

      emit(state.copyWith(status: ProjectStatus.success,responseAccountStatement: response,paidAmount: response.data!.summary!.paidAmount??0,
          pendingAmount: response.data!.summary!.pendingAmount??0,dueAmount: response.data!.summary!.dueAmount??0,
          earningIncrement:  response.data!.summary!.earningIncrement??0));

    } else {
      if(response.message!=null){
        showCustomToast(context, response.message.toString());
      }
      // showCustomToast(context, response.message.toString());
    }
  }

  // addMilestoneApi
  Future<void> addMilestoneApi(context,String farmerId,
      String farmerProjectId,
      String milestoneTitle,
      String milestoneDescription,
      String milestoneDuration,int projectId,String projectStatus,String add) async {

    if(state.milestoneTitle.text.isEmpty){
      showCustomToast(context, "Please enter milestone name");
    }else if(state.milestoneDuration.text.isEmpty){
      showCustomToast(context, "Please enter milestone duration");
    }else if(state.milestoneDescription.text.isEmpty){
      showCustomToast(context, "Please enter milestone description");
    }else{
      var response = await apiRepository.addMileStoneApi(farmerId, farmerProjectId, milestoneTitle, milestoneDescription, milestoneDuration,id: state.projectId.toString());

      if (response.status == 200) {
        showCustomToast(context, response.message.toString());
        await farmerProjectDetailApi(context,projectId);
        if(add == "add"){
          DdeMilestoneDetail(milestoneId:
          response.data!.id,
              projectStatus:projectStatus,
              navigateScreen: "add",projectId:projectId
          ).navigate();
        }else{
          pressBack();
        }
      } else {
        if(response.message!=null){
          showCustomToast(context, response.message.toString());
        }
        // showCustomToast(context, response.message.toString());
      }
    }
  }

  // addMilestoneApi
  Future<void> addSupplierMilestoneApi(context,String farmerId,
      String farmerProjectId,
      String milestoneTitle,
      String milestoneDescription,
      String milestoneDuration,int projectId,String projectStatus) async {

    if(state.milestoneTitle.text.isEmpty){
      showCustomToast(context, "Please enter milestone name");
    }else if(state.milestoneDuration.text.isEmpty){
      showCustomToast(context, "Please enter milestone duration");
    }else if(state.milestoneDescription.text.isEmpty){
      showCustomToast(context, "Please enter milestone description");
    }else{
      var response = await apiRepository.addMileStoneApi(farmerId, farmerProjectId, milestoneTitle, milestoneDescription, milestoneDuration,id: state.projectId.toString());

      if (response.status == 200) {
        showCustomToast(context, response.message.toString());
        await farmerProjectDetailApi(context,projectId);
        SupplierMilestoneDetail(milestoneId:
        response.data!.id,
            projectStatus:projectStatus,
            navigateScreen: "add",projectId:projectId,
          selectedFilter: 'pending',
        ).navigate(isRemove: true);
        // pressBack();
      } else {
        if(response.message!=null){
          showCustomToast(context, response.message.toString());
        }
        // showCustomToast(context, response.message.toString());
      }
    }
  }

  void milestoneId(String id){
    emit(state.copyWith(projectId: id));
  }

  void searchMilestoneFilter(String query, List<DataMileStoneName> searchList) {
    List<DataMileStoneName> dummySearchList = <DataMileStoneName>[];
    dummySearchList.addAll(searchList);
    if (query.isNotEmpty) {
      List<DataMileStoneName> dummyListData = <DataMileStoneName>[];
      for (final item in dummySearchList) {
        if (item.milestoneTitle!.toLowerCase().contains(query.toLowerCase())) {
          dummyListData.add(item);
        }
      }
      emit(state.copyWith(filterMileStone: dummyListData));
      return;
    } else {
      emit(state.copyWith(filterMileStone: dummySearchList));
    }
  }

  void searchMaterialName(String query, List<DataResourceName> searchList) {
    List<DataResourceName> dummySearchList = <DataResourceName>[];
    dummySearchList.addAll(searchList);
    if (query.isNotEmpty) {
      List<DataResourceName> dummyListData = <DataResourceName>[];
      for (final item in dummySearchList) {
        if (item.resourceName!.toLowerCase().contains(query.toLowerCase())) {
          dummyListData.add(item);
        }
      }
      emit(state.copyWith(filterMaterialType: dummyListData));
      return;
    } else {
      emit(state.copyWith(filterMaterialType: dummySearchList));
    }
  }

  void searchResourceType(String query, List<DataResourceType> searchList) {
    List<DataResourceType> dummySearchList = <DataResourceType>[];
    dummySearchList.addAll(searchList);
    if (query.isNotEmpty) {
      List<DataResourceType> dummyListData = <DataResourceType>[];
      for (final item in dummySearchList) {
        if (item.name!.toLowerCase().contains(query.toLowerCase())) {
          dummyListData.add(item);
        }
      }
      emit(state.copyWith(filterResourceType: dummyListData));
      return;
    } else {
      emit(state.copyWith(filterResourceType: dummySearchList));
    }
  }


  void searchSizeCapacity(String query, List<DataCapacityList> searchList) {
    List<DataCapacityList> dummySearchList = <DataCapacityList>[];
    dummySearchList.addAll(searchList);
    if (query.isNotEmpty) {
      List<DataCapacityList> dummyListData = <DataCapacityList>[];
      for (final item in dummySearchList) {
        if (item.resourceCapacity!.toLowerCase().contains(query.toLowerCase())) {
          dummyListData.add(item);
        }
      }
      emit(state.copyWith(filterResourceCapacityType: dummyListData));
      return;
    } else {
      emit(state.copyWith(filterResourceCapacityType: dummySearchList));
    }
  }

  // getMileStoneDataApi
  void getMileStoneDataApi(context,int id) async {

    var response = await apiRepository.getMileStoneDataApi(id);

    if (response.status == 200) {

      showCustomToast(context, response.message.toString());

    } else {
      if(response.message!=null){
        showCustomToast(context, response.message.toString());
      }
      // showCustomToast(context, response.message.toString());
    }
  }

  // addTaskApi
  void addTaskApi(context,String farmerId, String farmerProjectId, String farmerMileStoneId, String taskName,int milestoneId) async {

    var response = await apiRepository.addTaskApi(farmerId, farmerProjectId, farmerMileStoneId, taskName);

    if (response.status == 200) {

      showCustomToast(context, response.message.toString());
      disposeProgress();
      await farmerProjectMilestoneDetailApi(context, milestoneId);

    } else {
      if(response.message!=null){
        showCustomToast(context, response.message.toString());
      }
      // showCustomToast(context, response.message.toString());
    }
  }

  // addTaskApi
  void deleteTaskApi(context,String id,int milestoneId) async {

    customDialog(widget: launchProgress());

    var response = await apiRepository.deleteTaskApi(id);

    disposeProgress();

    if (response.status == 200) {

      showCustomToast(context, response.message.toString());
      await farmerProjectMilestoneDetailApi(context,milestoneId);

    } else {
      if(response.message!=null){
        showCustomToast(context, response.message.toString());
      }
      // showCustomToast(context, response.message.toString());
    }
  }

  // farmerParticipationStatusApi
  void farmerParticipationStatusApi(context,String farmerProjectId) async {

    customDialog(widget: launchProgress());

    var response = await apiRepository.farmerParticipationStatusApi(farmerProjectId);

    disposeProgress();

    if (response.status == 200) {

      showCustomToast(context, response.message.toString());
      const ThankYouConfirm().navigate(isInfinity: true);

    } else {
      if(response.message!=null){
        showCustomToast(context, response.message.toString());
      }
      // showCustomToast(context, response.message.toString());
    }
  }

  // responseAreaImprovementListApi
  void responseAreaImprovementListApi(context) async {

    var response = await apiRepository.improvementAreaFilterListApi();

    if (response.status == 200) {

      emit(state.copyWith(responseImprovementAreaFilterList: response));

    } else {
      if(response.message!=null){
        showCustomToast(context, response.message.toString());
      }
      // showCustomToast(context, response.message.toString());
    }
  }

  // projectRatingApi
  void projectRatingApi(context,String farmerProjectId,String ratedFor,String ratedForId,String rating,String feedback) async {

    var response = await apiRepository.projectRatingApi(farmerProjectId, ratedFor, ratedForId, rating, feedback);

    if (response.status == 200) {

      // showCustomToast(context, response.message.toString());
      pressBack();
      await farmerProjectDetailApi(context,int.parse(farmerProjectId));

    } else {
      if(response.message!=null){
        showCustomToast(context, response.message.toString());
      }
      // showCustomToast(context, response.message.toString());
    }
  }

  // projectRatingApi
  void supplierProjectDropdownApi(context) async {

    var response = await apiRepository.getSupplierProjectFilterListApi();

    if (response.status == 200) {
      emit(state.copyWith(responseProjectSupplierFilterDropdownList: response));
      // showCustomToast(context, response.message.toString());

    } else {
      if(response.message!=null){
        showCustomToast(context, response.message.toString());
      }
      // showCustomToast(context, response.message.toString());
    }
  }

  // supplierFarmerFilterListApi
  void supplierFarmerFilterListApi(context) async {

    var response = await apiRepository.getSupplierFarmerFilterListApi();

    if (response.status == 200) {

      emit(state.copyWith(responseFarmerFilterDropdownList: response));
      // showCustomToast(context, response.message.toString());

    } else {
      if(response.message!=null){
        showCustomToast(context, response.message.toString());
      }
      // showCustomToast(context, response.message.toString());
    }
  }

  // supplierFarmerFilterListApi
  void customLoanListApi(context, String search, {bool isLoaderRequired = true}) async {
    if(isLoaderRequired) {
      emit(state.copyWith(status: ProjectStatus.loading));
    }
    var response = await apiRepository.getCustomLoanListApi(search);

    if (response.status == 200) {
      emit(state.copyWith(status: ProjectStatus.success, responseCustomLoanList: response));
    } else {
      if(response.message!=null){
        showCustomToast(context, response.message.toString());
      }
      // showCustomToast(context, response.message.toString());
      emit(state.copyWith(status: ProjectStatus.error));
    }
  }

  // supplierFarmerFilterListApi
  void customLoanFormApi(context, String? farmerId, {bool isLoadingRequired = true}) async {
    if(isLoadingRequired) {
      emit(state.copyWith(status: ProjectStatus.loading));
    }

    var response = await apiRepository.getCustomLoanFormApi(farmerId);
    if (response.status == 200) {
      emit(state.copyWith(responseLoanForm: response,responseLoanCalculation: null));
      customLoanPurposeListApi(context);
    } else {
      if(response.message!=null){
        showCustomToast(context, response.message.toString());
      }
      // showCustomToast(context, response.message.toString());
      emit(state.copyWith(status: ProjectStatus.error));
    }
  }

  void customLoanPurposeListApi(context) async {

    var response = await apiRepository.getCustomLoanPurposeListApi();
    if (response.status == 200) {
      response.data!.insert(0, loan.Data(name: 'Other'));
      emit(state.copyWith(status: ProjectStatus.success, responseLoanPurposeList: response));
    } else {
      if(response.message!=null){
        showCustomToast(context, response.message.toString());
      }
      // showCustomToast(context, response.message.toString());
      emit(state.copyWith(status: ProjectStatus.error));
    }
  }

  Future<void> loanCalculationAPi(context,String farmerId,String loanAmount,String repaymentMonths) async {

    var response = await apiRepository.loanCalculationApi(farmerId, loanAmount, repaymentMonths);
    if (response.status == 200) {
      emit(state.copyWith(status: ProjectStatus.success,responseLoanCalculation: response));
    } else {
      if(response.message!=null){
        showCustomToast(context, response.message.toString());
      }
      // showCustomToast(context, response.message.toString());
      emit(state.copyWith(status: ProjectStatus.error));
    }
  }

  ///// verifyProjectStatusApi /////
  Future<MobileLoginModel> verifyStatusApi(context,String otp,) async{

    customDialog(widget: launchProgress());
    var response = await apiRepository.verifyProjectStatusApi(otp, state.userIdForOtpValidate.toString());
    disposeProgress();

    if(response.status == 200){


      return response;

    }
    else
    {
      if(response.message!=null){
        showCustomToast(context, response.message.toString());
      }
      // showCustomToast(context, response.message.toString());
      return MobileLoginModel(status: 422);
      // emit(state.copyWith(status: ProjectStatus.error));
    }
  }

  void customLoanApplyApi(context, String loanPurpose, int loanAmount, int repaymentMonths, String remarks, String? farmerId, String addressDocName, String addressDocNo, String addressDocExpiryDate,
      List<String> documentFiles,String idDocName,
      String idDocTypeNo, String idDocTypeExpiryDate, List<String> documentTypeFiles, String farmerPhoto,
      FarmerMAster? farmerMaster,String? remittanceType) async {
    customDialog(widget: launchProgress());

    var response = await apiRepository.addCustomLoanApi(loanPurpose, loanAmount, repaymentMonths, remarks,
        farmerId,remittanceType);
    if (response.status == 200) {
      customLoanKycApi(context, response.data!['farmer_id'].toString(), response.data!['id'].toString(),
          addressDocName, addressDocNo,
          addressDocExpiryDate, documentFiles,
          idDocName, idDocTypeNo, idDocTypeExpiryDate,
          documentTypeFiles, farmerPhoto,farmerMaster);
      // customLoanListApi(context, '');
      showCustomToast(context, response.message.toString(), isSuccess: true);
    } else {
      if(response.message!=null){
        showCustomToast(context, response.message.toString());
      }
      // showCustomToast(context, response.message.toString());
      emit(state.copyWith(status: ProjectStatus.error));
    }
  }

  Future<void> customLoanKycApi(context, String farmerId, String farmerProjectId, String addressDocName, String addressDocNo, String addressDocExpiryDate,
      List<String> documentFiles,String idDocName,
      String idDocTypeNo, String idDocTypeExpiryDate, List<String> documentTypeFiles, String farmerPhoto,FarmerMAster? farmerMaster) async {
    var response = await apiRepository.projectKycApi(farmerId, farmerProjectId, addressDocName, addressDocNo, addressDocExpiryDate, documentFiles.map((e) => File(e)).toList(), idDocName, idDocTypeNo, idDocTypeExpiryDate, documentTypeFiles.map((e) => File(e)).toList(), File(farmerPhoto));
    disposeProgress();
    if (response.status == 200) {
      ThankYouCustomLoan(response: farmerMaster).navigate(isInfinity: true);
      showCustomToast(context, response.message.toString(), isSuccess: true);
    } else {
      if(response.message!=null){
        showCustomToast(context, response.message.toString());
      }
      // showCustomToast(context, response.message.toString());
    }
  }

}
