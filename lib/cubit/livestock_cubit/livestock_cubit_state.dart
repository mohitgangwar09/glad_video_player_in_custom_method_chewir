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

  const LivestockCubitState({
      required this.status,
      required this.breed,
      required this.responseLivestockList,
      required this.responseMyLivestockList,
      required this.responseLivestockDetail,
      required this.responseLivestockCartList,
      required this.responseLoanApplicationList,
      required this.confirmDelivery,
  });

  factory LivestockCubitState.initial() {
    return const LivestockCubitState(
      status: LivestockStatus.initial,
      breed: null,
      responseLivestockList: null,
      responseMyLivestockList: null,
      responseLivestockDetail: null,
      responseLivestockCartList: null,
      responseLoanApplicationList: null,
      confirmDelivery: null,
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
    String? confirmDelivery,
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
  ];

}