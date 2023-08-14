import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:glad/data/repository/auth_repo.dart';
import 'package:glad/utils/extension.dart';
import 'package:shared_preferences/shared_preferences.dart';
part 'auth_cubit_state.dart';

class AuthCubit extends Cubit<AuthCubitState>{

  final AuthRepository apiRepository;
  final SharedPreferences? sharedPreferences;
  bool isEmail(String em) {
    String p =
        r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
    RegExp regExp = RegExp(p);
    return regExp.hasMatch(em);}

  AuthCubit({required this.apiRepository,this.sharedPreferences}) : super(AuthCubitState.initial());

  void passwordVisible() {
    emit(state.copyWith(passwordVisible: state.passwordVisible == false ? true:false));
  }

  void confirmVisible() {
    emit(state.copyWith(confirmVisible: state.confirmVisible == false ? true:false));
  }

  // loginSingUpWithPhone
  Future<void> loginWithPasswordAPi(context) async{
    if(state.emailController.text.isEmpty){
      showCustomToast(context, "Please enter email");
    }else if(!isEmail(state.emailController.text)){
      showCustomToast(context, "Please enter valid email");
    }else if(state.passwordController.text.isEmpty){
      showCustomToast(context, "Please enter password");
    }else{
      emit(state.copyWith(status: AuthStatus.submit));

      var response = await apiRepository.loginAndSignUpWithPhoneApi(state.emailController.text,
         state.passwordController.text);
      if(response.statusCode == 200){
        emit(state.copyWith(status: AuthStatus.success,token: response.data!.token));
      }
      else{
        emit(state.copyWith(status: AuthStatus.error));
        showCustomToast(context, response.errors![0].message.toString());
        // response.errors![0].message.toString().toast();
      }
    }
  }


  // createPasswordApi
  void resetPasswordAPi(context) async{
    if(state.passwordController.text.isEmpty){
      // emit(state.copyWith(validator: 'password'));
    }else if(state.emailController.text.isEmpty){
      // emit(state.copyWith(validator: 'confirmPassword'));
    }else if(state.emailController.text != state.passwordController.text){
      // emit(state.copyWith(validator: 'invalid'));
    }else{

      emit(state.copyWith(status: AuthStatus.submit));

      var response = await apiRepository.createPasswordApi(state.passwordController.text);

      if(response.statusCode == 200){

        emit(state.copyWith(status: AuthStatus.success));
      }
    }
  }


  bool isLoggedIn() {
    return apiRepository.isLoggedIn();}

    clearSharedData() async {
    bool isSuccess = await apiRepository.clearSharedData();
    if(isSuccess)
      {

      }
  }

  String getUserToken() {
    return apiRepository.getUserToken();}

}