part of 'news_cubit.dart';

enum NewsStatus{initial,submit,success,error}

class NewsCubitState extends Equatable{
  final NewsStatus status;
  final NewsListModel? responseNewsList;
  final TrainingAndNewsCategoryModel? responseNewsCategories;
  final String selectedCategoryId;

  const NewsCubitState({
      required this.status,
      required this.responseNewsList,
      required this.responseNewsCategories,
      required this.selectedCategoryId,
  });

  factory NewsCubitState.initial() {
    return const NewsCubitState(
      status: NewsStatus.initial,
      responseNewsCategories: null,
      responseNewsList: null,
      selectedCategoryId: '',
    );
  }

  NewsCubitState copyWith({
    NewsStatus? status,
    NewsListModel? responseNewsList,
    TrainingAndNewsCategoryModel? responseNewsCategories,
    String? selectedCategoryId,
  }) {
    return NewsCubitState(
        status: status ?? this.status,
        responseNewsList: responseNewsList ?? this.responseNewsList,
        responseNewsCategories: responseNewsCategories ?? this.responseNewsCategories,
        selectedCategoryId: selectedCategoryId ?? this.selectedCategoryId,
    );
  }

  @override
  List<Object?> get props => [
    status,
    responseNewsList,
    responseNewsCategories,
    selectedCategoryId,
  ];

}