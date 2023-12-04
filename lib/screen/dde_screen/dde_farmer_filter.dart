import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:glad/cubit/dde_farmer_cubit/dde_farmer_cubit.dart';
import 'package:glad/screen/custom_widget/custom_appbar.dart';
import 'package:glad/screen/custom_widget/custom_methods.dart';
import 'package:glad/utils/color_resources.dart';
import 'package:glad/utils/extension.dart';
import 'package:glad/utils/styles.dart';

class FilterDDEFarmer extends StatelessWidget {
  const FilterDDEFarmer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: BlocBuilder<DdeFarmerCubit,DdeState>(builder: (context, state) {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CustomAppBar(
                context: context,
                centerTitle: true,
                titleText1: 'Filters',
                titleText1Style: figtreeMedium.copyWith(fontSize: 20, color: Colors.black),
                leading: TextButton(
                    onPressed: () {
                      BlocProvider.of<DdeFarmerCubit>(context).breedFilterClear();
                      BlocProvider.of<DdeFarmerCubit>(context).getFarmer(context, '${BlocProvider.of<DdeFarmerCubit>(context).state.selectedRagRatingType}'.toLowerCase(), false);
                      pressBack();
                    },
                    child: "Cancel"
                        .textMedium(color: ColorResources.maroon, fontSize: 12)),
                action: TextButton(
                    onPressed: () {
                      BlocProvider.of<DdeFarmerCubit>(context).breedFilterClear();
                      BlocProvider.of<DdeFarmerCubit>(context).getFarmer(context, '${BlocProvider.of<DdeFarmerCubit>(context).state.selectedRagRatingType}'.toLowerCase(), false);
                      pressBack();
                    },
                    child: "Reset"
                        .textMedium(color: ColorResources.maroon, fontSize: 12)),
              ),
              Expanded(
                child: SingleChildScrollView(
                  child: Padding(
                    padding: const EdgeInsets.only(left: 18.0, right: 18, top: 31),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [

                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            "Milking Cows".textMedium(fontSize: 18),
                            "Numbers".textSemiBold(
                                fontSize: 12, color: const Color(0xff727272))
                          ],
                        ),

                        customProjectContainer(
                            marginLeft: 0,
                            marginTop: 8,
                            height: 124,
                            child: Row(
                              children: [
                                31.horizontalSpace(),
                                Expanded(
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      "From".textSemiBold(
                                        fontSize: 14,
                                      ),
                                      Container(
                                          margin: const EdgeInsets.only(top: 5),
                                          padding: const EdgeInsets.only(left: 10),
                                          decoration: boxDecoration(
                                              borderRadius: 10,
                                              borderColor: const Color(0xff767676)),
                                          height: 50,
                                          child: TextField(
                                            keyboardType: TextInputType.phone,
                                            maxLines: 1,
                                            maxLength: 12,
                                            controller: state.milkingCowFromController,
                                            inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                                            decoration: const InputDecoration(
                                              counterText: '',
                                                border: InputBorder.none),
                                          ))
                                    ],
                                  ),
                                ),
                                18.horizontalSpace(),
                                Expanded(
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      "UpTo".textSemiBold(
                                        fontSize: 14,
                                      ),
                                      Container(
                                          padding: const EdgeInsets.only(left: 10),
                                          margin: const EdgeInsets.only(top: 5),
                                          decoration: boxDecoration(
                                              borderRadius: 10,
                                              borderColor: const Color(0xff767676)),
                                          height: 50,
                                          child: TextField(
                                            keyboardType: TextInputType.phone,
                                            maxLines: 1,
                                            maxLength: 12,
                                            controller: state.milkingCowToController,
                                            inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                                            decoration: const InputDecoration(
                                                counterText: '',
                                                border: InputBorder.none),
                                          ))
                                    ],
                                  ),
                                ),
                                31.horizontalSpace(),
                              ],
                            )),

