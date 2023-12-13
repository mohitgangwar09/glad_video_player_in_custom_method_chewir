import 'dart:io';

import 'package:dio/dio.dart';
import 'package:glad/data/model/auth_models/response_otp_model.dart';
import 'package:glad/data/model/farmer_profile_model.dart';
import 'package:glad/data/model/improvement_area_list_model.dart';
import 'package:glad/data/model/improvement_area_update_response.dart';
import 'package:glad/data/model/respone_team_member.dart';
import 'package:glad/data/model/response_county_list.dart';
import 'package:glad/data/model/response_district.dart';
import 'package:glad/data/model/response_profile_model.dart';
import 'package:glad/data/model/response_sub_county.dart';
import 'package:glad/data/model/response_user_rating.dart';
import 'package:glad/data/model/response_validate_country.dart';
import 'package:glad/utils/app_constants.dart';
import 'package:glad/utils/extension.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:glad/data/network/api_hitter.dart' as api_hitter;

class ProfileRepository {
  final SharedPreferences? sharedPreferences;

  ProfileRepository({this.sharedPreferences});

  ///////////////// userProfileApi //////////

  Future<ResponseProfile> getUserProfileApi() async {
    var userId = sharedPreferences?.getString(AppConstants.userId);

    var data = {
      "id": userId,
    };

    api_hitter.ApiResponse apiResponse = await api_hitter.ApiHitter()
        .getApiResponse(AppConstants.profileApi, queryParameters: data);

    if (apiResponse.status) {
      return ResponseProfile.fromJson(apiResponse.response!.data);
    }else
    {
      return ResponseProfile(status: 422, message: apiResponse.msg);
    }
  }

  ///////////////// userRatingApi //////////

  Future<ResponseUserRating> userRatingApi({String? userRoleId}) async {

    var data = {"user_role_id": userRoleId ?? sharedPreferences?.getString(AppConstants.userRoleId)};

    api_hitter.ApiResponse apiResponse = await api_hitter.ApiHitter()
        .getApiResponse(AppConstants.userRatingApi,
        queryParameters: data,
        headers: {'Authorization': 'Bearer ${getUserToken()}'});

    if (apiResponse.status) {
      return ResponseUserRating.fromJson(apiResponse.response!.data);
    }else
    {
      return ResponseUserRating(status: 422, message: apiResponse.msg);
    }
  }

  ///////////////// teamMembersListApi //////////

  Future<ResponseTeamMemberList> teamMembersListApi({String? userRoleId}) async {

    api_hitter.ApiResponse apiResponse = await api_hitter.ApiHitter()
        .getApiResponse(AppConstants.teamMembersApi,
        headers: {'Authorization': 'Bearer ${getUserToken()}'});

    if (apiResponse.status) {
      return ResponseTeamMemberList.fromJson(apiResponse.response!.data);
    }else
    {
      return ResponseTeamMemberList(status: 422, message: apiResponse.msg);
    }
  }

  ///////////////// addTeamMemberApi //////////

  Future<ResponseOtpModel> addTeamMemberApi(String name, String email, String phone) async {

    var data = {
      "name" : name,
      "email" : email,
      "phone" : phone,
    };

    api_hitter.ApiResponse apiResponse = await api_hitter.ApiHitter()
        .getPostApiResponse(AppConstants.addTeamMembersApi,
        data: data,
        headers: {'Authorization': 'Bearer ${getUserToken()}'});

    if (apiResponse.status) {
      return ResponseOtpModel.fromJson(apiResponse.response!.data);
    }else
    {
      return ResponseOtpModel(status: 422, message: apiResponse.msg);
    }
  }

  ///////////////// updateTeamMemberApi //////////

  Future<ResponseOtpModel> updateTeamMemberApi(String id,String name, String email, String phone) async {

    var data = {
      "id" : id,
      "name" : name,
      "email" : email,
      "phone" : phone,
    };

    api_hitter.ApiResponse apiResponse = await api_hitter.ApiHitter()
        .getPostApiResponse(AppConstants.updateTeamMembersApi,
        data: data,
        headers: {'Authorization': 'Bearer ${getUserToken()}'});

    if (apiResponse.status) {
      return ResponseOtpModel.fromJson(apiResponse.response!.data);
    }else
    {
      return ResponseOtpModel(status: 422, message: apiResponse.msg);
    }
  }

