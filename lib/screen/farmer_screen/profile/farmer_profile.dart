import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:glad/screen/custom_widget/custom_methods.dart';
import 'package:glad/utils/images.dart';
import 'package:glad/utils/styles.dart';

class FarmerProfile extends StatelessWidget {
  const FarmerProfile({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Stack(
          children: [
            farmerBackground(),
            Padding(
              padding: const EdgeInsets.only(top: 60.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                   mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                    InkWell(
                      onTap: (){
                        Navigator.pop(context);
                      },
                      child: const Icon(
                        Icons.arrow_back,
                        color: Colors.black,
                        size: 32,
                      ),
                    ),
                    Text('My Profile',style: figtreeMedium.copyWith(fontSize: 22),),
                    SvgPicture.asset(Images.profileEdit)
                  ],)


                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
