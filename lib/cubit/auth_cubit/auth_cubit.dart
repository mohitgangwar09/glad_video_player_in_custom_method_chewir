import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:glad/data/repository/auth_repo.dart';
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

  // loginSingUpWithPhone
  /*Future<void> loginAndSignUpWithPhoneAPi() async{
    if(state.phoneController.text.isEmpty){
      emit(state.copyWith(validator: 'phone'));
    }else{
      emit(state.copyWith(status: AuthStatus.submit,validator: ''));

      var response = await apiRepository.loginAndSignUpWithPhoneApi(state.phoneController.text,
       //   state.isTermsAndCondition,countryCode, );
          true,countryCode, );
      if(response.statusCode == 200){
        emit(state.copyWith(status: AuthStatus.success,token: response.data!.token));
        const VerifyScreen().navigate(isInfinity: true);
      }
      else{
        emit(state.copyWith(status: AuthStatus.error));
        // response.errors![0].message.toString().toast();
        showCustomToast(context, response.errors![0].message.toString());
        // response.errors![0].message.toString().toast();
      }
    }
  }*/

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