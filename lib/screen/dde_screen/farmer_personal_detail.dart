import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:glad/cubit/profile_cubit/profile_cubit.dart';
import 'package:glad/screen/custom_widget/custom_appbar.dart';
import 'package:glad/screen/custom_widget/custom_dropdown.dart';
import 'package:glad/screen/custom_widget/custom_methods.dart';
import 'package:glad/screen/custom_widget/custom_textfield.dart';
import 'package:glad/screen/custom_widget/custom_textfield2.dart';
import 'package:glad/utils/color_resources.dart';
import 'package:glad/utils/extension.dart';
import 'package:glad/utils/images.dart';
import 'package:glad/utils/styles.dart';

class PersonalDetail extends StatefulWidget {
  const PersonalDetail({super.key});

  @override
  State<PersonalDetail> createState() => _PersonalDetailState();
}

class _PersonalDetailState extends State<PersonalDetail> {
  @override
  void initState() {
    // BlocProvider.of<ProfileCubit>(context).getFarmerProfile(context);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocBuilder<ProfileCubit, ProfileCubitState>(
          builder: (context, state) {
            return Stack(
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
            );
          }),
    );
  }

  Widget personalDetails(context) {
    return BlocBuilder<ProfileCubit, ProfileCubitState>(
        builder: (context, state) {
          return Padding(
            padding: const EdgeInsets.fromLTRB(24, 20, 24, 0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CustomTextField2(
                  title: 'Name',
                  width: 1,
                  borderColor: 0xff727272,
                  controller: state.nameController
                    ..text = state.responseFarmerProfile!.farmer!.name
                        .toString(),
                ),
                25.verticalSpace(),
                Row(
                  children: [
                    SizedBox(
                      width: 100,
                      child: CustomDropdown(
                          hint: '',
                          width: 1,
                          borderColor: 0xff727272,
                          title: 'Mobile',
                          dropdownValue: null,
                          itemList: const ['', ''],
                          onChanged: (String) {},
                          icon: Images.arrowDropdown,
                          iconColor: Colors.black),
                    ),
                    10.horizontalSpace(),
                    Expanded(
                      child: CustomTextField2(
                        title: '',
                        width: 1,
                        borderColor: 0xff727272,
                        controller: state.phoneController
                          ..text =
                          state.responseFarmerProfile!.farmer!.phone == null
                              ? ''
                              : state.responseFarmerProfile!.farmer!.phone
                              .toString(),
                      ),
                    )
                  ],
                ),
                25.verticalSpace(),
                CustomTextField2(
                  title: 'Email',
                  width: 1,
                  controller: state.emailController
                    ..text = state.responseFarmerProfile!.farmer!.email
                        .toString(),
                  borderColor: 0xff727272,
                ),
                25.verticalSpace(),
                CustomDropdown(
                    width: 1,
                    borderColor: 0xff727272,
                    title: 'Gender',
                    hint: '',
                    dropdownValue: state.gender,
                    itemList: const ['Male', 'Female'],
                    onChanged: (String) {},
                    icon: Images.arrowDropdown,

                    iconColor: Colors.black),
                25.verticalSpace(),
                CustomTextField2(
                  width: 1,
                  borderColor: 0xff727272,
                  title: 'DOB',
                  controller: TextEditingController(
                      text: state.responseFarmerProfile!.farmer!.dateOfBirth ==
                          null
                          ? ''
                          : state.responseFarmerProfile!.farmer!.dateOfBirth
                          .toString()),
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
                          borderColor: 0xff727272,
                          title: 'Landline No',
                          hint: '',
                          dropdownValue: null,
                          itemList: const ['', ''],
                          onChanged: (String) {},
                          icon: Images.arrowDropdown,
                          iconColor: Colors.black),
                    ),
                    10.horizontalSpace(),
                    Expanded(
                      child: CustomTextField2(
                          title: '',
                          width: 1,
                          borderColor: 0xff727272,
                          hint: '',
                          controller: state.landlineController
                            ..text =
                                state.responseFarmerProfile!.farmer!
                                    .landlineNo ??
                                    123456789.toString()),
                    )
                  ],
                ),
                25.verticalSpace(),
                CustomTextField2(
                  width: 1,
                  borderColor: 0xff727272,
                  controller: TextEditingController(
                      text: state.responseFarmerProfile!.farmer!
                          .farmingExperience ==
                          null
                          ? ''
                          : state.responseFarmerProfile!.farmer!
                          .farmingExperience
                          .toString()),
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
                CustomTextField2(
                  width: 1,
                  borderColor: 0xff727272,
                  title: 'Farm Size',
                  controller: state.farmSize
                    ..text = state.responseFarmerProfile!.farmer!.farmSize ==
                        null
                        ? ''
                        : state.responseFarmerProfile!.farmer!.farmSize
                        .toString(),
                  image2Colors: ColorResources.maroon,
                  readOnly: true,
                  onTap: () {},
                  focusNode: FocusNode(),
                ),
                25.verticalSpace(),
                CustomTextField2(
                  width: 1,
                  borderColor: 0xff727272,
                  title: 'Dairy Area',
                  controller: state.dairyArea
                    ..text = state.responseFarmerProfile!.farmer!.dairyArea ==
                        null
                        ? ''
                        : state.responseFarmerProfile!.farmer!.dairyArea
                        .toString(),
                  image2Colors: ColorResources.maroon,
                  readOnly: true,
                  onTap: () {},
                  focusNode: FocusNode(),
                ),
                25.verticalSpace(),
                CustomTextField2(
                  width: 1,
                  borderColor: 0xff727272,
                  title: 'No. of people working in the farm',
                  controller: state.staffQuantity
                    ..text =
                    state.responseFarmerProfile!.farmer!.staffQuantity == null
                        ? ''
                        : state.responseFarmerProfile!.farmer!.staffQuantity
                        .toString() ??
                        '2',
                  image2Colors: ColorResources.maroon,
                  readOnly: true,
                  onTap: () {},
                  focusNode: FocusNode(),
                ),
                25.verticalSpace(),
                CustomTextField2(
                  width: 1,
                  borderColor: 0xff727272,
                  title: 'Manger Name',
                  controller: state.managerName
                    ..text =
                    state.responseFarmerProfile!.farmer!.managerName == null
                        ? ''
                        : state.responseFarmerProfile!.farmer!.managerName
                        .toString(),
                  image2Colors: ColorResources.maroon,
                  readOnly: true,
                  onTap: () {},
                  focusNode: FocusNode(),
                ),
                25.verticalSpace(),
                Row(
                  children: [
                    SizedBox(
                      width: 110,
                      child: CustomDropdown(
                          width: 1,
                          borderColor: 0xff727272,
                          title: "Manager's mobile",
                          hint: '',
                          dropdownValue: null,
                          itemList: const ['', ''],
                          onChanged: (String) {},
                          icon: Images.arrowDropdown,
                          iconColor: Colors.black),
                    ),
                    10.horizontalSpace(),
                    Expanded(
                      child: CustomTextField2(
                        title: '',
                        width: 1,
                        borderColor: 0xff727272,
                        controller: state.managerPhone
                          ..text = state.responseFarmerProfile!.farmer!
                              .managerPhone ==
                              null
                              ? ''
                              : state.responseFarmerProfile!.farmer!
                              .managerPhone
                              .toString() ??
                              '9876543111'.toString(),
                      ),
                    )
                  ],
                ),
              ],
            ),
          );
        });
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
