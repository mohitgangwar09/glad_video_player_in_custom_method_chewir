import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:glad/cubit/cowsandyieldDoneCubit/cowsandyielddonecubit.dart';
import 'package:glad/cubit/dde_farmer_cubit/dde_farmer_cubit.dart';
import 'package:glad/data/model/model_total_production.dart';
import 'package:glad/data/model/response_cow_breed_details.dart';
import 'package:glad/data/model/update_record_breed_model.dart';
import 'package:glad/screen/custom_widget/custom_appbar.dart';
import 'package:glad/screen/custom_widget/custom_methods.dart';
import 'package:glad/screen/custom_widget/custom_textfield.dart';
import 'package:glad/screen/dialog/breed_picker.dart';
import 'package:glad/utils/color_resources.dart';
import 'package:glad/utils/extension.dart';
import 'package:glad/utils/helper.dart';
import 'package:glad/utils/images.dart';
import 'package:glad/utils/styles.dart';

String validatorCowYield = "";

class CowsAndYieldsSumDone extends StatefulWidget {

  final String farmerId,userId;

  const CowsAndYieldsSumDone({super.key,required this.farmerId,required this.userId});

  @override
  CowsAndYieldsSumDoneState createState() => CowsAndYieldsSumDoneState();
}

class CowsAndYieldsSumDoneState extends State<CowsAndYieldsSumDone> {
  final _formKey = GlobalKey<FormState>();
  static List<bool> addBreedLength = [];
  static List<String> productionList = [""];
  List<String> addMonthId = [];
  static List<RequestData> requestData = [];
  static List<DateWiseData> responseDateWiseData = [];
  static List<ModelTotalProduction> modelTotalProduction = [];
  static bool addMonth = false;
  static bool checkClickMonth = false;
  static List<bool> showQty=[];
  static List<bool> showGreaterQty=[];
  List<bool> showMonthWiseData=[true];

  void showHideMonthWise(int i){
    setState((){
      showMonthWiseData[i]=!showMonthWiseData[i];
    });
  }

  void showHide(int i){
    setState((){
      showQty[i]=!showQty[i];
    });
  }

  void showGreaterHide(int i){
    setState((){
      showGreaterQty[i]=!showGreaterQty[i];
    });
  }

  @override
  void initState() {
    super.initState();
    SchedulerBinding.instance.addPostFrameCallback((_) {
      // BlocProvider.of<CowsAndYieldDoneCubit>(context).emit(CowsAndCubitDoneState.initial());
      BlocProvider.of<CowsAndYieldDoneCubit>(context).getCowBreedDetailsApi(context,"",id: widget.userId.toString());
      BlocProvider.of<DdeFarmerCubit>(context).getBreedListApi(context,widget.userId.toString());
      // context.read<CowsAndYieldCubit>().addRequestData();
      // BlocProvider.of<CowsAndYieldCubit>(context).showMonth(0,MonthWiseData());
    });
  }

