import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:glad/cubit/project_cubit/project_cubit.dart';
import 'package:glad/data/model/response_farmer_filter_list.dart';
import 'package:glad/data/model/response_project_supplier_filter_list.dart';
import 'package:glad/screen/custom_widget/custom_appbar.dart';
import 'package:glad/screen/custom_widget/custom_methods.dart';
import 'package:glad/utils/color_resources.dart';
import 'package:glad/utils/extension.dart';
import 'package:glad/utils/styles.dart';

class SupplierFilter extends StatelessWidget {
  const SupplierFilter(this.selectedFilter,{Key? key,}) : super(key: key);
  final String selectedFilter;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: BlocBuilder<ProjectCubit, ProjectState>(builder: (context, state) {
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
                        .supplierProjectsApi(
                        context, selectedFilter, false);
                    pressBack();
                  },
                  child: "Cancel"
                      .textMedium(color: ColorResources.maroon, fontSize: 12)),
              action: TextButton(
                  onPressed: () {
                    BlocProvider.of<ProjectCubit>(context).roiFilterClear();
                    BlocProvider.of<ProjectCubit>(context)
                        .supplierProjectsApi(
                        context, selectedFilter, false);

                    pressBack();

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

/*

                      "Improvement areas".textMedium(fontSize: 18),

                      15.verticalSpace(),

                      state.responseImprovementAreaFilterList!=null?
                      Wrap(
                        children: state.responseImprovementAreaFilterList!.data!.map((item) => InkWell(
                          onTap: (){
                            context.read<ProjectCubit>().emit(state.copyWith(
                                filterImprovementAreaName: item.name));
                          },
                          child: Container(
                              margin: 5.marginAll(),
                              padding: const EdgeInsets.only(
                                  left: 14, right: 14, bottom: 10, top: 10),
                              decoration: boxDecoration(
                                  borderColor: state.filterImprovementAreaName == item.name ?
                                  const Color(0xff6A0030):const Color(0xffDCDCDC),
                                  backgroundColor: state.filterImprovementAreaName == item.name ?const Color(0xffFFF3F4):Colors.transparent,
                                  borderRadius: 30),
                              child: Text(item.name.toString())),
                        ))
                            .toList()
                            .cast<Widget>(),
                      ):const SizedBox.shrink(),*/

                      // 20.verticalSpace(),

                      "Project".textMedium(fontSize: 18),

                      15.verticalSpace(),

                      if(state.responseProjectSupplierFilterDropdownList!=null)
                        state.responseProjectSupplierFilterDropdownList!.data!=null?
                        Container(
                          height: 55,
                          decoration: BoxDecoration(
                              border: Border.all(color: const Color(0xffD9D9D9,),width: 1.5),
                              borderRadius: BorderRadius.circular(10)
                          ),
                          width: screenWidth(),
                          child: DropdownButtonHideUnderline(
                            child: DropdownButton2<String>(
                              isExpanded: true,
                              isDense: true,
                              hint: Text(
                                state.selectProjectFilter.toString(),
                                style: TextStyle(
                                  fontSize: 14,
                                  color: Theme.of(context).hintColor,
                                ),
                              ),
                              items: state.responseProjectSupplierFilterDropdownList?.data!
                                  .map((DataSupplierFilter item) => DropdownMenuItem<String>(
                                value: item.name.toString(),
                                child: Text(
                                  item.name!,
                                  style: const TextStyle(
                                    fontSize: 14,
                                  ),
                                ),
                              )).toList(),
                              // value: state.counties![0].name!,
                              onChanged: (String? value) {
                                BlocProvider.of<ProjectCubit>(context).emit(state.copyWith(selectProjectFilter: value));
                              },
                              buttonStyleData: const ButtonStyleData(
                                padding: EdgeInsets.symmetric(horizontal: 16),
                                height: 40,
                                width: 140,
                              ),
                              menuItemStyleData: const MenuItemStyleData(
                                height: 40,
                              ),
                            ),
                          ),
                        ):const SizedBox.shrink(),

                      20.verticalSpace(),

                      "Farmer".textMedium(fontSize: 18),

                      15.verticalSpace(),

                      if(state.responseFarmerFilterDropdownList!=null)
                        state.responseFarmerFilterDropdownList!.data!=null?
                        Container(
                          height: 55,
                          decoration: BoxDecoration(
                              border: Border.all(color: const Color(0xffD9D9D9,),width: 1.5),
                              borderRadius: BorderRadius.circular(10)
                          ),
                          width: screenWidth(),
                          child: DropdownButtonHideUnderline(
                            child: DropdownButton2<String>(
                              isExpanded: true,
                              isDense: true,
                              hint: Text(
                                state.selectFarmerFilter.toString(),
                                style: TextStyle(
                                  fontSize: 14,
                                  color: Theme.of(context).hintColor,
                                ),
                              ),
                              items: state.responseFarmerFilterDropdownList?.data!
                                  .map((DataFarmerFilterList item) => DropdownMenuItem<String>(
                                value: item.name.toString(),
                                child: Text(
                                  item.name!,
                                  style: const TextStyle(
                                    fontSize: 14,
                                  ),
                                ),
                              )).toList(),
                              // value: state.counties![0].name!,
                              onChanged: (String? value) {
                                BlocProvider.of<ProjectCubit>(context).emit(state.copyWith(selectFarmerFilter: value));
                              },
                              buttonStyleData: const ButtonStyleData(
                                padding: EdgeInsets.symmetric(horizontal: 16),
                                height: 40,
                                width: 140,
                              ),
                              menuItemStyleData: const MenuItemStyleData(
                                height: 40,
                              ),
                            ),
                          ),
                        ):const SizedBox.shrink(),

                      33.verticalSpace(),

                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          "Investment".textMedium(fontSize: 18),
                          "In Number".textSemiBold(
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
                                          controller: state.investmentFromController,
                                          maxLength: 12,
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
                                          controller: state.investmentUpToController,
                                          maxLength: 12,
                                          inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                                          decoration: const InputDecoration(
                                            border: InputBorder.none,counterText: '',),
                                        ))
                                  ],
                                ),
                              ),
                              31.horizontalSpace(),
                            ],
                          )),

                      Container(
                          margin: 20.marginAll(),
                          height: 55,
                          width: screenWidth(),
                          child: customButton("Apply",
                              fontColor: 0xffffffff, onTap: () {
                                BlocProvider.of<ProjectCubit>(context)
                                    .supplierProjectsApi(
                                    context, selectedFilter, false);
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
