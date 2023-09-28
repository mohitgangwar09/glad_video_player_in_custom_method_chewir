part of 'project_cubit.dart';

enum ProjectStatus { initial, loading, success, error }

class ProjectState extends Equatable {

  final ProjectStatus status;
  final FarmerProjectModel? responseFarmerProject;

  const ProjectState({
    required this.status,
    required this.responseFarmerProject,
  });

  factory ProjectState.initial(){
    return const ProjectState(
      status: ProjectStatus.initial,
      responseFarmerProject: null,
    );
  }

  ProjectState copyWith({
    ProjectStatus? status,
    FarmerProjectModel? responseFarmerProject,
  }) {
    return ProjectState(
      status: status ?? this.status,
      responseFarmerProject: responseFarmerProject ?? this.responseFarmerProject,
    );
  }

  @override
  List<Object?> get props =>[
    status,
    responseFarmerProject,
  ];

}