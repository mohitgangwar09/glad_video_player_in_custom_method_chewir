import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:glad/cubit/cowsandyieldsum/cowsandyieldcubit.dart';
import 'package:glad/cubit/dde_farmer_cubit/dde_farmer_cubit.dart';
import 'package:glad/data/model/response_cow_breed_details.dart';
import 'package:glad/data/model/update_record_breed_model.dart';
import 'package:glad/screen/custom_widget/custom_methods.dart';
import 'package:glad/screen/custom_widget/custom_textfield.dart';
import 'package:glad/screen/dialog/breed_picker.dart';
import 'package:glad/screen/extra_screen/profile_navigate.dart';
import 'package:glad/screen/extra_screen/test_cubit_yield.dart';
import 'package:glad/utils/color_resources.dart';
import 'package:glad/utils/extension.dart';
import 'package:glad/utils/helper.dart';
import 'package:glad/utils/images.dart';
import 'package:glad/utils/styles.dart';

class TestCowAndYield extends StatefulWidget {
  const TestCowAndYield({super.key});

  @override
  TestCowAndYieldState createState() => TestCowAndYieldState();
}

class TestCowAndYieldState extends State<TestCowAndYield> {
  final _formKey = GlobalKey<FormState>();

  static List<String> productionList = [""];
  List<String> addMonthId = [];
  // static List<RequestData> requestData = [];
  static List<DateWiseData> requestData = [];
  static List<DateWiseData> responseData = [];
  static bool addMonth = false;

