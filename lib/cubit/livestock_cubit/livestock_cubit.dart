import 'dart:io';

import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:glad/cubit/project_cubit/project_cubit.dart';
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
import 'package:glad/utils/extension.dart';
import 'package:glad/utils/helper.dart';
import 'package:shared_preferences/shared_preferences.dart';
part 'livestock_cubit_state.dart';

class LivestockCubit extends Cubit<LivestockCubitState>{

  final OthersRepository apiRepository;
  final SharedPreferences sharedPreferences;

  LivestockCubit({required this.apiRepository,required this.sharedPreferences}) : super(LivestockCubitState.initial());

  // trainingListApi
  Future<void> livestockBreedApi(context) async{
    var response = await apiRepository.getLivestockBreedApi();
    if (response.status == 200) {
      emit(state.copyWith(status: LivestockStatus.success, breed: response));
    }
    else {
      emit(state.copyWith(status: LivestockStatus.error));
      showCustomToast(context, response.message.toString());
    }
  }

  // trainingListApi
  Future<void> livestockListApi(context) async{
    emit(state.copyWith(status: LivestockStatus.submit));
    var response = await apiRepository.getLivestockListApi();
    if (response.status == 200) {
      emit(state.copyWith(status: LivestockStatus.success, responseLivestockList: response));
    }
    else {
      emit(state.copyWith(status: LivestockStatus.error));
      showCustomToast(context, response.message.toString());
    }
  }

  // trainingListApi
  Future<void> myLivestockListApi(context, {bool isLoaderRequired = true}) async{
    if(isLoaderRequired) {
      emit(state.copyWith(status: LivestockStatus.submit));
    }
    var response = await apiRepository.getMyLivestockListApi();
    if (response.status == 200) {
      emit(state.copyWith(status: LivestockStatus.success, responseMyLivestockList: response));
    }
    else {
      emit(state.copyWith(status: LivestockStatus.error));
      showCustomToast(context, response.message.toString());
    }
  }

  // trainingListApi
  Future<void> livestockDetailApi(context, String id, {bool isLoaderRequired = true}) async{
    if(isLoaderRequired) {
      emit(state.copyWith(status: LivestockStatus.submit));
    }
    var response = await apiRepository.getLivestockDetailApi(id);
    if (response.status == 200) {
      emit(state.copyWith(status: LivestockStatus.success, responseLivestockDetail: response));
    }
    else {
      emit(state.copyWith(status: LivestockStatus.error));
      showCustomToast(context, response.message.toString());
    }
  }

  Future<void> livestockAddApi(context, String breedId, List<String> paths, String milk, String lactation, String price, String pregnant, String cowQty, String age, String description) async{
    var response = await apiRepository.addLivestockApi(breedId, paths, milk, lactation, price, pregnant, cowQty, age, description);
    if (response.status == 200) {
      showCustomToast(context, response.message.toString(), isSuccess: true);
      print('desc : ${response.data!.description}');
      ThankYouLivestock(response: response).navigate();
    }
    else {
      emit(state.copyWith(status: LivestockStatus.error));
      showCustomToast(context, response.message.toString());
    }
  }

  Future<void> livestockUpdateApi(context, String id, String breedId, List<String> paths, String milk, String lactation, String price, String pregnant, String cowQty, String age, String description) async{
    customDialog(widget: launchProgress());
    var response = await apiRepository.updateLivestockApi(id, breedId, paths, milk, lactation, price, pregnant, cowQty, age, description);
    if (response.status == 200) {
      showCustomToast(context, response.message.toString(), isSuccess: true);
      livestockDetailApi(context, id, isLoaderRequired: false);
      myLivestockListApi(context);
      disposeProgress();
      pressBack();
    }
    else {
      disposeProgress();
      emit(state.copyWith(status: LivestockStatus.error));
      showCustomToast(context, response.message.toString());
    }
  }

  Future<void> livestockDeleteMediaApi(context, String id, String livestockId) async{
    var response = await apiRepository.deleteMediaApi(id);
    if (response.status == 200) {
      showCustomToast(context, response.message.toString(), isSuccess: true);
      livestockDetailApi(context, livestockId);
      myLivestockListApi(context);
    }
    else {
      showCustomToast(context, response.message.toString());
    }
  }

  Future<void> livestockAddToCartApi(context, livestockId,int quantity,String price) async{
    var response = await apiRepository.addToCartLivestockApi(livestockId,quantity, price);
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
                              await emptyCartApi(context,livestockId,quantity,price);
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
        const LiveStockCartListScreen(navigates: 'live',).navigate(isInfinity: true);
      }
    }
    else {
      showCustomToast(context, response.message.toString());
    }
  }

  Future<void> livestockCartListApi(context, {bool isLoaderRequired = true}) async{
    if(isLoaderRequired) {
      emit(state.copyWith(status: LivestockStatus.submit));
    }
    var response = await apiRepository.getLivestockCartListApi();
    if (response.status == 200) {
      emit(state.copyWith(status: LivestockStatus.success, responseLivestockCartList: response));
    } else {
      emit(state.copyWith(status: LivestockStatus.error));
    }
  }


  Future<void> livestockCartItemRemoveApi(context, int id) async{
    customDialog(widget: launchProgress());
    var response = await apiRepository.livestockDeleteCartItemApi(id);
    if (response.status == 200) {
      disposeProgress();
      livestockCartListApi(context, isLoaderRequired: false);
    } else {
      disposeProgress();
      emit(state.copyWith(status: LivestockStatus.error));
    }
  }

  Future<void> livestockUpdateCartApi(context, int cartId, int cowQty) async{
    customDialog(widget: launchProgress());
    var response = await apiRepository.livestockUpdateCartApi(cartId, cowQty);
    if (response.status == 200) {
      disposeProgress();
      livestockCartListApi(context, isLoaderRequired: false);
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
      myLivestockListApi(context, isLoaderRequired: false);
    } else {
      disposeProgress();
      emit(state.copyWith(status: LivestockStatus.error));
    }
  }

  // livestockLoanApi
  Future<void> applyLivestockLoanApi(context, int id,String farmerParticipation,
      String remarks,String addressDocName, String addressDocNo, String addressDocExpiryDate,
      List<String> documentFiles,String idDocName,
      String idDocTypeNo, String idDocTypeExpiryDate, List<String> documentTypeFiles, String farmerPhoto,FarmerMaster farmerMaster) async{
    customDialog(widget: launchProgress());
    var response = await apiRepository.applyLivestockLoanApi(id, farmerParticipation, remarks);
    if (response.status == 200) {
      disposeProgress();
      BlocProvider.of<ProjectCubit>(context).
      liveStockKycApi(context, response.data!.farmerId.toString(), response.data!.id.toString(),
          addressDocName, addressDocNo,
          addressDocExpiryDate, documentFiles,
          idDocName, idDocTypeNo, idDocTypeExpiryDate,
          documentTypeFiles, farmerPhoto,farmerMaster);
    } else {
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
  Future<void> emptyCartApi(context,livestockId, int quantity, String price) async{
    customDialog(widget: launchProgress());
    var response = await apiRepository.emptyCartApi();
    if (response.status == 200) {
      await livestockAddToCartApi(context, livestockId, quantity, price);
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
      showCustomToast(context, response.message.toString());
    }
  }


  String getUserToken() {
    return apiRepository.getUserToken();}

}