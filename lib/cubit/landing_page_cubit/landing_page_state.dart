part of 'landing_page_cubit.dart';

enum LandingPageStatus {initial,loading,success,error}

class LandingPageState extends Equatable{

  final String focusTag;
  final LandingPageStatus status;
  final Data? response;

  const LandingPageState({
    required this.focusTag,
    required this.status,
    required this.response
  });

  factory LandingPageState.initial() {
    return const LandingPageState(
      focusTag: "",
      status: LandingPageStatus.initial,
      response: null,
    );
  }

  LandingPageState copyWith({
    String? focusTag,
    int? selectedIndex,
    LandingPageStatus? status,
    Data? response,
  }) {
    return LandingPageState(
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