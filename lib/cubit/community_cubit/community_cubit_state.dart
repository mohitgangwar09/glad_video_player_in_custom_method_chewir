part of 'community_cubit.dart';

enum CommunityStatus{initial,submit,success,error}

class CommunityCubitState extends Equatable{
  final CommunityStatus status;
  final ResponseCommunityList? responseCommunityList;
  final ResponseCommunityList? responseCommunityDetailList;
  final ResponseCommunityLikeList? responseCommunityLikeList;
  final ResponseCommunityCommentList? responseCommunityCommentList;

  const CommunityCubitState({
      required this.status,
      required this.responseCommunityList,
      required this.responseCommunityLikeList,
      required this.responseCommunityCommentList,
      required this.responseCommunityDetailList,
  });

  factory CommunityCubitState.initial() {
    return const CommunityCubitState(
      status: CommunityStatus.initial,
      responseCommunityList: null,
      responseCommunityLikeList: null,
      responseCommunityCommentList: null,
      responseCommunityDetailList: null,
    );
  }

  CommunityCubitState copyWith({
    CommunityStatus? status,
    ResponseCommunityList? responseCommunityList,
    ResponseCommunityList? responseCommunityDetailList,
    ResponseCommunityLikeList? responseCommunityLikeList,
    ResponseCommunityCommentList? responseCommunityCommentList
  }) {
    return CommunityCubitState(
        status: status ?? this.status,
        responseCommunityList: responseCommunityList ?? this.responseCommunityList,
        responseCommunityLikeList: responseCommunityLikeList ?? this.responseCommunityLikeList,
        responseCommunityCommentList: responseCommunityCommentList ?? this.responseCommunityCommentList,
        responseCommunityDetailList: responseCommunityDetailList ?? this.responseCommunityDetailList,
    );
  }

  @override
  List<Object?> get props => [
    status,
    responseCommunityList,
    responseCommunityLikeList,
    responseCommunityCommentList,
    responseCommunityDetailList,
  ];

}