import 'dart:io';

import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:expandable_text/expandable_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:glad/cubit/project_cubit/project_cubit.dart';
import 'package:glad/data/model/farmer_project_milestone_detail_model.dart';
import 'package:glad/screen/custom_widget/container_border.dart';
import 'package:glad/screen/custom_widget/custom_appbar.dart';
import 'package:glad/screen/custom_widget/custom_methods.dart';
import 'package:glad/utils/color_resources.dart';
import 'package:glad/utils/extension.dart';
import 'package:glad/utils/helper.dart';
import 'package:glad/utils/images.dart';
import 'package:glad/utils/styles.dart';

class TaskUpdate extends StatefulWidget {
  const TaskUpdate({super.key, required this.task});
  final FarmerProjectTask task;

  @override
  State<TaskUpdate> createState() => _TaskUpdateState();
}

class _TaskUpdateState extends State<TaskUpdate> {
  String? selectOption = '';
  TextEditingController controller = TextEditingController();
  List<String> images = [];

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
                              widget.task.taskName ?? '',
                              style: figtreeMedium.copyWith(fontSize: 18, color: Colors.black),
                            ),
                            5.verticalSpace(),
                            widget.task.taskStatus == 'pending' ? Text(
                              formatProjectStatus(widget.task.taskStatus ?? ''),
                              style: figtreeMedium.copyWith(fontSize: 14, color: const Color(0xFFFC5E60)),
                            ) : widget.task.taskStatus == 'In-progress' ? Text(
                              formatProjectStatus(widget.task.taskStatus ?? ''),
                              style: figtreeMedium.copyWith(fontSize: 14, color: const Color(0xFFF6B51D)),
                            ) : const SizedBox.shrink(),
                            30.verticalSpace(),
                            Container(
                              height: 60,
                              decoration: BoxDecoration(
                                  border: Border.all(color: const Color(0xffD9D9D9,),width: 1.5),
                                  borderRadius: BorderRadius.circular(10),
                                  color: Colors.white
                              ),
                              width: screenWidth(),
                              child: DropdownButtonHideUnderline(
                                child: DropdownButton2<String>(
                                  isExpanded: true,
                                  isDense: true,
                                  hint: Text(
                                    selectOption.toString(),
                                    style: TextStyle(
                                      fontSize: 14,
                                      color: Theme.of(context).hintColor,
                                    ),
                                  ),
                                  items: ["Pending","In progress","Completed"]
                                      .map((String item) => DropdownMenuItem<String>(
                                    value: item,
                                    child: Text(
                                      item,
                                      style: const TextStyle(
                                        fontSize: 14,
                                      ),
                                    ),
                                  )).toList(),
                                  // value: state.counties![0].name!,
                                  onChanged: (value) {
                                    setState(() {
                                      selectOption = value.toString();
                                    });
                                  },
                                  buttonStyleData: const ButtonStyleData(
                                    padding: EdgeInsets.symmetric(horizontal: 16),
                                    height: 40,
                                    width: 140,
                                  ),
                                  menuItemStyleData: const MenuItemStyleData(
                                    height: 40,
                                  ),
                                ),
                              ),
                            ),
                            15.verticalSpace(),
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
                            Text(
                              'Upload pictures',
                              style: figtreeMedium.copyWith(fontSize: 18, color: Colors.black),
                            ),
                            10.verticalSpace(),
                            Stack(
                              children: [
                                ContainerBorder(
                                  margin: 0.marginVertical(),
                                  padding:
                                  10.paddingOnly(top: 15, bottom: 15),
                                  borderColor: 0xffD9D9D9,
                                  backColor: 0xffFFFFFF,
                                  radius: 10,
                                  widget: Row(
                                    mainAxisAlignment:
                                    MainAxisAlignment.center,
                                    crossAxisAlignment:
                                    CrossAxisAlignment.center,
                                    children: [
                                      5.horizontalSpace(),
                                      Expanded(
                                        child: Padding(
                                          padding: const EdgeInsets.only(
                                              left: 10.0, top: 2, bottom: 2),
                                          child: Column(
                                            crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                            children: [
                                              RichText(
                                                  text: TextSpan(children: [
                                                    TextSpan(
                                                        text: 'Choose ',
                                                        style: figtreeMedium
                                                            .copyWith(
                                                            fontSize: 16,
                                                            color: const Color(
                                                                0xFFFC5E60))),
                                                    TextSpan(
                                                        text: 'you file here',
                                                        style: figtreeMedium
                                                            .copyWith(
                                                            fontSize: 16,
                                                            color:
                                                            ColorResources
                                                                .fieldGrey))
                                                  ])),
                                              Text('Max size 5 MB',
                                                  style:
                                                  figtreeMedium.copyWith(
                                                      fontSize: 12,
                                                      color:
                                                      ColorResources
                                                          .fieldGrey))
                                            ],
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                Positioned(
                                  right: 13,
                                  top: 0,
                                  bottom: 0,
                                  child: Row(
                                    children: [
                                      InkWell(
                                        onTap: () async {
                                            var image = await imgFromGallery();
                                            images.add(image);
                                            setState(() {});

                                        },
                                        child: SvgPicture.asset(
                                          Images.attachment,
                                          colorFilter: const ColorFilter.mode(
                                              ColorResources.fieldGrey,
                                              BlendMode.srcIn),
                                        ),
                                      ),
                                        Row(children: [
                                          10.horizontalSpace(),
                                          InkWell(
                                            onTap: () async{
                                              var image = await imgFromCamera();
                                              images.add(image);
                                              setState(() {});
                                            },
                                            child: SvgPicture.asset(
                                              Images.camera,
                                              colorFilter: const ColorFilter.mode(
                                                  ColorResources.fieldGrey,
                                                  BlendMode.srcIn),
                                            ),
                                          )
                                        ],),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                            30.verticalSpace(),
                            customGrid(context,
                                mainAxisSpacing: 20,
                                crossAxisSpacing: 10,
                                childAspectRatio: 1.2,
                                list: images, child: (index) {
                              return ClipRRect(
                                borderRadius: BorderRadius.circular(14),
                                  child: Image.file(File(images[index]), fit: BoxFit.fitWidth,width: screenWidth(),));
                            }),
                            40.verticalSpace(),
                            Container(
                                margin: 20.marginAll(),
                                height: 55,
                                width: screenWidth(),
                                child: customButton("Submit",
                                    fontColor: 0xffffffff,
                                    onTap: () {
                                  if(selectOption == ''){
                                    showCustomToast(context, 'Select status');
                                  } else if(controller.text == ''){
                                    showCustomToast(context, 'Write remarks');
                                  } else {
                                    BlocProvider.of<ProjectCubit>(context)
                                        .farmerProjectMilestoneTaskUpdateApi(
                                        context,
                                        widget.task.farmerId,
                                        widget.task.farmerProjectId,
                                        widget.task.farmerMilestoneId,
                                        widget.task.id,
                                        selectOption!.toLowerCase().replaceAllMapped(' ', (match) => ''),
                                        controller.text,
                                        images);
                                  }
                                    })),
                            40.verticalSpace(),

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
