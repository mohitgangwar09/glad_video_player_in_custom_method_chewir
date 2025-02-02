import 'dart:io';

import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:glad/cubit/project_cubit/project_cubit.dart';
import 'package:glad/data/model/auth_models/mail_login_model.dart';
import 'package:glad/data/model/farmers_list.dart';
import 'package:glad/data/model/livestock_cart_list.dart';
import 'package:glad/data/model/livestock_detail.dart';
import 'package:glad/data/model/livestock_list_model.dart';
import 'package:glad/data/model/response_breed.dart';
import 'package:glad/data/model/response_faq_list.dart';
import 'package:glad/data/model/response_loan_application_list.dart';
import 'package:glad/data/model/response_my_livestock.dart';
import 'package:glad/data/model/training_and_news_category_model.dart';
import 'package:glad/data/model/training_detail_model.dart';
import 'package:glad/data/model/training_list_model.dart';
import 'package:glad/data/model/youtube_video_statistics_model.dart';
import 'package:glad/data/repository/others_repo.dart';
import 'package:glad/screen/livestock/livestock_cart_list_screen.dart';
import 'package:glad/screen/common/thankyou_livestock.dart';
import 'package:glad/screen/custom_widget/custom_methods.dart';
import 'package:glad/utils/app_constants.dart';
import 'package:glad/utils/extension.dart';
import 'package:glad/utils/helper.dart';
import 'package:shared_preferences/shared_preferences.dart';
part 'livestock_cubit_state.dart';

class LivestockCubit extends Cubit<LivestockCubitState>{

  final OthersRepository apiRepository;
  final SharedPreferences sharedPreferences;

  LivestockCubit({required this.apiRepository,required this.sharedPreferences}) : super(LivestockCubitState.initial());

  void roiFilter(String filter) async{
    emit(state.copyWith(roiFilter: filter));
  }

  void ageCheck(String from,String upTo){
    emit(state.copyWith(ageFromController: TextEditingController(text: from),ageUpToController: TextEditingController(text: upTo)));
  }

  void selectedDdeFarmerLivestockDetail(FarmerMAster? farmerMAster) async{
    emit(state.copyWith(selectedLivestockFarmerMAster: farmerMAster));
  }

  void livestockClearFilter(){
    emit(state.copyWith(
        breedNameSelected: TextEditingController(text: ''),
        ageFromController: TextEditingController(text: ''),
        ageUpToController: TextEditingController(text: ''),
        priceFromController: TextEditingController(text: ''),
        priceUpToController: TextEditingController(text: ''),
        lactationFromController: TextEditingController(text: ''),
        lactationUpToController: TextEditingController(text: ''),
        yieldFromController: TextEditingController(text: ''),
        yieldUpToController: TextEditingController(text: '')
    ));
  }

  // trainingListApi
  Future<void> livestockBreedApi(context) async{
    var response = await apiRepository.getLivestockBreedApi();
    if (response.status == 200) {
      emit(state.copyWith(status: LivestockStatus.success, breed: response));
    }
    else {
      emit(state.copyWith(status: LivestockStatus.error));
      if(response.message!=null){
        showCustomToast(context, response.message.toString());
      }
      // showCustomToast(context, response.message.toString());
    }
  }

  // trainingListApi
  Future<void> livestockListApi(context,bool showLoader,{String? searchQuery}) async{
    if (showLoader) {
      emit(state.copyWith(status: LivestockStatus.submit));
    }
    var response = await apiRepository.getLivestockListApi(searchQuery:searchQuery,
      ageFrom: state.ageFromController.text.toString(),
      ageUpTo: state.ageUpToController.text.toString(),
      priceFrom: state.priceFromController.text.toString(),
      priceUpTo: state.priceUpToController.text.toString(),
      lactationFrom: state.lactationFromController.text.toString(),
      lactationUpTo: state.lactationFromController.text.toString(),
      yieldFrom: state.yieldFromController.text.toString(),
      yieldUpTo: state.yieldUpToController.text.toString(),
      cowBreed: state.breedNameSelected.text.toString(),
      orderBy: state.roiFilter
    );
    if (response.status == 200) {
      emit(state.copyWith(status: LivestockStatus.success, responseLivestockList: response));
    }
    else {
      emit(state.copyWith(status: LivestockStatus.error));
      if(response.message!=null){
        showCustomToast(context, response.message.toString());
      }
      // showCustomToast(context, response.message.toString());
    }
  }

