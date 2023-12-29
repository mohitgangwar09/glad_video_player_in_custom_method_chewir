part of 'training_cubit.dart';

enum TrainingStatus{initial,submit,success,error}

class TrainingCubitState extends Equatable{
  final TrainingStatus status;
  final TrainingListModel? responseTrainingList;
  final TrainingAndNewsCategoryModel? responseTrainingCategories;
  final TrainingDetailModel? responseTrainingDetail;
  final String selectedCategoryId;
  final YoutubeVideoStatisticsModel? responseVideoStatistics;
  final ResponseFaqList? responseFaqList;

  const TrainingCubitState({
      required this.status,
      required this.responseTrainingList,
      required this.responseTrainingCategories,
      required this.responseTrainingDetail,
      required this.selectedCategoryId,
      required this.responseVideoStatistics,
      required this.responseFaqList,
  });

  factory TrainingCubitState.initial() {
    return const TrainingCubitState(
      status: TrainingStatus.initial,
      responseTrainingCategories: null,
      responseTrainingDetail: null,
      responseTrainingList: null,
      selectedCategoryId: '',
      responseVideoStatistics: null,
      responseFaqList: null,
    );
  }

  TrainingCubitState copyWith({
    TrainingStatus? status,
    TrainingListModel? responseTrainingList,
    TrainingAndNewsCategoryModel? responseTrainingCategories,
    TrainingDetailModel? responseTrainingDetail,
    String? selectedCategoryId,
    YoutubeVideoStatisticsModel? responseVideoStatistics,
    ResponseFaqList? responseFaqList,
  }) {
    return TrainingCubitState(
        status: status ?? this.status,
        responseTrainingList: responseTrainingList ?? this.responseTrainingList,
        responseTrainingDetail: responseTrainingDetail ?? this.responseTrainingDetail,
        responseTrainingCategories: responseTrainingCategories ?? this.responseTrainingCategories,
        selectedCategoryId: selectedCategoryId ?? this.selectedCategoryId,
        responseVideoStatistics: responseVideoStatistics ?? this.responseVideoStatistics,
        responseFaqList: responseFaqList ?? this.responseFaqList,
    );
  }

  @override
  List<Object?> get props => [
    status,
    responseTrainingList,
    responseTrainingDetail,
    responseTrainingCategories,
    selectedCategoryId,
    responseVideoStatistics,
    responseFaqList
  ];

}