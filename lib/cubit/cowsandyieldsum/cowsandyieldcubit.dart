import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:glad/data/model/response_breed.dart';
import 'package:glad/data/model/response_cow_breed_details.dart';
import 'package:glad/data/repository/dde_repo.dart';
import 'package:glad/screen/custom_widget/custom_methods.dart';
import 'package:glad/screen/extra_screen/cowsandyieldsum.dart';
import 'package:glad/screen/extra_screen/profile_navigate.dart';
import 'package:glad/utils/extension.dart';
import 'package:glad/utils/helper.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../data/model/farmers_list.dart';

part 'cowsandcubitstate.dart';

class CowsAndYieldCubit extends Cubit<CowsAndCubitState>{

  final SharedPreferences sharedPreferences;
  final DdeRepository apiRepository;

  CowsAndYieldCubit({required this.apiRepository,required this.sharedPreferences}):super(CowsAndCubitState.initial());


  void showMonth(int i,MonthWiseData monthWise){
    print("CowBreeDetail $i lengthClick ${CowsAndYieldsSumState.requestData.length}");
    emit(state.copyWith(monthId: int.parse(state.responseMonthlyWiseData![i].id.toString())));
  }


  void allController(String milk){
    state.milkingCowController.add(TextEditingController());
    state.herdSizeController.add(TextEditingController());
    state.yieldPerDayController.add(TextEditingController());
    state.dryController.add(TextEditingController());
    state.heiferController.add(TextEditingController());
    state.sevenTwelveMonthController.add(TextEditingController());
    state.lessthanSixMonthController.add(TextEditingController());
    state.bullCalfController.add(TextEditingController());
  }

  void totalFirstProduction(double totalProduction,int index) {

    double sums = 0;

    state.suppliedToPdfController.addListener(() {
      Future.delayed(const Duration(milliseconds: 20),(){
          sums = double.parse(state.suppliedToPdfController.text.isNotEmpty?state.suppliedToPdfController.text.toString():"0")+double.parse(state.suppliedToOtherPdfController.text.isNotEmpty?state.suppliedToOtherPdfController.text.toString():"0")+double.parse(state.selfUseController.text.isNotEmpty?state.selfUseController.text.toString():"0");
          double divideByMilking = 0,totalYield =0;
          divideByMilking = state.totalProduction/state.totalMilkingCow;
          double numberOfDays = double.parse(DateTime(DateTime.now().year, DateTime.now().month + 1, 0).day.toString());
          double divideByDays = divideByMilking/numberOfDays;
          totalYield = 0 ;
          emit(state.copyWith(totalProduction: sums,yieldPerDay: divideByDays));
      }) ;
    });

    state.suppliedToOtherPdfController.addListener(() {

        sums = double.parse(state.suppliedToPdfController.text.isNotEmpty?state.suppliedToPdfController.text.toString():"0")+double.parse(state.suppliedToOtherPdfController.text.isNotEmpty?state.suppliedToOtherPdfController.text.toString():"0")+double.parse(state.selfUseController.text.isNotEmpty?state.selfUseController.text.toString():"0");
        double divideByMilking = 0,totalYield =0;
        divideByMilking = state.totalProduction/state.totalMilkingCow;
        debugPrint(DateTime(DateTime.now().year, DateTime.now().month + 1, 0).day.toString());
        double numberOfDays = double.parse(DateTime(DateTime.now().year, DateTime.now().month + 1, 0).day.toString());
        double divideByDays = divideByMilking/numberOfDays;
        totalYield = 0 ;
        emit(state.copyWith(totalProduction: sums,yieldPerDay: divideByDays));
      // }
    });

    state.selfUseController.addListener(() {
        sums = double.parse(state.suppliedToPdfController.text.isNotEmpty?state.suppliedToPdfController.text.toString():"0")+double.parse(state.suppliedToOtherPdfController.text.isNotEmpty?state.suppliedToOtherPdfController.text.toString():"0")+double.parse(state.selfUseController.text.isNotEmpty?state.selfUseController.text.toString():"0");
        double divideByMilking = 0,totalYield =0;
        divideByMilking = state.totalProduction/state.totalMilkingCow;
        double numberOfDays = double.parse(DateTime(DateTime.now().year, DateTime.now().month + 1, 0).day.toString());
        double divideByDays = divideByMilking/numberOfDays;
        totalYield = 0 ;
        emit(state.copyWith(totalProduction: sums,yieldPerDay: divideByDays));
    });
  }

