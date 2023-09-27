import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:glad/cubit/cowsandyieldsum/cowsandyieldcubit.dart';
import 'package:glad/cubit/dde_farmer_cubit/dde_farmer_cubit.dart';
import 'package:glad/cubit/dde_enquiry_cubit/dde_enquiry_cubit.dart';
import 'package:glad/data/model/model_total_production.dart';
import 'package:glad/data/model/response_cow_breed_details.dart';
import 'package:glad/data/model/update_record_breed_model.dart';
import 'package:glad/screen/custom_widget/custom_appbar.dart';
import 'package:glad/screen/custom_widget/custom_methods.dart';
import 'package:glad/screen/custom_widget/custom_textfield.dart';
import 'package:glad/screen/dialog/breed_picker.dart';
import 'package:glad/screen/extra_screen/profile_navigate.dart';
import 'package:glad/utils/color_resources.dart';
import 'package:glad/utils/extension.dart';
import 'package:glad/utils/helper.dart';
import 'package:glad/utils/images.dart';
import 'package:glad/utils/styles.dart';

class CowsAndYieldsSum extends StatefulWidget {
  const CowsAndYieldsSum({super.key});

  @override
  CowsAndYieldsSumState createState() => CowsAndYieldsSumState();
}

class CowsAndYieldsSumState extends State<CowsAndYieldsSum> {
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


  void showHide(int i){
    setState((){
      showQty[i]=!showQty[i];
    });
  }

