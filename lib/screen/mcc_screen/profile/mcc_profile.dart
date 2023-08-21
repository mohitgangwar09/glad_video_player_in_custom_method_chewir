import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:glad/cubit/profile_cubit/profile_cubit.dart';
import 'package:glad/screen/custom_widget/custom_appbar.dart';
import 'package:glad/screen/custom_widget/custom_methods.dart';
import 'package:glad/utils/extension.dart';
import 'package:glad/utils/helper.dart';

import '../../../utils/color_resources.dart';
import '../../../utils/images.dart';
import '../../../utils/styles.dart';
import '../../custom_widget/custom_textfield.dart';
import '../../dde_screen/dde_profile.dart';

class MccProfile extends StatefulWidget {
  const MccProfile({super.key});

  @override
  State<MccProfile> createState() => _MccProfileState();
}

class _MccProfileState extends State<MccProfile> {

  @override
  void initState() {
    super.initState();

    SchedulerBinding.instance.addPostFrameCallback((_) {
      BlocProvider.of<ProfileCubit>(context).profileApi(context);
    });
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      body: Stack(
          children: [
        landingBackground(),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CustomAppBar(
              context: context,
              titleText1: '',
              leading: arrowBackButton(),
            ),
            Expanded(
              child :SingleChildScrollView(
                child: BlocBuilder<ProfileCubit,ProfileCubitState>(
                  builder: (BuildContext contexts, state) {
                    return Column(children: [
                      profileImage(context,state),
                      profileInputField(context,state),
                      helpLineItem(context,state),
                    ],);
                  }
                ),
              ),
            ),
          ],
        ),
      ]),
    );
  }

  ///////ProfileInputField//////////
  Widget profileInputField(BuildContext context,ProfileCubitState state) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(36, 0, 30, 0),
      child: Column(
        children: [
          30.verticalSpace(),
          CustomTextField(
            style: figtreeMedium.copyWith(fontSize: 14, color: Colors.black),
            hint: 'Phone',
            enabled: false,
            controller: state.phoneController,
            leadingImage: Images.textCall,
            imageColors: ColorResources.fieldGrey,
            withoutBorder: true,
            underLineBorderColor: ColorResources.grey,
          ),
          20.verticalSpace(),
          CustomTextField(
            hint: 'Email',
            controller: state.emailController,
            leadingImage: Images.emailPhone,
            imageColors: ColorResources.fieldGrey,
            style: figtreeMedium.copyWith(fontSize: 14, color: Colors.black),
            enabled: false,

            withoutBorder: true,
            underLineBorderColor: ColorResources.grey,
          ),
          20.verticalSpace(),
          CustomTextField(
            maxLine: 2,
            controller: state.addressController,
            hint: 'Address',
            leadingImage: Images.textEdit,
            imageColors: ColorResources.fieldGrey,
            style: figtreeMedium.copyWith(fontSize: 14, color: Colors.black),
            enabled: false,
            withoutBorder: true,
            underLineBorderColor: ColorResources.grey,
          ),
          30.verticalSpace(),
          logOut(context),
          60.verticalSpace(),

        ],
      ),
    );
  }

  /////////ProfileImage////////
  Widget profileImage(BuildContext context,ProfileCubitState state){
    return state.responseProfile!=null ?
    Column(
      children: [
        Center(
          child: Stack(
            children: [
              ClipOval(
                clipper: MyClip(),
                child: SizedBox(
                  height: 180,
                  width: 190,
                  child: networkImage(text: state.responseProfile!.data!.user!.profilePic.toString()),
                ),
              ),
              Positioned(
                  right: 0,
                  bottom: 24,
                  child: InkWell(
                    onTap: (){
                      showPicker(context, cameraFunction: () async{
                        var image = await imgFromCamera();
                        await context.read<ProfileCubit>().updateProfilePicImage(context,image);
                      }, galleryFunction: () async{
                        var image = await imgFromGallery();
                        await context.read<ProfileCubit>().updateProfilePicImage(context,image);
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
        ),
        30.verticalSpace(),
        Text(state.responseProfile!.data!.user!.name.toString(),
          style: figtreeSemiBold.copyWith(fontSize: 22),
        ),
      ],
    ):const SizedBox();
  }

///////////HelpLine/////////
  Widget helpLineItem(BuildContext context,ProfileCubitState state) {
    return Column(
      children: [
        Container(
          height: 110,
          decoration: const BoxDecoration(color: ColorResources.maroon1),
          child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                phoneCall(234567890),
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'GLAD Helpline Number',
                      style: figtreeMedium.copyWith(
                          fontSize: 14, color: Colors.white),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Text(
                      '+234567890',
                      style: figtreeMedium.copyWith(
                          fontSize: 14, color: Colors.white),
                    )
                  ],
                ),
                whatsapp(234567890),
              ]),
        ),
        const SizedBox(
          height: 30,
        ),
        socialMediaItem(),
        const SizedBox(
          height: 30,
        )
      ],
    );
  }

  //////////////SocialMedia///////////
  Widget socialMediaItem() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        SvgPicture.asset(Images.facebook,colorFilter: const ColorFilter.mode(Colors.black, BlendMode.modulate),),
        const SizedBox(
          width: 20,
        ),
        SvgPicture.asset(Images.twitter,colorFilter: const ColorFilter.mode(Colors.black, BlendMode.modulate)),
        const SizedBox(
          width: 20,
        ),
        SvgPicture.asset(Images.linkedin,colorFilter: const ColorFilter.mode(Colors.black, BlendMode.modulate)),
        const SizedBox(
          width: 20,
        ),
        SvgPicture.asset(Images.youtube,colorFilter: const ColorFilter.mode(Colors.black, BlendMode.modulate)),
      ],
    );
  }
}