import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:glad/cubit/project_cubit/project_cubit.dart';
import 'package:glad/data/model/response_capacity_list.dart';
import 'package:glad/data/model/response_resource_type.dart';
import 'package:glad/screen/custom_widget/custom_appbar.dart';
import 'package:glad/screen/custom_widget/custom_methods.dart';
import 'package:glad/utils/extension.dart';
import 'package:glad/utils/images.dart';
import 'package:glad/utils/styles.dart';

class AttributesEditDdeResource extends StatefulWidget {
  final int index;
  const AttributesEditDdeResource({super.key,required this.index});

  @override
  State<AttributesEditDdeResource> createState() => _AttributesEditDdeResourceState();
}

class _AttributesEditDdeResourceState extends State<AttributesEditDdeResource> {

  final TextEditingController valueController = TextEditingController();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      /*BlocProvider.of<ProjectCubit>(context).getResourceNameApi(context,
          BlocProvider.of<ProjectCubit>(context).state.responseFarmerProjectMilestoneDetail!.data!.milestoneDetails![0].farmerProjectResourcePrice![widget.index].farmerId.toString(),
          BlocProvider.of<ProjectCubit>(context).state.responseFarmerProjectMilestoneDetail!.data!.milestoneDetails![0].farmerProjectResourcePrice![widget.index].farmerProjectId.toString(),
          BlocProvider.of<ProjectCubit>(context).state.responseFarmerProjectMilestoneDetail!.data!.milestoneDetails![0].farmerProjectResourcePrice![widget.index].farmerMilestoneId.toString()
      );*/
      BlocProvider.of<ProjectCubit>(context).getResourceTypeApi(context,
        BlocProvider.of<ProjectCubit>(context).state.responseFarmerProjectMilestoneDetail!.data!.milestoneDetails![0].farmerProjectResourcePrice![widget.index].milestoneId.toString(),
        BlocProvider.of<ProjectCubit>(context).state.responseFarmerProjectMilestoneDetail!.data!.milestoneDetails![0].farmerProjectResourcePrice![widget.index].resourceName.toString(),
      );
      BlocProvider.of<ProjectCubit>(context).getResourceCapacityApi(context,
        BlocProvider.of<ProjectCubit>(context).state.responseFarmerProjectMilestoneDetail!.data!.milestoneDetails![0].farmerProjectResourcePrice![widget.index].milestoneId.toString(),
        BlocProvider.of<ProjectCubit>(context).state.responseFarmerProjectMilestoneDetail!.data!.milestoneDetails![0].farmerProjectResourcePrice![widget.index].resourceName.toString(),
        BlocProvider.of<ProjectCubit>(context).state.responseFarmerProjectMilestoneDetail!.data!.milestoneDetails![0].farmerProjectResourcePrice![widget.index].resourceType.toString(),);
      // BlocProvider.of<ProjectCubit>(context).projectUOMListApi(context);
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
                titleText1: 'Resources',
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
                  child: TextField(
                    enabled: false,
                    maxLines: 1,
                    controller: TextEditingController(text: state.selectMaterialName.toString()),
                    decoration: const InputDecoration(
                        border: InputBorder.none,
                        contentPadding: EdgeInsets.only(top: 10,left: 13)
                    ),
                  ),
                ),


                /*Container(
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
                          ));

                      BlocProvider.of<ProjectCubit>(context).getPriceAttributeApi(context);
                      BlocProvider.of<ProjectCubit>(context).getResourceTypeApi(context,value.id.toString(),'resourceType');

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
              ),*/

                20.verticalSpace(),

                Align(
                    alignment: Alignment.centerLeft,
                    child: "Type".textMedium(color: Colors.black, fontSize: 12)),

                5.verticalSpace(),

                Stack(
                  children: [
                    Container(
                      height: 60,
                      decoration: BoxDecoration(
                          border: Border.all(color: const Color(0xffD9D9D9,),width: 1.5),
                          borderRadius: BorderRadius.circular(10)
                      ),
                      width: screenWidth(),
                      child: TextField(
                        maxLines: 1,
                        controller: state.resourceTypeController,
                        onChanged: (value){
                          context.read<ProjectCubit>().searchResourceType(value, state.responseResourceType!);
                        },
                        decoration: const InputDecoration(
                            border: InputBorder.none,
                            hintText: 'Search...',
                            contentPadding: EdgeInsets.only(top: 10,left: 13)
                        ),
                      ),
                    ),
                    Visibility(
                      visible: state.resourceTypeController.text.isNotEmpty,
                      child: Positioned(
                        top: 0,
                        bottom: 0,
                        right: 12,
                        child: InkWell(
                          onTap: (){
                            setState(() {
                              state.resourceTypeController.clear();
                              state.filterResourceType!.clear();
                            });
                          },child: Align(alignment: Alignment.centerRight
                            ,child: SvgPicture.asset(Images.cross)),
                        ),
                      ),
                    )
                  ],
                ),

                // state.materialNameController.text.isNotEmpty?
                state.filterResourceType!=null?
                Card(
                  child: Flexible(
                    child: ListView.separated(
                        shrinkWrap: true,
                        padding: EdgeInsets.all(state.filterResourceType!.isNotEmpty?15:0),
                        itemBuilder: (context,index){
                          return InkWell(
                            onTap: (){
                              BlocProvider.of<ProjectCubit>(context).emit(
                                  state.copyWith(selectResourceType: state.filterResourceType![index].name!.toString(),
                                      selectResourceTypeId: state.filterResourceType![index].id!.toString(),selectSizeCapacity: ''));

                              state.resourceTypeController.text = state.filterResourceType![index].name!;
                              state.resourceCapacityController.clear();
                              BlocProvider.of<ProjectCubit>(context).getResourceCapacityApi(context,
                                state.responseFarmerProjectMilestoneDetail!.data!.milestoneDetails![0].farmerProjectResourcePrice![0].milestoneId.toString(),
                                state.selectMaterialName,
                                state.filterResourceType![index].name.toString(),
                              );

                              BlocProvider.of<ProjectCubit>(context).getPriceAttributeApi(context,
                                state.responseFarmerProjectMilestoneDetail!.data!.milestoneDetails![0].projectId.toString(),
                                state.responseFarmerProjectMilestoneDetail!.data!.milestoneDetails![0].farmerProjectResourcePrice![0].milestoneId.toString(),
                              );
                              BlocProvider.of<ProjectCubit>(context).emit(state.copyWith(filterResourceType: []));
                            },
                            child: Expanded(
                              child: Text(state.filterResourceType![index].name.toString(),
                                style: figtreeMedium.copyWith(
                                  color: Colors.black,
                                  fontSize: 15,
                                ),),
                            ),
                          );
                        },
                        separatorBuilder: (context,index){
                          return const Divider(thickness: 1,height: 28,);
                        },
                        itemCount: state.filterResourceType!.length),
                  ),
                ):
                const SizedBox.shrink(),
                // : const SizedBox.shrink(),


                20.verticalSpace(),

                Align(
                    alignment: Alignment.centerLeft,
                    child: "Size Capacity".textMedium(color: Colors.black, fontSize: 12)),

                5.verticalSpace(),

                Stack(
                  children: [
                    Container(
                      height: 60,
                      decoration: BoxDecoration(
                          border: Border.all(color: const Color(0xffD9D9D9,),width: 1.5),
                          borderRadius: BorderRadius.circular(10)
                      ),
                      width: screenWidth(),
                      child: TextField(
                        maxLines: 1,
                        controller: state.resourceCapacityController,
                        onChanged: (value){
                          context.read<ProjectCubit>().searchSizeCapacity(value, state.responseResourceCapacityType!);
                        },
                        decoration: const InputDecoration(
                            border: InputBorder.none,
                            hintText: 'Search...',
                            contentPadding: EdgeInsets.only(top: 10,left: 13)
                        ),
                      ),
                    ),
                    Visibility(
                      visible: state.resourceCapacityController.text.isNotEmpty,
                      child: Positioned(
                        top: 0,
                        bottom: 0,
                        right: 12,
                        child: InkWell(
                          onTap: (){
                            setState(() {
                              state.resourceCapacityController.clear();
                              state.filterResourceCapacityType!.clear();
                            });
                          },child: Align(alignment: Alignment.centerRight
                            ,child: SvgPicture.asset(Images.cross)),
                        ),
                      ),
                    )
                  ],
                ),

                // state.materialNameController.text.isNotEmpty?
                state.filterResourceCapacityType!=null?
                Card(
                  child: Flexible(
                    child: ListView.separated(
                        shrinkWrap: true,
                        padding: EdgeInsets.all(state.filterResourceCapacityType!.isNotEmpty?15:0),
                        itemBuilder: (context,index){
                          return InkWell(
                            onTap: (){
                              BlocProvider.of<ProjectCubit>(context).emit(
                                  state.copyWith(selectSizeCapacity: state.filterResourceCapacityType![index].resourceCapacity!.toString(),
                                      selectSizeCapacityId: state.filterResourceCapacityType![index].id!.toString()));
                              state.resourceCapacityController.text = state.filterResourceCapacityType![index].resourceCapacity!.toString();
                              BlocProvider.of<ProjectCubit>(context).getPriceAttributeApi(context,
                                state.responseFarmerProjectMilestoneDetail!.data!.milestoneDetails![0].projectId.toString(),
                                state.responseFarmerProjectMilestoneDetail!.data!.milestoneDetails![0].farmerProjectResourcePrice![0].milestoneId.toString(),
                              );
                              BlocProvider.of<ProjectCubit>(context).emit(state.copyWith(filterResourceCapacityType: []));
                            },
                            child: Expanded(
                              child: Text(state.filterResourceCapacityType![index].resourceCapacity.toString(),
                                style: figtreeMedium.copyWith(
                                  color: Colors.black,
                                  fontSize: 15,
                                ),),
                            ),
                          );
                        },
                        separatorBuilder: (context,index){
                          return const Divider(thickness: 1,height: 28,);
                        },
                        itemCount: state.filterResourceCapacityType!.length),
                  ),
                ):
                const SizedBox.shrink(),

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
                                  state.responseFarmerProjectMilestoneDetail!.data!.milestoneDetails![0].farmerProjectResourcePrice![widget.index].milestoneId.toString(),);
                                if(value.isNotEmpty){
                                  double sums = double.parse(value.toString())*double.parse(state.pricePerUnitController.text.toString());
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
                    enabled: true,
                    onChanged: (value){
                      if(value.isNotEmpty){
                        double sums = double.parse(state.requiredQtyController.text)*double.parse(value.toString());
                        state.valueController.text = sums.toStringAsFixed(2);
                      }
                    },
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

                /*CustomTextField2(title:'Price per unit',
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
                            BlocProvider.of<ProjectCubit>(context).state.responseFarmerProjectMilestoneDetail!.data!.milestoneDetails![0].farmerProjectResourcePrice![widget.index].id.toString()

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