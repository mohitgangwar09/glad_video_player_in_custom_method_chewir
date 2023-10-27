import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:glad/cubit/cowsandyieldDoneCubit/cowsandyielddonecubit.dart';
import 'package:glad/cubit/landing_page_cubit/landing_page_cubit.dart';
import 'package:glad/cubit/profile_cubit/profile_cubit.dart';
import 'package:glad/cubit/project_cubit/project_cubit.dart';
import 'package:glad/screen/custom_widget/custom_appbar.dart';
import 'package:glad/screen/custom_widget/custom_methods.dart';
import 'package:glad/screen/custom_widget/g_map.dart';
import 'package:glad/screen/dde_screen/dde_cow_and_yield_done.dart';
import 'package:glad/screen/dde_screen/farmer_personal_detail.dart';
import 'package:glad/screen/dde_screen/widget/all_project_farmer_widget.dart';
import 'package:glad/screen/farmer_screen/dashboard/milk_production_yield.dart';
import 'package:glad/screen/farmer_screen/profile/edit_address.dart';
import 'package:glad/screen/farmer_screen/profile/edit_kyc_documents.dart';
import 'package:glad/screen/farmer_screen/profile/farmer_profile.dart';
import 'package:glad/screen/farmer_screen/profile/kyc_update.dart';
import 'package:glad/screen/farmer_screen/profile/view_kyc_documents.dart';
import 'package:glad/utils/color_resources.dart';
import 'package:glad/utils/extension.dart';
import 'package:glad/utils/helper.dart';
import 'package:glad/utils/images.dart';
import 'package:glad/utils/styles.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:intl/intl.dart';

import '../farmer_screen/profile/improvement_area.dart';

class DdeFarmerDetail extends StatefulWidget {
  const DdeFarmerDetail({Key? key, required this.userId,required this.farmerId}) : super(key: key);
  final int userId,farmerId;

  @override
  State<DdeFarmerDetail> createState() => _DdeFarmerDetailState();
}

class _DdeFarmerDetailState extends State<DdeFarmerDetail> {