  // trainingListApi
  Future<void> myLivestockListApi(context, String search, {bool isLoaderRequired = true}) async{
    if(isLoaderRequired) {
      emit(state.copyWith(status: LivestockStatus.submit));
    }
    var response = await apiRepository.getMyLivestockListApi(search);
    if (response.status == 200) {
      emit(state.copyWith(status: LivestockStatus.success, responseMyLivestockList: response));
    }
    else {
      emit(state.copyWith(status: LivestockStatus.error));
      if(response.message!=null){
        showCustomToast(context, response.message.toString());
      }
      // showCustomToast(context, response.message.toString());
    }
  }

  // trainingListApi
  Future<void> livestockDetailApi(context, String id, {bool isLoaderRequired = true,String? userId}) async{
    if(isLoaderRequired) {
      emit(state.copyWith(status: LivestockStatus.submit));
    }
    var response = await apiRepository.getLivestockDetailApi(id,userId: userId);
    if (response.status == 200) {
      emit(state.copyWith(status: LivestockStatus.success, responseLivestockDetail: response));
    }
    else {
      if( response.message == "This ad has been removed by the seller"){
        pressBack();
      }
      emit(state.copyWith(status: LivestockStatus.error));
      if(response.message!=null){
        showCustomToast(context, response.message.toString());
      }
      // showCustomToast(context, response.message.toString());
    }
  }

  ///// verifyProjectStatusApi /////
  Future<MobileLoginModel> verifyProjectStatus(context,String otp,) async{

    customDialog(widget: launchProgress());
    // emit(state.copyWith(status: ProjectStatus.loading));
    var response = await apiRepository.verifyMobileApi(otp, BlocProvider.of<ProjectCubit>(context).state.userIdForOtpValidate.toString());
    disposeProgress();

    if(response.status == 200){


      return response;

    }
    else
    {
      if(response.message!=null){
        showCustomToast(context, response.message.toString());
      }
      // showCustomToast(context, response.message.toString());
      return MobileLoginModel(status: 422);
      // emit(state.copyWith(status: ProjectStatus.error));
    }
  }

  Future<void> livestockAddApi(context, String breedId, List<String> paths, String milk, String lactation, String price, String pregnant, String cowQty, String age, String description,{String? userId}) async{
    customDialog(widget: launchProgress());
    var response = await apiRepository.addLivestockApi(breedId, paths, milk, lactation, price, pregnant, cowQty, age, description,
    userId: sharedPreferences.getString(AppConstants.userType) == "dde"?userId:null);
    disposeProgress();
    if (response.status == 200) {
      showCustomToast(context, response.message.toString(), isSuccess: true);
      ThankYouLivestock(response: response).navigate();
    }
    else {
      emit(state.copyWith(status: LivestockStatus.error));
      if(response.message!=null){
        showCustomToast(context, response.message.toString());
      }
      // showCustomToast(context, response.message.toString());
    }
  }

  Future<void> livestockUpdateApi(context, String id, String breedId, List<String> paths, String milk, String lactation, String price, String pregnant, String cowQty, String age, String description) async{
    customDialog(widget: launchProgress());
    var response = await apiRepository.updateLivestockApi(id, breedId, paths, milk, lactation, price, pregnant, cowQty, age, description);
    if (response.status == 200) {
      showCustomToast(context, response.message.toString(), isSuccess: true);
      livestockDetailApi(context, id, isLoaderRequired: false);
      myLivestockListApi(context, '');
      disposeProgress();
      pressBack();
    }
    else {
      disposeProgress();
      emit(state.copyWith(status: LivestockStatus.error));
      if(response.message!=null){
        showCustomToast(context, response.message.toString());
      }
      // showCustomToast(context, response.message.toString());
    }
  }

  Future<void> livestockDeleteMediaApi(context, String id, String livestockId) async{
    var response = await apiRepository.deleteMediaApi(id);
    if (response.status == 200) {
      showCustomToast(context, response.message.toString(), isSuccess: true);
      livestockDetailApi(context, livestockId);
      myLivestockListApi(context, '');
    }
    else {
      if(response.message!=null){
        showCustomToast(context, response.message.toString());
      }
      // showCustomToast(context, response.message.toString());
    }
  }

