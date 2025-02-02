import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
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
                enabled: false,
                backgroundColor: Colors.grey.shade300.value,
                controller: TextEditingController()..text = state.responseFarmerProfile!.farmer!.name.toString(),),
              20.verticalSpace(),
              Row(
                children: [

                  SizedBox(
                    width: 100,
                    child: CustomTextField2(
                      title: 'Mobile',
                      backgroundColor: Colors.grey.shade300.value,
                      controller: TextEditingController(text: '+256'),
                      enabled: false,
                    ),
                  ),

                  10.horizontalSpace(),

                  Expanded(
                    child: CustomTextField2(title: '',
                      enabled: false,
                      backgroundColor: Colors.grey.shade300.value,
                      controller: state.phoneController..text = state.responseFarmerProfile!.farmer!.phone == null
                          ? ''
                          : state.responseFarmerProfile!.farmer!.phone
                          .toString(),),
                  ),
                ],
              ),
              20.verticalSpace(),
              CustomTextField2(title: 'Email',
                backgroundColor: Colors.grey.shade300.value,
                controller:  state.emailController..text = state.responseFarmerProfile!.farmer!.email == null
                    ? ''
                    : state.responseFarmerProfile!.farmer!.email
                    .toString(),
              enabled: false,),
              20.verticalSpace(),
              CustomDropdown(
                title: 'Gender',
                itemList: const ['Male', 'Female'],
                dropdownValue: state.gender,
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
                controller: TextEditingController()..text = state.selectDob == "0000-00-00"?"":state.selectDob,
                // controller: TextEditingController()..text = state.responseFarmerProfile!.farmer!.dateOfBirth.toString(),
                onTap: () async{
                  var selectDate = await selectedDate(context);
                  if(isAdult("${selectDate.month}-${selectDate.day}-${selectDate.year}")){
                    // BlocProvider.of<ProfileCubit>(context).selectDob("${selectDate.year}/${selectDate.month}/${selectDate.day}");
                    BlocProvider.of<ProfileCubit>(context).selectDob("${selectDate.year}/${selectDate.month}/${selectDate.day}");
                  }else{
                    ageToast(context);
                  }
                },
                focusNode: FocusNode(),
              ),

              20.verticalSpace(),
              Row(
                children: [

                  SizedBox(
                    width: 100,
                    child: CustomTextField2(
                      title: 'Landline No',
                      inputType: TextInputType.phone,
                      maxLine: 1,
                      enabled: false,
                      readOnly: false,
                      maxLength: 12,
                      inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                      controller: TextEditingController(text: '+256'),
                      // enabled: false,
                    ),
                  ),

                  10.horizontalSpace(),

                  Expanded(
                    child: CustomTextField2(title: '',
                      controller: state.landlineController,
                      inputType: TextInputType.phone,
                      maxLine: 1,
                      maxLength: 12,
                      inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                    ),
                  ),
                ],
              ),

              20.verticalSpace(),

              CustomTextField2(
                title: 'Farming since',
                image2: Images.calender,
                image2Colors: ColorResources.maroon,
                // hint: state.farmerSince.toString(),
                controller: TextEditingController()..text = state.farmerSince == "0000-00-00"?"":state.farmerSince,
                // controller: state.farmerSince,
                readOnly: true,
                onTap: () async{
                  var selectDate = await selectedDateFarmer(context);
                  BlocProvider.of<ProfileCubit>(context).farmerSince("${selectDate.year}/${selectDate.month}/${selectDate.day}");
                },
                focusNode: FocusNode(),
              ),
              40.verticalSpace(),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20.0),
                child: customButton(
                  'Save',
                  onTap: () {
                    context.read<ProfileCubit>().updatePersonalDetailApi(context);
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
                    onTap: () {
                  pressBack();
                    },
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