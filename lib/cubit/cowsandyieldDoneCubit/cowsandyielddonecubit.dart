import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:glad/cubit/profile_cubit/profile_cubit.dart';
import 'package:glad/data/model/response_breed.dart';
import 'package:glad/data/model/response_cow_breed_details.dart';
import 'package:glad/data/model/update_record_breed_model.dart';
import 'package:glad/data/repository/dde_repo.dart';
import 'package:glad/screen/custom_widget/custom_methods.dart';
import 'package:glad/screen/dde_screen/dde_cow_and_yield_done.dart';
import 'package:glad/utils/extension.dart';
import 'package:glad/utils/helper.dart';
import 'package:shared_preferences/shared_preferences.dart';
part 'cowsandcubitdonestate.dart';

class CowsAndYieldDoneCubit extends Cubit<CowsAndCubitDoneState>{

  final SharedPreferences sharedPreferences;
  final DdeRepository apiRepository;

  CowsAndYieldDoneCubit({required this.apiRepository,required this.sharedPreferences}):super(CowsAndCubitDoneState.initial());


  void showMonth(int i,MonthWiseData monthWise){
    // print("CowBreeDetail $i lengthClick ${CowsAndYieldsSumState.requestData.length}");
    emit(state.copyWith(monthId: int.parse(state.responseMonthlyWiseData![i].id.toString())));
  }

  void changeBreed(String breedName, String breedId,int index) {
    state.breedController[index].text = breedName;
    CowsAndYieldsSumDoneState.requestData[index].cowBreedId = breedId;
  }

  void removeControllerValue(int index){
    print(state.milkingCowController.length);
    state.milkingCowController.removeAt(index);
    state.herdSizeController.removeAt(index);
    state.yieldPerDayController.removeAt(index);
    state.dryController.removeAt(index);
    state.heiferController.removeAt(index);
    state.sevenTwelveMonthController.removeAt(index);
    state.lessthanSixMonthController.removeAt(index);
    state.bullCalfController.removeAt(index);
    state.breedController.removeAt(index);
    print(state.milkingCowController.length);
    totalAll(index);
  }

  void addRequestData(int index,addMore){
    if(addMore == "addMore"){
      CowsAndYieldsSumDoneState.requestData.addAll({RequestData(
        id: 'null',
        cowBreedId: '1',
        milkingCows: '0',
        yieldPerCow: '1',
        dryCows: '0',
        heardSize: '0',
        heiferCows: '0',
        sevenToTwelveMonthCows: '0',
        sixMonthCow: '0',
        bullCalfs: "0",
      )});
      print("addMore ${CowsAndYieldsSumDoneState.requestData.length}");
    }else{
      CowsAndYieldsSumDoneState.requestData.addAll({RequestData(
        id: state.responseMonthlyWiseData![0].dateWiseData![index].id.toString(),
        cowBreedId: '1',
        milkingCows: state.responseMonthlyWiseData![0].dateWiseData![index].milkingCows.toString(),
        yieldPerCow: '1',
        dryCows: state.responseMonthlyWiseData![0].dateWiseData![index].dryCows.toString(),
        heardSize: "0",
        // heardSize: state.responseMonthlyWiseData![0].dateWiseData![index].heardSize.toString(),
        heiferCows: state.responseMonthlyWiseData![0].dateWiseData![index].heiferCows.toString(),
        sevenToTwelveMonthCows: state.responseMonthlyWiseData![0].dateWiseData![index].sevenToTwelveMonthCows.toString(),
        sixMonthCow: state.responseMonthlyWiseData![0].dateWiseData![index].sixMonthCow.toString(),
        bullCalfs: state.responseMonthlyWiseData![0].dateWiseData![index].bullCalfs.toString(),
      )});
    }
  }


  void allController(String milk){
    print("AddFirst${state.milkingCowController.length}");
    state.milkingCowController.add(TextEditingController());
    state.herdSizeController.add(TextEditingController());
    state.yieldPerDayController.add(TextEditingController());
    state.dryController.add(TextEditingController());
    state.heiferController.add(TextEditingController());
    state.sevenTwelveMonthController.add(TextEditingController());
    state.lessthanSixMonthController.add(TextEditingController());
    state.bullCalfController.add(TextEditingController());
    state.breedController.add(TextEditingController());
    print("After${state.milkingCowController.length}");
  }


