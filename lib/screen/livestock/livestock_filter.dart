import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:glad/cubit/livestock_cubit/livestock_cubit.dart';
import 'package:glad/cubit/project_cubit/project_cubit.dart';
import 'package:glad/screen/custom_widget/custom_appbar.dart';
import 'package:glad/screen/custom_widget/custom_methods.dart';
import 'package:glad/utils/color_resources.dart';
import 'package:glad/utils/extension.dart';
import 'package:glad/utils/styles.dart';

class LivestockFilter extends StatefulWidget {
  const LivestockFilter(this.selectedFilter,{Key? key,}) : super(key: key);
  final String selectedFilter;

  @override
  State<LivestockFilter> createState() => _LivestockFilterState();
}

class _LivestockFilterState extends State<LivestockFilter> {


  Set checkFilter = {};

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: BlocBuilder<LivestockCubit, LivestockCubitState>(builder: (context, state) {
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
                    BlocProvider.of<ProjectCubit>(context).roiFilterClear();
                    BlocProvider.of<ProjectCubit>(context)
                        .ddeProjectsApi(
                        context, widget.selectedFilter, false);
                    pressBack();
                  },
                  child: "Cancel"
                      .textMedium(color: ColorResources.maroon, fontSize: 12)),
              action: TextButton(
                  onPressed: () {
                    BlocProvider.of<LivestockCubit>(context).livestockClearFilter();
                    /*BlocProvider.of<LivestockCubit>(context)
                        .livestockListApi(
                        context, false);*/

                    // pressBack();

                  }, child: "Reset"
                  .textMedium(color: ColorResources.maroon, fontSize: 12)),
            ),
            Expanded(
              child: SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.only(left: 18.0, right: 18, top: 31),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      "Breed".textMedium(fontSize: 18),

                      15.verticalSpace(),

                      if(state.breed!=null)
                        state.breed!.data!=null?
                        Wrap(
                          children: state.breed!.data!.map((item) => InkWell(
                            onTap: (){
                              context.read<LivestockCubit>().emit(state.copyWith(
                                  breedNameSelected: TextEditingController(text: item.name.toString())));
                            },
                            child: Container(
                                margin: 5.marginAll(),
                                padding: const EdgeInsets.only(
                                    left: 14, right: 14, bottom: 10, top: 10),
                                decoration: boxDecoration(
                                    borderColor:state.breedNameSelected.text == item.name ?
                                    const Color(0xff6A0030):const Color(0xffDCDCDC),
                                    backgroundColor: state.breedNameSelected.text == item.name ?const Color(0xffFFF3F4):Colors.transparent,
                                    borderRadius: 30),
                                child: Text(item.name.toString())),
                          ))
                              .toList()
                              .cast<Widget>(),
                        ):const SizedBox.shrink(),
                      33.verticalSpace(),

                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          "Age".textMedium(fontSize: 18),
                          "In Numbers".textSemiBold(
                              fontSize: 12, color: const Color(0xff727272))
                        ],
                      ),

                      customProjectContainer(
                          marginLeft: 0,
                          marginTop: 8,
                          height: 124,
                          child: Stack(
                            children: [
                              Row(
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
                                              controller: state.ageFromController,
                                              onChanged: (value){
                                                setState(() {
                                                  if(state.ageUpToController.text.isNotEmpty&&state.ageFromController.text.isNotEmpty){
                                                    if(int.parse(state.ageUpToController.text)<int.parse(state.ageFromController.text)){

                                                    }
                                                  }
                                                });
                                              },
                                              inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                                              decoration: const InputDecoration(
                                                  border: InputBorder.none,
                                                  counterText: ''
                                              ),
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
                                              onChanged: (value){
                                                setState(() {
                                                  if(state.ageUpToController.text.isNotEmpty&&state.ageFromController.text.isNotEmpty){
                                                    if(int.parse(state.ageUpToController.text)<int.parse(state.ageFromController.text)){

                                                    }
                                                  }
                                                });
                                              },
                                              controller: state.ageUpToController,
                                              inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                                              decoration: const InputDecoration(
                                                  border: InputBorder.none,counterText: ''),
                                            )),
                                      ],
                                    ),
                                  ),
                                  31.horizontalSpace(),
                                ],
                              ),
                              if(state.ageUpToController.text.isNotEmpty&&state.ageFromController.text.isNotEmpty)
                                if(int.parse(state.ageUpToController.text)<int.parse(state.ageFromController.text))
                                  Positioned(
                                      left: 30,
                                      bottom: 6,
                                      child: "Age UpTo must be greater than Age From".textRegular(color: Colors.red,
                                          fontSize: 12))
                            ],
                          )),

                      33.verticalSpace(),

                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          "Price".textMedium(fontSize: 18),
                          "In Number".textSemiBold(
                              fontSize: 12, color: const Color(0xff727272))
                        ],
                      ),

                      customProjectContainer(
                          marginLeft: 0,
                          marginTop: 8,
                          height: 124,
                          child: Stack(
                            children: [
                              Row(
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
                                              controller: state.priceFromController,
                                              maxLength: 12,
                                              onChanged: (value){
                                                setState(() {
                                                  if(state.priceUpToController.text.isNotEmpty&&state.priceFromController.text.isNotEmpty){
                                                    if(int.parse(state.priceUpToController.text)<int.parse(state.priceFromController.text)){

                                                    }
                                                  }
                                                });
                                              },
                                              inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                                              decoration: const InputDecoration(
                                                border: InputBorder.none,counterText: '',),
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
                                              controller: state.priceUpToController,
                                              maxLength: 12,
                                              onChanged: (value){
                                                setState(() {
                                                  if(state.priceUpToController.text.isNotEmpty&&state.priceFromController.text.isNotEmpty){
                                                    if(int.parse(state.priceUpToController.text)<int.parse(state.priceFromController.text)){

                                                    }
                                                  }
                                                });
                                              },
                                              inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                                              decoration: const InputDecoration(
                                                border: InputBorder.none,counterText: '',),
                                            ))
                                      ],
                                    ),
                                  ),
                                  31.horizontalSpace(),
                                ],
                              ),
                              if(state.priceUpToController.text.isNotEmpty&&state.priceFromController.text.isNotEmpty)
                                if(int.parse(state.priceUpToController.text)<int.parse(state.priceFromController.text))
                                  Positioned(
                                      left: 30,
                                      bottom: 6,
                                      child: "Price UpTo must be greater than Price From".textRegular(color: Colors.red,
                                          fontSize: 12))
                            ],
                          )),

                      33.verticalSpace(),

                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          "Lactation".textMedium(fontSize: 18),
                          "In Numbers".textSemiBold(
                              fontSize: 12, color: const Color(0xff727272))
                        ],
                      ),

                      customProjectContainer(
                          marginLeft: 0,
                          marginTop: 8,
                          height: 124,
                          child: Stack(
                            children: [
                              Row(
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
                                              onChanged: (value){
                                                setState(() {
                                                  if(state.lactationUpToController.text.isNotEmpty&&state.lactationFromController.text.isNotEmpty){
                                                    if(int.parse(state.lactationUpToController.text)<int.parse(state.lactationFromController.text)){

                                                    }
                                                  }
                                                });
                                              },
                                              controller: state.lactationFromController,
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
                                              onChanged: (value){
                                                setState(() {
                                                  if(state.lactationUpToController.text.isNotEmpty&&state.lactationFromController.text.isNotEmpty){
                                                    if(int.parse(state.lactationUpToController.text)<int.parse(state.lactationFromController.text)){

                                                    }
                                                  }
                                                });
                                              },
                                              controller: state.lactationUpToController,
                                              inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                                              decoration: const InputDecoration(
                                                border: InputBorder.none,counterText: '',),
                                            ))
                                      ],
                                    ),
                                  ),
                                  31.horizontalSpace(),
                                ],
                              ),
                              if(state.lactationUpToController.text.isNotEmpty&&state.lactationFromController.text.isNotEmpty)
                                if(int.parse(state.lactationUpToController.text)<int.parse(state.lactationFromController.text))
                                  Positioned(
                                      left: 30,
                                      bottom: 6,
                                      child: "Lactation UpTo must be greater than Lactation From".textRegular(color: Colors.red,
                                          fontSize: 12))
                            ],
                          )),

                      33.verticalSpace(),

                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          "Yield".textMedium(fontSize: 18),
                          "In Numbers".textSemiBold(
                              fontSize: 12, color: const Color(0xff727272))
                        ],
                      ),

                      customProjectContainer(
                          marginLeft: 0,
                          marginTop: 8,
                          height: 124,
                          child: Stack(
                            children: [
                              Row(
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
                                              controller: state.yieldFromController,
                                              onChanged: (value){
                                                setState(() {
                                                  if(state.yieldUpToController.text.isNotEmpty&&state.yieldFromController.text.isNotEmpty){
                                                    if(int.parse(state.yieldUpToController.text)<int.parse(state.yieldFromController.text)){

                                                    }
                                                  }
                                                });
                                              },
                                              inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                                              decoration: const InputDecoration(
                                                border: InputBorder.none,counterText: '',),
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
                                              controller: state.yieldUpToController,
                                              onChanged: (value){
                                                setState(() {
                                                  if(state.yieldUpToController.text.isNotEmpty&&state.yieldFromController.text.isNotEmpty){
                                                    if(int.parse(state.yieldUpToController.text)<int.parse(state.yieldFromController.text)){

                                                    }
                                                  }
                                                });
                                              },
                                              inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                                              decoration: const InputDecoration(
                                                border: InputBorder.none,counterText: '',),
                                            ))
                                      ],
                                    ),
                                  ),
                                  31.horizontalSpace(),
                                ],
                              ),

                              if(state.yieldUpToController.text.isNotEmpty&&state.yieldFromController.text.isNotEmpty)
                                if(int.parse(state.yieldUpToController.text)<int.parse(state.yieldFromController.text))
                                  Positioned(
                                      left: 30,
                                      bottom: 6,
                                      child: "Yield UpTo must be greater than Yield From".textRegular(color: Colors.red,
                                          fontSize: 12))
                            ],
                          )),

                      10.verticalSpace(),

                      Container(
                          margin: 20.marginAll(),
                          height: 55,
                          width: screenWidth(),
                          child: customButton("Apply",
                              fontColor: 0xffffffff, onTap: () {
                                if(state.ageUpToController.text.isNotEmpty||state.ageFromController.text.isNotEmpty) {
                                  if(state.ageFromController.text.isEmpty){
                                    "Age From is required".toast();
                                  }else if(state.ageUpToController.text.isEmpty){
                                    "Age UpTo is required".toast();
                                  }else{
                                    if(int.parse(state.ageUpToController.text.isEmpty?"0":state.ageUpToController.text)<int.parse(state.ageFromController.text.isEmpty?"0":state.ageFromController.text)){
                                      "Age UpTo must be greater than Age From".toast();
                                    }else{
                                      BlocProvider.of<LivestockCubit>(context)
                                          .livestockListApi(
                                          context, false,searchQuery: '');
                                      pressBack();
                                    }
                                  }
                                }
                                else if(state.priceUpToController.text.isNotEmpty||state.priceFromController.text.isNotEmpty) {
                                  if(state.priceFromController.text.isEmpty){
                                    "Price From is required".toast();
                                  }else if(state.priceUpToController.text.isEmpty){
                                    "Price UpTo is required".toast();
                                  }else{
                                    if(int.parse(state.priceUpToController.text.isEmpty?"0":state.priceUpToController.text)<int.parse(state.priceFromController.text.isEmpty?"0":state.priceFromController.text)){
                                      "Price UpTo must be greater than Price From".toast();
                                    }else{
                                      /*BlocProvider.of<LivestockCubit>(context)
                                          .livestockListApi(
                                          context, false,searchQuery: '');
                                      pressBack();*/
                                    }
                                  }
                                }
                                else if(state.lactationUpToController.text.isNotEmpty||state.lactationFromController.text.isNotEmpty) {
                                  if(state.lactationFromController.text.isEmpty){
                                    "Lactation From is required".toast();
                                  }else if(state.lactationUpToController.text.isEmpty){
                                    "Lactation UpTo is required".toast();
                                  }else{
                                    if(int.parse(state.lactationUpToController.text.isEmpty?"0":state.lactationUpToController.text)<int.parse(state.lactationFromController.text.isEmpty?"0":state.lactationFromController.text)){
                                      "Lactation UpTo must be greater than Lactation From".toast();
                                    }else{
                                      BlocProvider.of<LivestockCubit>(context)
                                          .livestockListApi(
                                          context, false,searchQuery: '');
                                      pressBack();
                                    }
                                  }
                                }
                                else if(state.yieldUpToController.text.isNotEmpty||state.yieldFromController.text.isNotEmpty) {
                                  if(int.parse(state.yieldUpToController.text.isEmpty?"0":state.yieldUpToController.text)<int.parse(state.yieldFromController.text.isEmpty?"0":state.yieldFromController.text)){
                                      "Yield UpTo must be greater than yield From".toast();
                                    }
                                }
                                else{
                                  BlocProvider.of<LivestockCubit>(context)
                                      .livestockListApi(
                                      context, false,searchQuery: '');
                                  pressBack();
                                }
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
