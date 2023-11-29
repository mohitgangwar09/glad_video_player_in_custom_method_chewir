import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:glad/cubit/project_cubit/project_cubit.dart';
import 'package:glad/data/model/farmer_project_milestone_detail_model.dart';
import 'package:glad/screen/custom_widget/circular_percent_indicator.dart';
import 'package:glad/screen/custom_widget/custom_appbar.dart';
import 'package:glad/screen/custom_widget/custom_methods.dart';
import 'package:glad/screen/dde_screen/add_dde_resources.dart';
import 'package:glad/screen/dde_screen/preview_screen.dart';
import 'package:glad/screen/dde_screen/update_dde_resource.dart';
import 'package:glad/screen/farmer_screen/common/add_attribute.dart';
import 'package:glad/screen/farmer_screen/common/attributes_edit.dart';
import 'package:glad/screen/supplier_screen/edit_milestone.dart';
import 'package:glad/screen/supplier_screen/task_detail.dart';
import 'package:glad/screen/supplier_screen/task_update.dart';
import 'package:glad/utils/color_resources.dart';
import 'package:glad/utils/extension.dart';
import 'package:glad/utils/images.dart';
import 'package:glad/utils/styles.dart';
import 'package:intl/intl.dart';

class SupplierProjectMilestoneDetail extends StatefulWidget {
  const SupplierProjectMilestoneDetail({super.key, required this.milestoneId,required this.projectStatus,this.farmerLogin,this.selectedFilter,required this.navigateScreen,required this.projectId});
  final int milestoneId,projectId;
  final String projectStatus,navigateScreen;
  final String? farmerLogin;
  final String? selectedFilter;

  @override
  State<SupplierProjectMilestoneDetail> createState() =>
      _SupplierProjectMilestoneDetailState();
}

class _SupplierProjectMilestoneDetailState
    extends State<SupplierProjectMilestoneDetail> {
  @override
  void initState() {
    BlocProvider.of<ProjectCubit>(context)
        .farmerProjectMilestoneDetailApi(context, widget.milestoneId);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocBuilder<ProjectCubit, ProjectState>(builder: (context, state) {
        if (state.status == ProjectStatus.loading) {
          return const Center(
              child: CircularProgressIndicator(
                color: ColorResources.maroon,
              ));
        } else if (state.responseFarmerProjectMilestoneDetail == null) {
          return Center(
              child: Text("${state.responseFarmerProjectMilestoneDetail} Api Error"));
        } else {
          return Stack(
            children: [
              landingBackground(),
              Column(
                children: [
                  CustomAppBar(
                    context: context,
                    centerTitle: true,
                    titleText1: state.responseFarmerProjectMilestoneDetail!.data!.milestoneDetails![0].milestoneTitle ?? '',
                    titleText1Style: figtreeMedium.copyWith(
                        fontSize: 20, color: Colors.black),

                    // leading: arrowBackButton(),
                    leading: InkWell(
                        onTap: (){
                          // arrowBackButton();
                          pressBack();
                          context.read<ProjectCubit>().farmerProjectDetailApi(context,widget.projectId);
                        },child: const Icon(Icons.arrow_back)),
                    /*action: widget.selectedFilter == "pending"?InkWell(
                        onTap: () {
                          const EditMilestone().navigate();
                        },
                        child: SvgPicture.asset(Images.profileEdit)):const SizedBox.shrink(),*/
                  ),
                  Expanded(
                      child: SingleChildScrollView(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              description(state),
                              dividerValue(state),
                              attributes(state),
                              mileStoneDeliverable(state),
                              uploadedPictures(state),
                            ],
                          )))
                ],
              )
            ],
          );
        }
      }),
    );
  }

  ///////DescriptionDetails///////////
  Widget description(ProjectState state) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(24, 20, 24, 0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Description',
                style: figtreeMedium.copyWith(fontSize: 18),
              ),
              05.horizontalSpace(),
              10.verticalSpace(),
              Text(
                state.responseFarmerProjectMilestoneDetail!.data!.milestoneDetails![0].milestoneDescription ?? '',
                style: figtreeMedium.copyWith(fontSize: 14),
              )
            ],
          ),
          Builder(
              builder: (context) {
                int count = 0;
                for( FarmerProjectTask mile in state.responseFarmerProjectMilestoneDetail!.data!.milestoneDetails![0].farmerProjectTask!) {
                  if(mile.taskStatus == 'approved') {
                    count++;
                  }
                }
                return Stack(
                  alignment: Alignment.center,
                  children: [
                    CircularPercentIndicator(
                      radius: 30,
                      percent: count / state.responseFarmerProjectMilestoneDetail!.data!.milestoneDetails![0].farmerProjectTask!.length,
                      progressColor: const Color(0xFF12CE57),
                      backgroundColor: const Color(0xFFDCEAE5),
                    ),
                    RichText(
                      softWrap: false,
                      text: TextSpan(children: [
                        TextSpan(
                            text: removeZeroesInFraction(((count / state.responseFarmerProjectMilestoneDetail!.data!.milestoneDetails![0].farmerProjectTask!.length) * 100).toString()),
                            style: figtreeBold.copyWith(
                                color: Colors.black,
                                fontSize: 16)),
                        TextSpan(
                            text: '%\n',
                            style: figtreeBold.copyWith(
                                color: Colors.black,
                                fontSize: 9)),
                        TextSpan(
                            text: 'completed',
                            style: figtreeBold.copyWith(
                                color:
                                const Color(0xFF808080),
                                fontSize: 6))
                      ]),
                      textAlign: TextAlign.center,
                    )
                  ],
                );
              }
          )
        ],
      ),
    );
  }

