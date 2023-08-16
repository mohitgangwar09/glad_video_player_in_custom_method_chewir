import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:glad/data/repository/auth_repo.dart';
import 'package:glad/screen/auth_screen/create_password.dart';
import 'package:glad/screen/auth_screen/otp.dart';
import 'package:glad/screen/auth_screen/upload_profile_picture.dart';
import 'package:glad/screen/custom_widget/custom_methods.dart';
import 'package:glad/screen/farmer_screen/dashboard/dashboard_farmer.dart';
import 'package:glad/utils/extension.dart';
import 'package:glad/utils/helper.dart';
import 'package:shared_preferences/shared_preferences.dart';
part 'auth_cubit_state.dart';

class AuthCubit extends Cubit<AuthCubitState>{

  final AuthRepository apiRepository;
  final SharedPreferences sharedPreferences;

  bool isEmail(String em) {
    String p =
        r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
    RegExp regExp = RegExp(p);
    return regExp.hasMatch(em);}

  bool isPassword() {
    bool passValid = RegExp("^(?=.{8,32}\$)(?=.*[a-z])(?=.*[a-z])(?=.*[0-9])(?=.*[!@#\$%^&*(),.?:{}|<>]).*").hasMatch(state.passwordController.text);
    return passValid;
  }

  AuthCubit({required this.apiRepository,required this.sharedPreferences}) : super(AuthCubitState.initial());

  void passwordVisible() {
    emit(state.copyWith(passwordVisible: state.passwordVisible == false ? true:false));
  }

  void confirmVisible() {
    emit(state.copyWith(confirmVisible: state.confirmVisible == false ? true:false));
  }

  void password(){
    if(state.passwordController.text.isEmpty){
      emit(state.copyWith(validator: 'password',validatorString: 'Please enter new password'));
    }else if(state.passwordController.text.length<8){
      emit(state.copyWith(validator: 'length',validatorString: "Please choose a longer password."));
    } else if(!isPassword()){
      emit(state.copyWith(validator: 'weak',validatorString: 'Please choose a stronger password. Try a mix of letters, symbols, and numbers.'));
    }/*else if(state.emailController.text.isEmpty){
      emit(state.copyWith(validator: 'confirmPassword',validatorString: "Please enter confirm password"));
    }else if(state.emailController.text != state.passwordController.text){
      emit(state.copyWith(validator: 'invalid',validatorString: "Passwords don’t match."));
    }*/else{
      emit(state.copyWith(validator: ''));
    }
  }

  void confirmValidate(){
    if(state.emailController.text.isEmpty){
      emit(state.copyWith(validator: 'confirmPassword',validatorString: "Please enter confirm password"));
    }else if(state.emailController.text != state.passwordController.text){
      emit(state.copyWith(validator: 'invalid',validatorString: "Passwords don’t match."));
    }else{
      emit(state.copyWith(validator: ''));
    }
  }

  void emailValidate(){
    if(state.emailController.text.isEmpty){
      emit(state.copyWith(validator: 'email',validatorString: "Please enter email"));
    }else if(!isEmail(state.emailController.text)){
      emit(state.copyWith(validator: "emailError",validatorString: 'Please enter valid email'));
    }else{
      emit(state.copyWith(validator: ''));
    }
  }

  // loginSingUpWithPhone
  Future<void> loginWithPasswordAPi(context) async{
    if(state.emailController.text.isEmpty){
      emit(state.copyWith(validator: "email",validatorString: 'Please enter email'));
    }else if(!isEmail(state.emailController.text)){
      emit(state.copyWith(validator: "emailError",validatorString: 'Please enter valid email'));
    }else if(state.passwordController.text.isEmpty){
      emit(state.copyWith(validator: "password",validatorString:"please enter password"));
    }else{
      customDialog(widget: launchProgress());
      emit(state.copyWith(status: AuthStatus.submit,validator: ''));
      var response = await apiRepository.loginWithPasswordApi(state.emailController.text,
         state.passwordController.text);
      disposeProgress();
      // print(response);
      if(response.status == 200){
        emit(state.copyWith(status: AuthStatus.success,id: response.data!.id));
        if(response.data!.userType == "mcc"){
          if(response.data!.isFirst == 0){
            const OtpScreen().navigate();
          }else{
            const DashboardFarmer().navigate(isInfinity: true);
          }
        }else if(response.data!.userType == "farmer"){

        }else{

        }

      }
      else{
        emit(state.copyWith(status: AuthStatus.error));
        showCustomToast(context, response.message.toString());
      }
    }
  }


  /*Future<void> resendOtp(context) async{
    customDialog(widget: launchProgress());
    var response = await apiRepository.resendOtpApi(state.token,);
    disposeProgress();
    if (response.statusCode == 200) {
      // response.message.toString().toast();
      showCustomToast(context, response.message.toString());
    }
    else {
      emit(state.copyWith(status: AuthStatus.error));
      // response.errors![0].message.toString().toast();
      showCustomToast(context, response.errors![0].message.toString());
    }
  }*/

  ///// verifyOtpAPi /////
  Future<void> verifyOtpAPi(context) async{
    if(state.otpController.text.isEmpty){
      emit(state.copyWith(validator: 'otp'));
    }else{
      customDialog(widget: launchProgress());
      emit(state.copyWith(status: AuthStatus.submit,validator: ''));
      var response = await apiRepository.verifyOtpApi(state.otpController.text, state.id);
      disposeProgress();
      if(response.statusCode == 200){
        emit(state.copyWith(status: AuthStatus.success));
        if(state.passwordController.text.isEmpty){
          // const DashboardFarmer().navigate(isInfinity: true);
          const UploadProfilePicture().navigate();
        }else{
          const CreatePassword().navigate(isInfinity: true);
        }
      }
      else
      {
        emit(state.copyWith(status: AuthStatus.error));
        showCustomToast(context, response['message']);
      }
    }
  }


  // createPasswordApi
  void resetPasswordAPi(context) async{
    if(state.passwordController.text.isEmpty){
      showCustomToast(context, "Please enter new password");
      emit(state.copyWith(validator: 'password',validatorString: '"Please enter new password"'));
    }else if(state.passwordController.text.length<8){
      emit(state.copyWith(validator: 'length',validatorString: "Please choose a longer password."));
    } else if(!isPassword()){
      emit(state.copyWith(validator: 'weak',validatorString: 'Please choose a stronger password. Try a mix of letters, symbols, and numbers.'));
    }else if(state.emailController.text.isEmpty){
      emit(state.copyWith(validator: 'confirmPassword',validatorString: "Please enter confirm password"));
    }else if(state.emailController.text != state.passwordController.text){
      emit(state.copyWith(validator: 'invalid',validatorString: "Passwords don’t match."));
    }else{

      emit(state.copyWith(status: AuthStatus.submit));

      var response = await apiRepository.createPasswordApi(state.id,state.passwordController.text,state.emailController.text);

      if(response.statusCode == 200){
        const DashboardFarmer().navigate();
        emit(state.copyWith(status: AuthStatus.success));
      }else{
        emit(state.copyWith(status: AuthStatus.error));
        showCustomToast(context, response['message']);
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