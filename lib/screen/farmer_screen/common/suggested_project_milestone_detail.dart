import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:glad/cubit/project_cubit/project_cubit.dart';
import 'package:glad/screen/custom_widget/custom_appbar.dart';
import 'package:glad/screen/custom_widget/custom_methods.dart';
import 'package:glad/screen/farmer_screen/common/add_attribute.dart';
import 'package:glad/screen/farmer_screen/common/attributes_edit.dart';
import 'package:glad/utils/color_resources.dart';
import 'package:glad/utils/extension.dart';
import 'package:glad/utils/images.dart';
import 'package:glad/utils/styles.dart';

class SuggestedProjectMilestoneDetail extends StatefulWidget {
  const SuggestedProjectMilestoneDetail({super.key, required this.milestoneId});
  final int milestoneId;

  @override
  State<SuggestedProjectMilestoneDetail> createState() =>
      _SuggestedProjectMilestoneDetailState();
}

class _SuggestedProjectMilestoneDetailState
    extends State<SuggestedProjectMilestoneDetail> {
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
                    leading: arrowBackButton(),
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
                      // state.responseFarmerProjectMilestoneDetail!.data!.milestoneDetails![0].farmerProjectResourcePrice!=null?
                      //  attributes(state) :const SizedBox.shrink(),
                      mileStoneDeliverable(state),
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
            state.responseFarmerProjectMilestoneDetail!.data!.milestoneDetails![0].milestoneDescription ?? '',
            style: figtreeMedium.copyWith(fontSize: 14),
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
                'UGX ${state.responseFarmerProjectMilestoneDetail!.data!.milestoneDetails![0].milestoneValue ?? ''}',
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
    print(state.responseFarmerProjectMilestoneDetail!.data!.milestoneDetails![0].farmerProjectResourcePrice);
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
              InkWell(
                onTap: () {
                  context.read<ProjectCubit>().getSelectedAttribute(
                    'Select Material Name',
                    'Select Type',
                    'Select Size Capacity',
                    '',
                    '',
                    '');
                  const AttributesAdd().navigate();

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
              child: (index) => state.responseFarmerProjectMilestoneDetail!.data!.milestoneDetails![0].farmerProjectResourcePrice![index].notRequired!=null?
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

                            Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [

                                InkWell(
                                    onTap: (){
                                      AttributesEdit(index:index).navigate();
                                      context.read<ProjectCubit>().getSelectedAttribute(
                                          state.responseFarmerProjectMilestoneDetail!.data!.milestoneDetails![0].farmerProjectResourcePrice![index].resourceName??'',
                                          state.responseFarmerProjectMilestoneDetail!.data!.milestoneDetails![0].farmerProjectResourcePrice![index].resourceType??'',
                                          state.responseFarmerProjectMilestoneDetail!.data!.milestoneDetails![0].farmerProjectResourcePrice![index].resourceCapacity??'',
                                          state.responseFarmerProjectMilestoneDetail!.data!.milestoneDetails![0].farmerProjectResourcePrice![index].resourceUom??'',
                                          state.responseFarmerProjectMilestoneDetail!.data!.milestoneDetails![0].farmerProjectResourcePrice![index].resourceSize.toString()??'',
                                          state.responseFarmerProjectMilestoneDetail!.data!.milestoneDetails![0].farmerProjectResourcePrice![index].resourcePrice.toString()??'',
                                      );
                                    },child: Image.asset(Images.editIcon,width: 24,height: 24,)),
                                15.horizontalSpace(),
                                InkWell(
                                    onTap: (){
                                      BlocProvider.of<ProjectCubit>(context).deleteAttributeApi(context,
                                        state.responseFarmerProjectMilestoneDetail!.data!.milestoneDetails![0].farmerProjectResourcePrice![index].id.toString(),
                                        state.responseFarmerProjectMilestoneDetail!.data!.milestoneDetails![0].id.toString(),
                                      );
                                    }
                                    ,child: Image.asset(Images.deleteIcon,width: 24,height: 24,)),

                              ],
                            ),
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

                            customAttribute("Value", " ${state.responseFarmerProjectMilestoneDetail!.data!.milestoneDetails![0].farmerProjectResourcePrice![index].resourcePrice* state.responseFarmerProjectMilestoneDetail!.data!.milestoneDetails![0].farmerProjectResourcePrice![index].resourceSize ?? ''}"),
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
                    Container(
                      height: 50,
                      width: 50,
                      decoration: BoxDecoration(
                          color: ColorResources.pinkMain,
                          borderRadius: BorderRadius.circular(14)),
                      child: Center(
                          child: Text(
                        '${index + 1}',
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
