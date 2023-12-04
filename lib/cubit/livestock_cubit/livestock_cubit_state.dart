part of 'livestock_cubit.dart';

enum LivestockStatus{initial,submit,success,error}

class LivestockCubitState extends Equatable{
  final LivestockStatus status;
  final ResponseBreed? breed;
  final String selectedBreed;

  const LivestockCubitState({
      required this.status,
      required this.breed,
      required this.selectedBreed,
  });

  factory LivestockCubitState.initial() {
    return const LivestockCubitState(
      status: LivestockStatus.initial,
      breed: null,
      selectedBreed: '',
    );
  }

  LivestockCubitState copyWith({
    LivestockStatus? status,
    ResponseBreed? breed,
    String? selectedBreed,
  }) {
    return LivestockCubitState(
        status: status ?? this.status,
        breed: breed ?? this.breed,
        selectedBreed: selectedBreed ?? this.selectedBreed,
    );
  }

  @override
  List<Object?> get props => [
    status,
    breed,
    selectedBreed,
  ];

}