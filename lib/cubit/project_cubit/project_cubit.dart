import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:glad/data/model/dde_project_model.dart';
import 'package:glad/data/model/farmer_project_detail_model.dart';
import 'package:glad/data/model/farmer_project_model.dart';
import 'package:glad/data/repository/project_repo.dart';
import 'package:glad/utils/extension.dart';
import 'package:shared_preferences/shared_preferences.dart';

part 'project_state.dart';

class ProjectCubit extends Cubit<ProjectState> {
  final SharedPreferences sharedPreferences;
  final ProjectRepository apiRepository;

  ProjectCubit(
      {required this.apiRepository, required this.sharedPreferences})
      : super(ProjectState.initial());

  // farmerProjectsApi
  void farmerProjectsApi(context, String projectStatus, bool showLoader) async {
    if (showLoader) {
      emit(state.copyWith(status: ProjectStatus.loading));
    }
    // customDialog(widget: launchProgress());
    var response = await apiRepository.getFarmerProjectsApi(projectStatus);
    if (response.status == 200) {
      // disposeProgress();
      emit(state.copyWith(responseFarmerProject: response));
    } else {
      emit(state.copyWith(status: ProjectStatus.error));
      showCustomToast(context, response.message.toString());
    }
  }

  // farmerProjectsApi
  void ddeProjectsApi(context, String projectStatus, bool showLoader) async {
    if (showLoader) {
      emit(state.copyWith(status: ProjectStatus.loading));
    }
    // customDialog(widget: launchProgress());
    var response = await apiRepository.getDdeProjectsApi(projectStatus);
    if (response.status == 200) {
      // disposeProgress();
      emit(state.copyWith(responseDdeProject: response));
    } else {
      emit(state.copyWith(status: ProjectStatus.error));
      showCustomToast(context, response.message.toString());
    }
  }

  void farmerProjectDetailApi(context, int projectId) async {
    emit(state.copyWith(status: ProjectStatus.loading));
    var response = await apiRepository.getFarmerProjectDetailApi(projectId);
    if (response.status == 200) {
      emit(state.copyWith(status: ProjectStatus.success, responseFarmerProjectDetail: response));
    } else {
      emit(state.copyWith(status: ProjectStatus.error));
      showCustomToast(context, response.message.toString());
    }
  }

}
