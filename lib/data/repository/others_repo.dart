
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:glad/data/model/auth_models/response_otp_model.dart';
import 'package:glad/data/model/livestock_cart_list.dart';
import 'package:glad/data/model/livestock_detail.dart';
import 'package:glad/data/model/livestock_list_model.dart';
import 'package:glad/data/model/news_list_model.dart';
import 'package:glad/data/model/response_add_livestock.dart';
import 'package:glad/data/model/response_breed.dart';
import 'package:glad/data/model/response_community_comment_list.dart';
import 'package:glad/data/model/response_community_like_list.dart';
import 'package:glad/data/model/response_community_list_model.dart';
import 'package:glad/data/model/response_faq_list.dart';
import 'package:glad/data/model/response_livestock_laon.dart';
import 'package:glad/data/model/response_loan_application_list.dart';
import 'package:glad/data/model/response_my_livestock.dart';
import 'package:glad/data/model/training_and_news_category_model.dart';
import 'package:glad/data/model/training_detail_model.dart';
import 'package:glad/data/model/training_list_model.dart';
import 'package:glad/data/model/youtube_video_statistics_model.dart';
import 'package:glad/screen/extra_screen/profile_navigate.dart';
import 'package:glad/utils/app_constants.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:glad/data/network/api_hitter.dart' as api_hitter;

class OthersRepository {
  final SharedPreferences? sharedPreferences;

  OthersRepository({this.sharedPreferences});

  ///////////////// getTrainingListApi //////////
  Future<TrainingListModel> getTrainingListApi(String categoryId) async {
    var data = {"category_id": categoryId};

    api_hitter.ApiResponse apiResponse = await api_hitter.ApiHitter()
        .getApiResponse(!sharedPreferences!.containsKey(AppConstants.userType) ? AppConstants.guestTrainingListApi : AppConstants.trainingListApi, queryParameters: data,
        headers: {'Authorization': 'Bearer ${getUserToken()}'});

    if (apiResponse.status) {
      return TrainingListModel.fromJson(apiResponse.response!.data);
    } else {
      return TrainingListModel(status: 422, message: apiResponse.msg);
    }
  }

  ///////////////// getTrainingDetailApi //////////
  Future<TrainingDetailModel> getTrainingDetailApi(String trainingId) async {
   var data = {"id": trainingId};

    api_hitter.ApiResponse apiResponse = await api_hitter.ApiHitter()
        .getApiResponse(AppConstants.trainingDetailApi, queryParameters: data,
        headers: {'Authorization': 'Bearer ${getUserToken()}'});

    if (apiResponse.status) {
      return TrainingDetailModel.fromJson(apiResponse.response!.data);
    } else {
      return TrainingDetailModel(status: 422, message: apiResponse.msg);
    }
  }

  ///////////////// getTrainingCategoryApi //////////
  Future<TrainingAndNewsCategoryModel> getTrainingCategoryApi() async {
    api_hitter.ApiResponse apiResponse = await api_hitter.ApiHitter()
        .getApiResponse(!sharedPreferences!.containsKey(AppConstants.userType) ? AppConstants.guestTrainingCategoryApi : AppConstants.trainingCategoryApi,
        headers: {'Authorization': 'Bearer ${getUserToken()}'});

    if (apiResponse.status) {
      return TrainingAndNewsCategoryModel.fromJson(apiResponse.response!.data);
    } else {
      return TrainingAndNewsCategoryModel(status: 422, message: apiResponse.msg);
    }
  }

  ///////////////// getTrainingCategoryApi //////////
  Future<YoutubeVideoStatisticsModel?> getVideoStatisticsApi(String videoId) async {
    String apiKey = 'AIzaSyDdkM0EySEulkkwqqB0c5Z29ddPYaY3FU0';
    String url = 'https://www.googleapis.com/youtube/v3/videos?part=statistics&id=$videoId&key=$apiKey';
    print(url);
    Response apiResponse = await Dio().get(url);

    print(apiResponse.data);
    if (apiResponse.statusCode == 200) {
      return YoutubeVideoStatisticsModel.fromJson(apiResponse.data);
    } else {
      return null;
    }
  }

