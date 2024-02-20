import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:get_it/get_it.dart';
import 'package:glad/cubit/project_cubit/project_cubit.dart';
import 'package:glad/data/model/response_project_data_firebase.dart';
import 'package:glad/data/model/supplier_project_model.dart';
import 'package:glad/screen/chat/firebase_chat_screen.dart';
import 'package:glad/screen/dde_screen/dashboard_tab_screen/enquiry_screen.dart';
import 'package:glad/screen/dde_screen/suggested_investment.dart';
import 'package:glad/screen/farmer_screen/common/active_project_detail.dart';
import 'package:glad/screen/farmer_screen/common/suggested_project_details.dart';
import 'package:glad/screen/mcc_screen/dashboard_tab_screen/application_detail.dart';
import 'package:glad/screen/supplier_screen/project_details.dart';
import 'package:glad/screen/supplier_screen/survey_detail.dart';
import 'package:glad/utils/app_constants.dart';
import 'package:glad/utils/extension.dart';
import 'package:glad/utils/sharedprefrence.dart';
import 'package:shared_preferences/shared_preferences.dart';

class FcmNavigation {
  static void handleBackgroundStateNavigation(Map payload) {
    String userType =
        GetIt.instance<SharedPreferences>().getString(AppConstants.userType) ??
            '';
    if (userType == 'farmer') {
      if (payload["route"] == 'project') {
        if (payload["project_status"].toString() == 'active') {
          ActiveProjectDetails(projectId: int.parse(payload["id"])).navigate();
        } else {
          SuggestedProjectDetails(projectId: int.parse(payload["id"]))
              .navigate();
        }
      } else if (payload["route"] == 'project_chat') {
        _redirectProjectChatScreen(int.parse(payload["id"]), userType);
      } else {}
    } else if (userType == 'dde') {
      if (payload["route"] == 'project') {
        DDeFarmerInvestmentDetails(
          projectId: int.parse(payload["id"]),
        ).navigate();
      } else if (payload["route"] == 'project_chat') {
        _redirectProjectChatScreen(int.parse(payload["id"]), userType);
      } else if (payload["route"] == 'enquiry' || payload["route"] == 'enquiry_chat') {
        const EnquiryScreen().navigate();
      } else {}
    } else if (userType == 'mcc') {
      if (payload["route"] == 'project') {
        if (payload["project_status"].toString() == 'applied' ||
            payload["project_status"].toString() == 'revoked') {
          ApplicationDetail(
                  projectId: int.parse(payload["id"]),
                  selectedFilter: 'pending')
              .navigate();
        } else {
          ApplicationDetail(
                  projectId: int.parse(payload["id"]),
                  selectedFilter: 'approved')
              .navigate();
        }
      } else if (payload["route"] == 'project_chat') {
        _redirectProjectChatScreen(int.parse(payload["id"]), userType);
      } else {}
    } else if (userType == 'supplier') {
      if (payload["route"] == 'project') {
        if (payload["project_status"].toString() == 'survey_requested') {
          SurveyDetails(
                  projectId: int.parse(payload["id"]), selectedFilter: 'new')
              .navigate();
        } else if (payload["project_status"].toString() == 'verified' ||
            payload["project_status"].toString() == 'approved') {
          SurveyDetails(
                  projectId: int.parse(payload["id"]),
                  selectedFilter: 'completed')
              .navigate();
        } else {
          ProjectDetails(
                  projectId: int.parse(payload["id"]), selectedFilter: '')
              .navigate();
        }
      } else if (payload["route"] == 'project_chat') {
        _redirectProjectChatScreen(int.parse(payload["id"]), userType);
      } else {}
    } else {}
  }

  static void _redirectProjectChatScreen(int projectId, String userType) async {
    if (Get.key.currentContext != null) {
      await BlocProvider.of<ProjectCubit>(Get.key.currentContext!)
          .farmerProjectDetailApi(Get.key.currentContext!, projectId);
      ProjectState state =
          BlocProvider.of<ProjectCubit>(Get.key.currentContext!).state;
      FirebaseFirestore.instance
          .collection('projects_chats')
          .doc(projectId.toString())
          .set({
        'farmer_project_id': state
            .responseFarmerProjectDetail!.data!.farmerProject![0].id
            .toString(),
        'farmer_id': state.responseFarmerProjectDetail!.data!.farmerProject![0]
            .farmerMaster!.id
            .toString(),
        'dde_id': state.responseFarmerProjectDetail!.data!.farmerProject![0]
            .farmerMaster!.ddeId
            .toString(),
        'supplier_id':
            state.responseFarmerProjectDetail!.data!.supplierDetail != null
                ? state.responseFarmerProjectDetail!.data!.supplierDetail!.id
                    .toString()
                : "",
        'mcc_id': state.responseFarmerProjectDetail!.data!.farmerProject![0]
            .farmerMaster!.mccId
            .toString(),
        'admin_id': '',
        'project_name': state
            .responseFarmerProjectDetail!.data!.farmerProject![0].name
            .toString(),
        'created_at': Timestamp.now(),
        'farmer_name': state.responseFarmerProjectDetail!.data!
            .farmerProject![0].farmerMaster!.name
            .toString(),
        'farmer_address': state.responseFarmerProjectDetail!.data!
                    .farmerProject![0].farmerMaster!.address !=
                null
            ? state.responseFarmerProjectDetail!.data!.farmerProject![0]
                        .farmerMaster!.address!.address !=
                    null
                ? state.responseFarmerProjectDetail!.data!.farmerProject![0]
                    .farmerMaster!.address!.address!
                    .toString()
                : ''
            : '',
      }, SetOptions(merge: true));

      ResponseProjectDataForFirebase response = ResponseProjectDataForFirebase(
          projectName: state
              .responseFarmerProjectDetail!.data!.farmerProject![0].name!
              .toString(),
          farmerProjectId:
              state.responseFarmerProjectDetail!.data!.farmerProject![0].id,
          userName: await SharedPrefManager.getPreferenceString(
              AppConstants.userName),
          userType: userType,
          farmerId: state.responseFarmerProjectDetail!.data!.farmerProject![0]
              .farmerMaster!.id
              .toString(),
          ddeId: state.responseFarmerProjectDetail!.data!.farmerProject != null
              ? state.responseFarmerProjectDetail!.data!.farmerProject![0].ddeId
                  .toString()
              : '',
          mccId: state.responseFarmerProjectDetail!.data!.farmerProject![0].farmerMaster != null
              ? state.responseFarmerProjectDetail!.data!.farmerProject![0]
                  .farmerMaster!.mccId
                  .toString()
              : '',
          supplierId: state.responseFarmerProjectDetail!.data!.supplierDetail != null
              ? state.responseFarmerProjectDetail!.data!.supplierDetail!.id.toString()
              : '',
          farmerName: state.responseFarmerProjectDetail!.data!.farmerProject![0].farmerMaster!.name.toString(),
          farmerAddress: state.responseFarmerProjectDetail!.data!.farmerProject![0].farmerMaster!.address != null ? state.responseFarmerProjectDetail!.data!.farmerProject![0].farmerMaster!.address!.address.toString() : '',
          projectImage: state.responseFarmerProjectDetail!.data!.farmerProject![0].project["image"].toString());

      FirebaseChatScreen(responseProjectDataForFirebase: response).navigate();
    }
  }
}
