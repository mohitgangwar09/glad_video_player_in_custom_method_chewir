import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:glad/cubit/project_cubit/project_cubit.dart';
import 'package:glad/screen/custom_widget/custom_appbar.dart';
import 'package:glad/screen/custom_widget/custom_methods.dart';
import 'package:glad/utils/color_resources.dart';
import 'package:glad/utils/extension.dart';
import 'package:glad/utils/styles.dart';
import 'package:intl/intl.dart';

class TrackProgress extends StatelessWidget {
  const TrackProgress({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocBuilder<ProjectCubit, ProjectState>(
        builder: (BuildContext context, state) {
          return Stack(
            children: [
              landingBackground(),
              Column(
                children: [
                  CustomAppBar(
                    context: context,
                    titleText1: 'Progress tracker',
                    leading: arrowBackButton(),
                    centerTitle: true,
                    titleText1Style:
                    figtreeMedium.copyWith(fontSize: 20, color: Colors.black),
                  ),
                  Expanded(
                    child: SingleChildScrollView(
                      child: Padding(
                        padding: const EdgeInsets.fromLTRB(24, 20, 24, 20),
                        child: customList(
                          list: state.responseFarmerProjectDetail!.data!.farmerProject![0].farmerProjectLog!,
                          child: (int index) => Padding(
                            padding: const EdgeInsets.only(bottom: 20),
                            child: Container(
                              width: screenWidth(),
                              decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(16),
                                  border: Border.all(color: ColorResources.grey)),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.all(15.0),
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Row(
                                          mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                          children: [
                                            Row(
                                              children: [
                                                Text(DateFormat('dd MMM, yy hh:mm').format(DateTime.parse(state.responseFarmerProjectDetail!.data!.farmerProject![0].farmerProjectLog![index].date)),
                                                    // state.responseFarmerProjectDetail!.data!.farmerProject![0].farmerProjectLog![index].date??'0',
                                                    style: figtreeMedium.copyWith(
                                                        fontSize: 18,
                                                        color: Colors.black)),
                                                /*Text('23 Jan, 2023',
                                                    style: figtreeMedium.copyWith(
                                                        fontSize: 18,
                                                        color: Colors.black)),
                                                10.horizontalSpace(),
                                                Text('09:00 AM',
                                                    style: figtreeMedium.copyWith(
                                                        fontSize: 18,
                                                        color: Colors.black)),*/
                                              ],
                                            ),
                                            Container(
                                              decoration: BoxDecoration(
                                                  color: Colors.white,
                                                  borderRadius:
                                                  BorderRadius.circular(16),
                                                  border: Border.all(
                                                      color: ColorResources.maroon)),
                                              padding: const EdgeInsets.all(6),
                                              child: Text(state.responseFarmerProjectDetail!.data!.farmerProject![0].farmerProjectLog![index].projectStatus.toString(),
                                                  style: figtreeMedium.copyWith(
                                                      fontSize: 12,
                                                      color: ColorResources.maroon)),
                                            ),
                                          ],
                                        ),
                                        7.verticalSpace(),
                                        '${state.responseFarmerProjectDetail!.data!.farmerProject![0].farmerProjectLog![index].userName.toString()} (${state.responseFarmerProjectDetail!.data!.farmerProject![0].farmerProjectLog![index].userRole.toString()})'.textMedium(
                                            fontSize: 14, color: const Color(0xFF23262A)),
                                        4.verticalSpace(),
                                       /* RichText(
                                            text: TextSpan(children: [
                                              *//*TextSpan(
                                                  text: 'Activity: ',
                                                  style: figtreeMedium.copyWith(
                                                      fontSize: 14, color: Colors.black)),
                                              TextSpan(
                                                  text: 'Assigned DDE: ',
                                                  style: figtreeMedium.copyWith(
                                                      fontSize: 14,
                                                      color: ColorResources.fieldGrey)),*//*
                                              TextSpan(
                                                  text: 'Begumanya Charles',
                                                  style: figtreeMedium.copyWith(
                                                      fontSize: 14, color: Colors.black))
                                            ])),*/
                                      ],
                                    ),
                                  ),
                                  SizedBox(
                                      width: screenWidth(),
                                      height: 2,
                                      child: horizontalPaint()),
                                  Padding(
                                    padding: const EdgeInsets.all(15.0),
                                    child: Column(
                                      children: [
                                        Text(state.responseFarmerProjectDetail!.data!.farmerProject![0].farmerProjectLog![index].remarks??'',
                                        style: figtreeMedium.copyWith(
                                            fontSize: 18,
                                            color: Colors.black,
                                            overflow: TextOverflow.ellipsis
                                        ),),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          );
        },
      ),
    );
  }
}
