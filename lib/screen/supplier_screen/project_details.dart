import 'package:cached_network_image/cached_network_image.dart';
import 'package:expandable_text/expandable_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:glad/cubit/landing_page_cubit/landing_page_cubit.dart';
import 'package:glad/cubit/profile_cubit/profile_cubit.dart';
import 'package:glad/cubit/project_cubit/project_cubit.dart';
import 'package:glad/data/model/frontend_kpi_model.dart';
import 'package:glad/screen/custom_widget/circular_percent_indicator.dart';
import 'package:glad/screen/custom_widget/custom_appbar.dart';
import 'package:glad/screen/custom_widget/custom_methods.dart';
import 'package:glad/screen/dde_screen/track_progress.dart';
import 'package:glad/screen/supplier_screen/dispute_screen.dart';
import 'package:glad/screen/supplier_screen/milestone_detail.dart';
import 'package:glad/screen/supplier_screen/milestone_project_detail.dart';
import 'package:glad/screen/supplier_screen/supplier_farmer_detail.dart';
import 'package:glad/utils/color_resources.dart';
import 'package:glad/utils/extension.dart';
import 'package:glad/utils/images.dart';
import 'package:glad/utils/styles.dart';
import 'package:intl/intl.dart';

import '../../data/model/farmer_project_detail_model.dart';


class ProjectDetails extends StatefulWidget {
  const ProjectDetails({super.key,
    required this.projectId,
    required this.selectedFilter,
  });

  final int projectId;
  final String selectedFilter;

  @override
  State<ProjectDetails> createState() => _ProjectDetailsState();
}

class _ProjectDetailsState extends State<ProjectDetails> {

