import 'package:cached_network_image/cached_network_image.dart';
import 'package:expandable_text/expandable_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:glad/cubit/project_cubit/project_cubit.dart';
import 'package:glad/data/model/frontend_kpi_model.dart';
import 'package:glad/screen/custom_widget/custom_appbar.dart';
import 'package:glad/screen/custom_widget/custom_methods.dart';
import 'package:glad/screen/custom_widget/custom_textfield2.dart';
import 'package:glad/screen/farmer_screen/common/add_remark.dart';
import 'package:glad/screen/farmer_screen/common/suggested_project_milestone_detail.dart';
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
                        padding: const EdgeInsets.fromLTRB(22, 20, 22, 0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            description(state),
                            30.verticalSpace(),
                            dde(context, state),
                            state.responseFarmerProjectDetail!.data!.farmerProject![0].kpi!=null?
                            kpi(context,state):const SizedBox.shrink(),
                            projectMilestones(context, state),
                            state.responseFarmerProjectDetail!.data!.farmerProject![0].projectSubStatus!=null?
                            state.responseFarmerProjectDetail!.data!.farmerProject![0].projectSubStatus.toString().capitalized() == "suggested".capitalized()?
                            inviteExpert(context, state):const SizedBox.shrink():const SizedBox.shrink(),
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
                                state.responseFarmerProjectDetail!.data!.farmerProject![0].dairyDevelopMentExecutive!.address != null
                                    ? state.responseFarmerProjectDetail!.data!.farmerProject![0].dairyDevelopMentExecutive!.address["address"] != null
                                && state.responseFarmerProjectDetail!.data!.farmerProject![0].dairyDevelopMentExecutive!.address["sub_county"] != null
                                    ? state.responseFarmerProjectDetail!.data!.farmerProject![0].dairyDevelopMentExecutive!.address["sub_county"] +
                                    state.responseFarmerProjectDetail!.data!.farmerProject![0].dairyDevelopMentExecutive!.address["address"]
                                    : ''
                                    : '',
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
                Padding(
                  padding: const EdgeInsets.only(right: 15.0),
                  child: Text(
                    'You may contact our Dairy Development Executive (DDE) for any assistance related to application processing.',
                    style: figtreeRegular.copyWith(fontSize: 12),
                    textAlign: TextAlign.center,
                  ),
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
                InkWell(
                  onTap: (){
                    callOnMobile(state.responseFarmerProjectDetail!.data!.farmerProject![0].dairyDevelopMentExecutive!.phone ?? '');
                  }, child: SvgPicture.asset(Images.callPrimary)),
                6.horizontalSpace(),
                InkWell(onTap: ()async{
                  await launchWhatsApp(state.responseFarmerProjectDetail!.data!.farmerProject![0].dairyDevelopMentExecutive!.phone ?? '');
                },child: SvgPicture.asset(Images.whatsapp)),
                6.horizontalSpace(),
              ],
            )),
      ],
    );
  }

