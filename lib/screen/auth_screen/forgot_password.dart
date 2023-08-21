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

class ForgotPassword extends StatefulWidget {
  const ForgotPassword({Key? key}) : super(key: key);

  @override
  State<ForgotPassword> createState() => _ForgotPasswordState();
}

class _ForgotPasswordState extends State<ForgotPassword> {

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      bottom: true,
      top: false,
      maintainBottomViewPadding: false,
      child: WillPopScope(
        onWillPop: () async{
          BlocProvider.of<AuthCubit>(context).emit(AuthCubitState.initial());
          pressBack();
          return false;
        },
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
      ),
    );
  }

  // main View
  Widget mainView() {
    return BlocBuilder<AuthCubit,AuthCubitState>(
      builder: (BuildContext context, state) {
        return Padding(
          padding: const EdgeInsets.symmetric(vertical: 80),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [

              Padding(
                padding: const EdgeInsets.only(left: 35.0),
                child: SvgPicture.asset(Images.loginLogo,width: 162,height: 50,),
              ),

              Padding(
                padding: const EdgeInsets.only(left: 35.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text("Forgot password?",
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
                    child: CustomTextField(hint: 'Email',
                      controller: state.emailController,
                      borderColor: 0xff727272,
                      style: figtreeRegular.copyWith(
                          color: Colors.black,
                          fontSize: 14
                      ),
                      onChanged: (value){
                      context.read<AuthCubit>().emailValidate();
                      },
                      image: Images.emailPhone,withoutBorder: true,
                      imageColors: Colors.black,
                      underLineBorderColor: const Color(0xff727272),),
                  ),
                  if(state.validator == "email" || state.validator == "emailError")
                    Padding(padding: const EdgeInsets.only(left: 40),
                      child: validator(state.validatorString,
                          color: Colors.red),),
                ],
              ),



              Center(
                  child: customButton("Submit", style:figtreeSemiBold.copyWith(
                      color: Colors.black
                  ),onTap: (){
                    context.read<AuthCubit>().forgotPasswordApi(context);
                  }, borderColor: 0xFF6A0030,
                      color: 0x00000000)
              ),


            ],
          ),
        );
      },
    );
  }

}