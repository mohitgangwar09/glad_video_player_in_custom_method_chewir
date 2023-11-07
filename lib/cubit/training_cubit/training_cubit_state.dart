part of 'training_cubit.dart';

enum TrainingStatus{initial,submit,success,error}

class TrainingCubitState extends Equatable{
  final TrainingStatus status;
  final TrainingListModel? responseTrainingList;
  final TrainingAndNewsCategoryModel? responseTrainingCategories;
  final TrainingDetailModel? responseTrainingDetail;
  final String selectedCategoryId;

  const TrainingCubitState({
      required this.status,
      required this.responseTrainingList,
      required this.responseTrainingCategories,
      required this.responseTrainingDetail,
      required this.selectedCategoryId,
  });

  factory TrainingCubitState.initial() {
    return const TrainingCubitState(
      status: TrainingStatus.initial,
      responseTrainingCategories: null,
      responseTrainingDetail: null,
      responseTrainingList: null,
      selectedCategoryId: '',
    );
  }

  TrainingCubitState copyWith({
    TrainingStatus? status,
    TrainingListModel? responseTrainingList,
    TrainingAndNewsCategoryModel? responseTrainingCategories,
    TrainingDetailModel? responseTrainingDetail,
    String? selectedCategoryId,
  }) {
    return TrainingCubitState(
        status: status ?? this.status,
        responseTrainingList: responseTrainingList ?? this.responseTrainingList,
        responseTrainingDetail: responseTrainingDetail ?? this.responseTrainingDetail,
        responseTrainingCategories: responseTrainingCategories ?? this.responseTrainingCategories,
        selectedCategoryId: selectedCategoryId ?? this.selectedCategoryId,
    );
  }

  @override
  List<Object?> get props => [
    status,
    responseTrainingList,
    responseTrainingDetail,
    responseTrainingCategories,
    selectedCategoryId,
  ];

}