import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:glad/data/model/response_breed.dart';
import 'package:glad/data/model/response_cow_breed_details.dart';
import 'package:glad/data/repository/dde_repo.dart';
import 'package:glad/screen/custom_widget/custom_methods.dart';
import 'package:glad/screen/extra_screen/profile_navigate.dart';
import 'package:glad/utils/extension.dart';
import 'package:glad/utils/helper.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../data/model/farmers_list.dart';
part 'dde_farmer_state.dart';

class DdeFarmerCubit extends Cubit<DdeState>{

  final SharedPreferences sharedPreferences;
  final DdeRepository apiRepository;

  DdeFarmerCubit({required this.apiRepository,required this.sharedPreferences}):super(DdeState.initial());

  void changeBreed(String breedName, String breedId) {
    emit(state.copyWith(breedController: TextEditingController(text: breedName), breedId: breedId));
  }

  void changeSearchBreedController(TextEditingController addressController) {
    emit(state.copyWith(breedSearchController: addressController));
  }

  void breedController(String addressController) {
    emit(state.copyWith(breedController: TextEditingController(text: addressController)));
  }

  void showHide(int i){
      emit(state.copyWith(showQties: []));
  }

  void totalMilkingCow(int i){
    double sums = 0 ;
    state.milkingCowController.add(TextEditingController());
    state.milkingCowController[i].text = CowsAndYieldsDDEFarmerState.requestData[i].milkingCows.toString() ?? "";
    state.milkingCowController[i].addListener(() {
      Future.delayed(const Duration(milliseconds: 20),(){
        // for (var data in CowsAndYieldsDDEFarmerState.requestData){
        for(int i=0;i<CowsAndYieldsDDEFarmerState.requestData.length;i++){
          if(state.milkingCowController[i].text.isNotEmpty){
            sums = sums+double.parse(CowsAndYieldsDDEFarmerState.requestData[i].milkingCows.toString());
            print(CowsAndYieldsDDEFarmerState.requestData[i].milkingCows);
          }

        }
        print(sums);
        emit(state.copyWith(totalProduction: sums));
        sums = 0;
      }) ;
    });
  }

  void totalFirstProduction(double totalProduction,int index) {

    state.suppliedToPdfController.addListener(() {
      print(state.suppliedToPdfController.text);
      if(state.suppliedToPdfController.text.isNotEmpty){
      CowsAndYieldsDDEFarmerState.modelTotalProduction[index].suppliedToPdfl = state.suppliedToPdfController.text;
      CowsAndYieldsDDEFarmerState.modelTotalProduction[index].totalMilkProduction = double.parse(CowsAndYieldsDDEFarmerState.modelTotalProduction[index].suppliedToOther ?? "0")+double.parse(CowsAndYieldsDDEFarmerState.modelTotalProduction[index].suppliedToPdfl??"0")+double.parse(CowsAndYieldsDDEFarmerState.modelTotalProduction[index].selfUseController);
      emit(state.copyWith(totalProduction: CowsAndYieldsDDEFarmerState.modelTotalProduction[index].totalMilkProduction));
      }else{
        CowsAndYieldsDDEFarmerState.modelTotalProduction[index].suppliedToPdfl = state.suppliedToPdfController.text;
        CowsAndYieldsDDEFarmerState.modelTotalProduction[index].totalMilkProduction = double.parse(CowsAndYieldsDDEFarmerState.modelTotalProduction[index].suppliedToOther ?? "0")+double.parse("0")+double.parse(CowsAndYieldsDDEFarmerState.modelTotalProduction[index].selfUseController);
        emit(state.copyWith(totalProduction: CowsAndYieldsDDEFarmerState.modelTotalProduction[index].totalMilkProduction));
      }
    });

    state.suppliedToOtherPdfController.addListener(() {

      if(state.suppliedToOtherPdfController.text.isNotEmpty){
        CowsAndYieldsDDEFarmerState.modelTotalProduction[index].suppliedToOther = state.suppliedToOtherPdfController.text;
        CowsAndYieldsDDEFarmerState.modelTotalProduction[index].totalMilkProduction = double.parse(CowsAndYieldsDDEFarmerState.modelTotalProduction[index].suppliedToOther)+double.parse(CowsAndYieldsDDEFarmerState.modelTotalProduction[index].suppliedToPdfl)+double.parse(CowsAndYieldsDDEFarmerState.modelTotalProduction[index].selfUseController);
        emit(state.copyWith(totalProduction: CowsAndYieldsDDEFarmerState.modelTotalProduction[index].totalMilkProduction));}
    });

    state.selfUseController.addListener(() {

      if(state.selfUseController.text.isNotEmpty){
        CowsAndYieldsDDEFarmerState.modelTotalProduction[index].selfUseController = state.selfUseController.text;
        CowsAndYieldsDDEFarmerState.modelTotalProduction[index].totalMilkProduction = double.parse(CowsAndYieldsDDEFarmerState.modelTotalProduction[index].suppliedToOther)+double.parse(CowsAndYieldsDDEFarmerState.modelTotalProduction[index].suppliedToPdfl)+double.parse(CowsAndYieldsDDEFarmerState.modelTotalProduction[index].selfUseController);
        emit(state.copyWith(totalProduction: CowsAndYieldsDDEFarmerState.modelTotalProduction[index].totalMilkProduction));}
    });
  }

