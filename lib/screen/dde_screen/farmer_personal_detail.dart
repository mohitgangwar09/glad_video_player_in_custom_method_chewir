import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
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
                        onPressed: () {
                          context.read<ProfileCubit>().updateDdeFarmDetailApi(context,);
                        },
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
                  enabled: false,
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
                      child: CustomTextField2(
                        title: 'Mobile',
                        width: 1,
                        borderColor: 0xff727272,
                        controller: TextEditingController(text: '+256'),
                        enabled: false,
                      ),
                    ),
                    10.horizontalSpace(),
                    Expanded(
                      child: CustomTextField2(
                        title: '',
                        enabled: false,
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
                  enabled: false,
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
                    onChanged: (String? value) {
                      context.read<ProfileCubit>().selectGender(value.toString());
                    },
                    icon: Images.arrowDropdown,
                    iconColor: Colors.black),
                25.verticalSpace(),
                CustomTextField2(
                  width: 1,
                  borderColor: 0xff727272,
                  title: 'DOB',
                  controller: TextEditingController()..text = state.selectDob == "0000-00-00"?"":state.responseFarmerProfile!.farmer!.dateOfBirth!.toString(),
                  // controller: state.selectDob.toString() == ""?
                  //     TextEditingController(
                  //     text: state.responseFarmerProfile!.farmer!.dateOfBirth ==
                  //         state.selectDob.toString()
                  //         ? ''
                  //         : state.responseFarmerProfile!.farmer!.dateOfBirth
                  //         .toString()):TextEditingController(text: state.selectDob.toString()),
                  image2: Images.calender,
                  image2Colors: ColorResources.maroon,
                  readOnly: true,
                  onTap: () async{
                    var selectDate = await selectedDate(context);
                    BlocProvider.of<ProfileCubit>(context).selectDob("${selectDate.year}/${selectDate.month}/${selectDate.day}");
                  },
                  focusNode: FocusNode(),
                ),
                25.verticalSpace(),
                Row(
                  children: [
                    SizedBox(
                      width: 100,
                      child: CustomTextField2(
                        title: 'Landline No',
                        width: 1,
                        inputType: TextInputType.phone,
                        maxLine: 1,
                        maxLength: 12,
                        inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                        borderColor: 0xff727272,
                        controller: TextEditingController(text: '+256'),
                        // enabled: false,
                      ),
                    ),
                    10.horizontalSpace(),
                    Expanded(
                      child: CustomTextField2(
                          title: '',
                          width: 1,
                          borderColor: 0xff727272,
                          hint: '',
                          inputType: TextInputType.phone,
                          maxLine: 1,
                          maxLength: 12,
                          inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                          // enabled: false,
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
                  controller: TextEditingController()..text = state.farmerSince == "0000-00-00"?"":state.farmerSince,
                  title: 'Farming Since',
                  image2: Images.calender,
                  image2Colors: ColorResources.maroon,
                  readOnly: true,
                  onTap: () async{
                    var selectDate = await selectedDate(context);
                    BlocProvider.of<ProfileCubit>(context).farmerSince("${selectDate.year}/${selectDate.month}/${selectDate.day}");
                  },
                  focusNode: FocusNode(),
                ),
                25.verticalSpace(),
                CustomTextField2(
                  width: 1,
                  inputType: TextInputType.phone,
                  maxLine: 1,
                  maxLength: 12,
                  inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                  borderColor: 0xff727272,
                  title: 'Farm Size',
                  controller: state.farmSize
                    ..text = state.responseFarmerProfile!.farmer!.farmSize ==
                        null
                        ? ''
                        : state.responseFarmerProfile!.farmer!.farmSize
                        .toString(),
                  image2Colors: ColorResources.maroon,
                  // readOnly: true,
                  onTap: () {},
                  focusNode: FocusNode(),
                ),
                25.verticalSpace(),
                CustomTextField2(
                  width: 1,
                  inputType: TextInputType.phone,
                  maxLine: 1,
                  maxLength: 12,
                  inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                  borderColor: 0xff727272,
                  title: 'Dairy Area',
                  controller: state.dairyArea
                    ..text = state.responseFarmerProfile!.farmer!.dairyArea ==
                        null
                        ? ''
                        : state.responseFarmerProfile!.farmer!.dairyArea
                        .toString(),
                  image2Colors: ColorResources.maroon,
                  // readOnly: true,
                  onTap: () {},
                  focusNode: FocusNode(),
                ),
                25.verticalSpace(),
                CustomTextField2(
                  width: 1,
                  borderColor: 0xff727272,
                  inputType: TextInputType.phone,
                  maxLine: 1,
                  maxLength: 4,
                  inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                  title: 'No. of people working in the farm',
                  controller: state.staffQuantity
                    ..text =
                    state.responseFarmerProfile!.farmer!.staffQuantity == null
                        ? ''
                        : state.responseFarmerProfile!.farmer!.staffQuantity
                        .toString() ??
                        '2',
                  image2Colors: ColorResources.maroon,
                  // readOnly: true,
                  onTap: () {},
                  focusNode: FocusNode(),
                ),
                25.verticalSpace(),
                CustomTextField2(
                  width: 1,
                  maxLine: 1,
                  borderColor: 0xff727272,
                  title: 'Manger Name',
                  controller: state.managerName
                    ..text =
                    state.responseFarmerProfile!.farmer!.managerName == null
                        ? ''
                        : state.responseFarmerProfile!.farmer!.managerName
                        .toString(),
                  image2Colors: ColorResources.maroon,
                  onTap: () {},
                  focusNode: FocusNode(),
                ),
                25.verticalSpace(),
                Row(
                  children: [
                    SizedBox(
                      width: 110,
                      child: CustomTextField2(
                        title: 'Manager\'s mobile',
                        width: 1,
                        inputType: TextInputType.phone,
                        maxLine: 1,
                        maxLength: 12,
                        inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                        borderColor: 0xff727272,
                        controller: TextEditingController(text: '+256'),
                        enabled: true,
                      ),
                    ),
                    10.horizontalSpace(),
                    Expanded(
                      child: CustomTextField2(
                        title: '',
                        width: 1,
                        inputType: TextInputType.phone,
                        maxLine: 1,
                        maxLength: 12,
                        inputFormatters: [FilteringTextInputFormatter.digitsOnly],
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
            onTap: () {
              context.read<ProfileCubit>().updateFarmDetailApi(context);
            },
            width: screenWidth(),
            height: 60,
          ),
          15.verticalSpace(),
          customButton('Cancel',
              style: figtreeMedium.copyWith(fontSize: 16),
              onTap: () {
                pressBack();
              },
              width: screenWidth(),
              height: 60,
              color: 0xffDCDCDC),
          20.verticalSpace(),
        ],
      ),
    );
  }
}