  ///////////////// getNewsListApi //////////
  Future<NewsListModel> getNewsListApi(String categoryId) async {
    var data = {"category_id": categoryId};

    api_hitter.ApiResponse apiResponse = await api_hitter.ApiHitter()
        .getApiResponse(AppConstants.newsListApi, queryParameters: data,
        headers: {'Authorization': 'Bearer ${getUserToken()}'});

    if (apiResponse.status) {
      return NewsListModel.fromJson(apiResponse.response!.data);
    } else {
      return NewsListModel(status: 422, message: apiResponse.msg);
    }
  }

  ///////////////// getTrainingCategoryApi //////////
  Future<TrainingAndNewsCategoryModel> getNewsCategoryApi() async {
    api_hitter.ApiResponse apiResponse = await api_hitter.ApiHitter()
        .getApiResponse(AppConstants.newsCategoryApi,
        headers: {'Authorization': 'Bearer ${getUserToken()}'});

    if (apiResponse.status) {
      return TrainingAndNewsCategoryModel.fromJson(apiResponse.response!.data);
    } else {
      return TrainingAndNewsCategoryModel(status: 422, message: apiResponse.msg);
    }
  }

  ///////////////// getCommunityListApi //////////
  Future<ResponseCommunityList> getCommunityListApi() async {

    api_hitter.ApiResponse apiResponse = await api_hitter.ApiHitter()
        .getApiResponse(!sharedPreferences!.containsKey(AppConstants.userType) ? AppConstants.guestCommunityListApi : AppConstants.communityListApi,
        headers: {'Authorization': 'Bearer ${getUserToken()}'});

    if (apiResponse.status) {
      return ResponseCommunityList.fromJson(apiResponse.response!.data);
    } else {
      return ResponseCommunityList(status: 422, message: apiResponse.msg);
    }
  }

  ///////////////// getCommunityDetailApi //////////
  Future<ResponseCommunityList> getCommunityDetailApi(String id) async {
    Map<String, dynamic> param = {
      'id': id
    };
    api_hitter.ApiResponse apiResponse = await api_hitter.ApiHitter()
        .getApiResponse(!sharedPreferences!.containsKey(AppConstants.userType) ? AppConstants.guestCommunityDetailApi : AppConstants.communityDetailApi,
        headers: {'Authorization': 'Bearer ${getUserToken()}'},
        queryParameters: param);

    if (apiResponse.status) {
      return ResponseCommunityList.fromJson(apiResponse.response!.data);
    } else {
      return ResponseCommunityList(status: 422, message: apiResponse.msg);
    }
  }

  ///////////////// getCommunityListApi //////////
  Future<ResponseCommunityLikeList> getLikeListApi(String communityId) async {
    var data = {'id': communityId};

    api_hitter.ApiResponse apiResponse = await api_hitter.ApiHitter()
        .getApiResponse(!sharedPreferences!.containsKey(AppConstants.userType) ? AppConstants.guestLikeListApi : AppConstants.likeListApi, queryParameters: data,
        headers: {'Authorization': 'Bearer ${getUserToken()}'});

    if (apiResponse.status) {
      return ResponseCommunityLikeList.fromJson(apiResponse.response!.data);
    } else {
      return ResponseCommunityLikeList(status: 422, message: apiResponse.msg);
    }
  }

  ///////////////// getCommunityListApi //////////
  Future<ResponseCommunityCommentList> getCommentListApi(String communityId) async {
    var data = {'id': communityId};

    api_hitter.ApiResponse apiResponse = await api_hitter.ApiHitter()
        .getApiResponse(!sharedPreferences!.containsKey(AppConstants.userType) ? AppConstants.guestCommentListApi : AppConstants.commentListApi, queryParameters: data,
        headers: {'Authorization': 'Bearer ${getUserToken()}'});

    if (apiResponse.status) {
      return ResponseCommunityCommentList.fromJson(apiResponse.response!.data);
    } else {
      return ResponseCommunityCommentList(status: 422, message: apiResponse.msg);
    }
  }

