import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:glad/cubit/dde_enquiry_cubit/dde_enquiry_cubit.dart';
import 'package:glad/cubit/landing_page_cubit/landing_page_cubit.dart';
import 'package:glad/cubit/profile_cubit/profile_cubit.dart';
import 'package:glad/screen/custom_widget/custom_appbar.dart';
import 'package:glad/screen/custom_widget/custom_methods.dart';
import 'package:glad/screen/custom_widget/g_map.dart';
import 'package:glad/screen/dde_screen/dde_farmer_filter.dart';
import 'package:glad/screen/dde_screen/project_widget.dart';
import 'package:glad/screen/farmer_screen/dashboard/dashboard_farmer.dart';
import 'package:glad/screen/farmer_screen/profile/farmer_profile.dart';
import 'package:glad/utils/color_resources.dart';
import 'package:glad/utils/extension.dart';
import 'package:glad/utils/helper.dart';
import 'package:glad/utils/images.dart';
import 'package:glad/utils/styles.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:intl/intl.dart';

class EnquiryDetailsScreen extends StatefulWidget {
  final String id;
  final String enquiryStatue;
  final String latitude,longitude,closedAt;
  const EnquiryDetailsScreen(
    this.id,
      this.enquiryStatue,
      this.latitude,
      this.longitude,this.closedAt, {
    Key? key,
  }) : super(key: key);

  @override
  State<EnquiryDetailsScreen> createState() => EnquiryDetailsScreenState();
}

class EnquiryDetailsScreenState extends State<EnquiryDetailsScreen> {
  TextEditingController commentController = TextEditingController();
  String? district;

  GoogleMapController? mapController;

  Map<MarkerId, Marker> markers = <MarkerId, Marker>{};

  String countryCode = "";

  void getCountryCode() async{
    String countryCodes = await BlocProvider.of<ProfileCubit>(context).getCountryCode();
    countryCode = countryCodes;
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    // WidgetsBinding.instance.addPostFrameCallback((timeStamp) {

      BlocProvider.of<DdeEnquiryCubit>(context)
          .enquiryDetailApi(context, widget.id);

      getCountryCode();
    // });
  }

