import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:glad/cubit/project_cubit/project_cubit.dart';
import 'package:glad/data/model/farmer_project_milestone_detail_model.dart';
import 'package:glad/screen/common/approve_milestone.dart';
import 'package:glad/screen/custom_widget/circular_percent_indicator.dart';
import 'package:glad/screen/custom_widget/custom_appbar.dart';
import 'package:glad/screen/custom_widget/custom_methods.dart';
import 'package:glad/screen/dde_screen/add_dde_resources.dart';
import 'package:glad/screen/dde_screen/preview_screen.dart';
import 'package:glad/screen/dde_screen/suggested_investment.dart';
import 'package:glad/screen/dde_screen/update_dde_resource.dart';
import 'package:glad/screen/farmer_screen/common/add_attribute.dart';
import 'package:glad/screen/farmer_screen/common/attributes_edit.dart';
import 'package:glad/screen/supplier_screen/task_detail.dart';
import 'package:glad/utils/color_resources.dart';
import 'package:glad/utils/extension.dart';
import 'package:glad/utils/images.dart';
import 'package:glad/utils/styles.dart';
import 'package:intl/intl.dart';

class DdeMilestoneDetail extends StatefulWidget {
  const DdeMilestoneDetail({super.key, required this.milestoneId,required this.projectStatus,required this.navigateScreen,required this.projectId});
  final int milestoneId,projectId;
  final String projectStatus,navigateScreen;

  @override
  State<DdeMilestoneDetail> createState() =>
      _DdeMilestoneDetailState();
}

