import 'dart:io';

import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:glad/data/model/farmer_dashboard_model.dart';
import 'package:glad/data/repository/drawer_repo.dart';
import 'package:glad/screen/custom_widget/custom_methods.dart';
import 'package:glad/utils/extension.dart';
import 'package:glad/utils/helper.dart';
import 'package:shared_preferences/shared_preferences.dart';
part 'drawer_state.dart';

class DrawerCubit extends Cubit<DrawerState> {
  final SharedPreferences sharedPreferences;
  final DrawerRepository apiRepository;

  DrawerCubit(
      {required this.apiRepository, required this.sharedPreferences})
      : super(DrawerState.initial());

  ////// addTestimonials
  Future<void> addTestimonials(context,String image, String description, fileType) async{
    customDialog(widget: launchProgress());
    var response = await apiRepository.addTestimonialApi(File(image), fileType, description);
    if (response.status == 200) {

      disposeProgress();
      pressBack();
      showCustomToast(context, response.message.toString());
    }
    else {
      emit(state.copyWith(status: DrawerStatus.error));
      showCustomToast(context, response.message.toString());
    }
  }

}
