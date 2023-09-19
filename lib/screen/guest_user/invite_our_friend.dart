// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:glad/cubit/landing_page_cubit/landing_page_cubit.dart';
import 'package:glad/screen/custom_widget/container_border.dart';
import 'package:glad/screen/custom_widget/custom_appbar.dart';
import 'package:glad/screen/custom_widget/custom_methods.dart';
import 'package:glad/screen/custom_widget/custom_textfield.dart';
import 'package:glad/screen/custom_widget/g_map.dart';
import 'package:glad/utils/app_constants.dart';
import 'package:glad/utils/color_resources.dart';
import 'package:glad/utils/extension.dart';
import 'package:glad/utils/images.dart';
import 'package:glad/utils/styles.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:google_search_place/google_search_place.dart';
import 'package:google_search_place/model/prediction.dart';

class InviteAnExpert extends StatefulWidget {
  const InviteAnExpert({super.key});

  @override
  State<InviteAnExpert> createState() => _InviteAnExpertState();
}

class _InviteAnExpertState extends State<InviteAnExpert> {
  TextEditingController? nameController = TextEditingController();
  TextEditingController? mobileController = TextEditingController();
  TextEditingController? addressController = TextEditingController();
  TextEditingController? commentController = TextEditingController();
  final TextEditingController _searchPlaceController = TextEditingController();
  double? lat;
  double? long;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocBuilder<LandingPageCubit, LandingPageState>(
          builder: (context, state) {
        return Stack(
          children: [
            landingBackground(),
            Column(
              children: [
                CustomAppBar(
                  context: context,
                  titleText1: 'Invite an expert',
                  description: 'Provide the following details',
                  leading: arrowBackButton(),
                  centerTitle: true,
                ),
                Expanded(
                  child: SingleChildScrollView(
                    child: Column(
                      children: [
                        personalDetailsTextField(),
                        map(context),
                        addressDetailsTextField(),
                        submitProcessButton(),
                      ],
                    ),
                  ),
                )
              ],
            )
          ],
        );
      }),
    );
  }

  ////////////TextField Details////////////
  Widget personalDetailsTextField() {
    return Padding(
      padding: const EdgeInsets.fromLTRB(24, 20, 24, 0),
      child: Column(
        children: [
          CustomTextField(
              hint: 'Enter your name',
              controller: nameController,
              radius: 12,
              borderColor: 0xff999999,
              decoration: const InputDecoration()),
          10.verticalSpace(),
          CustomTextField(
            hint: 'Enter your mobile',
            controller: mobileController,
            borderColor: 0xff999999,
            radius: 12,
          ),
          20.verticalSpace(),
        ],
      ),
    );
  }

  //////////Map/////////
  Widget map(context) {
    return Column(
      children: [
        Stack(
          children: [
            GMap(
              lat: lat ?? 28.4986,
              lng: long ?? 77.3999,
              height: 350,
              onMapCreated: (controller) async{
                // controller.animateCamera(CameraUpdate.newCameraPosition(
                //     CameraPosition(target: LatLng(lat!, long!), zoom: 11)));
              },
              onCameraIdle: () {},
            ),
            Positioned(
                child: Padding(
              padding: const EdgeInsets.fromLTRB(19, 20, 19, 0),
              child: Stack(
                children: [
                  ContainerBorder(
                    margin: 0.marginVertical(),
                    padding: 10.paddingOnly(top: 15, bottom: 15),
                    borderColor: 0xffD9D9D9,
                    backColor: 0xffFFFFFF,
                    radius: 60,
                    widget: Row(
                      children: [
                        5.horizontalSpace(),
                        Expanded(
                          child: Padding(
                            padding: const EdgeInsets.only(left: 10.0, right: 35),
                            child: SearchPlaceAutoCompletedTextField(
                                googleAPIKey: AppConstants.gMapsApiKey,
                                controller: _searchPlaceController,
                                itmOnTap: (Prediction prediction) {
                                  _searchPlaceController.text = prediction.description ?? "";
                                  addressController!.text = prediction.description!;
                                  _searchPlaceController.selection = TextSelection.fromPosition(TextPosition(offset: prediction.description?.length ?? 0));
                                },
                                getPlaceDetailWithLatLng: (Prediction prediction) {
                                  _searchPlaceController.text = prediction.description ?? "";
                                  addressController!.text = prediction.description!;
                                  _searchPlaceController.selection = TextSelection.fromPosition(TextPosition(offset: prediction.description?.length ?? 0));
                                  lat = double.parse(prediction.lat!);
                                  long = double.parse(prediction.lng!);
                                  setState(() {

                                  });
                                  debugPrint("$lat $long");
                                },
                              inputDecoration: InputDecoration(
                                labelText: 'Type your address...',
                                enabledBorder: const UnderlineInputBorder(
                                  borderSide:
                                  BorderSide(color: Colors.transparent),
                                ),
                                focusedBorder: const UnderlineInputBorder(
                                  borderSide:
                                  BorderSide(color: Colors.transparent),
                                ),
                                labelStyle: figtreeRegular.copyWith(
                                    fontSize: 15, color: Colors.grey),
                                hintStyle:
                                    figtreeMedium.copyWith(
                                        fontSize: 16,
                                        color: Colors.grey),
                                contentPadding: const EdgeInsets.all(0.0),
                                isDense: true,
                                border: InputBorder.none,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Positioned(
                    right: 13,
                    top: 0,
                    bottom: 0,
                    child: Row(
                      children: [
                          SvgPicture.asset(
                            Images.search,
                            colorFilter: ColorFilter.mode(ColorResources.maroon, BlendMode.srcIn),
                          ),
                          10.horizontalSpace(),
                      ],
                    ),
                  ),
                ],
              )
            ))
          ],
        )
      ],
    );
  }

////////////Address Details///////////
  Widget addressDetailsTextField() {
    return Padding(
      padding: const EdgeInsets.fromLTRB(24, 20, 24, 0),
      child: Column(
        children: [
          CustomTextField(
              hint: 'Address',
              controller: addressController,
              enabled: false,
              radius: 12,
              minLine: 2,
              borderColor: 0xff999999,
              decoration: const InputDecoration()),
          10.verticalSpace(),
          CustomTextField(
            hint: 'Comments(if any)',
            controller: commentController,
            minLine: 2,
            borderColor: 0xff999999,
            radius: 12,
          ),
          20.verticalSpace(),
        ],
      ),
    );
  }

  /////////////SubmitCancel Button/////////////
  Widget submitProcessButton() {
    return Padding(
      padding: const EdgeInsets.fromLTRB(40, 0, 40, 0),
      child: Column(
        children: [
          customButton('Submit', onTap: () {
            if(nameController!.text.isEmpty) {
              showCustomToast(context, 'Name is required');
            } else if(mobileController!.text.isEmpty) {
              showCustomToast(context, 'Mobile no is required');
            } else if(addressController!.text.isEmpty) {
              showCustomToast(context, 'Address is required');
            }else if(commentController!.text.isEmpty) {
              showCustomToast(context, 'Comment is required');
            } else {
              BlocProvider.of<LandingPageCubit>(context).inviteExpertDetails(
                  context,
                  nameController!.text,
                  mobileController!.text,
                  addressController!.text,
                  commentController!.text,
                  lat!.toString(),
                  long!.toString());
            }

          },
              fontColor: 0xffFFFFFF,
              width: screenWidth(),
              height: 60,
              radius: 88),
          10.verticalSpace(),
          customButton('Cancel',
              onTap: () {},
              color: 0xffDCDCDC,
              width: screenWidth(),
              height: 60,
              radius: 88),
          20.verticalSpace(),
        ],
      ),
    );
  }
}