  void getDataController(int childIndex,List<DateWiseData> responseDateWise){
    state.milkingCowController[childIndex].text = responseDateWise[childIndex].milkingCows.toString();
    state.herdSizeController[childIndex].text = responseDateWise[childIndex].heardSize.toString();
    state.yieldPerDayController[childIndex].text = responseDateWise[childIndex].yieldPerCow.toString();
    state.dryController[childIndex].text = responseDateWise[childIndex].dryCows.toString();
    state.heiferController[childIndex].text = responseDateWise[childIndex].heiferCows.toString();
    state.sevenTwelveMonthController[childIndex].text = responseDateWise[childIndex].sevenToTwelveMonthCows.toString();
    state.lessthanSixMonthController[childIndex].text = responseDateWise[childIndex].sixMonthCow.toString();
    state.bullCalfController[childIndex].text = "0";
  }

  void totalMilkingCow(int index){
    print("Total Milking Cow ${CowsAndYieldsSumState.requestData.length}");
    int sums = 0,sumOfHerd = 0,totalHerdSize = 0,addTotalHerd;
    state.milkingCowController[index].addListener(() {
      Future.delayed(const Duration(milliseconds: 20),(){
        print("TotalCount ${CowsAndYieldsSumState.requestData.length}");
        for (int i = 0; i < CowsAndYieldsSumState.requestData.length; i++) {
            sums = sums + int.parse(CowsAndYieldsSumState.requestData[i].milkingCows.toString().isEmpty?"0":CowsAndYieldsSumState.requestData[i].milkingCows.toString());
            addTotalHerd = int.parse(CowsAndYieldsSumState.requestData[i].milkingCows.toString().isEmpty?"0":CowsAndYieldsSumState.requestData[i].milkingCows.toString())+
                int.parse(CowsAndYieldsSumState.requestData[i].dryCows.toString().isEmpty?"0":CowsAndYieldsSumState.requestData[i].dryCows.toString())+
                int.parse(CowsAndYieldsSumState.requestData[i].heiferCows.toString().isEmpty?"0":CowsAndYieldsSumState.requestData[i].heiferCows.toString())+
                int.parse(CowsAndYieldsSumState.requestData[i].sevenToTwelveMonthCows.toString().isEmpty?"0":CowsAndYieldsSumState.requestData[i].sevenToTwelveMonthCows.toString())+
                int.parse(CowsAndYieldsSumState.requestData[i].sixMonthCow.toString().isEmpty?"0":CowsAndYieldsSumState.requestData[i].sixMonthCow.toString())+
                int.parse("0");
            totalHerdSize = totalHerdSize+addTotalHerd;
        }

        sumOfHerd = int.parse(CowsAndYieldsSumState.requestData[index].milkingCows.toString().isEmpty?"0":CowsAndYieldsSumState.requestData[index].milkingCows.toString())+
            int.parse(CowsAndYieldsSumState.requestData[index].dryCows.toString().isEmpty?"0":CowsAndYieldsSumState.requestData[index].dryCows.toString())+
            int.parse(CowsAndYieldsSumState.requestData[index].heiferCows.toString().isEmpty?"0":CowsAndYieldsSumState.requestData[index].heiferCows.toString())+
            int.parse(CowsAndYieldsSumState.requestData[index].sevenToTwelveMonthCows.toString().isEmpty?"0":CowsAndYieldsSumState.requestData[index].sevenToTwelveMonthCows.toString())+
            int.parse(CowsAndYieldsSumState.requestData[index].sixMonthCow.toString().isEmpty?"0":CowsAndYieldsSumState.requestData[index].sixMonthCow.toString())+
            int.parse("0");

        state.herdSizeController[index] = TextEditingController(text: sumOfHerd.toString());

        emit(state.copyWith(totalMilkingCow: sums,totalHerdSize: totalHerdSize));
        sums = 0;
        totalHerdSize = 0;
        sumOfHerd = 0;

      });
    }) ;
  }