  ///////////////// getCommunityListApi //////////
  Future<ResponseOtpModel> addCommentApi(String communityId, String comment) async {
    var data = {'community_id': communityId, 'comment': comment};

    api_hitter.ApiResponse apiResponse = await api_hitter.ApiHitter()
        .getPostApiResponse(AppConstants.addCommentApi, data: data,
        headers: {'Authorization': 'Bearer ${getUserToken()}'});

    if (apiResponse.status) {
      return ResponseOtpModel.fromJson(apiResponse.response!.data);
    } else {
      return ResponseOtpModel(status: 422, message: apiResponse.msg);
    }
  }

 ///////////////// getCommunityListApi //////////
  Future<ResponseOtpModel> addPostApi(String remark, String path) async {
      var data = FormData.fromMap({'remark': remark});
      data.files.add(MapEntry(
          'community_document_files[]', await MultipartFile.fromFile(path)));

      api_hitter.ApiResponse apiResponse = await api_hitter.ApiHitter()
          .getPostApiResponse(AppConstants.addPostApi, data: data,
          headers: {'Authorization': 'Bearer ${getUserToken()}'});

      if (apiResponse.status) {
        return ResponseOtpModel.fromJson(apiResponse.response!.data);
      } else {
        return ResponseOtpModel(status: 422, message: apiResponse.msg);
      }
    }

  ///////////////// addLikeApi //////////
  Future<ResponseOtpModel> addLikeApi(String communityId) async {
    var data = {'community_id': communityId};

    api_hitter.ApiResponse apiResponse = await api_hitter.ApiHitter()
        .getPostApiResponse(AppConstants.addLikeApi, data: data,
        headers: {'Authorization': 'Bearer ${getUserToken()}'});

    if (apiResponse.status) {
      return ResponseOtpModel.fromJson(apiResponse.response!.data);
    } else {
      return ResponseOtpModel(status: 422, message: apiResponse.msg);
    }
  }

  ///////////////// getLivestockBreedApi //////////
  Future<ResponseBreed> getLivestockBreedApi() async {

    api_hitter.ApiResponse apiResponse = await api_hitter.ApiHitter()
        .getApiResponse(AppConstants.livestockBreedApi,
        headers: {'Authorization': 'Bearer ${getUserToken()}'});

    if (apiResponse.status) {
      return ResponseBreed.fromJson(apiResponse.response!.data);
    } else {
      return ResponseBreed(status: 422, message: apiResponse.msg);
    }
  }

  ///////////////// getLivestockBreedApi //////////
  Future<ResponseLivestockList> getLivestockListApi({String? searchQuery}) async {

    var data = {
      "search": searchQuery
    };

    api_hitter.ApiResponse apiResponse = await api_hitter.ApiHitter()
        .getApiResponse(sharedPreferences!.containsKey(AppConstants.userType) ? AppConstants.livestockListApi : AppConstants.guestLivestockListApi,
        headers: {'Authorization': 'Bearer ${getUserToken()}'},
    queryParameters: data);

    if (apiResponse.status) {
      return ResponseLivestockList.fromJson(apiResponse.response!.data);
    } else {
      return ResponseLivestockList(status: 422, message: apiResponse.msg);
    }
  }

  ///////////////// getLivestockBreedApi //////////
  Future<ResponseMyLivestock> getMyLivestockListApi() async {

    api_hitter.ApiResponse apiResponse = await api_hitter.ApiHitter()
        .getApiResponse(AppConstants.myLivestockListApi,
        headers: {'Authorization': 'Bearer ${getUserToken()}'});

    if (apiResponse.status) {
      return ResponseMyLivestock.fromJson(apiResponse.response!.data);
    } else {
      return ResponseMyLivestock(status: 422, message: apiResponse.msg);
    }
  }

