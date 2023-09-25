import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:glad/cubit/landing_page_cubit/landing_page_cubit.dart';
import 'package:glad/cubit/profile_cubit/profile_cubit.dart';
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
  String? district;

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
                        onPressed: () {
                          BlocProvider.of<ProfileCubit>(context)
                              .addressUpdateApi(context,widget.userId);
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
                          map(context),
                          /*const Stack(
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
                          ),*/
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
                                  // controller: state.districtController,
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
                                          .addressUpdateApi(context,widget.userId);
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

  Widget map(context) {
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
                                      // _searchPlaceController.text = prediction.description ?? "";
                                      addressController!.text = prediction.description!;
                                      // _searchPlaceController.selection = TextSelection.fromPosition(TextPosition(offset: prediction.description?.length ?? 0));
                                      _searchPlaceController.clear();
                                    },
                                    getPlaceDetailWithLatLng: (Prediction prediction) {
                                      // _searchPlaceController.text = prediction.description ?? "";
                                      addressController!.text = prediction.description!;
                                      // _searchPlaceController.selection = TextSelection.fromPosition(TextPosition(offset: prediction.description?.length ?? 0));
                                      lat = double.parse(prediction.lat!);
                                      long = double.parse(prediction.lng!);
                                      setState(() {});
                                      debugPrint("$lat $long");
                                      for( AddressComponents data in prediction.placeDetails!.result!.addressComponents!) {
                                        if(data.types!.contains('administrative_area_level_3')){
                                          district = data.longName;
                                          break;
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