  ///////////////// userFarmerRatingApi //////////

  Future<ResponseUserRating> userFarmerDetailRatingApi({String? userRoleId}) async {

    var data = {"user_role_id": userRoleId ?? sharedPreferences?.getString(AppConstants.userRoleId)};

    api_hitter.ApiResponse apiResponse = await api_hitter.ApiHitter()
        .getApiResponse(AppConstants.userRatingApi,
        queryParameters: data,
        headers: {'Authorization': 'Bearer ${getUserToken()}'});

    if (apiResponse.status) {
      return ResponseUserRating.fromJson(apiResponse.response!.data);
    }else
    {
      return ResponseUserRating(status: 422, message: apiResponse.msg);
    }
  }

  ///////////////// updateProfileApi //////////
  Future<ResponseOtpModel> updateProfileImageAPiRam(File file) async {
    var userId = sharedPreferences!.getString(AppConstants.userId);

    FormData formData = FormData.fromMap(
        {"id": userId, "photo": await MultipartFile.fromFile(file.path), "profile_pic": await MultipartFile.fromFile(file.path),});

    print(formData.fields);

    api_hitter.ApiResponse apiResponse = await api_hitter.ApiHitter()
        .getPostApiResponse(AppConstants.updateFarmerApi, data: formData,
        headers: {'Authorization': 'Bearer ${getUserToken()}'}
    );

    if (apiResponse.status) {
      return ResponseOtpModel.fromJson(apiResponse.response!.data);
    } else {
      return ResponseOtpModel(status: 422, message: apiResponse.msg);
    }
  }

///////////////// updateFarmerKYCStatus //////////
  Future<ResponseOtpModel> updateFarmerKYCStatus(int farmerId, String docName, String docNo, String docExpiryDate, List<File> documentFiles,
      String docType, String docTypeNo, String docTypeExpiryDate, List<File> documentTypeFiles, File profilePic) async {

    FormData formData = FormData.fromMap(
        {
          "doc_name": docType,
          "doc_no": docTypeNo,
          "doc_expiry_date": docTypeExpiryDate,
          "doc_type": docName,
          "doc_type_no": docNo,
          "doc_type_expiry_date": docExpiryDate,
          "profile_pic": await MultipartFile.fromFile(profilePic.path),
        });
    for(var e in documentFiles) {
      formData.files.add(MapEntry("document_files[]", await MultipartFile.fromFile(e.path)));
    }
    for(var e in documentTypeFiles) {
      formData.files.add(MapEntry("document_type_files[]", await MultipartFile.fromFile(e.path)));
    }
    // if(sharedPreferences!.getString(AppConstants.userType) == 'dde'){
      formData.fields.add(MapEntry('farmer_id', farmerId.toString()));
    // }
    print(formData.fields);

    api_hitter.ApiResponse apiResponse = await api_hitter.ApiHitter()
        .getPostApiResponse(AppConstants.updateKycDocument, data: formData,
        headers: {'Authorization': 'Bearer ${getUserToken()}'}
    );

    if (apiResponse.status) {
      return ResponseOtpModel.fromJson(apiResponse.response!.data);
    } else {
      return ResponseOtpModel(status: 422, message: apiResponse.msg);
    }
  }

  ///////////////// updateFarmerKYCStatus //////////
  Future<ResponseOtpModel> editFarmerKYCStatus(int farmerId,  int id, String docName, String docNo, String docExpiryDate, List<File> documentFiles,
      String docType, String docTypeNo, String docTypeExpiryDate, List<File> documentTypeFiles, String profilePic) async {

    FormData formData = FormData.fromMap(
        {
          'id': id,
          "doc_name": docType,
          "doc_no": docTypeNo,
          "doc_expiry_date": docTypeExpiryDate,
          "doc_type": docName,
          "doc_type_no": docNo,
          "doc_type_expiry_date": docExpiryDate,
        });
    if(profilePic != ''){
      formData.files.add(MapEntry("profile_pic", await MultipartFile.fromFile(File(profilePic).path)));
    }
    for(var e in documentFiles) {
      formData.files.add(MapEntry("document_files[]", await MultipartFile.fromFile(e.path)));
    }
    for(var e in documentTypeFiles) {
      formData.files.add(MapEntry("document_type_files[]", await MultipartFile.fromFile(e.path)));
    }
    // if(sharedPreferences!.getString(AppConstants.userType) == 'dde'){
      formData.fields.add(MapEntry('farmer_id', farmerId.toString()));
    // }
    print(formData.fields);

    api_hitter.ApiResponse apiResponse = await api_hitter.ApiHitter()
        .getPostApiResponse(AppConstants.editKycDocument, data: formData,
        headers: {'Authorization': 'Bearer ${getUserToken()}'}
    );

    if (apiResponse.status) {
      return ResponseOtpModel.fromJson(apiResponse.response!.data);
    } else {
      return ResponseOtpModel(status: 422, message: apiResponse.msg);
    }
  }

