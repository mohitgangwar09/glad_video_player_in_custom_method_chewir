part of 'project_cubit.dart';

enum ProjectStatus { initial, loading, success, error }

class ProjectState extends Equatable {
  final ProjectStatus status;
  final FarmerProjectModel? responseFarmerProject;
  final DdeProjectModel? responseDdeProject;
  final FarmerProjectDetailModel? responseFarmerProjectDetail;
  final FarmerProjectMilestoneDetailModel? responseFarmerProjectMilestoneDetail;
  final List<DataResourceType>? responseResourceType;
  final List<DataResourceType>? responseResourceCapacityType;
  final List<DataResourceType>? responseProjectUOM;
  final List<DataMaterialType>? responseMaterialType;
  final String? selectResourceType, selectSizeCapacity,selectProjectUOM,selectMaterialName;
  final String? selectResourceTypeId, selectSizeCapacityId,selectProjectUOMId,selectMaterialId;
  final TextEditingController requiredQtyController,pricePerUnitController;

  const ProjectState({
    required this.status,
    required this.responseFarmerProject,
    required this.responseDdeProject,
    required this.responseFarmerProjectDetail,
    required this.responseFarmerProjectMilestoneDetail,
    required this.responseResourceType,
    required this.responseResourceCapacityType,
    required this.responseProjectUOM,
    required this.selectResourceType,
    required this.selectResourceTypeId,
    required this.selectSizeCapacity,
    required this.selectSizeCapacityId,
    required this.selectProjectUOMId,
    required this.selectProjectUOM,
    required this.requiredQtyController,
    required this.pricePerUnitController,
    required this.responseMaterialType,
    required this.selectMaterialName,
    required this.selectMaterialId,
  });

  factory ProjectState.initial() {
    return ProjectState(
      status: ProjectStatus.initial,
      responseFarmerProject: null,
      responseDdeProject: null,
      responseFarmerProjectDetail: null,
      responseFarmerProjectMilestoneDetail: null,
      responseResourceType: const [],
      responseResourceCapacityType: const [],
      responseMaterialType: const [],
      responseProjectUOM: const [],
      selectResourceType: 'Select Type',
      selectSizeCapacity: 'Select Size Capacity',
      selectProjectUOM: '',
      selectResourceTypeId: '',
      selectSizeCapacityId: '',
      selectProjectUOMId: '',
      selectMaterialId: '',
      selectMaterialName: 'Select Material Name',
      pricePerUnitController: TextEditingController(),
      requiredQtyController: TextEditingController(),
    );
  }

  ProjectState copyWith({
    ProjectStatus? status,
    FarmerProjectModel? responseFarmerProject,
    DdeProjectModel? responseDdeProject,
    FarmerProjectDetailModel? responseFarmerProjectDetail,
    FarmerProjectMilestoneDetailModel? responseFarmerProjectMilestoneDetail,
    List<DataResourceType>? responseResourceType,
    List<DataResourceType>? responseResourceCapacityType,
    List<DataResourceType>? responseProjectUOM,
    List<DataMaterialType>? responseMaterialType,
    String? selectResourceType, selectSizeCapacity,selectProjectUOM,selectMaterialId,
    String? selectResourceTypeId, selectSizeCapacityId,selectProjectUOMId,selectMaterialName,
    TextEditingController? requiredQtyController,pricePerUnitController
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
      responseResourceType:
      responseResourceType ??
          this.responseResourceType,
      responseResourceCapacityType:
      responseResourceCapacityType ??
          this.responseResourceCapacityType,
      responseProjectUOM:
      responseProjectUOM ??
          this.responseProjectUOM,
      responseMaterialType:
      responseMaterialType ??
          this.responseMaterialType,
      selectResourceType: selectResourceType ?? this.selectResourceType,
      selectSizeCapacity: selectSizeCapacity ?? this.selectSizeCapacity,
      selectProjectUOM: selectProjectUOM ?? this.selectProjectUOM,
      selectResourceTypeId: selectResourceTypeId ?? this.selectResourceTypeId,
      selectSizeCapacityId: selectSizeCapacityId ?? this.selectSizeCapacityId,
      selectProjectUOMId: selectProjectUOMId ?? this.selectProjectUOMId,
      requiredQtyController: requiredQtyController ?? this.requiredQtyController,
      pricePerUnitController: pricePerUnitController ?? this.pricePerUnitController,
      selectMaterialName: selectMaterialName ?? this.selectMaterialName,
      selectMaterialId: selectMaterialId ?? this.selectMaterialId,
    );
  }

  @override
  List<Object?> get props => [
        status,
        responseFarmerProject,
        responseDdeProject,
        responseFarmerProjectDetail,
        responseFarmerProjectMilestoneDetail,
    responseResourceType,
    responseResourceCapacityType,
    responseProjectUOM,
    selectResourceType,
    selectSizeCapacity,
    selectProjectUOM,
    selectResourceTypeId,
    selectSizeCapacityId,
    selectProjectUOMId,
    requiredQtyController,
    pricePerUnitController,
    responseMaterialType,
    selectMaterialName,
    selectMaterialId
      ];
}