/////////KPI///////////////////////
  Widget kpi(context,ProjectState state) {
    List<FrontendKpiModel> kpiData = [];

    if(state.responseFarmerProjectDetail!.data!.farmerProject![0].kpi!.investment!=null){
       kpiData.add(FrontendKpiModel(name: 'Investment',
           image: Images.investmentKpi,
           value: getCurrencyString(state.responseFarmerProjectDetail!.data!.farmerProject![0].kpi!.investment!)));
    }

    if(state.responseFarmerProjectDetail!.data!.farmerProject![0].kpi!.revenue!=null){
      kpiData.add(FrontendKpiModel(name: 'Revenue',
          image: Images.revenueKpi,
          value: getCurrencyString(state.responseFarmerProjectDetail!.data!.farmerProject![0].kpi!.revenue!)));
    }

    if(state.responseFarmerProjectDetail!.data!.farmerProject![0].kpi!.roi!=null){
      kpiData.add(FrontendKpiModel(name: 'ROI',
          image: Images.roiKpi,
          value: getCurrencyString(state.responseFarmerProjectDetail!.data!.farmerProject![0].kpi!.roi!)));
    }

    if(state.responseFarmerProjectDetail!.data!.farmerProject![0].kpi!.farmerParticipation!=null){
      kpiData.add(FrontendKpiModel(name: 'Farmer Participation',
          image: Images.farmerParticipationKpi,
          actionImage: Images.imageEdit,
          value: getCurrencyString(state.responseFarmerProjectDetail!.data!.farmerProject![0].kpi!.farmerParticipation!)));
    }

    if(state.responseFarmerProjectDetail!.data!.farmerProject![0].kpi!.loan!=null){
      kpiData.add(FrontendKpiModel(name: 'Loan',
          image: Images.loanKpi,
          value: getCurrencyString(state.responseFarmerProjectDetail!.data!.farmerProject![0].kpi!.loan!)));
    }

    if(state.responseFarmerProjectDetail!.data!.farmerProject![0].kpi!.repayment!=null){
      kpiData.add(FrontendKpiModel(name: 'Repayment',
          image: Images.repaymentKpi,
          value: getCurrencyString(state.responseFarmerProjectDetail!.data!.farmerProject![0].kpi!.repayment!)));
    }

    if(state.responseFarmerProjectDetail!.data!.farmerProject![0].kpi!.emi!=null){
      kpiData.add(FrontendKpiModel(name: 'EMI',
          image: Images.emiKpi,
          value: getCurrencyString(state.responseFarmerProjectDetail!.data!.farmerProject![0].kpi!.emi!)));
    }

    if(state.responseFarmerProjectDetail!.data!.farmerProject![0].kpi!.currentYield!=null){
      kpiData.add(FrontendKpiModel(name: 'Current Yield',
        image: Images.yieldKpi,
        actionImage: Images.menuIcon,
        value: '${state.responseFarmerProjectDetail!.data!.farmerProject![0].kpi!.currentYield!} Ltr.',
      ));
    }

    if(state.responseFarmerProjectDetail!.data!.farmerProject![0].kpi!.expectedYield!=null){
      kpiData.add(FrontendKpiModel(name: 'Target Yield',
        image: Images.yieldKpi,
        value: '${state.responseFarmerProjectDetail!.data!.farmerProject![0].kpi!.expectedYield!} Ltr.',
      ));
    }

    if(state.responseFarmerProjectDetail!.data!.farmerProject![0].kpi!.idealYield!=null){
      kpiData.add(FrontendKpiModel(name: 'Ideal Yield',
          image: Images.idealKpi,
          value: "${state.responseFarmerProjectDetail!.data!.farmerProject![0].kpi!.idealYield!} Ltr."
      ));
    }

    if(state.responseFarmerProjectDetail!.data!.farmerProject![0].kpi!.targetFarmProduction!=null){
      kpiData.add(FrontendKpiModel(name: 'Target Farm Production',
          image: Images.yieldKpi,
          value: "${state.responseFarmerProjectDetail!.data!.farmerProject![0].kpi!.targetFarmProduction!} Ltr."
      ));
    }

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
            list: kpiData,
            crossAxisCount: 3,
            mainAxisSpacing: 15,
            crossAxisSpacing: 13,
            mainAxisExtent: 123,
            child: (index){
              return Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(14),
                  border: Border.all(color: const Color(0xffDCDCDC),width: 1),
                  boxShadow:[
                    BoxShadow(
                        color: Colors.grey.withOpacity(0.2),
                        blurRadius: 2.0,
                        offset: const Offset(0, 2))],
                ),
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
                            kpiData[index].image.toString(),
                            width: 30,
                            height: 30,
                          ),
                          kpiData[index].actionImage!=null?
                          SvgPicture.asset(kpiData[index].actionImage.toString()):
                              const SizedBox.shrink()
                        ],
                      ),
                      15.verticalSpace(),
                      Text(
                        '${kpiData[index].value}',
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: figtreeMedium.copyWith(fontSize: 14.3),
                      ),
                      05.verticalSpace(),
                      Text(
                        kpiData[index].name.toString(),
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                        style: figtreeRegular.copyWith(
                          fontSize: 12.5,
                        ),
                      )
                    ],
                  ),
                ),
              );
            }),


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
      customList(
        list: List.generate(state.responseFarmerProjectDetail!.data!.farmerProject![0].farmerProjectMilestones!.length, (index) => null),
          axis: Axis.vertical,
          child: (int index) {
            return Padding(
              padding: const EdgeInsets.only(
                bottom: 20,
              ),
              child: InkWell(
                onTap: () {
                  SuggestedProjectMilestoneDetail(milestoneId: state.responseFarmerProjectDetail!.data!.farmerProject![0].farmerProjectMilestones![index].id).navigate();
                },
                child: customProjectContainer(
                    marginLeft: 0,
                    marginTop: 0,
                    borderRadius: 14,
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
              ),
            );
          }),
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
  Widget inviteExpert(BuildContext context, ProjectState  state) {
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
              TextEditingController controller = TextEditingController();
              String date = '';
              modalBottomSheetMenu(context,
                  radius: 40,
                  child: StatefulBuilder(
                    builder: (context, setState) {
                      return SizedBox(
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
                                      title: 'Preferred date',
                                      image2: Images.calender,
                                      image2Colors: ColorResources.maroon,
                                      readOnly: true,
                                      controller: TextEditingController()..text = date,
                                        onTap: () async{
                                          var selectDate = await selectedFutureDate(context);
                                          date = "${selectDate.year}/${selectDate.month}/${selectDate.day}";
                                          setState(() {});
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
                                      controller: controller,
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
                                        onTap: () {
                                          context.read<ProjectCubit>().inviteExpertForSurvey(context,
                                              state.responseFarmerProjectDetail!.data!.farmerProject![0].id,
                                              date,
                                              controller.text ?? '',
                                              '',state.responseFarmerProjectDetail!.data!.farmerProject![0].farmerId.toString()
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
          ),
        )),
        20.verticalSpace(),
        InkWell(
          onTap: () {
            customDialog(
                widget: Center(
                  child: Material(
                    borderRadius: BorderRadius.circular(15),
                    child: Container(
                      height: 135,
                      width: screenWidth()-30,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(15),
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [

                          "Are you sure u are not interested?".textMedium(
                              fontSize: 19,
                              color: Colors.black
                          ),

                          20.verticalSpace(),

                          Row(
                            children: [

                              20.horizontalSpace(),

                              Expanded(
                                child: customButton("No",
                                    borderColor: 0xFF6A0030,
                                    color: 0xFFffffff,onTap: (){
                                      pressBack();
                                    }),
                              ),

                              20.horizontalSpace(),

                              Expanded(
                                child: customButton("Yes",fontColor: 0xFFffffff, onTap: (){
                                  context.read<ProjectCubit>().updateSuggestedProjectStatus(context, 'not_interested' , state.responseFarmerProjectDetail!.data!.farmerProject![0].id);
                                }),
                              ),

                              20.horizontalSpace(),

                            ],
                          ),

                        ],
                      ),
                    ),
                  ),
                )
            );
          },
            child: Text('Not Interested', style: figtreeMedium.copyWith(fontSize: 16, color: Colors.grey, decoration: TextDecoration.underline), )),
        20.verticalSpace(),
      ],
    );
  }
}
