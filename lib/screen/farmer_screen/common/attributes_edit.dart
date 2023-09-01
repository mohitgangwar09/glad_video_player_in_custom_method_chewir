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

class AttributesEdit extends StatelessWidget {
  const AttributesEdit({super.key});

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
                titleText1: 'Attributes',
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
                      child: Column(
                children: [
                  attributesTextFieldButton(),
                ],
              )))
            ],
          )
        ],
      ),
    );
  }

////////////TextField//////////////
  Widget attributesTextFieldButton() {
    return Padding(
      padding: const EdgeInsets.fromLTRB(20, 0, 20, 0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          30.verticalSpace(),
          CustomDropdown(
              hint: '',
              width: 1,
              borderColor: 0xff727272 ,
              title: 'Type',
              dropdownValue: null,
              itemList: const ['', ''],
              onChanged: (String) {},
              icon: Images.arrowDropdown,
              iconColor: Colors.black),
          20.verticalSpace(),
          CustomDropdown(
              hint: '',
              width: 1,
              borderColor: 0xff727272 ,
              title: 'Size Capacity',
              dropdownValue: null,
              itemList: const ['', ''],
              onChanged: (String) {},
              icon: Images.arrowDropdown,
              iconColor: Colors.black),
          20.verticalSpace(),
          Row(
            children: [
              const Expanded(child: CustomTextField2(title:'Required Qty',width: 1,borderColor: 0xff727272,hint: '',),),
              10.horizontalSpace(),
              Expanded(
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

            ],
          ),
          20.verticalSpace(),
          const CustomTextField2(title:'Price per unit',width: 1,borderColor: 0xff727272,hint: '',),
          80.verticalSpace(),
          Padding(
            padding: const EdgeInsets.only(left: 10, right: 10),
            child: customButton('Save',
                style: figtreeMedium.copyWith(color: Colors.white),
                width: screenWidth(),
                height: 60,
                onTap: () {}),
          )
        ],
      ),
    );
  }
}