  ///////////////// supplierKycDocumentApi //////////
  Future<ResponseOtpModel> supplierKycDocumentApi(int supplierId,
      String doc1Name, String doc2Name, String doc3Name,
      String doc4Name,String doc5Name,String doc6Name,
      String doc1Number,String doc2Number,String doc3Number,
      String doc4Number,String doc5Number,String doc6Number,
      String doc1Expiry,String doc2Expiry,String doc3Expiry,
      String doc4Expiry,String doc5Expiry,String doc6Expiry,
      List<File> doc1File, List<File> doc2File,
      List<File> doc3File, List<File> doc4File,
      List<File> doc5File, List<File> doc6File,
      ) async {

    FormData formData = FormData.fromMap(
        {

          // "supplier_id": supplierId,
          "supplier_id": sharedPreferences!.getString(AppConstants.userRoleId),
          "doc_1_name": doc1Name,
          "doc_1_no": doc1Number,
          "doc_1_expiry_date": doc1Expiry,
          'doc_2_name': doc2Name,
          "doc_2_no": doc2Number,
          "doc_2_expiry_date": doc2Expiry,
          'doc_3_name': doc3Name,
          "doc_3_no": doc3Number,
          "doc_3_expiry_date": doc3Expiry,
          'doc_4_name': doc4Name,
          "doc_4_no": doc4Number,
          "doc_4_expiry_date": doc4Expiry,
          'doc_5_name': doc5Name,
          "doc_5_no": doc5Number,
          "doc_5_expiry_date": doc5Expiry,
          'doc_6_name': doc6Name,
          "doc_6_no": doc6Number,
          "doc_6_expiry_date": doc6Expiry,
        });
      for(var e in doc1File) {
        formData.files.add(MapEntry("doc_file_1[]", await MultipartFile.fromFile(e.path)));
      }

      for(var e in doc2File) {
        formData.files.add(MapEntry("doc_file_2[]", await MultipartFile.fromFile(e.path)));
      }

      for(var e in doc3File) {
        formData.files.add(MapEntry("doc_file_3[]", await MultipartFile.fromFile(e.path)));
      }

      for(var e in doc4File) {
        formData.files.add(MapEntry("doc_file_4[]", await MultipartFile.fromFile(e.path)));
      }

      for(var e in doc5File) {
        formData.files.add(MapEntry("doc_file_5[]", await MultipartFile.fromFile(e.path)));
      }


      for(var e in doc6File) {
        formData.files.add(MapEntry("doc_file_6[]", await MultipartFile.fromFile(e.path)));
      }



    print(formData.fields);

    api_hitter.ApiResponse apiResponse = await api_hitter.ApiHitter()
        .getPostApiResponse(AppConstants.supplierKycDocumentApi, data: formData,
        headers: {'Authorization': 'Bearer ${getUserToken()}'}
    );

    if (apiResponse.status) {
      return ResponseOtpModel.fromJson(apiResponse.response!.data);
    } else {
      return ResponseOtpModel(status: 422, message: apiResponse.msg);
    }
  }


