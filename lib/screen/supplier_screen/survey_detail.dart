import 'package:cached_network_image/cached_network_image.dart';
import 'package:expandable_text/expandable_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:glad/cubit/landing_page_cubit/landing_page_cubit.dart';
import 'package:glad/cubit/profile_cubit/profile_cubit.dart';
import 'package:glad/cubit/project_cubit/project_cubit.dart';
import 'package:glad/screen/custom_widget/custom_appbar.dart';
import 'package:glad/screen/custom_widget/custom_methods.dart';
import 'package:glad/screen/dde_screen/dde_farmer_detail.dart';
import 'package:glad/screen/supplier_screen/accept_screen.dart';
import 'package:glad/screen/supplier_screen/add_milestone.dart';
import 'package:glad/screen/supplier_screen/milestone_detail.dart';
import 'package:glad/screen/supplier_screen/supplier_farmer_detail.dart';
import 'package:glad/screen/supplier_screen/survey_finished.dart';
import 'package:glad/utils/color_resources.dart';
import 'package:glad/utils/extension.dart';
import 'package:glad/utils/images.dart';
import 'package:glad/utils/styles.dart';

import '../../data/model/farmer_project_detail_model.dart';
import 'reject_screen.dart';

class SurveyDetails extends StatefulWidget {
  const SurveyDetails({super.key,
    required this.projectId,
    required this.selectedFilter,
  });

  final int projectId;
  final String selectedFilter;

  @override
  State<SurveyDetails> createState() => _SurveyDetailsState();
}

class _SurveyDetailsState extends State<SurveyDetails> {

  TextEditingController controller = TextEditingController();

