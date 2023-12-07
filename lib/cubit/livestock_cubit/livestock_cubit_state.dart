part of 'livestock_cubit.dart';

enum LivestockStatus{initial,submit,success,error}

class LivestockCubitState extends Equatable{
  final LivestockStatus status;
  final ResponseBreed? breed;
  final LivestockList? responseLivestockList;
  final LivestockList? responseMyLivestockList;
  final LivestockDetail? responseLivestockDetail;
  // final String selectedBreed;

  const LivestockCubitState({
      required this.status,
      required this.breed,
      required this.responseLivestockList,
      required this.responseMyLivestockList,
      required this.responseLivestockDetail,
      // required this.selectedBreed,
  });

  factory LivestockCubitState.initial() {
    return const LivestockCubitState(
      status: LivestockStatus.initial,
      breed: null,
      responseLivestockList: null,
      responseMyLivestockList: null,
      responseLivestockDetail: null,
      // selectedBreed: '',
    );
  }

  LivestockCubitState copyWith({
    LivestockStatus? status,
    ResponseBreed? breed,
    LivestockList? responseLivestockList,
    LivestockList? responseMyLivestockList,
    LivestockDetail? responseLivestockDetail,
    // String? selectedBreed,
  }) {
    return LivestockCubitState(
        status: status ?? this.status,
        breed: breed ?? this.breed,
        responseLivestockList: responseLivestockList ?? this.responseLivestockList,
        responseMyLivestockList: responseMyLivestockList ?? this.responseMyLivestockList,
        responseLivestockDetail: responseLivestockDetail ?? this.responseLivestockDetail,
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
    // selectedBreed,
  ];

}