  ///////////////// getLivestockBreedApi //////////
  Future<LivestockDetail> getLivestockDetailApi(String id) async {

    api_hitter.ApiResponse apiResponse = await api_hitter.ApiHitter()
        .getApiResponse(sharedPreferences!.containsKey(AppConstants.userType) ? AppConstants.livestockDetailApi : AppConstants.guestLivestockDetailApi,
        headers: {'Authorization': 'Bearer ${getUserToken()}'}, queryParameters: {'id': id});

    if (apiResponse.status) {
      return LivestockDetail.fromJson(apiResponse.response!.data);
    } else {
      return LivestockDetail(status: 422, message: apiResponse.msg);
    }
  }

  ///////////////// getCommunityListApi //////////
  Future<ResponseAddLivestock> addLivestockApi(String breedId, List<String> paths, String milk, String lactation, String price, String pregnant, String cowQty, String age, String description) async {
    FormData data = FormData.fromMap({
    'cow_breed_id': breedId,
    'yield': milk,
    'age': age,
    'lactation': lactation,
    'price': price,
    'pregnant': pregnant,
    'cow_qty': cowQty,
    'description': description,
    });

    for(String path in paths){
      data.files.add(MapEntry(
        'live_stock_document_files[]', await MultipartFile.fromFile(path)));
    }

    print(data.fields);

    api_hitter.ApiResponse apiResponse = await api_hitter.ApiHitter()
        .getPostApiResponse(AppConstants.livestockAddApi, data: data,
        headers: {'Authorization': 'Bearer ${getUserToken()}'});

    if (apiResponse.status) {
      return ResponseAddLivestock.fromJson(apiResponse.response!.data);
    } else {
      return ResponseAddLivestock(status: 422, message: apiResponse.msg);
    }
  }

  ///////////////// livestockApi //////////
  Future<ResponseAddLivestock> updateNegotiatedPrice(String livestockId, String negotiatedPrice, String userId) async {


    FormData data = FormData.fromMap({
      "live_stock_id": livestockId,
      "user_id": userId,
      "negotiated_price": negotiatedPrice
    });

    print(data.fields);

    api_hitter.ApiResponse apiResponse = await api_hitter.ApiHitter()
        .getPostApiResponse(AppConstants.updateNegotiatedPriceApi, data: data,
        headers: {'Authorization': 'Bearer ${getUserToken()}'});

    if (apiResponse.status) {
      return ResponseAddLivestock.fromJson(apiResponse.response!.data);
    } else {
      return ResponseAddLivestock(status: 422, message: apiResponse.msg);
    }
  }

  ///////////////// getCommunityListApi //////////
  Future<ResponseAddLivestock> updateLivestockApi(String id, String breedId, List<String> paths, String milk, String lactation, String price, String pregnant, String cowQty, String age, String description) async {
    FormData data = FormData.fromMap({
      'id': id,
      'cow_breed_id': breedId,
      'yield': milk,
      'age': age,
      'lactation': lactation,
      'price': price,
      'pregnant': pregnant,
      'cow_qty': cowQty,
      'description': description,
    });

    for(String path in paths){
      data.files.add(MapEntry(
          'live_stock_document_files[]', await MultipartFile.fromFile(path)));
    }

    print(data.fields);

    api_hitter.ApiResponse apiResponse = await api_hitter.ApiHitter()
        .getPostApiResponse(AppConstants.livestockUpdateApi, data: data,
        headers: {'Authorization': 'Bearer ${getUserToken()}'});

    if (apiResponse.status) {
      return ResponseAddLivestock.fromJson(apiResponse.response!.data);
    } else {
      return ResponseAddLivestock(status: 422, message: apiResponse.msg);
    }
  }