  ///////////////// supplierKycDocumentApi //////////
  Future<ResponseOtpModel> supplierKycDocumentUpdateApi(int documentId,int supplierId,
      String doc1Name, String doc2Name, String doc3Name,
      String doc4Name,String doc5Name,String doc6Name,
      String doc1Number,String doc2Number,String doc3Number,
      String doc4Number,String doc5Number,String doc6Number,
      String doc1Expiry,String doc2Expiry,String doc3Expiry,
      String doc4Expiry,String doc5Expiry,String doc6Expiry,
      List<File> doc1File, List<File> doc2File,
      List<File> doc3File, List<File> doc4File,
      List<File> doc5File, List<File> doc6File,
      String docOneSelectedFile,docTwoSelectedFile,docThreeSelectedFile,
      docFourSelectedFile,docFiveSelectedFile,docSixSelectedFile
      ) async {

    FormData formData = FormData.fromMap(
        {
          "id": documentId,
          "supplier_id": sharedPreferences!.getString(AppConstants.userRoleId),
          "doc_1_name": doc1Name,
          "doc_1_no": doc1Number,
          "doc_1_expiry_date": doc1Expiry,
          'doc_2_name': doc2Name,
          "doc_2_no": doc2Number,
          "doc_2_expiry_date": doc2Expiry,
          'doc_3_name': doc3Name,
          "doc_3_no": doc3Number,
          "doc_3_expiry_date": doc3Expiry,
          'doc_4_name': doc4Name,
          "doc_4_no": doc4Number,
          "doc_4_expiry_date": doc4Expiry,
          'doc_5_name': doc5Name,
          "doc_5_no": doc5Number,
          "doc_5_expiry_date": doc5Expiry,
          'doc_6_name': doc6Name,
          "doc_6_no": doc6Number,
          "doc_6_expiry_date": doc6Expiry,
        });
    if(docOneSelectedFile == 'selected'){
      for(var e in doc1File) {
        formData.files.add(MapEntry("doc_file_1[]", await MultipartFile.fromFile(e.path)));
      }
    }

    if(docTwoSelectedFile == 'selected') {
      for(var e in doc2File) {
        formData.files.add(MapEntry("doc_file_2[]", await MultipartFile.fromFile(e.path)));
      }
    }

    if(docThreeSelectedFile == 'selected') {
      for(var e in doc3File) {
        formData.files.add(MapEntry("doc_file_3[]", await MultipartFile.fromFile(e.path)));
      }
    }

    if(docFourSelectedFile == 'selected') {
      for(var e in doc4File) {
        formData.files.add(MapEntry("doc_file_4[]", await MultipartFile.fromFile(e.path)));
      }
    }

    if(docFiveSelectedFile == 'selected') {
      for(var e in doc5File) {
        formData.files.add(MapEntry("doc_file_5[]", await MultipartFile.fromFile(e.path)));
      }
    }

    if(docSixSelectedFile == 'selected') {
      for(var e in doc6File) {
        formData.files.add(MapEntry("doc_file_6[]", await MultipartFile.fromFile(e.path)));
      }
    }


    print(formData.fields);

    api_hitter.ApiResponse apiResponse = await api_hitter.ApiHitter()
        .getPostApiResponse(AppConstants.supplierKycDocumentUpdateApi, data: formData,
        headers: {'Authorization': 'Bearer ${getUserToken()}'}
    );

    if (apiResponse.status) {
      return ResponseOtpModel.fromJson(apiResponse.response!.data);
    } else {
      return ResponseOtpModel(status: 422, message: apiResponse.msg);
    }
  }

  ///////////////// updateProfileApi //////////
  Future<ResponseOtpModel> updateProfileImageAPi(File file) async {
    var userId = sharedPreferences!.getString(AppConstants.userId);

    FormData formData = FormData.fromMap({
          "id": userId,
          "profile_pic": await MultipartFile.fromFile(file.path),
          "photo": await MultipartFile.fromFile(file.path),
        });

    print(formData.fields);

    api_hitter.ApiResponse apiResponse = await api_hitter.ApiHitter()
        .getPostApiResponse(AppConstants.updateProfileImageAPi, data: formData);

    if (apiResponse.status) {
      return ResponseOtpModel.fromJson(apiResponse.response!.data);
    } else {
      return ResponseOtpModel(status: 422, message: apiResponse.msg);
    }
  }

  Future<ImprovementAreaListModel> getImprovementArea(int farmerId) async {
    print({'farmer_id': farmerId});
    api_hitter.ApiResponse apiResponse = await api_hitter.ApiHitter().getApiResponse(
        AppConstants.improvementAreaList, headers: {'Authorization': 'Bearer ${getUserToken()}'}, queryParameters: {'farmer_id': farmerId});
    if (apiResponse.status) {
      return ImprovementAreaListModel.fromJson(apiResponse.response!.data);
    } {
      return ImprovementAreaListModel(
          status: 422,
          message: apiResponse.msg);
    }
  }

