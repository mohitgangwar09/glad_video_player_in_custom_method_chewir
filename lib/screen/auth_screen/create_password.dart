import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:glad/cubit/auth_cubit/auth_cubit.dart';
import 'package:glad/screen/custom_widget/custom_methods.dart';
import 'package:glad/screen/custom_widget/custom_textfield.dart';
import 'package:glad/utils/color_resources.dart';
import 'package:glad/utils/extension.dart';
import 'package:glad/utils/images.dart';
import 'package:glad/utils/styles.dart';
import 'package:pin_code_fields/pin_code_fields.dart';

class CreatePassword extends StatefulWidget {
  final String? id,tagForgotPassword;
  const CreatePassword(this.tagForgotPassword,{Key? key,this.id}) : super(key: key);

  @override
  State<CreatePassword> createState() => _CreatePasswordState();
}

class _CreatePasswordState extends State<CreatePassword> {


  @override
  Widget build(BuildContext context) {

    // BlocProvider.of<AuthCubit>(context).emit(AuthCubitState.initial());

    return SafeArea(
      bottom: true,
      top: false,
      maintainBottomViewPadding: false,
      child: Scaffold(
        backgroundColor: ColorResources.maroon,
        body: hideKeyboard(
          context,
          child: SingleChildScrollView(
            child: SizedBox(
              width: screenWidth(),
              height: screenHeight(),
              child: authBackgroundForgotOtp(
                widget: mainView(),
              ),
            ),
          ),
        ),
      ),
    );
  }

  // main View
  Widget mainView() {
    return BlocBuilder<AuthCubit,AuthCubitState>(
        builder: (BuildContext contexts, state) {
        return Padding(
          padding: const EdgeInsets.symmetric(vertical: 80),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [

              Padding(
                padding: const EdgeInsets.only(left: 35.0),
                child: SvgPicture.asset(
                  Images.onboardingLogo,
                  height: 60,
                ),
              ),

              Padding(
                padding: const EdgeInsets.only(left: 35.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text("Create New password?",
                      style: figtreeMedium.copyWith(
                          color: Colors.black,
                          fontSize: 24
                      ),),

                    Padding(
                      padding: const EdgeInsets.only(top: 12.0),
                      child: Text.rich(
                          TextSpan(
                              text: 'Enter the address associated with your account.',
                              style: figtreeRegular.copyWith(fontSize: 14),
                              children: const <InlineSpan>[
                              ]
                          )
                      ),
                    ),

                  ],
                ),
              ),


              Column(
                children: [

                  Padding(
                    padding: const EdgeInsets.fromLTRB(40,21,40,0),
                    child: SizedBox(
                      height: 55,
                      child: CustomTextField(hint: 'Email',
                        controller: state.emailController,
                        onChanged: (value){

                        },
                        style: figtreeRegular.copyWith(
                            color: Colors.black,
                            fontSize: 14
                        ),
                        enabled: false,
                        underLineBorderColor: const Color(0xff727272),
                        image: Images.emailPhone,imageColors: Colors.black,withoutBorder: true,),
                    ),
                  ),



                  Padding(
                    padding: const EdgeInsets.fromLTRB(40,21,40,0),
                    child: Stack(
                      children: [


                        CustomTextField(hint: 'New Password',
                          controller: state.passwordController,
                          borderColor: 0xff727272,
                          onChanged: (value){
                            context.read<AuthCubit>().password();
                          },
                          style: figtreeRegular.copyWith(
                              color: Colors.black,
                              fontSize: 14
                          ),
                          maxLine: 1,
                          obscureText: state.passwordVisible,
                          withoutBorder: true,
                          underLineBorderColor: const Color(0xff727272),),

                        Positioned(
                          right: -10,
                          top: 0,
                          child: IconButton(
                            icon: Icon(
                              // Based on passwordVisible state choose the icon
                              state.passwordVisible
                                  ? Icons.visibility_off
                                  : Icons.visibility,
                              color: Colors.black,
                            ),
                            onPressed: () {
                              context.read<AuthCubit>().passwordVisible();
                            },
                          ),
                        )
                      ],
                    ),
                  ),

                  if(state.validator == "password"|| state.validator == "length" ||state.validator == "weak")
                    Padding(padding: const EdgeInsets.only(left: 40),
                      child: validator(state.validatorString),),

                  Padding(
                    padding: const EdgeInsets.fromLTRB(40,21,40,0),
                    child: Stack(
                      children: [
                        CustomTextField(hint: 'Confirm Password',
                          controller: state.confirmPasswordController,
                          borderColor: 0xff727272,
                          obscureText: state.confirmVisible,
                          style: figtreeRegular.copyWith(
                              color: Colors.black,
                              fontSize: 14
                          ),
                          onChanged: (value){
                            context.read<AuthCubit>().confirmValidate();
                          },
                          maxLine: 1,
                          withoutBorder: true,
                          imageColors: Colors.black,
                          underLineBorderColor: const Color(0xff727272),),
                        Positioned(
                          right: -10,
                          top: 0,
                          child: IconButton(
                            icon: Icon(
                              // Based on passwordVisible state choose the icon
                              state.confirmVisible
                                  ? Icons.visibility_off
                                  : Icons.visibility,
                              color: Colors.black,
                            ),
                            onPressed: () {
                              context.read<AuthCubit>().confirmVisible();
                            },
                          ),
                        )
                      ],
                    ),
                  ),

                  if(state.validator == "confirmPassword"|| state.validator == "invalid")
                    Padding(padding: const EdgeInsets.only(left: 40),
                      child: validator(state.validatorString),),
                ],
              ),

              Center(
                  child: customButton("Submit", style:figtreeSemiBold.copyWith(
                      color: Colors.black
                  ),onTap: (){
                    context.read<AuthCubit>().createPasswordAPi(context,widget.id.toString(),widget.tagForgotPassword.toString());
                  },
                      borderColor: 0xFF6A0030,
                      color: 0x00000000)
              ),


            ],
          ),
        );
      }
    );
  }

}