  @override
  void initState() {
    super.initState();
    SchedulerBinding.instance.addPostFrameCallback((_) {
      BlocProvider.of<CowsAndYieldCubit>(context).emit(CowsAndCubitState.initial());
      BlocProvider.of<CowsAndYieldCubit>(context).getCowBreedDetailsApi(context,"",id: '1847');
      BlocProvider.of<DdeFarmerCubit>(context).getBreedListApi(context);
      // context.read<CowsAndYieldCubit>().addRequestData();
      // BlocProvider.of<CowsAndYieldCubit>(context).showMonth(0,MonthWiseData());
    });
  }



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[200],
      body: Form(
        key: _formKey,
        child: Padding(
          padding: const EdgeInsets.all(1.0),
          child: Column(
            children: [

              CustomAppBar(
                context: context,
                titleText1: 'Cows and Yield',
                leading: arrowBackButton(),
                centerTitle: true,
                description: 'Provide the following details',
                action: TextButton(
                  onPressed: () {},
                  child: Text(
                    'Save',
                    style: figtreeMedium.copyWith(
                        fontSize: 14, color: ColorResources.maroon),
                  ),
                ),
                titleText1Style:
                figtreeMedium.copyWith(fontSize: 20, color: Colors.black),
              ),

              addMore(BlocProvider.of<CowsAndYieldCubit>(context).state.initialIndex == BlocProvider.of<CowsAndYieldCubit>(context).state.responseMonthlyWiseData!.length-1, BlocProvider.of<CowsAndYieldCubit>(context).state.initialIndex!,BlocProvider.of<CowsAndYieldCubit>(context).state.responseMonthlyWiseData!),

              Expanded(
                child: SingleChildScrollView(
                  child: BlocBuilder<CowsAndYieldCubit,CowsAndCubitState>(
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

                                                        context.read<CowsAndYieldCubit>().showMonth(index,state.responseMonthlyWiseData![index]);

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

                                                                      state.responseMonthlyWiseData![index].id == state.monthId?
                                                                      SvgPicture.asset(
                                                                        Images.less1,
                                                                        height:40,
                                                                        width: 40,
                                                                      ):SvgPicture.asset(
                                                                        Images.add,
                                                                        height:40,
                                                                        width: 40,
                                                                      ),

                                                                      10.horizontalSpace(),


                                                                      index>0?const SizedBox(width: 0,height: 0,):
                                                                      InkWell(
                                                                        onTap: (){
                                                                          // BlocProvider.of<DdeFarmerCubit>(context).deleteMonthId(context, responseMonthWise.monthname.toString().capitalized(),responseMonthWise.farmerId.toString());
                                                                        },
                                                                        child: SvgPicture.asset(
                                                                          Images.deleteCows,
                                                                          height: 40,
                                                                          width: 40,
                                                                        ),
                                                                      ),

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
                                                                            'Herd Size',
                                                                            style: figtreeMedium
                                                                                .copyWith(fontSize: 12),
                                                                          ),

                                                                          Text(
                                                                              state.responseMonthlyWiseData![index].totalHerdSize!=null?state.responseMonthlyWiseData![index].totalHerdSize!.toString():"",
                                                                            style: figtreeSemiBold
                                                                                .copyWith(fontSize: 18),
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
                                                                            'Production',
                                                                            style: figtreeMedium
                                                                                .copyWith(fontSize: 12),
                                                                          ),

                                                                          Text(
                                                                            state.responseMonthlyWiseData![index].totalMilkProduction!=null?state.responseMonthlyWiseData![index].totalMilkProduction!.toString():"0",
                                                                            style: figtreeSemiBold
                                                                                .copyWith(fontSize: 18),
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
                                                                            'Milking Cows',
                                                                            style: figtreeMedium
                                                                                .copyWith(fontSize: 12),
                                                                          ),
                                                                          Text(
                                                                            state.responseMonthlyWiseData![index].milkingCow!=null?state.responseMonthlyWiseData![index].milkingCow!.toString():"0",
                                                                            style: figtreeSemiBold
                                                                                .copyWith(fontSize: 18),
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
                                                                            'Yield/day',
                                                                            style: figtreeMedium
                                                                                .copyWith(fontSize: 12),
                                                                          ),
                                                                          Text(
                                                                            state.responseMonthlyWiseData![index].yieldPerCow!=null?state.responseMonthlyWiseData![index].yieldPerCow!.toString():"0",
                                                                            style: figtreeSemiBold
                                                                                .copyWith(fontSize: 18),
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
                                                                            state.totalProduction.toString(),
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
                                                                            state.yieldPerDay.toStringAsFixed(2),
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
                                                    index>0?state.responseMonthlyWiseData![index].id == state.monthId?
                                                    customList(
                                                      padding: const EdgeInsets.only(left: 15,right: 15,top: 10,bottom: 10),
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

                                                              ],
                                                            ),

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
                                                                          state.responseMonthlyWiseData![index].totalMilkProduction!=null?state.responseMonthlyWiseData![index].totalMilkProduction.toString():"",
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
                                                                          state.responseMonthlyWiseData![index].yieldPerCow!=null?double.parse(state.responseMonthlyWiseData![index].yieldPerCow!.toString()).toStringAsFixed(2):"",
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
                                                            )

                                                          ],
                                                        );
                                                      }
                                                    ):const SizedBox(width: 0,height: 0,):
                                                    state.responseMonthlyWiseData![index].id == state.monthId?
                                                    checkClickMonth == false ?Padding(
                                                      padding: const EdgeInsets.only(left: 17,right: 17),
                                                      child: Column(
                                                        children: [
                                                          ...getDateWiseData(state.responseMonthlyWiseData![0].dateWiseData!)
                                                        ],
                                                      ),
                                                    ):const SizedBox(width: 0,height: 0,):const SizedBox(width: 0,height: 0,),
                                                    
                                                    index > 0 ? const SizedBox(width: 0,height: 0,) :
                                                    state.responseMonthlyWiseData![index].id == state.monthId?
                                                    checkClickMonth == false ?
                                                    Column(
                                                      children: [
                                                        20.verticalSpace(),
                                                        addMoreDateWiseData(false,0,state.responseMonthlyWiseData![index].dateWiseData!),

                                                        20.verticalSpace(),
                                                        TotalProductionTextField(0, state.responseMonthlyWiseData![index], state.responseMonthlyWiseData!),
                                                        20.verticalSpace(),

                                                      ],
                                                    ):const Text("dd"):const SizedBox(width: 0,height: 0,),

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

              saveCancelButton(),

            ],
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

              _formKey.currentState?.save();

              UpdateRecordMonthBreedModel response =
              UpdateRecordMonthBreedModel(monthId: 3605,farmerId: 5,
                  requestData: requestData);
              String jsonRequestData = jsonEncode(response);

