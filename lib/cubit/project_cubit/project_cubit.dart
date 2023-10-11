import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:glad/data/model/auth_models/response_otp_model.dart';
import 'package:glad/data/model/dde_project_model.dart';
import 'package:glad/data/model/farmer_project_detail_model.dart';
import 'package:glad/data/model/farmer_project_milestone_detail_model.dart';
import 'package:glad/data/model/farmer_project_model.dart';
import 'package:glad/data/model/response_resource_type.dart';
import 'package:glad/data/repository/project_repo.dart';
import 'package:glad/screen/custom_widget/custom_methods.dart';
import 'package:glad/utils/extension.dart';
import 'package:glad/utils/helper.dart';
import 'package:shared_preferences/shared_preferences.dart';

part 'project_state.dart';

class ProjectCubit extends Cubit<ProjectState> {
  final SharedPreferences sharedPreferences;
  final ProjectRepository apiRepository;

  ProjectCubit(
      {required this.apiRepository, required this.sharedPreferences})
      : super(ProjectState.initial());

  void getSelectedAttribute(String resourceType,String resourceCapacityName,uom){
    emit(state.copyWith(selectResourceType: resourceType,selectSizeCapacity: resourceCapacityName,selectProjectUOM: uom));
  }

  // farmerProjectsApi
  void farmerProjectsApi(context, String projectStatus, bool showLoader) async {
    if (showLoader) {
      emit(state.copyWith(status: ProjectStatus.loading));
    }
    // customDialog(widget: launchProgress());
    var response = await apiRepository.getFarmerProjectsApi(projectStatus);
    if (response.status == 200) {
      // disposeProgress();
      emit(state.copyWith(status: ProjectStatus.success, responseFarmerProject: response));
    } else {
      emit(state.copyWith(status: ProjectStatus.error));
      showCustomToast(context, response.message.toString());
    }
  }

  // farmerProjectsApi
  void ddeProjectsApi(context, String projectStatus, bool showLoader) async {
    if (showLoader) {
      emit(state.copyWith(status: ProjectStatus.loading));
    }
    var response = await apiRepository.getDdeProjectsApi(projectStatus);
    if (response.status == 200) {
      emit(state.copyWith(status: ProjectStatus.success, responseDdeProject: response));
    } else {
      emit(state.copyWith(status: ProjectStatus.error));
      showCustomToast(context, response.message.toString());
    }
  }

  void farmerProjectDetailApi(context, int projectId) async {
    emit(state.copyWith(status: ProjectStatus.loading));
    var response = await apiRepository.getFarmerProjectDetailApi(projectId);
    if (response.status == 200) {
      emit(state.copyWith(status: ProjectStatus.success, responseFarmerProjectDetail: response));
    } else {
      emit(state.copyWith(status: ProjectStatus.error));
      showCustomToast(context, response.message.toString());
    }
  }

  void farmerProjectMilestoneDetailApi(context, int milestoneId) async {
    emit(state.copyWith(status: ProjectStatus.loading));
    var response = await apiRepository.getFarmerProjectMilestoneDetailApi(milestoneId);
    if (response.status == 200) {

      if(response.data!.milestoneDetails![0].resourceQty!=null){
        state.requiredQtyController.text = response.data!.milestoneDetails![0].resourceQty.toString();
      }

      if(response.data!.milestoneDetails![0].resourcePrice!=null){
        state.pricePerUnitController.text = response.data!.milestoneDetails![0].resourcePrice.toString();
      }

      emit(state.copyWith(status: ProjectStatus.success,
          responseFarmerProjectMilestoneDetail: response,
          selectResourceType: response.data!.milestoneDetails![0].resourceTypeName!=null?response.data!.milestoneDetails![0].resourceTypeName!:'Select Type',
          selectSizeCapacity: response.data!.milestoneDetails![0].resourceCapacityName!=null?response.data!.milestoneDetails![0].resourceCapacityName!:'Select Size Capacity',
          selectProjectUOM: response.data!.milestoneDetails![0].resourceUomName!=null?response.data!.milestoneDetails![0].resourceUomName!:'Select UOM',
      ));
    } else {
      emit(state.copyWith(status: ProjectStatus.error));
      showCustomToast(context, response.message.toString());
    }
  }

  void inviteExpertForSurvey(context, int ddeId, String date, String remark) async {
    customDialog(widget: launchProgress());
    var response = await apiRepository.inviteExpertForSurveyApi(ddeId, date, remark);
    if (response.status == 200) {
      disposeProgress();
      pressBack();
      showCustomToast(context, response.data['message'], isSuccess: true);
    } else {
      emit(state.copyWith(status: ProjectStatus.error));
      showCustomToast(context, response.message.toString());
    }
  }

  void updateSuggestedProjectStatus(context, String status, int projectId) async {
    customDialog(widget: launchProgress());
    var response = await apiRepository.suggestedProjectUpdateStatus(status, projectId);
    if (response.status == 200) {
      disposeProgress();
      pressBack();
      showCustomToast(context, response.message ?? '', isSuccess: true);
    } else {
      emit(state.copyWith(status: ProjectStatus.error));
      showCustomToast(context, response.message.toString());
    }
  }

  void getResourceTypeApi(context) async {
    // emit(state.copyWith(status: ProjectStatus.loading));
    var response = await apiRepository.getResourceTypeApi();
    if (response.status == 200) {
      List<DataResourceType> dataResourceType = [];
      if(response.data!=null){
        dataResourceType = response.data!;
      }
      emit(state.copyWith(responseResourceType: dataResourceType));
    } else {
      // emit(state.copyWith(status: ProjectStatus.error));
      showCustomToast(context, response.message.toString());
    }
  }

  void getResourceCapacityApi(context) async {
    // emit(state.copyWith(status: ProjectStatus.loading));
    var response = await apiRepository.getResourceCapacityApi();
    if (response.status == 200) {
      List<DataResourceType> dataResourceType = [];
      if(response.data!=null){
        dataResourceType = response.data!;
      }
      emit(state.copyWith(responseResourceCapacityType: dataResourceType));
    } else {
      // emit(state.copyWith(status: ProjectStatus.error));
      showCustomToast(context, response.message.toString());
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
      showCustomToast(context, response.message.toString());
    }
  }

  void updateAttributeApi(context,String id) async {
    // emit(state.copyWith(status: ProjectStatus.loading));
    var response = await apiRepository.updateAttributeApi(id,
        state.selectResourceTypeId.toString(),
        state.selectSizeCapacityId.toString(),
        state.pricePerUnitController.text.toString(),
        state.requiredQtyController.text.toString(),
        state.selectProjectUOMId.toString());
    if (response.status == 200) {

      showCustomToast(context, response.message.toString());

    } else {
      showCustomToast(context, response.message.toString());
    }
  }

  void getPriceAttributeApi(context) async {
    var response = await apiRepository.getPriceAttributeApi(
        state.selectResourceTypeId.toString(),
        state.selectSizeCapacityId.toString(),
        state.selectProjectUOMId.toString(),
        state.requiredQtyController.text.toString());

    if (response.status == 200) {

      if(response.data!.resourcePrice!=null){
        state.pricePerUnitController.text = response.data!.resourcePrice.toString();
      }

    } else {
      showCustomToast(context, response.message.toString());
    }
  }

}
