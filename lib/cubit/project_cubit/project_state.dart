part of 'project_cubit.dart';

enum ProjectStatus { initial, loading, success, error }

class ProjectState extends Equatable {
  final ProjectStatus status;
  final FarmerProjectModel? responseFarmerProject;
  final DdeProjectModel? responseDdeProject;
  final SupplierProjectModel? responseSupplierProject;
  final dde.FarmerProjectDetailModel? responseFarmerProjectDetail;
  final FarmerProjectMilestoneDetailModel? responseFarmerProjectMilestoneDetail;
  final List<DataResourceType>? responseResourceType;
  final List<DataResourceType>? filterResourceType;
  final List<DataCapacityList>? responseResourceCapacityType;
  final List<DataCapacityList>? filterResourceCapacityType;
  final List<DataResourceType>? responseProjectUOM;
  final List<DataResourceName>? responseMaterialType;
  final List<DataResourceName>? filterMaterialType;
  final List<DataMileStoneName>? responseMilestoneName;
  final List<DataMileStoneName>? filterMileStone;
  final ResponseAccountStatement? responseAccountStatement;
  final ResponseImprovementAreaFilterList? responseImprovementAreaFilterList;
  final String? selectResourceType, selectSizeCapacity,selectProjectUOM,selectMaterialName,primaryId;
  final String? selectResourceTypeId, selectSizeCapacityId,selectProjectUOMId,selectMaterialId,userIdForOtpValidate;
  final TextEditingController requiredQtyController,pricePerUnitController,valueController;
  final TextEditingController milestoneTitle,milestoneDescription,milestoneDuration;
  final TextEditingController materialNameController,resourceTypeController,resourceCapacityController,uomController;
  final String? projectId;
  final String? selectedFilterMCCApplication,statusLoan,roiFilter,filterImprovementAreaName;
  final dynamic paidAmount,dueAmount,pendingAmount;
  final TextEditingController revenueFromController,revenueToController,investmentFromController,
      investmentUpToController,roiFromController,roiUpToController,loanAmountFromController,loanAmountUpToController;


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
    required this.valueController,
    required this.responseMaterialType,
    required this.selectMaterialName,
    required this.selectMaterialId,
    required this.primaryId,
    required this.userIdForOtpValidate,
    required this.milestoneTitle,
    required this.milestoneDescription,
    required this.milestoneDuration,
    required this.responseMilestoneName,
    required this.filterMileStone,
    required this.projectId,
    required this.filterMaterialType,
    required this.filterResourceCapacityType,
    required this.filterResourceType,
    required this.materialNameController,
    required this.resourceTypeController,
    required this.resourceCapacityController,
    required this.uomController,
    required this.responseAccountStatement,
    required this.responseSupplierProject,
    required this.selectedFilterMCCApplication,
    required this.paidAmount,
    required this.pendingAmount,
    required this.dueAmount,
    required this.statusLoan,
    required this.roiFilter,
    required this.revenueFromController,
    required this.revenueToController,
    required this.investmentFromController,
    required this.investmentUpToController,
    required this.roiFromController,
    required this.roiUpToController,
    required this.loanAmountFromController,
    required this.loanAmountUpToController,
    required this.responseImprovementAreaFilterList,
    required this.filterImprovementAreaName,
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
      responseMilestoneName: const [],
      filterMileStone: const [],
      filterResourceCapacityType: const [],
      filterResourceType: const [],
      filterMaterialType: const [],
      selectResourceType: '',
      // selectResourceType: 'Select Type',
      selectSizeCapacity: '',
      // selectSizeCapacity: 'Select Size Capacity',
      selectProjectUOM: '',
      selectResourceTypeId: '',
      selectSizeCapacityId: '',
      selectProjectUOMId: '',
      selectMaterialId: '',
      selectMaterialName: '',
      // selectMaterialName: 'Select Material Name',
      pricePerUnitController: TextEditingController(),
      requiredQtyController: TextEditingController(),
      valueController: TextEditingController(),
      milestoneTitle: TextEditingController(),
      milestoneDuration: TextEditingController(),
      milestoneDescription: TextEditingController(),
      materialNameController: TextEditingController(),
      resourceTypeController: TextEditingController(),
      resourceCapacityController: TextEditingController(),
      uomController: TextEditingController(),
      revenueFromController: TextEditingController(),
      revenueToController: TextEditingController(),
      investmentFromController: TextEditingController(),
      investmentUpToController: TextEditingController(),
      roiFromController: TextEditingController(),
      roiUpToController: TextEditingController(),
      loanAmountFromController: TextEditingController(),
      loanAmountUpToController: TextEditingController(),
      primaryId: '',
      userIdForOtpValidate: '',
      projectId: '',
      selectedFilterMCCApplication: 'pending',
      responseSupplierProject: null,
      responseAccountStatement: null,
      paidAmount: null,
      dueAmount: null,
      pendingAmount: null,
      statusLoan: null,
      roiFilter: '',
      responseImprovementAreaFilterList: null,
      filterImprovementAreaName: ''
    );
  }

  ProjectState copyWith({
    ProjectStatus? status,
    FarmerProjectModel? responseFarmerProject,
    DdeProjectModel? responseDdeProject,
    dde.FarmerProjectDetailModel? responseFarmerProjectDetail,
    FarmerProjectMilestoneDetailModel? responseFarmerProjectMilestoneDetail,
    List<DataResourceType>? responseResourceType,
    List<DataResourceType>? filterResourceType,
    List<DataCapacityList>? responseResourceCapacityType,
    List<DataCapacityList>? filterResourceCapacityType,
    List<DataResourceType>? responseProjectUOM,
    List<DataResourceName>? responseMaterialType,
    List<DataResourceName>? filterMaterialType,
    List<DataMileStoneName>? responseMilestoneName,
    List<DataMileStoneName>? filterMileStone,
    ResponseAccountStatement? responseAccountStatement,
    String? selectResourceType, selectSizeCapacity,selectProjectUOM,selectMaterialId,primaryId,userIdForOtpValidate,
    String? selectResourceTypeId, selectSizeCapacityId,selectProjectUOMId,selectMaterialName,
    TextEditingController? requiredQtyController,pricePerUnitController,valueController,
    TextEditingController? milestoneTitle,mile,milestoneDuration,milestoneDescription,uomController,
    TextEditingController? materialNameController,resourceTypeController,resourceCapacityController,
    String? projectId, selectedFilterMCCApplication,
    SupplierProjectModel? responseSupplierProject,
    dynamic paidAmount,dueAmount,pendingAmount,
    String? statusLoan,roiFilter,filterImprovementAreaName,
    TextEditingController? revenueFromController,revenueToController,investmentFromController,
    investmentUpToController,roiFromController,roiUpToController,loanAmountFromController,loanAmountUpToController,
    ResponseImprovementAreaFilterList? responseImprovementAreaFilterList,
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
      primaryId: primaryId ?? this.primaryId,
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
      valueController: valueController ?? this.valueController,
      userIdForOtpValidate: userIdForOtpValidate ?? this.userIdForOtpValidate,
      milestoneTitle: milestoneTitle ?? this.milestoneTitle,
      milestoneDuration: milestoneDuration ?? this.milestoneDuration,
      milestoneDescription: milestoneDescription ?? this.milestoneDescription,
      filterMileStone: filterMileStone ?? this.filterMileStone,
      projectId: projectId ?? this.projectId,
      responseImprovementAreaFilterList: responseImprovementAreaFilterList ?? this.responseImprovementAreaFilterList,
      responseMilestoneName: responseMilestoneName ?? this.responseMilestoneName,
      filterResourceType: filterResourceType ?? this.filterResourceType,
      filterMaterialType: filterMaterialType ?? this.filterMaterialType,
      filterResourceCapacityType: filterResourceCapacityType ?? this.filterResourceCapacityType,
      materialNameController: materialNameController ?? this.materialNameController,
      resourceTypeController: resourceTypeController ?? this.resourceTypeController,
      resourceCapacityController: resourceCapacityController ?? this.resourceCapacityController,
      uomController: uomController ?? this.uomController,
      revenueToController: revenueToController ?? this.revenueToController,
      revenueFromController: revenueFromController ?? this.revenueFromController,
      investmentFromController: investmentFromController ?? this.investmentFromController,
      investmentUpToController: investmentUpToController ?? this.investmentUpToController,
      roiFromController: roiFromController ?? this.roiFromController,
      roiUpToController: roiUpToController ?? this.roiUpToController,
      loanAmountUpToController: loanAmountUpToController ?? this.loanAmountUpToController,
      loanAmountFromController: loanAmountFromController ?? this.loanAmountFromController,
      responseAccountStatement: responseAccountStatement ?? this.responseAccountStatement,
      selectedFilterMCCApplication: selectedFilterMCCApplication ?? this.selectedFilterMCCApplication,
      responseSupplierProject: responseSupplierProject ?? this.responseSupplierProject,
      paidAmount: paidAmount ?? this.paidAmount,
      dueAmount: dueAmount ?? this.dueAmount,
      statusLoan: statusLoan ?? this.statusLoan,
      pendingAmount: pendingAmount ?? this.pendingAmount,
      roiFilter: roiFilter ?? this.roiFilter,
      filterImprovementAreaName: filterImprovementAreaName ?? this.filterImprovementAreaName,
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
    selectMaterialId,
    primaryId,
    valueController,
    userIdForOtpValidate,
    milestoneDescription,
    responseMilestoneName,
    filterMileStone,
    projectId,
    filterMaterialType,
    filterResourceCapacityType,
    filterResourceType,
    resourceCapacityController,
    materialNameController,
    resourceTypeController,
    uomController,
    selectedFilterMCCApplication,
    responseSupplierProject,
    responseAccountStatement,
    paidAmount,
    pendingAmount,
    dueAmount,
    statusLoan,
    roiFilter,
    revenueToController,
    revenueFromController,
    investmentFromController,
    investmentUpToController,
    roiFromController,
    roiUpToController,
    loanAmountFromController,
    loanAmountUpToController,
    responseImprovementAreaFilterList,
    filterImprovementAreaName
  ];
}