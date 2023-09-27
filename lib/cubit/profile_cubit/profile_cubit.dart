import 'dart:io';

import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:glad/data/model/improvement_area_list_model.dart';
import 'package:glad/data/model/response_district.dart';
import 'package:glad/data/model/response_profile_model.dart';
import 'package:glad/data/model/farmer_profile_model.dart' as farmer_profile;
import 'package:glad/data/repository/profile_repo.dart';
import 'package:glad/screen/custom_widget/custom_methods.dart';
import 'package:glad/utils/app_constants.dart';
import 'package:glad/utils/extension.dart';
import 'package:glad/utils/helper.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:stepper_list_view/stepper_list_view.dart';

part 'profile_cubit_state.dart';

class ProfileCubit extends Cubit<ProfileCubitState> {
  final ProfileRepository apiRepository;
  final SharedPreferences sharedPreferences;

  ProfileCubit({required this.apiRepository, required this.sharedPreferences})
      : super(ProfileCubitState.initial());

  void selectGender(String gender) {
    emit(state.copyWith(gender: gender));
  }

  void changeDistrict(String districtName, String districtId,TextEditingController districtController) {
    emit(state.copyWith(selectDistrict: districtName, districtId: districtId,districtController: districtController));
  }

  void changeSelectedBreedIndex(int index) {
    emit(state.copyWith(selectedBreedIndex: index));
  }

  void changeSearchDistrictController(TextEditingController addressController) {
    emit(state.copyWith(addressSearchController: addressController));
  }

  void loginSearchCountryFilter(String query, List<DistrictData> searchList) {
    List<DistrictData> dummySearchList = <DistrictData>[];
    dummySearchList.addAll(searchList);
    if (query.isNotEmpty) {
      List<DistrictData> dummyListData = <DistrictData>[];
      for (var item in dummySearchList) {
        if (item.name!.toLowerCase().contains(query.toLowerCase())) {
          dummyListData.add(item);
        }
      }
      // emit(state.copyWith(listLoginCountryData:dummyListData ));
      emit(state.copyWith(searchDistrictList: dummyListData));
      return;
    } else {
      emit(state.copyWith(searchDistrictList: dummySearchList));
    }
  }

  void selectDob(String dob){
    emit(state.copyWith(selectDob: dob));
  }

  void farmerSince(String farmerSince){
    emit(state.copyWith(farmerSince: farmerSince));
  }

  void profilePicture(String profilePhoto){
    emit(state.copyWith(profileImage: profilePhoto));
  }


  // profileApi
  Future<void> profileApi(context) async {
    emit(state.copyWith(status: ProfileStatus.submit));
    var response = await apiRepository.getUserProfileApi();
    if (response.status == 200) {
      if (response.data!.user!.mobile != null) {
        state.phoneController.text = response.data!.user!.mobile.toString();
      }

      if (response.data!.user!.email != null) {
        state.emailController.text = response.data!.user!.email.toString();
      }

      if (response.data!.user!.address != null) {
        state.addressController.text =
            response.data!.user!.address!.address.toString();
      }

      emit(state.copyWith(
          status: ProfileStatus.success, responseProfile: response));
    } else {
      emit(state.copyWith(status: ProfileStatus.error));
      showCustomToast(context, response.message.toString());
    }
  }

  // improvementAreaListApi
  Future<void> improvementAreaListApi(context, String farmerId) async {
    var response = await apiRepository.getImprovementArea(int.parse(farmerId.toString()));
    if (response.status == 200) {
      emit(state.copyWith(improvementAreaListResponse: response));
    } else {
      emit(state.copyWith(status: ProfileStatus.error));
      showCustomToast(context, response.message.toString());
    }
  }

  // updateProfilePicImage
  Future<void> updateProfilePicImage(context, String image) async {
    customDialog(widget: launchProgress());
    var response = await apiRepository.updateProfileImageAPi(File(image));
    disposeProgress();
    if (response.status == 200) {
      await profileApi(context);
      disposeProgress();
      showCustomToast(context, response.message.toString());
    } else {
      emit(state.copyWith(status: ProfileStatus.error));
      showCustomToast(context, response.message.toString());
    }
  }

  Future<void> getFarmerProfile(context, {String? userId}) async{
    emit(state.copyWith(status: ProfileStatus.submit));

    var response = await apiRepository.getFarmerProfileApi(userId ?? sharedPreferences.getString(AppConstants.userId)!);
    if(response.status == 200){
      if(response.data!.farmer!.phone != null){
        state.landlineController.text = response.data!.farmer!.phone.toString();
      }
      if(response.data!.farmer!.farmSize != null){
        state.farmSize.text = response.data!.farmer!.farmSize.toString();
      }
      if(response.data!.farmer!.dairyArea != null){
        state.dairyArea.text = response.data!.farmer!.dairyArea.toString();
      }
      if(response.data!.farmer!.staffQuantity != null){
        state.staffQuantity.text = response.data!.farmer!.staffQuantity.toString();
      }
      if(response.data!.farmer!.managerName != null){
        state.managerName.text = response.data!.farmer!.managerName.toString();
      }
      if(response.data!.farmer!.managerPhone != null){
        state.managerPhone.text = response.data!.farmer!.managerPhone.toString();
      }
      await improvementAreaListApi(context, response.data!.farmer!.id.toString());
      emit(state.copyWith(status: ProfileStatus.success, responseFarmerProfile: response.data,
          selectDistrict: response.data!.farmer!.address!=null?response.data!.farmer!.address!.district!=null?
          response.data!.farmer!.address!.district!.toString():"":"",
        gender: response.data!.farmer!.gender!=null?response.data!.farmer!.gender.toString():null,
        selectDob: response.data!.farmer!.dateOfBirth!=null?response.data!.farmer!.dateOfBirth.toString():null,
        farmerSince: response.data!.farmer!.farmingExperience!=null?response.data!.farmer!.farmingExperience.toString():null
      ));
    }
    else{
      emit(state.copyWith(status: ProfileStatus.error));
      showCustomToast(context, response.message.toString());
    }
  }

