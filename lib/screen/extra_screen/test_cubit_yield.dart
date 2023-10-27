import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:glad/data/model/response_cow_breed_details.dart';
import 'package:glad/data/repository/dde_repo.dart';
import 'package:glad/screen/custom_widget/custom_methods.dart';
import 'package:glad/screen/extra_screen/test_cows_and_yield.dart';
import 'package:glad/utils/extension.dart';
import 'package:glad/utils/helper.dart';
import 'package:shared_preferences/shared_preferences.dart';


part 'test_cubit_yield_state.dart';

class CowsAndYieldCubitTest extends Cubit<TestYieldState>{

  final SharedPreferences sharedPreferences;
  final DdeRepository apiRepository;

  CowsAndYieldCubitTest({required this.apiRepository,required this.sharedPreferences}):super(TestYieldState.initial());


  void showMonth(int i,MonthWiseData monthWise){
    emit(state.copyWith(monthId: int.parse(state.responseMonthlyWiseData![i].id.toString())));
  }


  void allController(String milk){
    // List<TextEditingController> controller = [];
    // controller.add(TextEditingController());
    state.milkingCowController.add(TextEditingController());
    state.herdSizeController.add(TextEditingController());
    state.yieldPerDayController.add(TextEditingController());
    state.dryController.add(TextEditingController());
    state.heiferController.add(TextEditingController());
    state.sevenTwelveMonthController.add(TextEditingController());
    state.lessthanSixMonthController.add(TextEditingController());
    state.bullCalfController.add(TextEditingController());
  }

  void getDataController(int childIndex,List<DateWiseData> responseDateWise){
    // for(int childIndex=0;childIndex<CowsAndYieldsSumState.responseDateWiseData.length;childIndex++){
    state.milkingCowController[childIndex].text = responseDateWise[childIndex].milkingCows.toString();
    state.herdSizeController[childIndex].text = responseDateWise[childIndex].heardSize.toString();
    state.yieldPerDayController[childIndex].text = responseDateWise[childIndex].yieldPerCow.toString();
    state.dryController[childIndex].text = responseDateWise[childIndex].dryCows.toString();
    state.heiferController[childIndex].text = responseDateWise[childIndex].heiferCows.toString();
    state.sevenTwelveMonthController[childIndex].text = responseDateWise[childIndex].sevenToTwelveMonthCows.toString();
    state.lessthanSixMonthController[childIndex].text = responseDateWise[childIndex].sixMonthCow.toString();
    state.bullCalfController[childIndex].text = "0";
    // }
  }

