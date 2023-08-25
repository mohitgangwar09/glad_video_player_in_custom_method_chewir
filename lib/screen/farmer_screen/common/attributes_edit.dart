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
            itemList: const ['Male', 'Female'],
            dropdownValue: null,
            icon: Images.arrowDropdown,
            iconColor: Colors.black,
            onChanged: (String? value) {},
            title: 'Type',
          ),
          20.verticalSpace(),
          CustomDropdown(
            title: 'Size/Capacity',
            itemList: const ['Male', 'Female'],
            dropdownValue: null,
            icon: Images.arrowDropdown,
            iconColor: Colors.black,
            onChanged: (String? value) {},
            hint: '',
          ),
          20.verticalSpace(),
          SizedBox(
            width: screenWidth(),
            child: Row(
              children: [
                Expanded(
                    child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(left: 5.0),
                      child: Text(
                        'Required Qty.',
                        style: figtreeMedium.copyWith(fontSize: 13),
                      ),
                    ),
                    5.verticalSpace(),
                    Container(
                      // color: Colors.white,
                      decoration: BoxDecoration(
                          border:
                              Border.all(width: 1, color: ColorResources.grey),
                          borderRadius: BorderRadius.circular(8),
                          color: Colors.white),
                      height: 55,
                      child: const Padding(
                        padding: EdgeInsets.only(left: 10),
                        child: TextField(
                          decoration: InputDecoration(border: InputBorder.none),
                        ),
                      ),
                    ),
                  ],
                )),
                10.horizontalSpace(),
                Expanded(
                  child: CustomDropdown(
                    itemList: const ['Male', 'Female'],
                    dropdownValue: null,
                    icon: Images.arrowDropdown,
                    iconColor: Colors.black,
                    onChanged: (String? value) {},
                    hint: '',
                  ),
                ),
              ],
            ),
          ),
          20.verticalSpace(),
          Padding(
            padding: const EdgeInsets.only(left: 5.0),
            child: Text(
              'Price per unit',
              style: figtreeMedium.copyWith(fontSize: 13),
            ),
          ),
          5.verticalSpace(),
          Container(
            height: 55,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(08),
                color: Colors.white,
                border: Border.all(width: 1, color: ColorResources.grey)),
            child: const Padding(
              padding: EdgeInsets.only(left: 10),
              child: TextField(
                decoration: InputDecoration(
                  border: InputBorder.none,
                ),
              ),
            ),
          ),
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
