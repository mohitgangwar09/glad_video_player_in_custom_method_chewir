import 'package:cached_network_image/cached_network_image.dart';
import 'package:expandable_text/expandable_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:glad/cubit/project_cubit/project_cubit.dart';
import 'package:glad/screen/custom_widget/custom_appbar.dart';
import 'package:glad/screen/custom_widget/custom_methods.dart';
import 'package:glad/screen/custom_widget/custom_textfield2.dart';
import 'package:glad/screen/farmer_screen/common/add_remark.dart';
import 'package:glad/screen/farmer_screen/common/installation_watertank.dart';
import 'package:glad/utils/color_resources.dart';
import 'package:glad/utils/extension.dart';
import 'package:glad/utils/helper.dart';
import 'package:glad/utils/images.dart';
import 'package:glad/utils/styles.dart';

class SuggestedProjectDetails extends StatefulWidget {
  const SuggestedProjectDetails({super.key, required this.projectId});
  final int projectId;

  @override
  State<SuggestedProjectDetails> createState() =>
      _SuggestedProjectDetailsState();
}

class _SuggestedProjectDetailsState extends State<SuggestedProjectDetails> {
  @override
  void initState() {
    BlocProvider.of<ProjectCubit>(context)
        .farmerProjectDetailApi(context, widget.projectId);
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
        } else if (state.responseFarmerProjectDetail == null) {
          return Center(child: Text("${state.responseFarmerProjectDetail} Api Error"));
        } else {
          return Stack(
            children: [
              landingBackground(),
              Column(
                children: [
                  CustomAppBar(
                    context: context,
                    titleText1: state.responseFarmerProjectDetail!.data!.farmerProject![0].name ?? '',
                    leading: arrowBackButton(),
                    centerTitle: true,
                    titleText1Style: figtreeMedium.copyWith(
                        fontSize: 20, color: Colors.black),
                  ),
                  Expanded(
                    child: SingleChildScrollView(
                      child: Padding(
                        padding: const EdgeInsets.fromLTRB(24, 20, 24, 0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            description(state),
                            30.verticalSpace(),
                            dde(context, state),
                            kpi(context),
                            projectMilestones(context, state),
                            inviteExpert(context),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              // Positioned(
              //     bottom: 0,
              //     right: 0,
              //     child: Image.asset(
              //       Images.messageChat,
              //       width: 100,
              //       height: 100,
              //     ))
            ],
          );
        }
      }),
    );
  }

///////DescriptionDetails///////////
  Widget description(ProjectState state) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Text(
              'Description',
              style: figtreeMedium.copyWith(fontSize: 18),
            ),
            // 05.horizontalSpace(),
            // Container(
            //   padding: const EdgeInsets.symmetric(vertical: 4, horizontal: 7),
            //   decoration: boxDecoration(
            //     borderWidth: 1,
            //     borderRadius: 30,
            //     borderColor: const Color(0xff6A0030),
            //   ),
            //   child: Text(
            //     "Applied",
            //     textAlign: TextAlign.center,
            //     style: figtreeMedium.copyWith(
            //         color: const Color(0xff6A0030), fontSize: 10),
            //   ),
            // )
          ],
        ),
        10.verticalSpace(),
        ExpandableText(
          state.responseFarmerProjectDetail!.data!.farmerProject![0].description ?? '',
          expandText: 'Read More',
          linkColor: ColorResources.maroon,
          style: figtreeMedium.copyWith(fontSize: 14),
          collapseText: 'Show Less',
        )
      ],
    );
  }

