import 'package:flutter/material.dart';
import 'package:glad/screen/custom_widget/custom_appbar.dart';
import 'package:glad/screen/custom_widget/custom_methods.dart';
import 'package:glad/screen/custom_widget/custom_textfield.dart';
import 'package:glad/screen/custom_widget/g_map.dart';
import 'package:glad/utils/color_resources.dart';
import 'package:glad/utils/extension.dart';
import 'package:glad/utils/images.dart';
import 'package:glad/utils/styles.dart';

class InviteAnExpert extends StatelessWidget {
  const InviteAnExpert({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          landingBackground(),
          Column(
            children: [
              CustomAppBar(context: context, titleText1: 'Invite an expert', description: 'Provide the following details', leading: arrowBackButton(), centerTitle: true,),
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
      ),
    );
  }

  ////////////TextField Details////////////
  Widget personalDetailsTextField() {
    return Padding(
      padding: const EdgeInsets.fromLTRB(24, 20, 24, 0),
      child: Column(
        children: [
          const CustomTextField(
              hint: 'Enter your name',
              radius: 12,
              borderColor: 0xff999999,
              decoration: InputDecoration()),
          10.verticalSpace(),
          const CustomTextField(
            hint: 'Enter your mobile',
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
    return const Column(
      children: [
        Stack(
          children: [
            GMap(
              myLocationButtonEnabled: true,
              myLocationEnabled: true,
              lat: 28.4986,
              lng: 77.3999,
              height: 350,
              zoomGesturesEnabled: true,
            ),
            // Positioned(
            //     child: Padding(
            //       padding: EdgeInsets.fromLTRB(19, 20, 59, 0),
            //       child: CustomTextField(
            //         hint: 'Type your address...',
            //         radius: 60,
            //         image: Images.search,
            //         imageColors: ColorResources.maroon,
            //       ),
            //     ))
            Positioned(
                child: Padding(
                  padding: EdgeInsets.fromLTRB(19, 20, 59, 0),
                  child: CustomTextField(
                    hint: 'Type your address...',
                    radius: 60,
                    image: Images.search,
                    imageColors: ColorResources.maroon,
                  ),
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
          const CustomTextField(
              hint: 'Plot 11,Luwum St. Rwoozi, Kampala, Uganda 23489..',
              radius: 12,
              minLine:2,
              borderColor: 0xff999999,
              decoration: InputDecoration()),
          10.verticalSpace(),
          const CustomTextField(
            hint: 'Comments(if any)',
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
      padding: const EdgeInsets.fromLTRB(40,0,40,0),
      child: Column(
        children: [
          customButton('Submit', onTap: (){},fontColor: 0xffFFFFFF,width: screenWidth(),height: 60,radius: 88),
          10.verticalSpace(),
          customButton('Cancel', onTap: (){},color:0xffDCDCDC,width: screenWidth(),height: 60,radius: 88),
          20.verticalSpace(),
        ],
      ),
    );
  }

}
