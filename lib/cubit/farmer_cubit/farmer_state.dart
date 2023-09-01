part of 'farmer_cubit.dart';

enum FarmerStatus {initial,loading,success,error}

class FarmerState extends Equatable{

  final String focusTag;
  final FarmerStatus status;
  final Data? response;

  const FarmerState({
    required this.focusTag,
    required this.status,
    required this.response
  });

  factory FarmerState.initial() {
    return const FarmerState(
      focusTag: "",
      status: FarmerStatus.initial,
      response: null,
    );
  }

  FarmerState copyWith({
    String? focusTag,
    int? selectedIndex,
    FarmerStatus? status,
    Data? response,
  }) {
    return FarmerState(
      focusTag: focusTag ?? this.focusTag,
      status: status ?? this.status,
      response: response ?? this.response,
    );
  }

  @override
  List<Object?> get props => [
    focusTag,
    status,
    response
  ];
}