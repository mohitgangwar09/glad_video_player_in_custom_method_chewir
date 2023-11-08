import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:glad/cubit/project_cubit/project_cubit.dart';
import 'package:glad/screen/custom_widget/custom_appbar.dart';
import 'package:glad/screen/custom_widget/custom_methods.dart';
import 'package:glad/utils/extension.dart';
import 'package:glad/utils/images.dart';
import 'package:glad/utils/styles.dart';

class EditProjectMilestone extends StatefulWidget {
  const EditProjectMilestone({Key? key,required this.farmerId,required this.farmerProjectId,required this.projectId,required this.projectStatus}) : super(key: key);

  final String farmerId,farmerProjectId,projectStatus;
  final int projectId;

  @override
  State<EditProjectMilestone> createState() => _EditProjectMilestoneState();
}

class _EditProjectMilestoneState extends State<EditProjectMilestone> {

  bool click = false;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      body: BlocBuilder<ProjectCubit,ProjectState>(
          builder: (context,state) {
            return Column(
              children: [

                CustomAppBar(
                  context: context,
                  titleText1: 'Edit Project Milestone',
                  titleText1Style:
                  figtreeMedium.copyWith(fontSize: 20, color: Colors.black),
                  centerTitle: true,
                  leading: arrowBackButton(),
                  /*action: TextButton(
                  onPressed: () {},
                  child: Text(
                    'Save',
                    style: figtreeMedium.copyWith(
                        color: ColorResources.maroon, fontSize: 14),
                  )),*/
                ),

                Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Column(
                    children: [


                      Align(
                          alignment: Alignment.centerLeft,
                          child: "Milestone Name".textMedium(color: Colors.black, fontSize: 12)),

                      5.verticalSpace(),

                      Stack(
                        children: [
                          Container(
                            height: 60,
                            decoration: BoxDecoration(
                                border: Border.all(color: const Color(0xffD9D9D9,),width: 1.5),
                                borderRadius: BorderRadius.circular(10)
                            ),
                            width: screenWidth(),
                            child: TextField(
                              maxLines: 1,
                              controller: state.milestoneTitle,
                              onChanged: (value){
                              },
                              decoration: const InputDecoration(
                                  border: InputBorder.none,
                                  hintText: 'Search...',
                                  contentPadding: EdgeInsets.only(top: 10,left: 13)
                              ),
                            ),
                          ),
                        ],
                      ),

                      25.verticalSpace(),

                      Align(
                        alignment: Alignment.centerLeft,
                        child: "Milestone Duration".textMedium(color: Colors.black, fontSize: 12),
                      ),

                      5.verticalSpace(),

                      Container(
                        height: 60,
                        decoration: BoxDecoration(
                            border: Border.all(color: const Color(0xffD9D9D9,),width: 1.5),
                            borderRadius: BorderRadius.circular(10)
                        ),
                        width: screenWidth(),
                        child: TextField(
                          maxLines: 1,
                          controller: state.milestoneDuration,
                          keyboardType: TextInputType.number,
                          inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                          decoration: const InputDecoration(
                              border: InputBorder.none,
                              contentPadding: EdgeInsets.only(top: 10,left: 13)
                          ),
                        ),
                      ),

                      25.verticalSpace(),

                      Align(
                        alignment: Alignment.centerLeft,
                        child: "Milestone Description".textMedium(color: Colors.black, fontSize: 12),
                      ),

                      5.verticalSpace(),

                      Container(
                        height: 60,
                        decoration: BoxDecoration(
                            border: Border.all(color: const Color(0xffD9D9D9,),width: 1.5),
                            borderRadius: BorderRadius.circular(10)
                        ),
                        width: screenWidth(),
                        child: TextField(
                          maxLines: 1,
                          controller: state.milestoneDescription,
                          decoration: const InputDecoration(
                              border: InputBorder.none,
                              contentPadding: EdgeInsets.only(top: 10,left: 13)
                          ),
                        ),
                      ),

                      50.verticalSpace(),

                      customButton('Save',
                          style: figtreeMedium.copyWith(color: Colors.white),
                          width: screenWidth(),
                          height: 60,
                          onTap: () {
                            BlocProvider.of<ProjectCubit>(context).addMilestoneApi(context, widget.farmerId, widget.farmerProjectId, state.milestoneTitle.text, state.milestoneDescription.text, state.milestoneDuration.text,widget.projectId,widget.projectStatus);
                          })

                    ],
                  ),
                )
              ],
            );
          }
      ),
    );
  }
}