class _DdeMilestoneDetailState
    extends State<DdeMilestoneDetail> {
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
                    titleText1: state.responseFarmerProjectMilestoneDetail!.data!.milestoneDetails![0].milestoneTitle ?? '',
                    titleText1Style: figtreeMedium.copyWith(
                        fontSize: 20, color: Colors.black),
                    leading: arrowBackButton(onTap: (){
                      if(widget.navigateScreen == ""){
                        pressBack();
                        context.read<ProjectCubit>().farmerProjectDetailApi(context,widget.projectId);
                      }else{
                        DDeFarmerInvestmentDetails(projectId: widget.projectId,).navigate(isRemove: true);
                      }
                    }),
                    // leading: arrowBackButton(),
                  ),
                  // Stack(
                  //   alignment: Alignment.centerLeft,
                  //   children: [
                  //     Center(
                  //       child: Text(
                  //         'Installation of water tank...',
                  //         style: figtreeMedium.copyWith(fontSize: 22),
                  //       ),
                  //     ),
                  //     Positioned(
                  //         child: IconButton(
                  //             onPressed: () {
                  //               Navigator.pop(context);
                  //             },
                  //             icon: const Icon(Icons.arrow_back))),
                  //   ],
                  // ),
                  Expanded(
                      child: SingleChildScrollView(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              description(state),
                              dividerValue(state),
                              attributes(state),
                              // state.responseFarmerProjectMilestoneDetail!.data!.milestoneDetails![0].farmerProjectResourcePrice==0?
                              //  attributes(state) :const SizedBox.shrink(),
                              mileStoneDeliverable(state),
                              if(widget.projectStatus == 'active')
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

  ////////Uploaded Pictures//////////////
  Widget uploadedPictures(ProjectState state) {
    return Builder(
        builder: (context) {
          List<Media> images = [];
          for(FarmerProjectTask task in state.responseFarmerProjectMilestoneDetail!.data!.milestoneDetails![0].farmerProjectTask!) {
            images.addAll(task.media as Iterable<Media>);
          }
          if(images.isEmpty) {
            return SizedBox.shrink();
          }
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

  ///////DescriptionDetails///////////
  Widget description(ProjectState state) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(24, 20, 24, 0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Description',
                  style: figtreeMedium.copyWith(fontSize: 18),
                ),
                // 05.horizontalSpace(),
                10.verticalSpace(),
                Text(
                  state.responseFarmerProjectMilestoneDetail!.data!.milestoneDetails![0].milestoneDescription ?? '',
                  style: figtreeMedium.copyWith(fontSize: 14),
                )
              ],
            ),
          ),
          if(widget.projectStatus == 'active')
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
    return widget.projectStatus == 'active' ? Padding(
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
    ) : Padding(
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
                getCurrencyString(state.responseFarmerProjectMilestoneDetail!.data!.milestoneDetails![0].milestoneValue ?? 0),
                style: figtreeSemiBold.copyWith(
                    fontSize: 16, color: ColorResources.maroon),
              ),
              Text(
                '${state.responseFarmerProjectMilestoneDetail!.data!.milestoneDetails![0].milestoneDuration ?? ''} days',
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
  Widget attributes(ProjectState state) {
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
              // widget.farmerLogin==null ?
              widget.projectStatus.toString().toUpperCase() == "interested".toUpperCase()?
              InkWell(
                onTap: () {
                  /*context.read<ProjectCubit>().getSelectedAttribute(
                      'Select Material Name',
                      'Select Type',
                      'Select Size Capacity',
                      '',
                      '',
                      '');*/
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
                  // const AttributesAdd().navigate();

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
              ):const SizedBox.shrink()
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
              child: (index) => state.responseFarmerProjectMilestoneDetail!.data!.milestoneDetails![0].farmerProjectResourcePrice![index].notRequired == 1?
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

                            widget.projectStatus.toString().toUpperCase() == "interested".toUpperCase()?
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
                                    },child: Image.asset(Images.editIcon,width: 24,height: 24,)),
                                15.horizontalSpace(),
                                InkWell(
                                    onTap: (){
                                      BlocProvider.of<ProjectCubit>(context).deleteAttributeApi(context,
                                        state.responseFarmerProjectMilestoneDetail!.data!.milestoneDetails![0].farmerProjectResourcePrice![index].id.toString(),
                                        state.responseFarmerProjectMilestoneDetail!.data!.milestoneDetails![0].id.toString(),
                                        // widget.projectId
                                      );
                                    }
                                    ,child: Image.asset(Images.deleteIcon,width: 24,height: 24,)),

                              ],
                            ):const SizedBox.shrink(),
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
        ),
      ],
    );
  }

  ////////Milestone Deliverable//////////////
  Widget mileStoneDeliverable(ProjectState state) {
    return widget.projectStatus == 'active' ? Column(
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
                    if(state.responseFarmerProjectMilestoneDetail!.data!.milestoneDetails![0].farmerProjectTask![index].taskStatus != 'completed') {
                      TaskDetail(
                        task: state.responseFarmerProjectMilestoneDetail!
                            .data!.milestoneDetails![0]
                            .farmerProjectTask![index], approve: false,).navigate();
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
                              checkBox2(value: state.responseFarmerProjectMilestoneDetail!.data!.milestoneDetails![0].farmerProjectTask![index].taskStatus == 'approved', opacity: 0.4)
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
                          ) : state.responseFarmerProjectMilestoneDetail!.data!.milestoneDetails![0].farmerProjectTask![index].taskStatus == 'completed' ? InkWell(
                            onTap: () {
                              TaskDetail(
                                task: state.responseFarmerProjectMilestoneDetail!
                                    .data!.milestoneDetails![0]
                                    .farmerProjectTask![index], approve: true,).navigate();
                            },
                            child: Container(
                              padding: const EdgeInsets.symmetric(vertical: 4, horizontal: 7),
                              decoration: boxDecoration(
                                borderWidth: 1,
                                borderRadius: 30,
                                borderColor: const Color(0xff6A0030),
                              ),
                              child: Text(
                                'Approve',
                                textAlign: TextAlign.center,
                                style: figtreeMedium.copyWith(
                                    color: const Color(0xff6A0030), fontSize: 14),
                              ),
                            ),
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
        ),
        if(state.responseFarmerProjectMilestoneDetail!.data!.milestoneDetails![0].milestoneStatus != 'approved')
          Builder(
              builder: (context) {
                bool approve = true;
                for (FarmerProjectTask task in state.responseFarmerProjectMilestoneDetail!.data!.milestoneDetails![0].farmerProjectTask!){
                  if(task.taskStatus != "approved") {
                    approve = false;
                  }
                }
                return approve ?
                Container(
                    margin: 20.marginAll(),
                    height: 55,
                    width: screenWidth(),
                    child: customButton("Approve Milestone",
                        fontColor: 0xffffffff,
                        onTap: () {
                          ApproveMilestone(projectData: BlocProvider.of<ProjectCubit>(context).state.responseFarmerProjectDetail!.data!.farmerProject![0].farmerMaster!,
                            farmerProjectId: state.responseFarmerProjectMilestoneDetail!.data!.milestoneDetails![0].farmerProjectId,
                                milestone: state.responseFarmerProjectMilestoneDetail!.data!.milestoneDetails![0],).navigate();
                        })) :
                Container(
                    margin: 20.marginAll(),
                    height: 55,
                    width: screenWidth(),
                    child: customButton("Approve Milestone",
                        fontColor: 0xffffffff,
                        opacity: 0.4,
                        onTap: () {}));
              }
          ),

      ],
    )
        : Column(
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
              widget.projectStatus.toString() == "interested"?
              InkWell(
                onTap: (){
                  TextEditingController controller = TextEditingController();
                  modalBottomSheetMenu(context,
                      radius: 40,
                      child: StatefulBuilder(
                          builder: (context, setState) {
                            return SizedBox(
                              height: 320,
                              child: Padding(
                                padding: const EdgeInsets.fromLTRB(23, 40, 25, 10),
                                child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Center(
                                        child: Text(
                                          'Add Task',
                                          style: figtreeMedium.copyWith(fontSize: 22),
                                        ),
                                      ),
                                      30.verticalSpace(),

                                      Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            'Task Name',
                                            style: figtreeMedium.copyWith(fontSize: 12),
                                          ),
                                          5.verticalSpace(),
                                          TextField(
                                            controller: controller,
                                            maxLines: 1,
                                            minLines: 1,
                                            decoration: InputDecoration(
                                                hintText: 'Enter task name',
                                                hintStyle:
                                                figtreeMedium.copyWith(fontSize: 18),
                                                border: OutlineInputBorder(
                                                    borderRadius: BorderRadius.circular(12),
                                                    borderSide: const BorderSide(
                                                      width: 1,
                                                      color: Color(0xff999999),
                                                    ))),
                                          ),
                                          30.verticalSpace(),
                                          Padding(
                                            padding: const EdgeInsets.fromLTRB(28, 0, 29, 0),
                                            child: customButton(
                                              'Submit',
                                              fontColor: 0xffFFFFFF,
                                              onTap: () {
                                                BlocProvider.of<ProjectCubit>(context).addTaskApi(context,state.responseFarmerProjectMilestoneDetail!.data!.milestoneDetails![0].farmerId.toString(),state.responseFarmerProjectMilestoneDetail!.data!.milestoneDetails![0].farmerProjectId.toString(),state.responseFarmerProjectMilestoneDetail!.data!.milestoneDetails![0].id.toString(),
                                                    controller.text,widget.milestoneId
                                                );
                                              },
                                              height: 60,
                                              width: screenWidth(),
                                            ),
                                          )
                                        ],
                                      )
                                    ]),
                              ),
                            );
                          }
                      ));
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
              )
                  :
              const SizedBox.shrink()
                  // :const SizedBox.shrink()

            ],
          ),
        ),
        10.verticalSpace(),
        Padding(
          padding: const EdgeInsets.fromLTRB(20, 0, 20, 20),
          child: customList(
              list: List.generate(state.responseFarmerProjectMilestoneDetail!.data!.milestoneDetails![0].farmerProjectTask!.length, (index) => null),
              child: (int index) {
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
                          state.responseFarmerProjectMilestoneDetail!.data!.milestoneDetails![0].farmerProjectTask![index].taskName ?? '',
                          style: figtreeMedium.copyWith(fontSize: 14),
                        ),
                        widget.projectStatus == "interested"?
                        Padding(
                          padding: const EdgeInsets.all(10.0),
                          child: InkWell(
                              onTap: (){
                                BlocProvider.of<ProjectCubit>(context).deleteTaskApi(context,
                                    state.responseFarmerProjectMilestoneDetail!.data!.milestoneDetails![0].farmerProjectTask![index].id.toString(),widget.milestoneId
                                );
                              }
                              ,child: Image.asset(Images.deleteIcon,width: 24,height: 24,)),
                        ):const SizedBox.shrink()
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
