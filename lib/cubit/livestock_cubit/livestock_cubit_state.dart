part of 'livestock_cubit.dart';

enum LivestockStatus{initial,submit,success,error}

class LivestockCubitState extends Equatable{
  final LivestockStatus status;
  final ResponseBreed? breed;
  final ResponseLivestockList? responseLivestockList;
  final ResponseMyLivestock? responseMyLivestockList;
  final LivestockDetail? responseLivestockDetail;
  final LivestockCartList? responseLivestockCartList;
  final ResponseLoanApplicationList? responseLoanApplicationList;
  final String? confirmDelivery;
  final TextEditingController ageFromController,ageUpToController,priceFromController,priceUpToController,lactationFromController,lactationUpToController,yieldFromController,yieldUpToController,breedNameSelected;


  const LivestockCubitState({
      required this.status,
      required this.breed,
      required this.responseLivestockList,
      required this.responseMyLivestockList,
      required this.responseLivestockDetail,
      required this.responseLivestockCartList,
      required this.responseLoanApplicationList,
      required this.confirmDelivery,
      required this.ageFromController,
      required this.ageUpToController,
      required this.priceFromController,
      required this.priceUpToController,
      required this.lactationFromController,
      required this.lactationUpToController,
      required this.yieldFromController,
      required this.yieldUpToController,
      required this.breedNameSelected,
  });

  factory LivestockCubitState.initial() {
    return LivestockCubitState(
      status: LivestockStatus.initial,
      breed: null,
      responseLivestockList: null,
      responseMyLivestockList: null,
      responseLivestockDetail: null,
      responseLivestockCartList: null,
      responseLoanApplicationList: null,
      confirmDelivery: null,
      ageFromController: TextEditingController(),
      ageUpToController: TextEditingController(),
      priceFromController: TextEditingController(),
      priceUpToController: TextEditingController(),
      lactationFromController: TextEditingController(),
      lactationUpToController: TextEditingController(),
      yieldFromController: TextEditingController(),
      yieldUpToController: TextEditingController(),
      breedNameSelected: TextEditingController(),
    );
  }

  LivestockCubitState copyWith({
    LivestockStatus? status,
    ResponseBreed? breed,
    ResponseLivestockList? responseLivestockList,
    ResponseMyLivestock? responseMyLivestockList,
    LivestockDetail? responseLivestockDetail,
    LivestockCartList? responseLivestockCartList,
    ResponseLoanApplicationList? responseLoanApplicationList,
    ResponseFaqList? responseFaqList,
    String? confirmDelivery,
    TextEditingController? ageFromController,ageUpToController,priceFromController,priceUpToController,lactationFromController,lactationUpToController,yieldFromController,yieldUpToController,breedNameSelected
  }) {
    return LivestockCubitState(
        status: status ?? this.status,
        breed: breed ?? this.breed,
        responseLivestockList: responseLivestockList ?? this.responseLivestockList,
        responseMyLivestockList: responseMyLivestockList ?? this.responseMyLivestockList,
        responseLivestockDetail: responseLivestockDetail ?? this.responseLivestockDetail,
        responseLivestockCartList: responseLivestockCartList ?? this.responseLivestockCartList,
        responseLoanApplicationList: responseLoanApplicationList ?? this.responseLoanApplicationList,
        confirmDelivery: confirmDelivery ?? this.confirmDelivery,
        ageFromController: ageFromController ?? this.ageFromController,
        ageUpToController: ageUpToController ?? this.ageUpToController,
        priceFromController: priceFromController ?? this.priceFromController,
        priceUpToController: priceUpToController ?? this.priceUpToController,
        lactationFromController: lactationFromController ?? this.lactationFromController,
        lactationUpToController: lactationUpToController ?? this.lactationUpToController,
        yieldFromController: yieldFromController ?? this.yieldFromController,
        yieldUpToController: yieldUpToController ?? this.yieldUpToController,
        breedNameSelected: breedNameSelected ?? this.breedNameSelected,
    );
  }

  @override
  List<Object?> get props => [
    status,
    breed,
    responseLivestockList,
    responseMyLivestockList,
    responseLivestockDetail,
    responseLivestockCartList,
    responseLoanApplicationList,
    confirmDelivery,
    ageFromController,
    ageUpToController,
    priceFromController,
    priceUpToController,
    lactationFromController,
    lactationUpToController,
    yieldFromController,
    yieldUpToController,
    breedNameSelected,
  ];

}