  Future<ImprovementAreaUpdateResponse> updateImprovementArea(Map<String, dynamic> data) async {
    api_hitter.ApiResponse apiResponse = await api_hitter.ApiHitter().getPostApiResponse(
        AppConstants.improvementAreaUpdate, headers: {'Authorization': 'Bearer ${getUserToken()}'}, data :data);
    if (apiResponse.status) {
      return ImprovementAreaUpdateResponse.fromJson(apiResponse.response!.data);
    } {
      return ImprovementAreaUpdateResponse(
          status: 422,
          message: apiResponse.msg);
    }
  }

  Future<FarmerProfileModel> getFarmerProfileApi(String userId) async {

    print("checked $userId");

    api_hitter.ApiResponse apiResponse = await api_hitter.ApiHitter().getApiResponse(
        '${AppConstants.farmerDetailsApi}/$userId', headers: {'Authorization': 'Bearer ${getUserToken()}'});

    if (apiResponse.status) {
      return FarmerProfileModel.fromJson(apiResponse.response!.data);
    } else {
      return FarmerProfileModel(
          status: 422,
          message: apiResponse.msg);
    }
  }

  Future<FarmerProfileModel> updateFarmerDetailApi(String gender,
      String landlineNumber,String file,String dob,String farmingExperience) async {

    FormData formData;
    var userId = sharedPreferences?.getString(AppConstants.userId);

    if(file == ""){
      if(dob == ""){
        formData = FormData.fromMap({
          "id": userId,
          "gender": gender,
          "phone": landlineNumber,
          "farming_experience": farmingExperience,

        });
      }else{
        formData = FormData.fromMap({
          "id": userId,
          "gender": gender,
          "phone": landlineNumber,
          "date_of_birth": dob,
          "farming_experience": farmingExperience,
        });
      }

    }else{
      File files = File(file);
      if(dob == ""){
        formData = FormData.fromMap({
          "id": userId,
          "gender": gender,
          "phone": landlineNumber,
          "photo": await MultipartFile.fromFile(files.path),
          "farming_experience": farmingExperience,
        });
      }else{
        formData = FormData.fromMap({
          "id": userId,
          "gender": gender,
          "phone": landlineNumber,
          "date_of_birth": dob,
          "photo": await MultipartFile.fromFile(files.path),
          "farming_experience": farmingExperience,
        });
      }
    }

    api_hitter.ApiResponse apiResponse = await api_hitter.ApiHitter().getPostApiResponse(
        AppConstants.updateFarmerApi,
        headers: {'Authorization': 'Bearer ${getUserToken()}'},
        data: formData
    );

    if (apiResponse.status) {
      return FarmerProfileModel.fromJson(apiResponse.response!.data);
    } else {
      return FarmerProfileModel(status: 422, message: apiResponse.msg);
    }
  }

  ////////////////////address UpdateApi////////////////
  Future<ResponseOtpModel> addressUpdateApi(
      String country,
      String district,
      String region,
      String county,
      String subCounty,
      String postalCode,
      String address,String latitude,String longitude,String userId) async {
    // var userId = sharedPreferences?.getString(AppConstants.userId);

    FormData formData = FormData.fromMap({
      "id": userId,
      "country": country,
      "region": region,
      "district": district,
      "county": county,
      "sub_county": subCounty,
      "postal_code": postalCode,
      "address": address,
      "latitude": latitude,
      "longitude": longitude,
    });
    print(formData.fields);

    api_hitter.ApiResponse apiResponse = await api_hitter.ApiHitter()
        .getPostApiResponse(AppConstants.updateFarmerApi,
            headers: {'Authorization': 'Bearer ${getUserToken()}'},
            data: formData);

    if (apiResponse.status) {
      return ResponseOtpModel.fromJson(apiResponse.response!.data);
    } else {
      return ResponseOtpModel(status: 422, message: apiResponse.msg);
    }
  }

