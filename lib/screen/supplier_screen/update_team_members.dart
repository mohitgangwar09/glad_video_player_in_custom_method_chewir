import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:glad/cubit/profile_cubit/profile_cubit.dart';
import 'package:glad/data/model/respone_team_member.dart';
import 'package:glad/screen/custom_widget/custom_appbar.dart';
import 'package:glad/screen/custom_widget/custom_dropdown.dart';
import 'package:glad/screen/custom_widget/custom_methods.dart';
import 'package:glad/screen/custom_widget/custom_textfield2.dart';
import 'package:glad/utils/color_resources.dart';
import 'package:glad/utils/extension.dart';
import 'package:glad/utils/images.dart';
import 'package:glad/utils/styles.dart';
import 'package:lite_rolling_switch/lite_rolling_switch.dart';

class UpdateTeamMembers extends StatefulWidget {
  const UpdateTeamMembers({super.key,required this.dataMemberList});
  final DataMemberList dataMemberList;

  @override
  State<UpdateTeamMembers> createState() => _UpdateTeamMembersState();
}

class _UpdateTeamMembersState extends State<UpdateTeamMembers> {

  TextEditingController nameController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  String? teamMemberStatus;

  @override
  void initState() {
    super.initState();
    nameController.text = widget.dataMemberList.name.toString();
    phoneController.text = widget.dataMemberList.phone.toString();
    emailController.text = widget.dataMemberList.email.toString();
    teamMemberStatus = widget.dataMemberList.status.toString();
  }

  bool isEmail(String em) {
    String p =
        r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
    RegExp regExp = RegExp(p);
    return regExp.hasMatch(em);}

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

                        Align(
                          alignment: Alignment.centerLeft,
                          child: Padding(
                            padding: const EdgeInsets.only(top: 20),
                            child: SizedBox(
                              height: 38,
                              child: LiteRollingSwitch(
                                value: teamMemberStatus == "active"?true:false,
                                width: teamMemberStatus == "active"?100:120,
                                // width: 100,
                                textOn: 'Active',
                                textOff: 'Inactive',
                                // textSize: 11.5,
                                textOffColor: Colors.black,
                                textOnColor: Colors.white,
                                colorOn: const Color(0xff4BC56F),
                                colorOff: const Color(0xffECECFF),
                                iconOn: Icons.lightbulb_outline,
                                iconOff: Icons.power_settings_new_sharp,
                                animationDuration: const Duration(milliseconds: 300),
                                onChanged: (bool state) {
                                  // print('turned ${(state) ? 'on' : 'off'}');
                                  setState(() {
                                    // teamMemberStatus == "active"? 'inactive' : 'active';
                                    teamMemberStatus = (state) ? 'active' : 'inactive';
                                    // print(teamMemberStatus);
                                  });
                                },
                                onDoubleTap: () {},
                                onSwipe: () {},
                                onTap: () {},
                              ),
                            ),
                          ),
                        ),

                        40.verticalSpace(),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 20.0),
                          child: customButton(
                            'Save',
                            onTap: () {
                              if(nameController.text.isEmpty){
                                showCustomToast(context, 'Please enter name');
                              }else if(phoneController.text.isEmpty){
                                showCustomToast(context, 'Please enter mobile');
                              }else if(phoneController.text.length<8){
                                showCustomToast(context, 'Please enter valid mobile number');
                              }else if(emailController.text.isEmpty){
                                showCustomToast(context, 'Please enter email');
                              }else if(!isEmail(emailController.text)){
                                showCustomToast(context, 'Please enter valid email');
                              }else{
                                BlocProvider.of<ProfileCubit>(context).updateTeamMembersApi(context, widget.dataMemberList.id.toString() ,nameController.text, emailController.text, phoneController.text.toString(),teamMemberStatus.toString());
                              }
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