  void totalMilkingCow(int index){
    int sums = 0,sumOfHerd = 0,totalHerdSize = 0,addTotalHerd;
    state.milkingCowController[index].addListener(() {
      print(state.milkingCowController[index].text);
      Future.delayed(const Duration(milliseconds: 20),(){

        for (int i = 0; i < TestCowAndYieldState.requestData.length; i++) {
          sums = sums + int.parse(TestCowAndYieldState.requestData[i].milkingCows.toString().isEmpty?"0":TestCowAndYieldState.requestData[i].milkingCows.toString());
          addTotalHerd = int.parse(TestCowAndYieldState.requestData[i].milkingCows.toString().isEmpty?"0":TestCowAndYieldState.requestData[i].milkingCows.toString())+
              int.parse(TestCowAndYieldState.requestData[i].dryCows.toString().isEmpty?"0":TestCowAndYieldState.requestData[i].dryCows.toString())+
              int.parse(TestCowAndYieldState.requestData[i].heiferCows.toString().isEmpty?"0":TestCowAndYieldState.requestData[i].heiferCows.toString())+
              int.parse(TestCowAndYieldState.requestData[i].sevenToTwelveMonthCows.toString().isEmpty?"0":TestCowAndYieldState.requestData[i].sevenToTwelveMonthCows.toString())+
              int.parse(TestCowAndYieldState.requestData[i].sixMonthCow.toString().isEmpty?"0":TestCowAndYieldState.requestData[i].sixMonthCow.toString())+
              int.parse("0");
          totalHerdSize = totalHerdSize+addTotalHerd;
        }

        sumOfHerd = int.parse(TestCowAndYieldState.requestData[index].milkingCows.toString().isEmpty?"0":TestCowAndYieldState.requestData[index].milkingCows.toString())+
            int.parse(TestCowAndYieldState.requestData[index].dryCows.toString().isEmpty?"0":TestCowAndYieldState.requestData[index].dryCows.toString())+
            int.parse(TestCowAndYieldState.requestData[index].heiferCows.toString().isEmpty?"0":TestCowAndYieldState.requestData[index].heiferCows.toString())+
            int.parse(TestCowAndYieldState.requestData[index].sevenToTwelveMonthCows.toString().isEmpty?"0":TestCowAndYieldState.requestData[index].sevenToTwelveMonthCows.toString())+
            int.parse(TestCowAndYieldState.requestData[index].sixMonthCow.toString().isEmpty?"0":TestCowAndYieldState.requestData[index].sixMonthCow.toString())+
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

        for (int i = 0; i < TestCowAndYieldState.requestData.length; i++) {
          addTotalHerd = int.parse(TestCowAndYieldState.requestData[i].milkingCows.toString().isEmpty?"0":TestCowAndYieldState.requestData[i].milkingCows.toString())+
              int.parse(TestCowAndYieldState.requestData[i].dryCows.toString().isEmpty?"0":TestCowAndYieldState.requestData[i].dryCows.toString())+
              int.parse(TestCowAndYieldState.requestData[i].heiferCows.toString().isEmpty?"0":TestCowAndYieldState.requestData[i].heiferCows.toString())+
              int.parse(TestCowAndYieldState.requestData[i].sevenToTwelveMonthCows.toString().isEmpty?"0":TestCowAndYieldState.requestData[i].sevenToTwelveMonthCows.toString())+
              int.parse(TestCowAndYieldState.requestData[i].sixMonthCow.toString().isEmpty?"0":TestCowAndYieldState.requestData[i].sixMonthCow.toString())+
              int.parse("0");
          totalHerdSize = totalHerdSize+addTotalHerd;
        }

        sumOfHerd = int.parse(TestCowAndYieldState.requestData[index].milkingCows.toString().isEmpty?"0":TestCowAndYieldState.requestData[index].milkingCows.toString())+
            int.parse(TestCowAndYieldState.requestData[index].dryCows.toString().isEmpty?"0":TestCowAndYieldState.requestData[index].dryCows.toString())+
            int.parse(TestCowAndYieldState.requestData[index].heiferCows.toString().isEmpty?"0":TestCowAndYieldState.requestData[index].heiferCows.toString())+
            int.parse(TestCowAndYieldState.requestData[index].sevenToTwelveMonthCows.toString().isEmpty?"0":TestCowAndYieldState.requestData[index].sevenToTwelveMonthCows.toString())+
            int.parse(TestCowAndYieldState.requestData[index].sixMonthCow.toString().isEmpty?"0":TestCowAndYieldState.requestData[index].sixMonthCow.toString())+
            int.parse("0");

        state.herdSizeController[index] = TextEditingController(text: sumOfHerd.toString());

        emit(state.copyWith(totalHerdSize: totalHerdSize));
        totalHerdSize = 0;
        sumOfHerd = 0;

      });
    }) ;

    state.heiferController[index].addListener(() {
      Future.delayed(const Duration(milliseconds: 20),(){

        for (int i = 0; i < TestCowAndYieldState.requestData.length; i++) {
          addTotalHerd = int.parse(TestCowAndYieldState.requestData[i].milkingCows.toString().isEmpty?"0":TestCowAndYieldState.requestData[i].milkingCows.toString())+
              int.parse(TestCowAndYieldState.requestData[i].dryCows.toString().isEmpty?"0":TestCowAndYieldState.requestData[i].dryCows.toString())+
              int.parse(TestCowAndYieldState.requestData[i].heiferCows.toString().isEmpty?"0":TestCowAndYieldState.requestData[i].heiferCows.toString())+
              int.parse(TestCowAndYieldState.requestData[i].sevenToTwelveMonthCows.toString().isEmpty?"0":TestCowAndYieldState.requestData[i].sevenToTwelveMonthCows.toString())+
              int.parse(TestCowAndYieldState.requestData[i].sixMonthCow.toString().isEmpty?"0":TestCowAndYieldState.requestData[i].sixMonthCow.toString())+
              int.parse("0");
          totalHerdSize = totalHerdSize+addTotalHerd;
        }

        sumOfHerd = int.parse(TestCowAndYieldState.requestData[index].milkingCows.toString().isEmpty?"0":TestCowAndYieldState.requestData[index].milkingCows.toString())+
            int.parse(TestCowAndYieldState.requestData[index].dryCows.toString().isEmpty?"0":TestCowAndYieldState.requestData[index].dryCows.toString())+
            int.parse(TestCowAndYieldState.requestData[index].heiferCows.toString().isEmpty?"0":TestCowAndYieldState.requestData[index].heiferCows.toString())+
            int.parse(TestCowAndYieldState.requestData[index].sevenToTwelveMonthCows.toString().isEmpty?"0":TestCowAndYieldState.requestData[index].sevenToTwelveMonthCows.toString())+
            int.parse(TestCowAndYieldState.requestData[index].sixMonthCow.toString().isEmpty?"0":TestCowAndYieldState.requestData[index].sixMonthCow.toString())+
            int.parse("0");

        state.herdSizeController[index] = TextEditingController(text: sumOfHerd.toString());

        emit(state.copyWith(totalHerdSize: totalHerdSize));
        totalHerdSize = 0;
        sumOfHerd = 0;

      });
    }) ;

    state.sevenTwelveMonthController[index].addListener(() {
      Future.delayed(const Duration(milliseconds: 20),(){

        for (int i = 0; i < TestCowAndYieldState.requestData.length; i++) {
          addTotalHerd = int.parse(TestCowAndYieldState.requestData[i].milkingCows.toString().isEmpty?"0":TestCowAndYieldState.requestData[i].milkingCows.toString())+
              int.parse(TestCowAndYieldState.requestData[i].dryCows.toString().isEmpty?"0":TestCowAndYieldState.requestData[i].dryCows.toString())+
              int.parse(TestCowAndYieldState.requestData[i].heiferCows.toString().isEmpty?"0":TestCowAndYieldState.requestData[i].heiferCows.toString())+
              int.parse(TestCowAndYieldState.requestData[i].sevenToTwelveMonthCows.toString().isEmpty?"0":TestCowAndYieldState.requestData[i].sevenToTwelveMonthCows.toString())+
              int.parse(TestCowAndYieldState.requestData[i].sixMonthCow.toString().isEmpty?"0":TestCowAndYieldState.requestData[i].sixMonthCow.toString())+
              int.parse("0");
          totalHerdSize = totalHerdSize+addTotalHerd;
        }

        sumOfHerd = int.parse(TestCowAndYieldState.requestData[index].milkingCows.toString().isEmpty?"0":TestCowAndYieldState.requestData[index].milkingCows.toString())+
            int.parse(TestCowAndYieldState.requestData[index].dryCows.toString().isEmpty?"0":TestCowAndYieldState.requestData[index].dryCows.toString())+
            int.parse(TestCowAndYieldState.requestData[index].heiferCows.toString().isEmpty?"0":TestCowAndYieldState.requestData[index].heiferCows.toString())+
            int.parse(TestCowAndYieldState.requestData[index].sevenToTwelveMonthCows.toString().isEmpty?"0":TestCowAndYieldState.requestData[index].sevenToTwelveMonthCows.toString())+
            int.parse(TestCowAndYieldState.requestData[index].sixMonthCow.toString().isEmpty?"0":TestCowAndYieldState.requestData[index].sixMonthCow.toString())+
            int.parse("0");

        state.herdSizeController[index] = TextEditingController(text: sumOfHerd.toString());

        emit(state.copyWith(totalHerdSize: totalHerdSize));
        totalHerdSize = 0;
        sumOfHerd = 0;

      });
    }) ;

    state.lessthanSixMonthController[index].addListener(() {
      Future.delayed(const Duration(milliseconds: 20),(){

        for (int i = 0; i < TestCowAndYieldState.requestData.length; i++) {
          addTotalHerd = int.parse(TestCowAndYieldState.requestData[i].milkingCows.toString().isEmpty?"0":TestCowAndYieldState.requestData[i].milkingCows.toString())+
              int.parse(TestCowAndYieldState.requestData[i].dryCows.toString().isEmpty?"0":TestCowAndYieldState.requestData[i].dryCows.toString())+
              int.parse(TestCowAndYieldState.requestData[i].heiferCows.toString().isEmpty?"0":TestCowAndYieldState.requestData[i].heiferCows.toString())+
              int.parse(TestCowAndYieldState.requestData[i].sevenToTwelveMonthCows.toString().isEmpty?"0":TestCowAndYieldState.requestData[i].sevenToTwelveMonthCows.toString())+
              int.parse(TestCowAndYieldState.requestData[i].sixMonthCow.toString().isEmpty?"0":TestCowAndYieldState.requestData[i].sixMonthCow.toString());
              // + int.parse(TestCowAndYieldState.requestData[index].bullCalfs.toString().isEmpty?"0":TestCowAndYieldState.requestData[index].bullCalfs.toString());
          totalHerdSize = totalHerdSize+addTotalHerd;
        }

        sumOfHerd = int.parse(TestCowAndYieldState.requestData[index].milkingCows.toString().isEmpty?"0":TestCowAndYieldState.requestData[index].milkingCows.toString())+
            int.parse(TestCowAndYieldState.requestData[index].dryCows.toString().isEmpty?"0":TestCowAndYieldState.requestData[index].dryCows.toString())+
            int.parse(TestCowAndYieldState.requestData[index].heiferCows.toString().isEmpty?"0":TestCowAndYieldState.requestData[index].heiferCows.toString())+
            int.parse(TestCowAndYieldState.requestData[index].sevenToTwelveMonthCows.toString().isEmpty?"0":TestCowAndYieldState.requestData[index].sevenToTwelveMonthCows.toString())+
            int.parse(TestCowAndYieldState.requestData[index].sixMonthCow.toString().isEmpty?"0":TestCowAndYieldState.requestData[index].sixMonthCow.toString());
            // int.parse(TestCowAndYieldState.requestData[index].bullCalfs.toString().isEmpty?"0":TestCowAndYieldState.requestData[index].bullCalfs.toString());

        state.herdSizeController[index] = TextEditingController(text: sumOfHerd.toString());

        emit(state.copyWith(totalHerdSize: totalHerdSize));
        totalHerdSize = 0;
        sumOfHerd = 0;

      });
    }) ;

    state.bullCalfController[index].addListener(() {
      Future.delayed(const Duration(milliseconds: 20),(){

        for (int i = 0; i < TestCowAndYieldState.requestData.length; i++) {
          addTotalHerd = int.parse(TestCowAndYieldState.requestData[i].milkingCows.toString().isEmpty?"0":TestCowAndYieldState.requestData[i].milkingCows.toString())+
              int.parse(TestCowAndYieldState.requestData[i].dryCows.toString().isEmpty?"0":TestCowAndYieldState.requestData[i].dryCows.toString())+
              int.parse(TestCowAndYieldState.requestData[i].heiferCows.toString().isEmpty?"0":TestCowAndYieldState.requestData[i].heiferCows.toString())+
              int.parse(TestCowAndYieldState.requestData[i].sevenToTwelveMonthCows.toString().isEmpty?"0":TestCowAndYieldState.requestData[i].sevenToTwelveMonthCows.toString())+
              int.parse(TestCowAndYieldState.requestData[i].sixMonthCow.toString().isEmpty?"0":TestCowAndYieldState.requestData[i].sixMonthCow.toString());
              // int.parse(TestCowAndYieldState.requestData[index].bullCalfs.toString().isEmpty?"0":TestCowAndYieldState.requestData[index].bullCalfs.toString());
          totalHerdSize = totalHerdSize+addTotalHerd;
        }

        sumOfHerd = int.parse(TestCowAndYieldState.requestData[index].milkingCows.toString().isEmpty?"0":TestCowAndYieldState.requestData[index].milkingCows.toString())+
            int.parse(TestCowAndYieldState.requestData[index].dryCows.toString().isEmpty?"0":TestCowAndYieldState.requestData[index].dryCows.toString())+
            int.parse(TestCowAndYieldState.requestData[index].heiferCows.toString().isEmpty?"0":TestCowAndYieldState.requestData[index].heiferCows.toString())+
            int.parse(TestCowAndYieldState.requestData[index].sevenToTwelveMonthCows.toString().isEmpty?"0":TestCowAndYieldState.requestData[index].sevenToTwelveMonthCows.toString())+
            int.parse(TestCowAndYieldState.requestData[index].sixMonthCow.toString().isEmpty?"0":TestCowAndYieldState.requestData[index].sixMonthCow.toString());
            // int.parse(TestCowAndYieldState.requestData[index].bullCalfs.toString().isEmpty?"0":TestCowAndYieldState.requestData[index].bullCalfs.toString());

        state.herdSizeController[index] = TextEditingController(text: sumOfHerd.toString());

        emit(state.copyWith(totalHerdSize: totalHerdSize));
        totalHerdSize = 0;
        sumOfHerd = 0;

      });
    }) ;

  }


