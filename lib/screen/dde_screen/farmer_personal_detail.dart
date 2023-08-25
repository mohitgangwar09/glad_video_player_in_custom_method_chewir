import 'package:flutter/material.dart';
import 'package:glad/screen/custom_widget/custom_appbar.dart';
import 'package:glad/screen/custom_widget/custom_dropdown.dart';
import 'package:glad/screen/custom_widget/custom_methods.dart';
import 'package:glad/screen/custom_widget/custom_textfield.dart';
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
                  personalDetails()]
                        ,
              )))
            ],
          )
        ],
      ),
    );
  }

  Widget personalDetails() {
    return Column(
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
        CustomDropdown(
          title: 'Mobile',
          dropdownValue: null,
          itemList: ['', '', ''],
          onChanged: (value) {},
          hint: '',
          icon: Images.arrowDropdown,
          iconColor: Colors.black,
        ),

      ],
    );
  }
}
