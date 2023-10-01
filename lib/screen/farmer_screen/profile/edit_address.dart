import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:glad/cubit/landing_page_cubit/landing_page_cubit.dart';
import 'package:glad/cubit/profile_cubit/profile_cubit.dart';
import 'package:glad/data/model/response_county_list.dart';
import 'package:glad/data/model/response_sub_county.dart';
import 'package:glad/screen/custom_widget/container_border.dart';
import 'package:glad/screen/custom_widget/custom_appbar.dart';
import 'package:glad/screen/custom_widget/custom_dropdown.dart';
import 'package:glad/screen/custom_widget/custom_methods.dart';
import 'package:glad/screen/custom_widget/custom_textfield.dart';
import 'package:glad/screen/custom_widget/custom_textfield2.dart';
import 'package:glad/screen/custom_widget/g_map.dart';
import 'package:glad/screen/dialog/district_picker.dart';
import 'package:glad/utils/app_constants.dart';
import 'package:glad/utils/color_resources.dart';
import 'package:glad/utils/extension.dart';
import 'package:glad/utils/helper.dart';
import 'package:glad/utils/images.dart';
import 'package:glad/utils/styles.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:google_search_place/google_search_place.dart';
import 'package:google_search_place/model/place_details.dart';
import 'package:google_search_place/model/prediction.dart';

class EditAddress extends StatefulWidget {
  final String userId;
  const EditAddress({super.key,required this.userId});

  @override
  State<EditAddress> createState() => _EditAddressState();
}

class _EditAddressState extends State<EditAddress> {

  TextEditingController? addressController = TextEditingController();
  final TextEditingController _searchPlaceController = TextEditingController();
  double? lat;
  double? long;
  String? district,ugandaRegion;
  // String selectedCounty = "Select County";
  // String selectedSubCounty = "Select Sub County";

  GoogleMapController? mapController;

  Map<MarkerId, Marker> markers = <MarkerId, Marker>{};

  void _onMapCreated(GoogleMapController controller) {
    mapController = controller;
    mapController?.animateCamera(
      CameraUpdate.newCameraPosition(
        CameraPosition(
          target: LatLng(lat!=null?lat!:BlocProvider.of<LandingPageCubit>(context).state.currentPosition!.latitude, long!=null?long!:BlocProvider.of<LandingPageCubit>(context).state.currentPosition!.longitude),
          zoom: 15.5,
        ),
      ),
    );
    var marker = Marker(
      markerId: const MarkerId(''),
      position: LatLng(lat!=null?lat!:BlocProvider.of<LandingPageCubit>(context).state.currentPosition!.latitude, long!=null?long!:BlocProvider.of<LandingPageCubit>(context).state.currentPosition!.longitude),
      // icon: BitmapDescriptor.,
      infoWindow: const InfoWindow(
        title: '',
        snippet: '',
      ),
    );

    setState(() {
      markers[const MarkerId('place_name')] = marker;
    });
  }


  @override
  void dispose() {
    super.dispose();
    mapController!.dispose();
  }

