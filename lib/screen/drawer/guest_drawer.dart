import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:glad/screen/custom_widget/custom_methods.dart';
import 'package:glad/utils/color_resources.dart';
import 'package:glad/utils/extension.dart';
import 'package:glad/utils/images.dart';
import 'package:glad/utils/styles.dart';

class GuestSideDrawer extends StatelessWidget {
  const GuestSideDrawer({super.key});

  @override
  Widget build(BuildContext context) {

    return Container(
      color: const Color(0xFF6A0030),
      child: Stack(
        children: [

          Padding(
            padding: EdgeInsets.fromLTRB(0,screenHeight()*0.085,0,0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                menuItem(),
                const SizedBox(
                  height: 25,
                ),
                navigationItem(),
              ],
            ),
          ),

          sideBackground(),

          helpLineItem(),

        ],
      ),
    );
  }


  Widget navigationItem(){
    return Padding(
      padding: const EdgeInsets.fromLTRB(30, 0, 0, 0),
      child: Column(
        children: [
          navigationBarItem(
            image: Images.news,
            onTap: () {},
            text: 'News & Events',
          ),
          const SizedBox(
            height: 30,
          ),
          navigationBarItem(
              image: Images.training,
              onTap: () {},
              text: 'Training'),
          const SizedBox(
            height: 30,
          ),
          navigationBarItem(
              image: Images.faq, onTap: () {}, text: "Faq's"),
          const SizedBox(
            height:30,
          ),
          navigationBarItem(
            image: Images.aboutus,
            onTap: () {},
            text: 'About us',
          ),
          const SizedBox(
            height: 30,
          ),
          navigationBarItem(
              image: Images.privacy,
              onTap: () {},
              text: 'Privacy policy'),
        ],
      ),
    );
  }

  Widget helpLineItem(){
    return Positioned(
      bottom: 0,
      left: 0,
      right: 0,
      child: Column(
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
          const SizedBox(height: 30,),
          socialMediaItem(),
          const SizedBox(height: 30,)
        ],
      ),
    );
  }

  Widget socialMediaItem(){
    return  Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        SvgPicture.asset(Images.facebook),
        const SizedBox(
          width: 20,
        ),
        SvgPicture.asset(Images.twitter),
        const SizedBox(
          width: 20,
        ),
        SvgPicture.asset(Images.linkedin),
        const SizedBox(
          width: 20,
        ),
        SvgPicture.asset(Images.youtube),
      ],
    );
  }

  Widget menuItem(){
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.fromLTRB(20, 0, 10, 0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              InkWell(
                onTap: (){},
                child: SvgPicture.asset(
                  Images.close,
                  width: 30,
                  height: 30,
                ),
              ),
              SvgPicture.asset(
                Images.onboardingnew,
                width: 30,
                height: 30,
              )
            ],
          ),
        ),
        const SizedBox(
          height: 50,
        ),
        Padding(
          padding: const EdgeInsets.fromLTRB(20, 0, 0, 0),
          child: Text(
            'Menu',
            style: figtreeMedium.copyWith(
                fontSize: 28, color: Colors.white),
          ),
        ),
        const SizedBox(
          height: 40,
        ),
        Container(
          margin: const EdgeInsets.fromLTRB(20, 0,40, 0),
          height: 45,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(30),
              border: Border.all(
                  width: 1, color: const Color(0xffC788A5))),
          child: Padding(
            padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    SvgPicture.asset(Images.profile),
                    const SizedBox(
                      width: 20,
                    ),
                    Text(
                      'Login',
                      style: figtreeRegular.copyWith(
                          fontSize: 18, color: Colors.white),
                    )
                  ],
                ),
                const CircleAvatar(
                  radius: 15,
                  backgroundColor: ColorResources.maroon1,
                  child: Icon(Icons.arrow_forward, size: 15),
                )
              ],
            ),
          ),
        ),
      ],);
  }


  Widget sideBackground(){
    return  Positioned(
        right: 0,
        top: 135,
        // bottom:0,
        // left: 0,
        child: SvgPicture.asset(Images.drawerInside));
  }

}