  ///////////////// getCommunityListApi //////////
  Future<ResponseOtpModel> addToCartLivestockApi(String id,int cowQty,String cowPrice) async {

    var data = {'livestock_id': id,
    "cow_qty": cowQty,"cow_price": cowPrice};

    api_hitter.ApiResponse apiResponse = await api_hitter.ApiHitter()
        .getPostApiResponse(AppConstants.livestockAddToCartApi, data: data,
        headers: {'Authorization': 'Bearer ${getUserToken()}'});

    if (apiResponse.status) {
      return ResponseOtpModel.fromJson(apiResponse.response!.data);
    } else {
      return ResponseOtpModel(status: 422, message: apiResponse.msg);
    }
  }

  Future<LivestockCartList> getLivestockCartListApi() async {

    api_hitter.ApiResponse apiResponse = await api_hitter.ApiHitter()
        .getApiResponse(AppConstants.livestockCartListApi,
        headers: {'Authorization': 'Bearer ${getUserToken()}'});

    if (apiResponse.status) {
      return LivestockCartList.fromJson(apiResponse.response!.data);
    } else {
      return LivestockCartList(status: 422, message: apiResponse.msg);
    }
  }

  Future<ResponseOtpModel> livestockUpdateCartApi(int cartId, int cowQty) async {
    Map<String, dynamic> data = {
      'id': cartId,
      'cow_qty': cowQty,
    };
    api_hitter.ApiResponse apiResponse = await api_hitter.ApiHitter()
        .getPostApiResponse(AppConstants.livestockUpdateCartItemQuantityApi,
        headers: {'Authorization': 'Bearer ${getUserToken()}'},
        data: data);

    if (apiResponse.status) {
      return ResponseOtpModel.fromJson(apiResponse.response!.data);
    } else {
      return ResponseOtpModel(status: 422, message: apiResponse.msg);
    }
  }

  ///////////////// getCommunityListApi //////////
  Future<ResponseOtpModel> livestockDeleteCartItemApi(int id) async {

    var data = {
      "id": id
    };

    api_hitter.ApiResponse apiResponse = await api_hitter.ApiHitter().getPostApiResponse(
        AppConstants.livestockCartItemRemoveApi,
        headers: {'Authorization': 'Bearer ${getUserToken()}',},
        data: data
    );

    if (apiResponse.status) {
      return ResponseOtpModel.fromJson(apiResponse.response!.data);
    } else {
      return ResponseOtpModel(status: 422, message: apiResponse.msg);
    }
  }

  ///////////////// getCommunityListApi //////////
  Future<ResponseOtpModel> deleteMediaApi(String id) async {

    api_hitter.ApiResponse apiResponse = await api_hitter.ApiHitter()
        .deleteApiResponse(AppConstants.deleteMediaApi, data: {'id': id},
        headers: {'Authorization': 'Bearer ${getUserToken()}'});

    if (apiResponse.status) {
      return ResponseOtpModel.fromJson(apiResponse.response!.data);
    } else {
      return ResponseOtpModel(status: 422, message: apiResponse.msg);
    }
  }


  ///////////////// updateSoldCowApi //////////
  Future<ResponseOtpModel> updateSoldCowApi(int id,int soldCow) async {
    var data = {
      'id': id,
      'sold_cows': soldCow,
    };

    api_hitter.ApiResponse apiResponse = await api_hitter.ApiHitter()
        .getPostApiResponse(AppConstants.updateSoldCowApi, data: data,
        headers: {'Authorization': 'Bearer ${getUserToken()}'});

    if (apiResponse.status) {
      return ResponseOtpModel.fromJson(apiResponse.response!.data);
    } else {
      return ResponseOtpModel(status: 422, message: apiResponse.msg);
    }
  }

  ///////////////// removeLivestockApi //////////
  Future<ResponseOtpModel> removeLivestockApi(int id) async {
    var data = {
      'id': id,
    };

    api_hitter.ApiResponse apiResponse = await api_hitter.ApiHitter()
        .getPostApiResponse(AppConstants.removeLivestockApi, data: data,
        headers: {'Authorization': 'Bearer ${getUserToken()}'});

    if (apiResponse.status) {
      return ResponseOtpModel.fromJson(apiResponse.response!.data);
    } else {
      return ResponseOtpModel(status: 422, message: apiResponse.msg);
    }
  }

