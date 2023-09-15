part of 'dde_farmer_cubit.dart';


enum DdeFarmerStatus { initial, loading, success, error }

class DdeState extends Equatable {
  final String focusTag,breedId;
  final double totalProduction,totalHerdSize,sumOfHerd,totalMilkingCow,yieldPerDay;
  final List<double> sumOfMilkingSize;
  final DdeFarmerStatus status;
  final Data? response;
  final List<MonthWiseData>? responseMonthlyWiseData;
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

  const DdeState({
    required this.focusTag,
    required this.status,
    required this.response,
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
  });

  factory DdeState.initial(){
    return DdeState(
      focusTag: "focusTag",
      status: DdeFarmerStatus.initial,
      response: null,
      sumOfHerd: 0,
      yieldPerDay: 0,
      totalMilkingCow: 0,
      showQties: const [true],
      responseMonthlyWiseData: const [],
      breedSearchController: TextEditingController(),
      milkingCowController: [TextEditingController()],
      herdSizeController: [TextEditingController()],
      yieldPerDayController: [],
      dryController: [TextEditingController()],
      heiferController: [TextEditingController()],
      sevenTwelveMonthController: [TextEditingController()],
      lessthanSixMonthController: [TextEditingController()],
      bullCalfController: [TextEditingController()],
      breedController: TextEditingController(),
      suppliedToPdfController: TextEditingController(),
      suppliedToOtherPdfController: TextEditingController(),
      selfUseController: TextEditingController(),
      breedResponse: null,
      searchBreedList: null,
      breedId: '',
      totalProduction: 0,
      totalHerdSize: 0,
      sumOfMilkingSize: const [0],
    );
  }

  DdeState copyWith({
    String? focusTag,breedId,
    int? selectedIndex,
    double? totalProduction,totalHerdSize,sumOfHerd,totalMilkingCow,yieldPerDay,
    List<double>? sumOfMilkingSize,
    DdeFarmerStatus? status,
    Data? response,
    List<MonthWiseData>? responseMonthlyWiseData,
    TextEditingController? breedSearchController,
    List<TextEditingController>? milkingCowController,
    List<TextEditingController>? herdSizeController,
    List<TextEditingController>? yieldPerDayController,
    List<TextEditingController>? dryController,heiferController,sevenTwelveMonthController,lessthanSixMonthController,bullCalfController,
    TextEditingController? breedController,suppliedToPdfController,suppliedToOtherPdfController,selfUseController,
    List<DataBreed> ? breedResponse,
    List<DataBreed> ? searchBreedList,
    List<bool>? showQties,
  }) {
    return DdeState(
      focusTag: focusTag ?? this.focusTag,
      breedId: breedId ?? this.breedId,
      totalProduction: totalProduction ?? this.totalProduction,
      status: status ?? this.status,
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
    );
  }

  @override
  List<Object?> get props =>[
    focusTag,
    status,
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
    totalMilkingCow
  ];

}