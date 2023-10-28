part of 'training_cubit.dart';

enum TrainingStatus{initial,submit,success,error}

class TrainingCubitState extends Equatable{
  final TrainingStatus status;
  final TrainingListModel? responseTrainingList;
  final TrainingCategoryModel? responseTrainingCategories;
  final TrainingDetailModel? responseTrainingDetail;

  const TrainingCubitState({
      required this.status,
      required this.responseTrainingList,
      required this.responseTrainingCategories,
      required this.responseTrainingDetail,
  });

  factory TrainingCubitState.initial() {
    return const TrainingCubitState(
      status: TrainingStatus.initial,
      responseTrainingCategories: null,
      responseTrainingDetail: null,
      responseTrainingList: null,
    );
  }

  TrainingCubitState copyWith({
    TrainingStatus? status,
    TrainingListModel? responseTrainingList,
    TrainingCategoryModel? responseTrainingCategories,
    TrainingDetailModel? responseTrainingDetail,
  }) {
    return TrainingCubitState(
        status: status ?? this.status,
        responseTrainingList: responseTrainingList ?? this.responseTrainingList,
        responseTrainingDetail: responseTrainingDetail ?? this.responseTrainingDetail,
        responseTrainingCategories: responseTrainingCategories ?? this.responseTrainingCategories,
    );
  }

  @override
  List<Object?> get props => [
    status,
    responseTrainingList,
    responseTrainingDetail,
    responseTrainingCategories,
  ];

}