///////DividerValue///////////
  Widget dividerValue(ProjectState state) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(24, 0, 24, 0),
      child: Column(
        children: [
          30.verticalSpace(),
          const Divider(
            thickness: 1,
          ),
          10.verticalSpace(),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Value',
                    style: figtreeMedium.copyWith(fontSize: 14),
                  ),
                  Text(
                    getCurrencyString(state.responseFarmerProjectMilestoneDetail!.data!.milestoneDetails![0].milestoneValue ?? 0),
                    style: figtreeSemiBold.copyWith(
                        fontSize: 16, color: ColorResources.maroon),
                  ),
                ],
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Duration',
                    style: figtreeMedium.copyWith(fontSize: 14),
                  ),
                  Text(
                    '${state.responseFarmerProjectMilestoneDetail!.data!.milestoneDetails![0].milestoneDuration ?? ''} days',
                    style: figtreeSemiBold.copyWith(fontSize: 16),
                  ),
                ],
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Due Date',
                    style: figtreeMedium.copyWith(fontSize: 14),
                  ),
                  Text(
                    state.responseFarmerProjectMilestoneDetail!.data!.milestoneDetails![0].milestoneDueDate != null ? DateFormat('dd MMM, yyyy').format(DateTime.parse(state.responseFarmerProjectMilestoneDetail!.data!.milestoneDetails![0].milestoneDueDate.toString())) : '',
                    style: figtreeSemiBold.copyWith(fontSize: 16),
                  ),
                ],
              ),
            ],
          ),
          10.verticalSpace(),
          const Divider(
            thickness: 1,
          ),
        ],
      ),
    );
  }

  ////////Attributes///////////
  Widget attributes(ProjectState state) {
    // print(state.responseFarmerProjectMilestoneDetail!.data!.milestoneDetails![0].farmerProjectResourcePrice);
    return Column(
      children: [
        20.verticalSpace(),
        Padding(
          padding: const EdgeInsets.fromLTRB(24, 0, 24, 0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Resources',
                style: figtreeMedium.copyWith(fontSize: 18),
              ),
              05.horizontalSpace(),
              widget.farmerLogin==null ?
              widget.selectedFilter.toString() == "pending"?
              InkWell(
                onTap: () {
                  /*context.read<ProjectCubit>().getSelectedAttribute(
                      'Select Material Name',
                      'Select Type',
                      'Select Size Capacity',
                      '',
                      '',
                      '');
                  const AttributesAdd().navigate();*/
                  BlocProvider.of<ProjectCubit>(context).emit(state.copyWith(
                    materialNameController: TextEditingController()..clear(),
                    resourceTypeController: TextEditingController()..clear(),
                    resourceCapacityController: TextEditingController()..clear(),
                    requiredQtyController: TextEditingController()..clear(),
                    pricePerUnitController: TextEditingController()..clear(),
                    valueController: TextEditingController()..clear(),
                    uomController: TextEditingController()..clear(),
                  ));
                  const AddDdeResources().navigate();
                },
                child: Container(
                  padding:
                  const EdgeInsets.symmetric(vertical: 8, horizontal: 15),
                  decoration: boxDecoration(
                    backgroundColor: ColorResources.white,
                    borderWidth: 1,
                    borderRadius: 160,
                    borderColor: const Color(0xff6A0030),
                  ),
                  child: Text(
                    "Add",
                    textAlign: TextAlign.center,
                    style: figtreeMedium.copyWith(
                        color: const Color(0xff6A0030), fontSize: 10),
                  ),
                ),
              ):const SizedBox.shrink():const SizedBox.shrink()
            ],
          ),
        ),
        state.responseFarmerProjectMilestoneDetail!.data!.milestoneDetails![0].farmerProjectResourcePrice!.isNotEmpty?20.verticalSpace():0.verticalSpace(),
        SizedBox(
          height: state.responseFarmerProjectMilestoneDetail!.data!.milestoneDetails![0].farmerProjectResourcePrice!.isNotEmpty?265:0,
          child: customList(
              padding: const EdgeInsets.only(left: 0),
              axis: Axis.horizontal,
              scrollPhysics: const BouncingScrollPhysics(),
              list: state.responseFarmerProjectMilestoneDetail!.data!.milestoneDetails![0].farmerProjectResourcePrice!,
              child: (index) => state.responseFarmerProjectMilestoneDetail!.data!.milestoneDetails![0].farmerProjectResourcePrice![index].notRequired==1?
              const SizedBox.shrink():
              SizedBox(
                height: 200,
                width: screenWidth()-25,
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(5, 0, 0, 0),
                  child: customShadowContainer(
                      backColor: ColorResources.grey,
                      child: Padding(
                        padding: const EdgeInsets.fromLTRB(20, 5, 20, 0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [

                            10.verticalSpace(),

                            widget.farmerLogin==null ?
                            widget.selectedFilter.toString() == "pending"?
                            Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [

                                InkWell(
                                    onTap: (){
                                      AttributesEditDdeResource(index:index).navigate();
                                      // AttributesEdit(index:index).navigate();
                                      context.read<ProjectCubit>().getSelectedAttribute(
                                        state.responseFarmerProjectMilestoneDetail!.data!.milestoneDetails![0].farmerProjectResourcePrice![index].resourceName??'',
                                        state.responseFarmerProjectMilestoneDetail!.data!.milestoneDetails![0].farmerProjectResourcePrice![index].resourceType??'',
                                        state.responseFarmerProjectMilestoneDetail!.data!.milestoneDetails![0].farmerProjectResourcePrice![index].resourceCapacity??'',
                                        state.responseFarmerProjectMilestoneDetail!.data!.milestoneDetails![0].farmerProjectResourcePrice![index].resourceUom??'',
                                        state.responseFarmerProjectMilestoneDetail!.data!.milestoneDetails![0].farmerProjectResourcePrice![index].resourceSize.toString()??'',
                                        state.responseFarmerProjectMilestoneDetail!.data!.milestoneDetails![0].farmerProjectResourcePrice![index].resourcePrice.toString()??'',
                                      );
                                      state.valueController.text = state.responseFarmerProjectMilestoneDetail!.data!.milestoneDetails![0].farmerProjectResourcePrice![index].resourceValue.toString()??'';
                                      /*AttributesEdit(index:index).navigate();
                                      context.read<ProjectCubit>().getSelectedAttribute(
                                        state.responseFarmerProjectMilestoneDetail!.data!.milestoneDetails![0].farmerProjectResourcePrice![index].resourceName??'',
                                        state.responseFarmerProjectMilestoneDetail!.data!.milestoneDetails![0].farmerProjectResourcePrice![index].resourceType??'',
                                        state.responseFarmerProjectMilestoneDetail!.data!.milestoneDetails![0].farmerProjectResourcePrice![index].resourceCapacity??'',
                                        state.responseFarmerProjectMilestoneDetail!.data!.milestoneDetails![0].farmerProjectResourcePrice![index].resourceUom??'',
                                        state.responseFarmerProjectMilestoneDetail!.data!.milestoneDetails![0].farmerProjectResourcePrice![index].resourceSize.toString()??'',
                                        state.responseFarmerProjectMilestoneDetail!.data!.milestoneDetails![0].farmerProjectResourcePrice![index].resourcePrice.toString()??'',
                                      );
                                      state.valueController.text = state.responseFarmerProjectMilestoneDetail!.data!.milestoneDetails![0].farmerProjectResourcePrice![index].resourceValue.toString()??'';*/
                                    },child: Image.asset(Images.editIcon,width: 24,height: 24,)),
                                15.horizontalSpace(),
                                InkWell(
                                    onTap: (){
                                      BlocProvider.of<ProjectCubit>(context).deleteAttributeApi(context,
                                        state.responseFarmerProjectMilestoneDetail!.data!.milestoneDetails![0].farmerProjectResourcePrice![index].id.toString(),
                                        state.responseFarmerProjectMilestoneDetail!.data!.milestoneDetails![0].id.toString(),
                                        // widget.projectId
                                      );
                                    },child: Image.asset(Images.deleteIcon,width: 24,height: 24,)),

                              ],
                            ):const SizedBox.shrink():const SizedBox.shrink(),
                            10.verticalSpace(),
                            customAttribute("Material -",
                                state.responseFarmerProjectMilestoneDetail!.data!.milestoneDetails![0].farmerProjectResourcePrice!=null?state.responseFarmerProjectMilestoneDetail!.data!.milestoneDetails![0].farmerProjectResourcePrice![index].resourceName??'':''),
                            10.verticalSpace(),
                            customAttribute("Type",
                                state.responseFarmerProjectMilestoneDetail!.data!.milestoneDetails![0].farmerProjectResourcePrice!=null?state.responseFarmerProjectMilestoneDetail!.data!.milestoneDetails![0].farmerProjectResourcePrice![index].resourceType??'':''),
                            10.verticalSpace(),
                            customAttribute("Size/capacity",
                                state.responseFarmerProjectMilestoneDetail!.data!.milestoneDetails![0].farmerProjectResourcePrice!=null?state.responseFarmerProjectMilestoneDetail!.data!.milestoneDetails![0].farmerProjectResourcePrice![index].resourceCapacity??'':''),
                            10.verticalSpace(),
                            Row(

                              children: [
                                Expanded(child: customAttribute("QTY", '${(
                                    state.responseFarmerProjectMilestoneDetail!.data!.milestoneDetails![0].farmerProjectResourcePrice!=null?state.responseFarmerProjectMilestoneDetail!.data!.milestoneDetails![0].farmerProjectResourcePrice![index].resourceSize??'':'')} ${state.responseFarmerProjectMilestoneDetail!.data!.milestoneDetails![0].farmerProjectResourcePrice![index].resourceUom??''}')),
                                Container(height: 25,width: 1,color: Colors.grey),
                                Expanded(child: customAttribute("Price", getCurrencyString(double.parse(state.responseFarmerProjectMilestoneDetail!.data!.milestoneDetails![0].farmerProjectResourcePrice![index].resourcePrice.toString()??'0')))),
                              ],
                            ),
                            10.verticalSpace(),

                            customAttribute("Value", " ${getCurrencyString(state.responseFarmerProjectMilestoneDetail!.data!.milestoneDetails![0].farmerProjectResourcePrice![index].resourceValue??0)}"),
                            // 40.verticalSpace(),
                          ],
                        ),
                      )),
                ),
              )
          ),
        )
      ],
    );
  }

  ////////Milestone Deliverable//////////////
  Widget mileStoneDeliverable(ProjectState state) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        30.verticalSpace(),
        Padding(
          padding: const EdgeInsets.fromLTRB(24, 0, 24, 0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Milestone deliverables',
                style: figtreeMedium.copyWith(fontSize: 18),
              ),

              // widget.farmerLogin==null ?
              // widget.selectedFilter.toString() == "pending"?
              // InkWell(
              //   onTap: (){
              //     TextEditingController controller = TextEditingController();
              //     modalBottomSheetMenu(context,
              //         radius: 40,
              //         child: StatefulBuilder(
              //             builder: (context, setState) {
              //               return SizedBox(
              //                 height: 320,
              //                 child: Padding(
              //                   padding: const EdgeInsets.fromLTRB(23, 40, 25, 10),
              //                   child: Column(
              //                       crossAxisAlignment: CrossAxisAlignment.start,
              //                       children: [
              //                         Center(
              //                           child: Text(
              //                             'Add Task',
              //                             style: figtreeMedium.copyWith(fontSize: 22),
              //                           ),
              //                         ),
              //                         30.verticalSpace(),
              //
              //                         Column(
              //                           crossAxisAlignment: CrossAxisAlignment.start,
              //                           children: [
              //                             Text(
              //                               'Task Name',
              //                               style: figtreeMedium.copyWith(fontSize: 12),
              //                             ),
              //                             5.verticalSpace(),
              //                             TextField(
              //                               controller: controller,
              //                               maxLines: 1,
              //                               minLines: 1,
              //                               decoration: InputDecoration(
              //                                   hintText: 'Enter task name',
              //                                   hintStyle:
              //                                   figtreeMedium.copyWith(fontSize: 18),
              //                                   border: OutlineInputBorder(
              //                                       borderRadius: BorderRadius.circular(12),
              //                                       borderSide: const BorderSide(
              //                                         width: 1,
              //                                         color: Color(0xff999999),
              //                                       ))),
              //                             ),
              //                             30.verticalSpace(),
              //                             Padding(
              //                               padding: const EdgeInsets.fromLTRB(28, 0, 29, 0),
              //                               child: customButton(
              //                                 'Submit',
              //                                 fontColor: 0xffFFFFFF,
              //                                 onTap: () {
              //                                   BlocProvider.of<ProjectCubit>(context).addTaskApi(context,state.responseFarmerProjectMilestoneDetail!.data!.milestoneDetails![0].farmerId.toString(),state.responseFarmerProjectMilestoneDetail!.data!.milestoneDetails![0].farmerProjectId.toString(),state.responseFarmerProjectMilestoneDetail!.data!.milestoneDetails![0].id.toString(),
              //                                       controller.text,widget.milestoneId
              //                                   );
              //                                 },
              //                                 height: 60,
              //                                 width: screenWidth(),
              //                               ),
              //                             )
              //                           ],
              //                         )
              //                       ]),
              //                 ),
              //               );
              //             }
              //         ));
              //   },
              //   child: Container(
              //     padding:
              //     const EdgeInsets.symmetric(vertical: 8, horizontal: 15),
              //     decoration: boxDecoration(
              //       backgroundColor: ColorResources.white,
              //       borderWidth: 1,
              //       borderRadius: 160,
              //       borderColor: const Color(0xff6A0030),
              //     ),
              //     child: Text(
              //       "Add",
              //       textAlign: TextAlign.center,
              //       style: figtreeMedium.copyWith(
              //           color: const Color(0xff6A0030), fontSize: 10),
              //     ),
              //   ),
              // ):
              // const SizedBox.shrink():const SizedBox.shrink()

            ],
          ),
        ),
        10.verticalSpace(),
        Padding(
          padding: const EdgeInsets.fromLTRB(20, 0, 20, 20),
          child: customList(
              list: List.generate(state.responseFarmerProjectMilestoneDetail!.data!.milestoneDetails![0].farmerProjectTask!.length, (index) => null),
              child: (int index) {
                 return InkWell(
                   onTap: () {
                     if(state.responseFarmerProjectMilestoneDetail!.data!.milestoneDetails![0].farmerProjectTask![index].taskStatus != 'pending' &&
                         state.responseFarmerProjectMilestoneDetail!.data!.milestoneDetails![0].farmerProjectTask![index].taskStatus != 'inprogress' &&
                         state.responseFarmerProjectMilestoneDetail!.data!.milestoneDetails![0].farmerProjectTask![index].taskStatus != 'rejected') {
                       TaskDetail(
                           task: state.responseFarmerProjectMilestoneDetail!
                               .data!.milestoneDetails![0]
                               .farmerProjectTask![index], approve: false,).navigate();
                     } else {
                       TaskUpdate(
                           task: state.responseFarmerProjectMilestoneDetail!
                               .data!.milestoneDetails![0]
                               .farmerProjectTask![index]).navigate();
                     }
                   },
                   child: Container(
                    // height: 60,
                    margin: const EdgeInsets.fromLTRB(0, 10, 0, 5),
                    decoration: BoxDecoration(
                        color: Colors.white,
                        border: Border.all(width: 1, color: ColorResources.grey),
                        borderRadius: BorderRadius.circular(14)),
                    child: Padding(
                      padding: const EdgeInsets.fromLTRB(20, 10, 20, 10),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                state.responseFarmerProjectMilestoneDetail!.data!.milestoneDetails![0].farmerProjectTask![index].taskName ?? '',
                                style: figtreeMedium.copyWith(fontSize: 14),
                              ),
                              checkBox2(value: state.responseFarmerProjectMilestoneDetail!.data!.milestoneDetails![0].farmerProjectTask![index].taskStatus == 'approved' , opacity: 0.4)
                              // widget.selectedFilter == "pending"?
                              // Padding(
                              //   padding: const EdgeInsets.all(10.0),
                              //   child: InkWell(
                              //       onTap: (){
                              //         BlocProvider.of<ProjectCubit>(context).deleteTaskApi(context,
                              //             state.responseFarmerProjectMilestoneDetail!.data!.milestoneDetails![0].farmerProjectTask![index].id.toString(),widget.milestoneId
                              //         );
                              //       }
                              //       ,child: Image.asset(Images.deleteIcon,width: 24,height: 24,)),
                              // ):const SizedBox.shrink()
                            ],
                          ),
                          5.verticalSpace(),
                          state.responseFarmerProjectMilestoneDetail!.data!.milestoneDetails![0].farmerProjectTask![index].taskStatus == 'pending' ? Text(
                            formatProjectStatus(state.responseFarmerProjectMilestoneDetail!.data!.milestoneDetails![0].farmerProjectTask![index].taskStatus ?? ''),
                            style: figtreeMedium.copyWith(fontSize: 14, color: const Color(0xFFFC5E60)),
                          ) : state.responseFarmerProjectMilestoneDetail!.data!.milestoneDetails![0].farmerProjectTask![index].taskStatus == 'inprogress' ? Text(
                            'In-progress',
                            style: figtreeMedium.copyWith(fontSize: 14, color: const Color(0xFFF6B51D)),
                          ) : state.responseFarmerProjectMilestoneDetail!.data!.milestoneDetails![0].farmerProjectTask![index].taskStatus == 'rejected' ? Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                DateFormat('dd MMM, yyyy').format(DateTime.parse(state.responseFarmerProjectMilestoneDetail!.data!.milestoneDetails![0].farmerProjectTask![index].taskApproveRejectDate ?? '')),
                                style: figtreeMedium.copyWith(fontSize: 14, color: Colors.black),
                              ),
                              10.verticalSpace(),
                              Text(
                                'Not Approved',
                                style: figtreeMedium.copyWith(fontSize: 14, color: const Color(0xFF999999)),
                              ),
                            ],
                          ) : state.responseFarmerProjectMilestoneDetail!.data!.milestoneDetails![0].farmerProjectTask![index].taskStatus == 'approved' ? Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                DateFormat('dd MMM, yyyy').format(DateTime.parse(state.responseFarmerProjectMilestoneDetail!.data!.milestoneDetails![0].farmerProjectTask![index].taskApproveRejectDate ?? '')),
                                style: figtreeMedium.copyWith(fontSize: 14, color: Colors.black),
                              ),
                              10.verticalSpace(),
                              Text(
                                'Approved',
                                style: figtreeMedium.copyWith(fontSize: 14, color: const Color(0xFF999999)),
                              ),
                            ],
                          ) : Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                DateFormat('dd MMM, yyyy').format(DateTime.parse(state.responseFarmerProjectMilestoneDetail!.data!.milestoneDetails![0].farmerProjectTask![index].taskCompletionDate ?? '')),
                                style: figtreeMedium.copyWith(fontSize: 14, color: Colors.black),
                              ),
                              10.verticalSpace(),
                              Text(
                                formatProjectStatus(state.responseFarmerProjectMilestoneDetail!.data!.milestoneDetails![0].farmerProjectTask![index].taskStatus ?? ''),
                                style: figtreeMedium.copyWith(fontSize: 14, color: const Color(0xFF999999)),
                              )
                            ],
                          ),
                        ],
                      ),
                    ),
                ),
                 );
              }),
        )
      ],
    );
  }

  ////////Uploaded Pictures//////////////
  Widget uploadedPictures(ProjectState state) {
    return Builder(
      builder: (context) {
        List<Media> images = [];
        for(FarmerProjectTask task in state.responseFarmerProjectMilestoneDetail!.data!.milestoneDetails![0].farmerProjectTask!) {
          images.addAll(task.media as Iterable<Media>);
        }
        if(images.isEmpty) {
          return const SizedBox.shrink();
        }
        print(images);
        return Padding(
          padding: const EdgeInsets.fromLTRB(24, 0, 24, 0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Uploaded pictures',
                style: figtreeMedium.copyWith(fontSize: 18),
              ),
              20.verticalSpace(),
              customGrid(context,
                  mainAxisSpacing: 20,
                  crossAxisSpacing: 10,
                  childAspectRatio: 1.2,
                  list: images, child: (index) {
                    return InkWell(
                      onTap: () {
                        PreviewScreen(previewImage: images[index].originalUrl ?? '').navigate();
                      },
                      child: Stack(
                        alignment: Alignment.center,
                        children: [
                          ClipRRect(
                              borderRadius: BorderRadius.circular(14),
                              child: CachedNetworkImage(imageUrl: images[index].originalUrl ?? '', fit: BoxFit.fitWidth,width: screenWidth(),)),
                          Positioned(
                            bottom: 10,
                            right: 10,
                            child: Container(
                              alignment: Alignment.center,
                              height:35,
                              width: 80,
                              decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(170)),
                                padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
                                child: Text(DateFormat('dd MMM, yy').format(DateTime.parse(images[index].createdAt!)), style: figtreeMedium.copyWith(fontSize: 12),)),
                          )
                        ],
                      ),
                    );
                  }),
              20.verticalSpace()
            ],
          ),
        );
      }
    );
  }

  Widget customAttribute(String attributeName, String attributeData) {
    return Container(
      height: 32,
      padding: const EdgeInsets.only(left: 15, right: 15),
      decoration: BoxDecoration(
          color: ColorResources.containerColor,
          borderRadius: BorderRadius.circular(06)),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            child: Text(
              attributeName,
              style: figtreeMedium.copyWith(fontSize: 14),
            ),
          ),

          Text(
            attributeData,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: figtreeMedium.copyWith(fontSize: 14),
          ),
        ],
      ),
    );
  }
}



