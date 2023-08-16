import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:glad/cubit/auth_cubit/auth_cubit.dart';
import 'package:glad/screen/auth_screen/upload_profile_picture.dart';
import 'package:glad/screen/custom_widget/custom_methods.dart';
import 'package:glad/screen/extra_screen/navigation.dart';
import 'package:glad/utils/color_resources.dart';
import 'package:glad/utils/extension.dart';
import 'package:glad/utils/images.dart';
import 'package:glad/utils/styles.dart';
import 'package:pin_code_fields/pin_code_fields.dart';

class OtpScreen extends StatefulWidget {
  const OtpScreen({Key? key}) : super(key: key);

  @override
  State<OtpScreen> createState() => _OtpScreenState();
}

class _OtpScreenState extends State<OtpScreen> {

  int secondsRemaining = 20;
  bool enableResend = false;
  late Timer timer;

  @override
  initState() {
    super.initState();
    timer = Timer.periodic(const Duration(seconds: 1), (_) {
      if (secondsRemaining != 0) {
        setState(() {
          secondsRemaining--;
        });
      } else {
        setState(() {
          enableResend = true;
        });
      }
    });
  }

  @override
  dispose(){
    timer.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {

    var provider = BlocProvider.of<AuthCubit>(context,listen: true);

    return SafeArea(
      bottom: true,
      top: false,
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

  // pinFieldController
  Widget pinFieldController(BuildContext context,AuthCubitState state){
    return Padding(
      padding: const EdgeInsets.only(left: 40.0,right: 40),
      child: Stack(
        children: [

          PinCodeTextField(appContext: context, length: 4,
            textStyle: figtreeRegular.copyWith(
                color: Colors.black),
            keyboardType: TextInputType.phone,
            obscureText: false,
            showCursor: true,
            cursorColor: Colors.grey,
            animationType: AnimationType.fade,
            controller: state.otpController,
            autoFocus: false,
            animationDuration: const Duration(milliseconds: 300),
            pinTheme: PinTheme(
              selectedColor: const Color(0xff727272),
              activeBorderWidth: 1.5,
              selectedBorderWidth: 1.5,
              disabledBorderWidth: 1.5,
              inactiveBorderWidth:1.5,
              activeFillColor: Colors.grey,
              inactiveColor: Colors.grey,
              inactiveFillColor: Colors.grey,
              activeColor: Colors.grey,
              fieldHeight: 42,
              // fieldOuterPadding: 2.paddingAll(),
            ),
            onCompleted: (v) {
            },
            onChanged: (value) {
              if(value.length==4)
              {
                if(enableResend)
                {
                  setState((){
                    secondsRemaining = 30;
                    enableResend = false;
                  });
                }
                context.read<AuthCubit>().verifyOtpAPi(context);

              }
            },
            beforeTextPaste: (text) {
              return true;
            },
          ),

          // Positioned(
          //   bottom: 0,left: 0,
          //   child: validator(provider.state.validator == 'otp'?'Please enter otp':provider.state.validator == 'length'?'Please input valid otp':''),)

        ],
      ),
    );
  }

  // main View
  Widget mainView() {
    return BlocBuilder<AuthCubit,AuthCubitState>(
      builder: (BuildContext contexts, state) {
        return Padding(
          padding: const EdgeInsets.symmetric(vertical: 110),
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
                    Text("OTP Verification",
                      style: figtreeMedium.copyWith(
                          color: Colors.black,
                          fontSize: 24
                      ),),

                    Padding(
                      padding: const EdgeInsets.only(top: 12.0),
                      child: Text.rich(
                          TextSpan(
                              text: 'Enter OTP we just sent to ',
                              style: figtreeRegular.copyWith(fontSize: 14),
                              children: <InlineSpan>[
                                TextSpan(
                                  text: state.emailController.text,
                                  style: figtreeRegular.copyWith(fontSize: 14,fontWeight: FontWeight.bold),
                                )
                              ]
                          )
                      ),
                    ),

                  ],
                ),
              ),



              Column(
                children: [

                  pinFieldController(context,state),

                  Container(
                    margin: const EdgeInsets.only(top: 16),
                    width: screenWidth(),
                    child: Align(
                      alignment: Alignment.center,
                      child: Visibility(
                        visible: !enableResend,
                        child: Text('Resend Code in '.tr+secondsRemaining.toString()+' second'.tr,
                          style: figtreeMedium.copyWith(
                              fontSize: 16,
                              color: const Color(0xff18444B)
                          ),),
                      ),
                    ),
                  ),

                  Visibility(
                    visible: enableResend,
                    child:  Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [

                        Text(secondsRemaining>0?"Didn't receive the OTP? ".tr+secondsRemaining.toString()+' second'.tr:"Didn't receive the OTP? ",
                          style: figtreeMedium.copyWith(
                              fontSize: 16,
                              color: const Color(0xff18444B)
                          ),),

                        customTextButton(text: "Resend",
                            onTap: (){
                              setState((){
                                secondsRemaining = 30;
                                enableResend = false;
                              });
                            },decoration: TextDecoration.underline,
                            color: const Color(0xffFC5E60),fontSize: 16)

                      ],
                    ),
                  ),

                ],
              ),

              Center(
                child: customTextButton(onTap: (){

                }, text: "Cancel",color: const Color(0xff727272),
                    fontSize: 15,decoration: TextDecoration.underline),
              ),


            ],
          ),
        );
      },
    );
  }



}