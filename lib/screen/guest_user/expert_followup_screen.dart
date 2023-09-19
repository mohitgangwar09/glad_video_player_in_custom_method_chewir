import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:glad/cubit/landing_page_cubit/landing_page_cubit.dart';
import 'package:glad/screen/custom_widget/custom_appbar.dart';
import 'package:glad/screen/custom_widget/custom_methods.dart';
import 'package:glad/utils/color_resources.dart';
import 'package:glad/utils/extension.dart';
import 'package:glad/utils/images.dart';
import 'package:glad/utils/styles.dart';
import 'package:intl/intl.dart';

class ExpertFollowUpScreen extends StatefulWidget {
  const ExpertFollowUpScreen({super.key});

  @override
  State<ExpertFollowUpScreen> createState() => _ExpertFollowUpScreenState();
}

class _ExpertFollowUpScreenState extends State<ExpertFollowUpScreen> {

  TextEditingController commentController = TextEditingController();

  @override
  void initState() {
    super.initState();

    SchedulerBinding.instance.addPostFrameCallback((_) {
      BlocProvider.of<LandingPageCubit>(context).getFollowUpDetails(context, false);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(body: BlocBuilder<LandingPageCubit, LandingPageState>(
        builder: (context, state) {
          if (state.status == LandingPageStatus.loading) {
            return const Center(
                child: CircularProgressIndicator(
                  color: ColorResources.maroon,
                ));
          } else if (state.followupRemarkListResponse == null) {
            return Center(child: Text("${state.followupRemarkListResponse} Api Error"));
          } else {
            return Container(
              color: Colors.white,
              child: Stack(
                children: [
                  landingBackground(),
                  Column(
                    children: [
                      CustomAppBar(
                        context: context,
                        titleText1: 'Invite an expert',
                        centerTitle: true,
                        leading: arrowBackButton(),
                      ),
                      Expanded(
                          child: SingleChildScrollView(
                            child: Column(
                              children: [
                                Padding(
                                  padding: const EdgeInsets.symmetric(horizontal: 20),
                                  child: Container(
                                    width: screenWidth(),
                                    padding: const EdgeInsets.all(30),
                                    decoration: const BoxDecoration(
                                        color: Color(0xFFF6B51D),
                                        borderRadius: BorderRadius.only(
                                            topLeft: Radius.circular(30),
                                            topRight: Radius.circular(30),
                                            bottomLeft: Radius.circular(30),
                                            bottomRight: Radius.circular(0))),
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Text('Invited on: ${DateFormat('dd MMM, yyyy').format(DateTime.parse(state.guestDashboardResponse!.data!.enquiry!.createdAt!))}',
                                            style: figtreeMedium.copyWith(
                                                fontSize: 20, color: Colors.black)),
                                        10.verticalSpace(),
                                        Text(
                                            state.guestDashboardResponse!.data!.enquiry!.comment!,
                                            style: figtreeMedium.copyWith(
                                                fontSize: 16, color: Colors.black)),
                                      ],
                                    ),
                                  ),
                                ),
                                20.verticalSpace(),
                                customList(
                                  list: List.generate(state.followupRemarkListResponse!.data!.followupReamrkList!.length, (index) => ''),
                                  child: (index) => state.followupRemarkListResponse!.data!.followupReamrkList![index].commentedBy == 'guest-farmer' ?Padding(
                                    padding: const EdgeInsets.only(bottom: 20),
                                    child: Padding(
                                    padding: const EdgeInsets.symmetric(horizontal: 20),
                                    child: Container(
                                      width: screenWidth(),
                                      padding: const EdgeInsets.all(30),
                                      decoration: BoxDecoration(
                                          color: Colors.white,
                                          border: Border.all(color: const Color(0xFF999999)),
                                          borderRadius: const BorderRadius.only(
                                              topLeft: Radius.circular(30),
                                              topRight: Radius.circular(30),
                                              bottomLeft: Radius.circular(30),
                                              bottomRight: Radius.circular(0))),
                                      child: Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                              state.followupRemarkListResponse!.data!.followupReamrkList![index].comments!,
                                              style: figtreeMedium.copyWith(
                                                  fontSize: 16, color: Colors.black)),
                                          10.verticalSpace(),
                                          DateFormat('dd MMM, yyyy, hh:mm').format(DateTime.parse(state.followupRemarkListResponse!.data!.followupReamrkList![index].createdAt.toString())).textRegular(
                                              color: ColorResources.fieldGrey, fontSize: 14)
                                        ],
                                      ),
                                    ),
                                ),
                                  ) : Padding(
                                    padding: const EdgeInsets.only(bottom: 20),
                                    child: Padding(
                                      padding: const EdgeInsets.symmetric(horizontal: 20),
                                      child: Container(
                                        width: screenWidth(),
                                        padding: const EdgeInsets.all(30),
                                        decoration: BoxDecoration(
                                            color: const Color(0xFFFFF3F4),
                                            border: Border.all(color: const Color(0xFFC788A5)),
                                            borderRadius: const BorderRadius.only(
                                                topLeft: Radius.circular(30),
                                                topRight: Radius.circular(30),
                                                bottomRight: Radius.circular(30),
                                                bottomLeft: Radius.circular(0))),
                                        child: Column(
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: [
                                            Text('${state.guestDashboardResponse!.data!.dairyDevelopmentExecutive!.name} (DDE)',
                                                style: figtreeMedium.copyWith(
                                                    fontSize: 20, color: Colors.black)),
                                            10.verticalSpace(),
                                            Text(
                                                state.followupRemarkListResponse!.data!.followupReamrkList![index].comments!,
                                                style: figtreeMedium.copyWith(
                                                    fontSize: 16, color: Colors.black)),
                                            10.verticalSpace(),
                                            DateFormat('dd MMM, yyyy, hh:mm').format(DateTime.parse(state.followupRemarkListResponse!.data!.followupReamrkList![index].createdAt.toString())).textRegular(
                                                color: ColorResources.fieldGrey, fontSize: 14)
                                          ],
                                        ),
                                      ),
                                    ),
                                  ),)
                              ],
                            ),
                          )),
                      Container(
                        height: AppBar().preferredSize.height * 1.5,
                        width: screenWidth(),
                        padding: const EdgeInsets.symmetric(horizontal: 16),
                        decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: const BorderRadius.only(
                                topLeft: Radius.circular(24),
                                topRight: Radius.circular(24)),
                            border: Border.all(color: ColorResources.grey)),
                        child: Row(
                          children: [
                            Expanded(
                                child: TextField(
                                  controller: commentController,
                                  decoration: const InputDecoration(
                                      border: InputBorder.none,
                                      focusedBorder: InputBorder.none,
                                      enabledBorder: InputBorder.none,
                                      hintText: 'Followup remarks...'),
                                  onSubmitted: (value) {
                                    if(value.isNotEmpty) {
                                      context.read<LandingPageCubit>()
                                          .addFollowUpRemark(
                                          context, false, value,
                                          enquiryId: null);
                                      commentController.clear();
                                    }
                                  },
                                ),
                            ),
                            // SvgPicture.asset(
                            //   Images.attachment,
                            //   colorFilter: const ColorFilter.mode(
                            //       ColorResources.fieldGrey, BlendMode.srcIn),
                            // ),
                            // 10.horizontalSpace(),
                            // SvgPicture.asset(
                            //   Images.camera,
                            //   colorFilter: const ColorFilter.mode(
                            //       ColorResources.fieldGrey, BlendMode.srcIn),
                            // )
                          ],
                        ),
                      )
                    ],
                  ),
                ],
              ),
            );
          }
        }),);
  }
}
