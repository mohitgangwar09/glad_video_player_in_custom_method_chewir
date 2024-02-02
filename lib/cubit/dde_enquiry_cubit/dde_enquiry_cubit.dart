import 'dart:async';
import 'dart:io';

import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:glad/cubit/landing_page_cubit/landing_page_cubit.dart';
import 'package:glad/data/model/response_enquiry_detail.dart';
import 'package:glad/data/model/response_enquiry_model.dart';
import 'package:glad/data/repository/landing_page_repo.dart';
import 'package:glad/screen/custom_widget/custom_methods.dart';
import 'package:glad/utils/extension.dart';
import 'package:glad/utils/helper.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:url_launcher/url_launcher.dart';

part 'dde_enquiry_state.dart';

class DdeEnquiryCubit extends Cubit<DdeEnquiryState> {
  final SharedPreferences sharedPreferences;
  final LandingPageRepository apiRepository;
  Set<Marker> newMarker = {};
  DdeEnquiryCubit(
      {required this.apiRepository, required this.sharedPreferences}) : super(DdeEnquiryState.initial());

  void filterStatus(String status){
    emit(state.copyWith(enquiryStatus: status));
  }

  launchURL(String latitude,String longitude,context) async {

    String launchMap = "https://www.google.com/maps/dir/?api=1&origin=${BlocProvider.of<LandingPageCubit>(context).state.currentPosition!.latitude},${BlocProvider.of<LandingPageCubit>(context).state.currentPosition!.longitude}&destination=$latitude,$longitude";

    if (await canLaunchUrl(Uri.parse(launchMap))) {
      if(Platform.isIOS) {
        await launchUrl(Uri.parse(launchMap));
      } else {
        await launchUrl(Uri.parse(launchMap), mode: LaunchMode.externalApplication);
      }
    } else {
      throw 'Could not launch $launchMap';
    }
  }

  void onMapCreated(GoogleMapController controller,BuildContext context,String latitude,String longitude){
    Completer<GoogleMapController> controllers = Completer();
    newMarker.clear();
    // Future.delayed(const Duration(milliseconds: 20),(){
    var marker = Marker(
      markerId: const MarkerId('place_name'),
      position: LatLng(double.parse(latitude.toString()), double.parse(longitude.toString())),
    );

    newMarker.add(marker);
    controllers.complete(controller);
    emit(state.copyWith(mapController: controllers,markers: newMarker));}

  // enquiryListApi
  void enquiryListApi(context,String enquiryStatus) async {
    emit(state.copyWith(status: DdeEnquiryStatus.loading));
    // customDialog(widget: launchProgress());
    var response = await apiRepository.enquiryListApi(enquiryStatus.toString());
    if (response.status == 200) {
      // disposeProgress();
      emit(state.copyWith(status: DdeEnquiryStatus.success,
          responseEnquiryModel: response,enquiryStatus: enquiryStatus));
    } else {
      emit(state.copyWith(status: DdeEnquiryStatus.error));
      if(response.message!=null){
        showCustomToast(context, response.message.toString());
      }
    }
  }

  // enquiryDetailApi
  Future<void> enquiryDetailApi(context,String id) async {
    emit(state.copyWith(status: DdeEnquiryStatus.loading));
    var response = await apiRepository.enquiryDetailApi(id);
    if (response.status == 200) {
      emit(state.copyWith(status: DdeEnquiryStatus.success, responseEnquiryDetail: response));
    } else {
      emit(state.copyWith(status: DdeEnquiryStatus.error));
      if(response.message!=null){
        showCustomToast(context, response.message.toString());
      }
      // showCustomToast(context, response.message.toString());
    }
  }

  // enquiryClosedApi
  Future<void> enquiryClosedApi(context,String id) async {
    emit(state.copyWith(status: DdeEnquiryStatus.loading));
    customDialog(widget: launchProgress());
    var response = await apiRepository.enquiryClosedApi(id);
    if (response.status == 200) {
      showCustomToast(context, response.message.toString(), isSuccess: true);
      await pressBack();
      pressBack();
      pressBack();
      enquiryListApi(context, "Closed");
      emit(state.copyWith(status: DdeEnquiryStatus.success,
          markAsClosed: "closed",enquiryStatus: "Closed",pendingFromClose: 'pendingFromClose'));
    } else {
      pressBack();
      emit(state.copyWith(status: DdeEnquiryStatus.error));

      if(response.message!=null){
        showCustomToast(context, response.message.toString());
      }
      // showCustomToast(context, response.message.toString());
    }
  }


}