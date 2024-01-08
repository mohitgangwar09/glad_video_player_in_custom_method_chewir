part of 'dde_farmer_cubit.dart';


enum DdeFarmerStatus { initial, loading, success, error }

class DdeState extends Equatable {
  final String focusTag,breedId;
  final int id;
  final double totalProduction,totalHerdSize,sumOfHerd,totalMilkingCow,yieldPerDay;
  final List<double> sumOfMilkingSize;
  final DdeFarmerStatus status;
  final Data? response;
  final List<MonthWiseData>? responseMonthlyWiseData;
  final List<DateWiseData>? dateWise;
  final TextEditingController breedSearchController;
  final List<TextEditingController> milkingCowController;
  final List<TextEditingController> herdSizeController;
  final List<TextEditingController> yieldPerDayController;
  final List<TextEditingController> dryController;
  final List<TextEditingController> heiferController;
  final List<TextEditingController> sevenTwelveMonthController;
  final List<TextEditingController> lessthanSixMonthController;
  final List<TextEditingController> bullCalfController;
  final TextEditingController breedController;
  final TextEditingController suppliedToOtherPdfController;
  final TextEditingController suppliedToPdfController;
  final TextEditingController selfUseController;
  final List<DataBreed> ? breedResponse;
  final List<DataBreed> ? searchBreedList;
  final List<bool>? showQties;
  final String? selectedRagRatingType,breedFilter;
  final TextEditingController milkingCowFromController,milkingCowToController,milkSupplyFromController,
      milkSupplyUpToController,yieldPerCowFromController,yieldPerUpToController,farmSizeFromController,farmSizeUpToController,herdSizeFromController,herdSizeToController;
  final int? selectedIndex;

  const DdeState({
    required this.focusTag,
    required this.status,
    required this.response,
    required this.id,
    required this.selectedIndex,
    required this.dateWise,
    required this.yieldPerDay,
    required this.milkingCowController,
    required this.sumOfMilkingSize,
    required this.sumOfHerd,
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
    required this.showQties,
    required this.herdSizeController,
    required this.totalHerdSize,
    required this.yieldPerDayController,
    required this.dryController,
    required this.heiferController,
    required this.sevenTwelveMonthController,
    required this.lessthanSixMonthController,
    required this.bullCalfController,
    required this.totalMilkingCow,
    required this.selectedRagRatingType,
    required this.breedFilter,
    required this.milkingCowFromController,
    required this.milkingCowToController,
    required this.milkSupplyFromController,
    required this.milkSupplyUpToController,
    required this.yieldPerCowFromController,
    required this.yieldPerUpToController,
    required this.farmSizeFromController,
    required this.farmSizeUpToController,
    required this.herdSizeFromController,
    required this.herdSizeToController,
  });

  factory DdeState.initial(){
    return DdeState(
      focusTag: "focusTag",
      status: DdeFarmerStatus.initial,
      response: null,
      sumOfHerd: 0,
      yieldPerDay: 0,
      totalMilkingCow: 0,
      id: 0,
      selectedIndex: null,
      showQties: const [true],
      responseMonthlyWiseData: const [],
      dateWise: const [],
      breedSearchController: TextEditingController(),
      milkingCowController: [],
      herdSizeController: [],
      yieldPerDayController: [],
      dryController: [],
      heiferController: [],
      sevenTwelveMonthController: [],
      lessthanSixMonthController: [],
      bullCalfController: [],
      breedController: TextEditingController(),
      suppliedToPdfController: TextEditingController(),
      suppliedToOtherPdfController: TextEditingController(),
      selfUseController: TextEditingController(),
      milkingCowToController: TextEditingController(),
      milkingCowFromController: TextEditingController(),
      milkSupplyFromController: TextEditingController(),
      milkSupplyUpToController: TextEditingController(),
      yieldPerUpToController: TextEditingController(),
      yieldPerCowFromController: TextEditingController(),
      farmSizeFromController: TextEditingController(),
      farmSizeUpToController: TextEditingController(),
      herdSizeToController: TextEditingController(),
      herdSizeFromController: TextEditingController(),
      breedFilter: '',
      breedResponse: null,
      searchBreedList: null,
      breedId: '',
      totalProduction: 0,
      totalHerdSize: 0,
      sumOfMilkingSize: const [0],
      selectedRagRatingType: '',
    );
  }

