import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:glad/data/model/auth_models/response_otp_model.dart';
import 'package:glad/data/repository/auth_repo.dart';
import 'package:glad/screen/auth_screen/create_password.dart';
import 'package:glad/screen/auth_screen/login_with_password.dart';
import 'package:glad/screen/auth_screen/otp.dart';
import 'package:glad/screen/auth_screen/upload_profile_picture.dart';
import 'package:glad/screen/custom_widget/custom_methods.dart';
import 'package:glad/screen/dde_screen/dashboard/dashboard_dde.dart';
import 'package:glad/screen/dde_screen/dde_profile.dart';
import 'package:glad/screen/farmer_screen/dashboard/dashboard_farmer.dart';
import 'package:glad/screen/farmer_screen/profile/farmer_profile.dart';
import 'package:glad/screen/guest_user/dashboard/dashboard_guest.dart';
import 'package:glad/screen/mcc_screen/dashboard/dashboard_mcc.dart';
import 'package:glad/screen/mcc_screen/profile/mcc_profile.dart';
import 'package:glad/screen/supplier_screen/dashboard/dashboard_supplier.dart';
import 'package:glad/screen/supplier_screen/profile/service_provider_profile.dart';
import 'package:glad/utils/app_constants.dart';
import 'package:glad/utils/extension.dart';
import 'package:glad/utils/helper.dart';
import 'package:location/location.dart';
import 'package:shared_preferences/shared_preferences.dart';
part 'auth_cubit_state.dart';

class AuthCubit extends Cubit<AuthCubitState>{