  void getProductionData(MonthWiseData responseMonthWise){
    double sums = 0;

    if(responseMonthWise.selfUse!=null){
      state.selfUseController.text = responseMonthWise.selfUse.toString();
    }
    if(responseMonthWise.suppliedToPdfl!=null){
      state.suppliedToPdfController.text = responseMonthWise.suppliedToPdfl.toString();
    }
    if(responseMonthWise.suppliedToOthers!=null){
      state.suppliedToOtherPdfController.text = responseMonthWise.suppliedToOthers.toString();
    }

    sums = double.parse(state.suppliedToPdfController.text.isNotEmpty?state.suppliedToPdfController.text.toString():"0")+double.parse(state.suppliedToOtherPdfController.text.isNotEmpty?state.suppliedToOtherPdfController.text.toString():"0")+double.parse(state.selfUseController.text.isNotEmpty?state.selfUseController.text.toString():"0");

    double divideByMilking = 0,totalYield =0;
    divideByMilking = sums/state.totalMilkingCow;
    double numberOfDays = double.parse(DateTime(DateTime.now().year, DateTime.now().month + 1, 0).day.toString());
    double divideByDays = divideByMilking/numberOfDays;
    totalYield = 0 ;

    emit(state.copyWith(totalProduction: sums,yieldPerDay: divideByDays));


  }