  @override
  void initState() {
    super.initState();
    SchedulerBinding.instance.addPostFrameCallback((_) {
      BlocProvider.of<CowsAndYieldCubitTest>(context).emit(TestYieldState.initial());
      BlocProvider.of<CowsAndYieldCubitTest>(context).getCowBreedDetailsApi(context,"");
      // BlocProvider.of<CowsAndYieldCubit>(context).showMonth(0,MonthWiseData());
    });
  }



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[200],
      appBar: AppBar(title: const Text('Cows And Yield'),),
      body: Form(
        key: _formKey,
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [

              addMore(BlocProvider.of<CowsAndYieldCubitTest>(context).state.initialIndex == BlocProvider.of<CowsAndYieldCubit>(context).state.responseMonthlyWiseData!.length-1, BlocProvider.of<CowsAndYieldCubit>(context).state.initialIndex!,BlocProvider.of<CowsAndYieldCubit>(context).state.responseMonthlyWiseData!),

              Expanded(
                child: SingleChildScrollView(
                  child: BlocBuilder<CowsAndYieldCubitTest,TestYieldState>(
                      builder: (context,state) {
                        if(state.responseMonthlyWiseData!.isNotEmpty){
                          return customList(list: state.responseMonthlyWiseData!,child: (index) {
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
                                                  child: Card(
                                                    margin: 0.marginAll(),
                                                    shape: RoundedRectangleBorder(
                                                        borderRadius: BorderRadius.circular(20)),
                                                    color: Colors.white,
                                                    child:Column(children: [

                                                      InkWell(
                                                        onTap: (){
                                                          context.read<CowsAndYieldCubitTest>().showMonth(index,state.responseMonthlyWiseData![index]);
                                                        },
                                                        child: Container(
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

                                                                        SvgPicture.asset(
                                                                          Images.less1,
                                                                          height:40,
                                                                          width: 40,
                                                                        ),

                                                                        10.horizontalSpace(),


                                                                        InkWell(
                                                                          onTap: (){
                                                                            // BlocProvider.of<DdeFarmerCubit>(context).deleteMonthId(context, responseMonthWise.monthname.toString().capitalized(),responseMonthWise.farmerId.toString());
                                                                          },
                                                                          child: SvgPicture.asset(
                                                                            Images.deleteCows,
                                                                            height: 40,
                                                                            width: 40,
                                                                          ),
                                                                        )
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
                                                                              "200",
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
                                                                              "22",
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
                                                                              "20",
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
                                                                              state.responseMonthlyWiseData![index].yieldPerCow.toString(),
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
                                                                              "22",
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
                                                                              state.responseMonthlyWiseData![index].yieldPerCow.toString(),
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
                                                              )
                                                            ],
                                                          ),
                                                        ),
                                                      ),

                                                      //// breed Ui
                                                      index>0?
                                                      customList(
                                                          list: state.responseMonthlyWiseData![index].dateWiseData!,
                                                          child: (childIndex){
                                                            return Column(
                                                              children: [

                                                                Row(
                                                                  children: [
                                                                    Expanded(
                                                                        child: InkWell(
                                                                          onTap: (){

                                                                          },
                                                                          child: const SizedBox(
                                                                              height: 65,
                                                                              child: CustomTextField(
                                                                                enabled: false,
                                                                                // image: addBreedLength.length-1 >=widget.index? null:Images.arrowDown,
                                                                                imageColors: Colors.black,
                                                                                hint:'Breed Name',
                                                                              )),
                                                                        )),

                                                                    10.horizontalSpace(),

                                                                    InkWell(
                                                                      onTap: (){
                                                                      },
                                                                      child: Container(
                                                                        width: 45,
                                                                        height: 60,
                                                                        decoration: BoxDecoration(
                                                                            borderRadius: BorderRadius.circular(8),
                                                                            border: Border.all(color: Colors.red,)
                                                                        ),
                                                                        child: const Icon(
                                                                          Icons.remove, color: Colors.black,
                                                                          // Icons.remove:Icons.add, color: Colors.black,
                                                                        ),
                                                                      ),
                                                                    ),

                                                                    10.horizontalSpace(),

                                                                    InkWell(
                                                                      onTap: (){

                                                                      },
                                                                      child: SvgPicture.asset(
                                                                          Images.deleteField),
                                                                    )
                                                                  ],
                                                                ),

                                                                greaterThanZero()
                                                                // firstMonthCalculation(state.responseMonthlyWiseData![index].dateWiseData!,childIndex)

                                                              ],
                                                            );
                                                          }
                                                      ):Column(
                                                        children: [
                                                          ...getDateWiseData(state.responseMonthlyWiseData![0].dateWiseData!)
                                                        ],
                                                      ),

                                                      index > 0 ? const SizedBox(width: 0,height: 0,) :
                                                      addMoreDateWiseData(false,0,state.responseMonthlyWiseData![index].dateWiseData!)

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
                ),
              ),


              TextButton(
                onPressed: () {
                  // if(_formKey.currentState.validate()){
                  _formKey.currentState?.save();
                  /*UpdateRecordMonthBreedModel response =
                  UpdateRecordMonthBreedModel(monthId: 5,farmerId: 5,
                      requestData: requestData);
                  // print(object)
                  String jsonRequestData = jsonEncode(response);
                  print(jsonRequestData);*/

                  // print(response.requestData[response.requestData.length-1].milkingCows);

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


  Widget greaterThanZero(){
    return Column(
      children: [
        Row(
          children: [
            Expanded(child: breedTile(title: "Herd", value: 0)),

            Expanded(child: breedTile(title: "Miking Cow", value: 0)),

          ],
        )
      ],
    );
  }


  Widget breedTile({required String title,required int value}){
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

              setState(() {

                responseData.add(DateWiseData(id: null,milkingCows: "0",
                    yieldPerCow: "0",dryCows: "0",heiferCows: "0",sevenToTwelveMonthCows: "0",sixMonthCow: "0"));

                BlocProvider.of<CowsAndYieldCubitTest>(context).allController("0");
              });


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
            height: 60,
            width: 200,
            onTap: () {
              if(responseMonthWiseData.isNotEmpty){
                // if(checkDateMonth(responseMonthWiseData[0].year,(responseMonthWiseData[0].month+1))){

                BlocProvider.of<CowsAndYieldCubitTest>(context).addMonthApi(context,responseMonthWiseData.last.farmerId.toString(),"month");

                // }else{
                showCustomToast(context, "Month already exist");
                // }
              }else{
                BlocProvider.of<CowsAndYieldCubitTest>(context).addMonthApi(context,"5","month");
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
          requestData.removeAt(index);
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

  List<Widget> getDateWiseData(List<DateWiseData> responseDateWis,){
    List<Widget> friendsTextFieldsList = [];
    for(int i=0; i<responseData.length; i++){
      friendsTextFieldsList.add(
          Column(
            children: [
              ProductionTextField(i,responseData[i],requestData),
              addRemoveButton(i == responseData.length-1, i),
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

  const ProductionTextField(this.index,this.responseDateWise, this.dateWiseDate, {super.key});

  @override
  State<ProductionTextField> createState() => _ProductionTextFieldState();
}

class _ProductionTextFieldState extends State<ProductionTextField> {

  @override
  void initState() {
    super.initState();

    TestCowAndYieldState.responseData.add(DateWiseData(
      id: widget.responseDateWise.id.toString(),
      cowBreedId: widget.responseDateWise.cowBreedId,
      milkingCows: widget.responseDateWise.milkingCows,
      yieldPerCow: widget.responseDateWise.yieldPerCow,
      dryCows: widget.responseDateWise.dryCows,
      heardSize: widget.responseDateWise.heardSize.toString(),
      heiferCows: widget.responseDateWise.heiferCows,
      sevenToTwelveMonthCows: widget.responseDateWise.sevenToTwelveMonthCows,
      sixMonthCow: widget.responseDateWise.sixMonthCow,
    ));

  }

  @override
  Widget build(BuildContext context) {

    return BlocBuilder<CowsAndYieldCubitTest,TestYieldState>(
        builder: (context,state) {
          return Column(
            children: [

              Column(
                children: [
                  10.verticalSpace(),

                  Row(
                    children: [
                      Expanded(
                          child: InkWell(
                            onTap: (){
                              if(addBreedLength.length-1 >=widget.index){

                              }else{
                                customDialog(
                                    widget: BreedPicker(index: widget.index,));
                              }
                            },
                            child: SizedBox(
                                height: 65,
                                child: CustomTextField(
                                  enabled: false,
                                  image: addBreedLength.length-1 >=widget.index? null:Images.arrowDown,
                                  imageColors: Colors.black,
                                  // controller: _breedController,
                                  hint:'Breed Name',
                                )),
                          )),
                      10.horizontalSpace(),
                      InkWell(
                        onTap: (){
                        },
                        child: Container(
                          width: 45,
                          height: 60,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(8),
                              border: Border.all(color:  Colors.green)
                          ),
                          child: const Icon(
                            Icons.add, color: Colors.black,
                            // showQty[widget.index] ?  Icons.remove:Icons.add, color: Colors.black,
                          ),
                        ),
                      ),
                      10.horizontalSpace(),


                      InkWell(
                        onTap: (){
                          setState((){

                            if(addBreedLength.length-1 >=widget.index){

                            }else{
                              // widget.dateWiseDate.removeAt(widget.index);
                              // TestCowAndYieldState.responseDateWiseData.removeAt(widget.index);
                              // TestCowAndYieldState.requestData.removeAt(widget.index);
                              print("index${widget.index}");
                            }
                          });
                        },
                        child: SvgPicture.asset(
                            Images.deleteField),
                      )
                    ],
                  ),

                  20.verticalSpace(),
                ],
              ),

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
                                enabled: false,
                                onChanged: (v) => TestCowAndYieldState.requestData[widget.index].heardSize = v,
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
                                onChanged: (v){

                                  TestCowAndYieldState.requestData[widget.index].milkingCows = v;
                                  context.read<CowsAndYieldCubitTest>().totalMilkingCow(widget.index);

                                  },
                                controller: state.milkingCowController[widget.index],
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
                                onChanged: (v) => TestCowAndYieldState.requestData[widget.index].yieldPerCow = v,
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
                                onChanged: (v) => TestCowAndYieldState.requestData[widget.index].dryCows = v,
                                controller: state.dryController[widget.index],
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
                                'Heifer',
                                style: figtreeSemiBold
                                    .copyWith(
                                    fontSize:
                                    12),
                              ),
                              05.verticalSpace(),
                              CustomTextField(
                                hint: '',
                                onChanged: (v) => TestCowAndYieldState.requestData[widget.index].heiferCows = v,
                                controller: state.heiferController[widget.index],
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
                                onChanged: (v) => TestCowAndYieldState.requestData[widget.index].sevenToTwelveMonthCows = v,
                                controller: state.sevenTwelveMonthController[widget.index],
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
                                onChanged: (v) => TestCowAndYieldState.requestData[widget.index].sixMonthCow = v,
                                controller: state.lessthanSixMonthController[widget.index],
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
                                'Bull Calf',
                                style: figtreeSemiBold
                                    .copyWith(
                                    fontSize:
                                    12),
                              ),
                              05.verticalSpace(),
                              CustomTextField(
                                hint: '',
                                // onChanged: (v) => TestCowAndYieldState.requestData[widget.index].bullCalfs = v,
                                controller: state.bullCalfController[widget.index],
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
                ],
              ),
            ],
          );
        }
    );
  }
}