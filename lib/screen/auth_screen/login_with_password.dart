import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:glad/cubit/auth_cubit/auth_cubit.dart';
import 'package:glad/screen/auth_screen/create_password.dart';
import 'package:glad/screen/auth_screen/forgot_password.dart';
import 'package:glad/screen/auth_screen/login_with_otp.dart';
import 'package:glad/screen/auth_screen/otp.dart';
import 'package:glad/screen/custom_widget/custom_methods.dart';
import 'package:glad/screen/custom_widget/custom_textfield.dart';
import 'package:glad/screen/extra_screen/navigation.dart';
import 'package:glad/utils/extension.dart';
import 'package:glad/utils/images.dart';
import 'package:glad/utils/styles.dart';

class LoginWithPassword extends StatelessWidget {
  const LoginWithPassword({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    return SafeArea(
      bottom: true,
      top: false,
      child: Scaffold(
        body: hideKeyboard(
          context,
          child: SingleChildScrollView(
            child: SizedBox(
              height: screenHeight(),
              child: BlocBuilder<AuthCubit,AuthCubitState>(
                builder: (BuildContext context, state) {
                  return LayoutBuilder(
                    builder: (BuildContext context, BoxConstraints constraints) {
                      if(constraints.maxHeight<750){
                        return smallDevice(context);
                      }
                      return largeDevice(context);
                    },
                  );
                },
              ),
            ),
          ),
        ),
      ),
    );
  }
}

Widget smallDevice(BuildContext context){
  return Stack(
    children: [

      Positioned(
          top: screenHeight()*0.092,
          left: 0,
          right: 0,
          child: SvgPicture.asset(
            Images.onboardingLogo,
            height: 60,
          ),),

      Positioned(
        bottom: screenHeight()*0.04,
        left: 0,
        right: 0,
        child: loginWithOtp(context),
      ),

      Align(
          alignment: Alignment.topRight,child: SvgPicture.asset(Images.loginBack_1,width: screenWidth()*0.5,height: screenHeight()*0.35,)),

      Center(child: Padding(
        padding: const EdgeInsets.only(top: 50.0,bottom: 0),
        child: card(context),
      )),

      Positioned(bottom: 0,
          child:SvgPicture.asset(Images.loginBack_2,width: screenWidth()*0,height: screenHeight()*0.132,)),

      Positioned(
          bottom: screenWidth()*0.17,
          right: screenWidth()*0.09,
          child: SvgPicture.asset(Images.loginBelowBack,width: 35,height: 35,))

    ],
  );
}

Widget largeDevice(BuildContext context){
  return Stack(
    children: [

      Positioned(
          top: screenHeight()*0.12,
          left: 0,
          right: 0,
          child: SvgPicture.asset(
            Images.onboardingLogo,
            height: 60,
          ),),

      Positioned(
        bottom: screenHeight()*0.068,
        left: 0,
        right: 0,
        child: loginWithOtp(context),
      ),

      Align(
          alignment: Alignment.topRight,child: SvgPicture.asset(Images.loginBack_1,width: screenWidth()*0.35,height: screenHeight()*0.35,)),

      Center(child: Padding(
        padding: const EdgeInsets.only(top: 40.0,bottom: 10),
        child: card(context),
      )),

      Positioned(bottom: 0,
          child:SvgPicture.asset(Images.loginBack_2,width: screenWidth()*0,height: screenHeight()*0.15,)),

      Positioned(
          bottom: screenWidth()*0.3,
          right: screenHeight()*0.055,
          child: SvgPicture.asset(Images.loginBelowBack,width: 35,height: 35,))

    ],
  );
}

Widget card(BuildContext context){
  return BlocBuilder<AuthCubit,AuthCubitState>(
    builder: (BuildContext contexts, state) {
      return Stack(
        children: [

          SizedBox(
              height: screenWidth()*1.15,
              child: loginButton(context)),

          Positioned(
            top: 0,
            child: SizedBox(
              width: screenWidth(),
              child: Column(
                // mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [

                  Padding(
                    padding: const EdgeInsets.only(top: 60.0),
                    child: Text("Welcome back!",
                      style: figtreeMedium.copyWith(
                          color: Colors.white,
                          fontSize: 24
                      ),),
                  ),

                  Padding(
                    padding: const EdgeInsets.fromLTRB(40,21,40,0),
                    child: CustomTextField(hint: 'Email',
                      controller: state.emailController,
                      onChanged: (value){
                        context.read<AuthCubit>().emailValidate();
                      },
                      style: figtreeRegular.copyWith(
                          color: Colors.white,
                          fontSize: 14
                      ),
                      image: Images.emailPhone,withoutBorder: true,),
                  ),

                  if(state.validator == "email" || state.validator == "emailError")
                    Padding(padding: const EdgeInsets.only(left: 40),
                      child: validator(state.validatorString,
                      color: Colors.white),),

                  Padding(
                      padding: const EdgeInsets.fromLTRB(40,21,40,0),
                      child: Stack(
                        children: [

                          CustomTextField(hint: 'Password',
                            controller: state.passwordController,
                            withoutBorder: true,
                            maxLine: 1,
                            obscureText: state.passwordVisible,
                            style: figtreeRegular.copyWith(
                                color: Colors.white,
                                fontSize: 14
                            ),),

                          Positioned(
                            right: -10,
                            top: 0,
                            child: IconButton(
                              icon: Icon(
                                // Based on passwordVisible state choose the icon
                                state.passwordVisible
                                    ? Icons.visibility_off
                                    : Icons.visibility,
                                color: Colors.white,
                              ),
                              onPressed: () {
                                context.read<AuthCubit>().passwordVisible();
                              },
                            ),
                          )
                        ],
                      )
                  ),

                  if(state.validator == "password")
                    Padding(padding: const EdgeInsets.only(left: 40),
                      child: validator("Please enter password",
                          color: Colors.white),),

                  Padding(
                    padding: const EdgeInsets.only(top: 45.0),
                    child: TextButton(onPressed: (){
                      const ForgotPassword().navigate();
                      BlocProvider.of<AuthCubit>(context).emit(AuthCubitState.initial());
                    }, child: Text("Forgot password?",
                      style: figtreeMedium.copyWith(
                          color: const Color(0xffFC5E60),
                          decoration: TextDecoration.underline,
                          fontSize: 16
                      ),)),
                  )

                ],
              ),
            ),
          )

        ],
      );
    },
  );
}

Widget loginButton(BuildContext context){
  return Center(
    child: Stack(
      children: [

        SizedBox(
            height: screenHeight() * 0.65,
            width: screenWidth(),
            child: SvgPicture.asset(Images.cardLogin)),

        Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                InkWell(
                  onTap: (){

                    context.read<AuthCubit>().loginWithPasswordAPi(context);
                    // const Navigation().navigate();

                  }, child: Image.asset(Images.loginButton,
                  width: 80,height: 80,),
                ),
              ],
            )
        )
      ],
    ),
  );
}

Widget loginWithOtp(BuildContext context){
  return TextButton(onPressed: (){
    const LoginWithOTP().navigate();
    BlocProvider.of<AuthCubit>(context).emit(AuthCubitState.initial());
  }, child: Text("Login with OTP",
    style: figtreeMedium.copyWith(
      color: Colors.black,
      decoration: TextDecoration.underline,
      fontSize: 16,
    ),));
}