  void sumAllBreed(int index){
    int sumOfHerd = 0,totalHerdSize = 0,addTotalHerd;
    state.dryController[index].addListener(() {
      Future.delayed(const Duration(milliseconds: 20),(){

        for (int i = 0; i < CowsAndYieldsSumState.requestData.length; i++) {
          addTotalHerd = int.parse(CowsAndYieldsSumState.requestData[i].milkingCows.toString().isEmpty?"0":CowsAndYieldsSumState.requestData[i].milkingCows.toString())+
              int.parse(CowsAndYieldsSumState.requestData[i].dryCows.toString().isEmpty?"0":CowsAndYieldsSumState.requestData[i].dryCows.toString())+
              int.parse(CowsAndYieldsSumState.requestData[i].heiferCows.toString().isEmpty?"0":CowsAndYieldsSumState.requestData[i].heiferCows.toString())+
              int.parse(CowsAndYieldsSumState.requestData[i].sevenToTwelveMonthCows.toString().isEmpty?"0":CowsAndYieldsSumState.requestData[i].sevenToTwelveMonthCows.toString())+
              int.parse(CowsAndYieldsSumState.requestData[i].sixMonthCow.toString().isEmpty?"0":CowsAndYieldsSumState.requestData[i].sixMonthCow.toString())+
              int.parse("0");
          totalHerdSize = totalHerdSize+addTotalHerd;
        }

        sumOfHerd = int.parse(CowsAndYieldsSumState.requestData[index].milkingCows.toString().isEmpty?"0":CowsAndYieldsSumState.requestData[index].milkingCows.toString())+
            int.parse(CowsAndYieldsSumState.requestData[index].dryCows.toString().isEmpty?"0":CowsAndYieldsSumState.requestData[index].dryCows.toString())+
            int.parse(CowsAndYieldsSumState.requestData[index].heiferCows.toString().isEmpty?"0":CowsAndYieldsSumState.requestData[index].heiferCows.toString())+
            int.parse(CowsAndYieldsSumState.requestData[index].sevenToTwelveMonthCows.toString().isEmpty?"0":CowsAndYieldsSumState.requestData[index].sevenToTwelveMonthCows.toString())+
            int.parse(CowsAndYieldsSumState.requestData[index].sixMonthCow.toString().isEmpty?"0":CowsAndYieldsSumState.requestData[index].sixMonthCow.toString())+
            int.parse("0");

        state.herdSizeController[index] = TextEditingController(text: sumOfHerd.toString());

        emit(state.copyWith(totalHerdSize: totalHerdSize));
        totalHerdSize = 0;
        sumOfHerd = 0;

      });
    }) ;

    state.heiferController[index].addListener(() {
      Future.delayed(const Duration(milliseconds: 20),(){

        for (int i = 0; i < CowsAndYieldsSumState.requestData.length; i++) {
          addTotalHerd = int.parse(CowsAndYieldsSumState.requestData[i].milkingCows.toString().isEmpty?"0":CowsAndYieldsSumState.requestData[i].milkingCows.toString())+
              int.parse(CowsAndYieldsSumState.requestData[i].dryCows.toString().isEmpty?"0":CowsAndYieldsSumState.requestData[i].dryCows.toString())+
              int.parse(CowsAndYieldsSumState.requestData[i].heiferCows.toString().isEmpty?"0":CowsAndYieldsSumState.requestData[i].heiferCows.toString())+
              int.parse(CowsAndYieldsSumState.requestData[i].sevenToTwelveMonthCows.toString().isEmpty?"0":CowsAndYieldsSumState.requestData[i].sevenToTwelveMonthCows.toString())+
              int.parse(CowsAndYieldsSumState.requestData[i].sixMonthCow.toString().isEmpty?"0":CowsAndYieldsSumState.requestData[i].sixMonthCow.toString())+
              int.parse("0");
          totalHerdSize = totalHerdSize+addTotalHerd;
        }

        sumOfHerd = int.parse(CowsAndYieldsSumState.requestData[index].milkingCows.toString().isEmpty?"0":CowsAndYieldsSumState.requestData[index].milkingCows.toString())+
            int.parse(CowsAndYieldsSumState.requestData[index].dryCows.toString().isEmpty?"0":CowsAndYieldsSumState.requestData[index].dryCows.toString())+
            int.parse(CowsAndYieldsSumState.requestData[index].heiferCows.toString().isEmpty?"0":CowsAndYieldsSumState.requestData[index].heiferCows.toString())+
            int.parse(CowsAndYieldsSumState.requestData[index].sevenToTwelveMonthCows.toString().isEmpty?"0":CowsAndYieldsSumState.requestData[index].sevenToTwelveMonthCows.toString())+
            int.parse(CowsAndYieldsSumState.requestData[index].sixMonthCow.toString().isEmpty?"0":CowsAndYieldsSumState.requestData[index].sixMonthCow.toString())+
            int.parse("0");

        state.herdSizeController[index] = TextEditingController(text: sumOfHerd.toString());

        emit(state.copyWith(totalHerdSize: totalHerdSize));
        totalHerdSize = 0;
        sumOfHerd = 0;

      });
    }) ;

    state.sevenTwelveMonthController[index].addListener(() {
      Future.delayed(const Duration(milliseconds: 20),(){

        for (int i = 0; i < CowsAndYieldsSumState.requestData.length; i++) {
          addTotalHerd = int.parse(CowsAndYieldsSumState.requestData[i].milkingCows.toString().isEmpty?"0":CowsAndYieldsSumState.requestData[i].milkingCows.toString())+
              int.parse(CowsAndYieldsSumState.requestData[i].dryCows.toString().isEmpty?"0":CowsAndYieldsSumState.requestData[i].dryCows.toString())+
              int.parse(CowsAndYieldsSumState.requestData[i].heiferCows.toString().isEmpty?"0":CowsAndYieldsSumState.requestData[i].heiferCows.toString())+
              int.parse(CowsAndYieldsSumState.requestData[i].sevenToTwelveMonthCows.toString().isEmpty?"0":CowsAndYieldsSumState.requestData[i].sevenToTwelveMonthCows.toString())+
              int.parse(CowsAndYieldsSumState.requestData[i].sixMonthCow.toString().isEmpty?"0":CowsAndYieldsSumState.requestData[i].sixMonthCow.toString())+
              int.parse("0");
          totalHerdSize = totalHerdSize+addTotalHerd;
        }

        sumOfHerd = int.parse(CowsAndYieldsSumState.requestData[index].milkingCows.toString().isEmpty?"0":CowsAndYieldsSumState.requestData[index].milkingCows.toString())+
            int.parse(CowsAndYieldsSumState.requestData[index].dryCows.toString().isEmpty?"0":CowsAndYieldsSumState.requestData[index].dryCows.toString())+
            int.parse(CowsAndYieldsSumState.requestData[index].heiferCows.toString().isEmpty?"0":CowsAndYieldsSumState.requestData[index].heiferCows.toString())+
            int.parse(CowsAndYieldsSumState.requestData[index].sevenToTwelveMonthCows.toString().isEmpty?"0":CowsAndYieldsSumState.requestData[index].sevenToTwelveMonthCows.toString())+
            int.parse(CowsAndYieldsSumState.requestData[index].sixMonthCow.toString().isEmpty?"0":CowsAndYieldsSumState.requestData[index].sixMonthCow.toString())+
            int.parse("0");

        state.herdSizeController[index] = TextEditingController(text: sumOfHerd.toString());

        emit(state.copyWith(totalHerdSize: totalHerdSize));
        totalHerdSize = 0;
        sumOfHerd = 0;

      });
    }) ;

    state.lessthanSixMonthController[index].addListener(() {
      Future.delayed(const Duration(milliseconds: 20),(){

        for (int i = 0; i < CowsAndYieldsSumState.requestData.length; i++) {
          addTotalHerd = int.parse(CowsAndYieldsSumState.requestData[i].milkingCows.toString().isEmpty?"0":CowsAndYieldsSumState.requestData[i].milkingCows.toString())+
              int.parse(CowsAndYieldsSumState.requestData[i].dryCows.toString().isEmpty?"0":CowsAndYieldsSumState.requestData[i].dryCows.toString())+
              int.parse(CowsAndYieldsSumState.requestData[i].heiferCows.toString().isEmpty?"0":CowsAndYieldsSumState.requestData[i].heiferCows.toString())+
              int.parse(CowsAndYieldsSumState.requestData[i].sevenToTwelveMonthCows.toString().isEmpty?"0":CowsAndYieldsSumState.requestData[i].sevenToTwelveMonthCows.toString())+
              int.parse(CowsAndYieldsSumState.requestData[i].sixMonthCow.toString().isEmpty?"0":CowsAndYieldsSumState.requestData[i].sixMonthCow.toString())+
              int.parse(CowsAndYieldsSumState.requestData[index].bullCalfs.toString().isEmpty?"0":CowsAndYieldsSumState.requestData[index].bullCalfs.toString());
          totalHerdSize = totalHerdSize+addTotalHerd;
        }

        sumOfHerd = int.parse(CowsAndYieldsSumState.requestData[index].milkingCows.toString().isEmpty?"0":CowsAndYieldsSumState.requestData[index].milkingCows.toString())+
            int.parse(CowsAndYieldsSumState.requestData[index].dryCows.toString().isEmpty?"0":CowsAndYieldsSumState.requestData[index].dryCows.toString())+
            int.parse(CowsAndYieldsSumState.requestData[index].heiferCows.toString().isEmpty?"0":CowsAndYieldsSumState.requestData[index].heiferCows.toString())+
            int.parse(CowsAndYieldsSumState.requestData[index].sevenToTwelveMonthCows.toString().isEmpty?"0":CowsAndYieldsSumState.requestData[index].sevenToTwelveMonthCows.toString())+
            int.parse(CowsAndYieldsSumState.requestData[index].sixMonthCow.toString().isEmpty?"0":CowsAndYieldsSumState.requestData[index].sixMonthCow.toString())+
            int.parse(CowsAndYieldsSumState.requestData[index].bullCalfs.toString().isEmpty?"0":CowsAndYieldsSumState.requestData[index].bullCalfs.toString());

        state.herdSizeController[index] = TextEditingController(text: sumOfHerd.toString());

        emit(state.copyWith(totalHerdSize: totalHerdSize));
        totalHerdSize = 0;
        sumOfHerd = 0;

      });
    }) ;

    state.bullCalfController[index].addListener(() {
      Future.delayed(const Duration(milliseconds: 20),(){

        for (int i = 0; i < CowsAndYieldsSumState.requestData.length; i++) {
          addTotalHerd = int.parse(CowsAndYieldsSumState.requestData[i].milkingCows.toString().isEmpty?"0":CowsAndYieldsSumState.requestData[i].milkingCows.toString())+
              int.parse(CowsAndYieldsSumState.requestData[i].dryCows.toString().isEmpty?"0":CowsAndYieldsSumState.requestData[i].dryCows.toString())+
              int.parse(CowsAndYieldsSumState.requestData[i].heiferCows.toString().isEmpty?"0":CowsAndYieldsSumState.requestData[i].heiferCows.toString())+
              int.parse(CowsAndYieldsSumState.requestData[i].sevenToTwelveMonthCows.toString().isEmpty?"0":CowsAndYieldsSumState.requestData[i].sevenToTwelveMonthCows.toString())+
              int.parse(CowsAndYieldsSumState.requestData[i].sixMonthCow.toString().isEmpty?"0":CowsAndYieldsSumState.requestData[i].sixMonthCow.toString())+
              int.parse(CowsAndYieldsSumState.requestData[index].bullCalfs.toString().isEmpty?"0":CowsAndYieldsSumState.requestData[index].bullCalfs.toString());
          totalHerdSize = totalHerdSize+addTotalHerd;
        }

        sumOfHerd = int.parse(CowsAndYieldsSumState.requestData[index].milkingCows.toString().isEmpty?"0":CowsAndYieldsSumState.requestData[index].milkingCows.toString())+
            int.parse(CowsAndYieldsSumState.requestData[index].dryCows.toString().isEmpty?"0":CowsAndYieldsSumState.requestData[index].dryCows.toString())+
            int.parse(CowsAndYieldsSumState.requestData[index].heiferCows.toString().isEmpty?"0":CowsAndYieldsSumState.requestData[index].heiferCows.toString())+
            int.parse(CowsAndYieldsSumState.requestData[index].sevenToTwelveMonthCows.toString().isEmpty?"0":CowsAndYieldsSumState.requestData[index].sevenToTwelveMonthCows.toString())+
            int.parse(CowsAndYieldsSumState.requestData[index].sixMonthCow.toString().isEmpty?"0":CowsAndYieldsSumState.requestData[index].sixMonthCow.toString())+
            int.parse(CowsAndYieldsSumState.requestData[index].bullCalfs.toString().isEmpty?"0":CowsAndYieldsSumState.requestData[index].bullCalfs.toString());

        state.herdSizeController[index] = TextEditingController(text: sumOfHerd.toString());

        emit(state.copyWith(totalHerdSize: totalHerdSize));
        totalHerdSize = 0;
        sumOfHerd = 0;

      });
    }) ;

    ///// yieldController

    state.yieldPerDayController[index].addListener(() {
      Future.delayed(const Duration(milliseconds: 20),(){
        double totalYield = 0;
        for(int i=0;i<CowsAndYieldsDDEFarmerState.requestData.length;i++){
          totalYield = totalYield+double.parse(CowsAndYieldsDDEFarmerState.requestData[i].yieldPerCow.toString().isEmpty?"0":CowsAndYieldsDDEFarmerState.requestData[i].yieldPerCow.toString());
        }
        double divideByMilking = 0;
        divideByMilking = state.totalProduction/state.totalMilkingCow;
        double numberOfDays = double.parse(DateTime(DateTime.now().year, DateTime.now().month + 1, 0).day.toString());
        double divideByDays = divideByMilking/numberOfDays;
        emit(state.copyWith(yieldPerDay: divideByDays));
        totalYield = 0;
      }) ;
    });

  }