///////////DDEContainerTimeline/////////////
  Widget dde(context, ProjectState state) {
    return Stack(
      alignment: Alignment.center,
      children: [
        SizedBox(height: 200, width: screenWidth()),
        Container(
          height: 150,
          width: screenWidth(),
          decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(16),
              border: Border.all(color: ColorResources.grey)),
          child: Padding(
            padding: const EdgeInsets.fromLTRB(15.0, 16, 0, 10),
            child: Column(
              children: [
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    CircleAvatar(
                        radius: 30,
                        child: CachedNetworkImage(
                          imageUrl: state.responseFarmerProjectDetail!.data!.farmerProject![0].dairyDevelopMentExecutive!.image ?? '',
                          errorWidget: (_, __, ___) {
                            return Image.asset(
                              Images.sampleUser,
                              fit: BoxFit.cover,
                              width: 80,
                              height: 80,
                            );
                          },
                          fit: BoxFit.cover,
                          width: 80,
                          height: 80,
                        )),
                    15.horizontalSpace(),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(state.responseFarmerProjectDetail!.data!.farmerProject![0].dairyDevelopMentExecutive!.name ?? '',
                            style: figtreeMedium.copyWith(
                                fontSize: 16, color: Colors.black)),
                        10.verticalSpace(),
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            const Icon(
                              Icons.call,
                              color: Colors.black,
                              size: 16,
                            ),
                            Text(state.responseFarmerProjectDetail!.data!.farmerProject![0].dairyDevelopMentExecutive!.phone ?? '',
                                style: figtreeRegular.copyWith(
                                    fontSize: 12, color: Colors.black)),
                          ],
                        ),
                        4.verticalSpace(),
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            const Icon(
                              Icons.location_on,
                              color: Colors.black,
                              size: 16,
                            ),
                            SizedBox(
                              width: MediaQuery.of(context).size.width *
                                  0.5,
                              child: Text(
                                'Plot 11, street 09, Luwum St. Rwooz Plot 11, street 09, Luwum St. Rwooz',
                                style: figtreeRegular.copyWith(
                                  fontSize: 12,
                                  color: Colors.black,
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ),
                            ),
                          ],
                        ),

                      ],
                    )
                  ],
                ),
                const Padding(
                  padding: EdgeInsets.only(right: 15.0),
                  child: Divider(),
                ),
                Text(
                  'You may contact our Dairy Development Executive (DDE) for any assistance related to application processing.',
                  style: figtreeRegular.copyWith(fontSize: 12),
                  textAlign: TextAlign.center,
                )
              ],
            ),
          ),
        ),
        Positioned(
            top: -5,
            left: 0,
            child: Text(
              'DDE',
              style: figtreeMedium.copyWith(fontSize: 20),
            )),
        Positioned(
            top: 0,
            right: 10,
            child: Row(
              children: [
                SvgPicture.asset(Images.callPrimary),
                6.horizontalSpace(),
                SvgPicture.asset(Images.whatsapp),
                6.horizontalSpace(),
              ],
            )),
      ],
    );
  }

