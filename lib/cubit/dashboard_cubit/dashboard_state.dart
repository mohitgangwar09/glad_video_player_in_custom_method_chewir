part of 'dashboard_cubit.dart';

class DashboardState extends Equatable{

  final String focusTag;
  final int selectedIndex;

  const DashboardState({
    required this.focusTag,
    required this.selectedIndex
  });

  factory DashboardState.initial() {
    return const DashboardState(
      focusTag: "",
      selectedIndex: 0
    );
  }

  DashboardState copyWith({
    String? focusTag,
    int? selectedIndex,
  }) {
    return DashboardState(
      focusTag: focusTag ?? this.focusTag,
      selectedIndex: selectedIndex ?? this.selectedIndex,
    );
  }

  @override
  List<Object?> get props => [
    focusTag,
    selectedIndex
  ];
}