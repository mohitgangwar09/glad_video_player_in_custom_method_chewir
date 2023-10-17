import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:glad/data/model/auth_models/response_otp_model.dart';
import 'package:glad/data/model/dde_project_model.dart';
import 'package:glad/data/model/farmer_project_detail_model.dart';
import 'package:glad/data/model/farmer_project_milestone_detail_model.dart';
import 'package:glad/data/model/farmer_project_model.dart';
import 'package:glad/data/model/response_material_type.dart';
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

  void getSelectedAttribute(String materialName,String resourceType,
      String resourceCapacityName,String uom,String requiredQty,String pricePerUnit){
    emit(state.copyWith(
        selectMaterialName: materialName,
        selectResourceType: resourceType,
        selectSizeCapacity: resourceCapacityName,
        selectProjectUOM: '',
        requiredQtyController: TextEditingController()..clear(),
        pricePerUnitController: TextEditingController()..clear(),
    ));

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

  Future<void> farmerProjectDetailApi(context, int projectId) async {
    emit(state.copyWith(status: ProjectStatus.loading));
    var response = await apiRepository.getFarmerProjectDetailApi(projectId);
    if (response.status == 200) {
      emit(state.copyWith(status: ProjectStatus.success, responseFarmerProjectDetail: response));
    } else {
      emit(state.copyWith(status: ProjectStatus.error));
      showCustomToast(context, response.message.toString());
    }
  }

  Future<void> farmerProjectMilestoneDetailApi(context, int milestoneId) async {
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

  void inviteExpertForSurvey(context, int projectId, String date,
      String remark,String projectStatus,String farmerId) async {
    customDialog(widget: launchProgress());
    var response = await apiRepository.inviteExpertForSurveyApi(projectId, date,
        remark,projectStatus,farmerId);
    if (response.status == 200) {
      disposeProgress();
      pressBack();
      await farmerProjectDetailApi(context, projectId);
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

  void getResourceTypeApi(context,String id) async {
    // emit(state.copyWith(status: ProjectStatus.loading));
    var response = await apiRepository.getResourceTypeApi(id);
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

  void getMaterialTypeApi(context) async {
    // emit(state.copyWith(status: ProjectStatus.loading));
    var response = await apiRepository.getMaterialTypeApi();
    if (response.status == 200) {
      List<DataMaterialType> dataResourceType = [];
      if(response.data!=null){
        dataResourceType = response.data!;
      }
      emit(state.copyWith(responseMaterialType: dataResourceType));
    } else {
      showCustomToast(context, response.message.toString());
    }
  }

  void getResourceCapacityApi(context,String id) async {
    // emit(state.copyWith(status: ProjectStatus.loading));
    var response = await apiRepository.getResourceCapacityApi(id);
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

  void updateAttributeApi(context,String id,farmerProjectId,farmerMileStoneId) async {
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
        state.selectProjectUOM.toString());

    disposeProgress();

    if (response.status == 200) {

      showCustomToast(context, response.message.toString());

    } else {
      showCustomToast(context, response.message.toString());
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
        showCustomToast(context, response.message.toString());
      }
    }

  }

  void getPriceAttributeApi(context) async {
    var response = await apiRepository.getPriceAttributeApi(
        state.selectMaterialName.toString(),
        state.selectResourceType.toString(),
        state.selectSizeCapacity.toString(),
        state.requiredQtyController.text.toString(),
        state.selectProjectUOMId.toString(),
    );

    if (response.status == 200) {

      if(response.data!.resourcePrice!=null){
        state.pricePerUnitController.text = double.parse(response.data!.resourcePrice.toString()).toStringAsFixed(2);
      }

    } else {
      state.pricePerUnitController.clear();
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
      showCustomToast(context, response.message.toString());
    } else {
      showCustomToast(context, response.message.toString());
    }
  }

}