  Future<void> livestockAddToCartApi(context, livestockId,int quantity,String price,{String? userId}) async{

    var response = await apiRepository.addToCartLivestockApi(livestockId,quantity, price,userId:userId.toString());
    if (response.status == 200) {
      // pressBack();
      // livestockDetailApi(context, livestockId, isLoaderRequired: false);
      if(response.message == "LiveStock from other supplier exists in the cart"){
        customDialog(
            widget: Center(
              child: Material(
                borderRadius: BorderRadius.circular(15),
                child: Container(
                  height: 150,
                  width: screenWidth()-30,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(15),
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [

                      // "Are you sure to remove other supplier cart?".textMedium(
                      Padding(padding: const EdgeInsets.only(left: 4,right: 4),
                      child: "LiveStock from other supplier exists in the cart. Do you want to replace it?".textMedium(
                          fontSize: 18,
                          textAlign: TextAlign.center,
                          color: Colors.black
                      ),),

                      20.verticalSpace(),

                      Row(
                        children: [

                          20.horizontalSpace(),

                          Expanded(
                            child: customButton("No",
                                borderColor: 0xFF6A0030,
                                color: 0xFFffffff,onTap: (){
                                  pressBack();
                                }),
                          ),

                          20.horizontalSpace(),

                          Expanded(
                            child: customButton("Yes",fontColor: 0xFFffffff, onTap: ()async{
                              if(sharedPreferences.getString(AppConstants.userType) == "dde"){
                                await emptyCartApi(context,livestockId,quantity,price,userId:userId.toString());
                              }else{
                                await emptyCartApi(context,livestockId,quantity,price);
                              }
                            }),
                          ),

                          20.horizontalSpace(),

                        ],
                      ),

                    ],
                  ),
                ),
              ),
            )
        );
      }else{
        showCustomToast(context, response.message.toString(), isSuccess: true);
        if(sharedPreferences.getString(AppConstants.userType) == "dde"){
          LiveStockCartListScreen(navigates: 'live',userId: userId.toString(),).navigate(isInfinity: true);
        }else{
          const LiveStockCartListScreen(navigates: 'live',).navigate(isInfinity: true);
        }
      }
    }
    else {
      if(response.message!=null){
        showCustomToast(context, response.message.toString());
      }
      // showCustomToast(context, response.message.toString());
    }
  }

  Future<void> livestockCartListApi(context, {bool isLoaderRequired = true,String? userId}) async{
    if(isLoaderRequired) {
      emit(state.copyWith(status: LivestockStatus.submit));
    }
    var response = await apiRepository.getLivestockCartListApi(userId:userId);
    if (response.status == 200) {
      emit(state.copyWith(status: LivestockStatus.success, responseLivestockCartList: response));
    } else {
      emit(state.copyWith(status: LivestockStatus.error));
    }
  }


  Future<void> livestockCartItemRemoveApi(context, int id,{String? userId}) async{
    customDialog(widget: launchProgress());
    var response = await apiRepository.livestockDeleteCartItemApi(id,userId: sharedPreferences.getString(AppConstants.userType).toString() == "dde"?userId:null);
    if (response.status == 200) {
      disposeProgress();
      livestockCartListApi(context, isLoaderRequired: false,userId: userId);
    } else {
      disposeProgress();
      emit(state.copyWith(status: LivestockStatus.error));
    }
  }

  Future<void> livestockUpdateCartApi(context, int cartId, int cowQty,{String? userId}) async{
    customDialog(widget: launchProgress());
    var response = await apiRepository.livestockUpdateCartApi(cartId, cowQty,userId: sharedPreferences.getString(AppConstants.userType)=="dde"?userId:null);
    if (response.status == 200) {
      disposeProgress();
      livestockCartListApi(context, isLoaderRequired: false,userId: userId);
    } else {
      disposeProgress();
      emit(state.copyWith(status: LivestockStatus.error));
    }
  }

  // updateSoldCowApi
  Future<void> updateSoldCowApi(context, int cartId, int soldCows) async{
    customDialog(widget: launchProgress());
    var response = await apiRepository.updateSoldCowApi(cartId, soldCows);
    if (response.status == 200) {
      disposeProgress();
      showCustomToast(context, response.message.toString());
      await livestockDetailApi(context, cartId.toString(),isLoaderRequired: false);
      pressBack();
      // livestockCartListApi(context, isLoaderRequired: false);
    } else {
      disposeProgress();
      if(response.message!=null){
        showCustomToast(context, response.message.toString());
      }
      emit(state.copyWith(status: LivestockStatus.error));
    }
  }

  // removeLivestockAPi
  Future<void> removeLivestockAPi(context, int id) async{
    customDialog(widget: launchProgress());
    var response = await apiRepository.removeLivestockApi(id);
    if (response.status == 200) {
      disposeProgress();
      showCustomToast(context, response.message.toString());
      // await livestockDetailApi(context, id.toString(),isLoaderRequired: false);
      pressBack();
      myLivestockListApi(context, '', isLoaderRequired: false);
    } else {
      disposeProgress();
      showCustomToast(context, response.message.toString());
      emit(state.copyWith(status: LivestockStatus.error));
    }
  }

  // livestockLoanApi
  Future<void> applyLivestockLoanApi(context, int id,String farmerParticipation,
      String remarks,String addressDocName, String addressDocNo, String addressDocExpiryDate,
      List<String> documentFiles,String idDocName,
      String idDocTypeNo, String idDocTypeExpiryDate, List<String> documentTypeFiles, String farmerPhoto,FarmerMaster farmerMaster) async{
    customDialog(widget: launchProgress());
    var response = await apiRepository.applyLivestockLoanApi(id, farmerParticipation, remarks,
    userId: sharedPreferences.getString(AppConstants.userType)== "dde"?state.responseLivestockCartList!.data![0].userId.toString():null);
    if (response.status == 200) {
      disposeProgress();
      BlocProvider.of<ProjectCubit>(context).
      liveStockKycApi(context, response.data!.farmerId.toString(), response.data!.id.toString(),
          addressDocName, addressDocNo,
          addressDocExpiryDate, documentFiles,
          idDocName, idDocTypeNo, idDocTypeExpiryDate,
          documentTypeFiles, farmerPhoto,farmerMaster);
    } else {
      if(response.message!=null){
        showCustomToast(context, response.message.toString());
      }
      // showCustomToast(context, response.message.toString());
      disposeProgress();
      emit(state.copyWith(status: LivestockStatus.error));
    }
  }


  // livestockLoanApi
  Future<void> livestockDeliveryStatusApi(context,int id,
      String farmerProjectId, String remarks, String deliveryStatus,
      List<String> docFile) async{
    customDialog(widget: launchProgress());
    var response = await apiRepository.deliveryStatusApi(id, farmerProjectId, remarks, deliveryStatus, docFile.map((e) => File(e)).toList());
    if (response.status == 200) {
      disposeProgress();
      showCustomToast(context, response.message.toString());
      disposeProgress();
      BlocProvider.of<ProjectCubit>(context)
          .farmerProjectDetailApi(context, int.parse(farmerProjectId));
      // emit(state.copyWith(confirmDelivery: 'done'));
      pressBack();
    } else {
      disposeProgress();
      emit(state.copyWith(status: LivestockStatus.error));
    }
  }

  // updateSoldCowApi
  Future<void> emptyCartApi(context,livestockId, int quantity, String price,{String? userId}) async{
    customDialog(widget: launchProgress());
    var response = await apiRepository.emptyCartApi(userId: sharedPreferences.getString(AppConstants.userType)=="dde"?userId:null);
    if (response.status == 200) {
      await livestockAddToCartApi(context, livestockId, quantity, price,userId: userId);
    } else {
      disposeProgress();
      emit(state.copyWith(status: LivestockStatus.error));
    }
  }

  // loanListApi
  Future<void> loanListApi(context,String type) async{

    emit(state.copyWith(status: LivestockStatus.submit));
    var response = await apiRepository.loanListApi(type);
    if (response.status == 200) {

      emit(state.copyWith(responseLoanApplicationList: response,status: LivestockStatus.success));
    } else {
      disposeProgress();
      emit(state.copyWith(status: LivestockStatus.error));
    }
  }

  // updateNegotiateApi
  Future<void> updateNegotiateApi(context, String livestockId, String negotiatedPrice, String userId) async{
    var response = await apiRepository.updateNegotiatedPrice(livestockId, negotiatedPrice, userId);
    if (response.status == 200) {
      showCustomToast(context, response.message.toString(), isSuccess: true);
    }
    else {
      emit(state.copyWith(status: LivestockStatus.error));
      if(response.message!=null){
        showCustomToast(context, response.message.toString());
      }
      // showCustomToast(context, response.message.toString());
    }
  }


  String getUserToken() {
    return apiRepository.getUserToken();}

}