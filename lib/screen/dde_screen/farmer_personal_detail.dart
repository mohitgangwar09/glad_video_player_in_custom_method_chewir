
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
                        ]
                        ,
              )))
            ],
          )
        ],
      ),
    );
  }

  Widget personalDetails(context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(24,20,24,0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Name',
            style: figtreeSemiBold.copyWith(fontSize: 12),
          ),
          05.verticalSpace(),
          const CustomTextField(
            hint: '',
            paddingTop: 5,
            inputType: TextInputType.phone,
            paddingBottom: 21,
            maxLine: 1,
            width: 1,
            borderColor: 0xff999999,
          ),
          25.verticalSpace(),
          Text(
            'Mobile',
            style: figtreeSemiBold.copyWith(fontSize: 12),
          ),
          05.verticalSpace(),
          Row(
            children: [
              SizedBox(
                width:118,
                child: CustomDropdown(
                  dropdownValue: null,
                  itemList: ['', '', ''],
                  onChanged: (value) {},
                  hint: '',
                  icon: Images.arrowDropdown,
                  iconColor: Colors.black,
                ),
              ),
              10.horizontalSpace(),
              const Expanded(child: CustomTextField(
                hint: '',
                paddingTop: 5,
                inputType: TextInputType.phone,
                paddingBottom: 21,
                maxLine: 1,
                width: 1,
                borderColor: 0xff999999,
              ))
            ],
          ),
          25.verticalSpace(),
          Text(
            'Email',
            style: figtreeSemiBold.copyWith(fontSize: 12),
          ),
          05.verticalSpace(),
          const CustomTextField(
            hint: '',
            paddingTop: 5,
            inputType: TextInputType.phone,
            paddingBottom: 21,
            maxLine: 1,
            width: 1,
            borderColor: 0xff999999,
          ),
          25.verticalSpace(),
          Text(
            'Gender',
            style: figtreeSemiBold.copyWith(fontSize: 12),
          ),
          05.verticalSpace(),
          CustomDropdown(
            dropdownValue: null,
            itemList: ['', '', ''],
            onChanged: (value) {},
            hint: '',
            icon: Images.arrowDropdown,
            iconColor: Colors.black,
          ),
          25.verticalSpace(),
          CustomTextField2(
            title: 'DOB',
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
          Text(
            'Mobile',
            style: figtreeSemiBold.copyWith(fontSize: 12),
          ),
          05.verticalSpace(),
          Row(
            children: [
              SizedBox(
                width:118,
                child: CustomDropdown(
                  dropdownValue: null,
                  itemList: ['', '', ''],
                  onChanged: (value) {},
                  hint: '',
                  icon: Images.arrowDropdown,
                  iconColor: Colors.black,
                ),
              ),
              10.horizontalSpace(),
              const Expanded(child: CustomTextField(
                hint: '',
                paddingTop: 5,
                inputType: TextInputType.phone,
                paddingBottom: 21,
                maxLine: 1,
                width: 1,
                borderColor: 0xff999999,
              ))
            ],
          ),
          25.verticalSpace(),
          CustomTextField2(
            title: 'Farming Since',
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
          Text(
            'Farm Size',
            style: figtreeSemiBold.copyWith(fontSize: 12),
          ),
          05.verticalSpace(),
          const CustomTextField(
            hint: '',
            paddingTop: 5,
            inputType: TextInputType.phone,
            paddingBottom: 21,
            maxLine: 1,
            width: 1,
            borderColor: 0xff999999,
          ),
          25.verticalSpace(),
          Text(
            'Dairy Area',
            style: figtreeSemiBold.copyWith(fontSize: 12),
          ),
          05.verticalSpace(),
          const CustomTextField(
            hint: '',
            paddingTop: 5,
            inputType: TextInputType.phone,
            paddingBottom: 21,
            maxLine: 1,
            width: 1,
            borderColor: 0xff999999,
          ),
          25.verticalSpace(),
          Text(
            'No. of people working in the farm',
            style: figtreeSemiBold.copyWith(fontSize: 12),
          ),
          05.verticalSpace(),
          const CustomTextField(
            hint: '',
            paddingTop: 5,
            inputType: TextInputType.phone,
            paddingBottom: 21,
            maxLine: 1,
            width: 1,
            borderColor: 0xff999999,
          ),
          25.verticalSpace(),
          Text(
            'Manager Name',
            style: figtreeSemiBold.copyWith(fontSize: 12),
          ),
          05.verticalSpace(),
          const CustomTextField(
            hint: '',
            paddingTop: 5,
            inputType: TextInputType.phone,
            paddingBottom: 21,
            maxLine: 1,
            width: 1,
            borderColor: 0xff999999,
          ),
          25.verticalSpace(),
          Text(
            "Manager's Mobile",
            style: figtreeSemiBold.copyWith(fontSize: 12),
          ),
          05.verticalSpace(),
          Row(
            children: [
              SizedBox(
                width:118,
                child: CustomDropdown(
                  dropdownValue: null,
                  itemList: ['', '', ''],
                  onChanged: (value) {},
                  hint: '',
                  icon: Images.arrowDropdown,
                  iconColor: Colors.black,
                ),
              ),
              10.horizontalSpace(),
              const Expanded(child: CustomTextField(
                hint: '',
                paddingTop: 5,
                inputType: TextInputType.phone,
                paddingBottom: 21,
                maxLine: 1,
                width: 1,
                borderColor: 0xff999999,
              ))
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