  void totalAll(int i){
    int sums = 0 ,totalMilk=0,totalProduction = 0,sumOfHerd = 0,totalHerdSize = 0;
    for(int i=0;i<CowsAndYieldsSumState.responseDateWiseData.length;i++){
      totalMilk = totalMilk+int.parse(CowsAndYieldsSumState.responseDateWiseData[i].milkingCows.toString());
      sumOfHerd = int.parse(CowsAndYieldsSumState.responseDateWiseData[i].milkingCows.toString())+
          int.parse(CowsAndYieldsSumState.responseDateWiseData[i].dryCows.toString())+
          int.parse(CowsAndYieldsSumState.responseDateWiseData[i].heiferCows.toString())+
          int.parse(CowsAndYieldsSumState.responseDateWiseData[i].sevenToTwelveMonthCows.toString())+
          int.parse(CowsAndYieldsSumState.responseDateWiseData[i].sixMonthCow.toString())+
          int.parse("0");
      totalHerdSize = totalHerdSize+sumOfHerd;
    }
    // state.herdSizeController[i] = TextEditingController(text: sumOfHerd.toString());
    emit(state.copyWith(totalMilkingCow: totalMilk,totalHerdSize: totalHerdSize));

    totalMilk=0;
    sums=0;
    totalHerdSize=0;
    totalProduction=0;
    // sumOfHerd=0;
  }

