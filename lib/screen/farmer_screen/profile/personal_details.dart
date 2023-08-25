import 'package:flutter/material.dart';
import 'package:glad/screen/custom_widget/custom_dropdown.dart';
import 'package:glad/screen/custom_widget/custom_methods.dart';
import 'package:glad/screen/custom_widget/custom_textfield2.dart';
import 'package:glad/utils/color_resources.dart';
import 'package:glad/utils/extension.dart';
import 'package:glad/utils/images.dart';
import 'package:glad/utils/styles.dart';

class PersonalDetails extends StatelessWidget {
  const PersonalDetails({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20.0),
      child: Column(
        children: [
          const CustomTextField2(title: 'Name'),
          20.verticalSpace(),
          const CustomTextField2(title: 'Email'),
          20.verticalSpace(),
          CustomDropdown(
            title: 'Gender',
            itemList: const ['Male', 'Female'],
            dropdownValue: null,
            icon: Images.arrowDropdown,
            iconColor: Colors.black,
            onChanged: (String? value) {},
          ),
          20.verticalSpace(),
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
          20.verticalSpace(),
          CustomTextField2(
            title: 'Farming since',
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
          40.verticalSpace(),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20.0),
            child: customButton(
              'Save',
              onTap: () { },
              radius: 40,
              width: double.infinity,
              height: 60,
              style: figtreeMedium.copyWith(
                  color: Colors.white, fontSize: 16),
            ),
          ),
          20.verticalSpace(),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20.0),
            child: customButton('Cancel',
                onTap: () {},
                radius: 40,
                width: double.infinity,
                height: 60,
                style: figtreeMedium.copyWith(
                    color: Colors.black, fontSize: 16),
                color: 0xFFDCDCDC),
          ),
        ],
      ),
    );
  }
}