  // updatePersonalDetailApi or updaterFarmerDetailApi
  Future<void> updatePersonalDetailApi(context,) async{
    customDialog(widget: launchProgress());
    var response = await apiRepository.updateFarmerDetailApi(state.gender.toString(),
        state.landlineController.text, state.profileImage.toString(), state.selectDob);
    disposeProgress();
    if (response.status == 200) {
      showCustomToast(context, response.message.toString());
      await getFarmerProfile(context);
    }
    else {
      emit(state.copyWith(status: ProfileStatus.error));
      showCustomToast(context, response.message.toString());
    }
  }

  Future<void> getStepperData(index) async{
    emit(state.copyWith(status: ProfileStatus.loading));
    List<FarmerImprovementArea> areaList = (state.improvementAreaListResponse!)
        .data!
        .improvementAreaList![index]
        .farmerImprovementArea!;
    Results resultData =
    (state.improvementAreaListResponse!).data!.improvementAreaList![index].results!;
    emit(state.copyWith(
        status: ProfileStatus.success,
        stepperData: List.generate(
          areaList.length,
              (index) => StepperItemData(
            id: '$index',
            content: {
              'title': areaList[index].parameter,
              'description': areaList[index].value,
              'uom': areaList[index].uom,
            },
            avatar: "dot",
          ),
        ),
        resultData: resultData));
  }

  // updateDdeFarmDetailApi
  Future<void> updateDdeFarmDetailApi(context) async{
    customDialog(widget: launchProgress());
    var response = await apiRepository.updateDdeFarmerDetail(state.farmSize.text, state.dairyArea.text,
        state.staffQuantity.text, state.managerName.text, state.managerPhone.text,
        state.responseFarmerProfile!.farmer!.id.toString(),
        state.landlineController.text,
      state.farmerSince,state.gender.toString(),state.selectDob
    );

    disposeProgress();

    if (response.status == 200) {
      pressBack();
      showCustomToast(context, response.message.toString());
      await getFarmerProfile(context,userId: state.responseFarmerProfile!.farmer!.userId.toString());
    }
    else {
      emit(state.copyWith(status: ProfileStatus.error));
      showCustomToast(context, response.message.toString());
    }
  }


  // updateFarmDetailApi
  Future<void> updateFarmDetailApi(context) async{
    customDialog(widget: launchProgress());
    var response = await apiRepository.updateFarmApi(state.farmSize.text, state.dairyArea.text,
        state.staffQuantity.text, state.managerName.text, state.managerPhone.text, state.responseFarmerProfile!.farmer!.id.toString());

    disposeProgress();

    if (response.status == 200) {
      showCustomToast(context, response.message.toString());
      await getFarmerProfile(context,userId: state.responseFarmerProfile!.farmer!.userId.toString());
    }
    else {
      emit(state.copyWith(status: ProfileStatus.error));
      showCustomToast(context, response.message.toString());
    }
  }

  void getDistrict(context) async {
    emit(state.copyWith(status: ProfileStatus.loading));
    var response = await apiRepository.getDistrict();
    if (response.status == 200) {
      emit(state.copyWith(
        status: ProfileStatus.success,
        districtResponse: response.data,
      ));
    } else {
      emit(state.copyWith(status: ProfileStatus.error));
      showCustomToast(context, response.message.toString());
    }
  }

////////////AddressUpdate////////////////////////
  void addressUpdateApi(
    context,String userId
  ) async {
    emit(state.copyWith(status: ProfileStatus.loading));
    customDialog(widget: launchProgress());
    var response = await apiRepository.addressUpdateApi(
        state.countryController.text.toString(),
        state.districtId.toString(),
        state.countyController.text.toString(),
        state.parishController.text.toString(),
        state.villageController.text.toString(),
        state.centreNameController.text.toString(),userId);

    disposeProgress();

    if (response.status == 200) {
      emit(state.copyWith(
          status: ProfileStatus.success, districtResponse: response.data));
      showCustomToast(context, 'Address had been updated successfully');
      await getFarmerProfile(context,userId: userId);
    } else {
      emit(state.copyWith(status: ProfileStatus.error));
      showCustomToast(context, response.message.toString());
    }
  }

}