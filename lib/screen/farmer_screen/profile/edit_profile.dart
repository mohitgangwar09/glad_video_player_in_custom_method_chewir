import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:glad/cubit/landing_page_cubit/landing_page_cubit.dart';
import 'package:glad/cubit/profile_cubit/profile_cubit.dart';
import 'package:glad/screen/custom_widget/custom_appbar.dart';
import 'package:glad/screen/custom_widget/custom_methods.dart';
import 'package:glad/screen/dde_screen/dde_profile.dart';
import 'package:glad/screen/farmer_screen/profile/farm_details.dart';
import 'package:glad/screen/farmer_screen/profile/personal_details.dart';
import 'package:glad/utils/color_resources.dart';
import 'package:glad/utils/extension.dart';
import 'package:glad/utils/helper.dart';
import 'package:glad/utils/styles.dart';

class EditProfile extends StatefulWidget {
  const EditProfile({super.key, required this.section});
  final String section;

  @override
  State<EditProfile> createState() => _EditProfileState();
}

class _EditProfileState extends State<EditProfile> {
  String? section;

  @override
  void initState() {
    section = widget.section;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: hideKeyboard(
        context,
        child: Stack(
          children: [
            landingBackground(),
            Column(
              children: [
                CustomAppBar(
                  context: context,
                  titleText1: 'Edit Profile',
                  titleText1Style: figtreeMedium.copyWith(
                      fontSize: 20, color: Colors.black),

                  centerTitle: true,
                  leading: arrowBackButton(),
                  /*action: TextButton(
                      onPressed: () {},
                      child: Text(
                        'Save',
                        style: figtreeMedium.copyWith(
                            color: ColorResources.maroon, fontSize: 14),
                      )),*/
                ),
                Expanded(
                  child: SingleChildScrollView(
                    child: Column(
                      children: [

                        BlocBuilder<ProfileCubit,ProfileCubitState>(
                          builder: (context,state) {
                            return Center(
                              child: Stack(
                                children: [
                                  ClipOval(
                                    clipper: MyClip(),
                                    child: SizedBox(
                                      height: 180,
                                      width: 190,
                                      child: networkImage(text: state.responseFarmerProfile!.farmer!.photo.toString()),
                                    ),
                                  ),
                                  Positioned(
                                      right: 0,
                                      bottom: 24,
                                      child: InkWell(
                                        onTap: (){
                                          showPicker(context, cameraFunction: () async{
                                            var image = imgFromCamera();
                                            image.then((value) async{
                                              await context.read<ProfileCubit>().updateProfilePicImageRam(context,value);
                                              context.read<LandingPageCubit>().getFarmerDashboard(context);
                                              // context.read<ProfileCubit>().updateProfilePicImage(context,value);
                                            });
                                          }, galleryFunction: () async{
                                            var image =  imgFromGallery();
                                            image.then((value) async{
                                              await context.read<ProfileCubit>().updateProfilePicImageRam(context,value);
                                              context.read<LandingPageCubit>().getFarmerDashboard(context);
                                              // context.read<ProfileCubit>().updateProfilePicImage(context,value);
                                            });
                                          });
                                        },
                                        child: const CircleAvatar(
                                          radius: 20,
                                          backgroundColor: Colors.white,
                                          child: CircleAvatar(
                                            radius: 18,
                                            backgroundColor: ColorResources.primary,
                                            child: Icon(Icons.camera_alt,
                                                color: Colors.white, size: 20),
                                          ),
                                        ),
                                      )),
                                ],
                              ),
                            );
                          }
                        ),

                        /*InkWell(
                            splashColor: Colors.transparent,
                            onTap: () {
                              showPicker(context, cameraFunction: () {
                                var image = imgFromCamera();
                                image.then((value) async{
                                  context.read<ProfileCubit>().profilePicture(value);
                                });
                              }, galleryFunction: () {
                                var image =  imgFromGallery();
                                image.then((value) async{
                                  context.read<ProfileCubit>().profilePicture(value);
                                });
                              });
                            },
                            child: Padding(
                              padding:
                                  const EdgeInsets.fromLTRB(18.0, 0, 18, 0),
                              child: SvgPicture.asset(Images.uploadPP),
                            )),*/
                        15.verticalSpace(),

                        RichText(
                            text: TextSpan(children: [
                          TextSpan(
                              text: 'Tap to change ',
                              style: figtreeMedium.copyWith(
                                  color: ColorResources.redText, fontSize: 14)),
                          TextSpan(
                              text: 'your photo',
                              style: figtreeMedium.copyWith(
                                  color: Colors.black, fontSize: 14))
                        ])),
                        Text(
                          'Max size 5 MB',
                          style: figtreeMedium.copyWith(
                              fontSize: 12, color: Colors.grey),
                        ),
                        40.verticalSpace(),
                        Container(
                          height: 50,
                          margin: 20.marginHorizontal(),
                          width: screenWidth(),
                          decoration: boxDecoration(
                              borderRadius: 62,
                              borderColor: const Color(0xffDCDCDC),
                              backgroundColor: Colors.white),
                          child: Row(
                            children: [
                              Expanded(
                                child: InkWell(
                                  onTap: () {
                                    section = 'personal';
                                    setState(() {});
                                  },
                                  child: Container(
                                    height: screenHeight(),
                                    margin: const EdgeInsets.all(6),
                                    decoration: boxDecoration(
                                        backgroundColor: section == 'personal'
                                            ? const Color(0xff6A0030)
                                            : Colors.white,
                                        borderRadius: 62),
                                    alignment: Alignment.center,
                                    child: "Personal information".textMedium(
                                        color: section == 'personal'
                                            ? Colors.white
                                            : Colors.black,
                                        fontSize: 13),
                                  ),
                                ),
                              ),
                              Expanded(
                                child: InkWell(
                                  onTap: () {
                                    section = 'farm';
                                    setState(() {});
                                  },
                                  child: Container(
                                    height: screenHeight(),
                                    margin: const EdgeInsets.all(6),
                                    decoration: boxDecoration(
                                        backgroundColor: section == 'farm'
                                            ? const Color(0xff6A0030)
                                            : Colors.white,
                                        borderRadius: 62),
                                    alignment: Alignment.center,
                                    child: "Farm details".textMedium(
                                        color: section == 'farm'
                                            ? Colors.white
                                            : Colors.black,
                                        fontSize: 13),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        20.verticalSpace(),
                        if (section == 'personal') const PersonalDetails(),
                        if (section == 'farm') const FarmDetails()
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