  GoogleMapController? mapController;
  double? lat,long;

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
          target: LatLng(double.parse(latitude.toString()), double.parse(longitude)),
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
    BlocProvider.of<ProfileCubit>(context)
        .getFarmerProfile(context, userId: widget.userId.toString());
    BlocProvider.of<ProjectCubit>(context).ddeProjectsWithFarmerIdApi(context, widget.farmerId.toString());
    getCountryCode();
    super.initState();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    mapController?.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: BlocBuilder<ProfileCubit, ProfileCubitState>(
          builder: (context, state) {
        if (state.status == ProfileStatus.submit) {
          return const Center(
              child: CircularProgressIndicator(
            color: ColorResources.maroon,
          ));
        } else if (state.responseFarmerProfile == null) {
          return "${state.responseFarmerProfile} Api Error".textMedium();
        }
        else{
          return Stack(
            children: [
              landingBackground(),
              Column(
                children: [
                  CustomAppBar(
                    context: context,
                    titleText1: "Farmer Details",
                    action: Padding(
                      padding: const EdgeInsets.only(right: 8.0),
                      child: InkWell(
                          onTap: () {
                            const PersonalDetail().navigate();
                          },
                          child: SvgPicture.asset(Images.profileEdit)),
                    ),
                    leading: Padding(
                      padding: const EdgeInsets.only(left: 8.0),
                      child: InkWell(
                          onTap: () {
                            pressBack();
                          },
                          child: SvgPicture.asset(Images.arrowBack)),
                    ),
                    centerTitle: true,
                  ),
                  Expanded(
                    child: SingleChildScrollView(
                      child: Column(
                        children: [
                          Container(
                            margin: const EdgeInsets.only(top: 31),
                            padding: const EdgeInsets.only(left: 20, right: 20),
                            height: 168,
                            child: Row(
                              children: [
                                ClipRRect(
                                    borderRadius: BorderRadius.circular(15),
                                    child: CachedNetworkImage(
                                      imageUrl: state.responseFarmerProfile!
                                          .farmer!.photo ?? '',
                                      width: 112,
                                      height: 150,
                                      fit: BoxFit.cover,
                                      errorWidget: (_, __, ___) => Image.asset(
                                        Images.profileDemo,
                                        width: 112,
                                        height: 150,
                                        fit: BoxFit.cover,
                                      ),
                                    )),
                                17.horizontalSpace(),
                                Expanded(
                                  child: Padding(
                                    padding: const EdgeInsets.only(top: 25.0),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        InkWell(
                                          onTap: state.responseFarmerProfile!.farmer!.kycStatus == 'not_available' ? () {
                                            KYCUpdate(farmerId: state.responseFarmerProfile!.farmer!.id!, userId: state.responseFarmerProfile!.farmer!.userId.toString()).navigate();
                                          } : state.responseFarmerProfile!.farmer!.kycStatus == 'pending' ? () {
                                            EditKYCDocuments(farmerDocuments: state.responseFarmerProfile!.farmer!.farmerDocuments!, farmerId: state.responseFarmerProfile!.farmer!.id!, userId: state.responseFarmerProfile!.farmer!.userId.toString()).navigate();
                                          } : state.responseFarmerProfile!.farmer!.kycStatus == 'verified' ? () {
                                            ViewKYCDocuments(farmerDocuments: state.responseFarmerProfile!.farmer!.farmerDocuments!).navigate();
                                          } : () {},
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.start,
                                            children: [
                                              state.responseFarmerProfile!.farmer!.kycStatus == 'not_available' || state.responseFarmerProfile!.farmer!.kycStatus == 'pending' ? SvgPicture.asset(Images.kycUnverified) : Container(
                                                  decoration: const BoxDecoration(color: Colors.green, shape: BoxShape.circle),
                                                  padding: const EdgeInsets.all(4),
                                                  child: const Icon(Icons.done, color: Colors.white, size: 16,)),
                                              4.horizontalSpace(),
                                              Text('KYC ${formatProjectStatus(state.responseFarmerProfile!.farmer!.kycStatus ?? '')}',
                                                  style: figtreeMedium.copyWith(
                                                      fontSize: 12)),
                                            ],
                                          ),
                                        ),
                                        10.verticalSpace(),
                                        Text(
                                            state.responseFarmerProfile!.farmer!
                                                    .name ??
                                                '',
                                            style: figtreeMedium.copyWith(
                                                fontSize: 17)),
                                        5.verticalSpace(),
                                        Row(
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
                                                  fontSize: 9,
                                                )),
                                          ],
                                        ),
                                        5.verticalSpace(),
                                        Text(
                                            state.responseFarmerProfile!.farmer!
                                                    .email ??
                                                '',
                                            style: figtreeRegular.copyWith(
                                              fontSize: 12,
                                            )),
                                      ],
                                    ),
                                  ),
                                ),
                                10.horizontalSpace(),
                                Column(
                                  children: [

                                    InkWell(
                                      onTap: () {
                                        callOnMobile(state.responseFarmerProfile!.farmer!.phone ??
                                            '');
                                      },
                                      child: SvgPicture.asset(
                                        Images.callPrimary,
                                        width: 37,
                                        height: 37,
                                      ),
                                    ),
                                    10.verticalSpace(),
                                    InkWell(
                                      onTap: () async{
                                        await launchWhatsApp(state.responseFarmerProfile!.farmer!.phone ??
                                            '');
                                      },
                                      child: SvgPicture.asset(
                                        Images.whatsapp,
                                        width: 37,
                                        height: 37,
                                      ),
                                    ),
                                  ],
                                )
                              ],
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(
                                left: 22.0, right: 25, top: 0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Row(
                                  children: [

                                    state.responseFarmerProfile!.farmer!.dateOfBirth!=null?
                                    (state.responseFarmerProfile!.farmer!.dateOfBirth == "0000-00-00"?'0 years old':'${getAge(DateTime.parse(state.responseFarmerProfile!.farmer!.dateOfBirth ?? ''))} old').textRegular(fontSize: 12):"0".textRegular(fontSize: 12),
                                    10.horizontalSpace(),
                                    const CircleAvatar(
                                      radius: 4,
                                      backgroundColor: Colors.black,
                                    ),
                                    10.horizontalSpace(),
                                    state.responseFarmerProfile!.farmer!.farmingExperience!=null?
                                    "${state.responseFarmerProfile!.farmer!.farmingExperience == "0000-00-00"? '0':getAge(DateTime.parse(state.responseFarmerProfile!.farmer!.farmingExperience.toString()))} experience".textRegular(fontSize: 12):"0".textRegular(fontSize: 12),
                                  ],
                                ),

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
                              ],
                            ),
                          ),
                          Padding(
                            padding:
                            const EdgeInsets.only(left: 22.0, right: 25),
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                state.responseFarmerProfile!.farmer!.address!=null?Expanded(
                                    child: (state.responseFarmerProfile!.farmer!.address!.address.toString())
                                        .textRegular(fontSize: 12)):const Expanded(child: Text('')),
                                state.responseFarmerProfile!.farmer!.ragRating.toString() == "satisfactory"?
                                "Satisfactory".textMedium(fontSize: 12):
                                state.responseFarmerProfile!.farmer!.ragRating.toString() == 'critical'?
                                "Critical".textMedium(fontSize: 12):
                                state.responseFarmerProfile!.farmer!.ragRating.toString() == 'average'?
                                "Average".textMedium(fontSize: 12):"".textMedium(),
                                23.horizontalSpace()
                              ],
                            ),
                          ),
                          Container(
                            margin: const EdgeInsets.only(
                                left: 20, right: 20, top: 28),
                            width: screenWidth(),
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(20),
                                color: Colors.white,
                                boxShadow: [
                                  BoxShadow(
                                      color: Colors.grey.withOpacity(0.2),
                                      blurRadius: 16.0,
                                      offset: const Offset(0, 5)),
                                ],
                                border: Border.all(color: ColorResources.grey)),
                            padding:
                            const EdgeInsets.fromLTRB(18.0, 18, 18, 10),
                            child: Column(
                              children: [
                                Row(
                                  mainAxisAlignment:
                                  MainAxisAlignment.spaceBetween,
                                  children: [
                                    Column(
                                      crossAxisAlignment:
                                      CrossAxisAlignment.start,
                                      children: [
                                        Text('${state.responseFarmerProfile!.farmer!.farmSize ?? 150} Acres',
                                            style: figtreeSemiBold.copyWith(
                                                fontSize: 18)),
                                        Text('Farm Area',
                                            style: figtreeRegular.copyWith(
                                                fontSize: 12)),
                                      ],
                                    ),
                                    10.horizontalSpace(),
                                    Column(
                                      crossAxisAlignment:
                                      CrossAxisAlignment.start,
                                      children: [
                                        Text('${state.responseFarmerProfile!.farmer!.dairyArea ?? 150} Acres',
                                            style: figtreeSemiBold.copyWith(
                                                fontSize: 18)),
                                        Text('Dairy area',
                                            style: figtreeRegular.copyWith(
                                                fontSize: 12)),
                                      ],
                                    ),
                                    10.horizontalSpace(),
                                    Column(
                                      crossAxisAlignment:
                                      CrossAxisAlignment.start,
                                      children: [
                                        Text('${state.responseFarmerProfile!.farmer!.staffQuantity ?? 5}',
                                            style: figtreeSemiBold.copyWith(
                                                fontSize: 18)),
                                        Text('Members',
                                            style: figtreeRegular.copyWith(
                                                fontSize: 12)),
                                      ],
                                    ),
                                  ],
                                ),
                                17.verticalSpace(),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text('Managed by: ${state.responseFarmerProfile!.farmer!.managerName ?? 'Moses Emanuel'}',
                                        style: figtreeMedium.copyWith(
                                            fontSize: 12,
                                            color: const Color(0xff727272))),
                                    10.horizontalSpace(),
                                    Container(
                                      height: 5,
                                      width: 5,
                                      decoration: const BoxDecoration(
                                          color: Colors.black,
                                          shape: BoxShape.circle),
                                    ),
                                    10.horizontalSpace(),
                                    Text("${countryCode == ""? "":countryCode!=null?countryCode.toString():""} ${state.responseFarmerProfile!.farmer!.managerPhone ?? ''}",
                                        style: figtreeMedium.copyWith(
                                            fontSize: 12,
                                            color: const Color(0xff727272))),
                                    30.verticalSpace()
                                  ],
                                )
                              ],
                            ),
                          ),
                          30.verticalSpace(),
                          state.responseFarmerProfile!.farmer!.milkCollectionCenter!=null?
                          milkSupplyCardDetails(context,state):const SizedBox.shrink(),
                          30.verticalSpace(),
                          cowsInTheFarm(state),
                          30.verticalSpace(),
                          projectList(),
                          30.verticalSpace(),
                          state.responseFarmerProfile!.farmer!.address!=null?
                          address(context,state):const SizedBox.shrink(),
                          topPerformingFarmer(),
                          25.verticalSpace(),
                          state.improvementAreaListResponse != null
                              ? state.improvementAreaListResponse!.data!.improvementAreaList!.isNotEmpty
                              ? facilitiesInTheFarm(state)
                              : const SizedBox.shrink()
                              : const SizedBox.shrink(),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
              // Positioned(
              //     bottom: 20,
              //     right: 20,
              //     left: 20,
              //     child: Container(
              //       padding: const EdgeInsets.only(left: 25),
              //       height: 75,
              //       decoration: boxDecoration(
              //           backgroundColor: ColorResources.primary,
              //           borderRadius: 40),
              //       child: Row(
              //         children: [
              //           Expanded(
              //             child: InkWell(
              //               onTap: () {
              //                 ImprovementAreas(farmerId: int.parse(state.responseFarmerProfile!.farmer!.id!.toString()),farmerData:state.responseFarmerProfile!.farmer!).navigate();
              //               },
              //               child: Column(
              //                 mainAxisAlignment: MainAxisAlignment.center,
              //                 crossAxisAlignment: CrossAxisAlignment.start,
              //                 children: [
              //                   "Improvement areas".textRegular(
              //                       fontSize: 19, color: Colors.white),
              //                   "Based on the survey done by our experts!"
              //                       .textRegular(
              //                       fontSize: 12, color: Colors.white)
              //                 ],
              //               ),
              //             ),
              //           ),
              //           const Padding(
              //             padding: EdgeInsets.only(right: 25),
              //             child: CircleAvatar(
              //               radius: 23,
              //               backgroundColor: Color(0xffFC5E60),
              //               child: Icon(Icons.arrow_forward_rounded),
              //             ),
              //           )
              //         ],
              //       ),
              //     )),
            ],
          );
        }
      }),
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
                  ImprovementArea(index: index, fromDDE: true, farmerId: int.parse(state.responseFarmerProfile!.farmer!.id!.toString()),).navigate();
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

  ///////////milkSupplyCardDetails/////////
  Widget milkSupplyCardDetails(context, ProfileCubitState state) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.fromLTRB(25, 0, 0, 0),
          child: Text(
            'Milk supply (last 6 months)',
            style: figtreeMedium.copyWith(fontSize: 18),
          ),
        ),
        10.verticalSpace(),
        InkWell(
          onTap: () {
            MilkProductionYield(type: 'milk_production', farmerId: state.responseFarmerProfile!.farmer!.userId.toString()).navigate();
          },
          child: Padding(
            padding: const EdgeInsets.fromLTRB(18, 0, 24, 0),
            child: Column(
              children: [
                Stack(
                  children: [
                    SizedBox(
                      height: 210,
                      child: Column(
                        children: [
                          Container(
                            height: 200,
                            decoration: BoxDecoration(boxShadow: [
                              BoxShadow(
                                  color: Colors.grey.withOpacity(.100),
                                  blurRadius: 15),
                            ]),
                            child: Card(
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(20)),
                              color: const Color(0xffFFB300),
                              child: Padding(
                                padding:
                                    const EdgeInsets.only(left: 24.0, right: 20),
                                child: Column(children: [
                                  28.verticalSpace(),
                                  Row(
                                    children: [
                                      Expanded(
                                        child: Text(
                                          '${state.responseFarmerProfile!.farmerTotalMilkProduction??''} Ltr',
                                          style:
                                              figtreeBold.copyWith(fontSize: 24),
                                        ),
                                      ),
                                      Expanded(
                                        child: Text(
                                          'UGX 75M',
                                          style:
                                              figtreeBold.copyWith(fontSize: 24),
                                        ),
                                      ),
                                      SvgPicture.asset(
                                        Images.menuIcon,
                                      )
                                    ],
                                  ),
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Expanded(
                                          child: "Total supply"
                                              .textMedium(fontSize: 16)),
                                      Expanded(
                                          child:
                                              "Worth".textMedium(fontSize: 16)),
                                      0.verticalSpace()
                                    ],
                                  ),
                                  28.verticalSpace(),
                                  Row(
                                    children: [
                                      Expanded(
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text(state.responseFarmerProfile!.farmer!.milkCollectionCenter!.name??'',
                                                style: figtreeMedium.copyWith(
                                                    fontSize: 16,
                                                    color: Colors.black)),
                                            4.verticalSpace(),
                                            Row(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.end,
                                              children: [
                                                const Icon(
                                                  Icons.call,
                                                  color: Colors.black,
                                                  size: 16,
                                                ),
                                                Text(/*"+22112 3232 3223",*/
                                                    "${countryCode == ""? "":countryCode!=null?countryCode.toString():""} ${state.responseFarmerProfile!.farmer!
                                                        .milkCollectionCenter!.phone??''}",
                                                    style:
                                                        figtreeRegular.copyWith(
                                                            fontSize: 12,
                                                            color: Colors.black)),
                                              ],
                                            ),
                                            4.verticalSpace(),
                                            Row(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.end,
                                              children: [
                                                const Icon(
                                                  Icons.location_on,
                                                  color: Colors.black,
                                                  size: 16,
                                                ),
                                                SizedBox(
                                                  width: screenWidth() * 0.5,
                                                  child: Text(
                                                    "Luwum St. Rwoozi, Kampala...",
                                                    style:
                                                        figtreeRegular.copyWith(
                                                      fontSize: 12,
                                                      color: Colors.black,
                                                      overflow:
                                                          TextOverflow.ellipsis,
                                                    ),
                                                  ),
                                                ),
                                              ],
                                            )
                                          ],
                                        ),
                                      ),
                                      CircleAvatar(
                                          radius: 27,
                                          backgroundColor: ColorResources.primary,
                                          child: "MCC".textBold(
                                              color: Colors.white, fontSize: 13)),
                                    ],
                                  ),
                                  28.verticalSpace(),
                                ]),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Positioned(
                      bottom: 0,
                      right: 10,
                      left: 10,
                      child: SvgPicture.asset(Images.cardImage),
                    )
                  ],
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget address(BuildContext context,ProfileCubitState state) {
    return Stack(
      children: [
        GMap(
          lat: double.parse(state.responseFarmerProfile!.farmer!.address!.latitude!=null?state.responseFarmerProfile!.farmer!.address!.latitude!.toString():'0'),
          lng: double.parse(state.responseFarmerProfile!.farmer!.address!.longitude!=null?state.responseFarmerProfile!.farmer!.address!.longitude!.toString():'0'),
          height: 350,
          onMapCreated: (GoogleMapController controller){
            if(state.responseFarmerProfile!.farmer!.address!.latitude!=null){
              _onMapCreated(controller,state.responseFarmerProfile!.farmer!.address!.latitude!.toString(),
                  state.responseFarmerProfile!.farmer!.address!.longitude!.toString());
            }else{
              _onMapCreated(controller,BlocProvider.of<LandingPageCubit>(context).state.currentPosition!.latitude.toString(),
                  BlocProvider.of<LandingPageCubit>(context).state.currentPosition!.longitude.toString());
            }
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
                          // "${state.responseFarmerProfile!.farmer!.address!.county!=null?state.responseFarmerProfile!.farmer!.address!.county!:""}"
                              " ${state.responseFarmerProfile!.farmer!.address!.subCounty!=null?state.responseFarmerProfile!.farmer!.address!.subCounty!:""}"
                              " ${state.responseFarmerProfile!.farmer!.address!.district!=null?state.responseFarmerProfile!.farmer!.address!.district!:""}"
                              " ${state.responseFarmerProfile!.farmer!.address!.address!=null?state.responseFarmerProfile!.farmer!.address!.address!:""}"
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
                EditAddress(userId: state.responseFarmerProfile!.farmer!.userId.toString()).navigate();
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
          padding: const EdgeInsets.fromLTRB(20.0, 0, 20, 0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Align(
                alignment: Alignment.centerLeft,
                child: Text('Cows in the farm',
                    style: figtreeMedium.copyWith(fontSize: 18)),
              ),
              InkWell(
                  onTap: () {
                    BlocProvider.of<CowsAndYieldDoneCubit>(context).emit(CowsAndCubitDoneState.initial());
                    CowsAndYieldsSumDone(userId:state.responseFarmerProfile!.farmer!.userId.toString(),farmerId:state.responseFarmerProfile!.farmer!.id.toString()).navigate();
                    // CowsAndYieldsSum(userId:state.responseFarmerProfile!.farmer!.userId.toString(),farmerId:state.responseFarmerProfile!.farmer!.id.toString()).navigate();
                  },
                  child: SvgPicture.asset(Images.profileEdit)),
            ],
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
               /* Wrap(
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
                  ],),*/
                // 20.verticalSpace(),
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
                                text: state.responseFarmerProfile!.farmer!.cowBreedDetails!.isNotEmpty?state.responseFarmerProfile!.farmer!.cowBreedDetails![state.selectedBreedIndex!].milkingCows!.toString():'0',
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
                            state.responseFarmerProfile!.farmer!.farmerMilkProduction![0].totalMilkProduction!=null?
                            TextSpan(
                              // text:
                              // '${900/
                              //     double.parse(DateTime(DateTime.parse(state.responseFarmerProfile!.farmer!.farmerMilkProduction![0].date ?? DateTime.now().toString()).year, DateTime.parse(state.responseFarmerProfile!.farmer!.farmerMilkProduction![0].date ?? DateTime.now().toString()).month, 0).day.toString())
                              //   /22}',
                                text: '${ double.parse('${state.responseFarmerProfile!.farmer!.farmerMilkProduction![0].totalMilkProduction!=null?
                                double.parse(state.responseFarmerProfile!.farmer!.farmerMilkProduction![0].totalMilkProduction!.toString())/
                                    double.parse(state.responseFarmerProfile!.farmer!.cowBreedDetails![0].milkingCows.toString().isNotEmpty?state.responseFarmerProfile!.farmer!.cowBreedDetails![0].milkingCows!.toString():"1")
                                    / double.parse(DateTime(int.parse(state.responseFarmerProfile!.farmer!.cowBreedDetails![0].year!), DateFormat('MMMM').parse(state.responseFarmerProfile!.farmer!.cowBreedDetails![0].month.toString()).month+1, 0).day.toString()):'0'}')
                                    .toStringAsFixed(2)
                                } Ltr/Day',
                                style: figtreeSemiBold.copyWith(
                                    fontSize: 14, color: Colors.black)):TextSpan(
                                text: '',
                                style: figtreeRegular.copyWith(
                                    fontSize: 14, color: const Color(0xFF727272))),
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
                        Text(state.responseFarmerProfile!.farmer!.cowBreedDetails!.isNotEmpty?state.responseFarmerProfile!.farmer!.cowBreedDetails![state.selectedBreedIndex!].herdSize!.toString():"0",
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
                        Text(state.responseFarmerProfile!.farmer!.cowBreedDetails!.isNotEmpty?state.responseFarmerProfile!.farmer!.cowBreedDetails![state.selectedBreedIndex!].dryCows!.toString():"0",
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
                        Text(state.responseFarmerProfile!.farmer!.cowBreedDetails!.isNotEmpty?state.responseFarmerProfile!.farmer!.cowBreedDetails![state.selectedBreedIndex!].heiferCows.toString():"0",
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
                                    text: state.responseFarmerProfile!.farmer!.cowBreedDetails!.isNotEmpty?state.responseFarmerProfile!.farmer!.cowBreedDetails![state.selectedBreedIndex!].sevenToTwelveMonthCows.toString():"0",
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
                                    text: state.responseFarmerProfile!.farmer!.cowBreedDetails!.isNotEmpty?state.responseFarmerProfile!.farmer!.cowBreedDetails![state.selectedBreedIndex!].sixMonthCow.toString():"0",
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
                                    text: state.responseFarmerProfile!.farmer!.cowBreedDetails!.isNotEmpty?state.responseFarmerProfile!.farmer!.cowBreedDetails![state.selectedBreedIndex!].bullCalfs.toString(): '0',
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

  Widget projectList(){
    return BlocBuilder<ProjectCubit, ProjectState>(
      builder: (context,state) {
        return Column(
          children: [

            Align(
              alignment: Alignment.centerLeft,
              child: Padding(
                padding: const EdgeInsets.fromLTRB(20.0, 0, 20, 0),
                child: Text('Projects',
                    style: figtreeMedium.copyWith(fontSize: 18)),
              ),
            ),

            SizedBox(
              height: 235,
              width: screenWidth(),
              child: customList(
                padding: const EdgeInsets.only(left: 10.0,right: 10),
                  axis: Axis.horizontal,
                  list: List.generate(state.responseDdeProject!.data!
                      .projectList!.length, (index) => null),
                  child: (int i) {

                    return SizedBox(
                      height: 200,
                      width: screenWidth()-30,
                      child: customProjectContainer(
                        marginTop: 13.0,
                          child: AllProjectFarmerWidget(
                              status: true,
                              projectStatus: formatProjectStatus(state.responseDdeProject!.data!
                                  .projectList![i].projectStatus ?? ''),
                              name: state.responseDdeProject!.data!
                                  .projectList![i].name ?? '',
                              category: state.responseDdeProject!.data!
                                  .projectList![i].farmerImprovementArea !=
                                  null ? state.responseDdeProject!.data!
                                  .projectList![i].farmerImprovementArea!
                                  .improvementArea!.name ?? '' : '',
                              description: state.responseDdeProject!.data!
                                  .projectList![i].description ?? '',
                              investment: state.responseDdeProject!.data!
                                  .projectList![i].investmentAmount ?? 0,
                              revenue: state.responseDdeProject!.data!
                                  .projectList![i].revenuePerYear ?? 0,
                              roi: state.responseDdeProject!.data!
                                  .projectList![i].roiPerYear ?? 0.0,
                              loan: state.responseDdeProject!.data!
                                  .projectList![i].loanAmount ?? 0,
                              emi: state.responseDdeProject!.data!
                                  .projectList![i].emiAmount ?? 0,
                              balance: 0,
                              farmerName: state.responseDdeProject!.data!
                                  .projectList![i].farmerMaster!= null ? state.responseDdeProject!.data!
                                  .projectList![i].farmerMaster!.name ?? '' : '',
                              farmerAddress:  state.responseDdeProject!.data!
                                  .projectList![i].farmerMaster!= null ? state.responseDdeProject!.data!
                                  .projectList![i].farmerMaster!.fAddress ??
                                  '' : '',
                              farmerImage:  state.responseDdeProject!.data!
                                  .projectList![i].farmerMaster!= null ? state.responseDdeProject!.data!
                                  .projectList![i].farmerMaster!.photo ??
                                  ''  : '',
                              farmerPhone:  state.responseDdeProject!.data!
                                  .projectList![i].farmerMaster!= null ? state.responseDdeProject!.data!
                                  .projectList![i].farmerMaster!.phone ??
                                  ''  : '',
                              projectPercent: 0,
                              projectId: state.responseDdeProject!.data!
                                  .projectList![i].id ?? 0,
                              farmerDetail: state.responseDdeProject!.data!
                                  .projectList![i].farmerMaster!

                          ),
                          width: screenWidth()),
                    );
                  }),
            ),
          ],
        );
      }
    );
  }

  Widget topPerformingFarmer() {
    return Padding(
      padding: const EdgeInsets.only(left: 20.0, top: 30, right: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          "Top performing farmers".textMedium(fontSize: 18),
          25.verticalSpace(),
          SizedBox(
            height: 350,
            child: customList(
              list: List.generate(4, (index) => ''),
                axis: Axis.horizontal,
                child: (int index) {
                  return Padding(
                    padding: const EdgeInsets.only(right: 20.0),
                    child: Stack(
                      children: [
                        Container(
                          margin: 30.marginTop(),
                          height: 310,
                          width: screenWidth() - 140,
                          decoration: boxDecoration(
                              borderRadius: 18,
                              backgroundColor: const Color(0xffF9F9F9)),
                        ),
                        Positioned(
                            left: 0,
                            right: 0,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                CircleAvatar(
                                    radius: 35,
                                    child: Image.asset(Images.sampleUser,
                                        fit: BoxFit.cover,
                                        width: 70,
                                        height: 70)),
                                20.verticalSpace(),
                                "Hurton Elizabeth".textMedium(
                                    color: Colors.black, fontSize: 16),
                                4.verticalSpace(),
                                "1234 NW Bobcat Lane, St".textRegular(
                                    color: const Color(0xff727272)),
                                22.verticalSpace(),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    RichText(
                                      text: TextSpan(
                                        text: 'Milking Cows: ',
                                        style: figtreeRegular.copyWith(
                                            color: const Color(0xff727272)),
                                        children: <TextSpan>[
                                          TextSpan(
                                              text: '30',
                                              style: figtreeSemiBold.copyWith(
                                                  color:
                                                      const Color(0xff23262A))),
                                        ],
                                      ),
                                    ),
                                    10.horizontalSpace(),
                                    const CircleAvatar(
                                      radius: 4,
                                      backgroundColor: Color(0xff23262A),
                                    ),
                                    10.horizontalSpace(),
                                    RichText(
                                      text: TextSpan(
                                        text: 'Yield: ',
                                        style: figtreeRegular.copyWith(
                                            color: const Color(0xff727272)),
                                        children: <TextSpan>[
                                          TextSpan(
                                              text: '15 LTR',
                                              style: figtreeSemiBold.copyWith(
                                                  color:
                                                      const Color(0xff23262A))),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                                23.verticalSpace(),
                                Stack(
                                  children: [
                                    CircleAvatar(
                                        radius: 25,
                                        child: Image.asset(Images.sampleUser,
                                            fit: BoxFit.cover,
                                            width: 70,
                                            height: 70)),
                                    Padding(
                                      padding:
                                          const EdgeInsets.only(left: 40.0),
                                      child: CircleAvatar(
                                          radius: 25,
                                          child: Image.asset(Images.sampleUser,
                                              fit: BoxFit.cover,
                                              width: 70,
                                              height: 70)),
                                    ),
                                    Padding(
                                      padding:
                                          const EdgeInsets.only(left: 80.0),
                                      child: CircleAvatar(
                                          radius: 25,
                                          child: Image.asset(Images.sampleUser,
                                              fit: BoxFit.cover,
                                              width: 70,
                                              height: 70)),
                                    ),
                                  ],
                                ),
                                Container(
                                  margin: 20.marginTop(),
                                  width: 110,
                                  height: 45,
                                  child: customButton("Compare",
                                      borderColor: 0xFF6A0030,
                                      color: 0xFFffffff,
                                      fontColor: 0xFF6A0030,
                                      onTap: () {}),
                                )
                              ],
                            )),
                      ],
                    ),
                  );
                }),
          ),
        ],
      ),
    );
  }
}
