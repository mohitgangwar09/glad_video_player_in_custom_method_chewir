part of 'dde_farmer_cubit.dart';


enum DdeFarmerStatus { initial, loading, success, error }

class DdeState extends Equatable {
  final String focusTag,breedId;
  final DdeFarmerStatus status;
  final Data? response;
  final List<MonthWiseData>? responseMonthlyWiseData;
  final TextEditingController breedSearchController;
  final TextEditingController breedController;
  final List<DataBreed> ? breedResponse;
  final List<DataBreed> ? searchBreedList;

  const DdeState({
    required this.focusTag,
    required this.status,
    required this.response,
    required this.responseMonthlyWiseData,
    required this.breedSearchController,
    required this.breedController,
    required this.searchBreedList,
    required this.breedResponse,
    required this.breedId,
  });

  factory DdeState.initial(){
    return DdeState(
      focusTag: "focusTag",
      status: DdeFarmerStatus.initial,
      response: null,
      responseMonthlyWiseData: const [],
      breedSearchController: TextEditingController(),
      breedController: TextEditingController(),
      breedResponse: null,
      searchBreedList: null,
      breedId: '',
    );
  }

  DdeState copyWith({
    String? focusTag,breedId,
    int? selectedIndex,
    DdeFarmerStatus? status,
    Data? response,
    List<MonthWiseData>? responseMonthlyWiseData,
    TextEditingController? breedSearchController,
    TextEditingController? breedController,
    List<DataBreed> ? breedResponse,
    List<DataBreed> ? searchBreedList,
  }) {
    return DdeState(
      focusTag: focusTag ?? this.focusTag,
      breedId: breedId ?? this.breedId,
      status: status ?? this.status,
      response: response ?? this.response,
      responseMonthlyWiseData: responseMonthlyWiseData ?? this.responseMonthlyWiseData,
      breedSearchController: breedSearchController??this.breedSearchController,
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
    breedId
  ];

}