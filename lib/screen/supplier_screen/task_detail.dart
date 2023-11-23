import 'package:cached_network_image/cached_network_image.dart';
import 'package:expandable_text/expandable_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:glad/cubit/project_cubit/project_cubit.dart';
import 'package:glad/data/model/farmer_project_milestone_detail_model.dart';
import 'package:glad/screen/custom_widget/custom_appbar.dart';
import 'package:glad/screen/custom_widget/custom_methods.dart';
import 'package:glad/screen/dde_screen/preview_screen.dart';
import 'package:glad/utils/color_resources.dart';
import 'package:glad/utils/extension.dart';
import 'package:glad/utils/styles.dart';
import 'package:intl/intl.dart';

class TaskDetail extends StatelessWidget {
  const TaskDetail({super.key, required this.task, required this.approve});
  final FarmerProjectTask task;
  final bool approve;

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
                centerTitle: true,
                titleText1: 'Task Details',
                titleText1Style: figtreeMedium.copyWith(
                    fontSize: 20, color: Colors.black),
                leading: arrowBackButton(),
              ),
              Expanded(
                  child: SingleChildScrollView(
                      child: Padding(
                        padding: const EdgeInsets.fromLTRB(24, 20, 24, 0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              task.taskName ?? '',
                              style: figtreeMedium.copyWith(fontSize: 18),
                            ),
                            5.verticalSpace(),
                            Text(
                              task.taskStatus == 'inprogress' ? 'In-progress' : formatProjectStatus(task.taskStatus ?? ''),
                              style: figtreeMedium.copyWith(fontSize: 16, color: const Color(0xFF999999)),
                            ),
                            20.verticalSpace(),
                            Text(
                              'Remarks',
                              style: figtreeMedium.copyWith(fontSize: 14, color: const Color(0xFF999999)),
                            ),
                            10.verticalSpace(),
                            ExpandableText(
                              task.remarks ?? '',
                              expandText: 'Read More',
                              linkColor: ColorResources.maroon,
                              style: figtreeMedium.copyWith(fontSize: 14),
                              collapseText: 'Show Less',
                            ),
                            40.verticalSpace(),
                            if(task.media!.isNotEmpty)
                            Text(
                              'Uploaded pictures',
                              style: figtreeMedium.copyWith(fontSize: 18, color: Colors.black)
                            ),
                            10.verticalSpace(),
                            customGrid(context,
                                mainAxisSpacing: 20,
                                crossAxisSpacing: 10,
                                childAspectRatio: 1.2,
                                list: task.media!, child: (index) {
                                  return InkWell(
                                    onTap: () {
                                      PreviewScreen(previewImage: task.media![index].originalUrl ?? '').navigate();
                                    },
                                    child: Stack(
                                      alignment: Alignment.center,
                                      children: [
                                        ClipRRect(
                                            borderRadius: BorderRadius.circular(14),
                                            child: CachedNetworkImage(imageUrl: task.media![index].originalUrl ?? '', fit: BoxFit.fitWidth,width: screenWidth(),)),
                                        Positioned(
                                          bottom: 10,
                                          right: 10,
                                          child: Container(
                                              alignment: Alignment.center,
                                              height:35,
                                              width: 80,
                                              decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(170)),
                                              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
                                              child: Text(DateFormat('dd MMM, yy').format(DateTime.parse(task.media![index].createdAt!)), style: figtreeMedium.copyWith(fontSize: 12),)),
                                        )
                                      ],
                                    ),
                                  );
                                }),
                            if(approve)
                            Column(
                              children: [
                                40.verticalSpace(),
                                Container(
                                    margin: 20.marginAll(),
                                    height: 55,
                                    width: screenWidth(),
                                    child: customButton("Accept",
                                        fontColor: 0xffffffff,
                                        onTap: () {
                                          BlocProvider.of<ProjectCubit>(context)
                                              .farmerProjectMilestoneTaskUpdateApi(
                                              context,
                                              task.farmerId,
                                              task.farmerProjectId,
                                              task.farmerMilestoneId,
                                              task.id,
                                              'approved',
                                              '',
                                              []);
                                        })),
                                // 20.verticalSpace(),
                                Container(
                                    margin: 20.marginAll(),
                                    height: 55,
                                    width: screenWidth(),
                                    child: customButton("Reject",
                                        fontColor: 0xff000000,
                                        color: 0xFFDCDCDC,
                                        onTap: () {
                                          BlocProvider.of<ProjectCubit>(context)
                                              .farmerProjectMilestoneTaskUpdateApi(
                                              context,
                                              task.farmerId,
                                              task.farmerProjectId,
                                              task.farmerMilestoneId,
                                              task.id,
                                              'rejected',
                                              '',
                                              []);
                                        })),
                              ],
                            )
                          ],
                        ),
                      )))
            ],
          )
        ],
      ),
    );
  }
}
