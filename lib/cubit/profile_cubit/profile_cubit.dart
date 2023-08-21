import 'dart:io';

import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:glad/data/model/response_profile_model.dart';
import 'package:glad/data/repository/profile_repo.dart';
import 'package:glad/screen/custom_widget/custom_methods.dart';
import 'package:glad/utils/extension.dart';
import 'package:glad/utils/helper.dart';
import 'package:shared_preferences/shared_preferences.dart';
part 'profile_cubit_state.dart';

class ProfileCubit extends Cubit<ProfileCubitState>{

  final ProfileRepository apiRepository;
  final SharedPreferences sharedPreferences;

  ProfileCubit({required this.apiRepository,required this.sharedPreferences}) : super(ProfileCubitState.initial());

  // profileApi
  Future<void> profileApi(context) async{

      emit(state.copyWith(status: ProfileStatus.submit));
      var response = await apiRepository.getUserProfileApi();
      if(response.status == 200){
        if(response.data!.user!.mobile!=null){
          state.phoneController.text = response.data!.user!.mobile.toString();
        }

        if(response.data!.user!.email!=null){
          state.emailController.text = response.data!.user!.email.toString();
        }
       /* if(response.data!.user!.address!=null){
          state.addressController.text = response.data!.user!.address.toString();
        }*/
        emit(state.copyWith(status: ProfileStatus.success,responseProfile: response));

      }
      else{
        emit(state.copyWith(status: ProfileStatus.error));
        showCustomToast(context, response.message.toString());
      }
  }

  // updateProfilePicImage
  Future<void> updateProfilePicImage(context,String image) async{
    customDialog(widget: launchProgress());
    var response = await apiRepository.updateProfileImageAPi(File(image));
    disposeProgress();
    if (response.status == 200) {
      await profileApi(context);
      disposeProgress();
      showCustomToast(context, response.message.toString());
    }
    else {
      emit(state.copyWith(status: ProfileStatus.error));
      showCustomToast(context, response.toString());
    }
  }

}