  void deleteIndex(int index){
    int sums = 0;
    for (int i = 0; i < CowsAndYieldsSumState.requestData.length; i++) {
      sums = sums + int.parse(CowsAndYieldsSumState.requestData[i].milkingCows.toString());
    }
    emit(state.copyWith(totalMilkingCow: sums));
    sums = 0;
  }


  void getCowBreedDetailsApi(context,String tagMonth) async{
    customDialog(widget: launchProgress());
    emit(state.copyWith(status: CowsAndCubitStatus.loading));
    var response = await apiRepository.cowBreedDetailsApi();
    if(response.status == 200){
      disposeProgress();
      print("CowBreeDetail");
      emit(state.copyWith(status: CowsAndCubitStatus.success, responseMonthlyWiseData: response.data!.monthWiseData!));
      for(int i=0 ;i<response.data!.monthWiseData![0].dateWiseData!.length;i++){
        allController("0");
        CowsAndYieldsSumState.responseDateWiseData.add(response.data!.monthWiseData![0].dateWiseData![i]);
        getDataController(i, response.data!.monthWiseData![0].dateWiseData!);
        totalMilkingCow(i);
        sumAllBreed(i);
        totalAll(i);
      }
      showMonth(0,MonthWiseData());
    }
    else{
      emit(state.copyWith(status: CowsAndCubitStatus.error));
      showCustomToast(context, response.message.toString());
    }
  }