  @override
  void initState() {
    BlocProvider.of<ProjectCubit>(context)
        .farmerProjectDetailApi(context, widget.projectId);
    super.initState();
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
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
        }else{
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
                    titleText1Style:
                    figtreeMedium.copyWith(fontSize: 20, color: Colors.black),
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
                            state.responseFarmerProjectDetail!.data!.farmerProject![0].farmerMaster!=null?
                            farmerDetail(context, state.responseFarmerProjectDetail!.data!.farmerProject![0].farmerMaster!):const SizedBox.shrink(),
                            state.responseFarmerProjectDetail!.data!.farmerProject![0].dairyDevelopMentExecutive!=null?
                            dde(context,state.responseFarmerProjectDetail!.data!.farmerProject![0].dairyDevelopMentExecutive!):const SizedBox.shrink(),
                            projectMilestones(context,state),
                            6.verticalSpace(),
                            customProjectContainer(
                                marginLeft: 0,
                                marginTop: 0,
                                borderRadius: 14,
                                child: Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 8.0, vertical: 12),
                                  child: Column(
                                    children: [
                                      Padding(
                                        padding:
                                        const EdgeInsets.symmetric(horizontal: 8.0),
                                        child: Row(
                                          mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                          children: [
                                            Text(
                                              'Payment Terms',
                                              style:
                                              figtreeMedium.copyWith(fontSize: 18),
                                            ),
                                            SvgPicture.asset(Images.drop)
                                          ],
                                        ),
                                      ),
                                      customList(
                                        list: state.responseFarmerProjectDetail!.data!.farmerProject![0].farmerProjectPaymentTerms!,
                                          child: (index){
                                          return Container(
                                            margin: const EdgeInsets.only(top: 10),
                                            padding: const EdgeInsets.symmetric(
                                                vertical: 8, horizontal: 14),
                                            decoration: BoxDecoration(
                                                color: const Color(0xFFE4FFE3),
                                                borderRadius: BorderRadius.circular(10)),
                                            child: Row(
                                              mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                              children: [
                                                Expanded(
                                                  child: Text(
                                                    state.responseFarmerProjectDetail!.data!.farmerProject![0].farmerProjectPaymentTerms![index].paymentTerm??"",
                                                    style:
                                                    figtreeMedium.copyWith(fontSize: 16),
                                                  ),
                                                ),
                                                Container(
                                                  padding: const EdgeInsets.symmetric(
                                                      horizontal: 20, vertical: 10),
                                                  decoration: BoxDecoration(
                                                      color: Colors.white,
                                                      borderRadius:
                                                      BorderRadius.circular(14),
                                                      border:
                                                      Border.all(color: Colors.grey)),
                                                  child: Text(
                                                    '${state.responseFarmerProjectDetail!.data!.farmerProject![0].farmerProjectPaymentTerms![index].paymentPercentage!=null?state.responseFarmerProjectDetail!.data!.farmerProject![0].farmerProjectPaymentTerms![index].paymentPercentage!.toString():""}%',
                                                    style: figtreeMedium.copyWith(
                                                        fontSize: 12),
                                                  ),
                                                ),
                                              ],
                                            ),
                                          );
                                          })
                                    ],
                                  ),
                                )),
                            20.verticalSpace(),
                            Padding(
                              padding: const EdgeInsets.symmetric(horizontal: 35.0),
                              child: Text(
                                'This survey is required to be completed before 16 June, 2023.',
                                style: figtreeMedium.copyWith(fontSize: 18),
                                textAlign: TextAlign.center,
                              ),
                            ),


                            widget.selectedFilter == "new"?
                            Row(
                              children: [
                                Expanded(
                                  child: Container(
                                      margin: 18.marginAll(),
                                      height: 55,
                                      width: screenWidth(),
                                      child: customButton("Reject",
                                          fontColor: 0xffffffff,
                                          color: 0xff999999,
                                          onTap: () {
                                            modalBottomSheetMenu(context,
                                                radius: 40,
                                                child: SizedBox(
                                                  height: 320,
                                                  child: Padding(
                                                    padding: const EdgeInsets.fromLTRB(23, 40, 25, 10),
                                                    child: Column(
                                                        crossAxisAlignment: CrossAxisAlignment.start,
                                                        children: [
                                                          Center(
                                                            child: Text(
                                                              'Remarks',
                                                              style: figtreeMedium.copyWith(fontSize: 22),
                                                            ),
                                                          ),
                                                          30.verticalSpace(),
                                                          TextField(
                                                            maxLines: 4,
                                                            minLines: 4,
                                                            controller: controller,
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
                                                              onTap: () {
                                                                if(controller.text.isEmpty){
                                                                  showCustomToast(context, "Please enter remarks");
                                                                }else{
                                                                  context.read<ProjectCubit>().surveyStatusApi(context,
                                                                      state.responseFarmerProjectDetail!.data!.farmerProject![0].projectId,
                                                                      controller.text ?? '',
                                                                      'survey_rejected',state.responseFarmerProjectDetail!.data!.farmerProject![0].farmerId.toString(),
                                                                      state.responseFarmerProjectDetail!.data!.farmerProject![0]);
                                                                }
                                                              },
                                                              height: 60,
                                                              width: screenWidth(),
                                                            ),
                                                          )
                                                        ]),
                                                  ),
                                                ));
                                          })),
                                ),
                                Expanded(
                                  child: Container(
                                      margin: 18.marginAll(),
                                      height: 55,
                                      width: screenWidth(),
                                      child: customButton("Accept",
                                          fontColor: 0xffffffff, onTap: () {
                                            modalBottomSheetMenu(context,
                                                radius: 40,
                                                child: SizedBox(
                                                  height: 320,
                                                  child: Padding(
                                                    padding: const EdgeInsets.fromLTRB(23, 40, 25, 10),
                                                    child: Column(
                                                        crossAxisAlignment: CrossAxisAlignment.start,
                                                        children: [
                                                          Center(
                                                            child: Text(
                                                              'Remarks',
                                                              style: figtreeMedium.copyWith(fontSize: 22),
                                                            ),
                                                          ),
                                                          30.verticalSpace(),
                                                          TextField(
                                                            maxLines: 4,
                                                            minLines: 4,
                                                            controller: controller,
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
                                                              onTap: () {
                                                                if(controller.text.isEmpty){
                                                                  showCustomToast(context, "Please enter remarks");
                                                                }else{
                                                                  context.read<ProjectCubit>().surveyStatusApi(context,
                                                                      state.responseFarmerProjectDetail!.data!.farmerProject![0].projectId,
                                                                      controller.text ?? '',
                                                                      'survey_accepted',state.responseFarmerProjectDetail!.data!.farmerProject![0].farmerId.toString(),
                                                                      state.responseFarmerProjectDetail!.data!.farmerProject![0]);
                                                                }
                                                              },
                                                              height: 60,
                                                              width: screenWidth(),
                                                            ),
                                                          )
                                                        ]),
                                                  ),
                                                ));
                                          })),
                                )
                              ],
                            ):const SizedBox.shrink(),

                            15.verticalSpace(),

                            widget.selectedFilter == "pending"?
                            Center(
                              child: customButton("Submit Survey",
                                  fontColor: 0xffffffff, onTap: () {
                                    modalBottomSheetMenu(context,
                                        radius: 40,
                                        child: SizedBox(
                                          height: 320,
                                          child: Padding(
                                            padding: const EdgeInsets.fromLTRB(23, 40, 25, 10),
                                            child: Column(
                                                crossAxisAlignment: CrossAxisAlignment.start,
                                                children: [
                                                  Center(
                                                    child: Text(
                                                      'Remarks',
                                                      style: figtreeMedium.copyWith(fontSize: 22),
                                                    ),
                                                  ),
                                                  30.verticalSpace(),
                                                  TextField(
                                                    maxLines: 4,
                                                    minLines: 4,
                                                    controller: controller,
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
                                                      onTap: () {
                                                        if(controller.text.isEmpty){
                                                          showCustomToast(context, "Please enter remarks");
                                                        }else{
                                                          context.read<ProjectCubit>().surveyStatusApi(context,
                                                              state.responseFarmerProjectDetail!.data!.farmerProject![0].projectId,
                                                              controller.text ?? '',
                                                              'survey_completed',state.responseFarmerProjectDetail!.data!.farmerProject![0].farmerId.toString(),
                                                              state.responseFarmerProjectDetail!.data!.farmerProject![0]);
                                                        }
                                                      },
                                                      height: 60,
                                                      width: screenWidth(),
                                                    ),
                                                  )
                                                ]),
                                          ),
                                        ));
                                  }),
                            ):const SizedBox.shrink()
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              Positioned(
                  bottom: 0,
                  right: 0,
                  child: Image.asset(
                    Images.messageChat,
                    width: 100,
                    height: 100,
                  ))
            ],
          );
        }
        }
      ),
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
  Widget dde(context,DairyDevelopMentExecutive dde) {
    return Column(
      children: [
        Column(
          children: [
            Stack(
              alignment: Alignment.center,
              children: [
                SizedBox(height: 150, width: screenWidth()),
                Container(
                  height: 100,
                  width: screenWidth(),
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(16),
                      border: Border.all(color: ColorResources.grey)),
                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(15.0, 20, 0, 10),
                    child: Column(
                      children: [
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            dde.image!=null?
                            CircleAvatar(
                                radius: 33,
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(40),
                                  child: CachedNetworkImage(
                                    imageUrl: dde.image ?? '',
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
                                  ),
                                )) :
                            CircleAvatar(
                              radius: 30,
                              child: Image.asset(
                                Images.sampleUser,
                                fit: BoxFit.cover,
                                width: 80,
                                height: 80,
                              ),
                            ),
                            15.horizontalSpace(),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(dde.name!=null?dde.name!.toString():"",
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
                                    Text('+256 ${dde.phone!}',
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
                                        dde.address??"",
                                        style: figtreeRegular.copyWith(
                                          fontSize: 12,
                                          color: Colors.black,
                                          overflow: TextOverflow.ellipsis,
                                        ),
                                      ),
                                    ),
                                  ],
                                )
                              ],
                            )
                          ],
                        ),
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
                        SvgPicture.asset(Images.redirectLocation),
                        6.horizontalSpace(),
                      ],
                    )),
                Positioned(
                    bottom: -2,
                    child: InkWell(
                      onTap: () {
                        // const ProjectTimeline().navigate();
                      },
                      child: Text(
                        'View Timeline',
                        style: figtreeSemiBold.copyWith(
                            fontSize: 14,
                            color: ColorResources.maroon,
                            decoration: TextDecoration.underline,
                            decorationColor: ColorResources.maroon,
                            decorationThickness: 3.0),
                      ),
                    ))
              ],
            ),
          ],
        ),
      ],
    );
  }

  ///////////farmerDetail/////////////
  Widget farmerDetail(context, FarmerMaster farmerDetail) {
    return Stack(
      alignment: Alignment.center,
      children: [
        SizedBox(height: 150, width: screenWidth()),
        InkWell(
          onTap: (){
            BlocProvider.of<LandingPageCubit>(context).getCurrentLocation();
            BlocProvider.of<ProfileCubit>(context).emit(ProfileCubitState.initial());
            SupplierFarmerDetail(userId: farmerDetail.userId!,farmerId:farmerDetail.id!).navigate();
          },
          child: Container(
            height: 100,
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
                      farmerDetail.photo!=null?
                      CircleAvatar(
                          radius: 33,
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(40),
                            child: CachedNetworkImage(
                              imageUrl: farmerDetail.photo ?? '',
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
                            ),
                          )) :
                      CircleAvatar(
                        radius: 30,
                        child: Image.asset(
                          Images.sampleUser,
                          fit: BoxFit.cover,
                          width: 80,
                          height: 80,
                        ),
                      ),
                      15.horizontalSpace(),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(farmerDetail.name ?? '',
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
                              Text(farmerDetail.phone ?? '',
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
                                child: Text(farmerDetail.address!=null?
                                farmerDetail.address!.address!=null ?farmerDetail.address!.address!.toString():"":"",
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
                ],
              ),
            ),
          ),
        ),
        Positioned(
            top: -5,
            left: 0,
            child: Text(
              'Farmer',
              style: figtreeMedium.copyWith(fontSize: 20),
            )),
        Positioned(
            top: 0,
            right: 10,
            child: Row(
              children: [
                InkWell(
                    onTap: (){
                      callOnMobile(farmerDetail.phone ?? '');
                    }, child: SvgPicture.asset(Images.callPrimary)),
                6.horizontalSpace(),
                InkWell(onTap: ()async{
                  await launchWhatsApp(farmerDetail.phone ?? '');
                },child: SvgPicture.asset(Images.whatsapp)),

                6.horizontalSpace(),
                InkWell(onTap: ()async{

                },child: SvgPicture.asset(Images.redirectLocation)),
                6.horizontalSpace(),
              ],
            )),
      ],
    );
  }

  ///////////ProjectMilestones///////////
  Widget projectMilestones(context, ProjectState state) {
    return Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      30.verticalSpace(),
      Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            'Project milestones',
            style: figtreeMedium.copyWith(fontSize: 18),
          ),
          InkWell(
            onTap: () {
              const AddMilestone().navigate();
            },
              child: SvgPicture.asset(Images.add))
        ],
      ),
      15.verticalSpace(),
      InkWell(
        onTap: () {
          const MilestoneDetail().navigate();
        },
        child: customList(
          list: state.responseFarmerProjectDetail!.data!.farmerProject![0].farmerProjectMilestones!,
            axis: Axis.vertical,
            child: (int index) {
              return Padding(
                padding: const EdgeInsets.only(
                  bottom: 20,
                ),
                child: customProjectContainer(
                    marginLeft: 0,
                    marginTop: 0,
                    borderRadius: 14,
                    child: Padding(
                      padding: const EdgeInsets.fromLTRB(20, 20, 10, 20),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                state.responseFarmerProjectDetail!.data!.farmerProject![0].farmerProjectMilestones![index].milestoneTitle ?? '',
                                style: figtreeMedium.copyWith(fontSize: 18),
                              ),
                              SvgPicture.asset(Images.cross)
                            ],
                          ),
                          5.verticalSpace(),
                          Text(
                            '${state.responseFarmerProjectDetail!.data!.farmerProject![0].farmerProjectMilestones![index].farmerProjectTaskCount ?? 0} tasks included in this milestone.',
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
    ]);
  }
}
