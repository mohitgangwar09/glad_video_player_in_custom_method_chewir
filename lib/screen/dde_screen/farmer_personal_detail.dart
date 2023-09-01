import 'package:flutter/material.dart';
import 'package:glad/screen/custom_widget/custom_appbar.dart';
import 'package:glad/screen/custom_widget/custom_dropdown.dart';
import 'package:glad/screen/custom_widget/custom_methods.dart';
import 'package:glad/screen/custom_widget/custom_textfield.dart';
import 'package:glad/screen/custom_widget/custom_textfield2.dart';
import 'package:glad/utils/color_resources.dart';
import 'package:glad/utils/extension.dart';
import 'package:glad/utils/images.dart';
import 'package:glad/utils/styles.dart';

class PersonalDetail extends StatelessWidget {
  const PersonalDetail({super.key});

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
                titleText1: 'Personal Details',
                leading: arrowBackButton(),
                centerTitle: true,
                description: 'Provide the following details',
                action: TextButton(
                  onPressed: () {},
                  child: Text(
                    'Save',
                    style: figtreeMedium.copyWith(
                        fontSize: 14, color: ColorResources.maroon),
                  ),
                ),
                titleText1Style:
                    figtreeMedium.copyWith(fontSize: 20, color: Colors.black),
              ),
              Expanded(
                  child: SingleChildScrollView(
                      child: Column(
                children: [
                  personalDetails(context),
                  saveCancelButton(),
                ],
              )))
            ],
          )
        ],
      ),
    );
  }

  Widget personalDetails(context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(24, 20, 24, 0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const CustomTextField2(title: 'Name',width: 1,borderColor: 0xff727272,hint: '',),
          25.verticalSpace(),
          Row(
            children: [
              SizedBox(
                width: 100,
                child: CustomDropdown(
                  hint: '',
                  width: 1,
                  borderColor: 0xff727272 ,
                  title: 'Mobile',
                    dropdownValue: null,
                    itemList: const ['', ''],
                    onChanged: (String) {},
                    icon: Images.arrowDropdown,
                    iconColor: Colors.black),
              ),
              10.horizontalSpace(),
              const Expanded(child: CustomTextField2(title:'',width: 1,borderColor: 0xff727272,hint: '',),)
            ],
          ),
          25.verticalSpace(),
          const CustomTextField2(title: 'Email',width: 1,borderColor: 0xff727272,hint: '',),
          25.verticalSpace(),
          CustomDropdown(
              width: 1,
              borderColor: 0xff727272 ,
              title: 'Gender',
              hint: '',
              dropdownValue: null,
              itemList: const ['', ''],
              onChanged: (String) {},
              icon: Images.arrowDropdown,
              iconColor: Colors.black),
          25.verticalSpace(),
          CustomTextField2(
            width: 1,
            borderColor: 0xff727272,
            title: 'DOB',
            hint: '',
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
          25.verticalSpace(),
          Row(
            children: [
              SizedBox(
                width: 100,
                child: CustomDropdown(
                    width: 1,
                    borderColor: 0xff727272 ,
                    title: 'Landline No',
                    hint: '',
                    dropdownValue: null,
                    itemList: const ['', ''],
                    onChanged: (String) {},
                    icon: Images.arrowDropdown,
                    iconColor: Colors.black),
              ),
              10.horizontalSpace(),
              const Expanded(child: CustomTextField2(title:'',width: 1,borderColor: 0xff727272,hint: '',),)
            ],
          ),
          25.verticalSpace(),
          CustomTextField2(
            width: 1,
            borderColor: 0xff727272 ,
            title: 'Farming Since',
            hint: '',
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
          25.verticalSpace(),
          CustomTextField2(
            width: 1,
            borderColor: 0xff727272 ,
            title: 'Farm Size',
            hint: '',
            image2Colors: ColorResources.maroon,
            readOnly: true,
            onTap: () {
            },
            focusNode: FocusNode(),
          ),
          25.verticalSpace(),
          CustomTextField2(
            width: 1,
            borderColor: 0xff727272 ,
            title: 'Dairy Area',
            hint: '',
            image2Colors: ColorResources.maroon,
            readOnly: true,
            onTap: () {

            },
            focusNode: FocusNode(),
          ),
          25.verticalSpace(),
          CustomTextField2(
            width: 1,
            borderColor: 0xff727272 ,
            title: 'No. of people working in the farm',
            hint: '',
            image2Colors: ColorResources.maroon,
            readOnly: true,
            onTap: () {
            },
            focusNode: FocusNode(),
          ),
          25.verticalSpace(),
          CustomTextField2(
            width: 1,
            borderColor: 0xff727272 ,
            title: 'Manger Name',
            hint: '',
            image2Colors: ColorResources.maroon,
            readOnly: true,
            onTap: () {
            },
            focusNode: FocusNode(),
          ),
          25.verticalSpace(),
          Row(
            children: [
              SizedBox(
                width: 110,
                child: CustomDropdown(
                    width: 1,
                    borderColor: 0xff727272 ,
                    title: "Manager's mobile",
                    hint: '',
                    dropdownValue: null,
                    itemList: const ['', ''],
                    onChanged: (String) {},
                    icon: Images.arrowDropdown,
                    iconColor: Colors.black),
              ),
              10.horizontalSpace(),
              const Expanded(child: CustomTextField2(title:'',width: 1,borderColor: 0xff727272,hint: '',),)
            ],
          ),
        ],
      ),
    );
  }

  Widget saveCancelButton() {
    return Padding(
      padding: const EdgeInsets.fromLTRB(29, 40, 29, 0),
      child: Column(
        children: [
          // 40.verticalSpace(),
          customButton(
            'Save',
            style: figtreeMedium.copyWith(color: Colors.white, fontSize: 16),
            onTap: () {},
            width: screenWidth(),
            height: 60,
          ),
          15.verticalSpace(),
          customButton('Cancel',
              style: figtreeMedium.copyWith(fontSize: 16),
              onTap: () {},
              width: screenWidth(),
              height: 60,
              color: 0xffDCDCDC),
          20.verticalSpace(),
        ],
      ),
    );
  }
}