  @override
  void initState() {
    print(widget.projectId);
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
                        20.verticalSpace(),
                        kpi(context, state),
                        20.verticalSpace(),
                        state.responseFarmerProjectDetail!.data!.farmerProject![0].farmerMaster!=null?
                        farmerDetail(context, state.responseFarmerProjectDetail!.data!.farmerProject![0].farmerMaster!):const SizedBox.shrink(),
                        state.responseFarmerProjectDetail!.data!.farmerProject![0].dairyDevelopMentExecutive!=null?
                        dde(context,state.responseFarmerProjectDetail!.data!.farmerProject![0].dairyDevelopMentExecutive!):const SizedBox.shrink(),
                        projectMilestones(context, state),
                        20.verticalSpace(),
                        state.responseFarmerProjectDetail!.data!.farmerProject![0].farmerProjectPaymentTerms!.isNotEmpty?
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
                            )):
                        const SizedBox.shrink(),
                        40.verticalSpace(),
                        Center(
                          child: customButton("Raise dispute",
                              fontColor: 0xffffffff,
                              color: 0xFFFC5E60,
                              width: screenWidth(),
                              height: 60,
                              onTap: () {
                                modalBottomSheetMenu(context,
                                    radius: 40,
                                    child: SizedBox(
                                      height: 320,
                                      child: Padding(
                                        padding: const EdgeInsets.fromLTRB(
                                            23, 30, 25, 10),
                                        child: Column(
                                            crossAxisAlignment: CrossAxisAlignment
                                                .start,
                                            children: [
                                              Center(
                                                child: Text(
                                                  'Raise dispute',
                                                  style: figtreeMedium.copyWith(
                                                      fontSize: 22),
                                                ),
                                              ),
                                              30.verticalSpace(),
                                              'Reason of dispute'.textMedium(
                                                  color: Colors.black,
                                                  fontSize: 12),
                                              TextField(
                                                maxLines: 4,
                                                minLines: 4,
                                                decoration: InputDecoration(
                                                    hintText: 'Write...',
                                                    hintStyle:
                                                    figtreeMedium.copyWith(
                                                        fontSize: 18),
                                                    border: OutlineInputBorder(
                                                        borderRadius: BorderRadius
                                                            .circular(12),
                                                        borderSide: const BorderSide(
                                                          width: 1,
                                                          color: Color(
                                                              0xff999999),
                                                        ))),
                                              ),
                                              30.verticalSpace(),
                                              Padding(
                                                padding: const EdgeInsets
                                                    .fromLTRB(28, 0, 29, 0),
                                                child: customButton(
                                                  'Submit',
                                                  fontColor: 0xffFFFFFF,
                                                  onTap: () {
                                                    const DisputeScreen()
                                                        .navigate();
                                                  },
                                                  height: 60,
                                                  width: screenWidth(),
                                                ),
                                              )
                                            ]),
                                      ),
                                    ));
                              }),
                        ),
                        10.verticalSpace(),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 35.0),
                          child: Text(
                            'Tap above to raise dispute on this project. Glad legal department will look into it.',
                            style: figtreeRegular.copyWith(fontSize: 10,
                                color: ColorResources.fieldGrey),
                            textAlign: TextAlign.center,
                          ),
                        ),
                        40.verticalSpace(),
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
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                Text(
                  'Description',
                  style: figtreeMedium.copyWith(fontSize: 18),
                ),
                05.horizontalSpace(),
                Container(
                  padding: const EdgeInsets.symmetric(vertical: 4, horizontal: 7),
                  decoration: boxDecoration(
                    borderWidth: 1,
                    borderRadius: 30,
                    borderColor: const Color(0xff6A0030),
                  ),
                  child: Text(
                    formatProjectStatus(state.responseFarmerProjectDetail!.data!.farmerProject![0].projectStatus.toString()),
                    textAlign: TextAlign.center,
                    style: figtreeMedium.copyWith(
                        color: const Color(0xff6A0030), fontSize: 10),
                  ),
                )
              ],
            ),
            Builder(
              builder: (context) {
                int count = 0;
                for(FarmerProjectMilestones mile in state.responseFarmerProjectDetail!.data!.farmerProject![0].farmerProjectMilestones!) {
                  if(mile.milestoneStatus != "pending") {
                    count++;
                  }
                }
                return Stack(
                  alignment: Alignment.center,
                  children: [
                    CircularPercentIndicator(
                      radius: 30,
                      percent: count / state.responseFarmerProjectDetail!.data!.farmerProject![0].farmerProjectMilestones!.length,
                      progressColor: const Color(0xFF12CE57),
                      backgroundColor: const Color(0xFFDCEAE5),
                    ),
                    RichText(
                      softWrap: false,
                      text: TextSpan(children: [
                        TextSpan(
                            text: removeZeroesInFraction(((count / state.responseFarmerProjectDetail!.data!.farmerProject![0].farmerProjectMilestones!.length) * 100).toString()),
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
        20.verticalSpace(),
        ExpandableText(
          state.responseFarmerProjectDetail!.data!.farmerProject![0].description ?? '',
          expandText: 'Read More',
          linkColor: ColorResources.maroon,
          style: figtreeMedium.copyWith(fontSize: 14),
          collapseText: 'Show Less',
        ),
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
                            dde.photo!=null?
                            CircleAvatar(
                                radius: 33,
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(40),
                                  child: CachedNetworkImage(
                                    imageUrl: dde.photo ?? '',
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
                                        dde.address != null ?
                                        dde.address["address"] != null && dde.address["sub_county"] != null
                                            ? dde.address["sub_county"] + dde.address["address"] : '' : '',
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
                        const TrackProgress().navigate();
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

  /////////KPI///////////////////////
  Widget kpi(contexts,ProjectState state) {
    List<FrontendKpiModel> kpiData = [];

    if(state.responseFarmerProjectDetail!.data!.farmerProject![0].kpi!.investment!=null){
      kpiData.add(FrontendKpiModel(name: 'Project Value',
          image: Images.investmentKpi,
          value: getCurrencyString(state.responseFarmerProjectDetail!.data!.farmerProject![0].kpi!.investment!)));
    }

    if(state.responseFarmerProjectDetail!.data!.farmerProject![0].kpi!.farmerParticipation!=null){
      kpiData.add(FrontendKpiModel(name: 'Farmer Participation',
          image: Images.farmerParticipationKpi,
          // actionImage: Images.imageEdit,
          value: getCurrencyString(state.responseFarmerProjectDetail!.data!.farmerProject![0].kpi!.farmerParticipation!)));
    }

    if(state.responseFarmerProjectDetail!.data!.farmerProject![0].kpi!.farmerParticipation!=null && state.responseFarmerProjectDetail!.data!.farmerProject![0].kpi!.investment!=null){
      kpiData.add(FrontendKpiModel(name: 'Glad Participation',
          image: Images.loanKpi,
          // actionImage: Images.imageEdit,
          value: getCurrencyString(state.responseFarmerProjectDetail!.data!.farmerProject![0].kpi!.investment - state.responseFarmerProjectDetail!.data!.farmerProject![0].kpi!.farmerParticipation!)));
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
                          // kpiData[index].actionImage!=null?
                          // InkWell(
                          //     onTap: (){
                          //       TextEditingController controller = TextEditingController();
                          //       controller.text = state.responseFarmerProjectDetail!.data!.farmerProject![0].kpi!.farmerParticipation!.toString();
                          //       if(kpiData[index].name.toString() == "Farmer Participation"){
                          //         modalBottomSheetMenu(context,
                          //             radius: 40,
                          //             child: StatefulBuilder(
                          //                 builder: (context, setState) {
                          //                   return SizedBox(
                          //                     height: 320,
                          //                     child: Padding(
                          //                       padding: const EdgeInsets.fromLTRB(23, 40, 25, 10),
                          //                       child: Column(
                          //                           crossAxisAlignment: CrossAxisAlignment.start,
                          //                           children: [
                          //                             Center(
                          //                               child: Text(
                          //                                 'Farmer Participation',
                          //                                 style: figtreeMedium.copyWith(fontSize: 22),
                          //                               ),
                          //                             ),
                          //                             30.verticalSpace(),
                          //
                          //                             Column(
                          //                               crossAxisAlignment: CrossAxisAlignment.start,
                          //                               children: [
                          //                                 Text(
                          //                                   'Participation Value',
                          //                                   style: figtreeMedium.copyWith(fontSize: 12),
                          //                                 ),
                          //                                 5.verticalSpace(),
                          //                                 TextField(
                          //                                   controller: controller,
                          //                                   maxLines: 1,
                          //                                   keyboardType: TextInputType.number,
                          //                                   inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                          //                                   minLines: 1,
                          //                                   decoration: InputDecoration(
                          //                                       hintText: 'Enter participation value',
                          //                                       hintStyle:
                          //                                       figtreeMedium.copyWith(fontSize: 18),
                          //                                       border: OutlineInputBorder(
                          //                                           borderRadius: BorderRadius.circular(12),
                          //                                           borderSide: const BorderSide(
                          //                                             width: 1,
                          //                                             color: Color(0xff999999),
                          //                                           ))),
                          //                                 ),
                          //                                 30.verticalSpace(),
                          //                                 Padding(
                          //                                   padding: const EdgeInsets.fromLTRB(28, 0, 29, 0),
                          //                                   child: customButton(
                          //                                     'Submit',
                          //                                     fontColor: 0xffFFFFFF,
                          //                                     onTap: () {
                          //                                       if(controller.text.isEmpty){
                          //                                         showCustomToast(context, "Please enter participation value");
                          //                                       }else{
                          //                                         BlocProvider.of<ProjectCubit>(context).farmerParticipationApi(context,state.responseFarmerProjectDetail!.data!.farmerProject![0].farmerId.toString(),state.responseFarmerProjectDetail!.data!.farmerProject![0].id.toString(), controller.text,widget.projectId);
                          //                                       }
                          //                                     },
                          //                                     height: 60,
                          //                                     width: screenWidth(),
                          //                                   ),
                          //                                 )
                          //                               ],
                          //                             )
                          //                           ]),
                          //                     ),
                          //                   );
                          //                 }
                          //             ));
                          //       }
                          //     }, child: SvgPicture.asset(kpiData[index].actionImage.toString())):const SizedBox.shrink()

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
      30.verticalSpace(),
      Text(
        'Project milestones',
        style: figtreeMedium.copyWith(fontSize: 18),
      ),
      15.verticalSpace(),
      customList(
        list: state.responseFarmerProjectDetail!.data!.farmerProject![0].farmerProjectMilestones!,
          axis: Axis.vertical,
          child: (int index) {
            return Padding(
              padding: const EdgeInsets.only(
                bottom: 20,
              ),
              child: InkWell(
                onTap: () {
                  SupplierProjectMilestoneDetail(milestoneId:
                  state.responseFarmerProjectDetail!.data!.farmerProject![0].farmerProjectMilestones![index].id,
                    projectStatus:state.responseFarmerProjectDetail!.data!.farmerProject![0].projectStatus.toString(),
                    selectedFilter:widget.selectedFilter,
                    navigateScreen:'',
                    projectId: widget.projectId,
                  ).navigate();
                },
                child: customShadowContainer(
                    margin: 0,
                    color: state.responseFarmerProjectDetail!.data!.farmerProject![0].farmerProjectMilestones![index].milestoneStatus != "pending" ? Color(0xFFFFF3F4) : Colors.white,
                    backColor: state.responseFarmerProjectDetail!.data!.farmerProject![0].farmerProjectMilestones![index].milestoneStatus != "pending" ? ColorResources.maroon : ColorResources.grey,
                    // backColor: ColorResources.grey,
                    child: Padding(
                      padding: const EdgeInsets.fromLTRB(20, 20, 20, 20),
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
                              state.responseFarmerProjectDetail!.data!.farmerProject![0].farmerProjectMilestones![index].milestoneStatus != "pending"
                                  ? checkBox2(value: true)
                                  :  Builder(
                                  builder: (context) {
                                    int count = 0;
                                    for(FarmerProjectTask task in state.responseFarmerProjectDetail!.data!.farmerProject![0].farmerProjectMilestones![index].farmerProjectTask!) {
                                      if(task.taskStatus!.toLowerCase() == "completed" || task.taskStatus!.toLowerCase() == "approved") {
                                        count++;
                                      }
                                    }
                                    return Stack(
                                      alignment: Alignment.center,
                                      children: [
                                        CircularPercentIndicator(
                                          radius: 30,
                                          percent: count / state.responseFarmerProjectDetail!.data!.farmerProject![0].farmerProjectMilestones![index].farmerProjectTask!.length,
                                          progressColor: const Color(0xFF12CE57),
                                          backgroundColor: const Color(0xFFDCEAE5),
                                        ),
                                        RichText(
                                          softWrap: false,
                                          text: TextSpan(children: [
                                            TextSpan(
                                                text: removeZeroesInFraction(((count / state.responseFarmerProjectDetail!.data!.farmerProject![0].farmerProjectMilestones![index].farmerProjectTask!.length) * 100).toString()),
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
                          Text(
                            '${state.responseFarmerProjectDetail!.data!.farmerProject![0].farmerProjectMilestones![index].farmerProjectTaskCount ?? 0} tasks included in this milestone.',
                            style: figtreeMedium.copyWith(fontSize: 12),
                          ),
                          20.verticalSpace(),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
                                    state.responseFarmerProjectDetail!.data!.farmerProject![0].farmerProjectMilestones![index].milestoneValue!=null?getCurrencyString(state.responseFarmerProjectDetail!.data!.farmerProject![0].farmerProjectMilestones![index].milestoneValue):'',
                                    style: figtreeSemiBold.copyWith(
                                        fontSize: 16,
                                        color: ColorResources.maroon),
                                  )
                                ],
                              ),
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
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    'Due Date',
                                    style: figtreeMedium.copyWith(
                                        fontSize: 12,
                                        color: ColorResources.fieldGrey),
                                  ),
                                  Text(
                                    state.responseFarmerProjectDetail!.data!.farmerProject![0].farmerProjectMilestones![index].milestoneDueDate != null ? DateFormat('dd MMM, yyyy').format(DateTime.parse(state.responseFarmerProjectDetail!.data!.farmerProject![0].farmerProjectMilestones![index].milestoneDueDate.toString())) : '',
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
    ]);
  }
}
