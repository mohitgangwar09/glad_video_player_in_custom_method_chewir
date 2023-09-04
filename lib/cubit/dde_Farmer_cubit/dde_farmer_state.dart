part of 'dde_farmer_cubit.dart';


enum DdeFarmerStatus { initial, loading, success, error }

class DdeState extends Equatable {
  final String focusTag;
  final DdeFarmerStatus status;
  final Data? response;

  DdeState({
    required this.focusTag,
    required this.status,
    required this.response,
  });

  factory DdeState.initial(){
    return DdeState(
      focusTag: "focusTag",
      status: DdeFarmerStatus.initial,
      response: null,
    );
  }

  DdeState copyWith({
    String? focusTag,
    int? selectedIndex,
    DdeFarmerStatus? status,
    Data? response,

  }) {
    return DdeState(
      focusTag: focusTag ?? this.focusTag,
      status: status ?? this.status,
      response: response ?? this.response,
    );
  }

  @override
  List<Object?> get props =>[
    focusTag,
    status,
    response,
  ];

}