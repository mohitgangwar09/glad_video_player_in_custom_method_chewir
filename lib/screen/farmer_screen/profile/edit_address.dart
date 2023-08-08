import 'package:flutter/material.dart';
import 'package:glad/screen/custom_widget/custom_methods.dart';
import 'package:glad/screen/custom_widget/custom_textfield.dart';
import 'package:glad/screen/custom_widget/custom_textfield2.dart';
import 'package:glad/screen/custom_widget/g_map.dart';
import 'package:glad/utils/color_resources.dart';
import 'package:glad/utils/extension.dart';
import 'package:glad/utils/images.dart';
import 'package:glad/utils/styles.dart';

class EditAddress extends StatelessWidget {
  const EditAddress({super.key});

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
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    arrowBackButton(),
                    Text('Address',
                        style: figtreeMedium.copyWith(
                            fontWeight: FontWeight.w100,
                            fontSize: 20,
                            color: Colors.black)),
                    TextButton(
                        onPressed: () {},
                        child: Text(
                          'Save',
                          style: figtreeMedium.copyWith(
                              color: ColorResources.maroon, fontSize: 14),
                        )),
                  ],
                ),
                Text(
                  'Provide the following details',
                  style: figtreeMedium.copyWith(fontSize: 12),
                ),
                Expanded(
                  child: SingleChildScrollView(
                    child: Column(
                      children: [
                        20.verticalSpace(),
                        const Stack(
                          children: [
                            GMap(
                              lat: 28.4986,
                              lng: 77.3999,
                              height: 350,
                              zoomGesturesEnabled: true,
                              zoomControlsEnabled: true,
                              myLocationEnabled: true,
                              myLocationButtonEnabled: false,
                            ),
                            Positioned(
                                top: 20,
                                right: 20,
                                left: 20,
                                child: CustomTextField(
                                  hint: 'Search By...',
                                  leadingImage: Images.search,
                                  imageColors: Colors.black,
                                  borderRadius: 60,
                                ))
                          ],
                        ),
                        40.verticalSpace(),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 20.0),
                          child: Column(
                            children: [
                              CustomTextField2(
                                title: 'Country',
                                isDropdown: true,
                                itemList: const ['Male', 'Female'],
                                dropdownValue: null,
                                icon: Images.arrowDropdown,
                                iconColors: Colors.black,
                                onChanged: (String? value) {},
                              ),
                              20.verticalSpace(),
                              CustomTextField2(
                                title: 'District',
                                isDropdown: true,
                                itemList: const ['Male', 'Female'],
                                dropdownValue: null,
                                icon: Images.arrowDropdown,
                                iconColors: Colors.black,
                                onChanged: (String? value) {},
                              ),
                              20.verticalSpace(),
                              CustomTextField2(
                                title: 'City',
                                isDropdown: true,
                                itemList: const ['Male', 'Female'],
                                dropdownValue: null,
                                icon: Images.arrowDropdown,
                                iconColors: Colors.black,
                                onChanged: (String? value) {},
                              ),
                              20.verticalSpace(),
                              const CustomTextField2(title: 'Zip Code'),
                              20.verticalSpace(),
                              const CustomTextField2(title: 'Address', maxLine: 3, minLine: 3,),
                              40.verticalSpace(),
                              Padding(
                                padding: const EdgeInsets.symmetric(horizontal: 20.0),
                                child: customButton(
                                  'Save',
                                  onTap: () { },
                                  radius: 40,
                                  width: double.infinity,
                                  height: 60,
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
                                    height: 60,
                                    style: figtreeMedium.copyWith(
                                        color: Colors.black, fontSize: 16),
                                    color: 0xFFDCDCDC),
                              ),
                            ],
                          ),
                        )
                      ],
                    ),
                  ),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
