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
import 'package:glad/utils/color_resources.dart';
import 'package:glad/utils/extension.dart';
import 'package:glad/utils/helper.dart';
import 'package:glad/utils/images.dart';
import 'package:glad/utils/styles.dart';

class CowsAndYieldsDDEFarmer extends StatefulWidget {
  const CowsAndYieldsDDEFarmer({super.key});

  @override
  CowsAndYieldsDDEFarmerState createState() => CowsAndYieldsDDEFarmerState();
}

class CowsAndYieldsDDEFarmerState extends State<CowsAndYieldsDDEFarmer> {
  final _formKey = GlobalKey<FormState>();
  late TextEditingController _nameController;
  static List<String> productionList = [];
  int newIndex = 0;

  @override
  void initState() {
    super.initState();
    SchedulerBinding.instance.addPostFrameCallback((_) {
      BlocProvider.of<DdeFarmerCubit>(context).getCowBreedDetailsApi(context);
    });
    // _nameController = TextEditingController();
  }

  @override
  void dispose() {
    // _nameController.dispose();
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
                        print(productionList);

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

  Future addCowAndYield() async {

    Map<String,dynamic> jsonData = HashMap();

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

    print(jsonData);

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
        50.verticalSpace(),
        customButton('+ Add More',
            height: 50,
            width: 130,
            onTap: () {
              responseDateWiseData.insert(0, DateWiseData());
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

    return InkWell(
      onTap: () {
      },
      child: Column(
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
                      // height: 150,
                      child: Column(
                        children: [
                          Container(
                            width: screenWidth(),
                            decoration: BoxDecoration(boxShadow: [
                              BoxShadow(
                                  color: Colors.grey.withOpacity(.100),
                                  blurRadius: 15),
                            ]),
                            child: InkWell(
                              child: Card(
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(20)),
                                color: const Color(0xffFFB300),
                                child: Column(children: [
                                  Column(
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
                                                      "23",
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


                                  ...getDateWiseData(responseMonthWise.dateWiseData != null ?responseMonthWise.dateWiseData!:[DateWiseData()],responseMonthWise),

                                  addMoreDateWiseData(false,0,responseMonthWise.dateWiseData!=null?responseMonthWise.dateWiseData!:[]),
                                  20.verticalSpace(),
                                  Container(
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
                                                      const CustomTextField(
                                                        hint: '',
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
                                                      const CustomTextField(
                                                        hint: '',
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
                                                      const CustomTextField(
                                                        hint: '',
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
                                                '3800',
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
                                                '7.9',
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
      // productionList.add(responseDateWise.toString());
      friendsTextFieldsList.add(
          Column(
            children: [

              Visibility(
                visible: true,
                child: Container(
                  decoration: BoxDecoration(
                      borderRadius:
                      const BorderRadius.only(
                          bottomLeft:
                          Radius.circular(
                              20),
                          bottomRight:
                          Radius.circular(
                              20)),
                      border: Border.all(
                          width: 1,
                          color: ColorResources
                              .mustard),
                      color: Colors.white),
                  child: Padding(
                    padding:
                    const EdgeInsets.fromLTRB(
                        20, 15, 20, 0),
                    child: addDateWiseData(responseDateWise[i],responseDateWise,i,dataMonth),
                  ),
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
  @override
  void initState() {
    super.initState();
    checkCurrentMonth = checkDate(DateTime(int.parse(widget.dataMonth.year.toString()),int.parse(widget.dataMonth.month.toString())));
    print(checkCurrentMonth);
    _breedController = TextEditingController(text: widget.responseDateWise.breedName.toString());
    _herdController = TextEditingController(text: widget.responseDateWise.heardSize.toString());
    _milkingCowController = TextEditingController(text: widget.responseDateWise.milkingCows.toString());
    _yieldPerDayController = TextEditingController(text: widget.responseDateWise.yieldPerCow.toString());
    _dryController = TextEditingController(text: widget.responseDateWise.dryCows.toString());
    _heiferController = TextEditingController(text: widget.responseDateWise.heiferCows.toString());
    _sevenTwelveController = TextEditingController(text: widget.responseDateWise.sevenToTwelveMonthCows.toString());
    _lessThanSixController = TextEditingController(text: widget.responseDateWise.sixMonthCow.toString());
    _bullCalfController = TextEditingController(text: widget.responseDateWise.yieldPerCow.toString());
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
      // _herdController.text = CowsAndYieldsDDEFarmerState.productionList[widget.index]
      //     ?? "";
      // _milkingCowController.text = CowsAndYieldsDDEFarmerState.productionList[widget.index]
      //     ?? "";
    });

    return Column(
      children: [

        10.verticalSpace(),
        Row(
          children: [
            Expanded(
                child: SizedBox(
                    height: 65,
                    child: CustomTextField(
                      controller: _breedController,
                      onChanged: (v) => CowsAndYieldsDDEFarmerState.productionList[widget.index] = v,
                      hint:'Breed Name',
                    ))),
            10.horizontalSpace(),
            SvgPicture.asset(
                Images.addCows),
            10.horizontalSpace(),
            SvgPicture.asset(
                Images.deleteField)
          ],
        ),
        20.verticalSpace(),

        Column(

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
                          // enabled: checkCurrentMonth == true? false:true,
                          // onChanged: (v) => CowsAndYieldsDDEFarmerState.productionList[widget.index] = v,
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
                          onChanged: (v) => CowsAndYieldsDDEFarmerState.productionList[widget.index] = v,
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
                          onChanged: (v) => CowsAndYieldsDDEFarmerState.productionList[widget.index] = v,
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
                          onChanged: (v) => CowsAndYieldsDDEFarmerState.productionList[widget.index] = v,
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
                          onChanged: (v) => CowsAndYieldsDDEFarmerState.productionList[widget.index] = v,
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
                          onChanged: (v) => CowsAndYieldsDDEFarmerState.productionList[widget.index] = v,
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
                          onChanged: (v) => CowsAndYieldsDDEFarmerState.productionList[widget.index] = v,
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
                          onChanged: (v) => CowsAndYieldsDDEFarmerState.productionList[widget.index] = v,
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
            const Divider(
              thickness: 1,
              color:
              ColorResources.grey,
            ),
            10.verticalSpace(),
          ],
        ),
      ],
    );
  }
}





