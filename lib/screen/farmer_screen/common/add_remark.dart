import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:glad/screen/auth_screen/upload_profile_picture.dart';
import 'package:glad/screen/custom_widget/custom_methods.dart';
import 'package:glad/utils/extension.dart';
import 'package:glad/utils/images.dart';
import 'package:glad/utils/styles.dart';
import 'package:pin_code_fields/pin_code_fields.dart';

class AddRemark extends StatefulWidget {
  const AddRemark({super.key});

  @override
  State<AddRemark> createState() => _AddRemarkState();
}

class _AddRemarkState extends State<AddRemark> {
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
  dispose() {
    timer.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Positioned(left: 80, child: SvgPicture.asset(Images.addRemark1)),
          Positioned(
              bottom: 0, right: 0, child: SvgPicture.asset(Images.otpBack1)),
          Padding(
            padding: const EdgeInsets.only(top: 40.0),
            child: Column(
              children: [
                Stack(
                  alignment: Alignment.centerLeft,
                  children: [
                    Center(
                      child: Text(
                        'Add remarks',
                        style: figtreeMedium.copyWith(fontSize: 22),
                      ),
                    ),
                    Positioned(
                        child: IconButton(
                            onPressed: () {
                              Navigator.pop(context);
                            },
                            icon: const Icon(Icons.arrow_back))),
                  ],
                ),
                Expanded(
                  child: SingleChildScrollView(
                    child: Padding(
                      padding: const EdgeInsets.fromLTRB(25, 20, 25, 0),
                      child: Column(
                        children: [
                          remarkOtp(),
                          mainView(),
                          // pinFieldController(context),
                        ],
                      ),
                    ),
                  ),
                )
              ],
            ),
          )
        ],
      ),
    );
  }

  Widget remarkOtp() {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            SvgPicture.asset(Images.addRemark),
          ],
        ),
        TextField(
          maxLines: 5,
          minLines: 5,
          decoration: InputDecoration(
              hintText: 'Write...',
              hintStyle: figtreeMedium.copyWith(fontSize: 18),
              border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: const BorderSide(
                    width: 1,
                    color: Color(0xff999999),
                  ))),
        ),
        30.verticalSpace(),
        customButton('Send OTP', fontColor: 0xffFFFFFF, onTap: () {})
      ],
    );
  }

  // main View
  Widget mainView() {
    return Column(
      children: [
        30.verticalSpace(),
        Text(
          'Please enter the OTP sent to Farmer',
          style: figtreeMedium.copyWith(fontSize: 18),
        ),
        40.verticalSpace(),
        Column(
          children: [
            pinFieldController(context),
            Container(
              margin: const EdgeInsets.only(top: 16),
              width: screenWidth(),
              child: Align(
                alignment: Alignment.center,
                child: Visibility(
                  visible: !enableResend,
                  child: Text(
                    'Resend Code in '.tr +
                        secondsRemaining.toString() +
                        ' second'.tr,
                    style: figtreeMedium.copyWith(
                        fontSize: 16, color: const Color(0xff18444B)),
                  ),
                ),
              ),
            ),
            Visibility(
              visible: enableResend,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    secondsRemaining > 0
                        ? "Didn't receive the OTP? ".tr +
                            secondsRemaining.toString() +
                            ' second'.tr
                        : "Didn't receive the OTP? ",
                    style: figtreeMedium.copyWith(
                        fontSize: 16, color: const Color(0xff18444B)),
                  ),
                  customTextButton(
                      text: "Resend",
                      onTap: () {
                        setState(() {
                          secondsRemaining = 30;
                          enableResend = false;
                        });
                      },
                      decoration: TextDecoration.underline,
                      color: const Color(0xffFC5E60),
                      fontSize: 16)
                ],
              ),
            ),
          ],
        ),
        40.verticalSpace(),
        Center(
          child: customTextButton(
              onTap: () {},
              text: "Cancel",
              color: const Color(0xff727272),
              fontSize: 15,
              decoration: TextDecoration.underline),
        ),
      ],
    );
  }

  // pinFieldController
  Widget pinFieldController(context) {
    return Padding(
      padding: const EdgeInsets.only(left: 40.0, right: 40),
      child: Stack(
        children: [
          PinCodeTextField(
            appContext: context,
            length: 4,
            textStyle: figtreeRegular.copyWith(color: Colors.black),
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
              inactiveBorderWidth: 1.5,
              activeFillColor: Colors.grey,
              inactiveColor: Colors.grey,
              inactiveFillColor: Colors.grey,
              activeColor: Colors.grey,
              fieldHeight: 42,
              // fieldOuterPadding: 2.paddingAll(),
            ),
            onCompleted: (v) {
              print("Completed");
              const UploadProfilePicture().navigate();
            },
            onChanged: (value) {
              print(value);
              // setState(() {
              //   // currentText = value;
              // });
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
    );}

}