  // add Month Api
  void addMonthApi(context,String farmerId,String month) async{
    customDialog(widget: launchProgress());
    CowsAndYieldsSumState.responseDateWiseData.clear();
    emit(state.copyWith(status: CowsAndCubitStatus.loading));
    var response = await apiRepository.addMonthApi(farmerId.toString());
    if(response.status == 200){
      disposeProgress();
      showCustomToast(context, response.message.toString());
      getCowBreedDetailsApi(context,month);
      emit(state.copyWith(status: CowsAndCubitStatus.success));
    }
    else{
      emit(state.copyWith(status: CowsAndCubitStatus.error));
      showCustomToast(context, response.message.toString());
    }
  }

  // deleteMonthApi
  void deleteMonthId(context,String monthName,String farmerId) async{
    customDialog(widget: launchProgress());
    emit(state.copyWith(status: CowsAndCubitStatus.loading));
    var response = await apiRepository.deleteMonthApi(monthName,farmerId);
    if(response.status == 200){
      disposeProgress();
      showCustomToast(context, response.message.toString());
      getCowBreedDetailsApi(context,"deleteMonth");
      emit(state.copyWith(status: CowsAndCubitStatus.success));
    }
    else{
      emit(state.copyWith(status: CowsAndCubitStatus.error));
      showCustomToast(context, response.message.toString());
    }
  }


}