  void totalAll(int i){
    int sums = 0 ,totalMilk=0,totalProduction = 0,sumOfHerd = 0,totalHerdSize = 0;
    for(int i=0;i<TestCowAndYieldState.requestData.length;i++){
      totalMilk = totalMilk+int.parse(TestCowAndYieldState.requestData[i].milkingCows.toString());
      sumOfHerd = int.parse(TestCowAndYieldState.requestData[i].milkingCows.toString())+
          int.parse(TestCowAndYieldState.requestData[i].dryCows.toString())+
          int.parse(TestCowAndYieldState.requestData[i].heiferCows.toString())+
          int.parse(TestCowAndYieldState.requestData[i].sevenToTwelveMonthCows.toString())+
          int.parse(TestCowAndYieldState.requestData[i].sixMonthCow.toString());
          // int.parse("0");
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
    for (int i = 0; i < TestCowAndYieldState.requestData.length; i++) {
      sums = sums + int.parse(TestCowAndYieldState.requestData[i].milkingCows.toString());
    }
    emit(state.copyWith(totalMilkingCow: sums));
    sums = 0;
  }


  void getCowBreedDetailsApi(context,String tagMonth) async{
    customDialog(widget: launchProgress());
    emit(state.copyWith(status: TestYieldStatus.loading));
    var response = await apiRepository.cowBreedDetailsApi();
    if(response.status == 200){
      disposeProgress();
      emit(state.copyWith(status: TestYieldStatus.success, responseMonthlyWiseData: response.data!.monthWiseData!));
      for(int i=0 ;i<response.data!.monthWiseData![0].dateWiseData!.length;i++){
        allController("0");
        TestCowAndYieldState.requestData.add(response.data!.monthWiseData![0].dateWiseData![i]);
        getDataController(i, response.data!.monthWiseData![0].dateWiseData!);
        totalMilkingCow(i);
        sumAllBreed(i);
        totalAll(i);
      }
      showMonth(0,MonthWiseData());
    }
    else{
      emit(state.copyWith(status: TestYieldStatus.error));
      showCustomToast(context, response.message.toString());
    }
  }

  // add Month Api
  void addMonthApi(context,String farmerId,String month) async{
    customDialog(widget: launchProgress());
    emit(state.copyWith(status: TestYieldStatus.loading));
    var response = await apiRepository.addMonthApi(farmerId.toString());
    if(response.status == 200){
      disposeProgress();
      showCustomToast(context, response.message.toString(), isSuccess: true);
      getCowBreedDetailsApi(context,month);
      emit(state.copyWith(status: TestYieldStatus.success));
    }
    else{
      emit(state.copyWith(status: TestYieldStatus.error));
      showCustomToast(context, response.message.toString());
    }
  }

  // deleteMonthApi
  void deleteMonthId(context,String monthName,String farmerId) async{
    customDialog(widget: launchProgress());
    emit(state.copyWith(status: TestYieldStatus.loading));
    var response = await apiRepository.deleteMonthApi(monthName,farmerId);
    if(response.status == 200){
      disposeProgress();
      showCustomToast(context, response.message.toString(), isSuccess: true);
      getCowBreedDetailsApi(context,"deleteMonth");
      emit(state.copyWith(status: TestYieldStatus.success));
    }
    else{
      emit(state.copyWith(status: TestYieldStatus.error));
      showCustomToast(context, response.message.toString());
    }
  }


}