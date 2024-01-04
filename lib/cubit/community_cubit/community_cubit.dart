import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:glad/cubit/landing_page_cubit/landing_page_cubit.dart';
import 'package:glad/data/model/response_community_comment_list.dart';
import 'package:glad/data/model/response_community_like_list.dart';
import 'package:glad/data/model/response_community_list_model.dart';
import 'package:glad/data/model/response_friend_list.dart';
import 'package:glad/data/repository/others_repo.dart';
import 'package:glad/screen/custom_widget/custom_methods.dart';
import 'package:glad/utils/app_constants.dart';
import 'package:glad/utils/extension.dart';
import 'package:glad/utils/helper.dart';
import 'package:shared_preferences/shared_preferences.dart';
part 'community_cubit_state.dart';

class CommunityCubit extends Cubit<CommunityCubitState>{

  final OthersRepository apiRepository;
  final SharedPreferences sharedPreferences;

  CommunityCubit({required this.apiRepository,required this.sharedPreferences}) : super(CommunityCubitState.initial());

  // communityListApi
  Future<void> communityListApi(context, {bool isLoaderRequired = true}) async{
    if(isLoaderRequired) {
      emit(state.copyWith(status: CommunityStatus.submit));
      // customDialog(widget: launchProgress());
    }

    var response = await apiRepository.getCommunityListApi();
    if (response.status == 200) {
      emit(state.copyWith(status: CommunityStatus.success, responseCommunityList: response));
    }
    else {
      emit(state.copyWith(status: CommunityStatus.error));
      showCustomToast(context, response.message.toString());
    }
  }

  // communityListApi
  Future<void> communityDetailApi(context, String id, {bool isLoaderRequired = true}) async{
    if(isLoaderRequired) {
      emit(state.copyWith(status: CommunityStatus.submit));
      // customDialog(widget: launchProgress());
    }

    var response = await apiRepository.getCommunityDetailApi(id);
    if (response.status == 200) {
      emit(state.copyWith(status: CommunityStatus.success, responseCommunityDetailList: response));
    }
    else {
      emit(state.copyWith(status: CommunityStatus.error));
      showCustomToast(context, response.message.toString());
    }
  }

  // likeListApi
  Future<void> likeListApi(context, String communityId) async{
    customDialog(widget: launchProgress());
    var response = await apiRepository.getLikeListApi(communityId);
    if (response.status == 200) {
      disposeProgress();
      emit(state.copyWith(status: CommunityStatus.success, responseCommunityLikeList: response));
    }
    else {
      disposeProgress();
      emit(state.copyWith(status: CommunityStatus.error));
      showCustomToast(context, response.message.toString());
    }
  }

  // commentListApi
  Future<void> commentListApi(context, String communityId) async{
    customDialog(widget: launchProgress());
    var response = await apiRepository.getCommentListApi(communityId);
    if (response.status == 200) {
      disposeProgress();
      emit(state.copyWith(status: CommunityStatus.success, responseCommunityCommentList: response));
    }
    else {
      disposeProgress();
      emit(state.copyWith(status: CommunityStatus.error));
      showCustomToast(context, response.message.toString());
    }
  }

  // commentListApi
  Future<void> friendListApi(context) async{
    emit(state.copyWith(status: CommunityStatus.submit));
    var response = await apiRepository.getFriendListApi();
    if (response.status == 200) {
      emit(state.copyWith(status: CommunityStatus.success, responseFriendList: response));
    } else {
      emit(state.copyWith(status: CommunityStatus.error));
      showCustomToast(context, response.message.toString());
    }
  }

  // commentListApi
  Future<void> addCommentApi(context, String communityId, comment) async{
    var response = await apiRepository.addCommentApi(communityId, comment);

    if (response.status == 200) {
      // if(fromHome){
      //   if(sharedPreferences.getString(AppConstants.userType) == "farmer") {
      //     BlocProvider.of<LandingPageCubit>(context).getFarmerDashboard(context, isLoaderRequired: false);
      //   } else if(sharedPreferences.getString(AppConstants.userType) == "dde") {
      //     BlocProvider.of<LandingPageCubit>(context).ddeDashboardApi(context, isLoaderRequired: false);
      //   } else if(sharedPreferences.getString(AppConstants.userType) == "mcc") {
      //     BlocProvider.of<LandingPageCubit>(context).getMCCDashboard(context, isLoaderRequired: false);
      //   } else if(sharedPreferences.getString(AppConstants.userType) == "supplier") {
      //     BlocProvider.of<LandingPageCubit>(context).getSupplierDashboard(context, isLoaderRequired: false);
      //   }
      // }
      commentListApi(context, communityId);
      communityDetailApi(context, communityId, isLoaderRequired: false);
      communityListApi(context, isLoaderRequired: false);
    }
    else {
      showCustomToast(context, response.message.toString());
    }
  }

  // commentListApi
  Future<void> addFriendApi(context, String communityId) async{
    var response = await apiRepository.addFriendApi(communityId);

    if (response.status == 200) {
      communityDetailApi(context, communityId, isLoaderRequired: false);
      communityListApi(context, isLoaderRequired: false);
    } else {
      showCustomToast(context, response.message.toString());
    }
  }


  // commentListApi
  Future<void> addPostApi(context, String remark, String path) async{
    customDialog(widget: launchProgress());
    var response = await apiRepository.addPostApi(remark, path);

    if (response.status == 200) {
      communityListApi(context, isLoaderRequired: false);
      disposeProgress();
      pressBack();
      showCustomToast(context, response.message.toString(), isSuccess: true);
    }
    else {
      showCustomToast(context, response.message.toString());
    }
  }

  // addLikeApi
  Future<void> addLikeApi(context, String communityId) async{
    var response = await apiRepository.addLikeApi(communityId);

    if (response.status == 200) {
      // if(fromHome){
        // if(sharedPreferences.getString(AppConstants.userType) == "farmer") {
        //   BlocProvider.of<LandingPageCubit>(context).getFarmerDashboard(context, isLoaderRequired: false);
        // } else if(sharedPreferences.getString(AppConstants.userType) == "dde") {
        //   BlocProvider.of<LandingPageCubit>(context).ddeDashboardApi(context, isLoaderRequired: false);
        // } else if(sharedPreferences.getString(AppConstants.userType) == "mcc") {
        //   BlocProvider.of<LandingPageCubit>(context).getMCCDashboard(context, isLoaderRequired: false);
        // } else if(sharedPreferences.getString(AppConstants.userType) == "supplier") {
        //   BlocProvider.of<LandingPageCubit>(context).getSupplierDashboard(context, isLoaderRequired: false);
        // }
      // }
      communityDetailApi(context, communityId, isLoaderRequired: false);
      communityListApi(context, isLoaderRequired: false);
      // showCustomToast(context, response.message.toString(), isSuccess: true);
    }
    else {
      showCustomToast(context, response.message.toString());
    }
  }


  String getUserToken() {
    return apiRepository.getUserToken();}

}