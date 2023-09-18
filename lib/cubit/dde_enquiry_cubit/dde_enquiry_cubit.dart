import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:glad/data/model/response_enquiry_detail.dart';
import 'package:glad/data/model/response_enquiry_model.dart';
import 'package:glad/data/repository/landing_page_repo.dart';
import 'package:glad/screen/custom_widget/custom_methods.dart';
import 'package:glad/screen/farmer_screen/thankyou_screen.dart';
import 'package:glad/utils/extension.dart';
import 'package:glad/utils/helper.dart';
import 'package:shared_preferences/shared_preferences.dart';

part 'dde_enquiry_state.dart';

class DdeEnquiryCubit extends Cubit<DdeEnquiryState> {
  final SharedPreferences sharedPreferences;
  final LandingPageRepository apiRepository;

  DdeEnquiryCubit(
      {required this.apiRepository, required this.sharedPreferences}) : super(DdeEnquiryState.initial());

  // enquiryListApi
  void enquiryListApi(context) async {
    emit(state.copyWith(status: DdeEnquiryStatus.loading));
    customDialog(widget: launchProgress());
    var response = await apiRepository.enquiryListApi(state.enquiryStatus.toString());
    if (response.status == 200) {
      disposeProgress();
      emit(state.copyWith(status: DdeEnquiryStatus.success, responseEnquiryModel: response));
    } else {
      emit(state.copyWith(status: DdeEnquiryStatus.error));
      showCustomToast(context, response.message.toString());
    }
  }

  // enquiryDetailApi
  void enquiryDetailApi(context) async {
    emit(state.copyWith(status: DdeEnquiryStatus.loading));
    var response = await apiRepository.enquiryDetailApi(state.enquiryStatus.toString());
    if (response.status == 200) {
      emit(state.copyWith(status: DdeEnquiryStatus.success, responseEnquiryDetail: response));
    } else {
      emit(state.copyWith(status: DdeEnquiryStatus.error));
      showCustomToast(context, response.message.toString());
    }
  }


}