import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:glad/screen/custom_widget/custom_textfield.dart';
import 'package:glad/utils/extension.dart';
import 'package:glad/utils/images.dart';
import 'package:glad/utils/styles.dart';

class LoginWithPassword extends StatelessWidget {
  const LoginWithPassword({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [

          Align(
          alignment: Alignment.topRight,child: SvgPicture.asset(Images.loginBack_1)),

          Center(child: card()),

          Positioned(bottom: 0,
              child:SvgPicture.asset(Images.loginBack_2))

        ],
      ),
    );
  }
}


Widget card(){
  return Stack(
    children: [

      SizedBox(
          height: 512,
          child: background()),

      Positioned(
        top: 0,
        child: SizedBox(
          width: screenWidth(),
          child: Column(
            // mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              // Padding(
              //   padding: const EdgeInsets.only(bottom: .0),
              //   child: Text("Welcome Back",
              //   style: figtreeMedium.copyWith(
              //     color: Colors.white,
              //     fontSize: 24
              //   ),),
              // ),

              // const CustomTextField(hint: "hint", text: "text",withoutBorder: true,),
              // const SizedBox(height: 28,),
              // const CustomTextField(hint: "hint", text: "text"),

              Padding(
                padding: const EdgeInsets.only(top: 25.0),
                child: Text("Welcome Back",
                  style: figtreeMedium.copyWith(
                      color: Colors.white,
                      fontSize: 24
                  ),),
              ),
            ],
          ),
        ),
      )

    ],
  );
}


Widget background(){
  return Center(
    child: Stack(
      children: [
        Padding(
            padding: const EdgeInsets.only(left: 14.0,right: 14),
            child: SvgPicture.asset(Images.cardLogin)),

        Positioned(
            bottom: 30,
            left: 0,
            right: 0,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                InkWell(
                  onTap: (){

                  }, child: Image.asset(Images.loginButton,
                  width: 80,height: 80,),
                ),
              ],
            )
        )
      ],
    ),
  );
}