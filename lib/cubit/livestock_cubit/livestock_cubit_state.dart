part of 'livestock_cubit.dart';

enum LivestockStatus{initial,submit,success,error}

class LivestockCubitState extends Equatable{
  final LivestockStatus status;
  final ResponseBreed? breed;
  final LivestockList? responseLivestockList;
  final LivestockList? responseMyLivestockList;
  final LivestockDetail? responseLivestockDetail;
  final LivestockCartList? responseLivestockCartList;
  // final String selectedBreed;

  const LivestockCubitState({
      required this.status,
      required this.breed,
      required this.responseLivestockList,
      required this.responseMyLivestockList,
      required this.responseLivestockDetail,
      required this.responseLivestockCartList,
      // required this.selectedBreed,
  });

  factory LivestockCubitState.initial() {
    return const LivestockCubitState(
      status: LivestockStatus.initial,
      breed: null,
      responseLivestockList: null,
      responseMyLivestockList: null,
      responseLivestockDetail: null,
      responseLivestockCartList: null,
      // selectedBreed: '',
    );
  }

  LivestockCubitState copyWith({
    LivestockStatus? status,
    ResponseBreed? breed,
    LivestockList? responseLivestockList,
    LivestockList? responseMyLivestockList,
    LivestockDetail? responseLivestockDetail,
    LivestockCartList? responseLivestockCartList,
    // String? selectedBreed,
  }) {
    return LivestockCubitState(
        status: status ?? this.status,
        breed: breed ?? this.breed,
        responseLivestockList: responseLivestockList ?? this.responseLivestockList,
        responseMyLivestockList: responseMyLivestockList ?? this.responseMyLivestockList,
        responseLivestockDetail: responseLivestockDetail ?? this.responseLivestockDetail,
        responseLivestockCartList: responseLivestockCartList ?? this.responseLivestockCartList,
        // selectedBreed: selectedBreed ?? this.selectedBreed,
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
    // selectedBreed,
  ];

}