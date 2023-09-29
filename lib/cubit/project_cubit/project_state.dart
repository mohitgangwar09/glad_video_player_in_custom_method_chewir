part of 'project_cubit.dart';

enum ProjectStatus { initial, loading, success, error }

class ProjectState extends Equatable {
  final ProjectStatus status;
  final FarmerProjectModel? responseFarmerProject;
  final DdeProjectModel? responseDdeProject;
  final FarmerProjectDetailModel? responseFarmerProjectDetail;
  final FarmerProjectMilestoneDetailModel? responseFarmerProjectMilestoneDetail;

  const ProjectState({
    required this.status,
    required this.responseFarmerProject,
    required this.responseDdeProject,
    required this.responseFarmerProjectDetail,
    required this.responseFarmerProjectMilestoneDetail,
  });

  factory ProjectState.initial() {
    return const ProjectState(
      status: ProjectStatus.initial,
      responseFarmerProject: null,
      responseDdeProject: null,
      responseFarmerProjectDetail: null,
      responseFarmerProjectMilestoneDetail: null,
    );
  }

  ProjectState copyWith({
    ProjectStatus? status,
    FarmerProjectModel? responseFarmerProject,
    DdeProjectModel? responseDdeProject,
    FarmerProjectDetailModel? responseFarmerProjectDetail,
    FarmerProjectMilestoneDetailModel? responseFarmerProjectMilestoneDetail,
  }) {
    return ProjectState(
      status: status ?? this.status,
      responseFarmerProject:
          responseFarmerProject ?? this.responseFarmerProject,
      responseDdeProject: responseDdeProject ?? this.responseDdeProject,
      responseFarmerProjectDetail:
          responseFarmerProjectDetail ?? this.responseFarmerProjectDetail,
      responseFarmerProjectMilestoneDetail:
          responseFarmerProjectMilestoneDetail ??
              this.responseFarmerProjectMilestoneDetail,
    );
  }

  @override
  List<Object?> get props => [
        status,
        responseFarmerProject,
        responseDdeProject,
        responseFarmerProjectDetail,
        responseFarmerProjectMilestoneDetail,
      ];
}
