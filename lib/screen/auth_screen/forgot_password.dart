import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
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
    return SafeArea(
      bottom: true,
      top: false,
      child: Scaffold(
        backgroundColor: ColorResources.maroon,
        body: hideKeyboard(
          context,
          child: SingleChildScrollView(
            child: SizedBox(
              height: screenHeight(),
              width: screenWidth(),
              child: customBackground(
                widget: mainView(),
              ),
            ),
          ),
        ),
      ),
    );
  }

  // pinFieldController
  Widget pinFieldController(){
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
              print("Completed");
            },
            onChanged: (value) {
              print(value);
              setState(() {
                // currentText = value;
              });
            },
            beforeTextPaste: (text) {
              print("Allowing to paste $text");
              //if you return true then it will show the paste confirmation dialog. Otherwise if false, then nothing will happen.
              //but you can show anything you want here, like your pop up saying wrong paste format or etc
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



          Padding(
            padding: const EdgeInsets.fromLTRB(40,21,40,0),
            child: CustomTextField(hint: 'Email',text: '',
              borderColor: 0xff727272,
              style: figtreeRegular.copyWith(
                  color: Colors.black,
                  fontSize: 14
              ),
              image: Images.emailPhone,withoutBorder: true,
              imageColors: Colors.black,
              underLineBorderColor: const Color(0xff727272),),
          ),

          Center(
            child: customButton("Submit", style:figtreeSemiBold.copyWith(
              color: Colors.black
            ),onTap: (){},
            borderColor: 0xFF6A0030,
            color: 0x00000000)
          ),


        ],
      ),
    );
  }



}