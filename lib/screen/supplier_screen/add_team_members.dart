import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:glad/cubit/profile_cubit/profile_cubit.dart';
import 'package:glad/screen/custom_widget/custom_appbar.dart';
import 'package:glad/screen/custom_widget/custom_dropdown.dart';
import 'package:glad/screen/custom_widget/custom_methods.dart';
import 'package:glad/screen/custom_widget/custom_textfield2.dart';
import 'package:glad/utils/color_resources.dart';
import 'package:glad/utils/extension.dart';
import 'package:glad/utils/images.dart';
import 'package:glad/utils/styles.dart';

class AddTeamMembers extends StatefulWidget {
  const AddTeamMembers({super.key});

  @override
  State<AddTeamMembers> createState() => _AddTeamMembersState();
}

class _AddTeamMembersState extends State<AddTeamMembers> {

  TextEditingController nameController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  TextEditingController emailController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(

        body: BlocBuilder<ProfileCubit,ProfileCubitState>(
          builder: (BuildContext context, state) {
            return Column(
              children: [
                CustomAppBar(
                    context: context,
                    centerTitle: true,
                    titleText1: 'Team Members',
                    titleText1Style:
                    figtreeMedium.copyWith(fontSize: 20, color: Colors.black),
                    leading: arrowBackButton()),

                SingleChildScrollView(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20.0,),
                    child: Column(
                      children: [

                        20.verticalSpace(),

                        CustomTextField2(title: 'Name',
                          enabled: true,
                          controller: nameController),
                        20.verticalSpace(),
                        Row(
                          children: [

                            SizedBox(
                              width: 100,
                              child: CustomTextField2(
                                title: 'Mobile',
                                controller: TextEditingController(text: '+256'),
                                enabled: false
                              ),
                            ),

                            10.horizontalSpace(),

                            Expanded(
                              child: CustomTextField2(title: '',
                                enabled: true,
                                inputType: TextInputType.phone,
                                maxLine: 1,
                                maxLength: 12,
                                inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                                controller: phoneController,),
                            ),
                          ],
                        ),
                        20.verticalSpace(),
                        CustomTextField2(title: 'Email',
                          controller:  emailController,
                          enabled: true,),

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
                  ),
                ),
              ],
            );
          }
      ),
    );
  }
}