                        33.verticalSpace(),

                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            "Milk Supply".textMedium(fontSize: 18),
                            "In litre".textSemiBold(
                                fontSize: 12, color: const Color(0xff727272))
                          ],
                        ),

                        customProjectContainer(
                            marginLeft: 0,
                            marginTop: 8,
                            height: 124,
                            child: Row(
                              children: [
                                31.horizontalSpace(),
                                Expanded(
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      "From".textSemiBold(
                                        fontSize: 14,
                                      ),
                                      Container(
                                          margin: const EdgeInsets.only(top: 5),
                                          padding: const EdgeInsets.only(left: 10),
                                          decoration: boxDecoration(
                                              borderRadius: 10,
                                              borderColor: const Color(0xff767676)),
                                          height: 50,
                                          child: TextField(
                                            keyboardType: TextInputType.phone,
                                            maxLines: 1,
                                            maxLength: 12,
                                            controller: state.milkSupplyFromController,
                                            inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                                            decoration: const InputDecoration(
                                                counterText: '',
                                                border: InputBorder.none),
                                          ))
                                    ],
                                  ),
                                ),
                                18.horizontalSpace(),
                                Expanded(
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      "UpTo".textSemiBold(
                                        fontSize: 14,
                                      ),
                                      Container(
                                          padding: const EdgeInsets.only(left: 10),
                                          margin: const EdgeInsets.only(top: 5),
                                          decoration: boxDecoration(
                                              borderRadius: 10,
                                              borderColor: const Color(0xff767676)),
                                          height: 50,
                                          child: TextField(
                                            keyboardType: TextInputType.phone,
                                            maxLines: 1,
                                            maxLength: 12,
                                            controller: state.milkSupplyUpToController,
                                            inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                                            decoration: const InputDecoration(
                                                counterText: '',
                                                border: InputBorder.none),
                                          ))
                                    ],
                                  ),
                                ),
                                31.horizontalSpace(),
                              ],
                            )),

                        33.verticalSpace(),

                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            "Yield Per Cow".textMedium(fontSize: 18),
                            "In litre".textSemiBold(
                                fontSize: 12, color: const Color(0xff727272))
                          ],
                        ),

                        customProjectContainer(
                            marginLeft: 0,
                            marginTop: 8,
                            height: 124,
                            child: Row(
                              children: [
                                31.horizontalSpace(),
                                Expanded(
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      "From".textSemiBold(
                                        fontSize: 14,
                                      ),
                                      Container(
                                          margin: const EdgeInsets.only(top: 5),
                                          padding: const EdgeInsets.only(left: 10),
                                          decoration: boxDecoration(
                                              borderRadius: 10,
                                              borderColor: const Color(0xff767676)),
                                          height: 50,
                                          child: TextField(
                                            keyboardType: TextInputType.phone,
                                            maxLines: 1,
                                            maxLength: 12,
                                            controller: state.yieldPerCowFromController,
                                            inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                                            decoration: const InputDecoration(
                                                counterText: '',
                                                border: InputBorder.none),
                                          ))
                                    ],
                                  ),
                                ),
                                18.horizontalSpace(),
                                Expanded(
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      "UpTo".textSemiBold(
                                        fontSize: 14,
                                      ),
                                      Container(
                                          padding: const EdgeInsets.only(left: 10),
                                          margin: const EdgeInsets.only(top: 5),
                                          decoration: boxDecoration(
                                              borderRadius: 10,
                                              borderColor: const Color(0xff767676)),
                                          height: 50,
                                          child: TextField(
                                            keyboardType: TextInputType.phone,
                                            maxLines: 1,
                                            maxLength: 12,
                                            controller: state.yieldPerUpToController,
                                            inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                                            decoration: const InputDecoration(
                                                counterText: '',
                                                border: InputBorder.none),
                                          ))
                                    ],
                                  ),
                                ),
                                31.horizontalSpace(),
                              ],
                            )),

                        33.verticalSpace(),

                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            "Farm size".textMedium(fontSize: 18),
                            "In Acres".textSemiBold(
                                fontSize: 12, color: const Color(0xff727272))
                          ],
                        ),

                        customProjectContainer(
                            marginLeft: 0,
                            marginTop: 8,
                            height: 124,
                            child: Row(
                              children: [
                                31.horizontalSpace(),
                                Expanded(
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      "From".textSemiBold(
                                        fontSize: 14,
                                      ),
                                      Container(
                                          margin: const EdgeInsets.only(top: 5),
                                          padding: const EdgeInsets.only(left: 10),
                                          decoration: boxDecoration(
                                              borderRadius: 10,
                                              borderColor: const Color(0xff767676)),
                                          height: 50,
                                          child:  TextField(
                                            keyboardType: TextInputType.phone,
                                            maxLines: 1,
                                            inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                                            maxLength: 12,
                                            controller: state.farmSizeFromController,
                                            decoration: const InputDecoration(
                                                counterText: '',
                                                border: InputBorder.none),
                                          ))
                                    ],
                                  ),
                                ),
                                18.horizontalSpace(),
                                Expanded(
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      "UpTo".textSemiBold(
                                        fontSize: 14,
                                      ),
                                      Container(
                                          padding: const EdgeInsets.only(left: 10),
                                          margin: const EdgeInsets.only(top: 5),
                                          decoration: boxDecoration(
                                              borderRadius: 10,
                                              borderColor: const Color(0xff767676)),
                                          height: 50,
                                          child: TextField(
                                            keyboardType: TextInputType.phone,
                                            maxLines: 1,
                                            maxLength: 12,
                                            controller: state.farmSizeUpToController,
                                            inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                                            decoration: const InputDecoration(
                                                counterText: '',
                                                border: InputBorder.none),
                                          ))
                                    ],
                                  ),
                                ),
                                31.horizontalSpace(),
                              ],
                            )),

                        33.verticalSpace(),

                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            "Herd size".textMedium(fontSize: 18),
                            "In Numbers".textSemiBold(
                                fontSize: 12, color: const Color(0xff727272))
                          ],
                        ),

                        customProjectContainer(
                            marginLeft: 0,
                            marginTop: 8,
                            height: 124,
                            child: Row(
                              children: [
                                31.horizontalSpace(),
                                Expanded(
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      "From".textSemiBold(
                                        fontSize: 14,
                                      ),
                                      Container(
                                          margin: const EdgeInsets.only(top: 5),
                                          padding: const EdgeInsets.only(left: 10),
                                          decoration: boxDecoration(
                                              borderRadius: 10,
                                              borderColor: const Color(0xff767676)),
                                          height: 50,
                                          child: TextField(
                                            keyboardType: TextInputType.phone,
                                            maxLines: 1,
                                            inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                                            maxLength: 12,
                                            controller: state.herdSizeFromController,
                                            decoration: const InputDecoration(
                                                counterText: '',
                                                border: InputBorder.none),
                                          ))
                                    ],
                                  ),
                                ),
                                18.horizontalSpace(),
                                Expanded(
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      "UpTo".textSemiBold(
                                        fontSize: 14,
                                      ),
                                      Container(
                                          padding: const EdgeInsets.only(left: 10),
                                          margin: const EdgeInsets.only(top: 5),
                                          decoration: boxDecoration(
                                              borderRadius: 10,
                                              borderColor: const Color(0xff767676)),
                                          height: 50,
                                          child: TextField(
                                            keyboardType: TextInputType.phone,
                                            inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                                            maxLines: 1,
                                            maxLength: 12,
                                            controller: state.herdSizeToController,
                                            decoration: const InputDecoration(
                                                counterText: '',
                                                border: InputBorder.none),
                                          ))
                                    ],
                                  ),
                                ),
                                31.horizontalSpace(),
                              ],
                            )),

                        32.verticalSpace(),


                        Container(
                            margin: 20.marginAll(),
                            height: 55,
                            width: screenWidth(),
                            child: customButton("Apply",
                                fontColor: 0xffffffff, onTap: () {
                                  BlocProvider.of<DdeFarmerCubit>(context).getFarmer(context, '${BlocProvider.of<DdeFarmerCubit>(context).state.selectedRagRatingType}'.toLowerCase(), true);
                                  pressBack();
                                }))

                        // ,10.verticalSpace(),
                      ],
                    ),
                  ),
                ),
              )
            ],
          );
        }
      ),
    );
  }
}