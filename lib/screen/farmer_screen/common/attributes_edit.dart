import 'package:flutter/material.dart';
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
          Padding(
            padding: const EdgeInsets.only(top: 40.0),
            child: Column(
              children: [
                Stack(
                  alignment: Alignment.centerLeft,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(right: 17),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          IconButton(
                              onPressed: () {
                                Navigator.pop(context);
                              },
                              icon: const Icon(Icons.arrow_back)),
                          Text(
                            'Attributes',
                            style: figtreeMedium.copyWith(fontSize: 22),
                          ),
                          Text(
                            'Save',
                            style: figtreeMedium.copyWith(
                                fontSize: 14, color: ColorResources.maroon),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ],
            ),
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
