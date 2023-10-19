import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:glad/cubit/landing_page_cubit/landing_page_cubit.dart';
import 'package:glad/cubit/profile_cubit/profile_cubit.dart';
import 'package:glad/screen/custom_widget/custom_appbar.dart';
import 'package:glad/screen/custom_widget/custom_methods.dart';
import 'package:glad/screen/custom_widget/g_map.dart';
import 'package:glad/screen/farmer_screen/profile/edit_address.dart';
import 'package:glad/screen/farmer_screen/profile/edit_kyc_documents.dart';
import 'package:glad/screen/farmer_screen/profile/improvement_area.dart';
import 'package:glad/screen/farmer_screen/profile/kyc_update.dart';
import 'package:glad/screen/farmer_screen/profile/view_kyc_documents.dart';
import 'package:glad/utils/color_resources.dart';
import 'package:glad/utils/extension.dart';
import 'package:glad/utils/helper.dart';
import 'package:glad/utils/images.dart';
import 'package:glad/utils/styles.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'edit_profile.dart';

class FarmerProfile extends StatefulWidget {
  const FarmerProfile({super.key});

  @override
  State<FarmerProfile> createState() => _FarmerProfileState();
}

class _FarmerProfileState extends State<FarmerProfile> {

  GoogleMapController? mapController;

  Map<MarkerId, Marker> markers = <MarkerId, Marker>{};

  String countryCode = "";

  void getCountryCode() async{
    String countryCodes = await BlocProvider.of<ProfileCubit>(context).getCountryCode();
    countryCode = countryCodes;
  }

  void _onMapCreated(GoogleMapController controller,String latitude,String longitude) {
    mapController = controller;
    mapController?.animateCamera(
      CameraUpdate.newCameraPosition(
        CameraPosition(
          target: LatLng(double.parse(latitude), double.parse(longitude)),
          zoom: 15.5,
        ),
      ),
    );
    var marker = Marker(
      markerId: const MarkerId(''),
      position: LatLng(double.parse(latitude), double.parse(longitude)),
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
  void initState() {
    super.initState();

    BlocProvider.of<ProfileCubit>(context).getFarmerProfile(context);
    getCountryCode();
  }

  @override
  void dispose() {
    super.dispose();
    mapController!.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocBuilder<ProfileCubit, ProfileCubitState>(
          builder: (context, state) {
        if (state.status == ProfileStatus.submit) {
          return const Center(
              child: CircularProgressIndicator(
            color: ColorResources.maroon,
          ));
        }else if (state.responseFarmerProfile == null) {
          return "${state.responseFarmerProfile} Api Error".textMedium();
        }
        return Stack(
          children: [
            farmerBackground(),
            Column(
              children: [
                CustomAppBar(
                  context: context,
                  titleText1: 'My Profile',
                  titleText1Style:
                      figtreeMedium.copyWith(fontSize: 20, color: Colors.black),
                  centerTitle: true,
                  leading: arrowBackButton(),
                  action: Padding(
                    padding: const EdgeInsets.only(right: 10),
                    child: InkWell(
                        onTap: () {
                          const EditProfile(
                            section: 'personal',
                          ).navigate();
                        },
                        child: SvgPicture.asset(Images.profileEdit)),
                  ),
                ),
                Expanded(
                  child: SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        10.verticalSpace(),
                        state.responseFarmerProfile!.farmer!.photo!=null?
                        profileData(state):SizedBox(
                          height: 164,
                          width: 164,
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(50),
                            child: Image.asset(
                              Images.placeHolder,
                              height: 164,
                              width: 164,
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                        state.responseFarmerProfile!.farmer!.photo!=null?40.verticalSpace():0.verticalSpace(),
                        farmDetails(state),
                        30.verticalSpace(),
                        dde(context, state,countryCode),
                        20.verticalSpace(),
                        state.responseFarmerProfile!.farmer!.cowBreedDetails!.isNotEmpty?
                        cowsInTheFarm(state):const SizedBox.shrink(),
                        30.verticalSpace(),
                        state.responseFarmerProfile!.farmer!.address != null ? address(context,state) : SizedBox.shrink(),
                        state.improvementAreaListResponse != null
                            ? state.improvementAreaListResponse!.data!.improvementAreaList!.isNotEmpty
                                ? facilitiesInTheFarm(state)
                                : const SizedBox.shrink()
                            : const SizedBox.shrink(),
                        20.verticalSpace(),
                      ],
                    ),
                  ),
                )
              ],
            ),
          ],
        );
      }),
    );
  }

