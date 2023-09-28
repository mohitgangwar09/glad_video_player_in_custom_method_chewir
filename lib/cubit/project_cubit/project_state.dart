part of 'project_cubit.dart';

enum ProjectStatus { initial, loading, success, error }

class ProjectState extends Equatable {
  final ProjectStatus status;
  final FarmerProjectModel? responseFarmerProject;
  final DdeProjectModel? responseDdeProject;
  final FarmerProjectDetailModel? responseFarmerProjectDetail;

  const ProjectState({
    required this.status,
    required this.responseFarmerProject,
    required this.responseDdeProject,
    required this.responseFarmerProjectDetail,
  });

  factory ProjectState.initial() {
    return const ProjectState(
      status: ProjectStatus.initial,
      responseFarmerProject: null,
      responseDdeProject: null,
      responseFarmerProjectDetail: null,
    );
  }

  ProjectState copyWith({
    ProjectStatus? status,
    FarmerProjectModel? responseFarmerProject,
    DdeProjectModel? responseDdeProject,
    FarmerProjectDetailModel? responseFarmerProjectDetail,
  }) {
    return ProjectState(
      status: status ?? this.status,
      responseFarmerProject:
          responseFarmerProject ?? this.responseFarmerProject,
      responseDdeProject: responseDdeProject ?? this.responseDdeProject,
      responseFarmerProjectDetail:
          responseFarmerProjectDetail ?? this.responseFarmerProjectDetail,
    );
  }

  @override
  List<Object?> get props => [
        status,
        responseFarmerProject,
        responseDdeProject,
        responseFarmerProjectDetail,
      ];
}