  ///////////////// applyLivestockLoanApi //////////
  Future<ResponseLivestockLoan> applyLivestockLoanApi(int id,String farmerParticipation,String remarks) async {
    var data = {
      'id': id,
      'farmer_participation': farmerParticipation,
      'remarks': remarks
    };

    api_hitter.ApiResponse apiResponse = await api_hitter.ApiHitter()
        .getPostApiResponse(AppConstants.applyLivestockLoanApi, data: data,
        headers: {'Authorization': 'Bearer ${getUserToken()}'});

    if (apiResponse.status) {
      return ResponseLivestockLoan.fromJson(apiResponse.response!.data);
    } else {
      return ResponseLivestockLoan(status: 422, message: apiResponse.msg);
    }
  }


  ///////////////// deliveryStatusApi //////////
  Future<ResponseOtpModel> deliveryStatusApi(int id,
      String farmerProjectId, String remarks, String deliveryStatus,
      List<File> docFile
      ) async {

    FormData formData = FormData.fromMap(
        {

          // "id":"17",
          "id":id,
          "farmer_project_id":farmerProjectId,
          // "farmer_project_id":"1151",
          "remarks":remarks,
          "delivery_status": deliveryStatus
        });

    if(docFile.isNotEmpty){
      for(var e in docFile) {
        formData.files.add(MapEntry("pictures[]", await MultipartFile.fromFile(e.path)));
      }
    }

    print(formData.fields);

    api_hitter.ApiResponse apiResponse = await api_hitter.ApiHitter()
        .getPostApiResponse(AppConstants.livestockDeliveryStatusApi, data: formData,
        headers: {'Authorization': 'Bearer ${getUserToken()}'}
    );

    if (apiResponse.status) {
      return ResponseOtpModel.fromJson(apiResponse.response!.data);
    } else {
      return ResponseOtpModel(status: 422, message: apiResponse.msg);
    }
  }

  ///////////////// emptyCartApi //////////
  Future<ResponseOtpModel> emptyCartApi() async {


    api_hitter.ApiResponse apiResponse = await api_hitter.ApiHitter()
        .getApiResponse(AppConstants.emptyCartApi,
        headers: {'Authorization': 'Bearer ${getUserToken()}'});

    if (apiResponse.status) {
      return ResponseOtpModel.fromJson(apiResponse.response!.data);
    } else {
      return ResponseOtpModel(status: 422, message: apiResponse.msg);
    }
  }

  ///////////////// loanListApi //////////
  Future<ResponseLoanApplicationList> loanListApi(String type) async {


    api_hitter.ApiResponse apiResponse = await api_hitter.ApiHitter()
        .getApiResponse(AppConstants.loanListApi,
        queryParameters: {"type":type},
        headers: {'Authorization': 'Bearer ${getUserToken()}'});

    if (apiResponse.status) {
      return ResponseLoanApplicationList.fromJson(apiResponse.response!.data);
    } else {
      return ResponseLoanApplicationList(status: 422, message: apiResponse.msg);
    }
  }

  ///////////////// faqApi //////////
  Future<ResponseFaqList> faqApi(String type) async {


    api_hitter.ApiResponse apiResponse = await api_hitter.ApiHitter()
        .getApiResponse(AppConstants.faqApi,
        queryParameters: {"category_id":type},
        headers: {'Authorization': 'Bearer ${getUserToken()}'});

    if (apiResponse.status) {
      return ResponseFaqList.fromJson(apiResponse.response!.data);
    } else {
      return ResponseFaqList(status: 422, message: apiResponse.msg);
    }
  }

  getUserToken() {
    return sharedPreferences?.getString(AppConstants.token);
  }
}
