import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:glad/cubit/project_cubit/project_cubit.dart';
import 'package:glad/data/model/response_capacity_list.dart';
import 'package:glad/data/model/response_resource_name.dart';
import 'package:glad/data/model/response_resource_type.dart';
import 'package:glad/screen/custom_widget/custom_appbar.dart';
import 'package:glad/screen/custom_widget/custom_methods.dart';
import 'package:glad/utils/extension.dart';
import 'package:glad/utils/styles.dart';

class AttributesAdd extends StatefulWidget {
  const AttributesAdd({super.key});

  @override
  State<AttributesAdd> createState() => _AttributesEditState();
}

class _AttributesEditState extends State<AttributesAdd> {

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      BlocProvider.of<ProjectCubit>(context).getResourceNameApi(context,
          BlocProvider.of<ProjectCubit>(context).state.responseFarmerProjectMilestoneDetail!.data!.milestoneDetails![0].farmerId.toString(),
          BlocProvider.of<ProjectCubit>(context).state.responseFarmerProjectMilestoneDetail!.data!.milestoneDetails![0].farmerProjectId.toString(),
          BlocProvider.of<ProjectCubit>(context).state.responseFarmerProjectMilestoneDetail!.data!.milestoneDetails![0].id.toString());
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
                titleText1: 'Add Resources',
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
                  child: "Material Name".textMedium(color: Colors.black, fontSize: 12),
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
                    child: DropdownButton2<DataResourceName>(
                      isExpanded: true,
                      isDense: true,
                      hint: Text(
                        state.selectMaterialName.toString(),
                        style: TextStyle(
                          fontSize: 14,
                          color: Theme.of(context).hintColor,
                        ),
                      ),
                      items: state.responseMaterialType!
                          .map((DataResourceName item) => DropdownMenuItem<DataResourceName>(
                        value: item,
                        child: Text(
                          item.resourceName!,
                          style: const TextStyle(
                            fontSize: 14,
                          ),
                        ),
                      )).toList(),
                      // value: state.counties![0].name!,
                      onChanged: (DataResourceName? value) {

                        BlocProvider.of<ProjectCubit>(context).emit(
                            state.copyWith(selectMaterialName: value!.resourceName!.toString(),
                              selectMaterialId: value.id!.toString(),
                              selectResourceType: 'Select Type',selectResourceTypeId: '',
                              selectSizeCapacity: 'Select Size Capacity',selectSizeCapacityId: '',
                              pricePerUnitController: TextEditingController()..clear(),
                              requiredQtyController: TextEditingController()..clear(),
                            ));

                        BlocProvider.of<ProjectCubit>(context).notRequiredApi(context,
                          value.id!.toString());

                        BlocProvider.of<ProjectCubit>(context).getResourceTypeApi(context,
                            state.responseFarmerProjectMilestoneDetail!.data!.milestoneDetails![0].farmerProjectResourcePrice![0].milestoneId.toString(),
                            value.resourceName!.toString());

                        /*BlocProvider.of<ProjectCubit>(context).getResourceCapacityApi(context,
                          BlocProvider.of<ProjectCubit>(context).state.responseFarmerProjectMilestoneDetail!.data!.milestoneDetails![0].farmerProjectResourcePrice![0].milestoneId.toString(),
                          BlocProvider.of<ProjectCubit>(context).state.responseFarmerProjectMilestoneDetail!.data!.milestoneDetails![0].farmerProjectResourcePrice![0].resourceName.toString(),
                          BlocProvider.of<ProjectCubit>(context).state.responseFarmerProjectMilestoneDetail!.data!.milestoneDetails![0].farmerProjectResourcePrice![0].resourceType.toString(),);*/

                       /* BlocProvider.of<ProjectCubit>(context).getPriceAttributeApi(context,
                          state.responseFarmerProjectMilestoneDetail!.data!.milestoneDetails![0].projectId.toString(),
                          state.responseFarmerProjectMilestoneDetail!.data!.milestoneDetails![0].farmerProjectResourcePrice![0].milestoneId.toString(),
                        );*/

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
                            state.copyWith(selectResourceType: value!.name!.toString(),
                                selectResourceTypeId: value.id!.toString(),selectSizeCapacity: 'Select Size Capacity'));

                        BlocProvider.of<ProjectCubit>(context).getResourceCapacityApi(context,
                            state.responseFarmerProjectMilestoneDetail!.data!.milestoneDetails![0].farmerProjectResourcePrice![0].milestoneId.toString(),
                            state.selectMaterialName,
                            value.name!.toString(),
                        );
                        BlocProvider.of<ProjectCubit>(context).getPriceAttributeApi(context,
                          state.responseFarmerProjectMilestoneDetail!.data!.milestoneDetails![0].projectId.toString(),
                          state.responseFarmerProjectMilestoneDetail!.data!.milestoneDetails![0].farmerProjectResourcePrice![0].milestoneId.toString(),
                        );
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
                    child: DropdownButton2<DataCapacityList>(
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
                          .map((DataCapacityList item) => DropdownMenuItem<DataCapacityList>(
                        value: item,
                        child: Text(
                          item.resourceCapacity!,
                          style: const TextStyle(
                            fontSize: 14,
                          ),
                        ),
                      )).toList(),
                      // value: state.counties![0].name!,
                      onChanged: (DataCapacityList? value) {

                        BlocProvider.of<ProjectCubit>(context).emit(
                            state.copyWith(selectSizeCapacity: value!.resourceCapacity!.toString(),
                                selectSizeCapacityId: value.id!.toString()));
                        BlocProvider.of<ProjectCubit>(context).getPriceAttributeApi(context,
                          state.responseFarmerProjectMilestoneDetail!.data!.milestoneDetails![0].projectId.toString(),
                          state.responseFarmerProjectMilestoneDetail!.data!.milestoneDetails![0].farmerProjectResourcePrice![0].milestoneId.toString(),
                        );
                        // BlocProvider.of<ProjectCubit>(context).getPriceAttributeApi(context);
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

                20.verticalSpace(),

                Row(
                  children: [

                    Expanded(
                      child: Column(
                        children: [
                          Align(
                            alignment: Alignment.centerLeft,
                            child: "Required Qty".textMedium(color: Colors.black, fontSize: 12),
                          ),

                          5.verticalSpace(),

                          Container(
                            height: 60,
                            decoration: BoxDecoration(
                                border: Border.all(color: const Color(0xffD9D9D9,),width: 1.5),
                                borderRadius: BorderRadius.circular(10)
                            ),
                            width: screenWidth(),
                            child: TextField(
                              maxLines: 1,
                              inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                              controller: state.requiredQtyController,
                              maxLength: 10,
                              keyboardType: TextInputType.phone,
                              onChanged: (value){
                                BlocProvider.of<ProjectCubit>(context).getPriceAttributeApi(context,
                                  state.responseFarmerProjectMilestoneDetail!.data!.milestoneDetails![0].projectId.toString(),
                                  state.responseFarmerProjectMilestoneDetail!.data!.milestoneDetails![0].farmerProjectResourcePrice![0].milestoneId.toString(),
                                );
                                if(value.isNotEmpty){
                                  double sums = double.parse(value.toString())*double.parse(state.pricePerUnitController.toString());
                                  state.valueController.text = sums.toStringAsFixed(2);
                                }
                              },
                              decoration: const InputDecoration(
                                  border: InputBorder.none,
                                  counterText: '',
                                  contentPadding: EdgeInsets.only(top: 10,left: 13)
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),

                    10.horizontalSpace(),

                    Expanded(
                      child: Column(
                        children: [
                          Align(
                            alignment: Alignment.centerLeft,
                            child: "".textMedium(color: Colors.black, fontSize: 12),
                          ),

                          5.verticalSpace(),

                          Container(
                            height: 60,
                            decoration: BoxDecoration(
                                border: Border.all(color: const Color(0xffD9D9D9,),width: 1.5),
                                borderRadius: BorderRadius.circular(10)
                            ),
                            width: screenWidth(),
                            child: TextField(
                              enabled: false,
                              maxLines: 1,
                              inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                              controller: TextEditingController(text: state.selectProjectUOM.toString()),
                              decoration: const InputDecoration(
                                  border: InputBorder.none,
                                  contentPadding: EdgeInsets.only(top: 10,left: 13)
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),

                  ],
                ),
                20.verticalSpace(),
                Align(
                  alignment: Alignment.centerLeft,
                  child: "Price per unit".textMedium(color: Colors.black, fontSize: 12),
                ),

                5.verticalSpace(),

                Container(
                  height: 60,
                  decoration: BoxDecoration(
                      border: Border.all(color: const Color(0xffD9D9D9,),width: 1.5),
                      borderRadius: BorderRadius.circular(10)
                  ),
                  width: screenWidth(),
                  child: TextField(
                    maxLines: 1,
                    inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                    controller: state.pricePerUnitController,
                    maxLength: 10,
                    enabled: false,
                    keyboardType: TextInputType.phone,
                    decoration: const InputDecoration(
                        border: InputBorder.none,
                        counterText: '',
                        contentPadding: EdgeInsets.only(top: 10,left: 13)
                    ),
                  ),
                ),

                20.verticalSpace(),
                Align(
                  alignment: Alignment.centerLeft,
                  child: "Value".textMedium(color: Colors.black, fontSize: 12),
                ),

                5.verticalSpace(),

                Container(
                  height: 60,
                  decoration: BoxDecoration(
                      border: Border.all(color: const Color(0xffD9D9D9,),width: 1.5),
                      borderRadius: BorderRadius.circular(10)
                  ),
                  width: screenWidth(),
                  child: TextField(
                    maxLines: 1,
                    inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                    // controller: TextEditingController(text: state.requiredQtyController.text.isEmpty?"0":'${double.parse(state.requiredQtyController.text.toString())*double.parse(state.pricePerUnitController.text.toString())}'),
                    controller: state.valueController,
                    maxLength: 10,
                    enabled: false,
                    keyboardType: TextInputType.phone,
                    decoration: const InputDecoration(
                        border: InputBorder.none,
                        counterText: '',
                        contentPadding: EdgeInsets.only(top: 10,left: 13)
                    ),
                  ),
                ),


                /*Row(
                  children: [
                    Expanded(child:
                    CustomTextField2(title:'Required Qty',
                      width: 1,
                      inputType: TextInputType.phone,
                      maxLine: 1,
                      maxLength: 10,
                      onChanged: (value){
                        BlocProvider.of<ProjectCubit>(context).getPriceAttributeApi(context,
                          state.responseFarmerProjectMilestoneDetail!.data!.milestoneDetails![0].projectId.toString(),
                          state.responseFarmerProjectMilestoneDetail!.data!.milestoneDetails![0].farmerProjectResourcePrice![0].milestoneId.toString(),
                        );
                      },
                      inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                      controller: state.requiredQtyController,
                      borderColor: 0xff727272,hint: '',),),
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
                                        state.copyWith(selectProjectUOM: value!.name!.toString(),
                                          selectProjectUOMId: value.id!.toString(),));

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
                CustomTextField2(title:'Price per unit',
                  enabled: false,
                  width: 1,borderColor: 0xff727272,hint: '',
                  controller: state.pricePerUnitController,
                ),*/
                80.verticalSpace(),
                Padding(
                  padding: const EdgeInsets.only(left: 10, right: 10),
                  child: customButton('Save',
                      style: figtreeMedium.copyWith(color: Colors.white),
                      width: screenWidth(),
                      height: 60,
                      onTap: () {
                        BlocProvider.of<ProjectCubit>(context).updateAttributeApi(context,
                          state.responseFarmerProjectMilestoneDetail!.data!.milestoneDetails![0].farmerId.toString(),
                          state.responseFarmerProjectMilestoneDetail!.data!.milestoneDetails![0].farmerProjectId.toString(),
                          state.responseFarmerProjectMilestoneDetail!.data!.milestoneDetails![0].id.toString(),
                          state.primaryId.toString(),
                        );
                      }),
                )
              ],
            ),
          );
        }
    );
  }
}
