import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:glad/cubit/auth_cubit/auth_cubit.dart';
import 'package:glad/cubit/profile_cubit/profile_cubit.dart';
import 'package:glad/screen/custom_widget/custom_appbar.dart';
import 'package:glad/screen/custom_widget/custom_methods.dart';
import 'package:glad/screen/dde_screen/dashboard/dashboard_dde.dart';
import 'package:glad/screen/dde_screen/dde_profile.dart';
import 'package:glad/screen/extra_screen/navigation.dart';
import 'package:glad/screen/farmer_screen/dashboard/dashboard_farmer.dart';
import 'package:glad/screen/guest_user/dashboard_tab_screen/landing_page.dart';
import 'package:glad/screen/mcc_screen/dashboard/dashboard_mcc.dart';
import 'package:glad/screen/supplier_screen/dashboard/dashboard_supplier.dart';
import 'package:glad/utils/color_resources.dart';
import 'package:glad/utils/extension.dart';
import 'package:glad/utils/helper.dart';
import 'package:glad/utils/images.dart';
import 'package:glad/utils/styles.dart';

class UploadProfilePicture extends StatelessWidget {
  const UploadProfilePicture({super.key});

  @override
  Widget build(BuildContext context) {

    BlocProvider.of<ProfileCubit>(context).profileApi(context);

    return Scaffold(
      body: Stack(
        children: [
          landingBackground(),
          BlocBuilder<ProfileCubit,ProfileCubitState>(
              builder: (BuildContext context, state) {
              return Column(
                children: [
                  CustomAppBar(
                    context: context,
                    titleText1: state.responseProfile!= null ? state.responseProfile!.data!.user!.name.toString():'',
                    titleText1Style: figtreeMedium.copyWith(
                        fontSize: 20, color: Colors.black),
                    description: 'Complete your profile',
                    centerTitle: true,
                    leading: arrowBackButton(),
                  ),
                  uploadProfilePhoto(context,state),
                  actionButton(state,context)
                ],
              );
            }
          ),
        ],
      ),
    );
  }

  ///////// profile Photo /////////
  Widget uploadProfilePhoto(BuildContext context,ProfileCubitState state) {
    return Padding(
      padding: const EdgeInsets.only(top: 20.0),
      child: Column(
        children: [
          InkWell(
              splashColor: Colors.transparent,
              onTap: () {
                showPicker(context, cameraFunction: () {
                  var image = imgFromCamera();
                  image.then((value) async{
                    context.read<ProfileCubit>().updateProfilePicImage(context,value);
                  });
                }, galleryFunction: () {
                  var image =  imgFromGallery();
                  image.then((value) async{
                    context.read<ProfileCubit>().updateProfilePicImage(context,value);
                  });
                });
              },
              child: SizedBox(
                height: 124,
                width: 124,
                child: customShadowContainer(
                    radius: 30,
                    margin: 0,
                    backColor: Colors.grey,
                    elevation: 0,
                    child: state.responseProfile!=null ?
                    state.responseProfile!.data!.user!.profilePic.toString() == "false"?
                    Padding(
                      padding: const EdgeInsets.all(45.0),
                      child: SvgPicture.asset(Images.camera,width: 22,height: 22,),
                    ): ClipRRect(
                        borderRadius: BorderRadius.circular(30),child: networkImage(text: state.responseProfile!.data!.user!.profilePic.toString())):Image.asset(Images.camera)),
              )),
          10.verticalSpace(),
          RichText(
              text: TextSpan(children: [
            TextSpan(
                text: 'Tap to upload ',
                style: figtreeMedium.copyWith(
                    color: ColorResources.redText, fontSize: 14)),
            TextSpan(
                text: 'your profile picture',
                style: figtreeMedium.copyWith(color: Colors.black, fontSize: 14))
          ])),
          Text(
            'Max size 20 MB',
            style: figtreeMedium.copyWith(fontSize: 12, color: Colors.grey),
          ),
          // 80.verticalSpace(),
          screenHeight() < 750 ? 50.verticalSpace() : 80.verticalSpace(),
          Text(
            'Benefits of adding\nprofile photo',
            style: figtreeMedium.copyWith(
              fontSize: 20,
            ),
            textAlign: TextAlign.center,
          ),
          20.verticalSpace(),
          Text(
            'It makes your profile to look authentic.\nOthers can identify you easily.',
            style: figtreeMedium.copyWith(
              fontSize: 12,
            ),
            textAlign: TextAlign.center,
          ),
          screenHeight() < 750 ? 40.verticalSpace() : 100.verticalSpace(),
        ],
      ),
    );
  }

  ///// Submit & Skip Button //////
  Widget actionButton(ProfileCubitState state,context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0),
          child: customButton('Submit', onTap: () {
            if(state.responseProfile!.data!.user!.userType == "mcc"){
              const DashboardMCC().navigate(isInfinity: true);
            }else if(BlocProvider.of<ProfileCubit>(context).state.responseProfile!.data!.user!.userType == "dde"){
              const DashboardDDE().navigate(isInfinity: true);
            }else if(state.responseProfile!.data!.user!.userType == "supplier"){
              const DashboardSupplier().navigate(isInfinity: true);
            }else if(state.responseProfile!.data!.user!.userType == "farmer"){
              const DashboardFarmer().navigate(isInfinity: true);
            }else{

            }
            // const Navigation().navigate();
          },
              width: double.infinity,
              style: figtreeMedium.copyWith(color: Colors.white, fontSize: 16)),
        ),
        Padding(
          padding: const EdgeInsets.only(top: 20),
          child: InkWell(
            onTap: () {
              if(state.responseProfile!.data!.user!.userType == "mcc"){
                const DashboardMCC().navigate(isInfinity: true);
              }else if(BlocProvider.of<ProfileCubit>(context).state.responseProfile!.data!.user!.userType == "dde"){
                const DashboardDDE().navigate(isInfinity: true);
              }else if(state.responseProfile!.data!.user!.userType == "supplier"){
                const DashboardSupplier().navigate(isInfinity: true);
              }else if(state.responseProfile!.data!.user!.userType == "farmer"){
                const DashboardFarmer().navigate(isInfinity: true);
              }else{

              }
            },
            child: Text(
              'Skip',
              style: figtreeMedium.copyWith(
                  fontSize: 16, decoration: TextDecoration.underline),
            ),
          ),
        )
      ],
    );
  }
}
