part of 'dde_farmer_cubit.dart';


enum DdeFarmerStatus { initial, loading, success, error }

class DdeState extends Equatable {
  final String focusTag;
  final DdeFarmerStatus status;
  final Data? response;
  final List<MonthWiseData>? responseMonthlyWiseData;

  const DdeState({
    required this.focusTag,
    required this.status,
    required this.response,
    required this.responseMonthlyWiseData,
  });

  factory DdeState.initial(){
    return const DdeState(
      focusTag: "focusTag",
      status: DdeFarmerStatus.initial,
      response: null,
      responseMonthlyWiseData: [],
    );
  }

  DdeState copyWith({
    String? focusTag,
    int? selectedIndex,
    DdeFarmerStatus? status,
    Data? response,
    List<MonthWiseData>? responseMonthlyWiseData

  }) {
    return DdeState(
      focusTag: focusTag ?? this.focusTag,
      status: status ?? this.status,
      response: response ?? this.response,
      responseMonthlyWiseData: responseMonthlyWiseData ?? this.responseMonthlyWiseData,
    );
  }

  @override
  List<Object?> get props =>[
    focusTag,
    status,
    response,
    responseMonthlyWiseData
  ];

}