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
    return Scaffold(
      body: hideKeyboard(
        context,
        child: Stack(
          children: [

            Container(
              margin: const EdgeInsets.only(bottom: 85,top: 100),
              width: screenWidth(),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [

                  SvgPicture.asset(Images.loginLogo,width: 162,height: 46,),

                  TextButton(onPressed: (){}, child: Text("Login with OTP",
                    style: figtreeMedium.copyWith(
                        color: Colors.black,
                        decoration: TextDecoration.underline,
                        fontSize: 16,
                    ),)),

                ],
              ),
            ),

            Align(
                alignment: Alignment.topRight,child: SvgPicture.asset(Images.loginBack_1)),

            Center(child: Padding(
              padding: const EdgeInsets.only(top: 40.0,bottom: 10,left: 2.5,right: 2.5),
              child: card(context),
            )),

            Positioned(bottom: 0,
                child:SvgPicture.asset(Images.loginBack_2)),

            Positioned(
                bottom: 135,
                right: 50,
                child: SvgPicture.asset(Images.loginBelowBack,width: 35,height: 35,))

          ],
        ),
      ),
    );
  }
}

Widget card(BuildContext context){
  return Stack(
    children: [

      SizedBox(
          height: 512,
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