  @override
  void initState() {
    // BlocProvider.of<ProfileCubit>(context).getDistrict(context);
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
                        onPressed: () {
                          BlocProvider.of<ProfileCubit>(context)
                              .addressUpdateApi(context,widget.userId,
                          lat.toString(),long.toString());
                        },
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
                          map(context,state),
                          40.verticalSpace(),
                          Padding(
                            padding:
                                const EdgeInsets.symmetric(horizontal: 20.0),
                            child: Column(
                              children: [

                                CustomTextField2(
                                  title: 'Country',
                                  controller: state.countryController,
                                  enabled: false,
                                ),

                                20.verticalSpace(),

                                CustomTextField2(
                                  title: 'Region',
                                  controller: state.regionController,
                                  enabled: false,
                                ),
                                20.verticalSpace(),
                                // DistrictPicker(),
                                CustomTextField2(
                                  readOnly: true,
                                  controller: state.districtController,
                                  title: 'District',
                                ),

                                /*20.verticalSpace(),
                                CustomTextField2(
                                  readOnly: true,
                                  title: 'County',
                                  controller: state.countyController
                                    ..text = state.responseFarmerProfile!
                                        .farmer!.address!.county
                                        .toString(),
                                  imageColors: Colors.black,
                                  image: Images.arrowDropdown,
                                  onTap: () {
                                    customDialog(
                                        widget: const DistrictPicker());
                                  },
                                ),*/

                                20.verticalSpace(),

                                Align(
                                  alignment: Alignment.centerLeft,
                                  child: "County".textMedium(color: Colors.black, fontSize: 12),
                                ),

                                5.verticalSpace(),

                                Container(
                                  height: 55,
                                  decoration: BoxDecoration(
                                    border: Border.all(color: const Color(0xffD9D9D9,),width: 1.5),
                                    borderRadius: BorderRadius.circular(10)
                                  ),
                                  width: screenWidth(),
                                  child: DropdownButtonHideUnderline(
                                    child: DropdownButton2<Counties>(
                                      isExpanded: true,
                                      isDense: true,
                                      hint: Text(
                                        state.selectCounty.toString(),
                                        style: TextStyle(
                                          fontSize: 14,
                                          color: Theme.of(context).hintColor,
                                        ),
                                      ),
                                      items: state.counties!
                                          .map((Counties item) => DropdownMenuItem<Counties>(
                                        value: item,
                                        child: Text(
                                          item.name!,
                                          style: const TextStyle(
                                            fontSize: 14,
                                          ),
                                        ),
                                      )).toList(),
                                      // value: state.counties![0].name!,
                                      onChanged: (Counties? value) {
                                        // setState(() {
                                          // selectedCounty = value!.name!;
                                          BlocProvider.of<ProfileCubit>(context).emit(state.copyWith(selectSubCounty: 'Select Sub County',selectCounty: value!.name.toString()));
                                          BlocProvider.of<ProfileCubit>(context).getSubCountyApi(context, value.id.toString());
                                        // });
                                      },
                                      buttonStyleData: const ButtonStyleData(
                                        padding: EdgeInsets.symmetric(horizontal: 16),
                                        height: 40,
                                        width: 140,
                                      ),
                                      menuItemStyleData: const MenuItemStyleData(
                                        height: 40,
                                      ),
                                    ),
                                  ),
                                ),

                                20.verticalSpace(),

                                Align(
                                  alignment: Alignment.centerLeft,
                                  child: "Sub County".textMedium(color: Colors.black, fontSize: 12),
                                ),

                                5.verticalSpace(),

                                Container(
                                  height: 55,
                                  decoration: BoxDecoration(
                                      border: Border.all(color: const Color(0xffD9D9D9,),width: 1.5),
                                      borderRadius: BorderRadius.circular(10)
                                  ),
                                  width: screenWidth(),
                                  child: DropdownButtonHideUnderline(
                                    child: DropdownButton2<DataSubCounty>(
                                      isExpanded: true,
                                      isDense: true,
                                      hint: Text(
                                        state.selectSubCounty.toString(),
                                        style: TextStyle(
                                          fontSize: 14,
                                          color: Theme.of(context).hintColor,
                                        ),
                                      ),
                                      items: state.dataSubCounty!
                                          .map((DataSubCounty item) => DropdownMenuItem<DataSubCounty>(
                                        value: item,
                                        child: Text(
                                          item.name!,
                                          style: const TextStyle(
                                            fontSize: 14,
                                          ),
                                        ),
                                      )).toList(),
                                      // value: state.counties![0].name!,
                                      onChanged: (DataSubCounty? value) {
                                        // if(selectedCounty == 'Select County'){
                                        //   showCustomToast(context, "Please select county ist");
                                        // }else{
                                        BlocProvider.of<ProfileCubit>(context).emit(state.copyWith(selectSubCounty: value!.name!.toString()));
                                         /* setState(() {
                                            selectedSubCounty = value!.name!;
                                          });*/
                                        // }
                                      },
                                      buttonStyleData: const ButtonStyleData(
                                        padding: EdgeInsets.symmetric(horizontal: 16),
                                        height: 40,
                                        width: 140,
                                      ),
                                      menuItemStyleData: const MenuItemStyleData(
                                        height: 40,
                                      ),
                                    ),
                                  ),
                                ),

                                20.verticalSpace(),
                                CustomTextField2(
                                  title: 'Zip-Code',
                                  controller: state.zipCodeController,
                                  inputType: TextInputType.phone,
                                  maxLine: 1,
                                  maxLength: 12,
                                  inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                                    // ..text = state.responseFarmerProfile!
                                    //     .farmer!.address!.parish
                                    //     .toString(),
                                ),
                                20.verticalSpace(),
                                SizedBox(

                                  child: CustomTextField2(
                                    title: 'Address',
                                    // height: state.editAddressController.text.isEmpty?100: state.editAddressController.text.length>38?100:70,
                                    height: 100,
                                    minLine: 1,
                                    maxLine: 2,
                                    controller: state.editAddressController
                                      // ..text = state.responseFarmerProfile!
                                      //     .farmer!.address!.village
                                      //     .toString(),
                                  ),
                                ),
                              /*  20.verticalSpace(),
                                CustomTextField2(
                                  title: 'Centre Name',
                                  controller: state.centreNameController
                                    ..text = state.responseFarmerProfile!
                                        .farmer!.address!.centerName
                                        .toString(),
                                ),*/
                                40.verticalSpace(),
                                Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 20.0),
                                  child: customButton(
                                    'Save',
                                    onTap: () {
                                      BlocProvider.of<ProfileCubit>(context)
                                          .addressUpdateApi(context,widget.userId,
                                          lat.toString(),long.toString());
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
                                      onTap: () {
                                    pressBack();
                                      },
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

  Widget map(context,ProfileCubitState state) {
    return Column(
      children: [
        Stack(
          children: [
            GMap(
              lat: lat ?? BlocProvider.of<LandingPageCubit>(context).state.currentPosition!.latitude,
              lng: long ?? BlocProvider.of<LandingPageCubit>(context).state.currentPosition!.longitude,
              height: 350,
              onMapCreated: (controller) async{
                _onMapCreated(controller);
              },
              markers: markers.values.toSet(),
              onCameraIdle: () {},
            ),
            Positioned(
                child: Padding(
                    padding: const EdgeInsets.fromLTRB(19, 20, 19, 0),
                    child: Stack(
                      children: [
                        ContainerBorder(
                          margin: 0.marginVertical(),
                          padding: 10.paddingOnly(top: 15, bottom: 15),
                          borderColor: 0xffD9D9D9,
                          backColor: 0xffFFFFFF,
                          radius: 60,
                          widget: Row(
                            children: [
                              5.horizontalSpace(),
                              Expanded(
                                child: Padding(
                                  padding: const EdgeInsets.only(left: 10.0, right: 35),
                                  child: SearchPlaceAutoCompletedTextField(
                                    googleAPIKey: AppConstants.gMapsApiKey,
                                    controller: _searchPlaceController,
                                    itmOnTap: (Prediction prediction) {
                                      addressController!.text = prediction.description!;
                                      _searchPlaceController.clear();
                                    },
                                    getPlaceDetailWithLatLng: (Prediction prediction) {
                                      addressController!.text = prediction.description!;
                                      lat = double.parse(prediction.lat!);
                                      long = double.parse(prediction.lng!);
                                      setState(() {});

                                      if(prediction.placeDetails!.result!=null){
                                        if(prediction.placeDetails!.result!.formattedAddress!=null){
                                          state.editAddressController.text = prediction.placeDetails!.result!.formattedAddress.toString();
                                        }
                                      }
                                      List<DataSubCounty> data = [];
                                      // state.dataSubCounty!.clear();

                                      BlocProvider.of<ProfileCubit>(context).getSubCountyApi(context, 'null');
                                      for( AddressComponents data in prediction.placeDetails!.result!.addressComponents!) {

                                        if(data.types!.contains('administrative_area_level_2') || data.types!.contains('administrative_area_level_3')){
                                          // district = data.longName;
                                          state.districtController.text = data.longName.toString();
                                          print("district Name $district");
                                          // selectedCounty = 'Select County';
                                          // selectedSubCounty = 'Select Sub County';
                                          BlocProvider.of<ProfileCubit>(context).emit(state.copyWith(selectCounty: 'Select County',selectSubCounty: 'Select Sub County'));
                                          BlocProvider.of<ProfileCubit>(context).getCountyApi(context,data.longName.toString());
                                          // break;
                                        }

                                        if(data.types!.contains('postal_code')){
                                          // district = data.longName;
                                          // state.districtController.text = data.longName.toString();
                                          print("Postal Code $district");
                                          // break;
                                        }

                                        if(data.types!.contains('administrative_area_level_1')){
                                          // ugandaRegion = data.longName;
                                          state.regionController.text = data.longName.toString();
                                          print("uganda Region Name $ugandaRegion");
                                          // break;
                                        }

                                        if(data.types!.contains('country')){
                                          state.countryController.text = data.longName.toString();
                                          print("Country Name ${state.countryController.text}");
                                        }


                                        if(data.types!.contains('country')){
                                          state.countryController.text = data.longName.toString();
                                          print("Country Name ${state.countryController.text}");
                                        }

                                      }
                                      mapController?.animateCamera(
                                        CameraUpdate.newCameraPosition(
                                          CameraPosition(
                                            target: LatLng(lat!=null?lat!:BlocProvider.of<LandingPageCubit>(context).state.currentPosition!.latitude, long!=null?long!:BlocProvider.of<LandingPageCubit>(context).state.currentPosition!.longitude),
                                            zoom: 15.5,
                                          ),
                                        ),
                                      );
                                      var marker = Marker(
                                        markerId: const MarkerId(''),
                                        position: LatLng(lat!=null?lat!:BlocProvider.of<LandingPageCubit>(context).state.currentPosition!.latitude, long!=null?long!:BlocProvider.of<LandingPageCubit>(context).state.currentPosition!.longitude),
                                        // icon: BitmapDescriptor.,
                                        infoWindow: const InfoWindow(
                                          title: '',
                                          snippet: '',
                                        ),
                                      );

                                      // setState(() {
                                      markers[const MarkerId('place_name')] = marker;
                                      // });
                                    },
                                    inputDecoration: InputDecoration(
                                      labelText: 'Search By...',
                                      enabledBorder: const UnderlineInputBorder(
                                        borderSide:
                                        BorderSide(color: Colors.transparent),
                                      ),
                                      focusedBorder: const UnderlineInputBorder(
                                        borderSide:
                                        BorderSide(color: Colors.transparent),
                                      ),
                                      labelStyle: figtreeRegular.copyWith(
                                          fontSize: 15, color: Colors.grey),
                                      hintStyle:
                                      figtreeMedium.copyWith(
                                          fontSize: 16,
                                          color: Colors.grey),
                                      contentPadding: const EdgeInsets.all(0.0),
                                      isDense: true,
                                      border: InputBorder.none,
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        Positioned(
                          right: 13,
                          top: 0,
                          bottom: 0,
                          child: Row(
                            children: [
                              SvgPicture.asset(
                                Images.search,
                                colorFilter: const ColorFilter.mode(ColorResources.maroon, BlendMode.srcIn),
                              ),
                              10.horizontalSpace(),
                            ],
                          ),
                        ),
                      ],
                    )
                ))
          ],
        )
      ],
    );
  }

}
