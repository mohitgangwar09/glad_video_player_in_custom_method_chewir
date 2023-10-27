import 'dart:io';

import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:glad/data/model/improvement_area_list_model.dart';
import 'package:glad/data/model/response_county_list.dart';
import 'package:glad/data/model/response_district.dart';
import 'package:glad/data/model/response_profile_model.dart';
import 'package:glad/data/model/farmer_profile_model.dart' as farmer_profile;
import 'package:glad/data/model/response_sub_county.dart';
import 'package:glad/data/repository/profile_repo.dart';
import 'package:glad/screen/custom_widget/custom_methods.dart';
import 'package:glad/screen/dde_screen/add_remark.dart';
import 'package:glad/utils/app_constants.dart';
import 'package:glad/utils/extension.dart';
import 'package:glad/utils/helper.dart';
import 'package:glad/utils/sharedprefrence.dart';
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
        if(response.data!.user!.address!.dialCode!=null){
          debugPrint("dialCode${response.data!.user!.address!.dialCode}");
          await SharedPrefManager.savePrefString(AppConstants.countryCode, response.data!.user!.address!.dialCode.toString());
        }

      }

      emit(state.copyWith(
          status: ProfileStatus.success, responseProfile: response));
    } else {
      print(response.message.toString());
      emit(state.copyWith(status: ProfileStatus.error));
      showCustomToast(context, response.message.toString());
    }
  }

  Future<String> getCountryCode() async{
    String countryCode = await SharedPrefManager.getPreferenceString(AppConstants.countryCode);
    return countryCode;
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
  Future<void> updateProfilePicImageRam(context, String image) async {
    customDialog(widget: launchProgress());
    var response = await apiRepository.updateProfileImageAPiRam(File(image));
    disposeProgress();
    if (response.status == 200) {
      await getFarmerProfile(context);
      disposeProgress();
      showCustomToast(context, response.message.toString(), isSuccess: true);
    } else {
      emit(state.copyWith(status: ProfileStatus.error));
      showCustomToast(context, response.message.toString());
    }
  }
  // updateProfilePicImage
  Future<void> updateFarmerKYC(context, String userId, int farmerId, String docName, String docNo, String docExpiryDate, List<String> documentFiles,
      String docType, String docTypeNo, String docTypeExpiryDate, List<String> documentTypeFiles, String profilePic) async {
    customDialog(widget: launchProgress());
    var response = await apiRepository.updateFarmerKYCStatus(farmerId, docName, docNo, docExpiryDate, documentFiles.map((e) => File(e)).toList(),
    docType, docTypeNo, docTypeExpiryDate, documentTypeFiles.map((e) => File(e)).toList(), File(profilePic));
    disposeProgress();
    if (response.status == 200) {
      getFarmerProfile(context, userId: userId);
      pressBack();
      showCustomToast(context, response.message.toString(), isSuccess: true);
    } else {
      emit(state.copyWith(status: ProfileStatus.error));
      showCustomToast(context, response.message.toString());
    }
  }

  // editFarmerKYC
  Future<void> editFarmerKYC(context, String userId, int farmerId, int id, String docName, String docNo, String docExpiryDate, List<String> documentFiles,
      String docType, String docTypeNo, String docTypeExpiryDate, List<String> documentTypeFiles, String profilePic) async {
    customDialog(widget: launchProgress());
    var response = await apiRepository.editFarmerKYCStatus(farmerId, id, docName, docNo, docExpiryDate, documentFiles.map((e) => File(e)).toList(),
        docType, docTypeNo, docTypeExpiryDate, documentTypeFiles.map((e) => File(e)).toList(), profilePic);
    disposeProgress();
    if (response.status == 200) {
      getFarmerProfile(context, userId: userId);
      // pressBack();
      const AddRemark(tag: "loan",).navigate();
      showCustomToast(context, response.message.toString(), isSuccess: true);
    } else {
      emit(state.copyWith(status: ProfileStatus.error));
      showCustomToast(context, response.message.toString());
    }
  }

  // updateProfilePicImage
  Future<void> updateProfilePicImage(context, String image) async {
    customDialog(widget: launchProgress());
    var response = await apiRepository.updateProfileImageAPi(File(image));
    print(response.status.toString());
    if (response.status == 200) {
      await profileApi(context);
      disposeProgress();
      showCustomToast(context, response.message.toString(), isSuccess: true);
    } else {
      disposeProgress();
      print(response.message.toString());
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

      if (response.data!.farmer!.address!= null) {
        if(response.data!.farmer!.address!.dialCode!=null){
          await SharedPrefManager.savePrefString(AppConstants.countryCode, response.data!.farmer!.address!.dialCode!.toString());
        }

        if(response.data!.farmer!.address!.country!=null){
          state.countryController.text = response.data!.farmer!.address!.country!;
        }

        if(response.data!.farmer!.address!.region!=null){
          state.regionController.text = response.data!.farmer!.address!.region!;
        }

        if(response.data!.farmer!.address!.district!=null){
          state.districtController.text = response.data!.farmer!.address!.district!;
          emit(state.copyWith(selectCounty: response.data!.farmer!.address!.district!));
          getCountyApi(context, response.data!.farmer!.address!.district!);
        }

        if(response.data!.farmer!.address!.subCounty!=null){
          emit(state.copyWith(selectSubCounty: response.data!.farmer!.address!.subCounty!));
        }

        // if(response.data!.farmer!.address!.district!=null){
        //   state.districtController.text = response.data!.farmer!.address!.district!;
        // }

        if(response.data!.farmer!.address!.address!=null){
          state.editAddressController.text = response.data!.farmer!.address!.address!;
        }

        if(response.data!.farmer!.address!.postalCode!=null){
          state.zipCodeController.text = response.data!.farmer!.address!.postalCode!;
        }
      }

      await improvementAreaListApi(context, response.data!.farmer!.id.toString());
      emit(state.copyWith(status: ProfileStatus.success, responseFarmerProfile: response.data,
          selectDistrict: response.data!.farmer!.address!=null?response.data!.farmer!.address!.district!=null?
          response.data!.farmer!.address!.district!.toString():"":"",
        gender: response.data!.farmer!.gender!=null?response.data!.farmer!.gender.toString().capitalized():null,
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
        state.landlineController.text, state.profileImage.toString(), state.selectDob,state.farmerSince);
    disposeProgress();
    if (response.status == 200) {
      showCustomToast(context, response.message.toString(), isSuccess: true);
      await getFarmerProfile(context);
      pressBack();
    }
    else {
      emit(state.copyWith(status: ProfileStatus.error));
      showCustomToast(context, response.message.toString());
    }
  }

  // updatePersonalDetailApi or updaterFarmerDetailApi
  Future<bool> validateCountry(context, String country) async{
    customDialog(widget: launchProgress());
    var response = await apiRepository.validatedAddressCountry(country);
    disposeProgress();
    if (response.status == 200) {
      return true;
    }
    else {
      showCustomToast(context, response.message.toString());
      return false;
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

  // updateImprovementAreaApi
  void updateImprovementAreaApi(
      context, int farmerId, int improvementIndex) async {
    // emit(state.copyWith(status: ImprovementAreaStatus.loading));
    List<Map<String, dynamic>> updatedData = [];
    for (int index = 0; index < state.areaControllers!.length; index++) {
      updatedData.add({
        'id': state.improvementAreaListResponse!.data!.improvementAreaList![improvementIndex]
            .farmerImprovementArea![index].id.toString(),
        'value': state.areaControllers![index].text.toString()
      });
    }
    customDialog(widget: launchProgress());
    var response = await apiRepository.updateImprovementArea({
      'farmer_id': farmerId.toString(),
      'improvementAreaData': updatedData,
    });
    if (response.status == 200) {
      disposeProgress();
      showCustomToast(context, 'Improvement Area updated', isSuccess: true);
      pressBack();
      await improvementAreaListApi(context, farmerId.toString());
      getStepperData(improvementIndex);
    } else {
      emit(state.copyWith(status: ProfileStatus.error));
      showCustomToast(context, response.message.toString());
    }
  }

  void generateController(int improvementIndex) {
    List<TextEditingController> con = [];
    emit(state.copyWith(areaControllers: []));

    for (FarmerImprovementArea area in state.improvementAreaListResponse!.data!
        .improvementAreaList![improvementIndex].farmerImprovementArea!) {
      con.add(TextEditingController(text: area.value));
      print(area.value);
    }
    emit(state.copyWith(areaControllers: [...con]));
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
      showCustomToast(context, response.message.toString(), isSuccess: true);
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
      showCustomToast(context, response.message.toString(), isSuccess: true);
      await getFarmerProfile(context,userId: state.responseFarmerProfile!.farmer!.userId.toString());
      pressBack();
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

  void getCountyApi(context,String district) async {
    emit(state.copyWith(status: ProfileStatus.loading));
    var response = await apiRepository.getCountyByDistrictApi(state.districtController.text);
    if (response.status == 200) {
      List<Counties> counties= [];
      if(response.data!=null){
        counties = response.data![0].counties!;
        // counties = response.data![0].counties!;
      }

      emit(state.copyWith(
        status: ProfileStatus.success,
        responseCountyList: response,counties: counties
      ));
    } else {
      emit(state.copyWith(status: ProfileStatus.error));
      showCustomToast(context, response.message.toString());
    }
  }

  void getSubCountyApi(context,String id) async {
    emit(state.copyWith(status: ProfileStatus.loading));
    var response = await apiRepository.getSubCountyApi(id);
    if (response.status == 200) {
      List<DataSubCounty> subCounties = [];
      if(response.data!=null){
         subCounties = response.data!;
      }
      emit(state.copyWith(
        status: ProfileStatus.success,
        responseSubCounty: response,dataSubCounty: subCounties
      ));
    } else {
      emit(state.copyWith(status: ProfileStatus.error));
      showCustomToast(context, response.message.toString());
    }
  }

////////////AddressUpdate////////////////////////
  void addressUpdateApi(
    context,String userId,latitude,longitude
  ) async {
    if(state.selectCounty == "Select County"){
      showCustomToast(context, 'Please select county');
    }else if(state.selectSubCounty == "Select Sub County"){
      showCustomToast(context, 'Please select sub county');
    }else if(state.editAddressController.text.isEmpty){
      showCustomToast(context, 'Please enter address');
    }else{
      emit(state.copyWith(status: ProfileStatus.loading));
      customDialog(widget: launchProgress());
      var response = await apiRepository.addressUpdateApi(
          state.countryController.text.toString(),
          state.districtController.text.toString(),
          state.regionController.text.toString(),
          state.selectCounty.toString(),
          state.selectSubCounty.toString(),
          state.zipCodeController.text.toString(),
          state.editAddressController.text.toString(),latitude,longitude,userId);

      disposeProgress();

      if (response.status == 200) {
        emit(state.copyWith(
            status: ProfileStatus.success, districtResponse: response.data));
        showCustomToast(context, 'Address has been updated successfully', isSuccess: true);
        await getFarmerProfile(context,userId: userId);
        pressBack();
      } else {
        emit(state.copyWith(status: ProfileStatus.error));
        showCustomToast(context, response.message.toString());
      }
    }
  }

}