/////////KPI///////////////////////
  Widget kpi(context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.end,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "KPI's",
          style: figtreeMedium.copyWith(
            fontSize: 18,
          ),
        ),
        10.verticalSpace(),
        customGrid(context,
            list: [1, 2, 3, 4, 5, 6, 7],
            crossAxisCount: 3,
            mainAxisSpacing: 10,
            mainAxisExtent: 135, child: (int index) {
          return customShadowContainer(
              backColor: ColorResources.grey,
              margin: 2,
              radius: 14,
              width: screenWidth(),
              child: Padding(
                // padding: 0.paddingAll(),
                padding: const EdgeInsets.fromLTRB(8, 10, 8, 2),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        SvgPicture.asset(
                          Images.callPrimary,
                          width: 30,
                          height: 30,
                        ),
                        SvgPicture.asset(Images.menuIcon)
                      ],
                    ),
                    15.verticalSpace(),
                    Text(
                      'UGX 800K',
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: figtreeMedium.copyWith(fontSize: 16),
                    ),
                    05.verticalSpace(),
                    Text(
                      'Farmer Participation',
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: figtreeRegular.copyWith(
                        fontSize: 14,
                      ),
                    )
                  ],
                ),
              ));
        })
      ],
    );
  }

  ///////////ProjectMilestones///////////
  Widget projectMilestones(context, ProjectState state) {
    return Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      50.verticalSpace(),
      Text(
        'Project milestones',
        style: figtreeMedium.copyWith(fontSize: 18),
      ),
      15.verticalSpace(),
      InkWell(
        onTap: () {
          const InstallationOfWaterTank().navigate();
        },
        child: customList(
          list: List.generate(state.responseFarmerProjectDetail!.data!.farmerProject![0].farmerProjectMilestones!.length, (index) => null),
            axis: Axis.vertical,
            child: (int index) {
              return Padding(
                padding: const EdgeInsets.only(
                  bottom: 20,
                ),
                child: customShadowContainer(
                    margin: 0,
                    backColor: ColorResources.grey,
                    child: Padding(
                      padding: const EdgeInsets.all(20),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Text(
                                state.responseFarmerProjectDetail!.data!.farmerProject![0].farmerProjectMilestones![index].milestoneTitle ?? '',
                                style: figtreeMedium.copyWith(fontSize: 18),
                              ),
                              // checkBox(
                              //   value: true,
                              // )
                            ],
                          ),
                          5.verticalSpace(),
                          Text(
                            '05 tasks included in this milestone.',
                            style: figtreeMedium.copyWith(fontSize: 12),
                          ),
                          20.verticalSpace(),
                          Row(
                            children: [
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    'Value',
                                    style: figtreeMedium.copyWith(
                                        fontSize: 12,
                                        color: ColorResources.fieldGrey),
                                  ),
                                  Text(
                                    'UGX ${state.responseFarmerProjectDetail!.data!.farmerProject![0].farmerProjectMilestones![index].milestoneValue ?? ''}',
                                    style: figtreeSemiBold.copyWith(
                                        fontSize: 16,
                                        color: ColorResources.maroon),
                                  )
                                ],
                              ),
                              40.horizontalSpace(),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    'Duration',
                                    style: figtreeMedium.copyWith(
                                        fontSize: 12,
                                        color: ColorResources.fieldGrey),
                                  ),
                                  Text(
                                    '${state.responseFarmerProjectDetail!.data!.farmerProject![0].farmerProjectMilestones![index].milestoneDuration ?? ''} Days',
                                    style: figtreeSemiBold.copyWith(
                                        fontSize: 16,
                                        color: ColorResources.black),
                                  )
                                ],
                              ),
                            ],
                          ),
                        ],
                      ),
                    )),
              );
            }),
      ),
      // 20.verticalSpace(),
      // Center(
      //     child: Padding(
      //   padding: const EdgeInsets.only(left: 50, right: 50),
      //   child: customButton('Revoke',
      //       width: screenWidth(),
      //       style: figtreeMedium.copyWith(fontSize: 16, color: Colors.white),
      //       onTap: () {
      //     const AddRemark().navigate();
      //   }, radius: 88, color: 0xffFC5E60),
      // )),
      // 05.verticalSpace(),
      // Center(
      //     child: Text(
      //   'Tap above to revoke the loan application.',
      //   style: figtreeMedium.copyWith(
      //       fontSize: 10, color: ColorResources.fieldGrey),
      // )),
      20.verticalSpace(),
    ]);
  }

  /////////////InviteExpert/////////
  Widget inviteExpert(context) {
    return Column(
      children: [
        Center(
            child: Padding(
          padding: const EdgeInsets.only(left: 50, right: 50),
          child: customButton(
            'Invite expert for survey',
            width: screenWidth(),
            style: figtreeMedium.copyWith(fontSize: 16, color: Colors.white),
            onTap: () {
              modalBottomSheetMenu(context,
                  radius: 40,
                  child: SizedBox(
                    height: 450,
                    child: Padding(
                      padding: const EdgeInsets.fromLTRB(23, 40, 25, 10),
                      child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Center(
                              child: Text(
                                'Farmer feedback',
                                style: figtreeMedium.copyWith(fontSize: 22),
                              ),
                            ),
                            30.verticalSpace(),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                CustomTextField2(
                                  borderColor: 0xff727272,
                                  hint: 'Select Date',
                                  width: screenWidth(),
                                  title: 'Preferred date',
                                  image2: Images.calender,
                                  image2Colors: ColorResources.maroon,
                                  readOnly: true,
                                  onTap: () {
                                    showDatePicker(
                                        context: context,
                                        initialDate: DateTime.now(),
                                        firstDate: DateTime.now(),
                                        lastDate: DateTime.now());
                                  },
                                  focusNode: FocusNode(),
                                ),
                                20.verticalSpace(),
                                Text(
                                  'Remarks',
                                  style: figtreeMedium.copyWith(fontSize: 12),
                                ),
                                5.verticalSpace(),
                                TextField(
                                  maxLines: 4,
                                  minLines: 4,
                                  decoration: InputDecoration(
                                      hintText: 'Write...',
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
                                    onTap: () {},
                                    height: 60,
                                    width: screenWidth(),
                                  ),
                                )
                              ],
                            )
                          ]),
                    ),
                  ));
            },
          ),
        )),
      ],
    );
  }
}
