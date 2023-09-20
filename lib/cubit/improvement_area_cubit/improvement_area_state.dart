part of 'improvement_area_cubit.dart';

enum ImprovementAreaStatus { initial, loading, success, error }

class ImprovementAreaState extends Equatable {

  final ImprovementAreaStatus status;
  final ImprovementAreaListModel? response;
  final List<StepperItemData> stepperData;

  const ImprovementAreaState({
    required this.status,
    required this.stepperData,
    required this.response,
  });

  factory ImprovementAreaState.initial(){
    return const ImprovementAreaState(
      status: ImprovementAreaStatus.initial,
      response: null,
      stepperData: [],
    );
  }

  ImprovementAreaState copyWith({
    ImprovementAreaStatus? status,
    ImprovementAreaListModel? response,
    List<StepperItemData>? stepperData,
  }) {
    return ImprovementAreaState(
      status: status ?? this.status,
      response: response ?? this.response,
      stepperData: stepperData ?? this.stepperData,
    );
  }

  @override
  List<Object?> get props =>[
    status,
    response,
  ];

}