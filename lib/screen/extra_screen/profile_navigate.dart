import 'dart:collection';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:glad/cubit/dde_Farmer_cubit/dde_farmer_cubit.dart';
import 'package:glad/data/model/response_cow_breed_details.dart';
import 'package:glad/data/model/update_record_breed_model.dart';
import 'package:glad/screen/custom_widget/custom_methods.dart';
import 'package:glad/screen/custom_widget/custom_textfield.dart';
import 'package:glad/screen/dialog/breed_picker.dart';
import 'package:glad/utils/color_resources.dart';
import 'package:glad/utils/extension.dart';
import 'package:glad/utils/helper.dart';
import 'package:glad/utils/images.dart';
import 'package:glad/utils/styles.dart';

List<bool> showQty=[true];
List<DateWiseData> addBreedLength = [];
bool checkAddMore = false;

class CowsAndYieldsDDEFarmer extends StatefulWidget {
  const CowsAndYieldsDDEFarmer({super.key});

  @override
  CowsAndYieldsDDEFarmerState createState() => CowsAndYieldsDDEFarmerState();
}

class CowsAndYieldsDDEFarmerState extends State<CowsAndYieldsDDEFarmer> {
  final _formKey = GlobalKey<FormState>();
  late TextEditingController _nameController;
  static List<String> productionList = [];
  static List<RequestData> requestData = [];
  int newIndex = 0;
  late TextEditingController suppliedToPdfController;
  late TextEditingController suppliedToOtherPdfController;
  late TextEditingController selfUseController;

  @override
  void initState() {
    super.initState();
    SchedulerBinding.instance.addPostFrameCallback((_) {
      BlocProvider.of<DdeFarmerCubit>(context).getCowBreedDetailsApi(context);
      BlocProvider.of<DdeFarmerCubit>(context).getBreedListApi(context);
    });
    // _nameController = TextEditingController();
  }

  @override
  void dispose() {
    // _nameController.dispose();
    suppliedToPdfController.dispose();
    selfUseController.dispose();
    suppliedToOtherPdfController.dispose();
    super.dispose();
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[200],
      appBar: AppBar(title: const Text('Cows And Yield'),),
      body: BlocBuilder<DdeFarmerCubit,DdeState>(
        builder: (BuildContext context, state) {
          return Form(
            key: _formKey,
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(0),
                child: Column(
                  children: [
                    // addMore(newIndex == productionList.length-1, newIndex),
                    addMore(newIndex == state.responseMonthlyWiseData!.length-1, newIndex,state.responseMonthlyWiseData!),
                    ..._getProduction(state.responseMonthlyWiseData!),
                    const SizedBox(height: 40,),
                    TextButton(
                      onPressed: (){
                        _formKey.currentState?.save();
                        // print(productionList);

                        addCowAndYield();
                      },
                      child: const Text('Submit'),
                      // color: Colors.green,
                    ),
                  ],
                ),
              ),
            ),
          );
        }
      ),
    );
  }

  void addYields(){



    Map<String,dynamic> jsonData = HashMap();
    List<Map<String,dynamic>> listData = [];

    for(var element in listData ){
      Map<String,dynamic> addElement = HashMap();
      addElement.addAll({
        "id": element,
      });

      listData.add(addElement);
    }
    jsonData.addAll({
      "id":""
    });

  }


  Future addCowAndYield() async {

    UpdateRecordMonthBreedModel response =
    UpdateRecordMonthBreedModel(monthId: 5,farmerId: 5,
        requestData: requestData);
    String jsonRequestData = jsonEncode(response);
    context.read<DdeFarmerCubit>().updateCowBreedRecordApi(context, jsonRequestData);

    /*Map<String,dynamic> jsonData = HashMap();

    List<String> aaa = ["1","2","3"];
    List<Map<String,dynamic>> requestData = [];

    for (var element in aaa) {
      Map<String,dynamic> data = HashMap();
      data.addAll({
        "id": element,
        "heard_size":"",
        "milking_cows":"",
        "dry_cows":"",
        "heifer_cows":"",
        "seven_to_twelve_month_cows":"",
        "six_month_cow":"",
        "bull_calfs":"",
        "yield_per_cow":"",
        "cow_breed_id":"",
      });
      requestData.add(data);
    }

    // print(requestData);

    jsonData.addAll(
        {
          "month_id":"",
          "farmer_id": "",
          "requestData": requestData
        });

    print(jsonData);*/

  }

  //////////AddMoreButton////////////////
  Widget addMore(bool add, int index,List<MonthWiseData> responseMonthWiseData) {
    return Column(
      children: [
        50.verticalSpace(),
        customButton('+ Add More',
            height: 60,
            width: 200,
            onTap: () {
              responseMonthWiseData.insert(0, MonthWiseData());
              setState((){});
            },
            color: 0xffFFFFFF,
            borderColor: 0xff6A0030,
            fontColor: 0xff6A0030),
      ],
    );
  }

  //////////AddMoreBreedDateWise////////////////
  Widget addMoreDateWiseData(bool add, int index,List<dynamic> responseDateWiseData) {
    return Column(
      children: [
        0.verticalSpace(),
        customButton('+ Add Mores',
            height: 50,
            width: 130,
            onTap: () {
              responseDateWiseData.insert(0, DateWiseData());
              checkAddMore = true;
              setState((){});
            },
            color: 0xffFFFFFF,
            borderColor: 0xff6A0030,
            fontColor: 0xff6A0030),
      ],
    );
  }