              BlocProvider.of<CowsAndYieldCubit>(context).updateCowBreedRecordApi(context, jsonRequestData);

            },
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


  Widget greaterThanZero(DateWiseData responseDateWise){
    return Column(
      children: [
        Row(
          children: [
            Expanded(child: breedTile(title: "Herd", value: responseDateWise.heardSize.toString())),

            10.horizontalSpace(),

            Expanded(child: breedTile(title: "Miking Cow", value: responseDateWise.milkingCows.toString())),

          ],
        ),
        10.verticalSpace(),
        Row(
          children: [
            Expanded(child: breedTile(title: "Yield (Ltr./day)", value: responseDateWise.yieldPerCow.toString())),

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

            Expanded(child: breedTile(title: "Bull Calf", value: '0')),

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
                  BlocProvider.of<CowsAndYieldCubit>(context).addRequestData(index,"addMore");
                  BlocProvider.of<CowsAndYieldCubit>(context).allController("0");
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
            height: 60,
            width: 200,
            onTap: () {
              if(responseMonthWiseData.isNotEmpty){
                // if(checkDateMonth(responseMonthWiseData[0].year,(responseMonthWiseData[0].month+1))){

                  BlocProvider.of<CowsAndYieldCubit>(context).addMonthApi(context,responseMonthWiseData.last.farmerId.toString(),"month");

                // }else{
                  showCustomToast(context, "Month already exist");
                // }
              }else{
                BlocProvider.of<CowsAndYieldCubit>(context).addMonthApi(context,"5","month");
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
          BlocProvider.of<CowsAndYieldCubit>(context).removeControllerValue(index);
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
    return BlocBuilder<CowsAndYieldCubit,CowsAndCubitState>(
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
                            image: addBreedLength[index] == true? null:Images.arrowDown,
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
                      showQty[index] ?  Icons.remove:Icons.add, color: Colors.black,
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
                        BlocProvider.of<CowsAndYieldCubit>(context).removeControllerValue(index);
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

  List<Widget> getDateWiseData(List<DateWiseData> responseDateWis,){
    List<Widget> friendsTextFieldsList = [];
    for(int i=0; i<responseDateWiseData.length; i++){

      print(showQty.length);

      friendsTextFieldsList.add(
          Column(
            children: [

              10.verticalSpace(),

              addBreedRemoveButton(i == responseDateWiseData.length-1, i),

              showQty[i] ?
              ProductionTextField(i,responseDateWiseData[i],responseDateWiseData):
              const Text("yes working"),
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

  const ProductionTextField(this.index,this.responseDateWise, this.dateWiseDate, {super.key});

  @override
  State<ProductionTextField> createState() => _ProductionTextFieldState();
}

class _ProductionTextFieldState extends State<ProductionTextField> {

  @override
  void initState() {
    super.initState();
    context.read<CowsAndYieldCubit>().totalMilkingCow(widget.index);
    context.read<CowsAndYieldCubit>().sumAllBreed(widget.index);
  }

  @override
  Widget build(BuildContext context) {

    return BlocBuilder<CowsAndYieldCubit,CowsAndCubitState>(
        builder: (context,state) {

          return Column(
            children: [

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
                                onChanged: (v) => CowsAndYieldsSumState.requestData[widget.index].heardSize = v,
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
                                  CowsAndYieldsSumState.requestData[widget.index].milkingCows = v;
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
                                onChanged: (v) => CowsAndYieldsSumState.requestData[widget.index].yieldPerCow = v,
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
                                onChanged: (v) => CowsAndYieldsSumState.requestData[widget.index].dryCows = v,
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
                                onChanged: (v) => CowsAndYieldsSumState.requestData[widget.index].heiferCows = v,
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
                                onChanged: (v) => CowsAndYieldsSumState.requestData[widget.index].sevenToTwelveMonthCows = v,
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
                                onChanged: (v) => CowsAndYieldsSumState.requestData[widget.index].sixMonthCow = v,
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
                                onChanged: (v) => CowsAndYieldsSumState.requestData[widget.index].bullCalfs = v,
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

  void showHide(int i){
    setState((){
      showQty[i]=!showQty[i];
    });
  }

  @override
  void initState() {
    super.initState();

    context.read<DdeFarmerCubit>().totalFirstProduction(0,widget.index);

    CowsAndYieldsSumState.modelTotalProduction.addAll({ModelTotalProduction(
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


    return BlocBuilder<CowsAndYieldCubit,CowsAndCubitState>(
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
                                  context.read<CowsAndYieldCubit>().totalFirstProduction(0,widget.index);
                                } ,
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
                                controller: state.suppliedToOtherPdfController,
                                paddingTop: 5,
                                onChanged: (v){
                                  context.read<CowsAndYieldCubit>().totalFirstProduction(0,widget.index);
                                } ,
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
                                controller: state.selfUseController,
                                paddingTop: 5,
                                onChanged: (v){
                                  context.read<CowsAndYieldCubit>().totalFirstProduction(0,widget.index);
                                } ,
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
                        state.totalProduction.toString(),
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
                          state.yieldPerDay.toStringAsFixed(2),
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
          );
        }
    );
  }
}
