import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:glad/screen/custom_widget/custom_appbar.dart';
import 'package:glad/screen/custom_widget/custom_dropdown.dart';
import 'package:glad/screen/custom_widget/custom_methods.dart';
import 'package:glad/screen/custom_widget/custom_textfield2.dart';
import 'package:glad/utils/color_resources.dart';
import 'package:glad/utils/extension.dart';
import 'package:glad/utils/images.dart';
import 'package:glad/utils/styles.dart';
import 'package:stepper_list_view/stepper_list_view.dart';

class EditMilestone extends StatefulWidget {
  const EditMilestone({super.key});

  @override
  State<EditMilestone> createState() => _EditMilestoneState();
}

class _EditMilestoneState extends State<EditMilestone> {

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
                titleText1: 'Edit milestone',
                titleText1Style:
                figtreeMedium.copyWith(fontSize: 20, color: Colors.black),
                centerTitle: true,
                leading: arrowBackButton(),
                action: TextButton(
                    onPressed: () {},
                    child: Text(
                      'Save',
                      style: figtreeMedium.copyWith(
                          color: ColorResources.maroon, fontSize: 14),
                    )),
              ),
              Expanded(
                  child: SingleChildScrollView(
                    child: Padding(
                      padding: const EdgeInsets.all(20),
                      child: Column(
                        children: [
                          CustomDropdown(
                            title: 'Title of  the milestone',
                            iconColor: Colors.black,
                            icon: Images.arrowDropdown,
                            dropdownValue: null,
                            itemList: [' ', ' '], onChanged: (String ) {  },
                          ),
                          20.verticalSpace(),
                          const CustomTextField2(
                            title: 'Describe the milestone',
                            maxLine: 7,
                            minLine: 7,
                          ),
                          20.verticalSpace(),
                          const CustomTextField2(
                            title: 'Duration',
                            image2: Images.timer,
                            image2Colors: Colors.black,
                          ),
                          30.verticalSpace(),
                          Align(
                              alignment: Alignment.centerLeft,
                              child: Text('Attributes', style: figtreeMedium.copyWith(color: Colors.black, fontSize: 18))),
                          25.verticalSpace(),
                          Row(
                            children: [
                              Expanded(
                                child: CustomDropdown(
                                  title: 'Size/Capacity',
                                  itemList: const ['Male', 'Female'],
                                  dropdownValue: null,
                                  icon: Images.arrowDropdown,
                                  iconColor: Colors.black,
                                  onChanged: (String? value) {},
                                ),
                              ),
                              20.horizontalSpace(),
                              Expanded(
                                child: CustomDropdown(
                                  title: '',
                                  itemList: const ['Male', 'Female'],
                                  dropdownValue: null,
                                  icon: Images.arrowDropdown,
                                  iconColor: Colors.black,
                                  onChanged: (String? value) {},
                                ),
                              ),
                            ],
                          ),
                          20.verticalSpace(),
                          Row(
                            children: [
                              const Expanded(
                                child: CustomTextField2(
                                  title: 'Required Qty.',
                                ),
                              ),
                              20.horizontalSpace(),
                              Expanded(
                                child: CustomDropdown(
                                  title: '',
                                  itemList: const ['Male', 'Female'],
                                  dropdownValue: null,
                                  icon: Images.arrowDropdown,
                                  iconColor: Colors.black,
                                  onChanged: (String? value) {},
                                ),
                              ),
                            ],
                          ),
                          20.verticalSpace(),
                          const CustomTextField2(
                            title: 'Price per unit',
                          ),
                          20.verticalSpace(),
                          const CustomTextField2(
                            title: 'Value',
                          ),
                          30.verticalSpace(),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                'Milestone deliverables',
                                style: figtreeMedium.copyWith(fontSize: 18),
                              ),
                              InkWell(
                                  onTap: () {
                                  },
                                  child: SvgPicture.asset(Images.add))
                            ],
                          ),
                          20.verticalSpace(),
                          Stack(
                            children: [
                              Container(
                                padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 30),
                                decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(16),
                                    border: Border.all(color: ColorResources.grey)),
                                child: const CustomTextField2(
                                  title: 'Task Name',
                                ),
                              ),
                              Positioned(
                                  right: 10,
                                  top: 10,
                                  child: SvgPicture.asset(Images.cross))
                            ],
                          ),
                          20.verticalSpace(),
                          Stack(
                            children: [
                              Container(
                                padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 30),
                                decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(16),
                                    border: Border.all(color: ColorResources.grey)),
                                child: const CustomTextField2(
                                  title: 'Task Name',
                                ),
                              ),
                              Positioned(
                                  right: 10,
                                  top: 10,
                                  child: SvgPicture.asset(Images.cross))
                            ],
                          ),
                          40.verticalSpace(),
                          customButton("Save",
                              fontColor: 0xffffffff,
                              height: 60,
                              width: screenWidth(),
                              onTap: () {})
                        ],
                      ),
                    ),
                  )),
            ],
          )
        ],
      ),
    );
  }
}