  Future<FarmerProfileModel> updateFarmApi(String farmSize,String dairyArea,
      String staffQuantity, String managerName,String managerPhone,String userId) async {

    FormData formData = FormData.fromMap({
      "id": userId,
      "farm_size": farmSize,
      "dairy_area": dairyArea,
      "staff_quantity": staffQuantity,
      "manager_name": managerName,
      "manager_phone": managerPhone,
    });
    print(formData.fields);

    api_hitter.ApiResponse apiResponse = await api_hitter.ApiHitter()
        .getPostApiResponse(AppConstants.updateFarmApi,
            data: formData,
            headers: {'Authorization': 'Bearer ${getUserToken()}'});

    if (apiResponse.status) {
      return FarmerProfileModel.fromJson(apiResponse.response!.data);
    } else {
      return FarmerProfileModel(status: 422, message: apiResponse.msg);
    }
  }

  Future<FarmerProfileModel> updateDdeFarmerDetail(String farmSize,String dairyArea,
      String staffQuantity, String managerName,String managerPhone,String userId,String landlineNumber,
      String farmingExperience,String gender,String dateOfBirth) async {

    FormData formData = FormData.fromMap({
      "id": userId,
      "farm_size": farmSize,
      "dairy_area": dairyArea,
      "staff_quantity": staffQuantity,
      "manager_name": managerName,
      "manager_phone": managerPhone,
      "landline_no": landlineNumber,
      "farming_experience": farmingExperience,
      "gender": gender,
      "date_of_birth": dateOfBirth,
    });
    print(formData.fields);

    api_hitter.ApiResponse apiResponse = await api_hitter.ApiHitter()
        .getPostApiResponse(AppConstants.updateFarmApi,
        data: formData,
        headers: {'Authorization': 'Bearer ${getUserToken()}'});

    if (apiResponse.status) {
      return FarmerProfileModel.fromJson(apiResponse.response!.data);
    } else {
      return FarmerProfileModel(status: 422, message: apiResponse.msg);
    }
  }


  ///////////////GetDistrict/////////////

  Future<ResponseDistrict> getDistrict() async {

    api_hitter.ApiResponse apiResponse = await api_hitter.ApiHitter()
        .getApiResponse(AppConstants.getDistrict, headers: {
      'Authorization': 'Bearer ${getUserToken()}'});

    if (apiResponse.status) {
      return ResponseDistrict.fromJson(apiResponse.response!.data);
    }else
    {
      return ResponseDistrict(status: 422, message: apiResponse.msg);
    }
  }

  ///////////////getCountyList/////////////
  Future<ResponseCountyList> getCountyByDistrictApi(String districtName) async {

    var data = {
      "districtname" : districtName
    };

    api_hitter.ApiResponse apiResponse = await api_hitter.ApiHitter()
        .getApiResponse(AppConstants.countyListApi, queryParameters: data ,headers: {
      'Authorization': 'Bearer ${getUserToken()}'});

    if (apiResponse.status) {
      return ResponseCountyList.fromJson(apiResponse.response!.data);
    }else
    {
      return ResponseCountyList(status: 422, message: apiResponse.msg);
    }
  }

  ///////////////getCountyList/////////////
  Future<ResponseValidateCountry> validatedAddressCountry(String country) async {

    var data = {"name" : country};

    api_hitter.ApiResponse apiResponse = await api_hitter.ApiHitter()
        .getApiResponse(AppConstants.validateCountry, queryParameters: data ,headers: {
      'Authorization': 'Bearer ${getUserToken()}'});

    if (apiResponse.status) {
      return ResponseValidateCountry.fromJson(apiResponse.response!.data);
    }else
    {
      return ResponseValidateCountry(status: 422, message: apiResponse.msg);
    }
  }

  ///////////////getSubCounty/////////////

  Future<ResponseSubCounty> getSubCountyApi(String id) async {

    var data = {
      "id" : id
    };

    api_hitter.ApiResponse apiResponse = await api_hitter.ApiHitter()
        .getApiResponse(AppConstants.subCountyListApi, queryParameters: data ,headers: {
      'Authorization': 'Bearer ${getUserToken()}'});

    if (apiResponse.status) {
      return ResponseSubCounty.fromJson(apiResponse.response!.data);
    }else
    {
      return ResponseSubCounty(status: 422, message: apiResponse.msg);
    }
  }

  getUserToken() {
    return sharedPreferences?.getString(AppConstants.token);
  }
}
