import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:glad/cubit/profile_cubit/profile_cubit.dart';
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
    return BlocBuilder<ProfileCubit,ProfileCubitState>(
        builder: (BuildContext context, state) {
        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0),
          child: Column(
            children: [
              CustomTextField2(title: 'Name',
                controller: state.nameController,),
              20.verticalSpace(),
              CustomTextField2(title: 'Email',
                controller: state.emailController,),
              20.verticalSpace(),
              CustomDropdown(
                title: 'Gender',
                itemList: const ['Male', 'Female'],
                dropdownValue: state.gender.toString(),
                icon: Images.arrowDropdown,
                iconColor: Colors.black,
                onChanged: (String? value) {
                  context.read<ProfileCubit>().selectGender(value.toString());
                },
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
                  onTap: () {
                    // context.read<ProfileCubit>().updatePersonalDetailApi(context, farmSize, dairyArea, staffQuantity, managerName, managerPhone);
                  },
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
    );
  }
}