///////////AddMoreCard////////////
  Widget addMoreCard(MonthWiseData responseMonthWise,List<MonthWiseData> monthWise,int i) {

    suppliedToPdfController = TextEditingController(text: responseMonthWise.suppliedToPdfl.toString());
    suppliedToOtherPdfController = TextEditingController(text: responseMonthWise.suppliedToOthers.toString());
    selfUseController = TextEditingController(text: responseMonthWise.selfUse.toString());

    return InkWell(
      onTap: () {
      },
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // showQty[i] ? const Text('onClick') : Container(width: 45,height: 45,color: Colors.black,),
          10.verticalSpace(),
          Padding(
            padding: const EdgeInsets.fromLTRB(10, 0, 13, 0),
            child: Column(
              children: [
                Stack(
                  children: [
                    SizedBox(
                      // height: 150,
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
                            child: InkWell(
                              child: Card(
                                margin: 0.marginAll(),
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(20)),
                                color: Colors.white,
                                child: Column(children: [
                                  Container(
                                    decoration: const BoxDecoration(
                                        borderRadius: BorderRadius.only(topRight: Radius.circular(20),topLeft: Radius.circular(20)),
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
                                                    '${responseMonthWise.monthname??"0"}, ${responseMonthWise.year??"0"}',
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

                                                  SvgPicture.asset(
                                                    Images.less1,
                                                    height:40,
                                                    width: 40,
                                                  ),

                                                  10.horizontalSpace(),

                                                  InkWell(
                                                    onTap: (){

                                                    },
                                                    child: SvgPicture.asset(
                                                      Images.deleteCows,
                                                      height: 40,
                                                      width: 40,
                                                    ),
                                                  )
                                                ],
                                              )
                                            ],
                                          ),
                                        ),
                                        10.verticalSpace(),
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
                                                        "${responseMonthWise.totalMilkProduction??"0"}",
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
                                                        '${responseMonthWise.totalMilkProduction??"0"} Ltr.',
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
                                                        responseMonthWise.milkingCow ?? "0",
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
                                                        '${responseMonthWise.yieldPerCow ?? "0"} Ltr.',
                                                        style: figtreeSemiBold
                                                            .copyWith(fontSize: 18),
                                                      ),
                                                      Text(
                                                        'Yield/day',
                                                        style: figtreeMedium
                                                            .copyWith(fontSize: 12),
                                                      )
                                                    ],
                                                  ),
                                                  05.horizontalSpace(),
                                                ],
                                              ),
                                            ],
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  addMoreDateWiseData(false,0,responseMonthWise.dateWiseData!=null?responseMonthWise.dateWiseData!:[]),
                                  ...getDateWiseData(responseMonthWise.dateWiseData != null ?responseMonthWise.dateWiseData!:[DateWiseData()],responseMonthWise),

                                  addMoreDateWiseData(false,0,responseMonthWise.dateWiseData!=null?responseMonthWise.dateWiseData!:[]),
                                  20.verticalSpace(),
                                  Container(
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
                                                        controller: suppliedToPdfController,
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
                                                        controller: suppliedToOtherPdfController,
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
                                                        controller: selfUseController,
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
                                          20.verticalSpace(),
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
                                                responseMonthWise.totalMilkProduction.toString(),
                                                style: figtreeBold
                                                    .copyWith(
                                                    fontSize:
                                                    16),
                                              ),
                                            ],
                                          ),
                                          05.verticalSpace(),
                                          const Divider(
                                            thickness: 1,
                                            color:
                                            ColorResources
                                                .grey,
                                          ),
                                          Row(
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
                                                  responseMonthWise.yieldPerCow.toString(),
                                                style: figtreeBold
                                                    .copyWith(
                                                    fontSize:
                                                    16),
                                              ),
                                            ],
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                  20.verticalSpace(),
                                ]),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    //////////Bottom Design///////
                    // Positioned(
                    //   bottom: 0,
                    //   right: 25,
                    //   left: 25,
                    //   child: SvgPicture.asset(Images.cardImage),
                    // )
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  ///////////AddMoreCard////////////
  Widget addDateWiseData(DateWiseData responseDateWise,List<DateWiseData> dateWise,int i,MonthWiseData dataMonth) {
    return InkWell(
      onTap: () {

      },
      child: ProductionTextField(i,responseDateWise,dateWise,dataMonth),
    );
  }

