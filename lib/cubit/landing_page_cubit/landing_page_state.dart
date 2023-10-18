part of 'landing_page_cubit.dart';

enum LandingPageStatus { initial, loading, success, error }

class LandingPageState extends Equatable {
  final String focusTag;
  final LandingPageStatus status;
  final dashboard.Data? response;
  final MilkProductionChart? milkProductionChartResponse;
  final GuestDashboardModel? guestDashboardResponse;
  final FollowupRemarkListModel? followupRemarkListResponse;
  final Position? currentPosition;
  final ResponseDdeDashboard? responseDdeDashboard;
  final ResponseOtpModel? responseFarmerVisitor;
  final DateTime? selectedFarmerVisitDate;

  const LandingPageState({
    required this.focusTag,
    required this.status,
    required this.response,
    required this.milkProductionChartResponse,
    required this.guestDashboardResponse,
    required this.currentPosition,
    required this.followupRemarkListResponse,
    required this.responseDdeDashboard,
    required this.responseFarmerVisitor,
    required this.selectedFarmerVisitDate,
  });

  factory LandingPageState.initial() {
    return LandingPageState(
      focusTag: "",
      status: LandingPageStatus.initial,
      response: null,
      milkProductionChartResponse: null,
      guestDashboardResponse: null,
      currentPosition: null,
      followupRemarkListResponse: null,
      responseDdeDashboard: ResponseDdeDashboard(),
      responseFarmerVisitor: null,
      selectedFarmerVisitDate: DateTime.now(),
    );
  }

  LandingPageState copyWith({
    String? focusTag,
    int? selectedIndex,
    LandingPageStatus? status,
    dashboard.Data? response,
    MilkProductionChart? milkProductionChartResponse,
    GuestDashboardModel? guestDashboardResponse,
    Position? currentPosition,
    FollowupRemarkListModel? followupRemarkListResponse,
    ResponseDdeDashboard? responseDdeDashboard,
    ResponseOtpModel? responseFarmerVisitor,
    DateTime? selectedFarmerVisitDate,
  }) {
    return LandingPageState(
      focusTag: focusTag ?? this.focusTag,
      status: status ?? this.status,
      response: response ?? this.response,
      milkProductionChartResponse:
          milkProductionChartResponse ?? this.milkProductionChartResponse,
      guestDashboardResponse:
          guestDashboardResponse ?? this.guestDashboardResponse,
      currentPosition: currentPosition ?? this.currentPosition,
      followupRemarkListResponse:
          followupRemarkListResponse ?? this.followupRemarkListResponse,
      responseDdeDashboard: responseDdeDashboard ?? this.responseDdeDashboard,
      responseFarmerVisitor:
          responseFarmerVisitor ?? this.responseFarmerVisitor,
      selectedFarmerVisitDate:
          selectedFarmerVisitDate ?? this.selectedFarmerVisitDate,
    );
  }

  @override
  List<Object?> get props => [
        focusTag,
        status,
        response,
        milkProductionChartResponse,
        guestDashboardResponse,
        currentPosition,
        followupRemarkListResponse,
        responseDdeDashboard,
        responseFarmerVisitor,
        selectedFarmerVisitDate
      ];
}