  Widget profileData(ProfileCubitState state) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            InkWell(
              onTap: () {
                // const EditProfile(section: 'personal').navigate();
              },
              child: Stack(
                children: [
                  SizedBox(
                    width: 177,
                    child: Row(
                      children: [
                        SizedBox(
                          width: 154,
                          height: 154,
                          child: ClipRRect(
                              borderRadius: BorderRadius.circular(50),
                              child: Image.network(
                                state.responseFarmerProfile!=null?state.responseFarmerProfile!.farmer!.photo!:"https://develop-glad.staqo.com/storage/52/image_picker_AC704C99-29C8-454C-9C89-DABDAAD217F3-10034-00001D8B132EAD0D.jpg",
                                errorBuilder: (_, __, ___) => Image.asset(
                                  Images.placeHolder,
                                  height: 164,
                                  width: 164,
                                  fit: BoxFit.cover,
                                ),
                                height: 164,
                                width: 164,
                                fit: BoxFit.cover,
                              )),
                        ),
                      ],
                    ),
                  ),
                  /*Positioned.fill(
                      child: Align(
                          alignment: Alignment.centerRight,
                          child: SvgPicture.asset(Images.imageEdit))),*/
                ],
              ),
            ),
          ],
        ),
        10.verticalSpace(),
        InkWell(
          onTap: state.responseFarmerProfile!.farmer!.kycStatus == 'not_available' ? () {
            const KYCUpdate().navigate();
          } : state.responseFarmerProfile!.farmer!.kycStatus == 'pending' ? () {
            EditKYCDocuments(farmerDocuments: state.responseFarmerProfile!.farmer!.farmerDocuments!).navigate();
          } : state.responseFarmerProfile!.farmer!.kycStatus == 'verified' ? () {
            ViewKYCDocuments(farmerDocuments: state.responseFarmerProfile!.farmer!.farmerDocuments!).navigate();
          } : () {},
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(state.responseFarmerProfile!.farmer!.name!,
                  style: figtreeMedium.copyWith(fontSize: 24)),
              4.horizontalSpace(),
              state.responseFarmerProfile!.farmer!.kycStatus == 'not_available' || state.responseFarmerProfile!.farmer!.kycStatus == 'pending' ? SvgPicture.asset(Images.kycUnverified) : Container(
                  decoration: const BoxDecoration(color: Colors.green, shape: BoxShape.circle),
                  padding: const EdgeInsets.all(4),
                  child: const Icon(Icons.done, color: Colors.white, size: 16,)),
            ],
          ),
        ),
        10.verticalSpace(),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(state.responseFarmerProfile!.farmer!.email!,
                style: figtreeRegular.copyWith(
                    fontSize: 14, decoration: TextDecoration.underline)),
            8.horizontalSpace(),
            // Container(
            //   height: 5,
            //   width: 5,
            //   decoration: const BoxDecoration(
            //       color: Colors.black, shape: BoxShape.circle),
            // ),
            /*8.horizontalSpace(),
            Text(state.responseFarmerProfile!.farmer!.phone!,
                style: figtreeSemiBold.copyWith(fontSize: 14)),*/
          ],
        ),

        10.verticalSpace(),

        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text("${countryCode == ""? "":countryCode!=null?countryCode.toString():""} ${state.responseFarmerProfile!.farmer!
                .phone}",
                style: figtreeRegular.copyWith(
                  fontSize: 12,
                )),

            Text(
                "${', '}""${state.responseFarmerProfile!.farmer!
                    .supplierId ??
                    ''}",
                style: figtreeRegular.copyWith(
                  fontSize: 12,
                )),
          ],
        ),
        10.verticalSpace(),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Row(
              children: [
                Column(
                  children: [
                    Text(
                        (state.responseFarmerProfile!.farmer!.dateOfBirth == "0000-00-00"?'0 years old':getAge(DateTime.parse(state.responseFarmerProfile!.farmer!.farmingExperience ?? '')).split(' ')[0]),
                        style: figtreeSemiBold.copyWith(fontSize: 22)),
                    Text('${getAge(DateTime.parse(state.responseFarmerProfile!.farmer!.dateOfBirth ?? '')).split(' ')[1]} exp.',
                        style: figtreeRegular.copyWith(
                          fontSize: 12,
                        )),
                  ],
                ),
                15.horizontalSpace(),
                SizedBox(
                  height: 35,
                  child: customPaint(Colors.black),
                ),
                15.horizontalSpace(),
                Column(
                  children: [
                    Text((state.responseFarmerProfile!.farmer!.dateOfBirth == "0000-00-00"?'0 years old':getAge(DateTime.parse(state.responseFarmerProfile!.farmer!.dateOfBirth ?? '')).split(' ')[0]),
                        style: figtreeSemiBold.copyWith(fontSize: 22)),
                    Text('${getAge(DateTime.parse(state.responseFarmerProfile!.farmer!.dateOfBirth ?? '')).split(' ')[1]} old',
                        style: figtreeRegular.copyWith(
                          fontSize: 12,
                        )),
                  ],
                ),
                // 15.horizontalSpace(),
              ],
            ),
            const SizedBox(width: 30,),

            Row(
              children: [
                Container(
                    padding: const EdgeInsets.fromLTRB(20, 10, 20, 5),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(12),
                      color: Colors.white,
                    ),
                    child: Column(
                      children: [

                        state.responseFarmerProfile!.farmer!.ragRating.toString() == "satisfactory"?
                        "Satisfactory".textMedium(fontSize: 12):
                        state.responseFarmerProfile!.farmer!.ragRating.toString() == 'critical'?
                        "Critical".textMedium(fontSize: 12):
                        state.responseFarmerProfile!.farmer!.ragRating.toString() == 'average'?
                        "Average".textMedium(fontSize: 12):"".textMedium(),

                        state.responseFarmerProfile!.farmer!.ragRating.toString() == "satisfactory" ?
                        const CustomIndicator(
                          percentage: 65,
                          width: 95,
                          color: Color(0xFFFC5E60),
                          color1: Colors.yellow,
                          color2: Color(0xFF4BC56F),
                          barCircleColor: Color(0xFF4BC56F),
                        ):
                        state.responseFarmerProfile!.farmer!.ragRating.toString() == 'critical'?
                        const CustomIndicator(
                          percentage: 10,
                          width: 95,
                          color: Color(0xFFFC5E60),
                          color1: Colors.yellow,
                          color2: Colors.green,
                          barCircleColor: Color(0xFFFC5E60),
                        ):state.responseFarmerProfile!.farmer!.ragRating.toString() == 'average'?
                        const CustomIndicator(
                          percentage: 38,
                          width: 95,
                          color: Color(0xFFFC5E60),
                          color1: Colors.yellow,
                          color2: Colors.green,
                          barCircleColor: Colors.yellow,
                        ):"".textMedium()
                        /*const CustomIndicator(
                          percentage: 69,
                          width: 122,
                          color: Color(0xFF4BC56F),
                          color1: Color(0xFFFEEB53),
                          color2: Color(0xFFFC5E60),
                          barCircleColor :Color(0xFF4BC56F)
                        ),*/
                      ],
                    )),
              ],
            )
          ],
        ),
      ],
    );
  }

  Widget facilitiesInTheFarm(ProfileCubitState state) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.fromLTRB(20.0, 30, 0, 0),
          child: Align(
            alignment: Alignment.centerLeft,
            child: Text('Facilities in the Farm',
                style: figtreeMedium.copyWith(fontSize: 18)),
          ),
        ),
        15.verticalSpace(),
        SizedBox(
          height: 150,
          child: ListView.separated(
            itemCount: state.improvementAreaListResponse!.data!.improvementAreaList!.length,
            shrinkWrap: true,
            scrollDirection: Axis.horizontal,
            itemBuilder: (context, index) {
              return InkWell(
                onTap: () {
                  ImprovementArea(index: index).navigate();
                },
                child: Padding(
                  padding: EdgeInsets.only(left: index == 0 ? 20.0 : 0),
                  child: SizedBox(
                    width: 120,
                    child: Column(
                      children: [
                        ClipRRect(
                          borderRadius:
                          BorderRadius.circular(16.0),
                          child: CachedNetworkImage(
                            imageUrl: state
                                .improvementAreaListResponse!
                                .data!
                                .improvementAreaList![
                            index]
                                .image ??
                                '',
                            errorWidget: (_, __, ___) =>
                                Image.asset(
                                  Images.facilities,
                                  width: 120,
                                  height: 100,
                                  fit: BoxFit.cover,
                                  alignment: Alignment.center,
                                ),
                            width: 120,
                            height: 100,
                            fit: BoxFit.cover,
                            alignment: Alignment.center,
                          ),
                        ),
                        7.verticalSpace(),
                        Text(
                          state.improvementAreaListResponse!.data!.improvementAreaList![index].name.toString(),
                          style: figtreeMedium.copyWith(
                              color: Colors.black, fontSize: 12),
                          softWrap: true,
                        )
                      ],
                    ),
                  ),
                ),
              );
            },
            separatorBuilder: (context, index) {
              return 10.horizontalSpace();
            },
          ),
        )
      ],
    );
  }

  Widget address(BuildContext context,ProfileCubitState state) {
    return Stack(
      children: [
        GMap(
          lat: double.parse(state.responseFarmerProfile!.farmer!.address!.latitude!=null ? state.responseFarmerProfile!.farmer!.address!.latitude!.toString():BlocProvider.of<LandingPageCubit>(context).state.currentPosition!.latitude.toString()),
          lng: double.parse(state.responseFarmerProfile!.farmer!.address!.longitude!=null?state.responseFarmerProfile!.farmer!.address!.longitude!.toString():BlocProvider.of<LandingPageCubit>(context).state.currentPosition!.longitude.toString()),
          height: 350,
          onMapCreated: (GoogleMapController controller){
            _onMapCreated(controller,state.responseFarmerProfile!.farmer!.address!.latitude!=null?state.responseFarmerProfile!.farmer!.address!.latitude!.toString():BlocProvider.of<LandingPageCubit>(context).state.currentPosition!.latitude.toString(),
                state.responseFarmerProfile!.farmer!.address!.longitude!=null?state.responseFarmerProfile!.farmer!.address!.longitude!.toString():BlocProvider.of<LandingPageCubit>(context).state.currentPosition!.longitude.toString());
          },
          zoomGesturesEnabled: false,
          zoomControlsEnabled: false,
          myLocationEnabled: true,
          myLocationButtonEnabled: false,
          markers: markers.values.toSet(),
        ),
        Positioned(
          bottom: 20,
          left: 30,
          right: 30,
          child: Container(
            height: 105,
            decoration: BoxDecoration(
                color: Colors.white, borderRadius: BorderRadius.circular(16)),
            child: Padding(
              padding: const EdgeInsets.all(15),
              child: Row(
                children: [
                  Image.asset(Images.sampleLivestock),
                  15.horizontalSpace(),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text('Address',
                          style: figtreeMedium.copyWith(
                              fontSize: 16, color: Colors.black)),
                      4.verticalSpace(),
                      SizedBox(
                        width: MediaQuery.of(context).size.width * 0.4,
                        child: Text(
                          " ${state.responseFarmerProfile!.farmer!.address!.subCounty!=null?state.responseFarmerProfile!.farmer!.address!.subCounty!:""}"
                              " ${state.responseFarmerProfile!.farmer!.address!.district!=null?state.responseFarmerProfile!.farmer!.address!.district!:""}"
                              " ${state.responseFarmerProfile!.farmer!.address!.address!=null?state.responseFarmerProfile!.farmer!.address!.address!:""}"
                          // state.responseFarmerProfile!.farmer!.address!.address!=null? state.responseFarmerProfile!.farmer!.address!.address!.toString():"",
                          ,
                          style: figtreeRegular.copyWith(
                            fontSize: 14,
                            color: Colors.black,
                            overflow: TextOverflow.ellipsis,
                          ),
                          maxLines: 2,
                        ),
                      ),
                    ],
                  )
                ],
              ),
            ),
          ),
        ),
        Positioned(
          right: 20,
          top: 10,
          child: InkWell(
              onTap: () {
                BlocProvider.of<LandingPageCubit>(context).getCurrentLocation();
                EditAddress(userId :state.responseFarmerProfile!.farmer!.userId.toString()).navigate();
              },
              child: SvgPicture.asset(Images.profileEdit)),
        ),
      ],
    );
  }

  Widget cowsInTheFarm(ProfileCubitState state) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.fromLTRB(20.0, 0, 0, 0),
          child: Align(
            alignment: Alignment.centerLeft,
            child: Text('Cows in the farm',
                style: figtreeMedium.copyWith(fontSize: 18)),
          ),
        ),
        10.verticalSpace(),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0),
          child: Container(
            width: screenWidth(),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                color: Colors.white,
                border: Border.all(color: ColorResources.grey)),
            padding: const EdgeInsets.all(18.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                /*Wrap(
                  spacing: 10,
                  children: [
                  for(int index = 0; index < state.responseFarmerProfile!.farmer!.cowBreedDetails!.length; index++)
                    InkWell(
                      onTap: () {
                        BlocProvider.of<ProfileCubit>(context).changeSelectedBreedIndex(index);
                      },
                      child: Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20),
                          color: state.selectedBreedIndex == index ? ColorResources.maroon : const Color(0xFFF9F9F9),
                        ),
                        padding: const EdgeInsets.all(10.0),
                        child: Text(
                          state.responseFarmerProfile!.farmer!.cowBreedDetails![index].breedName!,
                          style: figtreeRegular.copyWith(
                              fontSize: 12, color: state.selectedBreedIndex == index ? Colors.white: Colors.black),
                        ),
                      ),
                    ),
                ],),
                20.verticalSpace(),*/

                Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: const Color(0xFFFFF3F4),
                  ),
                  padding: const EdgeInsets.symmetric(
                      vertical: 16.5, horizontal: 16),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      RichText(
                          text: TextSpan(children: [
                            TextSpan(
                                text: 'Milking Cows  ',
                                style: figtreeRegular.copyWith(
                                    fontSize: 14, color: const Color(0xFF727272))),
                            TextSpan(
                                text: state.responseFarmerProfile!.farmer!.cowBreedDetails![state.selectedBreedIndex!].milkingCows!.toString(),
                                style: figtreeSemiBold.copyWith(
                                    fontSize: 14, color: Colors.black)),
                          ])),
                      SizedBox(
                        height: 20,
                        child: customPaint(const Color(0xFF999999)),
                      ),
                      state.responseFarmerProfile!.farmer!.farmerMilkProduction!.isNotEmpty ? RichText(
                          text: TextSpan(children: [
                            TextSpan(
                                text: 'Yield  ',
                                style: figtreeRegular.copyWith(
                                    fontSize: 14, color: const Color(0xFF727272))),
                            TextSpan(
                                text: '${ double.parse('${state.responseFarmerProfile!.farmer!.farmerMilkProduction![0].totalMilkProduction!=null?
                                double.parse(state.responseFarmerProfile!.farmer!.farmerMilkProduction![0].totalMilkProduction!.toString())/
                                    double.parse(state.responseFarmerProfile!.farmer!.farmerMilkProduction![0].milkingCow!=null?state.responseFarmerProfile!.farmer!.farmerMilkProduction![0].milkingCow!.toString():"1")
                                    // /double.parse(DateTime(state.responseMonthlyWiseData![index].year!, state.responseMonthlyWiseData![index].month!, 0).day.toString())
                                    / double.parse(DateTime(DateTime.parse(state.responseFarmerProfile!.farmer!.farmerMilkProduction![0].date ?? DateTime.now().toString()).year, DateTime.parse(state.responseFarmerProfile!.farmer!.farmerMilkProduction![0].date ?? DateTime.now().toString()).month, 0).day.toString()):''}').toStringAsFixed(2)
                                } Ltr/Day',
                                style: figtreeSemiBold.copyWith(
                                    fontSize: 14, color: Colors.black)),
                          ])) : RichText(
                          text: TextSpan(children: [
                            TextSpan(
                                text: 'Yield  ',
                                style: figtreeRegular.copyWith(
                                    fontSize: 14, color: const Color(0xFF727272))),
                            TextSpan(
                                text: '0 Ltr/Day',
                                style: figtreeSemiBold.copyWith(
                                    fontSize: 14, color: Colors.black)),
                          ])),
                    ],
                  ),
                ),
                20.verticalSpace(),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SvgPicture.asset(Images.herdSize),
                        10.verticalSpace(),
                        Text('Herd Size',
                            style: figtreeMedium.copyWith(fontSize: 14)),
                        4.verticalSpace(),
                        Text(state.responseFarmerProfile!.farmer!.cowBreedDetails![state.selectedBreedIndex!].herdSize!.toString(),
                            style: figtreeSemiBold.copyWith(fontSize: 18)),
                      ],
                    ),
                    10.horizontalSpace(),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SvgPicture.asset(Images.dryCows),
                        10.verticalSpace(),
                        Text('Dry Cows',
                            style: figtreeMedium.copyWith(fontSize: 14)),
                        4.verticalSpace(),
                        Text(state.responseFarmerProfile!.farmer!.cowBreedDetails![state.selectedBreedIndex!].dryCows!.toString(),
                            style: figtreeSemiBold.copyWith(fontSize: 18)),
                      ],
                    ),
                    10.horizontalSpace(),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SvgPicture.asset(Images.heifer),
                        10.verticalSpace(),
                        Text('Heifer',
                            style: figtreeMedium.copyWith(fontSize: 14)),
                        4.verticalSpace(),
                        Text(state.responseFarmerProfile!.farmer!.cowBreedDetails![state.selectedBreedIndex!].heiferCows.toString(),
                            style: figtreeSemiBold.copyWith(fontSize: 18)),
                      ],
                    ),
                  ],
                ),
                20.verticalSpace(),
                Row(
                  children: [
                    Expanded(
                      child: Row(
                        children: [
                          RichText(
                              text: TextSpan(children: [
                                TextSpan(
                                    text: '7-12 month: ',
                                    style: figtreeRegular.copyWith(
                                        fontSize: 12,
                                        color: const Color(0xFF727272))),
                                TextSpan(
                                    text: state.responseFarmerProfile!.farmer!.cowBreedDetails![state.selectedBreedIndex!].sevenToTwelveMonthCows.toString(),
                                    style: figtreeMedium.copyWith(
                                        fontSize: 12, color: Colors.black)),
                              ])),
                        ],
                      ),
                    ),
                    Container(
                      height: 4.5,
                      width: 4.5,
                      decoration: const BoxDecoration(
                          color: Colors.black, shape: BoxShape.circle),
                    ),
                    Expanded(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          RichText(
                              text: TextSpan(children: [
                                TextSpan(
                                    text: '<6 month: ',
                                    style: figtreeRegular.copyWith(
                                        fontSize: 12,
                                        color: const Color(0xFF727272))),
                                TextSpan(
                                    text: state.responseFarmerProfile!.farmer!.cowBreedDetails![state.selectedBreedIndex!].sixMonthCow.toString(),
                                    style: figtreeRegular.copyWith(
                                        fontSize: 12, color: Colors.black)),
                              ])),
                          /*Container(
                          height: 4.5,
                          width: 4.5,
                          decoration: const BoxDecoration(
                              color: Colors.black, shape: BoxShape.circle),
                        ),*/
                        ],
                      ),
                    ),
                    Container(
                      height: 4.5,
                      width: 4.5,
                      decoration: const BoxDecoration(
                          color: Colors.black, shape: BoxShape.circle),
                    ),
                    Expanded(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          RichText(
                              text: TextSpan(children: [
                                TextSpan(
                                    text: 'Bull calf: ',
                                    style: figtreeRegular.copyWith(
                                        fontSize: 12,
                                        color: const Color(0xFF727272))),
                                TextSpan(
                                    text: state.responseFarmerProfile!.farmer!.cowBreedDetails![state.selectedBreedIndex!].bullCalfs.toString() ?? '01',
                                    style: figtreeMedium.copyWith(
                                        fontSize: 12, color: Colors.black)),
                              ])),
                        ],
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ) ,
      ],
    );
  }

  Widget dde(BuildContext context, ProfileCubitState state,String countryCode) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20.0),
      child: Stack(
        alignment: Alignment.center,
        children: [
          SizedBox(height: 200, width: screenWidth()),
          Container(
            height: 150,
            width: screenWidth(),
            decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(16),
                border: Border.all(color: ColorResources.grey)),
            child: Padding(
              padding: const EdgeInsets.fromLTRB(15.0, 16, 0, 10),
              child: Column(
                children: [
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Image.network(
                        state.responseFarmerProfile!.dairyDevelopMentExecutive!.image ?? '',
                        errorBuilder: (_, __, ___) =>
                            Image.asset(Images.sampleUser),
                      ),
                      15.horizontalSpace(),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(state.responseFarmerProfile!.dairyDevelopMentExecutive!.name!,
                              style: figtreeMedium.copyWith(
                                  fontSize: 16, color: Colors.black)),
                          4.verticalSpace(),
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                              const Icon(
                                Icons.call,
                                color: Colors.black,
                                size: 16,
                              ),
                              Text("${countryCode == ""? "":countryCode!=null?countryCode.toString():""}"
                                  " ${state.responseFarmerProfile!.dairyDevelopMentExecutive!.phone??''}"
                                   ,
                                  style: figtreeRegular.copyWith(
                                      fontSize: 12, color: Colors.black)),
                            ],
                          ),
                          4.verticalSpace(),
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                              const Icon(
                                Icons.location_on,
                                color: Colors.black,
                                size: 16,
                              ),
                              SizedBox(
                                width: MediaQuery.of(context).size.width * 0.6,
                                child: Text(
                                  state.responseFarmerProfile!.dairyDevelopMentExecutive!.address != null
                                      ? state.responseFarmerProfile!.dairyDevelopMentExecutive!.address!.address != null
                                      && state.responseFarmerProfile!.dairyDevelopMentExecutive!.address!.subCounty != null
                                      ? "${state.responseFarmerProfile!.dairyDevelopMentExecutive!.address!.subCounty} ${state.responseFarmerProfile!.dairyDevelopMentExecutive!.address!.address!}"
                                      : ''
                                      : '',
                                  style: figtreeRegular.copyWith(
                                    fontSize: 12,
                                    color: Colors.black,
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                ),
                              ),
                            ],
                          )
                        ],
                      )
                    ],
                  ),
                  const Padding(
                    padding: EdgeInsets.only(right: 15.0),
                    child: Divider(),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(right: 8.0),
                    child: Text(
                      'You may contact our Dairy Development Executive (DDE) for any assistance related to application processing.',
                      style: figtreeRegular.copyWith(fontSize: 12),
                      textAlign: TextAlign.center,
                    ),
                  )
                ],
              ),
            ),
          ),
          Positioned(
              top: 0,
              right: 10,
              child: Row(
                children: [
                  InkWell(
                    onTap: () {
                      callOnMobile(state.responseFarmerProfile!.dairyDevelopMentExecutive!.phone ??
                          '');
                    },
                      child: SvgPicture.asset(Images.callPrimary)),
                  6.horizontalSpace(),
                  whatsapp(state.responseFarmerProfile!.dairyDevelopMentExecutive!.phone ?? ''),
                  6.horizontalSpace(),
                ],
              )),
          Positioned(
            left: 0,
            top: -4,
            child: Text('DDE', style: figtreeMedium.copyWith(fontSize: 18)),
          )
        ],
      ),
    );
  }

  Widget farmDetails(ProfileCubitState state) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.fromLTRB(20, 20, 20, 10),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text('Farm Details', style: figtreeMedium.copyWith(fontSize: 18)),
              InkWell(
                  onTap: () {
                    const EditProfile(
                      section: 'farm',
                    ).navigate();
                  },
                  child: SvgPicture.asset(Images.profileEdit))
            ],
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0),
          child: Container(
            width: screenWidth(),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                color: Colors.white,
                border: Border.all(color: ColorResources.grey)),
            padding: const EdgeInsets.all(18.0),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('${state.responseFarmerProfile!.farmer!.farmSize} Acres',
                            style: figtreeSemiBold.copyWith(fontSize: 18)),
                        Text('Farm Area',
                            style: figtreeRegular.copyWith(fontSize: 12)),
                      ],
                    ),
                    10.horizontalSpace(),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('${state.responseFarmerProfile!.farmer!.dairyArea} Acres',
                            style: figtreeSemiBold.copyWith(fontSize: 18)),
                        Text('Dairy area',
                            style: figtreeRegular.copyWith(fontSize: 12)),
                      ],
                    ),
                    10.horizontalSpace(),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('${state.responseFarmerProfile!.farmer!.staffQuantity}',
                            style: figtreeSemiBold.copyWith(fontSize: 18)),
                        Text('Members',
                            style: figtreeRegular.copyWith(fontSize: 12)),
                      ],
                    ),
                  ],
                ),
                25.verticalSpace(),
                Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: const Color(0xFFE4FFE3).withOpacity(1),
                  ),
                  padding:
                      const EdgeInsets.symmetric(vertical: 12, horizontal: 9),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text('Managed by: ${state.responseFarmerProfile!.farmer!.managerName}',
                          style: figtreeMedium.copyWith(fontSize: 12)),
                      4.horizontalSpace(),
                      Container(
                        height: 5,
                        width: 5,
                        decoration: const BoxDecoration(
                            color: Colors.black, shape: BoxShape.circle),
                      ),
                      4.horizontalSpace(),
                      // Text('${state.responseFarmerProfile!.farmer!.managerPhone}',
                      Text("${countryCode == ""? "":countryCode!=null?countryCode.toString():""} ${state.responseFarmerProfile!.farmer!
                          .managerPhone}",
                          style: figtreeMedium.copyWith(fontSize: 12)),
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
      ],
    );
  }
}

class CustomIndicator extends StatelessWidget {
  const CustomIndicator(
      {super.key, required this.percentage, required this.width,required this.color,required this.color1,required this.color2,required this.barCircleColor});
  final int percentage;
  final double width;
  final Color? color;
  final Color? color1;
  final Color? color2;
  final Color? barCircleColor;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 30,
      width: width,
      child: Stack(
        alignment: Alignment.centerLeft,
        children: [
          Container(
            width: width,
            height: 5,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                gradient: LinearGradient(colors: [
                  color!,
                  color1!,
                  color2!
                ])),
          ),

          Positioned(
              left: percentage.toDouble(),
              child: Material(
                elevation: 4,
                color: Colors.transparent,
                shadowColor: const Color(0xFF000029),
                shape: const CircleBorder(),
                child: Container(
                  height: 22,
                  width: 22,
                  decoration: BoxDecoration(
                      color: barCircleColor!,
                      border: Border.all(color: Colors.white, width: 2),
                      shape: BoxShape.circle),
                ),
              ))
        ],
      ),
    );
  }
}
