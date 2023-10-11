import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:glad/cubit/project_cubit/project_cubit.dart';
import 'package:glad/data/model/response_resource_type.dart';
import 'package:glad/screen/custom_widget/custom_appbar.dart';
import 'package:glad/screen/custom_widget/custom_dropdown.dart';
import 'package:glad/screen/custom_widget/custom_methods.dart';
import 'package:glad/screen/custom_widget/custom_textfield.dart';
import 'package:glad/screen/custom_widget/custom_textfield2.dart';
import 'package:glad/utils/color_resources.dart';
import 'package:glad/utils/extension.dart';
import 'package:glad/utils/images.dart';
import 'package:glad/utils/styles.dart';

class AttributesEdit extends StatefulWidget {
  const AttributesEdit({super.key});

  @override
  State<AttributesEdit> createState() => _AttributesEditState();
}

class _AttributesEditState extends State<AttributesEdit> {

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      BlocProvider.of<ProjectCubit>(context).getResourceTypeApi(context);
      BlocProvider.of<ProjectCubit>(context).getResourceCapacityApi(context);
      BlocProvider.of<ProjectCubit>(context).projectUOMListApi(context);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          landingBackground(),
          Column(
            children: [
              CustomAppBar(
                context: context,
                titleText1: 'Attributes',
                titleText1Style:
                    figtreeMedium.copyWith(fontSize: 20, color: Colors.black),
                centerTitle: true,
                leading: arrowBackButton(),
                /*action: TextButton(
                    onPressed: () {},
                    child: Text(
                      'Save',
                      style: figtreeMedium.copyWith(
                          color: ColorResources.maroon, fontSize: 14),
                    )),*/
              ),
              Expanded(
                  child: SingleChildScrollView(
                      child: Column(
                children: [
                  attributesTextFieldButton(),
                ],
              )))
            ],
          )
        ],
      ),
    );
  }

////////////TextField//////////////
  Widget attributesTextFieldButton() {
    return BlocBuilder<ProjectCubit, ProjectState>(
      builder: (context,state) {
        return Padding(
          padding: const EdgeInsets.fromLTRB(20, 0, 20, 0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              30.verticalSpace(),
              Align(
                alignment: Alignment.centerLeft,
                child: "Type".textMedium(color: Colors.black, fontSize: 12),
              ),

              5.verticalSpace(),

              Container(
                height: 60,
                decoration: BoxDecoration(
                    border: Border.all(color: const Color(0xffD9D9D9,),width: 1.5),
                    borderRadius: BorderRadius.circular(10)
                ),
                width: screenWidth(),
                child: DropdownButtonHideUnderline(
                  child: DropdownButton2<DataResourceType>(
                    isExpanded: true,
                    isDense: true,
                    hint: Text(
                      state.selectResourceType.toString(),
                      style: TextStyle(
                        fontSize: 14,
                        color: Theme.of(context).hintColor,
                      ),
                    ),
                    items: state.responseResourceType!
                        .map((DataResourceType item) => DropdownMenuItem<DataResourceType>(
                      value: item,
                      child: Text(
                        item.name!,
                        style: const TextStyle(
                          fontSize: 14,
                        ),
                      ),
                    )).toList(),
                    // value: state.counties![0].name!,
                    onChanged: (DataResourceType? value) {

                      BlocProvider.of<ProjectCubit>(context).emit(
                          state.copyWith(selectResourceType: value!.name!.toString()));

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
              ),

              20.verticalSpace(),

              Align(
                alignment: Alignment.centerLeft,
                child: "Size Capacity".textMedium(color: Colors.black, fontSize: 12),
              ),

              5.verticalSpace(),

              Container(
                height: 60,
                decoration: BoxDecoration(
                    border: Border.all(color: const Color(0xffD9D9D9,),width: 1.5),
                    borderRadius: BorderRadius.circular(10)
                ),
                width: screenWidth(),
                child: DropdownButtonHideUnderline(
                  child: DropdownButton2<DataResourceType>(
                    isExpanded: true,
                    isDense: true,
                    hint: Text(
                      state.selectSizeCapacity.toString(),
                      style: TextStyle(
                        fontSize: 14,
                        color: Theme.of(context).hintColor,
                      ),
                    ),
                    items: state.responseResourceCapacityType!
                        .map((DataResourceType item) => DropdownMenuItem<DataResourceType>(
                      value: item,
                      child: Text(
                        item.name!,
                        style: const TextStyle(
                          fontSize: 14,
                        ),
                      ),
                    )).toList(),
                    // value: state.counties![0].name!,
                    onChanged: (DataResourceType? value) {

                      BlocProvider.of<ProjectCubit>(context).emit(
                          state.copyWith(selectSizeCapacity: value!.name!.toString()));

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
              ),

              20.verticalSpace(),

              Row(
                children: [
                  const Expanded(child: CustomTextField2(title:'Required Qty',width: 1,borderColor: 0xff727272,hint: '',),),
                  10.horizontalSpace(),
                  Expanded(
                    child: Column(
                      children: [

                        const Text(""),

                        Container(
                          height: 60,
                          margin: const EdgeInsets.only(top: 3),
                          decoration: BoxDecoration(
                              border: Border.all(color: const Color(0xffD9D9D9,),width: 1.5),
                              borderRadius: BorderRadius.circular(10)
                          ),
                          width: screenWidth(),
                          child: DropdownButtonHideUnderline(
                            child: DropdownButton2<DataResourceType>(
                              isExpanded: true,
                              isDense: true,
                              hint: Text(
                                state.selectProjectUOM.toString(),
                                style: TextStyle(
                                  fontSize: 14,
                                  color: Theme.of(context).hintColor,
                                ),
                              ),
                              items: state.responseProjectUOM!
                                  .map((DataResourceType item) => DropdownMenuItem<DataResourceType>(
                                value: item,
                                child: Text(
                                  item.name!,
                                  style: const TextStyle(
                                    fontSize: 14,
                                  ),
                                ),
                              )).toList(),
                              // value: state.counties![0].name!,
                              onChanged: (DataResourceType? value) {

                                BlocProvider.of<ProjectCubit>(context).emit(
                                    state.copyWith(selectProjectUOM: value!.name!.toString()));

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
                        ),
                      ],
                    )
                  ),

                ],
              ),
              20.verticalSpace(),
              const CustomTextField2(title:'Price per unit',width: 1,borderColor: 0xff727272,hint: '',),
              80.verticalSpace(),
              Padding(
                padding: const EdgeInsets.only(left: 10, right: 10),
                child: customButton('Save',
                    style: figtreeMedium.copyWith(color: Colors.white),
                    width: screenWidth(),
                    height: 60,
                    onTap: () {
                  // BlocProvider.of<ProjectCubit>(context).updateAttributeApi(context);
                    }),
              )
            ],
          ),
        );
      }
    );
  }
}
