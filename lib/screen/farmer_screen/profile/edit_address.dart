import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:glad/cubit/profile_cubit/profile_cubit.dart';
import 'package:glad/screen/custom_widget/custom_appbar.dart';
import 'package:glad/screen/custom_widget/custom_dropdown.dart';
import 'package:glad/screen/custom_widget/custom_methods.dart';
import 'package:glad/screen/custom_widget/custom_textfield.dart';
import 'package:glad/screen/custom_widget/custom_textfield2.dart';
import 'package:glad/screen/custom_widget/g_map.dart';
import 'package:glad/screen/dialog/district_picker.dart';
import 'package:glad/utils/color_resources.dart';
import 'package:glad/utils/extension.dart';
import 'package:glad/utils/helper.dart';
import 'package:glad/utils/images.dart';
import 'package:glad/utils/styles.dart';

class EditAddress extends StatefulWidget {
  const EditAddress({super.key});

  @override
  State<EditAddress> createState() => _EditAddressState();
}

class _EditAddressState extends State<EditAddress> {
  @override
  void initState() {
    BlocProvider.of<ProfileCubit>(context).getDistrict(context);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocBuilder<ProfileCubit, ProfileCubitState>(
        builder: (context, state) {
          return Stack(
            children: [
              landingBackground(),
              Column(
                children: [
                  CustomAppBar(
                    context: context,
                    titleText1: 'Address',
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
                    description: 'Provide the following details',
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
                                    radius: 60,
                                  ))
                            ],
                          ),
                          40.verticalSpace(),
                          Padding(
                            padding:
                                const EdgeInsets.symmetric(horizontal: 20.0),
                            child: Column(
                              children: [
                                CustomTextField2(
                                  title: 'Country',
                                  controller: state.countryController
                                    ..text = "Uganda",
                                  enabled: false,
                                ),
                                20.verticalSpace(),
                                // DistrictPicker(),
                                CustomTextField2(
                                  readOnly: true,
                                  controller: TextEditingController(
                                      text: state.selectDistrict),
                                  title: 'District',
                                  image: Images.arrowDropdown,
                                  imageColors: Colors.black,
                                  onTap: () {
                                    customDialog(
                                        widget: const DistrictPicker());
                                  },
                                ),
                                20.verticalSpace(),
                                CustomTextField2(
                                  title: 'County',
                                  controller: state.countyController
                                    ..text = state.responseFarmerProfile!
                                        .farmer!.address!.county
                                        .toString(),
                                ),
                                20.verticalSpace(),
                                CustomTextField2(
                                  title: 'Parish',
                                  controller: state.parishController
                                    ..text = state.responseFarmerProfile!
                                        .farmer!.address!.parish
                                        .toString(),
                                ),
                                20.verticalSpace(),
                                CustomTextField2(
                                  title: 'Village',
                                  controller: state.villageController
                                    ..text = state.responseFarmerProfile!
                                        .farmer!.address!.village
                                        .toString(),
                                ),
                                20.verticalSpace(),
                                CustomTextField2(
                                  title: 'Centre Name',
                                  controller: state.centreNameController
                                    ..text = state.responseFarmerProfile!
                                        .farmer!.address!.centerName
                                        .toString(),
                                ),
                                40.verticalSpace(),
                                Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 20.0),
                                  child: customButton(
                                    'Save',
                                    onTap: () {
                                      BlocProvider.of<ProfileCubit>(context)
                                          .addressUpdateApi(context);
                                    },
                                    radius: 40,
                                    width: double.infinity,
                                    height: 60,
                                    style: figtreeMedium.copyWith(
                                        color: Colors.white, fontSize: 16),
                                  ),
                                ),
                                20.verticalSpace(),
                                Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 20.0),
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
            ],
          );
        },
      ),
    );
  }
}