  void searchBreedFilter(String query, List<DataBreed> searchList) {
    List<DataBreed> dummySearchList = <DataBreed>[];
    dummySearchList.addAll(searchList);
    if (query.isNotEmpty) {
      List<DataBreed> dummyListData = <DataBreed>[];
      for (var item in dummySearchList) {
        if (item.name!.toLowerCase().contains(query.toLowerCase())) {
          dummyListData.add(item);
        }
      }
      // emit(state.copyWith(listLoginCountryData:dummyListData ));
      emit(state.copyWith(searchBreedList: dummyListData));
      return;
    } else {
      emit(state.copyWith(searchBreedList: dummySearchList));
    }
  }

  void getFarmer(context) async{
    customDialog(widget: launchProgress());
    emit(state.copyWith(status: DdeFarmerStatus.loading));
    var response = await apiRepository.getFarmersList();
    if(response.status == 200){
      disposeProgress();
      emit(state.copyWith(status: DdeFarmerStatus.success, response: response.data));
    }
    else{
      emit(state.copyWith(status: DdeFarmerStatus.error));
      showCustomToast(context, response.message.toString());
    }
    emit(state.copyWith(status: DdeFarmerStatus.success));
  }

  // getCowBreedDetailsApi
  void getCowBreedDetailsApi(context) async{
    customDialog(widget: launchProgress());
    emit(state.copyWith(status: DdeFarmerStatus.loading));
    var response = await apiRepository.cowBreedDetailsApi();
    if(response.status == 200){
      disposeProgress();
      emit(state.copyWith(status: DdeFarmerStatus.success, responseMonthlyWiseData: response.data!.monthWiseData!));
    }
    else{
      emit(state.copyWith(status: DdeFarmerStatus.error));
      showCustomToast(context, response.message.toString());
    }
    emit(state.copyWith(status: DdeFarmerStatus.success));
  }

  // updateCowBreedRecordApi
  void updateCowBreedRecordApi(context,String requestData) async{
    customDialog(widget: launchProgress());
    emit(state.copyWith(status: DdeFarmerStatus.loading));
    var response = await apiRepository.updateCowBreedRecordApi(requestData);
    if(response.status == 200){
      disposeProgress();
      showCustomToast(context, response.message.toString());
      getCowBreedDetailsApi(context);
      emit(state.copyWith(status: DdeFarmerStatus.success));
    }
    else{
      emit(state.copyWith(status: DdeFarmerStatus.error));
      showCustomToast(context, response.message.toString());
    }
    emit(state.copyWith(status: DdeFarmerStatus.success));
  }

  // updateCowBreedRecordApi
  void addMonthApi(context,String farmerId) async{
    customDialog(widget: launchProgress());
    emit(state.copyWith(status: DdeFarmerStatus.loading));
    var response = await apiRepository.addMonthApi(farmerId.toString());
    if(response.status == 200){
      disposeProgress();
      showCustomToast(context, response.message.toString());
      getCowBreedDetailsApi(context);
      emit(state.copyWith(status: DdeFarmerStatus.success));
    }
    else{
      emit(state.copyWith(status: DdeFarmerStatus.error));
      showCustomToast(context, response.message.toString());
    }
    emit(state.copyWith(status: DdeFarmerStatus.success));
  }

  // updateCowBreedRecordApi
  void deleteMonthId(context,String monthName,String farmerId) async{
    customDialog(widget: launchProgress());
    emit(state.copyWith(status: DdeFarmerStatus.loading));
    var response = await apiRepository.deleteMonthApi(monthName,farmerId);
    if(response.status == 200){
      disposeProgress();
      showCustomToast(context, response.message.toString());
      getCowBreedDetailsApi(context);
      emit(state.copyWith(status: DdeFarmerStatus.success));
    }
    else{
      emit(state.copyWith(status: DdeFarmerStatus.error));
      showCustomToast(context, response.message.toString());
    }
    emit(state.copyWith(status: DdeFarmerStatus.success));
  }

  // getBreed
  void getBreedListApi(context) async {
    emit(state.copyWith(status: DdeFarmerStatus.loading));
    var response = await apiRepository.getBreedApi();
    if (response.status == 200) {
      emit(state.copyWith(
        status: DdeFarmerStatus.success,
        breedResponse: response.data,
      ));
    } else {
      emit(state.copyWith(status: DdeFarmerStatus.error));
      showCustomToast(context, response.message.toString());
    }
  }


}