part of 'landing_page_cubit.dart';

enum LandingPageStatus {initial,loading,success,error}

class LandingPageState extends Equatable{

  final String focusTag;
  final LandingPageStatus status;
  final dashboard.Data? response;
  final MilkProductionChart? milkProductionChartResponse;


  const LandingPageState({
    required this.focusTag,
    required this.status,
    required this.response,
    required this.milkProductionChartResponse,
  });

  factory LandingPageState.initial() {
    return const LandingPageState(
      focusTag: "",
      status: LandingPageStatus.initial,
      response: null,
      milkProductionChartResponse: null,
    );
  }

  LandingPageState copyWith({
    String? focusTag,
    int? selectedIndex,
    LandingPageStatus? status,
    dashboard.Data? response,
    MilkProductionChart? milkProductionChartResponse,
  }) {
    return LandingPageState(
      focusTag: focusTag ?? this.focusTag,
      status: status ?? this.status,
      response: response ?? this.response,
      milkProductionChartResponse:  milkProductionChartResponse ?? this.milkProductionChartResponse
    );
  }

  @override
  List<Object?> get props => [
    focusTag,
    status,
    response,
    milkProductionChartResponse,
  ];
}