///////////SaveCancelButton////////////////////
  Widget saveCancelButton() {
    return Padding(
      padding: const EdgeInsets.fromLTRB(29, 40, 29, 0),
      child: Column(
        children: [
          // 40.verticalSpace(),
          customButton(
            'Save',
            style: figtreeMedium.copyWith(color: Colors.white, fontSize: 16),
            onTap: () {},
            width: screenWidth(),
            height: 60,
          ),
          15.verticalSpace(),
          customButton('Cancel',
              style: figtreeMedium.copyWith(fontSize: 16),
              onTap: () {},
              width: screenWidth(),
              height: 60,
              color: 0xffDCDCDC),
          20.verticalSpace(),
        ],
      ),
    );
  }

  Widget _addRemoveButton(bool add, int index){
    return InkWell(
      onTap: (){
        if(add){
          productionList.insert(0, "");
        }
        else {
          productionList.removeAt(index);
        }
        setState((){});
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

  List<Widget> _getProduction(List<MonthWiseData> responseMonthWiseData){
    List<Widget> friendsTextFieldsList = [];
    for(int i=0; i<responseMonthWiseData.length; i++){
      if(checkAddMore == false){
        print("checkAddMore");
        addBreedLength.clear();
        addBreedLength.addAll(responseMonthWiseData[i].dateWiseData!);
      }
      print("sss${responseMonthWiseData[i].dateWiseData!.length}dd ${addBreedLength.length}");
      friendsTextFieldsList.add(
          Column(
            children: [

              addMoreCard(responseMonthWiseData[i],responseMonthWiseData,i),

            ],
          )
      );
    }
    return friendsTextFieldsList;
  }


  List<Widget> getDateWiseData(List<DateWiseData> responseDateWise,MonthWiseData dataMonth){
    List<Widget> friendsTextFieldsList = [];
    productionList.clear();
    for(int i=0; i<responseDateWise.length; i++){
      productionList.clear();
      showQty.add(false);
      // productionList.add(responseDateWise.toString());
      friendsTextFieldsList.add(
          Column(
            children: [

              Container(
                decoration: const BoxDecoration(
                    borderRadius:
                    BorderRadius.only(
                        bottomLeft:
                        Radius.circular(
                            0),
                        bottomRight:
                        Radius.circular(
                            20)),
                    color: Colors.white
                ),
                child: Padding(
                  padding:
                  const EdgeInsets.fromLTRB(
                      20, 15, 20, 0),
                  child: addDateWiseData(responseDateWise[i],responseDateWise,i,dataMonth)
                ),
              ),
            ],
          )
      );
    }
    return friendsTextFieldsList;
  }

}

class ProductionTextField extends StatefulWidget {
  final int index;
  final DateWiseData responseDateWise;
  final MonthWiseData dataMonth;
  final List<DateWiseData> dataDateWise;
  const ProductionTextField(this.index,this.responseDateWise,this.dataDateWise,this.dataMonth, {super.key});

  @override
  State<ProductionTextField> createState() => _ProductionTextFieldState();
}

class _ProductionTextFieldState extends State<ProductionTextField> {
  bool? checkCurrentMonth;
  late TextEditingController _breedController;
  late TextEditingController _herdController;
  late TextEditingController _milkingCowController;
  late TextEditingController _yieldPerDayController;
  late TextEditingController _dryController;
  late TextEditingController _heiferController;
  late TextEditingController _sevenTwelveController;
  late TextEditingController _lessThanSixController;
  late TextEditingController _bullCalfController;

  void breedController(String addressController) {
    BlocProvider.of<DdeFarmerCubit>(context).emit(BlocProvider.of<DdeFarmerCubit>(context).state.copyWith(breedController: TextEditingController(text: addressController)));
  }

  void showHide(int i){
    setState((){
      showQty[i]=!showQty[i];
    });
  }

  @override
  void initState() {
    super.initState();

    // BlocProvider.of<DdeFarmerCubit>(context).state.breedController!.text = widget.responseDateWise.breedName.toString();
    // context.read<DdeFarmerCubit>().breedController(widget.responseDateWise.breedName.toString());
    // BlocProvider.of<DdeFarmerCubit>(context).state.copyWith(breedController: TextEditingController(text: widget.responseDateWise.breedName.toString()));
    // breedController(widget.responseDateWise.breedName.toString());
    checkCurrentMonth = checkDate(DateTime(int.parse(widget.dataMonth.year.toString()),int.parse(widget.dataMonth.month.toString())));
    _breedController = TextEditingController(text: widget.responseDateWise.breedName.toString());
    _herdController = TextEditingController(text: widget.responseDateWise.heardSize.toString());
    _milkingCowController = TextEditingController(text: widget.responseDateWise.milkingCows.toString());
    _yieldPerDayController = TextEditingController(text: widget.responseDateWise.yieldPerCow.toString());
    _dryController = TextEditingController(text: widget.responseDateWise.dryCows.toString());
    _heiferController = TextEditingController(text: widget.responseDateWise.heiferCows.toString());
    _sevenTwelveController = TextEditingController(text: widget.responseDateWise.sevenToTwelveMonthCows.toString());
    _lessThanSixController = TextEditingController(text: widget.responseDateWise.sixMonthCow.toString());
    _bullCalfController = TextEditingController(text: widget.responseDateWise.yieldPerCow.toString());

    CowsAndYieldsDDEFarmerState.requestData.addAll({RequestData(
        id: addBreedLength.length >=widget.index?widget.responseDateWise.id.toString():null,
        cowBreedId: widget.responseDateWise.cowBreedId,
        milkingCows: widget.responseDateWise.milkingCows,
        yieldPerCow: widget.responseDateWise.yieldPerCow,
        dryCows: widget.responseDateWise.dryCows,
        heardSize: widget.responseDateWise.heardSize.toString(),
        heiferCows: widget.responseDateWise.heiferCows,
        sevenToTwelveMonthCows: widget.responseDateWise.sevenToTwelveMonthCows,
        sixMonthCow: widget.responseDateWise.sixMonthCow,
        bullCalfs: "1",
    )});
  }
  @override
  void dispose() {
    _herdController.dispose();
    _breedController.dispose();
    _milkingCowController.dispose();
    _yieldPerDayController.dispose();
    _dryController.dispose();
    _heiferController.dispose();
    _sevenTwelveController.dispose();
    _lessThanSixController.dispose();
    _bullCalfController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {

    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      // BlocProvider.of<DdeFarmerCubit>(context).state.breedController!.text = CowsAndYieldsDDEFarmerState.requestData[widget.index].heardSize.toString()??"";
      _herdController.text = CowsAndYieldsDDEFarmerState.requestData[widget.index].heardSize.toString()??"";
      _yieldPerDayController.text = CowsAndYieldsDDEFarmerState.requestData[widget.index].yieldPerCow.toString() ?? "";
      _milkingCowController.text = CowsAndYieldsDDEFarmerState.requestData[widget.index].milkingCows.toString() ?? "";
      _dryController.text = CowsAndYieldsDDEFarmerState.requestData[widget.index].dryCows.toString() ?? "";
      _heiferController.text = CowsAndYieldsDDEFarmerState.requestData[widget.index].heiferCows.toString() ?? "";
      _sevenTwelveController.text = CowsAndYieldsDDEFarmerState.requestData[widget.index].sevenToTwelveMonthCows.toString() ?? "";
      _lessThanSixController.text = CowsAndYieldsDDEFarmerState.requestData[widget.index].sixMonthCow.toString() ?? "";
      _bullCalfController.text = CowsAndYieldsDDEFarmerState.requestData[widget.index].bullCalfs.toString() ?? "";
    });

    return Column(
      children: [

        10.verticalSpace(),

        Row(
          children: [
            BlocBuilder<DdeFarmerCubit,DdeState>(
              builder: (context,state) {
                return Expanded(
                    child: InkWell(
                      onTap: (){
                        print('${addBreedLength.length} hhh ${widget.index}');
                        if(addBreedLength.length-1 >=widget.index){

                        }else{
                          customDialog(
                              widget: const BreedPicker());
                        }
                      },
                      child: SizedBox(
                          height: 65,
                          child: CustomTextField(
                            enabled: false,
                            image: addBreedLength.length-1 >=widget.index? null:Images.arrowDown,
                            imageColors: Colors.black,
                            controller: _breedController,
                            // controller: state.breedController,
                            // onChanged: (v) => CowsAndYieldsDDEFarmerState.productionList[widget.index] = v,
                            hint:'Breed Name',
                          )),
                    ));
              }
            ),
            10.horizontalSpace(),
            InkWell(
              onTap: (){
                showHide(widget.index);
              },
              child: Container(
                width: 45,
                height: 60,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(color: showQty[widget.index]? Colors.green : Colors.red,)
                ),
                child: Icon(
                  showQty[widget.index] ?  Icons.remove:Icons.add, color: Colors.black,
                ),
              ),
            ),
            10.horizontalSpace(),
            SvgPicture.asset(
                Images.deleteField)
          ],
        ),
        20.verticalSpace(),

        showQty[widget.index] ? Column(

          children: [
            Row(
              children: [
                Expanded(
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
                          controller: _herdController,
                          onChanged: (v) => CowsAndYieldsDDEFarmerState.requestData[widget.index].heardSize = v,
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
                          'Milking Cow',
                          style: figtreeSemiBold
                              .copyWith(
                              fontSize:
                              12),
                        ),
                        05.verticalSpace(),
                        CustomTextField(
                          hint: '',
                          controller: _milkingCowController,
                          onChanged: (v) => CowsAndYieldsDDEFarmerState.requestData[widget.index].milkingCows = v,
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
            20.verticalSpace(),
            Row(
              children: [
                Expanded(
                    child:
                    Column(
                      crossAxisAlignment:
                      CrossAxisAlignment
                          .start,
                      children: [
                        Text(
                          'Yield (Ltr./Day)',
                          style: figtreeSemiBold
                              .copyWith(
                              fontSize:
                              12),
                        ),
                        05.verticalSpace(),
                        CustomTextField(
                          hint: '',
                          controller: _yieldPerDayController,
                          onChanged: (v) => CowsAndYieldsDDEFarmerState.requestData[widget.index].yieldPerCow = v,
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
                          'Dry',
                          style: figtreeSemiBold
                              .copyWith(
                              fontSize:
                              12),
                        ),
                        05.verticalSpace(),
                        CustomTextField(
                          hint: '',
                          paddingTop: 5,
                          controller: _dryController,
                          onChanged: (v) => CowsAndYieldsDDEFarmerState.requestData[widget.index].dryCows = v,
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
                          'Heifer',
                          style: figtreeSemiBold
                              .copyWith(
                              fontSize:
                              12),
                        ),
                        05.verticalSpace(),
                        CustomTextField(
                          hint: '',
                          paddingTop: 5,
                          controller: _heiferController,
                          onChanged: (v) => CowsAndYieldsDDEFarmerState.requestData[widget.index].heiferCows = v,
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
            20.verticalSpace(),
            Row(
              children: [
                Expanded(
                    child:
                    Column(
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
                          controller: _sevenTwelveController,
                          onChanged: (v) => CowsAndYieldsDDEFarmerState.requestData[widget.index].sevenToTwelveMonthCows = v,
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
                          '<6 mo',
                          style: figtreeSemiBold
                              .copyWith(
                              fontSize:
                              12),
                        ),
                        05.verticalSpace(),
                        CustomTextField(
                          hint: '',
                          paddingTop: 5,
                          controller: _lessThanSixController,
                          onChanged: (v) => CowsAndYieldsDDEFarmerState.requestData[widget.index].sixMonthCow = v,
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
                          'Bull Calf',
                          style: figtreeSemiBold
                              .copyWith(
                              fontSize:
                              12),
                        ),
                        05.verticalSpace(),
                        CustomTextField(
                          hint: '',
                          controller: _bullCalfController,
                          onChanged: (v) => CowsAndYieldsDDEFarmerState.requestData[widget.index].bullCalfs = v,
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
            10.verticalSpace(),
          ],
        ) : Visibility(visible: false,child: Container(width: 35,height: 35,color: Colors.black,)),
        widget.index == widget.dataDateWise.length-1 ? 15.verticalSpace() :const Divider(
          thickness: 1,
          color:
          ColorResources.grey,
        )
      ],
    );
  }
}





