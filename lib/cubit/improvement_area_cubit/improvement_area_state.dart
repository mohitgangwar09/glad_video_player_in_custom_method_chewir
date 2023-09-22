part of 'improvement_area_cubit.dart';

enum ImprovementAreaStatus { initial, loading, success, error }

class ImprovementAreaState extends Equatable {

  final ImprovementAreaStatus status;
  final ImprovementAreaListModel? response;
  final List<StepperItemData> stepperData;
  final Results? resultData;
  final List<TextEditingController>? areaControllers;

  const ImprovementAreaState({
    required this.status,
    required this.stepperData,
    required this.response,
    required this.resultData,
    required this.areaControllers,
  });

  factory ImprovementAreaState.initial(){
    return const ImprovementAreaState(
      status: ImprovementAreaStatus.initial,
      response: null,
      stepperData: [],
      resultData: null,
      areaControllers: [],
    );
  }

  ImprovementAreaState copyWith({
    ImprovementAreaStatus? status,
    ImprovementAreaListModel? response,
    List<StepperItemData>? stepperData,
    Results? resultData,
    List<TextEditingController>? areaControllers,
  }) {
    return ImprovementAreaState(
      status: status ?? this.status,
      response: response ?? this.response,
      stepperData: stepperData ?? this.stepperData,
      resultData: resultData ?? this.resultData,
      areaControllers: areaControllers ?? this.areaControllers,
    );
  }

  @override
  List<Object?> get props =>[
    status,
    response,
    stepperData,
    resultData,
    areaControllers,
  ];

}