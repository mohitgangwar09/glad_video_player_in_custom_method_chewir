import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:glad/screen/auth_screen/forgot_password.dart';
import 'package:glad/screen/auth_screen/otp.dart';
import 'package:glad/screen/custom_widget/custom_methods.dart';
import 'package:glad/screen/custom_widget/custom_textfield.dart';
import 'package:glad/utils/extension.dart';
import 'package:glad/utils/images.dart';
import 'package:glad/utils/styles.dart';

class LoginWithPassword extends StatelessWidget {
  const LoginWithPassword({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      bottom: true,
      top: false,
      child: Scaffold(
        body: hideKeyboard(
          context,
          child: SingleChildScrollView(
            child: SizedBox(
              height: screenHeight(),
              child: LayoutBuilder(
                builder: (BuildContext context, BoxConstraints constraints) {
                  if(constraints.maxHeight<750){
                    return smallDevice(context);
                  }
                  return largeDevice(context);
                },
              ),
            ),
          ),
        ),
      ),
    );
  }
}

Widget smallDevice(BuildContext context){
  return Stack(
    children: [

      Positioned(
          top: screenHeight()*0.092,
          left: 0,
          right: 0,
          child: SvgPicture.asset(Images.loginLogo,width: 162,height: 46,)),

      Positioned(
        bottom: screenHeight()*0.04,
        left: 0,
        right: 0,
        child: loginWithOtp(),
      ),

      Align(
          alignment: Alignment.topRight,child: SvgPicture.asset(Images.loginBack_1,width: screenWidth()*0.5,height: screenHeight()*0.35,)),

      Center(child: Padding(
        padding: const EdgeInsets.only(top: 50.0,bottom: 0),
        child: card(context),
      )),

      Positioned(bottom: 0,
          child:SvgPicture.asset(Images.loginBack_2,width: screenWidth()*0,height: screenHeight()*0.132,)),

      Positioned(
          bottom: screenWidth()*0.17,
          right: screenWidth()*0.09,
          child: SvgPicture.asset(Images.loginBelowBack,width: 35,height: 35,))

    ],
  );
}

Widget largeDevice(BuildContext context){
  return Stack(
    children: [

      Positioned(
          top: screenHeight()*0.12,
          left: 0,
          right: 0,
          child: SvgPicture.asset(Images.loginLogo,width: 162,height: 46,)),

      Positioned(
        bottom: screenHeight()*0.068,
        left: 0,
        right: 0,
        child: loginWithOtp(),
      ),

      Align(
          alignment: Alignment.topRight,child: SvgPicture.asset(Images.loginBack_1,width: screenWidth()*0.35,height: screenHeight()*0.35,)),

      Center(child: Padding(
        padding: const EdgeInsets.only(top: 40.0,bottom: 10),
        child: card(context),
      )),

      Positioned(bottom: 0,
          child:SvgPicture.asset(Images.loginBack_2,width: screenWidth()*0,height: screenHeight()*0.15,)),

      Positioned(
          bottom: screenWidth()*0.3,
          right: screenHeight()*0.055,
          child: SvgPicture.asset(Images.loginBelowBack,width: 35,height: 35,))

    ],
  );
}

Widget card(BuildContext context){
  return Stack(
    children: [

      SizedBox(
          height: screenWidth()*1.15,
          child: loginButton()),

      Positioned(
        top: 0,
        child: SizedBox(
          width: screenWidth(),
          child: Column(
            // mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [

              Padding(
                padding: const EdgeInsets.only(top: 60.0),
                child: Text("Welcome Back",
                  style: figtreeMedium.copyWith(
                      color: Colors.white,
                      fontSize: 24
                  ),),
              ),

              Padding(
                padding: const EdgeInsets.fromLTRB(40,21,40,0),
                child: CustomTextField(hint: 'Email/Phone',text: '',
                  style: figtreeRegular.copyWith(
                      color: Colors.white,
                      fontSize: 14
                  ),
                image: Images.emailPhone,withoutBorder: true,),
              ),


              Padding(
                padding: const EdgeInsets.fromLTRB(40,21,40,0),
                child: CustomTextField(hint: 'Password',text: '',
                  image: Images.password,withoutBorder: true,
                style: figtreeRegular.copyWith(
                    color: Colors.white,
                    fontSize: 14
                ),)
              ),


              Padding(
               padding: const EdgeInsets.only(top: 45.0),
               child: TextButton(onPressed: (){
                 const ForgotPassword().navigate();
               }, child: Text("Forgot password?",
                 style: figtreeMedium.copyWith(
                     color: const Color(0xffFC5E60),
                   decoration: TextDecoration.underline,
                   fontSize: 16
               ),)),
             )

            ],
          ),
        ),
      )

    ],
  );
}

Widget loginButton(){
  return Center(
    child: Stack(
      children: [

        SizedBox(
            height: screenHeight() * 0.65,
            width: screenWidth(),
            child: SvgPicture.asset(Images.cardLogin)),

        Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                InkWell(
                  onTap: (){

                    const OtpScreen().navigate();

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

Widget loginWithOtp(){
  return TextButton(onPressed: (){}, child: Text("Login with OTP",
    style: figtreeMedium.copyWith(
      color: Colors.black,
      decoration: TextDecoration.underline,
      fontSize: 16,
    ),));
}