  Future<void> _onMapCreated(GoogleMapController controller,String latitude,String longitude) async{
    // Future.delayed(const Duration(seconds: 2),(){

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
        infoWindow: const InfoWindow(
          title: '',
          snippet: '',
        ),
      );
      setState(() {
        markers[const MarkerId('place_name')] = marker;
      });
    // });
  }


  @override
  void dispose() {
    super.dispose();
    mapController!.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: ()async{
        pressBack();
        return true;
      },
      child: Scaffold(
        body: BlocBuilder<DdeEnquiryCubit, DdeEnquiryState>(
            builder: (context, state) {
          return Stack(
            children: [
              landingBackground(),
              Column(
                children: [
                  CustomAppBar(
                    context: context,
                    titleText1: 'Enquiry details',
                    titleText1Style:
                        figtreeMedium.copyWith(fontSize: 20, color: Colors.black),
                    centerTitle: true,
                    leading: InkWell(onTap: ()async{
                      pressBack();
                    },child: const SizedBox(child: Icon(Icons.arrow_back))),
                  ),
                  state.responseEnquiryDetail != null &&
                          state.responseEnquiryDetail!.data != null
                      ? Expanded(
                          child: SingleChildScrollView(
                          child: Column(
                            children: [
                              Stack(
                                children: [
                                  Column(
                                    children: [
                                      Padding(
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 20),
                                        child: SizedBox(
                                          height: 20,
                                          width: screenWidth(),
                                        ),
                                      ),
                                      Container(
                                        width: screenWidth(),
                                        padding: const EdgeInsets.symmetric(
                                            vertical: 30, horizontal: 20),
                                        decoration: const BoxDecoration(
                                            color: Color(0xFFE4FFE3),
                                            borderRadius: BorderRadius.only(
                                                topLeft: Radius.circular(50),
                                                topRight: Radius.circular(20),
                                                bottomRight: Radius.circular(50),
                                                bottomLeft: Radius.circular(20))),
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.spaceBetween,
                                              children: [
                                                Text(
                                                    state.responseEnquiryDetail!
                                                        .data!.enquiry!.name
                                                        .toString(),
                                                    style: figtreeMedium.copyWith(
                                                        fontSize: 18,
                                                        color: Colors.black)),
                                                Container(
                                                  padding:
                                                      const EdgeInsets.symmetric(
                                                          vertical: 7,
                                                          horizontal: 13),
                                                  decoration: boxDecoration(
                                                    backgroundColor:
                                                        const Color(0xFFFFF3F4),
                                                    borderRadius: 30,
                                                    borderColor:
                                                        ColorResources.maroon,
                                                  ),
                                                  child: Text(
                                                    state.responseEnquiryDetail!
                                                        .data!.enquiry!.status
                                                        .toString(),
                                                    textAlign: TextAlign.center,
                                                    style:
                                                        figtreeRegular.copyWith(
                                                            color: ColorResources
                                                                .maroon,
                                                            fontSize: 14),
                                                  ),
                                                )
                                              ],
                                            ),
                                            10.verticalSpace(),
                                            Row(
                                              children: [
                                                Text("${countryCode == ""? "":countryCode!=null?countryCode.toString():""} ${state.responseEnquiryDetail!.data!
                                                        .enquiry!.mobile}",
                                                    style: figtreeRegular.copyWith(
                                                        fontSize: 14,
                                                        color: Colors.black)),

                                                Text(state.responseEnquiryDetail!.data!
                                                    .enquiry!.supplierCode!=null?", ${state.responseEnquiryDetail!.data!
                                                    .enquiry!.supplierCode!}":"",
                                                    style: figtreeRegular.copyWith(
                                                        fontSize: 14,
                                                        color: Colors.black)),
                                              ],
                                            ),
                                            10.verticalSpace(),
                                            Row(
                                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                              children: [
                                                Text(
                                                  "Enquiry date: ${DateFormat('dd MMM, yyyy').format(DateTime.parse(state.responseEnquiryDetail!.data!.enquiry!.createdAt.toString()))}",
                                                  style: figtreeRegular.copyWith(
                                                      color: ColorResources.black,
                                                      fontSize: 14),
                                                ),

                                                state.enquiryStatus == "Closed"?
                                                state.pendingFromClose == ''?
                                                Text(
                                                  "Closed On: ${DateFormat('dd MMM, yyyy').format(DateTime.parse(widget.closedAt))}",
                                                  style: figtreeRegular.copyWith(
                                                      color: ColorResources.black,
                                                      fontSize: 14),
                                                ):const SizedBox(width: 0,height: 0,):const SizedBox.shrink(),
                                              ],
                                            ),
                                            30.verticalSpace(),
                                            Stack(
                                              children: [
                                                GMap(
                                                  lat: double.parse(widget.latitude),
                                                  lng: double.parse(widget.longitude),
                                                  height: 350,
                                                  onMapCreated: (GoogleMapController controller)async{
                                                    await _onMapCreated(controller,widget.latitude,
                                                        widget.longitude);
                                                  },
                                                  zoomGesturesEnabled: false,
                                                  zoomControlsEnabled: false,
                                                  myLocationEnabled: true,
                                                  myLocationButtonEnabled: false,
                                                  markers:  markers.values.toSet()
                                                ),
                                                Positioned(
                                                  bottom: 20,
                                                  left: 30,
                                                  right: 30,
                                                  child: Container(
                                                    height: 105,
                                                    decoration: BoxDecoration(
                                                        color: Colors.white,
                                                        borderRadius:
                                                            BorderRadius.circular(
                                                                16)),
                                                    child: Padding(
                                                      padding:
                                                          const EdgeInsets.all(
                                                              15),
                                                      child: Row(
                                                        children: [
                                                          Image.asset(Images
                                                              .sampleLivestock),
                                                          15.horizontalSpace(),
                                                          Column(
                                                            crossAxisAlignment:
                                                                CrossAxisAlignment
                                                                    .start,
                                                            mainAxisAlignment:
                                                                MainAxisAlignment
                                                                    .center,
                                                            children: [
                                                              Text('Address',
                                                                  style: figtreeMedium
                                                                      .copyWith(
                                                                          fontSize:
                                                                              16,
                                                                          color: Colors
                                                                              .black)),
                                                              4.verticalSpace(),
                                                              SizedBox(
                                                                width: MediaQuery.of(
                                                                            context)
                                                                        .size
                                                                        .width *
                                                                    0.38,
                                                                child: Text(
                                                                  state
                                                                              .responseEnquiryDetail!
                                                                              .data!
                                                                              .enquiry!
                                                                              .address !=
                                                                          null
                                                                      ? state
                                                                          .responseEnquiryDetail!
                                                                          .data!
                                                                          .enquiry!
                                                                          .address!
                                                                          .toString()
                                                                      : "",
                                                                  style:
                                                                      figtreeRegular
                                                                          .copyWith(
                                                                    fontSize: 14,
                                                                    color: Colors
                                                                        .black,
                                                                    overflow:
                                                                        TextOverflow
                                                                            .ellipsis,
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
                                                state.enquiryStatus.toString() == "Pending"?
                                                Positioned(
                                                  right: 10,
                                                  top: 10,
                                                  child: InkWell(
                                                      onTap: () {
                                                        context.read<DdeEnquiryCubit>().launchURL(state.responseEnquiryDetail!.data!.enquiry!.lat.toString(),state.responseEnquiryDetail!.data!.enquiry!.lat.toString(),context);
                                                      },
                                                      child: SvgPicture.asset(
                                                          Images.mapLocate)),
                                                ):const Visibility(visible: false,child: Text("")),
                                              ],
                                            ),
                                            30.verticalSpace(),
                                            'Farmer remarks'.textMedium(
                                                fontSize: 18,
                                                color: ColorResources.fieldGrey),
                                            10.verticalSpace(),
                                            state.responseEnquiryDetail!.data!
                                                        .enquiry!.comment !=
                                                    null
                                                ? state.responseEnquiryDetail!
                                                    .data!.enquiry!.comment
                                                    .toString()
                                                    .textMedium(
                                                        fontSize: 16,
                                                        color:
                                                            ColorResources.black)
                                                : "".textMedium()
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                  state.enquiryStatus == "Pending"?
                                  Positioned(
                                      top: 0,
                                      right: 10,
                                      child: Row(
                                        children: [
                                          InkWell(
                                              onTap: () async {
                                                await callOnMobile(state
                                                    .responseEnquiryDetail!
                                                    .data!
                                                    .enquiry!
                                                    .mobile
                                                    .toString());
                                              },
                                              child: SvgPicture.asset(
                                                  Images.callPrimary)),
                                          6.horizontalSpace(),
                                          InkWell(
                                              onTap: () async {
                                                await launchWhatsApp(state
                                                    .responseEnquiryDetail!
                                                    .data!
                                                    .enquiry!
                                                    .mobile
                                                    .toString());
                                              },
                                              child: SvgPicture.asset(
                                                  Images.whatsapp)),
                                          16.horizontalSpace(),
                                        ],
                                      )):Visibility(visible: false,child: "".textMedium()),
                                ],
                              ),
                              20.verticalSpace(),
                              state.responseEnquiryDetail!.data!.enquiry!
                                              .enquiryLog !=
                                          null &&
                                      state.responseEnquiryDetail!.data!.enquiry!
                                          .enquiryLog!.isNotEmpty
                                  ? customList(
                                      scrollPhysics:
                                          const NeverScrollableScrollPhysics(),
                                      list: state.responseEnquiryDetail!.data!
                                          .enquiry!.enquiryLog!,
                                      child: (index) {
                                        return state
                                                    .responseEnquiryDetail!
                                                    .data!
                                                    .enquiry!
                                                    .enquiryLog![index]
                                                    .commentedBy ==
                                                'guest-farmer'
                                            ? Padding(
                                                padding:
                                                    const EdgeInsets.symmetric(
                                                        horizontal: 20,
                                                        vertical: 10),
                                                child: Container(
                                                  width: screenWidth(),
                                                  padding:
                                                      const EdgeInsets.all(30),
                                                  decoration: BoxDecoration(
                                                      color:
                                                          const Color(0xFFFFF3F4),
                                                      border: Border.all(
                                                          color: const Color(
                                                              0xFFC788A5)),
                                                      borderRadius:
                                                          const BorderRadius.only(
                                                              topLeft:
                                                                  Radius.circular(
                                                                      30),
                                                              topRight:
                                                                  Radius.circular(
                                                                      30),
                                                              bottomRight:
                                                                  Radius.circular(
                                                                      30),
                                                              bottomLeft:
                                                                  Radius.circular(
                                                                      0))),
                                                  child: Column(
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment.start,
                                                    children: [
                                                      Text(
                                                          '${state.responseEnquiryDetail!.data!.enquiry!.name} (Farmer)',
                                                          style: figtreeMedium
                                                              .copyWith(
                                                                  fontSize: 20,
                                                                  color: Colors
                                                                      .black)),
                                                      10.verticalSpace(),

                                                      state
                                                          .responseEnquiryDetail!
                                                          .data!
                                                          .enquiry!
                                                          .enquiryLog![index]
                                                          .type == 'text'?
                                                      Text(
                                                          state
                                                              .responseEnquiryDetail!
                                                              .data!
                                                              .enquiry!
                                                              .enquiryLog![
                                                          index]
                                                              .comments !=
                                                              null
                                                              ? state
                                                              .responseEnquiryDetail!
                                                              .data!
                                                              .enquiry!
                                                              .enquiryLog![
                                                          index]
                                                              .comments!
                                                              : "",
                                                          style: figtreeMedium
                                                              .copyWith(
                                                              fontSize: 16,
                                                              color: Colors
                                                                  .black)):
                                                      networkImage(text: state
                                                          .responseEnquiryDetail!
                                                          .data!
                                                          .enquiry!
                                                          .enquiryLog![index]
                                                          .attachment!,height: 220,width: screenWidth()),
                                                      10.verticalSpace(),
                                                      DateFormat('dd MMM, yyyy hh:mm a')
                                                          .format(DateTime.parse(state
                                                              .responseEnquiryDetail!
                                                              .data!
                                                              .enquiry!.enquiryLog![index].createdAt
                                                              .toString()))
                                                          .textRegular(
                                                              color:
                                                                  ColorResources
                                                                      .fieldGrey,
                                                              fontSize: 14)
                                                    ],
                                                  ),
                                                ),
                                              )
                                            :
                                        Padding(
                                                padding:
                                                    const EdgeInsets.symmetric(
                                                        horizontal: 20,
                                                        vertical: 10),
                                                child: Container(
                                                  width: screenWidth(),
                                                  padding:
                                                      const EdgeInsets.all(30),
                                                  decoration: BoxDecoration(
                                                      color: Colors.white,
                                                      border: Border.all(
                                                          color: const Color(
                                                              0xFF999999)),
                                                      borderRadius:
                                                          const BorderRadius.only(
                                                              topLeft:
                                                                  Radius.circular(
                                                                      30),
                                                              topRight:
                                                                  Radius.circular(
                                                                      30),
                                                              bottomLeft:
                                                                  Radius.circular(
                                                                      30),
                                                              bottomRight:
                                                                  Radius.circular(
                                                                      0))),
                                                  child: Column(
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment.start,
                                                    children: [
                                                      state
                                                          .responseEnquiryDetail!
                                                          .data!
                                                          .enquiry!
                                                          .enquiryLog![index]
                                                          .type == 'text'?
                                                      Text(
                                                          state
                                                              .responseEnquiryDetail!
                                                              .data!
                                                              .enquiry!
                                                              .enquiryLog![
                                                          index]
                                                              .comments !=
                                                              null
                                                              ? state
                                                              .responseEnquiryDetail!
                                                              .data!
                                                              .enquiry!
                                                              .enquiryLog![
                                                          index]
                                                              .comments!
                                                              : "",
                                                          style: figtreeMedium
                                                              .copyWith(
                                                              fontSize: 16,
                                                              color: Colors
                                                                  .black)):
                                                      InkWell(
                                                        onTap: (){

                                                        },
                                                        child: networkImage(text: state
                                                            .responseEnquiryDetail!
                                                            .data!
                                                            .enquiry!
                                                            .enquiryLog![index]
                                                            .attachment!,height: 220,width: screenWidth()),
                                                      ),
                                                      10.verticalSpace(),
                                                      DateFormat('dd MMM, yyyy hh:mm a')
                                                          .format(DateTime.parse(state
                                                              .responseEnquiryDetail!
                                                              .data!
                                                              .enquiry!.enquiryLog![index].createdAt
                                                              .toString()))
                                                          .textRegular(
                                                              color:
                                                                  ColorResources
                                                                      .fieldGrey,
                                                              fontSize: 14)
                                                    ],
                                                  ),
                                                ),
                                              );
                                      })
                                  : const SizedBox(
                                      width: 0,
                                      height: 0,
                                    ),

                              state.responseEnquiryDetail!.data!.enquiry!.status == "pending"?
                              state.markAsClosed == ""?
                              Padding(
                                padding: const EdgeInsets.all(15.0),
                                child: InkWell(
                                  onTap: (){
                                    customDialog(
                                      widget: Center(
                                        child: Material(
                                          borderRadius: BorderRadius.circular(15),
                                          child: Container(
                                            height: 135,
                                            width: screenWidth()-30,
                                            decoration: BoxDecoration(
                                              borderRadius: BorderRadius.circular(15),
                                            ),
                                            child: Column(
                                              mainAxisAlignment: MainAxisAlignment.center,
                                              children: [

                                                "Are you want to close?".textMedium(
                                                  fontSize: 19,
                                                  color: Colors.black
                                                ),

                                                20.verticalSpace(),

                                                Row(
                                                  children: [

                                                    20.horizontalSpace(),

                                                    Expanded(
                                                      child: customButton("No",
                                                          borderColor: 0xFF6A0030,
                                                          color: 0xFFffffff,onTap: (){
                                                        pressBack();
                                                      }),
                                                    ),

                                                    20.horizontalSpace(),

                                                    Expanded(
                                                      child: customButton("Yes",fontColor: 0xFFffffff, onTap: (){
                                                        BlocProvider.of<DdeEnquiryCubit>(context).enquiryClosedApi(context, widget.id.toString());
                                                      }),
                                                    ),

                                                    20.horizontalSpace(),

                                                  ],
                                                ),

                                              ],
                                            ),
                                          ),
                                        ),
                                      )
                                    );
                                  },
                                  child: Row(
                                    children: [
                                      checkBox(onChanged: (v){
                                        BlocProvider.of<DdeEnquiryCubit>(context).enquiryClosedApi(context, widget.id.toString());
                                      }),
                                      Text("Mark as Closed",style: figtreeBold.copyWith(
                                      ),)
                                    ],
                                  ),
                                ),
                              ):const SizedBox(width: 0,height: 0,):Padding(
                                padding: const EdgeInsets.all(15.0),
                                child: Row(
                                  children: [
                                    checkBox(value: true),
                                    Text("Closed",style: figtreeBold.copyWith(
                                    ),)
                                  ],
                                ),
                              ),

                              20.verticalSpace()
                            ],
                          ),
                        ))
                      : const Expanded(
                          child: SizedBox(
                          width: 0,
                          height: 0,
                        )),
                  state.responseEnquiryDetail!.data != null &&
                          state.responseEnquiryDetail!.data!.enquiry!.status
                                  .toString() ==
                              "pending"
                      ? state.markAsClosed == ""?Container(
                          height: AppBar().preferredSize.height * 1.5,
                          width: screenWidth(),
                          padding: const EdgeInsets.only(left: 16,right: 4),
                          decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: const BorderRadius.only(
                                  topLeft: Radius.circular(24),
                                  topRight: Radius.circular(24)),
                              border: Border.all(color: ColorResources.grey)),
                          child: Row(
                            children: [
                              Expanded(
                                child: TextField(
                                  controller: commentController,
                                  maxLines: 3,
                                  minLines: 1,
                                  decoration: const InputDecoration(
                                      border: InputBorder.none,
                                      focusedBorder: InputBorder.none,
                                      enabledBorder: InputBorder.none,
                                      hintText: 'Followup remarks...'),
                                  onSubmitted: (value) {
                                    if (value.isNotEmpty) {
                                      context
                                          .read<LandingPageCubit>()
                                          .addFollowUpRemark(context, true, value,
                                              enquiryId: widget.id.toString(),type: 'text');
                                      commentController.clear();
                                    }
                                  },
                                ),
                              ),

                              InkWell(
                                onTap: ()async{
                                  var image =  imgFromGallery();
                                  image.then((value) async{
                                    context
                                        .read<LandingPageCubit>()
                                        .addFollowUpRemark(context, true, value,
                                        enquiryId: widget.id.toString(),type: 'image');
                                  });
                                },
                                child: SvgPicture.asset(
                                  Images.attachment,
                                  colorFilter: const ColorFilter.mode(
                                      ColorResources.fieldGrey, BlendMode.srcIn),
                                ),
                              ),
                              10.horizontalSpace(),
                              InkWell(
                                onTap: ()async{
                                  var image = imgFromCamera();
                                  image.then((value) async{
                                    context
                                        .read<LandingPageCubit>()
                                        .addFollowUpRemark(context, true, value,
                                        enquiryId: widget.id.toString(),type: 'image');
                                  });
                                },
                                child: SvgPicture.asset(
                                  Images.camera,
                                  colorFilter: const ColorFilter.mode(
                                      ColorResources.fieldGrey, BlendMode.srcIn),
                                ),
                              ),
                              // 10.horizontalSpace(),
                              IconButton(onPressed: (){
                                if(commentController.text.isNotEmpty){
                                  context
                                      .read<LandingPageCubit>()
                                      .addFollowUpRemark(context, true, commentController.text,
                                      enquiryId: widget.id.toString(),type: 'text');
                                  commentController.clear();
                                }
                              },icon: const Icon(Icons.send,color: Colors.grey, size: 31,))
                            ],
                          ),
                        ):
                  const SizedBox(
                    width: 0,
                    height: 0,)
                      : const SizedBox(
                          width: 0,
                          height: 0,
                        )
                ],
              ),
            ],
          );
        }),
      ),
    );
  }
}
