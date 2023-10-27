
part of 'cowsandyieldcubit.dart';

enum CowsAndCubitStatus { initial, loading, success, error }

class CowsAndCubitState extends Equatable {

  final CowsAndCubitStatus status;
  final List<MonthWiseData>? responseMonthlyWiseData;
  final int? initialIndex,monthId;
  final List<String>? addMonthId;
  final List<DateWiseData>? responseDateWise;
  final List<TextEditingController> milkingCowController;
  final List<TextEditingController> herdSizeController;
  final List<TextEditingController> yieldPerDayController;
  final List<TextEditingController> dryController;
  final List<TextEditingController> heiferController;
  final List<TextEditingController> sevenTwelveMonthController;
  final List<TextEditingController> lessthanSixMonthController;
  final List<TextEditingController> bullCalfController;
  final List<TextEditingController> breedController;
  final TextEditingController suppliedToOtherPdfController;
  final TextEditingController suppliedToPdfController;
  final TextEditingController selfUseController;
  final int totalMilkingCow,sumOfBreed,totalHerdSize;
  final double totalProduction,yieldPerDay;
  final List<String>? breedId;

  const CowsAndCubitState({
    required this.status,
    this.responseMonthlyWiseData,
    this.initialIndex,
    this.monthId,
    this.addMonthId,
    this.responseDateWise,
    required this.milkingCowController,
    required this.herdSizeController,
    required this.yieldPerDayController,
    required this.dryController,
    required this.heiferController,
    required this.sevenTwelveMonthController,
    required this.lessthanSixMonthController,
    required this.bullCalfController,
    required this.breedController,
    required this.suppliedToOtherPdfController,
    required this.suppliedToPdfController,
    required this.selfUseController,
    required this.totalMilkingCow,
    required this.sumOfBreed,
    required this.totalHerdSize,
    required this.totalProduction,
    required this.yieldPerDay,
    required this.breedId,
  });

  factory CowsAndCubitState.initial(){
    return CowsAndCubitState(
      status: CowsAndCubitStatus.initial,
      responseMonthlyWiseData: const [],
      initialIndex: 0,
      monthId: 0,
      addMonthId: const [],
      responseDateWise: const [],
      milkingCowController: const [],
      herdSizeController:  const [],
      yieldPerDayController: const [],
      dryController: const [],
      heiferController: const [],
      sevenTwelveMonthController: const [],
      lessthanSixMonthController: const [],
      bullCalfController: const [],
      breedController: const [],
      breedId: const [],
      suppliedToPdfController: TextEditingController(),
      suppliedToOtherPdfController: TextEditingController(),
      selfUseController: TextEditingController(),
      totalMilkingCow: 0,
      sumOfBreed: 0,
      totalProduction: 0,
      totalHerdSize: 0,
      yieldPerDay: 0
    );
  }

  CowsAndCubitState copyWith({
    CowsAndCubitStatus? status,
    List<MonthWiseData>? responseMonthlyWiseData,
    int? initialIndex,monthId,
    List<String>? addMonthId,
    List<DateWiseData>? responseDateWise,
    List<TextEditingController>? milkingCowController,
    List<TextEditingController>? herdSizeController,
    List<TextEditingController>? yieldPerDayController,
    List<TextEditingController>? dryController,
    List<TextEditingController>? heiferController,
    List<TextEditingController>? sevenTwelveMonthController,
    List<TextEditingController>? lessthanSixMonthController,
    List<TextEditingController>? bullCalfController,
    List<TextEditingController>? breedController,
    List<String>? breedId,
    TextEditingController? suppliedToOtherPdfController,
    TextEditingController? suppliedToPdfController,
    TextEditingController? selfUseController,
    int? totalMilkingCow,sumOfBreed,totalHerdSize,
    double? totalProduction,yieldPerDay
  }) {
    return CowsAndCubitState(
      status: status ?? this.status,
      responseMonthlyWiseData: responseMonthlyWiseData ?? this.responseMonthlyWiseData,
      initialIndex: initialIndex ?? this.initialIndex,
      monthId: monthId ?? this.monthId,
      addMonthId: addMonthId ?? this.addMonthId,
      responseDateWise: responseDateWise ?? this.responseDateWise,
      milkingCowController: milkingCowController ?? this.milkingCowController,
      herdSizeController: herdSizeController ?? this.herdSizeController,
      yieldPerDayController: yieldPerDayController ?? this.yieldPerDayController,
      dryController: dryController ?? this.dryController,
      heiferController: heiferController ?? this.heiferController,
      sevenTwelveMonthController: sevenTwelveMonthController ?? this.sevenTwelveMonthController,
      lessthanSixMonthController: lessthanSixMonthController ?? this.lessthanSixMonthController,
      bullCalfController: bullCalfController ?? this.bullCalfController,
      breedController: breedController ?? this.breedController,
      suppliedToOtherPdfController: suppliedToOtherPdfController ?? this.suppliedToOtherPdfController,
      suppliedToPdfController: suppliedToPdfController ?? this.suppliedToPdfController,
      selfUseController: selfUseController ?? this.selfUseController,
      totalMilkingCow: totalMilkingCow ?? this.totalMilkingCow,
      sumOfBreed: sumOfBreed ?? this.sumOfBreed,
      totalHerdSize: totalHerdSize ?? this.totalHerdSize,
      totalProduction: totalProduction ?? this.totalProduction,
      yieldPerDay: yieldPerDay ?? this.yieldPerDay,
      breedId: breedId ?? this.breedId,
    );
  }

  @override
  List<Object?> get props =>[
    status,
    responseMonthlyWiseData,
    initialIndex,
    monthId,
    addMonthId,
    responseDateWise,
    milkingCowController,
    herdSizeController,
    yieldPerDayController,
    dryController,
    heiferController,
    sevenTwelveMonthController,
    lessthanSixMonthController,
    bullCalfController,
    breedController,
    suppliedToOtherPdfController,
    suppliedToPdfController,
    selfUseController,
    totalMilkingCow,
    totalProduction,
    sumOfBreed,
    totalHerdSize,
    yieldPerDay,
    breedId
  ];

}