  void totalFirstProduction(double totalProduction,int index) {

    double sums = 0;

    state.suppliedToPdfController.addListener(() {
      print(state.suppliedToPdfController.text);
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
    state.breedController[childIndex].text = 'Jersey';
    state.milkingCowController[childIndex].text = responseDateWise[childIndex].milkingCows.toString();
    state.herdSizeController[childIndex].text = '0';
    state.yieldPerDayController[childIndex].text = responseDateWise[childIndex].yieldPerCow.toString();
    state.dryController[childIndex].text = responseDateWise[childIndex].dryCows.toString();
    state.heiferController[childIndex].text = responseDateWise[childIndex].heiferCows.toString();
    state.sevenTwelveMonthController[childIndex].text = responseDateWise[childIndex].sevenToTwelveMonthCows.toString();
    state.lessthanSixMonthController[childIndex].text = responseDateWise[childIndex].sixMonthCow.toString();
    state.bullCalfController[childIndex].text = responseDateWise[childIndex].bullCalfs.toString();
  }


  void totalMilkingCow(int index){
    int sums = 0,sumOfHerd = 0,totalHerdSize = 0,addTotalHerd;

    state.milkingCowController[index].addListener(() {
      Future.delayed(const Duration(milliseconds: 20),(){
        print("TotalCount ${CowsAndYieldsSumDoneState.requestData.length}");
        for (int i = 0; i < CowsAndYieldsSumDoneState.requestData.length; i++) {
            sums = sums + int.parse(CowsAndYieldsSumDoneState.requestData[i].milkingCows.toString().isEmpty?"0":CowsAndYieldsSumDoneState.requestData[i].milkingCows.toString());
            addTotalHerd = int.parse(CowsAndYieldsSumDoneState.requestData[i].milkingCows.toString().isEmpty?"0":CowsAndYieldsSumDoneState.requestData[i].milkingCows.toString())+
                int.parse(CowsAndYieldsSumDoneState.requestData[i].dryCows.toString().isEmpty?"0":CowsAndYieldsSumDoneState.requestData[i].dryCows.toString())+
                int.parse(CowsAndYieldsSumDoneState.requestData[i].heiferCows.toString().isEmpty?"0":CowsAndYieldsSumDoneState.requestData[i].heiferCows.toString())+
                int.parse(CowsAndYieldsSumDoneState.requestData[i].sevenToTwelveMonthCows.toString().isEmpty?"0":CowsAndYieldsSumDoneState.requestData[i].sevenToTwelveMonthCows.toString())+
                int.parse(CowsAndYieldsSumDoneState.requestData[i].sixMonthCow.toString().isEmpty?"0":CowsAndYieldsSumDoneState.requestData[i].sixMonthCow.toString())+
                int.parse(CowsAndYieldsSumDoneState.requestData[i].bullCalfs.toString().isEmpty?"0":CowsAndYieldsSumDoneState.requestData[i].bullCalfs.toString());
            totalHerdSize = totalHerdSize+addTotalHerd;
            sumOfHerd = int.parse(CowsAndYieldsSumDoneState.requestData[i].milkingCows.toString().isEmpty?"0":CowsAndYieldsSumDoneState.requestData[i].milkingCows.toString())+
                int.parse(CowsAndYieldsSumDoneState.requestData[i].dryCows.toString().isEmpty?"0":CowsAndYieldsSumDoneState.requestData[i].dryCows.toString())+
                int.parse(CowsAndYieldsSumDoneState.requestData[i].heiferCows.toString().isEmpty?"0":CowsAndYieldsSumDoneState.requestData[i].heiferCows.toString())+
                int.parse(CowsAndYieldsSumDoneState.requestData[i].sevenToTwelveMonthCows.toString().isEmpty?"0":CowsAndYieldsSumDoneState.requestData[i].sevenToTwelveMonthCows.toString())+
                int.parse(CowsAndYieldsSumDoneState.requestData[i].sixMonthCow.toString().isEmpty?"0":CowsAndYieldsSumDoneState.requestData[i].sixMonthCow.toString())+
                int.parse(CowsAndYieldsSumDoneState.requestData[i].bullCalfs.toString().isEmpty?"0":CowsAndYieldsSumDoneState.requestData[i].bullCalfs.toString());

            state.herdSizeController[i] = TextEditingController(text: sumOfHerd.toString());


        }

       /* sumOfHerd = int.parse(CowsAndYieldsSumState.requestData[index].milkingCows.toString().isEmpty?"0":CowsAndYieldsSumState.requestData[index].milkingCows.toString())+
            int.parse(CowsAndYieldsSumState.requestData[index].dryCows.toString().isEmpty?"0":CowsAndYieldsSumState.requestData[index].dryCows.toString())+
            int.parse(CowsAndYieldsSumState.requestData[index].heiferCows.toString().isEmpty?"0":CowsAndYieldsSumState.requestData[index].heiferCows.toString())+
            int.parse(CowsAndYieldsSumState.requestData[index].sevenToTwelveMonthCows.toString().isEmpty?"0":CowsAndYieldsSumState.requestData[index].sevenToTwelveMonthCows.toString())+
            int.parse(CowsAndYieldsSumState.requestData[index].sixMonthCow.toString().isEmpty?"0":CowsAndYieldsSumState.requestData[index].sixMonthCow.toString())+
            int.parse("0");*/
        // state.herdSizeController[index] = TextEditingController(text: sumOfHerd.toString());

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

        for (int i = 0; i < CowsAndYieldsSumDoneState.requestData.length; i++) {
          addTotalHerd = int.parse(CowsAndYieldsSumDoneState.requestData[i].milkingCows.toString().isEmpty?"0":CowsAndYieldsSumDoneState.requestData[i].milkingCows.toString())+
              int.parse(CowsAndYieldsSumDoneState.requestData[i].dryCows.toString().isEmpty?"0":CowsAndYieldsSumDoneState.requestData[i].dryCows.toString())+
              int.parse(CowsAndYieldsSumDoneState.requestData[i].heiferCows.toString().isEmpty?"0":CowsAndYieldsSumDoneState.requestData[i].heiferCows.toString())+
              int.parse(CowsAndYieldsSumDoneState.requestData[i].sevenToTwelveMonthCows.toString().isEmpty?"0":CowsAndYieldsSumDoneState.requestData[i].sevenToTwelveMonthCows.toString())+
              int.parse(CowsAndYieldsSumDoneState.requestData[i].sixMonthCow.toString().isEmpty?"0":CowsAndYieldsSumDoneState.requestData[i].sixMonthCow.toString())+
              int.parse(CowsAndYieldsSumDoneState.requestData[i].bullCalfs.toString().isEmpty?"0":CowsAndYieldsSumDoneState.requestData[i].bullCalfs.toString());
          totalHerdSize = totalHerdSize+addTotalHerd;

          sumOfHerd = int.parse(CowsAndYieldsSumDoneState.requestData[i].milkingCows.toString().isEmpty?"0":CowsAndYieldsSumDoneState.requestData[i].milkingCows.toString())+
              int.parse(CowsAndYieldsSumDoneState.requestData[i].dryCows.toString().isEmpty?"0":CowsAndYieldsSumDoneState.requestData[i].dryCows.toString())+
              int.parse(CowsAndYieldsSumDoneState.requestData[i].heiferCows.toString().isEmpty?"0":CowsAndYieldsSumDoneState.requestData[i].heiferCows.toString())+
              int.parse(CowsAndYieldsSumDoneState.requestData[i].sevenToTwelveMonthCows.toString().isEmpty?"0":CowsAndYieldsSumDoneState.requestData[i].sevenToTwelveMonthCows.toString())+
              int.parse(CowsAndYieldsSumDoneState.requestData[i].sixMonthCow.toString().isEmpty?"0":CowsAndYieldsSumDoneState.requestData[i].sixMonthCow.toString())+
              int.parse(CowsAndYieldsSumDoneState.requestData[i].bullCalfs.toString().isEmpty?"0":CowsAndYieldsSumDoneState.requestData[i].bullCalfs.toString());

          state.herdSizeController[i] = TextEditingController(text: sumOfHerd.toString());

        }

        emit(state.copyWith(totalHerdSize: totalHerdSize));
        totalHerdSize = 0;
        sumOfHerd = 0;

      });
    }) ;

    state.heiferController[index].addListener(() {
      Future.delayed(const Duration(milliseconds: 20),(){

        for (int i = 0; i < CowsAndYieldsSumDoneState.requestData.length; i++) {
          addTotalHerd = int.parse(CowsAndYieldsSumDoneState.requestData[i].milkingCows.toString().isEmpty?"0":CowsAndYieldsSumDoneState.requestData[i].milkingCows.toString())+
              int.parse(CowsAndYieldsSumDoneState.requestData[i].dryCows.toString().isEmpty?"0":CowsAndYieldsSumDoneState.requestData[i].dryCows.toString())+
              int.parse(CowsAndYieldsSumDoneState.requestData[i].heiferCows.toString().isEmpty?"0":CowsAndYieldsSumDoneState.requestData[i].heiferCows.toString())+
              int.parse(CowsAndYieldsSumDoneState.requestData[i].sevenToTwelveMonthCows.toString().isEmpty?"0":CowsAndYieldsSumDoneState.requestData[i].sevenToTwelveMonthCows.toString())+
              int.parse(CowsAndYieldsSumDoneState.requestData[i].sixMonthCow.toString().isEmpty?"0":CowsAndYieldsSumDoneState.requestData[i].sixMonthCow.toString())+
              int.parse(CowsAndYieldsSumDoneState.requestData[i].bullCalfs.toString().isEmpty?"0":CowsAndYieldsSumDoneState.requestData[i].bullCalfs.toString());
          totalHerdSize = totalHerdSize+addTotalHerd;
          sumOfHerd = int.parse(CowsAndYieldsSumDoneState.requestData[i].milkingCows.toString().isEmpty?"0":CowsAndYieldsSumDoneState.requestData[i].milkingCows.toString())+
              int.parse(CowsAndYieldsSumDoneState.requestData[i].dryCows.toString().isEmpty?"0":CowsAndYieldsSumDoneState.requestData[i].dryCows.toString())+
              int.parse(CowsAndYieldsSumDoneState.requestData[i].heiferCows.toString().isEmpty?"0":CowsAndYieldsSumDoneState.requestData[i].heiferCows.toString())+
              int.parse(CowsAndYieldsSumDoneState.requestData[i].sevenToTwelveMonthCows.toString().isEmpty?"0":CowsAndYieldsSumDoneState.requestData[i].sevenToTwelveMonthCows.toString())+
              int.parse(CowsAndYieldsSumDoneState.requestData[i].sixMonthCow.toString().isEmpty?"0":CowsAndYieldsSumDoneState.requestData[i].sixMonthCow.toString())+
              int.parse(CowsAndYieldsSumDoneState.requestData[i].bullCalfs.toString().isEmpty?"0":CowsAndYieldsSumDoneState.requestData[i].bullCalfs.toString());

          state.herdSizeController[i] = TextEditingController(text: sumOfHerd.toString());

        }

        // sumOfHerd = int.parse(CowsAndYieldsSumState.requestData[index].milkingCows.toString().isEmpty?"0":CowsAndYieldsSumState.requestData[index].milkingCows.toString())+
        //     int.parse(CowsAndYieldsSumState.requestData[index].dryCows.toString().isEmpty?"0":CowsAndYieldsSumState.requestData[index].dryCows.toString())+
        //     int.parse(CowsAndYieldsSumState.requestData[index].heiferCows.toString().isEmpty?"0":CowsAndYieldsSumState.requestData[index].heiferCows.toString())+
        //     int.parse(CowsAndYieldsSumState.requestData[index].sevenToTwelveMonthCows.toString().isEmpty?"0":CowsAndYieldsSumState.requestData[index].sevenToTwelveMonthCows.toString())+
        //     int.parse(CowsAndYieldsSumState.requestData[index].sixMonthCow.toString().isEmpty?"0":CowsAndYieldsSumState.requestData[index].sixMonthCow.toString())+
        //     int.parse("0");
        //
        // state.herdSizeController[index] = TextEditingController(text: sumOfHerd.toString());

        emit(state.copyWith(totalHerdSize: totalHerdSize));
        totalHerdSize = 0;
        sumOfHerd = 0;

      });
    }) ;

    state.sevenTwelveMonthController[index].addListener(() {
      Future.delayed(const Duration(milliseconds: 20),(){

        for (int i = 0; i < CowsAndYieldsSumDoneState.requestData.length; i++) {
          addTotalHerd = int.parse(CowsAndYieldsSumDoneState.requestData[i].milkingCows.toString().isEmpty?"0":CowsAndYieldsSumDoneState.requestData[i].milkingCows.toString())+
              int.parse(CowsAndYieldsSumDoneState.requestData[i].dryCows.toString().isEmpty?"0":CowsAndYieldsSumDoneState.requestData[i].dryCows.toString())+
              int.parse(CowsAndYieldsSumDoneState.requestData[i].heiferCows.toString().isEmpty?"0":CowsAndYieldsSumDoneState.requestData[i].heiferCows.toString())+
              int.parse(CowsAndYieldsSumDoneState.requestData[i].sevenToTwelveMonthCows.toString().isEmpty?"0":CowsAndYieldsSumDoneState.requestData[i].sevenToTwelveMonthCows.toString())+
              int.parse(CowsAndYieldsSumDoneState.requestData[i].sixMonthCow.toString().isEmpty?"0":CowsAndYieldsSumDoneState.requestData[i].sixMonthCow.toString())+
              int.parse(CowsAndYieldsSumDoneState.requestData[i].bullCalfs.toString().isEmpty?"0":CowsAndYieldsSumDoneState.requestData[i].bullCalfs.toString());
          totalHerdSize = totalHerdSize+addTotalHerd;
          sumOfHerd = int.parse(CowsAndYieldsSumDoneState.requestData[i].milkingCows.toString().isEmpty?"0":CowsAndYieldsSumDoneState.requestData[i].milkingCows.toString())+
              int.parse(CowsAndYieldsSumDoneState.requestData[i].dryCows.toString().isEmpty?"0":CowsAndYieldsSumDoneState.requestData[i].dryCows.toString())+
              int.parse(CowsAndYieldsSumDoneState.requestData[i].heiferCows.toString().isEmpty?"0":CowsAndYieldsSumDoneState.requestData[i].heiferCows.toString())+
              int.parse(CowsAndYieldsSumDoneState.requestData[i].sevenToTwelveMonthCows.toString().isEmpty?"0":CowsAndYieldsSumDoneState.requestData[i].sevenToTwelveMonthCows.toString())+
              int.parse(CowsAndYieldsSumDoneState.requestData[i].sixMonthCow.toString().isEmpty?"0":CowsAndYieldsSumDoneState.requestData[i].sixMonthCow.toString())+
              int.parse(CowsAndYieldsSumDoneState.requestData[i].bullCalfs.toString().isEmpty?"0":CowsAndYieldsSumDoneState.requestData[i].bullCalfs.toString());

          state.herdSizeController[i] = TextEditingController(text: sumOfHerd.toString());

        }

        // sumOfHerd = int.parse(CowsAndYieldsSumState.requestData[index].milkingCows.toString().isEmpty?"0":CowsAndYieldsSumState.requestData[index].milkingCows.toString())+
        //     int.parse(CowsAndYieldsSumState.requestData[index].dryCows.toString().isEmpty?"0":CowsAndYieldsSumState.requestData[index].dryCows.toString())+
        //     int.parse(CowsAndYieldsSumState.requestData[index].heiferCows.toString().isEmpty?"0":CowsAndYieldsSumState.requestData[index].heiferCows.toString())+
        //     int.parse(CowsAndYieldsSumState.requestData[index].sevenToTwelveMonthCows.toString().isEmpty?"0":CowsAndYieldsSumState.requestData[index].sevenToTwelveMonthCows.toString())+
        //     int.parse(CowsAndYieldsSumState.requestData[index].sixMonthCow.toString().isEmpty?"0":CowsAndYieldsSumState.requestData[index].sixMonthCow.toString())+
        //     int.parse("0");
        //
        // state.herdSizeController[index] = TextEditingController(text: sumOfHerd.toString());

        emit(state.copyWith(totalHerdSize: totalHerdSize));
        totalHerdSize = 0;
        sumOfHerd = 0;

      });
    }) ;

    state.lessthanSixMonthController[index].addListener(() {
      Future.delayed(const Duration(milliseconds: 20),(){

        for (int i = 0; i < CowsAndYieldsSumDoneState.requestData.length; i++) {
          addTotalHerd = int.parse(CowsAndYieldsSumDoneState.requestData[i].milkingCows.toString().isEmpty?"0":CowsAndYieldsSumDoneState.requestData[i].milkingCows.toString())+
              int.parse(CowsAndYieldsSumDoneState.requestData[i].dryCows.toString().isEmpty?"0":CowsAndYieldsSumDoneState.requestData[i].dryCows.toString())+
              int.parse(CowsAndYieldsSumDoneState.requestData[i].heiferCows.toString().isEmpty?"0":CowsAndYieldsSumDoneState.requestData[i].heiferCows.toString())+
              int.parse(CowsAndYieldsSumDoneState.requestData[i].sevenToTwelveMonthCows.toString().isEmpty?"0":CowsAndYieldsSumDoneState.requestData[i].sevenToTwelveMonthCows.toString())+
              int.parse(CowsAndYieldsSumDoneState.requestData[i].sixMonthCow.toString().isEmpty?"0":CowsAndYieldsSumDoneState.requestData[i].sixMonthCow.toString())+
              int.parse(CowsAndYieldsSumDoneState.requestData[index].bullCalfs.toString().isEmpty?"0":CowsAndYieldsSumDoneState.requestData[index].bullCalfs.toString());
          totalHerdSize = totalHerdSize+addTotalHerd;
          sumOfHerd = int.parse(CowsAndYieldsSumDoneState.requestData[i].milkingCows.toString().isEmpty?"0":CowsAndYieldsSumDoneState.requestData[i].milkingCows.toString())+
              int.parse(CowsAndYieldsSumDoneState.requestData[i].dryCows.toString().isEmpty?"0":CowsAndYieldsSumDoneState.requestData[i].dryCows.toString())+
              int.parse(CowsAndYieldsSumDoneState.requestData[i].heiferCows.toString().isEmpty?"0":CowsAndYieldsSumDoneState.requestData[i].heiferCows.toString())+
              int.parse(CowsAndYieldsSumDoneState.requestData[i].sevenToTwelveMonthCows.toString().isEmpty?"0":CowsAndYieldsSumDoneState.requestData[i].sevenToTwelveMonthCows.toString())+
              int.parse(CowsAndYieldsSumDoneState.requestData[i].sixMonthCow.toString().isEmpty?"0":CowsAndYieldsSumDoneState.requestData[i].sixMonthCow.toString())+
              int.parse(CowsAndYieldsSumDoneState.requestData[i].bullCalfs.toString().isEmpty?"0":CowsAndYieldsSumDoneState.requestData[i].bullCalfs.toString());

          state.herdSizeController[i] = TextEditingController(text: sumOfHerd.toString());

        }

        // sumOfHerd = int.parse(CowsAndYieldsSumState.requestData[index].milkingCows.toString().isEmpty?"0":CowsAndYieldsSumState.requestData[index].milkingCows.toString())+
        //     int.parse(CowsAndYieldsSumState.requestData[index].dryCows.toString().isEmpty?"0":CowsAndYieldsSumState.requestData[index].dryCows.toString())+
        //     int.parse(CowsAndYieldsSumState.requestData[index].heiferCows.toString().isEmpty?"0":CowsAndYieldsSumState.requestData[index].heiferCows.toString())+
        //     int.parse(CowsAndYieldsSumState.requestData[index].sevenToTwelveMonthCows.toString().isEmpty?"0":CowsAndYieldsSumState.requestData[index].sevenToTwelveMonthCows.toString())+
        //     int.parse(CowsAndYieldsSumState.requestData[index].sixMonthCow.toString().isEmpty?"0":CowsAndYieldsSumState.requestData[index].sixMonthCow.toString())+
        //     int.parse(CowsAndYieldsSumState.requestData[index].bullCalfs.toString().isEmpty?"0":CowsAndYieldsSumState.requestData[index].bullCalfs.toString());
        //
        // state.herdSizeController[index] = TextEditingController(text: sumOfHerd.toString());

        emit(state.copyWith(totalHerdSize: totalHerdSize));
        totalHerdSize = 0;
        sumOfHerd = 0;

      });
    }) ;

    state.bullCalfController[index].addListener(() {
      Future.delayed(const Duration(milliseconds: 20),(){

        for (int i = 0; i < CowsAndYieldsSumDoneState.requestData.length; i++) {
          addTotalHerd = int.parse(CowsAndYieldsSumDoneState.requestData[i].milkingCows.toString().isEmpty?"0":CowsAndYieldsSumDoneState.requestData[i].milkingCows.toString())+
              int.parse(CowsAndYieldsSumDoneState.requestData[i].dryCows.toString().isEmpty?"0":CowsAndYieldsSumDoneState.requestData[i].dryCows.toString())+
              int.parse(CowsAndYieldsSumDoneState.requestData[i].heiferCows.toString().isEmpty?"0":CowsAndYieldsSumDoneState.requestData[i].heiferCows.toString())+
              int.parse(CowsAndYieldsSumDoneState.requestData[i].sevenToTwelveMonthCows.toString().isEmpty?"0":CowsAndYieldsSumDoneState.requestData[i].sevenToTwelveMonthCows.toString())+
              int.parse(CowsAndYieldsSumDoneState.requestData[i].sixMonthCow.toString().isEmpty?"0":CowsAndYieldsSumDoneState.requestData[i].sixMonthCow.toString())+
              int.parse(CowsAndYieldsSumDoneState.requestData[index].bullCalfs.toString().isEmpty?"0":CowsAndYieldsSumDoneState.requestData[index].bullCalfs.toString());
          totalHerdSize = totalHerdSize+addTotalHerd;
          sumOfHerd = int.parse(CowsAndYieldsSumDoneState.requestData[i].milkingCows.toString().isEmpty?"0":CowsAndYieldsSumDoneState.requestData[i].milkingCows.toString())+
              int.parse(CowsAndYieldsSumDoneState.requestData[i].dryCows.toString().isEmpty?"0":CowsAndYieldsSumDoneState.requestData[i].dryCows.toString())+
              int.parse(CowsAndYieldsSumDoneState.requestData[i].heiferCows.toString().isEmpty?"0":CowsAndYieldsSumDoneState.requestData[i].heiferCows.toString())+
              int.parse(CowsAndYieldsSumDoneState.requestData[i].sevenToTwelveMonthCows.toString().isEmpty?"0":CowsAndYieldsSumDoneState.requestData[i].sevenToTwelveMonthCows.toString())+
              int.parse(CowsAndYieldsSumDoneState.requestData[i].sixMonthCow.toString().isEmpty?"0":CowsAndYieldsSumDoneState.requestData[i].sixMonthCow.toString())+
              int.parse(CowsAndYieldsSumDoneState.requestData[i].bullCalfs.toString().isEmpty?"0":CowsAndYieldsSumDoneState.requestData[i].bullCalfs.toString());

          state.herdSizeController[i] = TextEditingController(text: sumOfHerd.toString());

        }

        // sumOfHerd = int.parse(CowsAndYieldsSumState.requestData[index].milkingCows.toString().isEmpty?"0":CowsAndYieldsSumState.requestData[index].milkingCows.toString())+
        //     int.parse(CowsAndYieldsSumState.requestData[index].dryCows.toString().isEmpty?"0":CowsAndYieldsSumState.requestData[index].dryCows.toString())+
        //     int.parse(CowsAndYieldsSumState.requestData[index].heiferCows.toString().isEmpty?"0":CowsAndYieldsSumState.requestData[index].heiferCows.toString())+
        //     int.parse(CowsAndYieldsSumState.requestData[index].sevenToTwelveMonthCows.toString().isEmpty?"0":CowsAndYieldsSumState.requestData[index].sevenToTwelveMonthCows.toString())+
        //     int.parse(CowsAndYieldsSumState.requestData[index].sixMonthCow.toString().isEmpty?"0":CowsAndYieldsSumState.requestData[index].sixMonthCow.toString())+
        //     int.parse(CowsAndYieldsSumState.requestData[index].bullCalfs.toString().isEmpty?"0":CowsAndYieldsSumState.requestData[index].bullCalfs.toString());
        //
        // state.herdSizeController[index] = TextEditingController(text: sumOfHerd.toString());

        emit(state.copyWith(totalHerdSize: totalHerdSize));
        totalHerdSize = 0;
        sumOfHerd = 0;

      });
    }) ;
  }


  void totalAll(int i){
    int sums = 0 ,totalMilk=0,totalProduction = 0,sumOfHerd = 0,totalHerdSize = 0;
   /* for(int i=0;i<CowsAndYieldsSumState.requestData.length;i++){
      totalMilk = totalMilk+int.parse(CowsAndYieldsSumState.requestData[i].milkingCows.toString());
      sumOfHerd = int.parse(CowsAndYieldsSumState.requestData[i].milkingCows.toString())+
          int.parse(CowsAndYieldsSumState.requestData[i].dryCows.toString())+
          int.parse(CowsAndYieldsSumState.requestData[i].heiferCows.toString())+
          int.parse(CowsAndYieldsSumState.requestData[i].sevenToTwelveMonthCows.toString())+
          int.parse(CowsAndYieldsSumState.requestData[i].sixMonthCow.toString())+
          int.parse("0");
      totalHerdSize = totalHerdSize+sumOfHerd;
    }*/
    for(int i=0;i<CowsAndYieldsSumDoneState.responseDateWiseData.length;i++){
      totalMilk = totalMilk+int.parse(CowsAndYieldsSumDoneState.responseDateWiseData[i].milkingCows.toString());
      sumOfHerd = int.parse(CowsAndYieldsSumDoneState.responseDateWiseData[i].milkingCows.toString())+
          int.parse(CowsAndYieldsSumDoneState.responseDateWiseData[i].dryCows.toString())+
          int.parse(CowsAndYieldsSumDoneState.responseDateWiseData[i].heiferCows.toString())+
          int.parse(CowsAndYieldsSumDoneState.responseDateWiseData[i].sevenToTwelveMonthCows.toString())+
          int.parse(CowsAndYieldsSumDoneState.responseDateWiseData[i].sixMonthCow.toString())+
          int.parse(CowsAndYieldsSumDoneState.responseDateWiseData[i].bullCalfs.toString());
      totalHerdSize = totalHerdSize+sumOfHerd;
      state.herdSizeController[i].text = totalHerdSize.toString();
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
    for (int i = 0; i < CowsAndYieldsSumDoneState.requestData.length; i++) {
      sums = sums + int.parse(CowsAndYieldsSumDoneState.requestData[i].milkingCows.toString());
    }
    emit(state.copyWith(totalMilkingCow: sums));
    sums = 0;
  }

  // updateCowBreedRecordApi
  void updateCowBreedRecordApi(context,String requestData,String farmerId) async{
    customDialog(widget: launchProgress());
    emit(state.copyWith(status: CowsAndCubitStatus.loading));
    var response = await apiRepository.updateCowBreedRecordApi(requestData);
    disposeProgress();
    if(response.status == 200){
      showCustomToast(context, response.message.toString(), isSuccess: true);
      getCowBreedDetailsApi(context,"update",id: farmerId);
      await BlocProvider.of<ProfileCubit>(context).getFarmerProfile(context,userId: farmerId);
      BlocProvider.of<CowsAndYieldDoneCubit>(context).emit(CowsAndCubitDoneState.initial());
      CowsAndYieldsSumDoneState.responseDateWiseData.clear();
      CowsAndYieldsSumDoneState.requestData.clear();
      CowsAndYieldsSumDoneState.addBreedLength.clear();
      CowsAndYieldsSumDoneState.showQty.clear();
      CowsAndYieldsSumDoneState.showGreaterQty.clear();
      CowsAndYieldsSumDoneState.addMonth = false;
      CowsAndYieldsSumDoneState.checkClickMonth = false;
      pressBack();
      emit(state.copyWith(status: CowsAndCubitStatus.success));
    }
    else{
      emit(state.copyWith(status: CowsAndCubitStatus.error));
      showCustomToast(context, response.message.toString());
    }
  }

  void getCowBreedDetailsApi(context,String tagMonth,{String? id}) async{
    if(tagMonth == 'deleteMonth'){

    }else{
      CowsAndYieldsSumDoneState.addBreedLength.clear();
      CowsAndYieldsSumDoneState.showQty.clear();
    }
    customDialog(widget: launchProgress());
    emit(state.copyWith(status: CowsAndCubitStatus.loading));
    var response = await apiRepository.cowBreedDetailsApi(id: id.toString());
    if(response.status == 200){
      disposeProgress();
      emit(state.copyWith(status: CowsAndCubitStatus.success, responseMonthlyWiseData: response.data!.monthWiseData!));

      if(response.data!.monthWiseData!.isNotEmpty){
        /*if(response.data!.monthWiseData![0].dateWiseData!.length == 1){
          CowsAndYieldsSumState.showQty.add(true);
        }*/
        for(int i=0 ;i<response.data!.monthWiseData![0].dateWiseData!.length;i++){
          if(tagMonth == 'deleteMonth'){}else{
          if(tagMonth == "update"){
            CowsAndYieldsSumDoneState.addBreedLength.add(true);
              // if(i==response.data!.monthWiseData![0].dateWiseData!.length-1){
              //   CowsAndYieldsSumState.showQty.add(true);
              // }else{
            CowsAndYieldsSumDoneState.showQty.add(false);
              // }
          }
          else{
            CowsAndYieldsSumDoneState.addBreedLength.add(true);
            CowsAndYieldsSumDoneState.showQty.add(false);
            /*if(response.data!.monthWiseData![0].dateWiseData!.length == 1){
              CowsAndYieldsSumState.showQty.add(true);
            }else{
              if(i==response.data!.monthWiseData![0].dateWiseData!.length-1){
                CowsAndYieldsSumState.showQty.add(true);
              }else{
                CowsAndYieldsSumState.showQty.add(false);
              }
            }*/

            allController("0");
            CowsAndYieldsSumDoneState.responseDateWiseData.add(response.data!.monthWiseData![0].dateWiseData![i]);
            getDataController(i, response.data!.monthWiseData![0].dateWiseData!);
            totalMilkingCow(i);
            sumAllBreed(i);
            totalAll(i);
            addRequestData(i,"ist");
          }
          }
        }
        showMonth(0,MonthWiseData());
      }
    }
    else{
      emit(state.copyWith(status: CowsAndCubitStatus.error));
      showCustomToast(context, response.message.toString());
    }
  }

  // add Month Api
  void addMonthApi(context,String farmerId,String month,String userId) async{
    customDialog(widget: launchProgress());
    CowsAndYieldsSumDoneState.responseDateWiseData.clear();
    emit(state.copyWith(status: CowsAndCubitStatus.loading));
    var response = await apiRepository.addMonthApi(farmerId.toString());
    if(response.status == 200){
      disposeProgress();
      showCustomToast(context, response.message.toString(), isSuccess: true);
      getCowBreedDetailsApi(context,month,id: userId.toString());
      emit(state.copyWith(status: CowsAndCubitStatus.success));
    }
    else{
      emit(state.copyWith(status: CowsAndCubitStatus.error));
      showCustomToast(context, response.message.toString());
    }
  }

  // deleteMonthApi
  void deleteMonthId(context,String monthName,String farmerId,String userId) async{
    customDialog(widget: launchProgress());
    emit(state.copyWith(status: CowsAndCubitStatus.loading));
    var response = await apiRepository.deleteMonthApi(monthName,farmerId);
    if(response.status == 200){
      disposeProgress();
      // CowsAndYieldsSumState.showQty.clear();
      showCustomToast(context, response.message.toString(), isSuccess: true);
      getCowBreedDetailsApi(context,"deleteMonth",id: userId);
      emit(state.copyWith(status: CowsAndCubitStatus.success));
    }
    else{
      emit(state.copyWith(status: CowsAndCubitStatus.error));
      showCustomToast(context, response.message.toString());
    }
  }


}