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

  void showHide(i,MonthWiseData monthWise){
    emit(state.copyWith(id: int.parse(state.responseMonthlyWiseData![i].id.toString())));
  }


  void totalAll(int i,List<DateWiseData> responseDateWise){
    double sums = 0 ,totalMilk=0,totalProduction = 0,sumOfHerd = 0,newSum = 0;
    // print("${i.toString()} yyyyyy ${responseDateWise.length}" );
    // if(responseDateWise.length-1 >= i){
      for(int i=0;i<CowsAndYieldsDDEFarmerState.requestData.length;i++){
        sums = sums+double.parse(CowsAndYieldsDDEFarmerState.requestData[i].heardSize??"0".toString());
        totalMilk = totalMilk+double.parse(CowsAndYieldsDDEFarmerState.requestData[i].milkingCows.toString());
        sumOfHerd = double.parse(CowsAndYieldsDDEFarmerState.requestData[i].milkingCows.toString())+double.parse(CowsAndYieldsDDEFarmerState.requestData[i].dryCows.toString())+double.parse(CowsAndYieldsDDEFarmerState.requestData[i].heiferCows.toString())+double.parse(CowsAndYieldsDDEFarmerState.requestData[i].sevenToTwelveMonthCows.toString())+double.parse(CowsAndYieldsDDEFarmerState.requestData[i].sixMonthCow.toString())+double.parse(CowsAndYieldsDDEFarmerState.requestData[i].bullCalfs.toString());
        newSum = newSum+sumOfHerd;
      }

    state.herdSizeController[i] = TextEditingController(text: sumOfHerd.toString());
    emit(state.copyWith(totalHerdSize: newSum,totalMilkingCow: totalMilk,
        totalProduction: totalProduction));
    sums=0;
    newSum=0;
    totalMilk=0;
    totalProduction=0;
    sumOfHerd=0;
  }

  void totalHerdSize(int i){
    double sums = 0, sumOfHerd = 0,newSum = 0;
    state.herdSizeController.add(TextEditingController());
    state.herdSizeController[i].text = CowsAndYieldsDDEFarmerState.requestData[i].heardSize.toString() ?? "";
    state.herdSizeController[i].addListener(() {
      Future.delayed(const Duration(milliseconds: 20),(){
        for(int i=0;i<CowsAndYieldsDDEFarmerState.requestData.length;i++){
          if(state.herdSizeController[i].text.isNotEmpty){
            sums = sums+double.parse(CowsAndYieldsDDEFarmerState.requestData[i].heardSize.toString());
            sumOfHerd = double.parse(CowsAndYieldsDDEFarmerState.requestData[i].milkingCows.toString())+double.parse(CowsAndYieldsDDEFarmerState.requestData[i].dryCows.toString())+double.parse(CowsAndYieldsDDEFarmerState.requestData[i].heiferCows.toString())+double.parse(CowsAndYieldsDDEFarmerState.requestData[i].sevenToTwelveMonthCows.toString())+double.parse(CowsAndYieldsDDEFarmerState.requestData[i].sixMonthCow.toString())+double.parse(CowsAndYieldsDDEFarmerState.requestData[i].bullCalfs.toString());
            newSum = newSum+sumOfHerd;
          }
        }
        emit(state.copyWith(totalHerdSize: sums));
        sums = 0;
        sumOfHerd = 0;
        newSum = 0;
      }) ;

    });
  }

  void totalMilkingCow(int i){
      double sums = 0, totalHerd = 0;
      double sumNew = 0;
      state.milkingCowController.add(TextEditingController());
      state.milkingCowController[i].text =
          CowsAndYieldsDDEFarmerState.requestData[i].milkingCows.toString() ?? "";
      state.milkingCowController[i].addListener(() {
        Future.delayed(const Duration(milliseconds: 20), () {
          double totalHerd = 0;
          for (int i = 0; i < CowsAndYieldsDDEFarmerState.requestData.length; i++) {
            // print(object)
            if (state.milkingCowController[i].text.isNotEmpty) {
              sums = sums + double.parse(
                  CowsAndYieldsDDEFarmerState.requestData[i].milkingCows.toString());
              totalHerd = sums+int.parse(CowsAndYieldsDDEFarmerState.requestData[i].heardSize.toString());
            }
          }
          if (state.milkingCowController[i].text.isNotEmpty) {
            sumNew = double.parse(
                CowsAndYieldsDDEFarmerState.requestData[i].milkingCows
                    .toString()) + double.parse(
                CowsAndYieldsDDEFarmerState.requestData[i].dryCows.toString()) +
                double.parse(
                    CowsAndYieldsDDEFarmerState.requestData[i].heiferCows
                        .toString()) + double.parse(
                CowsAndYieldsDDEFarmerState.requestData[i]
                    .sevenToTwelveMonthCows.toString()) + double.parse(
                CowsAndYieldsDDEFarmerState.requestData[i].sixMonthCow
                    .toString()) + double.parse(
                CowsAndYieldsDDEFarmerState.requestData[i].bullCalfs
                    .toString());
          } else {
            sumNew = double.parse("0") + double.parse(
                CowsAndYieldsDDEFarmerState.requestData[i].dryCows.toString()) +
                double.parse(
                    CowsAndYieldsDDEFarmerState.requestData[i].heiferCows
                        .toString()) + double.parse(
                CowsAndYieldsDDEFarmerState.requestData[i]
                    .sevenToTwelveMonthCows.toString()) + double.parse(
                CowsAndYieldsDDEFarmerState.requestData[i].sixMonthCow
                    .toString()) + double.parse(
                CowsAndYieldsDDEFarmerState.requestData[i].bullCalfs
                    .toString());
          }
          state.herdSizeController[i] =
              TextEditingController(text: sumNew.toString());
          if (state.herdSizeController[i].text.isNotEmpty) {
            for (int i = 0; i <
                CowsAndYieldsDDEFarmerState.requestData.length; i++) {
              totalHerd = totalHerd +
                  double.parse(state.herdSizeController[i].text.isEmpty?"0":state.herdSizeController[i].text.toString());
            }
          }

          double divideByMilking = 0,
              totalYield = 0;
          divideByMilking = state.totalProduction / state.totalMilkingCow;
          print("days $divideByMilking");
          print(DateTime(DateTime
              .now()
              .year, DateTime
              .now()
              .month + 1, 0).day);
          double numberOfDays = double.parse(DateTime(DateTime
              .now()
              .year, DateTime
              .now()
              .month + 1, 0).day.toString());
          double divideByDays = divideByMilking / numberOfDays;
          // emit(state.copyWith(yieldPerDay: divideByDays));
          print(totalYield / state.totalMilkingCow);
          print(divideByDays);
          totalYield = 0;

          emit(state.copyWith(totalMilkingCow: sums,
              sumOfHerd: sumNew,
              totalHerdSize: totalHerd,
              yieldPerDay: divideByDays));
          sums = 0;
          totalHerd = 0;
        });
      });
  }

  void totalSumOfHerdSize(int index,int i) {
    double sums = 0;
    List<double> sumIndexWise = [];
    state.yieldPerDayController.add(TextEditingController());
    state.dryController.add(TextEditingController());
    state.heiferController.add(TextEditingController());
    state.sevenTwelveMonthController.add(TextEditingController());
    state.lessthanSixMonthController.add(TextEditingController());
    state.bullCalfController.add(TextEditingController());
    state.yieldPerDayController[index].text = CowsAndYieldsDDEFarmerState.requestData[index].yieldPerCow.toString() ?? "";
    state.dryController[index].text = CowsAndYieldsDDEFarmerState.requestData[index].dryCows.toString() ?? "";
    state.heiferController[index].text = CowsAndYieldsDDEFarmerState.requestData[index].heiferCows.toString() ?? "";
    state.sevenTwelveMonthController[index].text = CowsAndYieldsDDEFarmerState.requestData[index].sevenToTwelveMonthCows.toString() ?? "";
    state.lessthanSixMonthController[index].text = CowsAndYieldsDDEFarmerState.requestData[index].sixMonthCow.toString() ?? "";
    state.bullCalfController[index].text = CowsAndYieldsDDEFarmerState.requestData[index].bullCalfs.toString() ?? "";

    state.yieldPerDayController[index].addListener(() {
      Future.delayed(const Duration(milliseconds: 20),(){

        double totalYield = 0;
          for(int i=0;i<CowsAndYieldsDDEFarmerState.requestData.length;i++){
            if(state.yieldPerDayController[i].text.isNotEmpty){
              totalYield = totalYield+double.parse(CowsAndYieldsDDEFarmerState.requestData[i].yieldPerCow.toString());
              // totalHerd = sums+double.parse(CowsAndYieldsDDEFarmerState.requestData[i].heardSize.toString());
            }
        }
          double divideByMilking = 0;
          divideByMilking = state.totalProduction/state.totalMilkingCow;
          print("days $divideByMilking");
          print(DateTime(DateTime.now().year, DateTime.now().month + 1, 0).day);
          double numberOfDays = double.parse(DateTime(DateTime.now().year, DateTime.now().month + 1, 0).day.toString());
          double divideByDays = divideByMilking/numberOfDays;
          emit(state.copyWith(yieldPerDay: divideByDays));
          print(totalYield/state.totalMilkingCow);
          print(divideByDays);
          totalYield = 0 ;

      }) ;
    });


    state.dryController[index].addListener(() {
      Future.delayed(const Duration(milliseconds: 20),(){
        double sumOfHerd = 0,totalHerd = 0;
        if(state.dryController[i].text.isNotEmpty){
          sumOfHerd = double.parse(CowsAndYieldsDDEFarmerState.requestData[i].milkingCows.toString())+double.parse(CowsAndYieldsDDEFarmerState.requestData[i].dryCows.toString())+double.parse(CowsAndYieldsDDEFarmerState.requestData[i].heiferCows.toString())+double.parse(CowsAndYieldsDDEFarmerState.requestData[i].sevenToTwelveMonthCows.toString())+double.parse(CowsAndYieldsDDEFarmerState.requestData[i].sixMonthCow.toString())+double.parse(CowsAndYieldsDDEFarmerState.requestData[i].bullCalfs.toString());
        }else{
          sumOfHerd = double.parse(CowsAndYieldsDDEFarmerState.requestData[i].milkingCows.toString())+double.parse("0")+double.parse(CowsAndYieldsDDEFarmerState.requestData[i].heiferCows.toString())+double.parse(CowsAndYieldsDDEFarmerState.requestData[i].sevenToTwelveMonthCows.toString())+double.parse(CowsAndYieldsDDEFarmerState.requestData[i].sixMonthCow.toString())+double.parse(CowsAndYieldsDDEFarmerState.requestData[i].bullCalfs.toString());
        }
        state.herdSizeController[index] = TextEditingController(text: sumOfHerd.toString());
        if(state.herdSizeController[i].text.isNotEmpty){
          for(int i =0 ;i <CowsAndYieldsDDEFarmerState.requestData.length;i++){
            totalHerd = totalHerd+double.parse(state.herdSizeController[i].text.isEmpty?"0":state.herdSizeController[i].text);
          }
        }
        emit(state.copyWith(sumOfHerd: sumOfHerd,totalHerdSize: totalHerd));
        sums = 0;
      }) ;
    });

    state.heiferController[index].addListener(() {
      Future.delayed(const Duration(milliseconds: 20),(){
        double sumOfHerd = 0,totalHerd = 0 ;
        if(state.heiferController[i].text.isNotEmpty){
          sumOfHerd = double.parse(CowsAndYieldsDDEFarmerState.requestData[i].milkingCows.toString())+double.parse(CowsAndYieldsDDEFarmerState.requestData[i].dryCows.toString())+double.parse(CowsAndYieldsDDEFarmerState.requestData[i].heiferCows.toString())+double.parse(CowsAndYieldsDDEFarmerState.requestData[i].sevenToTwelveMonthCows.toString())+double.parse(CowsAndYieldsDDEFarmerState.requestData[i].sixMonthCow.toString())+double.parse(CowsAndYieldsDDEFarmerState.requestData[i].bullCalfs.toString());
        }else{
          sumOfHerd = double.parse(CowsAndYieldsDDEFarmerState.requestData[i].milkingCows.toString())+double.parse(CowsAndYieldsDDEFarmerState.requestData[i].dryCows.toString())+double.parse("0")+double.parse(CowsAndYieldsDDEFarmerState.requestData[i].sevenToTwelveMonthCows.toString())+double.parse(CowsAndYieldsDDEFarmerState.requestData[i].sixMonthCow.toString())+double.parse(CowsAndYieldsDDEFarmerState.requestData[i].bullCalfs.toString());
        }
        state.herdSizeController[index] = TextEditingController(text: sumOfHerd.toString());
        if(state.herdSizeController[i].text.isNotEmpty){
        for(int i =0 ;i <CowsAndYieldsDDEFarmerState.requestData.length;i++){

          totalHerd = totalHerd+double.parse(state.herdSizeController[i].text.isEmpty?"0":state.herdSizeController[i].text);
        }}
        emit(state.copyWith(sumOfHerd: sumOfHerd,totalHerdSize: totalHerd));
        sums = 0;
      }) ;
    });

    state.sevenTwelveMonthController[index].addListener(() {
      Future.delayed(const Duration(milliseconds: 20),(){
        double sumOfHerd = 0,totalHerd = 0;
        if(state.sevenTwelveMonthController[i].text.isNotEmpty){
          sumOfHerd = double.parse(CowsAndYieldsDDEFarmerState.requestData[i].milkingCows.toString())+double.parse(CowsAndYieldsDDEFarmerState.requestData[i].dryCows.toString())+double.parse(CowsAndYieldsDDEFarmerState.requestData[i].heiferCows.toString())+double.parse(CowsAndYieldsDDEFarmerState.requestData[i].sevenToTwelveMonthCows.toString())+double.parse(CowsAndYieldsDDEFarmerState.requestData[i].sixMonthCow.toString())+double.parse(CowsAndYieldsDDEFarmerState.requestData[i].bullCalfs.toString());
        }else{
          sumOfHerd = double.parse(CowsAndYieldsDDEFarmerState.requestData[i].milkingCows.toString())+double.parse(CowsAndYieldsDDEFarmerState.requestData[i].dryCows.toString())+double.parse(CowsAndYieldsDDEFarmerState.requestData[i].heiferCows.toString())+double.parse("0")+double.parse(CowsAndYieldsDDEFarmerState.requestData[i].sixMonthCow.toString())+double.parse(CowsAndYieldsDDEFarmerState.requestData[i].bullCalfs.toString());
        }
        state.herdSizeController[index] = TextEditingController(text: sumOfHerd.toString());
        if(state.herdSizeController[i].text.isNotEmpty){
        for(int i =0 ;i <CowsAndYieldsDDEFarmerState.requestData.length;i++){
          totalHerd = totalHerd+double.parse(state.herdSizeController[i].text.isEmpty?"0":state.herdSizeController[i].text);
        }}
        emit(state.copyWith(sumOfHerd: sumOfHerd,totalHerdSize: totalHerd));
        sums = 0;
      }) ;
    });

    state.lessthanSixMonthController[index].addListener(() {
      Future.delayed(const Duration(milliseconds: 20),(){
        double sumOfHerd = 0,totalHerd = 0;
        if(state.lessthanSixMonthController[i].text.isNotEmpty){
          sumOfHerd = double.parse(CowsAndYieldsDDEFarmerState.requestData[i].milkingCows.toString())+double.parse(CowsAndYieldsDDEFarmerState.requestData[i].dryCows.toString())+double.parse(CowsAndYieldsDDEFarmerState.requestData[i].heiferCows.toString())+double.parse(CowsAndYieldsDDEFarmerState.requestData[i].sevenToTwelveMonthCows.toString())+double.parse(CowsAndYieldsDDEFarmerState.requestData[i].sixMonthCow.toString())+double.parse(CowsAndYieldsDDEFarmerState.requestData[i].bullCalfs.toString());
        }else{
          sumOfHerd = double.parse(CowsAndYieldsDDEFarmerState.requestData[i].milkingCows.toString())+double.parse(CowsAndYieldsDDEFarmerState.requestData[i].dryCows.toString())+double.parse(CowsAndYieldsDDEFarmerState.requestData[i].heiferCows.toString())+double.parse(CowsAndYieldsDDEFarmerState.requestData[i].sevenToTwelveMonthCows.toString())+double.parse("0")+double.parse(CowsAndYieldsDDEFarmerState.requestData[i].bullCalfs.toString());
        }
        state.herdSizeController[index] = TextEditingController(text: sumOfHerd.toString());
        if(state.herdSizeController.isNotEmpty){
        for(int i =0 ;i <CowsAndYieldsDDEFarmerState.requestData.length;i++){
          totalHerd = totalHerd+double.parse(state.herdSizeController[i].text.isEmpty?"0":state.herdSizeController[i].text);
        }}
        emit(state.copyWith(sumOfHerd: sumOfHerd,totalHerdSize: totalHerd));
        sums = 0;
        totalHerd  = 0;
      }) ;
    });

    state.bullCalfController[index].addListener(() {
      Future.delayed(const Duration(milliseconds: 20),(){
        double sumOfHerd = 0,totalHerd = 0;
        if(state.bullCalfController[i].text.isNotEmpty){
          sumOfHerd = double.parse(CowsAndYieldsDDEFarmerState.requestData[i].milkingCows.toString())+double.parse(CowsAndYieldsDDEFarmerState.requestData[i].dryCows.toString())+double.parse(CowsAndYieldsDDEFarmerState.requestData[i].heiferCows.toString())+double.parse(CowsAndYieldsDDEFarmerState.requestData[i].sevenToTwelveMonthCows.toString())+double.parse(CowsAndYieldsDDEFarmerState.requestData[i].sixMonthCow.toString())+double.parse(CowsAndYieldsDDEFarmerState.requestData[i].bullCalfs.toString());
        }else{
          sumOfHerd = double.parse(CowsAndYieldsDDEFarmerState.requestData[i].milkingCows.toString())+double.parse(CowsAndYieldsDDEFarmerState.requestData[i].dryCows.toString())+double.parse(CowsAndYieldsDDEFarmerState.requestData[i].heiferCows.toString())+double.parse(CowsAndYieldsDDEFarmerState.requestData[i].sevenToTwelveMonthCows.toString())+double.parse(CowsAndYieldsDDEFarmerState.requestData[i].sixMonthCow.toString())+double.parse("0");
        }
        state.herdSizeController[index] = TextEditingController(text: sumOfHerd.toString());
        if(state.herdSizeController.isNotEmpty){
        for(int i =0 ;i <CowsAndYieldsDDEFarmerState.requestData.length;i++){
          totalHerd = totalHerd+double.parse(state.herdSizeController[i].text.isEmpty?"0":state.herdSizeController[i].text);
        }}
        emit(state.copyWith(sumOfHerd: sumOfHerd,totalHerdSize: totalHerd));
        sums = 0;
        totalHerd = 0;
      }) ;
    });

  }

  void totalFirstProduction(double totalProduction,int index) {

    double sums = 0;

    state.suppliedToPdfController.addListener(() {
      Future.delayed(const Duration(milliseconds: 20),(){
        if(state.suppliedToPdfController.text.isNotEmpty){
          sums = double.parse(state.suppliedToPdfController.text.isNotEmpty?state.suppliedToPdfController.text.toString():"0")+double.parse(state.suppliedToOtherPdfController.text.isNotEmpty?state.suppliedToOtherPdfController.text.toString():"0")+double.parse(state.selfUseController.text.isNotEmpty?state.selfUseController.text.toString():"0");
          double divideByMilking = 0,totalYield =0;
          divideByMilking = state.totalProduction/state.totalMilkingCow;
          double numberOfDays = double.parse(DateTime(DateTime.now().year, DateTime.now().month + 1, 0).day.toString());
          double divideByDays = divideByMilking/numberOfDays;
          totalYield = 0 ;
          emit(state.copyWith(totalProduction: sums,yieldPerDay: divideByDays));
        }
      }) ;
    });

    state.suppliedToOtherPdfController.addListener(() {
      if(state.suppliedToOtherPdfController.text.isNotEmpty){
      sums = double.parse(state.suppliedToPdfController.text.isNotEmpty?state.suppliedToPdfController.text.toString():"0")+double.parse(state.suppliedToOtherPdfController.text.isNotEmpty?state.suppliedToOtherPdfController.text.toString():"0")+double.parse(state.selfUseController.text.isNotEmpty?state.selfUseController.text.toString():"0");
      double divideByMilking = 0,totalYield =0;
      divideByMilking = state.totalProduction/state.totalMilkingCow;
      debugPrint(DateTime(DateTime.now().year, DateTime.now().month + 1, 0).day.toString());
      double numberOfDays = double.parse(DateTime(DateTime.now().year, DateTime.now().month + 1, 0).day.toString());
      double divideByDays = divideByMilking/numberOfDays;
      totalYield = 0 ;
      emit(state.copyWith(totalProduction: sums,yieldPerDay: divideByDays));
      }
    });

    state.selfUseController.addListener(() {
      if(state.selfUseController.text.isNotEmpty){
      sums = double.parse(state.suppliedToPdfController.text.isNotEmpty?state.suppliedToPdfController.text.toString():"0")+double.parse(state.suppliedToOtherPdfController.text.isNotEmpty?state.suppliedToOtherPdfController.text.toString():"0")+double.parse(state.selfUseController.text.isNotEmpty?state.selfUseController.text.toString():"0");
      double divideByMilking = 0,totalYield =0;
      divideByMilking = state.totalProduction/state.totalMilkingCow;
      double numberOfDays = double.parse(DateTime(DateTime.now().year, DateTime.now().month + 1, 0).day.toString());
      double divideByDays = divideByMilking/numberOfDays;
      totalYield = 0 ;
      emit(state.copyWith(totalProduction: sums,yieldPerDay: divideByDays));}
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

  void getFarmer(context, String ragRatingType) async{
    // customDialog(widget: launchProgress());
    emit(state.copyWith(status: DdeFarmerStatus.loading));
    var response = await apiRepository.getFarmersList(ragRatingType);
    if(response.status == 200){
      // disposeProgress();
      emit(state.copyWith(status: DdeFarmerStatus.success, response: response.data, selectedRagRatingType: ragRatingType));
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
      print(response.data!.monthWiseData!.length);
      emit(state.copyWith(status: DdeFarmerStatus.success, responseMonthlyWiseData: response.data!.monthWiseData!));

      /*for(int i =0 ;i<response.data!.monthWiseData!.length;i++){
        for(int j=0 ;j<response.data!.monthWiseData![i].dateWiseData!.length;j++){
          totalMilkingCow(j);
          totalSumOfHerdSize(j,j);
          totalHerdSize(j);
          totalAll(j,addBreedLength);
        }
      }*/

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