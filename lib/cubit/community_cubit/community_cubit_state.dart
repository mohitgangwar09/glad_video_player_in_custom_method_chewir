part of 'community_cubit.dart';

enum CommunityStatus{initial,submit,success,error}

class CommunityCubitState extends Equatable{
  final CommunityStatus status;
  final ResponseCommunityList? responseCommunityList;
  final ResponseCommunityLikeList? responseCommunityLikeList;
  final ResponseCommunityCommentList? responseCommunityCommentList;

  const CommunityCubitState({
      required this.status,
      required this.responseCommunityList,
      required this.responseCommunityLikeList,
      required this.responseCommunityCommentList,
  });

  factory CommunityCubitState.initial() {
    return const CommunityCubitState(
      status: CommunityStatus.initial,
      responseCommunityList: null,
      responseCommunityLikeList: null,
      responseCommunityCommentList: null,
    );
  }

  CommunityCubitState copyWith({
    CommunityStatus? status,
    ResponseCommunityList? responseCommunityList,
    ResponseCommunityLikeList? responseCommunityLikeList,
    ResponseCommunityCommentList? responseCommunityCommentList
  }) {
    return CommunityCubitState(
        status: status ?? this.status,
        responseCommunityList: responseCommunityList ?? this.responseCommunityList,
        responseCommunityLikeList: responseCommunityLikeList ?? this.responseCommunityLikeList,
        responseCommunityCommentList: responseCommunityCommentList ?? this.responseCommunityCommentList,
    );
  }

  @override
  List<Object?> get props => [
    status,
    responseCommunityList,
    responseCommunityLikeList,
    responseCommunityCommentList,
  ];

}