  DdeState copyWith({
    String? focusTag,breedId,
    int? selectedIndex,
    double? totalProduction,totalHerdSize,sumOfHerd,totalMilkingCow,yieldPerDay,
    List<double>? sumOfMilkingSize,
    DdeFarmerStatus? status,
    Data? response,
    int? id,
    List<MonthWiseData>? responseMonthlyWiseData,
    TextEditingController? breedSearchController,
    List<TextEditingController>? milkingCowController,
    List<TextEditingController>? herdSizeController,
    List<TextEditingController>? yieldPerDayController,
    List<TextEditingController>? dryController,heiferController,sevenTwelveMonthController,lessthanSixMonthController,bullCalfController,
    TextEditingController? breedController,suppliedToPdfController,suppliedToOtherPdfController,selfUseController,
    List<DataBreed> ? breedResponse,
    List<DateWiseData> ? dateWise,
    List<DataBreed> ? searchBreedList,
    List<bool>? showQties,
    String? selectedRagRatingType,breedFilter,
    TextEditingController? milkingCowFromController,milkingCowToController,milkSupplyFromController,
    milkSupplyUpToController,yieldPerCowFromController,yieldPerUpToController,farmSizeFromController,farmSizeUpToController,herdSizeFromController,herdSizeToController,
  }) {
    return DdeState(
      focusTag: focusTag ?? this.focusTag,
      breedId: breedId ?? this.breedId,
      dateWise: dateWise ?? this.dateWise,
      totalProduction: totalProduction ?? this.totalProduction,
      status: status ?? this.status,
      id: id ?? this.id,
      yieldPerDay: yieldPerDay ?? this.yieldPerDay,
      totalMilkingCow: totalMilkingCow ?? this.totalMilkingCow,
      sumOfHerd: sumOfHerd ?? this.sumOfHerd,
      response: response ?? this.response,
      responseMonthlyWiseData: responseMonthlyWiseData ?? this.responseMonthlyWiseData,
      breedSearchController: breedSearchController??this.breedSearchController,
      herdSizeController: herdSizeController??this.herdSizeController,
      yieldPerDayController: yieldPerDayController??this.yieldPerDayController,
      dryController: dryController??this.dryController,
      heiferController: heiferController??this.heiferController,
      sevenTwelveMonthController: sevenTwelveMonthController??this.sevenTwelveMonthController,
      lessthanSixMonthController: lessthanSixMonthController??this.lessthanSixMonthController,
      bullCalfController: bullCalfController??this.bullCalfController,
      milkingCowController: milkingCowController??this.milkingCowController,
      suppliedToPdfController: suppliedToPdfController??this.suppliedToPdfController,
      suppliedToOtherPdfController: suppliedToOtherPdfController??this.suppliedToOtherPdfController,
      selfUseController: selfUseController??this.selfUseController,
      breedController: breedController??this.breedController,
      breedResponse: breedResponse ?? this.breedResponse,
      searchBreedList: searchBreedList ?? this.searchBreedList,
      showQties: showQties ?? this.showQties,
      totalHerdSize: totalHerdSize ?? this.totalHerdSize,
      sumOfMilkingSize: sumOfMilkingSize ?? this.sumOfMilkingSize,
      selectedRagRatingType: selectedRagRatingType ?? this.selectedRagRatingType,
      breedFilter: breedFilter ?? this.breedFilter,
      milkingCowFromController: milkingCowFromController ?? this.milkingCowFromController,
      milkingCowToController: milkingCowToController ?? this.milkingCowToController,
      milkSupplyFromController: milkSupplyFromController ?? this.milkSupplyFromController,
      milkSupplyUpToController: milkSupplyUpToController ?? this.milkSupplyUpToController,
      yieldPerCowFromController: yieldPerCowFromController ?? this.yieldPerCowFromController,
      yieldPerUpToController: yieldPerUpToController ?? this.yieldPerUpToController,
      farmSizeFromController: farmSizeFromController ?? this.farmSizeFromController,
      farmSizeUpToController: farmSizeUpToController ?? this.farmSizeUpToController,
      herdSizeFromController: herdSizeFromController ?? this.herdSizeFromController,
      herdSizeToController: herdSizeToController ?? this.herdSizeToController,
      selectedIndex: selectedIndex ?? this.selectedIndex,
    );
  }

  @override
  List<Object?> get props =>[
    focusTag,
    status,
    dateWise,
    id,
    yieldPerDay,
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
    showQties,
    milkingCowController,
    herdSizeController,
    totalHerdSize,
    yieldPerDayController,
    dryController,
    heiferController,
    sevenTwelveMonthController,
    lessthanSixMonthController,
    bullCalfController,
    sumOfMilkingSize,
    sumOfHerd,
    totalMilkingCow,
    selectedRagRatingType,
    breedFilter,
    milkSupplyFromController,
    milkingCowToController,
    milkSupplyFromController,
    milkSupplyUpToController,
    yieldPerCowFromController,
    yieldPerUpToController,
    farmSizeFromController,
    farmSizeUpToController,
    herdSizeToController,
    herdSizeFromController,
    selectedIndex
  ];

}