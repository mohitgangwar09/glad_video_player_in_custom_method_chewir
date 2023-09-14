part of 'dde_farmer_cubit.dart';


enum DdeFarmerStatus { initial, loading, success, error }

class DdeState extends Equatable {
  final String focusTag,breedId;
  final double totalProduction;
  final DdeFarmerStatus status;
  final Data? response;
  final List<MonthWiseData>? responseMonthlyWiseData;
  final TextEditingController breedSearchController;
  final TextEditingController breedController;
  final TextEditingController suppliedToOtherPdfController;
  final TextEditingController suppliedToPdfController;
  final TextEditingController selfUseController;
  final List<DataBreed> ? breedResponse;
  final List<DataBreed> ? searchBreedList;

  const DdeState({
    required this.focusTag,
    required this.status,
    required this.response,
    required this.responseMonthlyWiseData,
    required this.breedSearchController,
    required this.breedController,
    required this.suppliedToPdfController,
    required this.suppliedToOtherPdfController,
    required this.selfUseController,
    required this.searchBreedList,
    required this.breedResponse,
    required this.breedId,
    required this.totalProduction,
  });

  factory DdeState.initial(){
    return DdeState(
      focusTag: "focusTag",
      status: DdeFarmerStatus.initial,
      response: null,
      responseMonthlyWiseData: const [],
      breedSearchController: TextEditingController(),
      breedController: TextEditingController(),
      suppliedToPdfController: TextEditingController(),
      suppliedToOtherPdfController: TextEditingController(),
      selfUseController: TextEditingController(),
      breedResponse: null,
      searchBreedList: null,
      breedId: '',
      totalProduction: 0,
    );
  }

  DdeState copyWith({
    String? focusTag,breedId,
    int? selectedIndex,
    double? totalProduction,
    DdeFarmerStatus? status,
    Data? response,
    List<MonthWiseData>? responseMonthlyWiseData,
    TextEditingController? breedSearchController,
    TextEditingController? breedController,suppliedToPdfController,suppliedToOtherPdfController,selfUseController,
    List<DataBreed> ? breedResponse,
    List<DataBreed> ? searchBreedList,
  }) {
    return DdeState(
      focusTag: focusTag ?? this.focusTag,
      breedId: breedId ?? this.breedId,
      totalProduction: totalProduction ?? this.totalProduction,
      status: status ?? this.status,
      response: response ?? this.response,
      responseMonthlyWiseData: responseMonthlyWiseData ?? this.responseMonthlyWiseData,
      breedSearchController: breedSearchController??this.breedSearchController,
      suppliedToPdfController: suppliedToPdfController??this.suppliedToPdfController,
      suppliedToOtherPdfController: suppliedToOtherPdfController??this.suppliedToOtherPdfController,
      selfUseController: selfUseController??this.selfUseController,
      breedController: breedController??this.breedController,
      breedResponse: breedResponse ?? this.breedResponse,
      searchBreedList: searchBreedList ?? this.searchBreedList,
    );
  }

  @override
  List<Object?> get props =>[
    focusTag,
    status,
    response,
    responseMonthlyWiseData,
    breedSearchController,
    searchBreedList,
    breedResponse,
    breedController,
    breedId,
    totalProduction,
    selfUseController,
    suppliedToOtherPdfController,
    suppliedToPdfController,
  ];

}