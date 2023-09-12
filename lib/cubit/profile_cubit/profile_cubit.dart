import 'dart:io';

import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:glad/data/model/response_district.dart';
import 'package:glad/data/model/response_profile_model.dart';
import 'package:glad/data/model/farmer_profile_model.dart' as farmer_profile;
import 'package:glad/data/repository/profile_repo.dart';
import 'package:glad/screen/custom_widget/custom_methods.dart';
import 'package:glad/utils/app_constants.dart';
import 'package:glad/utils/extension.dart';
import 'package:glad/utils/helper.dart';
import 'package:shared_preferences/shared_preferences.dart';

part 'profile_cubit_state.dart';

class ProfileCubit extends Cubit<ProfileCubitState> {
  final ProfileRepository apiRepository;
  final SharedPreferences sharedPreferences;

  ProfileCubit({required this.apiRepository, required this.sharedPreferences})
      : super(ProfileCubitState.initial());

  void selectGender(String gender) {
    emit(state.copyWith(gender: gender));
  }

  void changeDistrict(String districtName, String districtId) {
    emit(state.copyWith(selectDistrict: districtName, districtId: districtId));
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

  void getFarmerProfile(context, {String? userId}) async {
    emit(state.copyWith(status: ProfileStatus.submit));

    var response = await apiRepository.getFarmerProfileApi(
        userId ?? sharedPreferences.getString(AppConstants.userId)!);
    if (response.status == 200) {
      emit(state.copyWith(
          status: ProfileStatus.success, responseFarmerProfile: response.data));
    } else {
      emit(state.copyWith(status: ProfileStatus.error));
      showCustomToast(context, response.message.toString());
    }
  }

  // updatePersonalDetailApi or updaterFarmerDetailApi
  Future<void> updatePersonalDetailApi(context, String gender,
      String landlineNumber, File file, String dob, String managerPhone) async {
    customDialog(widget: launchProgress());
    var response = await apiRepository.updateFarmerDetailApi(
        state.gender, landlineNumber, file, dob, managerPhone);
    if (response.status == 200) {
      showCustomToast(context, response.message.toString());
    } else {
      emit(state.copyWith(status: ProfileStatus.error));
      showCustomToast(context, response.message.toString());
    }
  }

  // updateFarmDetailApi
  Future<void> updateFarmDetailApi(context, String farmSize, String dairyArea,
      String staffQuantity, String managerName, String managerPhone) async {
    var response = await apiRepository.updateFarmApi(
        farmSize, dairyArea, staffQuantity, managerName, managerPhone);
    if (response.status == 200) {
      await profileApi(context);
      disposeProgress();
      showCustomToast(context, response.message.toString());
    } else {
      emit(state.copyWith(status: ProfileStatus.error));
      showCustomToast(context, response.message.toString());
    }
  }

  /* Future<void> addressUpdateApi(context) async{
    var response = await apiRepository.addressUpdateApi(state.addressController.text,);
    if (response.status == 200) {

      showCustomToast(context, response.message.toString());

    }
    else {
      emit(state.copyWith(status: ProfileStatus.error));
      showCustomToast(context, response.message.toString());
    }
  }*/

  void getDistrict(context) async {
    emit(state.copyWith(status: ProfileStatus.loading));
    var response = await apiRepository.getDistrict();
    if (response.status == 200) {
      emit(state.copyWith(
        status: ProfileStatus.success,
        districtResponse: response.data,
        // countyController: TextEditingController(
        //     text: state.responseFarmerProfile!.farmer!.address!.county!),
        // parishController: TextEditingController(
        //     text: state.responseFarmerProfile!.farmer!.address!.parish!),
        // villageController: TextEditingController(
        //     text: state.responseFarmerProfile!.farmer!.address!.village!),
        // centreNameController: TextEditingController(
        //     text: state.responseFarmerProfile!.farmer!.address!.centerName!),
      ));
    } else {
      emit(state.copyWith(status: ProfileStatus.error));
      showCustomToast(context, response.message.toString());
    }
  }

////////////AddressUpdate////////////////////////
  void addressUpdateApi(
    context,
  ) async {
    emit(state.copyWith(status: ProfileStatus.loading));
    var response = await apiRepository.addressUpdateApi(
        state.countryController.text.toString(),
        state.districtId.toString(),
        state.countyController.text.toString(),
        state.parishController.text.toString(),
        state.villageController.text.toString(),
        state.centreNameController.text.toString());
    if (response.status == 200) {
      emit(state.copyWith(
          status: ProfileStatus.success, districtResponse: response.data));
    } else {
      emit(state.copyWith(status: ProfileStatus.error));
      showCustomToast(context, response.message.toString());
    }
  }
}
