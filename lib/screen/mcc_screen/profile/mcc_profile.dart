import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:glad/screen/custom_widget/custom_methods.dart';
import 'package:glad/utils/extension.dart';

import '../../../utils/color_resources.dart';
import '../../../utils/images.dart';
import '../../../utils/styles.dart';
import '../../custom_widget/custom_textfield.dart';
import '../../profile/glad_profile.dart';

class MccProfile extends StatelessWidget {
  const MccProfile({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Stack(
            children: [
          landingBackground(),
          Padding(
            padding: const EdgeInsets.only(top: 40.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets. fromLTRB(10,0,0,0),
                  child: InkWell(
                    onTap: (){
                      Navigator.pop(context);
                      },
                    child: const Icon(
                      Icons.arrow_back,
                      color: Colors.black,
                      size: 32,
                    ),
                  ),
                ),
                profileImage(),
                profileInputField(),
                helpLineItem(),



              ],
            ),
          ),

        ]),
      ),
    );
  }



  ///////ProfileInputField//////////
  Widget profileInputField() {
    return Padding(
      padding: const EdgeInsets.fromLTRB(36, 0, 30, 0),
      child: Column(
        children: [
          30.verticalSpace(),
          CustomTextField(
            style: figtreeMedium.copyWith(fontSize: 14, color: Colors.black),
            hint: 'Phone',
            enabled: false,
            text: '',
            leadingImage: Images.textCall,
            imageColors: ColorResources.fieldGrey,
            withoutBorder: true,
            underLineBorderColor: ColorResources.grey,
          ),
          20.verticalSpace(),
          CustomTextField(
            hint: 'Email',
            leadingImage: Images.emailPhone,
            imageColors: ColorResources.fieldGrey,
            style: figtreeMedium.copyWith(fontSize: 14, color: Colors.black),
            enabled: false,
            text: '',
            withoutBorder: true,
            underLineBorderColor: ColorResources.grey,
          ),
          20.verticalSpace(),
          CustomTextField(
            maxLine: 2,
            hint: 'Address',
            leadingImage: Images.textEdit,
            imageColors: ColorResources.fieldGrey,
            style: figtreeMedium.copyWith(fontSize: 14, color: Colors.black),
            enabled: false,
            text: '',
            withoutBorder: true,
            underLineBorderColor: ColorResources.grey,
          ),
          30.verticalSpace(),
          Row(children: [
            SvgPicture.asset(Images.logout,height: 25,width:25,),
            15.horizontalSpace(),
            Text('Logout',style: figtreeRegular.copyWith(fontSize: 18),)
          ],),
          60.verticalSpace(),

        ],
      ),
    );
  }



  /////////ProfileImage////////
  Widget profileImage(){
    return Column(
      children: [
        Center(
          child: Stack(
            children: [
              ClipOval(
                clipper: MyClip(),
                child: SizedBox(
                  height: 180,
                  width: 190,
                  child: Image.asset(
                    Images.sampleUser,
                    fit: BoxFit.fill,
                  ),
                ),
              ),
              const Positioned(
                  right: 0,
                  bottom: 24,
                  child: CircleAvatar(
                    radius: 20,
                    backgroundColor: Colors.white,
                    child: CircleAvatar(
                      radius: 18,
                      backgroundColor: ColorResources.primary,
                      child: Icon(Icons.camera_alt,
                          color: Colors.white, size: 20),
                    ),
                  )),
            ],
          ),
        ),
        30.verticalSpace(),
        Text(
          'Begumanya Charles',
          style: figtreeSemiBold.copyWith(fontSize: 22),
        ),
      ],
    );
  }


///////////HelpLine/////////
  Widget helpLineItem() {
    return Column(
      children: [
        Container(
          height: 110,
          decoration: const BoxDecoration(color: ColorResources.maroon1),
          child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                SvgPicture.asset(
                  Images.call,
                  width: 45,
                  height: 45,
                ),
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
                SvgPicture.asset(
                  Images.whatsapp,
                  width: 40,
                  height: 40,
                ),
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
