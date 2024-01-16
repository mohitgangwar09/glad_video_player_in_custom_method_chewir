import 'dart:async';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:glad/cubit/livestock_cubit/livestock_cubit.dart';
import 'package:glad/cubit/project_cubit/project_cubit.dart';
import 'package:glad/screen/custom_widget/custom_methods.dart';
import 'package:glad/screen/custom_widget/custom_textfield2.dart';
import 'package:glad/utils/color_resources.dart';
import 'package:glad/utils/extension.dart';
import 'package:glad/utils/images.dart';
import 'package:glad/utils/styles.dart';
import 'package:pin_code_fields/pin_code_fields.dart';

import '../../../data/model/farmer_project_detail_model.dart';


class AddLivestockRemark extends StatefulWidget {
  final FarmerMaster projectData;
  final Seller seller;
  final int livestockId;
  final String status;
  AddLivestockRemark({super.key,required this.projectData,required this.livestockId,required this.status,required this.seller});

  @override
  State<AddLivestockRemark> createState() => _AddLivestockRemarkState();
}

class _AddLivestockRemarkState extends State<AddLivestockRemark> {
  int secondsRemaining = 20;
  bool enableResend = false;
  String date = '';
  late Timer timer;
  String selectOption = "Select Option",istClickOnSendOtp = "";

  final TextEditingController controller = TextEditingController();

  /*@override
  initState() {
    super.initState();
  }*/

  @override
  dispose() {
    timer.cancel();
    controller.dispose();
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
                          istClickOnSendOtp == ""?const SizedBox.shrink():
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
          controller: controller,
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
        istClickOnSendOtp == ""?
        customButton('Send OTP', fontColor: 0xffFFFFFF,
            onTap: istClickOnSendOtp ==""?() {

              istClickOnSendOtp = "click";

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

              BlocProvider.of<ProjectCubit>(context).sendProjectStatusOtpApi(context,
                  widget.seller.phone.toString()
              );
            }:(){}):const SizedBox.shrink(),

        30.verticalSpace(),

        Container(
          height: 100,
          width: screenWidth(),
          decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(16),
              border: Border.all(color: ColorResources.grey)),
          child: Padding(
            padding: const EdgeInsets.fromLTRB(15.0, 16, 0, 10),
            child: Column(
              children: [
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    widget.seller.photo!=null?
                    CircleAvatar(
                        radius: 33,
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(40),
                          child: CachedNetworkImage(
                            imageUrl: widget.seller.photo ?? '',
                            errorWidget: (_, __, ___) {
                              return Image.asset(
                                Images.sampleUser,
                                fit: BoxFit.cover,
                                width: 80,
                                height: 80,
                              );
                            },
                            fit: BoxFit.cover,
                            width: 80,
                            height: 80,
                          ),
                        )) :
                    CircleAvatar(
                      radius: 30,
                      child: Image.asset(
                        Images.sampleUser,
                        fit: BoxFit.cover,
                        width: 80,
                        height: 80,
                      ),
                    ),
                    15.horizontalSpace(),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(widget.seller.name ?? '',
                            style: figtreeMedium.copyWith(
                                fontSize: 16, color: Colors.black)),
                        10.verticalSpace(),
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            const Icon(
                              Icons.call,
                              color: Colors.black,
                              size: 16,
                            ),
                            Text(widget.seller.phone ?? '',
                                style: figtreeRegular.copyWith(
                                    fontSize: 12, color: Colors.black)),
                          ],
                        ),
                        4.verticalSpace(),
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            const Icon(
                              Icons.location_on,
                              color: Colors.black,
                              size: 16,
                            ),
                            SizedBox(
                              width: MediaQuery.of(context).size.width *
                                  0.5,
                              child: Text(widget.seller.address!=null?
                              widget.seller.address!.address!=null ?widget.seller.address!.address!.toString():"":"",
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                                style: figtreeRegular.copyWith(
                                  fontSize: 12,
                                  color: Colors.black,
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ),
                            ),
                          ],
                        ),

                      ],
                    )
                  ],
                ),
              ],
            ),
          ),
        ),

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
                        BlocProvider.of<ProjectCubit>(context).sendProjectStatusOtpApi(context,
                            widget.seller.phone.toString()
                        );
                        // BlocProvider.of<AuthCubit>(context).resendOtp(context,widget.);
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
              onTap: () {
                pressBack();
              },
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
              // print("Completed");
              // ThankYou(profileData:widget.profileData,improvementProfileData:widget.projectData).navigate();
              // const UploadProfilePicture().navigate();
            },
            onChanged: (value) async{
              if(value.length==4){

                var future = await BlocProvider.of<LivestockCubit>(context).verifyProjectStatus(context, value.toString(),);

                if(future.status == 200){
                  BlocProvider.of<ProjectCubit>(context).loanStatusUpdateApi(context, widget.livestockId,
                      widget.status.toString(),
                      controller.text ?? '',
                      widget.projectData);
                }

              }
              // setState(() {
              //   // currentText = value;
              // });
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
    );}

}
