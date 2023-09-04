part of 'drawer_cubit.dart';

enum DrawerStatus {initial,loading,success,error}

class DrawerState extends Equatable{

  final String focusTag;
  final DrawerStatus status;
  final dynamic response;

  const DrawerState({
    required this.focusTag,
    required this.status,
    required this.response
  });

  factory DrawerState.initial() {
    return const DrawerState(
      focusTag: "",
      status: DrawerStatus.initial,
      response: null,
    );
  }

  DrawerState copyWith({
    String? focusTag,
    int? selectedIndex,
    DrawerStatus? status,
    dynamic response,
  }) {
    return DrawerState(
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