  void updateBreedDetailApi(){

  _formKey.currentState?.save();

  if(requestData[0].milkingCows == ""){
    showCustomToast(context, 'Enter milking cow');
    setState(() {
      validatorCowYield = "milkingCow";
    });
  }/*else if(requestData[0].dryCows == ""){
    showCustomToast(context, 'Enter dry');
    setState(() {
      validatorCowYield = "dryCow";
    });
  }else if(requestData[0].heiferCows == ""){
    showCustomToast(context, 'Enter heifer');
    setState(() {
      validatorCowYield = "heiferCow";
    });
  }else if(requestData[0].sevenToTwelveMonthCows == ""){
    showCustomToast(context, 'Enter 7-12 mo');
    setState(() {
      validatorCowYield = "sevenTwelve";
    });
  }else if(requestData[0].sixMonthCow == ""){
    showCustomToast(context, 'Enter <6 mo');
    setState(() {
      validatorCowYield = "sixMonthCow";
    });
  }else if(requestData[0].bullCalfs == ""){
    showCustomToast(context, 'Enter bull calf');
    setState(() {
      validatorCowYield = "bullCalf";
    });
  }*/else if( BlocProvider.of<CowsAndYieldDoneCubit>(context).state.suppliedToPdfController.text.isEmpty){
    validatorCowYield = "";
    showCustomToast(context, 'Enter supplied to PDFL(Ltr.)');
  }else if( BlocProvider.of<CowsAndYieldDoneCubit>(context).state.suppliedToOtherPdfController.text.isEmpty){

    validatorCowYield = "";
    showCustomToast(context, 'Enter supplied to other(Ltr.)');
  }else if( BlocProvider.of<CowsAndYieldDoneCubit>(context).state.selfUseController.text.isEmpty){

    validatorCowYield = "";
    showCustomToast(context, 'Enter self use');
  }
  else{
    validatorCowYield = "";
    requestData[0].heardSize = BlocProvider.of<CowsAndYieldDoneCubit>(context).state.herdSizeController[0].text.toString();
    UpdateRecordMonthBreedModel response =
    UpdateRecordMonthBreedModel(
        suppliedToOtherPdf: int.parse(BlocProvider.of<CowsAndYieldDoneCubit>(context).state.suppliedToOtherPdfController.text),
        suppliedToPdf: int.parse(BlocProvider.of<CowsAndYieldDoneCubit>(context).state.suppliedToPdfController.text),
        selfUse: int.parse(BlocProvider.of<CowsAndYieldDoneCubit>(context).state.selfUseController.text),
        monthId: BlocProvider.of<CowsAndYieldDoneCubit>(context).state.responseMonthlyWiseData![0].id!,farmerId: int.parse(widget.farmerId.toString()),
        totalProduction:BlocProvider.of<CowsAndYieldDoneCubit>(context).state.totalProduction.toInt(),
        yieldPerCow:double.parse(BlocProvider.of<CowsAndYieldDoneCubit>(context).state.yieldPerDay.toStringAsFixed(2)),
        requestData: requestData);
    String jsonRequestData = jsonEncode(response);

    print(jsonRequestData);

    BlocProvider.of<CowsAndYieldDoneCubit>(context).updateCowBreedRecordApi(context, jsonRequestData,widget.userId.toString());

  }

  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[200],
      body: WillPopScope(
        onWillPop: () async{
          pressBack();
          BlocProvider.of<CowsAndYieldDoneCubit>(context).emit(CowsAndCubitDoneState.initial());
          responseDateWiseData.clear();
          requestData.clear();
          addBreedLength.clear();
          showQty.clear();
          showGreaterQty.clear();
          addMonth = false;
          checkClickMonth = false;
          return true;
        },
        child: Form(
          key: _formKey,
          child: Padding(
            padding: const EdgeInsets.all(1.0),
            child: Column(
              children: [

                CustomAppBar(
                  context: context,
                  titleText1: 'Cows and Yield',
                  leading: InkWell(
                    onTap: (){
                      pressBack();
                      BlocProvider.of<CowsAndYieldDoneCubit>(context).emit(CowsAndCubitDoneState.initial());
                      responseDateWiseData.clear();
                      requestData.clear();
                      addBreedLength.clear();
                      showQty.clear();
                      showGreaterQty.clear();
                      addMonth = false;
                      checkClickMonth = false;
                      }, child: const Icon(Icons.arrow_back,size: 28,)),
                  centerTitle: true,
                  description: 'Provide the following details',
                  action: TextButton(
                    onPressed: () {
                      updateBreedDetailApi();
                    },
                    child: Text(
                      'Save',
                      style: figtreeMedium.copyWith(
                          fontSize: 14, color: ColorResources.maroon),
                    ),
                  ),
                  titleText1Style:
                  figtreeMedium.copyWith(fontSize: 20, color: Colors.black),
                ),

                Expanded(
                  child: SingleChildScrollView(
                    child: Column(
                      children: [

                        BlocBuilder<CowsAndYieldDoneCubit,CowsAndCubitDoneState>(
                            builder: (context,state) {
                            return addMore(state.initialIndex == state.responseMonthlyWiseData!.length-1, state.initialIndex!,state.responseMonthlyWiseData!);
                          }
                        ),

                        BlocBuilder<CowsAndYieldDoneCubit,CowsAndCubitDoneState>(
                            builder: (context,state) {
                              if(state.responseMonthlyWiseData!.isNotEmpty){
                                return customList(list: state.responseMonthlyWiseData!,child: (index) {
                                  showMonthWiseData.add(false);
                                  return Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      10.verticalSpace(),
                                      Padding(
                                        padding: const EdgeInsets.fromLTRB(10, 0, 13, 0),
                                        child: Column(
                                          children: [
                                            Stack(
                                              children: [
                                                SizedBox(
                                                  child: Column(
                                                    children: [
                                                      Container(
                                                        width: screenWidth(),
                                                        decoration: BoxDecoration(
                                                            borderRadius: BorderRadius.circular(20),
                                                            border: Border.all( color: const Color(0xffFFB300),),
                                                            boxShadow: [
                                                              BoxShadow(
                                                                  color: Colors.grey.withOpacity(.100),
                                                                  blurRadius: 15),
                                                            ]),
                                                        child: Card(
                                                          margin: 0.marginAll(),
                                                          shape: RoundedRectangleBorder(
                                                              borderRadius: BorderRadius.circular(20)),
                                                          color: Colors.white,
                                                          child:Column(children: [

                                                            InkWell(
                                                              onTap: (){
                                                                showHideMonthWise(index);
                                                                showGreaterQty.clear();
                                                                context.read<CowsAndYieldDoneCubit>().showMonth(index,state.responseMonthlyWiseData![index]);

                                                              },
                                                              child: Container(
                                                                decoration: const BoxDecoration(
                                                                  borderRadius: BorderRadius.only(
                                                                      topRight: Radius.circular(20),
                                                                      topLeft: Radius.circular(20),
                                                                      bottomLeft: Radius.circular(20),
                                                                      bottomRight: Radius.circular(20),
                                                                  ),
                                                                  color: Color(0xffFFB300),
                                                                ),
                                                                child: Column(
                                                                  children: [
                                                                    Padding(
                                                                      padding: const EdgeInsets.fromLTRB(
                                                                          20, 15, 15, 10),
                                                                      child: Row(
                                                                        mainAxisAlignment:
                                                                        MainAxisAlignment.spaceBetween,
                                                                        children: [
                                                                          Row(
                                                                            children: [
                                                                              Text(
                                                                                '${state.responseMonthlyWiseData![index].monthname??"0"}, ${state.responseMonthlyWiseData![index].year??"0"}',
                                                                                style: figtreeBold.copyWith(
                                                                                    fontSize: 18),
                                                                              ),
                                                                              05.horizontalSpace(),
                                                                              const Icon(
                                                                                Icons.keyboard_arrow_down,
                                                                                size: 30,
                                                                              )
                                                                            ],
                                                                          ),
                                                                          Row(
                                                                            children: [
                                                                              // viewList.contains(index)?"dd".textBold():"PP".textMedium(),

                                                                              // state.responseMonthlyWiseData![index].id == state.monthId?
                                                                              showMonthWiseData[index]?
                                                                              SvgPicture.asset(
                                                                                Images.less1,
                                                                                height:40,
                                                                                width: 40,
                                                                              ):Container(
                                                                                width: 40,
                                                                                height: 40,
                                                                                decoration: BoxDecoration(
                                                                                    borderRadius: BorderRadius.circular(7),
                                                                                    border: Border.all(color: Colors.white,width: 2)
                                                                                ),
                                                                                child: const Icon(Icons.add,
                                                                                  color: Colors.white,),
                                                                              ),

                                                                              10.horizontalSpace(),

                                                                              index>0?const SizedBox(width: 0,height: 0,):
                                                                              state.responseMonthlyWiseData!.length>1?
                                                                              InkWell(
                                                                                onTap: (){
                                                                                  BlocProvider.of<CowsAndYieldDoneCubit>(context).deleteMonthId(context, state.responseMonthlyWiseData![index].monthname.toString().capitalized(),widget.farmerId,widget.userId);
                                                                                },
                                                                                child: SvgPicture.asset(
                                                                                  Images.deleteCows,
                                                                                  height: 40,
                                                                                  width: 40,
                                                                                ),
                                                                              ):
                                                                              const SizedBox.shrink(),

                                                                            ],
                                                                          ),
                                                                        ],
                                                                      ),
                                                                    ),
                                                                    10.verticalSpace(),
                                                                    index>0?
                                                                    Padding(
                                                                      padding: const EdgeInsets.fromLTRB(
                                                                          20, 0, 10, 20),
                                                                      child: Row(
                                                                        mainAxisAlignment:
                                                                        MainAxisAlignment.spaceBetween,
                                                                        children: [
                                                                          Row(
                                                                            children: [
                                                                              Column(
                                                                                crossAxisAlignment:
                                                                                CrossAxisAlignment.start,
                                                                                children: [

                                                                                  Text(
                                                                                    state.responseMonthlyWiseData![index].totalHerdSize!=null?state.responseMonthlyWiseData![index].totalHerdSize!.toString():"",
                                                                                    style: figtreeSemiBold
                                                                                        .copyWith(fontSize: 18),
                                                                                  ),

                                                                                  Text(
                                                                                    'Herd Size',
                                                                                    style: figtreeMedium
                                                                                        .copyWith(fontSize: 12),
                                                                                  ),

                                                                                ],
                                                                              ),
                                                                              05.horizontalSpace(),
                                                                            ],
                                                                          ),
                                                                          Row(
                                                                            children: [
                                                                              Column(
                                                                                crossAxisAlignment:
                                                                                CrossAxisAlignment.start,
                                                                                children: [

                                                                                  Text(
                                                                                    state.responseMonthlyWiseData![index].totalMilkProduction!=null?state.responseMonthlyWiseData![index].totalMilkProduction!.toString():"0",
                                                                                    style: figtreeSemiBold
                                                                                        .copyWith(fontSize: 18),
                                                                                  ),

                                                                                  Text(
                                                                                    'Production',
                                                                                    style: figtreeMedium
                                                                                        .copyWith(fontSize: 12),
                                                                                  ),
                                                                                ],
                                                                              ),
                                                                              05.horizontalSpace(),
                                                                            ],
                                                                          ),
                                                                          Row(
                                                                            children: [
                                                                              Column(
                                                                                crossAxisAlignment:
                                                                                CrossAxisAlignment.start,
                                                                                children: [
                                                                                  Text(
                                                                                    state.responseMonthlyWiseData![index].milkingCow!=null?state.responseMonthlyWiseData![index].milkingCow!.toString():"0",
                                                                                    style: figtreeSemiBold
                                                                                        .copyWith(fontSize: 18),
                                                                                  ),
                                                                                  Text(
                                                                                    'Milking Cows',
                                                                                    style: figtreeMedium
                                                                                        .copyWith(fontSize: 12),
                                                                                  ),
                                                                                ],
                                                                              ),
                                                                              05.horizontalSpace(),
                                                                            ],
                                                                          ),
                                                                          Row(
                                                                            children: [
                                                                              Column(
                                                                                crossAxisAlignment:
                                                                                CrossAxisAlignment.start,
                                                                                children: [
                                                                                  Text(
                                                                                    double.parse('${state.responseMonthlyWiseData![index].totalMilkProduction!=null?
                                                                                  double.parse(state.responseMonthlyWiseData![index].totalMilkProduction!.toString())/
                                                                                  double.parse(state.responseMonthlyWiseData![index].milkingCow!=null?state.responseMonthlyWiseData![index].milkingCow!.toString():"1")
                                                                                      / double.parse(DateTime(state.responseMonthlyWiseData![index].year!, state.responseMonthlyWiseData![index].month!+1, 0).day.toString()):'0'}').toStringAsFixed(2)
                                                                                    ,
                                                                                    style: figtreeSemiBold
                                                                                        .copyWith(fontSize: 18),
                                                                                  ),

                                                                                  Text(
                                                                                    'Yield/day',
                                                                                    style: figtreeMedium
                                                                                        .copyWith(fontSize: 12),
                                                                                  ),

                                                                                ],
                                                                              ),
                                                                              05.horizontalSpace(),
                                                                            ],
                                                                          ),
                                                                        ],
                                                                      ),
                                                                    ):
                                                                    Padding(
                                                                      padding: const EdgeInsets.fromLTRB(
                                                                          20, 0, 10, 20),
                                                                      child: Row(
                                                                        mainAxisAlignment:
                                                                        MainAxisAlignment.spaceBetween,
                                                                        children: [
                                                                          Row(
                                                                            children: [
                                                                              Column(
                                                                                crossAxisAlignment:
                                                                                CrossAxisAlignment.start,
                                                                                children: [
                                                                                  Text(
                                                                                    state.totalHerdSize.toString(),
                                                                                    style: figtreeSemiBold
                                                                                        .copyWith(fontSize: 18),
                                                                                  ),
                                                                                  Text(
                                                                                    'Herd Size',
                                                                                    style: figtreeMedium
                                                                                        .copyWith(fontSize: 12),
                                                                                  )
                                                                                ],
                                                                              ),
                                                                              05.horizontalSpace(),
                                                                            ],
                                                                          ),
                                                                          Row(
                                                                            children: [
                                                                              Column(
                                                                                crossAxisAlignment:
                                                                                CrossAxisAlignment.start,
                                                                                children: [
                                                                                  Text(
                                                                                    state.totalProduction.toInt().toString(),
                                                                                    style: figtreeSemiBold
                                                                                        .copyWith(fontSize: 18),
                                                                                  ),
                                                                                  Text(
                                                                                    'Production',
                                                                                    style: figtreeMedium
                                                                                        .copyWith(fontSize: 12),
                                                                                  )
                                                                                ],
                                                                              ),
                                                                              05.horizontalSpace(),
                                                                            ],
                                                                          ),
                                                                          Row(
                                                                            children: [
                                                                              Column(
                                                                                crossAxisAlignment:
                                                                                CrossAxisAlignment.start,
                                                                                children: [
                                                                                  Text(
                                                                                    state.totalMilkingCow.toString(),
                                                                                    style: figtreeSemiBold
                                                                                        .copyWith(fontSize: 18),
                                                                                  ),
                                                                                  Text(
                                                                                    'Milking Cows',
                                                                                    style: figtreeMedium
                                                                                        .copyWith(fontSize: 12),
                                                                                  )
                                                                                ],
                                                                              ),
                                                                              05.horizontalSpace(),
                                                                            ],
                                                                          ),
                                                                          Row(
                                                                        children: [
                                                                          Column(
                                                                            crossAxisAlignment:
                                                                            CrossAxisAlignment.start,
                                                                            children: [
                                                                              Text(
                                                                                // state.yieldPerDay.toStringAsFixed(2),
                                                                                state.yieldPerDay>0?
                                                                                state.yieldPerDay.toStringAsFixed(2):'0',
                                                                                style: figtreeSemiBold
                                                                                    .copyWith(fontSize: 18),
                                                                              ),
                                                                              Text(
                                                                                'Yield/days',
                                                                                style: figtreeMedium
                                                                                    .copyWith(fontSize: 12),
                                                                              )
                                                                            ],
                                                                          ),
                                                                          05.horizontalSpace(),
                                                                        ],
                                                                      ),],
                                                                      ),
                                                                    )
                                                                  ],
                                                                ),
                                                              ),
                                                            ),

                                                            // index>0?state.responseMonthlyWiseData![index].id == state.monthId?
                                                            index>0?showMonthWiseData[index] ?
                                                            customList(
                                                                padding: const EdgeInsets.only(left: 15,right: 15,top: 10,bottom: 10),
                                                                list: state.responseMonthlyWiseData![index].dateWiseData!,
                                                                child: (childIndex){
                                                                  if(state.responseMonthlyWiseData![index].dateWiseData!.length == 1){
                                                                    showGreaterQty.add(true);
                                                                  }else{
                                                                    if(index==state.responseMonthlyWiseData![index].dateWiseData!.length-1){
                                                                      showGreaterQty.add(true);
                                                                    }else{
                                                                      showGreaterQty.add(false);
                                                                    }
                                                                  }
                                                                  return Column(
                                                                    children: [

                                                                      /*Row(
                                                                    children: [
                                                                      Expanded(
                                                                          child: InkWell(
                                                                            onTap: (){

                                                                            },
                                                                            child: SizedBox(
                                                                                height: 65,
                                                                                child: CustomTextField(
                                                                                  enabled: false,
                                                                                  controller: TextEditingController(text: state.responseMonthlyWiseData![index].dateWiseData![childIndex].breedName.toString()),
                                                                                  imageColors: Colors.black,
                                                                                  hint:'Breed Name',
                                                                                )),
                                                                          )),

                                                                      10.horizontalSpace(),

                                                                      InkWell(
                                                                        onTap: (){
                                                                          showGreaterHide(childIndex);
                                                                        },
                                                                        child: Container(
                                                                          width: 45,
                                                                          height: 60,
                                                                          decoration: BoxDecoration(
                                                                              borderRadius: BorderRadius.circular(8),
                                                                              border: Border.all(color: Colors.red,)
                                                                          ),
                                                                          child: Icon(
                                                                            showGreaterQty[childIndex] ?  Icons.remove:Icons.add, color: Colors.black,
                                                                            // Icons.remove:Icons.add, color: Colors.black,
                                                                          ),
                                                                        ),
                                                                      ),

                                                                    ],
                                                                  ),*/

                                                                      // showGreaterQty[childIndex]?
                                                                      Column(
                                                                        children: [

                                                                          10.verticalSpace(),

                                                                          greaterThanZero(state.responseMonthlyWiseData![index].dateWiseData![childIndex]),

                                                                          Container(
                                                                            margin: const EdgeInsets.only(left: 0,right: 0,top: 15),
                                                                            decoration: BoxDecoration(
                                                                              borderRadius:
                                                                              BorderRadius
                                                                                  .circular(20),
                                                                              color: const Color(
                                                                                  0xffFFF3F4),
                                                                            ),
                                                                            child: Padding(
                                                                              padding:
                                                                              const EdgeInsets
                                                                                  .fromLTRB(
                                                                                  16, 20, 10, 0),
                                                                              child: Column(
                                                                                children: [
                                                                                  Row(
                                                                                    mainAxisAlignment:
                                                                                    MainAxisAlignment
                                                                                        .spaceBetween,
                                                                                    children: [
                                                                                      Expanded(
                                                                                          child:
                                                                                          Column(
                                                                                            crossAxisAlignment:
                                                                                            CrossAxisAlignment
                                                                                                .start,
                                                                                            children: [
                                                                                              Text(
                                                                                                'Supplied to PDFL (Ltr.)',
                                                                                                style: figtreeSemiBold
                                                                                                    .copyWith(
                                                                                                    fontSize:
                                                                                                    12),
                                                                                              ),
                                                                                              08.verticalSpace(),
                                                                                              CustomTextField(
                                                                                                hint: '',
                                                                                                enabled: false,
                                                                                                controller: TextEditingController(text: state.responseMonthlyWiseData![index].suppliedToPdfl!=null?state.responseMonthlyWiseData![index].suppliedToPdfl.toString():""),
                                                                                                paddingTop: 5,
                                                                                                inputType: TextInputType.phone,
                                                                                                paddingBottom: 21,
                                                                                                maxLine: 1,
                                                                                                width: 1,
                                                                                                borderColor:
                                                                                                0xff999999,
                                                                                              ),
                                                                                            ],
                                                                                          )),
                                                                                      15.horizontalSpace(),
                                                                                      Expanded(
                                                                                          child: Column(
                                                                                            crossAxisAlignment:
                                                                                            CrossAxisAlignment
                                                                                                .start,
                                                                                            children: [
                                                                                              Text(
                                                                                                'Supplied to Others (Ltr.)',
                                                                                                style: figtreeSemiBold
                                                                                                    .copyWith(
                                                                                                    fontSize:
                                                                                                    12),
                                                                                              ),
                                                                                              08.verticalSpace(),
                                                                                              CustomTextField(
                                                                                                hint: '',
                                                                                                enabled: false,
                                                                                                controller: TextEditingController(text: state.responseMonthlyWiseData![index].suppliedToOthers!=null?state.responseMonthlyWiseData![index].suppliedToOthers.toString():""),
                                                                                                paddingTop: 5,
                                                                                                inputType: TextInputType.phone,
                                                                                                paddingBottom: 21,
                                                                                                maxLine: 1,
                                                                                                width: 1,
                                                                                                borderColor:
                                                                                                0xff999999,
                                                                                              ),
                                                                                            ],
                                                                                          )),
                                                                                      15.horizontalSpace(),
                                                                                      Expanded(
                                                                                          child:
                                                                                          Column(
                                                                                            crossAxisAlignment:
                                                                                            CrossAxisAlignment
                                                                                                .start,
                                                                                            children: [
                                                                                              Padding(
                                                                                                padding: const EdgeInsets.only(top:15.0),
                                                                                                child: Text(
                                                                                                  'Self use',
                                                                                                  style: figtreeSemiBold
                                                                                                      .copyWith(
                                                                                                      fontSize:
                                                                                                      12),
                                                                                                ),
                                                                                              ),
                                                                                              08.verticalSpace(),
                                                                                              CustomTextField(
                                                                                                hint: '',
                                                                                                enabled: false,
                                                                                                controller: TextEditingController(text: state.responseMonthlyWiseData![index].selfUse!=null?state.responseMonthlyWiseData![index].selfUse.toString():""),
                                                                                                paddingTop: 5,
                                                                                                inputType: TextInputType.phone,
                                                                                                paddingBottom: 21,
                                                                                                maxLine: 1,
                                                                                                width: 1,
                                                                                                borderColor:
                                                                                                0xff999999,
                                                                                              ),
                                                                                            ],
                                                                                          )),
                                                                                    ],
                                                                                  ),
                                                                                  15.verticalSpace(),
                                                                                  /* Row(
                                                                                    mainAxisAlignment:
                                                                                    MainAxisAlignment
                                                                                        .spaceBetween,
                                                                                    children: [
                                                                                      Text(
                                                                                        'Total milk production (Ltr.)',
                                                                                        style: figtreeRegular
                                                                                            .copyWith(
                                                                                            fontSize:
                                                                                            16),
                                                                                      ),
                                                                                      Text(
                                                                                        state.responseMonthlyWiseData![index].totalMilkProduction!=null?state.responseMonthlyWiseData![index].totalMilkProduction.toString():"",
                                                                                        style: figtreeBold
                                                                                            .copyWith(
                                                                                            fontSize:
                                                                                            16),
                                                                                      ),
                                                                                    ],
                                                                                  ),
                                                                                  05.verticalSpace(),*/
                                                                                  // const Divider(
                                                                                  //   thickness: 1,
                                                                                  //   color:
                                                                                  //   ColorResources
                                                                                  //       .grey,
                                                                                  // ),
                                                                                  /*Row(
                                                                                mainAxisAlignment:
                                                                                MainAxisAlignment
                                                                                    .spaceBetween,
                                                                                children: [
                                                                                  Text(
                                                                                    'Yield (Ltr.) /Cow /Day',
                                                                                    style: figtreeRegular
                                                                                        .copyWith(
                                                                                        fontSize:
                                                                                        16),
                                                                                  ),
                                                                                  Text(
                                                                                    state.responseMonthlyWiseData![index].yieldPerCow!=null?double.parse(state.responseMonthlyWiseData![index].yieldPerCow!.toString()).toStringAsFixed(2):"",
                                                                                    style: figtreeBold
                                                                                        .copyWith(
                                                                                        fontSize:
                                                                                        16),
                                                                                  ),
                                                                                ],
                                                                              ),*/
                                                                                ],
                                                                              ),
                                                                            ),
                                                                          )
                                                                        ],
                                                                      )
                                                                      // :const SizedBox(width: 0,height: 0,)

                                                                    ],
                                                                  );
                                                                }
                                                            ):const SizedBox(width: 0,height: 0,):
                                                            showMonthWiseData[index] ?
                                                            Padding(
                                                              padding: const EdgeInsets.only(left: 17,right: 17),
                                                              child: Column(
                                                                children: [
                                                                  ...getDateWiseData(state.responseMonthlyWiseData![0].dateWiseData!,state.responseMonthlyWiseData![0])
                                                                ],
                                                              ),
                                                            ):const SizedBox.shrink(),
                                                            /*state.responseMonthlyWiseData![index].id == state.monthId?
                                                            checkClickMonth == false ?
                                                            Padding(
                                                              padding: const EdgeInsets.only(left: 17,right: 17),
                                                              child: Column(
                                                                children: [
                                                                  ...getDateWiseData(state.responseMonthlyWiseData![0].dateWiseData!)
                                                                ],
                                                              ),
                                                            ):const SizedBox(width: 0,height: 0,)
                                                                :const SizedBox(width: 0,height: 0,),*/

                                                            /*index > 0 ? const SizedBox(width: 0,height: 0,) :
                                                            state.responseMonthlyWiseData![index].id == state.monthId?
                                                            checkClickMonth == false ?
                                                            Column(
                                                              children: [

                                                                20.verticalSpace(),
                                                                TotalProductionTextField(0, state.responseMonthlyWiseData![index], state.responseMonthlyWiseData!),
                                                                20.verticalSpace(),

                                                              ],
                                                            ):const Text(""):const SizedBox(width: 0,height: 0,),*/

                                                            index > 0 ? const SizedBox(width: 0,height: 0,) :
                                                            showMonthWiseData[index] ?
                                                            Column(
                                                              children: [

                                                                20.verticalSpace(),
                                                                TotalProductionTextField(0, state.responseMonthlyWiseData![index], state.responseMonthlyWiseData!),
                                                                20.verticalSpace(),

                                                              ],
                                                            ):const SizedBox(width: 0,height: 0,),

                                                            //// breed Ui
                                                            // index>0?state.responseMonthlyWiseData![index].id == state.monthId?
                                                            /*index>0?state.responseMonthlyWiseData![index].id == state.monthId?
                                                            customList(
                                                                padding: const EdgeInsets.only(left: 15,right: 15,top: 10,bottom: 10),
                                                                list: state.responseMonthlyWiseData![index].dateWiseData!,
                                                                child: (childIndex){
                                                                  if(state.responseMonthlyWiseData![index].dateWiseData!.length == 1){
                                                                    showGreaterQty.add(true);
                                                                  }else{
                                                                    if(index==state.responseMonthlyWiseData![index].dateWiseData!.length-1){
                                                                      showGreaterQty.add(true);
                                                                    }else{
                                                                      showGreaterQty.add(false);
                                                                    }
                                                                  }
                                                                  return Column(
                                                                    children: [

                                                                      *//*Row(
                                                                    children: [
                                                                      Expanded(
                                                                          child: InkWell(
                                                                            onTap: (){

                                                                            },
                                                                            child: SizedBox(
                                                                                height: 65,
                                                                                child: CustomTextField(
                                                                                  enabled: false,
                                                                                  controller: TextEditingController(text: state.responseMonthlyWiseData![index].dateWiseData![childIndex].breedName.toString()),
                                                                                  imageColors: Colors.black,
                                                                                  hint:'Breed Name',
                                                                                )),
                                                                          )),

                                                                      10.horizontalSpace(),

                                                                      InkWell(
                                                                        onTap: (){
                                                                          showGreaterHide(childIndex);
                                                                        },
                                                                        child: Container(
                                                                          width: 45,
                                                                          height: 60,
                                                                          decoration: BoxDecoration(
                                                                              borderRadius: BorderRadius.circular(8),
                                                                              border: Border.all(color: Colors.red,)
                                                                          ),
                                                                          child: Icon(
                                                                            showGreaterQty[childIndex] ?  Icons.remove:Icons.add, color: Colors.black,
                                                                            // Icons.remove:Icons.add, color: Colors.black,
                                                                          ),
                                                                        ),
                                                                      ),

                                                                    ],
                                                                  ),*//*

                                                                      // showGreaterQty[childIndex]?
                                                                      Column(
                                                                        children: [

                                                                          10.verticalSpace(),

                                                                          greaterThanZero(state.responseMonthlyWiseData![index].dateWiseData![childIndex]),

                                                                          Container(
                                                                            margin: const EdgeInsets.only(left: 0,right: 0,top: 15),
                                                                            decoration: BoxDecoration(
                                                                              borderRadius:
                                                                              BorderRadius
                                                                                  .circular(20),
                                                                              color: const Color(
                                                                                  0xffFFF3F4),
                                                                            ),
                                                                            child: Padding(
                                                                              padding:
                                                                              const EdgeInsets
                                                                                  .fromLTRB(
                                                                                  16, 20, 10, 0),
                                                                              child: Column(
                                                                                children: [
                                                                                  Row(
                                                                                    mainAxisAlignment:
                                                                                    MainAxisAlignment
                                                                                        .spaceBetween,
                                                                                    children: [
                                                                                      Expanded(
                                                                                          child:
                                                                                          Column(
                                                                                            crossAxisAlignment:
                                                                                            CrossAxisAlignment
                                                                                                .start,
                                                                                            children: [
                                                                                              Text(
                                                                                                'Supplied to PDFL (Ltr.)',
                                                                                                style: figtreeSemiBold
                                                                                                    .copyWith(
                                                                                                    fontSize:
                                                                                                    12),
                                                                                              ),
                                                                                              08.verticalSpace(),
                                                                                              CustomTextField(
                                                                                                hint: '',
                                                                                                enabled: false,
                                                                                                controller: TextEditingController(text: state.responseMonthlyWiseData![index].suppliedToPdfl!=null?state.responseMonthlyWiseData![index].suppliedToPdfl.toString():""),
                                                                                                paddingTop: 5,
                                                                                                inputType: TextInputType.phone,
                                                                                                paddingBottom: 21,
                                                                                                maxLine: 1,
                                                                                                width: 1,
                                                                                                borderColor:
                                                                                                0xff999999,
                                                                                              ),
                                                                                            ],
                                                                                          )),
                                                                                      15.horizontalSpace(),
                                                                                      Expanded(
                                                                                          child: Column(
                                                                                            crossAxisAlignment:
                                                                                            CrossAxisAlignment
                                                                                                .start,
                                                                                            children: [
                                                                                              Text(
                                                                                                'Supplied to Others (Ltr.)',
                                                                                                style: figtreeSemiBold
                                                                                                    .copyWith(
                                                                                                    fontSize:
                                                                                                    12),
                                                                                              ),
                                                                                              08.verticalSpace(),
                                                                                              CustomTextField(
                                                                                                hint: '',
                                                                                                enabled: false,
                                                                                                controller: TextEditingController(text: state.responseMonthlyWiseData![index].suppliedToOthers!=null?state.responseMonthlyWiseData![index].suppliedToOthers.toString():""),
                                                                                                paddingTop: 5,
                                                                                                inputType: TextInputType.phone,
                                                                                                paddingBottom: 21,
                                                                                                maxLine: 1,
                                                                                                width: 1,
                                                                                                borderColor:
                                                                                                0xff999999,
                                                                                              ),
                                                                                            ],
                                                                                          )),
                                                                                      15.horizontalSpace(),
                                                                                      Expanded(
                                                                                          child:
                                                                                          Column(
                                                                                            crossAxisAlignment:
                                                                                            CrossAxisAlignment
                                                                                                .start,
                                                                                            children: [
                                                                                              Padding(
                                                                                                padding: const EdgeInsets.only(top:15.0),
                                                                                                child: Text(
                                                                                                  'Self use',
                                                                                                  style: figtreeSemiBold
                                                                                                      .copyWith(
                                                                                                      fontSize:
                                                                                                      12),
                                                                                                ),
                                                                                              ),
                                                                                              08.verticalSpace(),
                                                                                              CustomTextField(
                                                                                                hint: '',
                                                                                                enabled: false,
                                                                                                controller: TextEditingController(text: state.responseMonthlyWiseData![index].selfUse!=null?state.responseMonthlyWiseData![index].selfUse.toString():""),
                                                                                                paddingTop: 5,
                                                                                                inputType: TextInputType.phone,
                                                                                                paddingBottom: 21,
                                                                                                maxLine: 1,
                                                                                                width: 1,
                                                                                                borderColor:
                                                                                                0xff999999,
                                                                                              ),
                                                                                            ],
                                                                                          )),
                                                                                    ],
                                                                                  ),
                                                                                  15.verticalSpace(),
                                                                                 *//* Row(
                                                                                    mainAxisAlignment:
                                                                                    MainAxisAlignment
                                                                                        .spaceBetween,
                                                                                    children: [
                                                                                      Text(
                                                                                        'Total milk production (Ltr.)',
                                                                                        style: figtreeRegular
                                                                                            .copyWith(
                                                                                            fontSize:
                                                                                            16),
                                                                                      ),
                                                                                      Text(
                                                                                        state.responseMonthlyWiseData![index].totalMilkProduction!=null?state.responseMonthlyWiseData![index].totalMilkProduction.toString():"",
                                                                                        style: figtreeBold
                                                                                            .copyWith(
                                                                                            fontSize:
                                                                                            16),
                                                                                      ),
                                                                                    ],
                                                                                  ),
                                                                                  05.verticalSpace(),*//*
                                                                                  // const Divider(
                                                                                  //   thickness: 1,
                                                                                  //   color:
                                                                                  //   ColorResources
                                                                                  //       .grey,
                                                                                  // ),
                                                                                  *//*Row(
                                                                                mainAxisAlignment:
                                                                                MainAxisAlignment
                                                                                    .spaceBetween,
                                                                                children: [
                                                                                  Text(
                                                                                    'Yield (Ltr.) /Cow /Day',
                                                                                    style: figtreeRegular
                                                                                        .copyWith(
                                                                                        fontSize:
                                                                                        16),
                                                                                  ),
                                                                                  Text(
                                                                                    state.responseMonthlyWiseData![index].yieldPerCow!=null?double.parse(state.responseMonthlyWiseData![index].yieldPerCow!.toString()).toStringAsFixed(2):"",
                                                                                    style: figtreeBold
                                                                                        .copyWith(
                                                                                        fontSize:
                                                                                        16),
                                                                                  ),
                                                                                ],
                                                                              ),*//*
                                                                                ],
                                                                              ),
                                                                            ),
                                                                          )
                                                                        ],
                                                                      )
                                                                      // :const SizedBox(width: 0,height: 0,)

                                                                    ],
                                                                  );
                                                                }
                                                            ):const SizedBox(width: 0,height: 0,):
                                                                showMonthWiseData[index] ?
                                                            Padding(
                                                              padding: const EdgeInsets.only(left: 17,right: 17),
                                                              child: Column(
                                                                children: [
                                                                  ...getDateWiseData(state.responseMonthlyWiseData![0].dateWiseData!)
                                                                ],
                                                              ),
                                                            ):const SizedBox.shrink(),
                                                            *//*state.responseMonthlyWiseData![index].id == state.monthId?
                                                            checkClickMonth == false ?
                                                            Padding(
                                                              padding: const EdgeInsets.only(left: 17,right: 17),
                                                              child: Column(
                                                                children: [
                                                                  ...getDateWiseData(state.responseMonthlyWiseData![0].dateWiseData!)
                                                                ],
                                                              ),
                                                            ):const SizedBox(width: 0,height: 0,)
                                                                :const SizedBox(width: 0,height: 0,),*//*

                                                            *//*index > 0 ? const SizedBox(width: 0,height: 0,) :
                                                            state.responseMonthlyWiseData![index].id == state.monthId?
                                                            checkClickMonth == false ?
                                                            Column(
                                                              children: [

                                                                20.verticalSpace(),
                                                                TotalProductionTextField(0, state.responseMonthlyWiseData![index], state.responseMonthlyWiseData!),
                                                                20.verticalSpace(),

                                                              ],
                                                            ):const Text(""):const SizedBox(width: 0,height: 0,),*//*

                                                            index > 0 ? const SizedBox(width: 0,height: 0,) :
                                                            showMonthWiseData[index] ?
                                                            Column(
                                                              children: [

                                                                20.verticalSpace(),
                                                                TotalProductionTextField(0, state.responseMonthlyWiseData![index], state.responseMonthlyWiseData!),
                                                                20.verticalSpace(),

                                                              ],
                                                            ):const SizedBox(width: 0,height: 0,),*/

                                                          ]),
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ],
                                        ),
                                      ),
                                    ],
                                  );
                                });
                              }
                              return const SizedBox(width: 0,height: 0,);
                            }
                        ),

                        BlocBuilder<CowsAndYieldDoneCubit,CowsAndCubitDoneState>(
                          builder: (context,state) {
                            return state.responseMonthlyWiseData!.isNotEmpty?saveCancelButton():const SizedBox.shrink();
                          }
                        ),

                        // const SizedBox(height: 40,)

                      ],
                    ),
                  ),
                )

              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget saveCancelButton() {
    return Padding(
      padding: const EdgeInsets.fromLTRB(29, 40, 29, 0),
      child: Column(
        children: [
          // 40.verticalSpace(),
          customButton(
            'Save',
            style: figtreeMedium.copyWith(color: Colors.white, fontSize: 16),
            onTap: () {
              updateBreedDetailApi();
            },
            width: screenWidth(),
            height: 60,
          ),
          15.verticalSpace(),
          customButton('Cancel',
              style: figtreeMedium.copyWith(fontSize: 16),
              onTap: () {
            pressBack();
            BlocProvider.of<CowsAndYieldDoneCubit>(context).emit(CowsAndCubitDoneState.initial());
            responseDateWiseData.clear();
            requestData.clear();
            addBreedLength.clear();
            showQty.clear();
            showGreaterQty.clear();
            addMonth = false;
            checkClickMonth = false;
              },
              width: screenWidth(),
              height: 60,
              color: 0xffDCDCDC),
          20.verticalSpace(),
        ],
      ),
    );
  }


  Widget greaterThanZero(DateWiseData responseDateWise){
    return Column(
      children: [
       /* Row(
          children: [
            // Expanded(child: breedTile(title: "Herd", value: responseDateWise.heardSize.toString())),

            10.horizontalSpace(),

            Expanded(child: breedTile(title: "Miking Cow", value: responseDateWise.milkingCows.toString())),

          ],
        ),*/
        10.verticalSpace(),
        Row(
          children: [
            Expanded(child: breedTile(title: "Miking Cow", value: responseDateWise.milkingCows.toString())),
           /* Expanded(child: breedTile(title: "Yield (Ltr./day)", value: responseDateWise.yieldPerCow.toString())),

            10.horizontalSpace(),*/
            10.horizontalSpace(),
            Expanded(child: breedTile(title: "Dry", value: responseDateWise.dryCows.toString())),

            10.horizontalSpace(),

            Expanded(child: breedTile(title: "Heifer", value: responseDateWise.heiferCows.toString())),

          ],
        ),
        10.verticalSpace(),
        Row(
          children: [
            Expanded(child: breedTile(title: "7-12 mo", value: responseDateWise.sevenToTwelveMonthCows.toString())),

            10.horizontalSpace(),

            Expanded(child: breedTile(title: "<6 month", value: responseDateWise.sixMonthCow.toString())),

            10.horizontalSpace(),

            Expanded(child: breedTile(title: "Bull Calf", value: responseDateWise.bullCalfs.toString())),

          ],
        ),
      ],
    );
  }


  Widget breedTile({required String title,required String value}){
    return Column(
      crossAxisAlignment:
      CrossAxisAlignment
          .start,
      children: [
        Text(
          title,
          style: figtreeSemiBold
              .copyWith(
              fontSize:
              12),
        ),
        05.verticalSpace(),
        Container(
          height: 61,
          width: screenWidth(),
          padding: const EdgeInsets.only(left: 22),
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              border: Border.all(color: const Color(0xff999999),)
          ),
          child: Align(
              alignment: Alignment.centerLeft,child: Text(value.toString())),
        )
      ],
    );
  }

  //////////AddMoreBreedDateWise////////////////
  Widget addMoreDateWiseData(bool add, int index,List<DateWiseData> responseDateWiseDatas) {
    return Column(
      children: [
        0.verticalSpace(),
        customButton('+ Add Mores',
            height: 50,
            width: 130,
            onTap: () {

              if(BlocProvider.of<DdeFarmerCubit>(context).state.breedResponse!.length>responseDateWiseData.length){
                setState(() {
                  responseDateWiseData.add(DateWiseData(id: null,milkingCows: "0",
                      yieldPerCow: "0",dryCows: "0",heiferCows: "0",sevenToTwelveMonthCows: "0",sixMonthCow: "0"));
                  addBreedLength.add(false);
                  showQty.insert(responseDateWiseDatas.length-1,true);
                  BlocProvider.of<CowsAndYieldDoneCubit>(context).addRequestData(index,"addMore");
                  BlocProvider.of<CowsAndYieldDoneCubit>(context).allController("0");
                  // context.read<CowsAndYieldCubit>().addRequestData(index,"addMore");
                });
              }
            },
            color: 0xffFFFFFF,
            borderColor: 0xff6A0030,
            fontColor: 0xff6A0030),
      ],
    );
  }

  //////////AddMoreButton////////////////
  Widget addMore(bool add, int index,List<MonthWiseData> responseMonthWiseData) {
    return Column(
      children: [
        20.verticalSpace(),
        customButton('+ Add More',
            height: 55,
            width: 180,
            onTap: () {
              if(responseMonthWiseData.isNotEmpty){
                if(checkDateMonth(responseMonthWiseData[0].year,(responseMonthWiseData[0].month+1))){

                  // showCustomToast(context, "Current Month");
                  BlocProvider.of<CowsAndYieldDoneCubit>(context).addMonthApi(context,widget.farmerId,"month",widget.userId);

                }else{
                  showCustomToast(context, "Month already exist");
                }
              }else{
                BlocProvider.of<CowsAndYieldDoneCubit>(context).addMonthApi(context,widget.farmerId,"month",widget.userId);
              }
              requestData.clear();
              addMonth = true;
              setState((){});
            },
            color: 0xffFFFFFF,
            borderColor: 0xff6A0030,
            fontColor: 0xff6A0030),
      ],
    );
  }

  Widget addRemoveButton(bool add, int index) {
    return InkWell(
      onTap: () {
        setState(() {
          responseDateWiseData.removeAt(index);
          requestData.removeAt(index);
          BlocProvider.of<CowsAndYieldDoneCubit>(context).removeControllerValue(index);
        });
      },
      child: Container(
        width: 30,
        height: 30,
        decoration: BoxDecoration(
          color: (add) ? Colors.green : Colors.red,
          borderRadius: BorderRadius.circular(20),
        ),
        child: Icon(
          (add) ? Icons.add : Icons.remove, color: Colors.white,
        ),
      ),
    );
  }

  Widget addBreedRemoveButton(bool add, int index) {
    return BlocBuilder<CowsAndYieldDoneCubit,CowsAndCubitDoneState>(
        builder: (context,state) {
          return Column(
            children: [

              10.verticalSpace(),

              Row(
                children: [
                  Expanded(
                      child: InkWell(
                        onTap: (){
                          // if(CowsAndYieldsSumState.addBreedLength[index] == true){

                          // }else{
                          customDialog(
                              widget: BreedPicker(index:index));
                          // }
                        },
                        child: SizedBox(
                            height: 65,
                            child: CustomTextField(
                              enabled: false,
                              image: addBreedLength.isEmpty?null:addBreedLength[index] == true? null:Images.arrowDown,
                              imageColors: Colors.black,
                              controller: state.breedController[index],
                              hint:'Breed Name',
                            )),
                      )),
                  10.horizontalSpace(),
                  InkWell(
                    onTap: (){
                      showHide(index);
                    },
                    child: Container(
                      width: 45,
                      height: 60,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(8),
                          border: Border.all(color:  Colors.green)
                      ),
                      child: Icon(
                        // /*showQty[widget.index] ? */ Icons.remove/*:Icons.add*/, color: Colors.black,
                        showQty.isEmpty?Icons.remove:showQty[index] ?  Icons.remove:Icons.add, color: Colors.black,
                      ),
                    ),
                  ),
                  10.horizontalSpace(),

                  InkWell(
                    onTap: (){
                      setState((){
                        setState(() {
                          responseDateWiseData.removeAt(index);
                          requestData.removeAt(index);
                          addBreedLength.removeAt(index);
                          BlocProvider.of<CowsAndYieldDoneCubit>(context).removeControllerValue(index);
                        });
                      });
                    },
                    child: SvgPicture.asset(
                        Images.deleteField),
                  )
                ],
              ),

              20.verticalSpace(),
            ],
          );
        }
    );
  }

  List<Widget> getDateWiseData(List<DateWiseData> responseDateWis,MonthWiseData responseMonthWise){
    List<Widget> friendsTextFieldsList = [];
    for(int i=0; i<responseDateWiseData.length; i++){

      // print("lengthCome${responseDateWiseData.length}");
      // print(showQty.length);

      friendsTextFieldsList.add(
          Column(
            children: [

              // 10.verticalSpace(),

              // addBreedRemoveButton(i == responseDateWiseData.length-1, i),

              // showQty.isEmpty?const SizedBox(width: 0,height: 0,):
              // showQty[i] ?
              ProductionTextField(i,responseDateWiseData[i],responseDateWiseData,responseMonthWise)
                  // : const SizedBox(width: 0,height: 0,),
              // addRemoveButton(i == responseDateWiseData.length-1, i),
            ],
          )
        // ProductionTextField(i,responseDateWise[i],responseDateWise)
      );
    }
    return friendsTextFieldsList;
  }

}


class ProductionTextField extends StatefulWidget {
  final int index;
  final DateWiseData responseDateWise;
  final List<DateWiseData> dateWiseDate;
  final MonthWiseData responseMonthWise;

  const ProductionTextField(this.index,this.responseDateWise, this.dateWiseDate,this.responseMonthWise, {super.key});

  @override
  State<ProductionTextField> createState() => _ProductionTextFieldState();
}

class _ProductionTextFieldState extends State<ProductionTextField> {

  @override
  void initState() {
    super.initState();
    context.read<CowsAndYieldDoneCubit>().totalMilkingCow(widget.index,widget.responseMonthWise);
    context.read<CowsAndYieldDoneCubit>().sumAllBreed(widget.index);
  }

  Widget validator(String validateString,String showString){
    return Column(
      children: [

        6.verticalSpace(),

        validatorCowYield == validateString?
        showString.textRegular(color: Colors.red,
            fontSize: 12):const SizedBox.shrink()

      ],
    );
  }

  @override
  Widget build(BuildContext context) {

    return BlocBuilder<CowsAndYieldDoneCubit,CowsAndCubitDoneState>(
        builder: (context,state) {

          return Column(
            children: [

              // 20.verticalSpace(),

              Column(
                children: [

                /*  Row(
                    children: [
                      *//*Expanded(
                          child: Column(
                            crossAxisAlignment:
                            CrossAxisAlignment
                                .start,
                            children: [
                              Text(
                                'Herd',
                                style: figtreeSemiBold
                                    .copyWith(
                                    fontSize:
                                    12),
                              ),
                              05.verticalSpace(),
                              CustomTextField(
                                hint: '',
                                enabled: false,
                                readOnly: true,
                                onChanged: (v){
                                  CowsAndYieldsSumDoneState.requestData[widget.index].heardSize = v;
                                },
                                controller: state.herdSizeController[widget.index],
                                paddingTop: 5,
                                inputType: TextInputType.phone,
                                paddingBottom: 21,
                                maxLine: 1,
                                width: 1,
                                borderColor:
                                0xff999999,
                              ),
                            ],
                          )),*//*
                      // 15.horizontalSpace(),
                      Expanded(
                          child: Column(
                            crossAxisAlignment:
                            CrossAxisAlignment
                                .start,
                            children: [
                              Text(
                                'Milking Cow',
                                style: figtreeSemiBold
                                    .copyWith(
                                    fontSize:
                                    12),
                              ),
                              05.verticalSpace(),
                              CustomTextField(
                                hint: '',
                                onChanged: (v){
                                  CowsAndYieldsSumDoneState.requestData[widget.index].milkingCows = v;
                                },
                                inputType: TextInputType.phone,
                                maxLine: 1,
                                maxLength: 6,
                                inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                                controller: state.milkingCowController[widget.index],
                                paddingTop: 5,
                                paddingBottom: 21,
                                width: 1,
                                borderColor:
                                0xff999999,
                              ),

                              validator('milkingCow','Enter milking cow'),

                            ],
                          )),
                    ],
                  ),*/

                  20.verticalSpace(),

                  Row(
                    children: [
                      /*Expanded(
                          child: Column(
                            crossAxisAlignment:
                            CrossAxisAlignment
                                .start,
                            children: [
                              Text(
                                'Yield (Ltr/.Day)',
                                style: figtreeSemiBold
                                    .copyWith(
                                    fontSize:
                                    12),
                              ),
                              05.verticalSpace(),
                              CustomTextField(
                                hint: '',
                                onChanged: (v) => CowsAndYieldsSumDoneState.requestData[widget.index].yieldPerCow = v,
                                controller: state.yieldPerDayController[widget.index],
                                paddingTop: 5,
                                inputType: TextInputType.phone,
                                paddingBottom: 21,
                                maxLine: 1,
                                width: 1,
                                borderColor:
                                0xff999999,
                              ),
                            ],
                          )),
                      15.horizontalSpace(),*/
                      Expanded(
                          child: Column(
                            crossAxisAlignment:
                            CrossAxisAlignment
                                .start,
                            children: [
                              Text(
                                'Milking Cow',
                                style: figtreeSemiBold
                                    .copyWith(
                                    fontSize:
                                    12),
                              ),
                              05.verticalSpace(),
                              CustomTextField(
                                hint: '',
                                onChanged: (v){
                                  CowsAndYieldsSumDoneState.requestData[widget.index].milkingCows = v;
                                },
                                inputType: TextInputType.phone,
                                maxLine: 1,
                                maxLength: 6,
                                inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                                controller: state.milkingCowController[widget.index],
                                paddingTop: 5,
                                paddingBottom: 21,
                                width: 1,
                                borderColor:
                                0xff999999,
                              ),

                              validator('milkingCow','Enter milking cow'),

                            ],
                          )),
                      15.horizontalSpace(),
                      Expanded(
                          child: Column(
                            crossAxisAlignment:
                            CrossAxisAlignment
                                .start,
                            children: [
                              Text(
                                'Dry',
                                style: figtreeSemiBold
                                    .copyWith(
                                    fontSize:
                                    12),
                              ),
                              05.verticalSpace(),
                              CustomTextField(
                                hint: '',
                                onChanged: (v) => CowsAndYieldsSumDoneState.requestData[widget.index].dryCows = v,
                                controller: state.dryController[widget.index],
                                inputType: TextInputType.phone,
                                maxLine: 1,
                                maxLength: 6,
                                inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                                paddingTop: 5,
                                paddingBottom: 21,
                                width: 1,
                                borderColor:
                                0xff999999,
                              ),

                              validator('dryCow','Enter dry'),

                            ],
                          )),

                      15.horizontalSpace(),

                      Expanded(
                          child: Column(
                            crossAxisAlignment:
                            CrossAxisAlignment
                                .start,
                            children: [
                              Text(
                                'Heifer',
                                style: figtreeSemiBold
                                    .copyWith(
                                    fontSize:
                                    12),
                              ),
                              05.verticalSpace(),
                              CustomTextField(
                                hint: '',
                                onChanged: (v) => CowsAndYieldsSumDoneState.requestData[widget.index].heiferCows = v,
                                controller: state.heiferController[widget.index],
                                inputType: TextInputType.phone,
                                maxLine: 1,
                                maxLength: 6,
                                inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                                paddingTop: 5,
                                paddingBottom: 21,
                                width: 1,
                                borderColor:
                                0xff999999,
                              ),

                              validator('heiferCow','Enter heifer'),

                            ],
                          )),
                    ],
                  ),

                  20.verticalSpace(),

                  Row(
                    children: [
                      Expanded(
                          child: Column(
                            crossAxisAlignment:
                            CrossAxisAlignment
                                .start,
                            children: [
                              Text(
                                '7-12 mo',
                                style: figtreeSemiBold
                                    .copyWith(
                                    fontSize:
                                    12),
                              ),
                              05.verticalSpace(),
                              CustomTextField(
                                hint: '',
                                onChanged: (v) => CowsAndYieldsSumDoneState.requestData[widget.index].sevenToTwelveMonthCows = v,
                                controller: state.sevenTwelveMonthController[widget.index],
                                inputType: TextInputType.phone,
                                maxLine: 1,
                                maxLength: 6,
                                inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                                paddingTop: 5,
                                paddingBottom: 21,
                                width: 1,
                                borderColor:
                                0xff999999,
                              ),

                              validator('sevenTwelve','Enter 7-12 mo'),

                            ],
                          )),
                      15.horizontalSpace(),
                      Expanded(
                          child: Column(
                            crossAxisAlignment:
                            CrossAxisAlignment
                                .start,
                            children: [
                              Text(
                                '<6 mo',
                                style: figtreeSemiBold
                                    .copyWith(
                                    fontSize:
                                    12),
                              ),
                              05.verticalSpace(),
                              CustomTextField(
                                hint: '',
                                onChanged: (v) => CowsAndYieldsSumDoneState.requestData[widget.index].sixMonthCow = v,
                                controller: state.lessthanSixMonthController[widget.index],
                                inputType: TextInputType.phone,
                                maxLine: 1,
                                maxLength: 6,
                                inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                                paddingTop: 5,
                                paddingBottom: 21,
                                width: 1,
                                borderColor:
                                0xff999999,
                              ),

                              validator('sixMonthCow','Enter <6 mo'),

                            ],
                          )),

                      15.horizontalSpace(),

                      Expanded(
                          child: Column(
                            crossAxisAlignment:
                            CrossAxisAlignment
                                .start,
                            children: [
                              Text(
                                'Bull Calf',
                                style: figtreeSemiBold
                                    .copyWith(
                                    fontSize:
                                    12),
                              ),
                              05.verticalSpace(),
                              CustomTextField(
                                hint: '',
                                onChanged: (v) => CowsAndYieldsSumDoneState.requestData[widget.index].bullCalfs = v,
                                controller: state.bullCalfController[widget.index],
                                inputType: TextInputType.phone,
                                maxLine: 1,
                                maxLength: 6,
                                inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                                paddingTop: 5,
                                paddingBottom: 21,
                                width: 1,
                                borderColor:
                                0xff999999,
                              ),

                              validator('bullCalf','Enter bull calf'),

                            ],
                          )),
                    ],
                  ),
                ],
              ),

              10.verticalSpace(),

              const Divider(height: 20,thickness: 1.5,),
            ],
          );
        }
    );
  }
}

class TotalProductionTextField extends StatefulWidget {
  final int index;
  final MonthWiseData responseMonthWise;
  final List<MonthWiseData> dataMonthWise;
  const TotalProductionTextField(this.index,this.responseMonthWise,this.dataMonthWise, {super.key});

  @override
  State<TotalProductionTextField> createState() => _TotalProductionTextFieldState();
}

class _TotalProductionTextFieldState extends State<TotalProductionTextField> {

  @override
  void initState() {
    super.initState();

    context.read<CowsAndYieldDoneCubit>().totalFirstProduction(0,widget.index,widget.responseMonthWise);

    context.read<CowsAndYieldDoneCubit>().getProductionData(widget.responseMonthWise);

    CowsAndYieldsSumDoneState.modelTotalProduction.addAll({ModelTotalProduction(
      totalMilkProduction: widget.responseMonthWise.totalMilkProduction!=null ?double.parse(widget.responseMonthWise.totalMilkProduction.toString()): 0.0,
      selfUseController: widget.responseMonthWise.selfUse!=null?widget.responseMonthWise.selfUse.toString():"0.0",
      suppliedToPdfl: widget.responseMonthWise.suppliedToPdfl!=null?widget.responseMonthWise.suppliedToPdfl.toString():"0.0",
      suppliedToOther: widget.responseMonthWise.suppliedToOthers!=null?widget.responseMonthWise.suppliedToOthers.toString():"0.0",
    )});
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {


    return BlocBuilder<CowsAndYieldDoneCubit,CowsAndCubitDoneState>(
        builder: (context,state) {
          return Container(
            margin: const EdgeInsets.only(left: 15,right: 15),
            decoration: BoxDecoration(
              borderRadius:
              BorderRadius
                  .circular(20),
              color: const Color(
                  0xffFFF3F4),
            ),
            child: Padding(
              padding:
              const EdgeInsets
                  .fromLTRB(
                  16, 20, 10, 20),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment:
                    MainAxisAlignment
                        .spaceBetween,
                    children: [
                      Expanded(
                          child:
                          Column(
                            crossAxisAlignment:
                            CrossAxisAlignment
                                .start,
                            children: [
                              Text(
                                'Supplied to PDFL (Ltr.)',
                                style: figtreeSemiBold
                                    .copyWith(
                                    fontSize:
                                    12),
                              ),
                              08.verticalSpace(),
                              CustomTextField(
                                hint: '',
                                controller: state.suppliedToPdfController,
                                onChanged: (v){
                                  context.read<CowsAndYieldDoneCubit>().totalFirstProduction(0,widget.index,widget.responseMonthWise);
                                } ,
                                maxLine: 1,
                                maxLength: 12,
                                inputType: TextInputType.phone,
                                inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                                paddingTop: 5,
                                paddingBottom: 21,
                                width: 1,
                                borderColor:
                                0xff999999,
                              ),
                            ],
                          )),
                      15.horizontalSpace(),
                      Expanded(
                          child: Column(
                            crossAxisAlignment:
                            CrossAxisAlignment
                                .start,
                            children: [
                              Text(
                                'Supplied to Others (Ltr.)',
                                style: figtreeSemiBold
                                    .copyWith(
                                    fontSize:
                                    12),
                              ),
                              08.verticalSpace(),
                              CustomTextField(
                                hint: '',
                                controller: state.suppliedToOtherPdfController,
                                paddingTop: 5,
                                onChanged: (v){
                                  context.read<CowsAndYieldDoneCubit>().totalFirstProduction(0,widget.index,widget.responseMonthWise);
                                } ,
                                maxLine: 1,
                                maxLength: 12,
                                inputType: TextInputType.phone,
                                inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                                paddingBottom: 21,
                                width: 1,
                                borderColor:
                                0xff999999,
                              ),
                            ],
                          )),
                      15.horizontalSpace(),
                      Expanded(
                          child:
                          Column(
                            crossAxisAlignment:
                            CrossAxisAlignment
                                .start,
                            children: [
                              Padding(
                                padding: const EdgeInsets.only(top:15.0),
                                child: Text(
                                  'Self use',
                                  style: figtreeSemiBold
                                      .copyWith(
                                      fontSize:
                                      12),
                                ),
                              ),
                              08.verticalSpace(),
                              CustomTextField(
                                hint: '',
                                controller: state.selfUseController,
                                paddingTop: 5,
                                onChanged: (v){
                                  context.read<CowsAndYieldDoneCubit>().totalFirstProduction(0,widget.index,widget.responseMonthWise);
                                } ,
                                maxLine: 1,
                                maxLength: 12,
                                inputType: TextInputType.phone,
                                inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                                paddingBottom: 21,
                                width: 1,
                                borderColor:
                                0xff999999,
                              ),
                            ],
                          )),
                    ],
                  ),
                 /* 20.verticalSpace(),
                  Row(
                    mainAxisAlignment:
                    MainAxisAlignment
                        .spaceBetween,
                    children: [
                      Text(
                        'Total milk production (Ltr.)',
                        style: figtreeRegular
                            .copyWith(
                            fontSize:
                            16),
                      ),
                      Text(
                        state.totalProduction.toInt().toString(),
                        style: figtreeBold
                            .copyWith(
                            fontSize:
                            16),
                      ),
                    ],
                  ),*/
                  05.verticalSpace(),
                  /*const Divider(
                    thickness: 1,
                    color:
                    ColorResources
                        .grey,
                  ),*/
                  /*Row(
                    mainAxisAlignment:
                    MainAxisAlignment
                        .spaceBetween,
                    children: [
                      Text(
                        'Yield (Ltr.) /Cow /Day',
                        style: figtreeRegular
                            .copyWith(
                            fontSize:
                            16),
                      ),
                      Text(
                        state.yieldPerDay.toStringAsFixed(2),
                        style: figtreeBold
                            .copyWith(
                            fontSize:
                            16),
                      ),
                    ],
                  ),*/
                ],
              ),
            ),
          );
        }
    );
  }
}
