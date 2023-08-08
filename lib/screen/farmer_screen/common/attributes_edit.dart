import 'package:flutter/material.dart';
import 'package:glad/screen/custom_widget/custom_appbar.dart';
import 'package:glad/screen/custom_widget/custom_methods.dart';
import 'package:glad/utils/color_resources.dart';
import 'package:glad/utils/styles.dart';

class AttributesEdit extends StatelessWidget {
  const AttributesEdit({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          landingBackground(),
          Column(
            children: [
              CustomAppBar(
                context: context,
                titleText1: 'Attributes',
                titleText1Style: figtreeMedium.copyWith(
                    fontSize: 20, color: Colors.black),

                centerTitle: true,
                leading: arrowBackButton(),
                action: TextButton(
                    onPressed: () {},
                    child: Text(
                      'Save',
                      style: figtreeMedium.copyWith(
                          color: ColorResources.maroon, fontSize: 14),
                    )),
              ),

            ],
          )
          // Padding(
          //   padding: const EdgeInsets.only(top: 40.0),
          //   child: Row(
          //     mainAxisAlignment: MainAxisAlignment.spaceBetween,
          //     children: [
          //       Icon(Icons.arrow_back),
          //       Text('Attributes',style: figtreeMedium.copyWith(fontSize: 22),),
          //       Text('Save',style: figtreeMedium.copyWith(fontSize: 14,color: ColorResources.maroon),)
          //     ],
          //   ),
          // )
        ],
      ),
    );
  }
}