/*
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:glad/screen/custom_widget/custom_appbar.dart';
import 'package:glad/screen/custom_widget/custom_methods.dart';
import 'package:glad/screen/supplier_screen/edit_milestone.dart';
import 'package:glad/utils/color_resources.dart';
import 'package:glad/utils/extension.dart';
import 'package:glad/utils/images.dart';
import 'package:glad/utils/styles.dart';

class MilestoneDetail extends StatelessWidget {
  const MilestoneDetail({super.key});

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
                titleText1: 'Installation of water tank',
                titleText1Style:
                    figtreeMedium.copyWith(fontSize: 20, color: Colors.black),
                leading: arrowBackButton(),
                centerTitle: true,
                action: InkWell(
                    onTap: () {
                      const EditMilestone().navigate();
                    },
                    child: SvgPicture.asset(Images.profileEdit)),
              ),
              Expanded(
                  child: SingleChildScrollView(
                      child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          description(),
                          dividerValue(),
                          attributes(),
                          mileStoneDeliverable(),
                        ],
                      )))
            ],
          )
        ],
      ),
    );
  }

  ///////DescriptionDetails///////////
  Widget description() {
    return Padding(
      padding: const EdgeInsets.fromLTRB(24, 20, 24, 0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Description',
            style: figtreeMedium.copyWith(fontSize: 18),
          ),
          05.horizontalSpace(),
          10.verticalSpace(),
          Text(
            "Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries dummy text ever since the 1500s.",
            style: figtreeMedium.copyWith(fontSize: 14),
          )
        ],
      ),
    );
  }

///////DividerValue///////////
  Widget dividerValue() {
    return Padding(
      padding: const EdgeInsets.fromLTRB(24, 0, 24, 0),
      child: Column(
        children: [
          30.verticalSpace(),
          const Divider(
            thickness: 1,
          ),
          10.verticalSpace(),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Value',
                style: figtreeMedium.copyWith(fontSize: 14),
              ),
              Text(
                'Duration',
                style: figtreeMedium.copyWith(fontSize: 14),
              ),
            ],
          ),
          05.verticalSpace(),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'UGX 700K',
                style: figtreeSemiBold.copyWith(
                    fontSize: 16, color: ColorResources.maroon),
              ),
              Text(
                '12 days',
                style: figtreeSemiBold.copyWith(fontSize: 16),
              ),
            ],
          ),
          10.verticalSpace(),
          const Divider(
            thickness: 1,
          ),
        ],
      ),
    );
  }

  ////////Attributes///////////
  Widget attributes() {
    return Column(
      children: [
        20.verticalSpace(),
        Padding(
          padding: const EdgeInsets.fromLTRB(24, 0, 24, 0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Text(
                'Attributes',
                style: figtreeMedium.copyWith(fontSize: 18),
              ),
            ],
          ),
        ),
        20.verticalSpace(),
        Padding(
          padding: const EdgeInsets.fromLTRB(15, 0, 15, 0),
          child: customShadowContainer(
              backColor: ColorResources.grey,
              child: Padding(
                padding: const EdgeInsets.fromLTRB(20, 18, 20, 0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    customAttribute("Type", "Plastic"),
                    10.verticalSpace(),
                    customAttribute("Size/capacity", "5000Ltr"),
                    10.verticalSpace(),
                    customAttribute("Quantity", "02 NOS"),
                    10.verticalSpace(),
                    customAttribute("Price", "UGX 100K"),
                    40.verticalSpace(),
                  ],
                ),
              )),
        )
      ],
    );
  }

  ////////Milestone Deliverable//////////////
  Widget mileStoneDeliverable() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        30.verticalSpace(),
        Padding(
          padding: const EdgeInsets.fromLTRB(24, 0, 24, 0),
          child: Text(
            'Milestone deliverables',
            style: figtreeMedium.copyWith(fontSize: 18),
          ),
        ),
        10.verticalSpace(),
        Padding(
          padding: const EdgeInsets.fromLTRB(20, 0, 20, 20),
          child: customList(child: (
            int index,
          ) {
            return Container(
              height: 60,
              margin: const EdgeInsets.fromLTRB(0, 10, 0, 5),
              decoration: BoxDecoration(
                  color: Colors.white,
                  border: Border.all(width: 1, color: ColorResources.grey),
                  borderRadius: BorderRadius.circular(14)),
              child: Padding(
                padding: const EdgeInsets.fromLTRB(20, 0, 5, 0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Various versions have evolved',
                      style: figtreeMedium.copyWith(fontSize: 14),
                    ),
                    Container(
                      height: 50,
                      width: 50,
                      decoration: BoxDecoration(
                          color: ColorResources.pinkMain,
                          borderRadius: BorderRadius.circular(14)),
                      child: Center(
                          child: Text(
                        '01',
                        style: figtreeMedium.copyWith(fontSize: 14),
                      )),
                    )
                  ],
                ),
              ),
            );
          }),
        )
      ],
    );
  }

  Widget customAttribute(String attributeName, String attributeData) {
    return Container(
      height: 32,
      padding: const EdgeInsets.only(left: 20, right: 20),
      decoration: BoxDecoration(
          color: ColorResources.containerColor,
          borderRadius: BorderRadius.circular(06)),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            child: Text(
              attributeName,
              style: figtreeMedium.copyWith(fontSize: 14),
            ),
          ),
          Expanded(
            child: Text(
              attributeData,
              style: figtreeMedium.copyWith(fontSize: 14),
            ),
          ),
        ],
      ),
    );
  }
}
*/
