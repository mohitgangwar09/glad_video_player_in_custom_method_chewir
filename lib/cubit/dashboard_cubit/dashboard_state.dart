part of 'dashboard_cubit.dart';

class DashboardState extends Equatable{

  final String focusTag;
  final int selectedIndex;
  final ListQueue<int> navigationQueue;

  const DashboardState({
    required this.focusTag,
    required this.selectedIndex,
    required this.navigationQueue,
  });

  factory DashboardState.initial() {
    return DashboardState(
      focusTag: "",
      selectedIndex: 0,
      navigationQueue: ListQueue()..add(0)
    );
  }

  DashboardState copyWith({
    String? focusTag,
    int? selectedIndex,
    ListQueue<int>? navigationQueue
  }) {
    return DashboardState(
      focusTag: focusTag ?? this.focusTag,
      selectedIndex: selectedIndex ?? this.selectedIndex,
      navigationQueue: navigationQueue ?? this.navigationQueue,
    );
  }

  @override
  List<Object?> get props => [
    focusTag,
    selectedIndex,
    navigationQueue
  ];
}