  final AuthRepository apiRepository;
  final SharedPreferences sharedPreferences;
  Location location = Location();

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
    if(state.confirmPasswordController.text.isEmpty){
      emit(state.copyWith(validator: 'confirmPassword',validatorString: "Please enter confirm password"));
    }else if(state.passwordController.text != state.confirmPasswordController.text){
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

  void mobileValidate(){
    if(state.emailController.text.isEmpty){
      emit(state.copyWith(validator: "mobile",validatorString: 'Please enter phone number.'));
    }else if(state.emailController.text.length<8){
      emit(state.copyWith(validator: "validNumber",validatorString: 'Please input minimum at 8 number.'));
    }else{
      emit(state.copyWith(validator: ''));
    }
  }

  // loginSingUpWithPasswordApi
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
        emit(state.copyWith(status: AuthStatus.success,id: response.data!.id.toString(),passwordController: TextEditingController()));

        if(response.data!.isFirst == 0){
          const OtpScreen(tag: "email",).navigate(isInfinity: true);
        }else{
          apiRepository.saveUserToken(response.data!.accessToken.toString());
          await sharedPreferences.setString(AppConstants.userId, response.data!.id.toString());
          await sharedPreferences.setString(AppConstants.userType, response.data!.userType.toString());
          if(response.data!.profilePic == null){
            const UploadProfilePicture().navigate(isInfinity: true);
          }else{
            if(response.data!.userType == "mcc"){
              const DashboardMCC().navigate(isInfinity: true);
            }else if(response.data!.userType == "farmer"){
              const DashboardFarmer().navigate(isInfinity: true);
            }else if(response.data!.userType == "supplier"){
              const DashboardSupplier().navigate(isInfinity: true);
            }else if(response.data!.userType == "dde"){
              const DashboardDDE().navigate(isInfinity: true);
            }
          }
        }

      }
      else{
        emit(state.copyWith(status: AuthStatus.error));
        showCustomToast(context, response.message.toString());
      }
    }
  }

  // loginSingUpWithPhone
  Future<void> loginWithPhoneAPi(context) async{
    if(state.emailController.text.isEmpty){
      emit(state.copyWith(validator: "mobile",validatorString: 'Please enter phone number.'));
    }else if(state.emailController.text.length<8){
      emit(state.copyWith(validator: "validNumber",validatorString: 'Please input minimum at 8 number.'));
    }else{
      customDialog(widget: launchProgress());
      emit(state.copyWith(status: AuthStatus.submit,validator: ''));
      var response = await apiRepository.loginWithPhoneApi(state.emailController.text);
      disposeProgress();
      // print(response);
      if(response.status == 200){
        emit(state.copyWith(status: AuthStatus.success,id: response.data!.id.toString(),validatorString: response.data!.email.toString(), userType: response.data!.userType.toString()));
           const OtpScreen(tag:"phone").navigate(isInfinity: true);
      }
      else{
        emit(state.copyWith(status: AuthStatus.error));
        showCustomToast(context, response.message.toString());
      }
    }
  }

  // resendApi
  Future<void> resendOtp(context,String forDemo) async{
    customDialog(widget: launchProgress());
    ResponseOtpModel response;
    if(forDemo == "phone"){
      response = await apiRepository.resendOtpApi(state.validatorString);
    }else{
      response = await apiRepository.resendOtpApi(state.emailController.text,);
    }
    disposeProgress();
    if (response.status == 200) {
      // response.message.toString().toast();
      showCustomToast(context, response.message.toString());
    }
    else {
      emit(state.copyWith(status: AuthStatus.error));
      // response.errors![0].message.toString().toast();
      showCustomToast(context, response.message.toString());
    }
  }

  // forgotPasswordApi
  Future<void> forgotPasswordApi(context) async{
    if(state.emailController.text.isEmpty){
      emit(state.copyWith(validator: "email",validatorString: 'Please enter email'));
    }else if(!isEmail(state.emailController.text)){
      emit(state.copyWith(validator: "emailError",validatorString: 'Please enter valid email'));
    }else{
      customDialog(widget: launchProgress());
      var response = await apiRepository.forgotPasswordApi(state.emailController.text,);
      disposeProgress();
      if (response.status == 200) {
        emit(state.copyWith(status: AuthStatus.success,id: response.data!.id.toString()));
        const OtpScreen(tag: "forgot").navigate(isInfinity: true);
      }
      else {
        emit(state.copyWith(status: AuthStatus.error));
        // response.errors![0].message.toString().toast();
        showCustomToast(context, response.message.toString());
      }
    }
  }

  ///// verifyOtpAPi /////
  Future<void> verifyOtpAPi(context) async{
    if(state.otpController.text.isEmpty){
      emit(state.copyWith(validator: 'otp'));
    }else{
      customDialog(widget: launchProgress());
      emit(state.copyWith(status: AuthStatus.submit,validator: ''));
      var response = await apiRepository.verifyOtpApi(state.otpController.text, state.id.toString());
      disposeProgress();
      if(response.status == 200){
        emit(state.copyWith(status: AuthStatus.success));
        await sharedPreferences.setString(AppConstants.userId, state.id.toString());
        await sharedPreferences.setString(AppConstants.userType, state.userType.toString());
        if(state.passwordController.text.isEmpty){
          showCustomToast(context, response.message.toString());
          CreatePassword(id:state.id,"forgotPassword").navigate(isInfinity: true);
        }else{
          CreatePassword(id: state.id,"").navigate(isInfinity: true);
        }
      }
      else
      {
        emit(state.copyWith(status: AuthStatus.error));
        showCustomToast(context, response.message.toString());
      }
    }
  }


  ///// verifyMobileOtpAPi /////
  Future<void> verifyMobileOtpAPi(context) async{
    if(state.otpController.text.isEmpty){
      emit(state.copyWith(validator: 'otp'));
    }else{
      customDialog(widget: launchProgress());
      emit(state.copyWith(status: AuthStatus.submit,validator: ''));
      var response = await apiRepository.verifyMobileOtpApi(state.otpController.text, state.id.toString());
      disposeProgress();
      if(response.status == 200){
        emit(state.copyWith(status: AuthStatus.success));
        apiRepository.saveUserToken(response.data!.accessToken.toString());
        await sharedPreferences.setString(AppConstants.userId, response.data!.id.toString());
        await sharedPreferences.setString(AppConstants.userType, response.data!.userType.toString());
        if(response.data!.profilePic == null){
          const UploadProfilePicture().navigate(isInfinity: true);
        }else{
          if(response.data!.userType == "mcc"){
            const DashboardMCC().navigate(isInfinity: true);
          }else if(response.data!.userType == "farmer"){
            const DashboardFarmer().navigate(isInfinity: true);
          }else if(response.data!.userType == "supplier"){
            const DashboardSupplier().navigate(isInfinity: true);
          }else if(response.data!.userType == "dde"){
            const DashboardDDE().navigate(isInfinity: true);
          }
        }
      }
      else
      {
        emit(state.copyWith(status: AuthStatus.error));
        showCustomToast(context, response.message.toString());
      }
    }
  }


  // createPasswordApi
  void createPasswordAPi(context,String id,String tagForgot) async{
    if(state.passwordController.text.isEmpty){
      // showCustomToast(context, "Please enter new password");
      emit(state.copyWith(validator: 'password',validatorString: 'Please enter new password'));
    }else if(state.passwordController.text.length<8){
      emit(state.copyWith(validator: 'length',validatorString: "Please choose a longer password."));
    } else if(!isPassword()){
      emit(state.copyWith(validator: 'weak',validatorString: 'Please choose a stronger password. Try a mix of letters, symbols, and numbers.'));
    }else if(state.confirmPasswordController.text.isEmpty){
      emit(state.copyWith(validator: 'confirmPassword',validatorString: "Please enter confirm password"));
    }else if(state.confirmPasswordController.text != state.passwordController.text){
      emit(state.copyWith(validator: 'invalid',validatorString: "Passwords don’t match."));
    }else{
      customDialog(widget: launchProgress());
      emit(state.copyWith(status: AuthStatus.submit));

      var response = await apiRepository.createPasswordApi(id.toString(),state.passwordController.text,state.confirmPasswordController.text);

      disposeProgress();
      if(response.status == 200){
          BlocProvider.of<AuthCubit>(context).emit(AuthCubitState.initial());
          const LoginWithPassword().navigate(isInfinity: true);
          showCustomToast(context, response.message.toString());
        // }
        emit(state.copyWith(status: AuthStatus.success));
      }else{
        emit(state.copyWith(status: AuthStatus.error));

      }
    }
  }

  Future<void> getLocation(contexts) async {
    bool serviceEnabled;
    PermissionStatus permissionGranted;

    serviceEnabled = await location.serviceEnabled();
    if (!serviceEnabled) {
      serviceEnabled = await location.requestService();
      if (!serviceEnabled) {
        return;
      }
    }

    permissionGranted = await location.hasPermission();
    if (permissionGranted == PermissionStatus.denied) {
      permissionGranted = await location.requestPermission();
      if (permissionGranted != PermissionStatus.granted) {
        return;
      }
    }

  }


  bool isLoggedIn() {
    debugPrint(apiRepository.getUserToken());
    return apiRepository.isLoggedIn();}

    clearSharedData() async {
    bool isSuccess = await apiRepository.clearSharedData();
    if(isSuccess)
      {
        const DashboardGuest().navigate(isInfinity: true);
      }
  }

  String getUserToken() {
    return apiRepository.getUserToken();}

}