import 'package:flutter/material.dart';
import 'package:glad/screen/custom_widget/custom_methods.dart';
import 'package:glad/screen/custom_widget/custom_textfield2.dart';
import 'package:glad/utils/extension.dart';
import 'package:glad/utils/styles.dart';

class FarmDetails extends StatelessWidget {
  const FarmDetails({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20.0),
      child: Column(
        children: [
          const CustomTextField2(title: 'Farm Size'),
          20.verticalSpace(),
          const CustomTextField2(title: 'Dairy Area'),
          20.verticalSpace(),
          const CustomTextField2(title: 'No. of people working in the farm'),
          20.verticalSpace(),
          const CustomTextField2(title: 'Manager Name'),
          40.verticalSpace(),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20.0),
            child: customButton(
              'Save',
              onTap: () { },
              radius: 40,
              width: double.infinity,
              height: 70,
              style: figtreeMedium.copyWith(
                  color: Colors.white, fontSize: 16),
            ),
          ),
          20.verticalSpace(),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20.0),
            child: customButton('Cancel',
                onTap: () {},
                radius: 40,
                width: double.infinity,
                height: 70,
                style: figtreeMedium.copyWith(
                    color: Colors.black, fontSize: 16),
                color: 0xFFDCDCDC),
          ),
        ],
      ),
    );
  }
}
