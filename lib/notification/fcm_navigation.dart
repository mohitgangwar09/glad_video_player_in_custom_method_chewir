import 'package:get_it/get_it.dart';
import 'package:glad/screen/dde_screen/suggested_investment.dart';
import 'package:glad/screen/farmer_screen/common/active_project_detail.dart';
import 'package:glad/screen/farmer_screen/common/suggested_project_details.dart';
import 'package:glad/utils/app_constants.dart';
import 'package:glad/utils/extension.dart';
import 'package:shared_preferences/shared_preferences.dart';

class FcmNavigation {
  static void handleBackgroundStateNavigation(Map payload) {
    String userType =
        GetIt.instance<SharedPreferences>().getString(AppConstants.userType) ??
            '';
    if (userType == 'farmer') {
      if (payload["route"] == 'project') {
        if (payload["project_status"] == 'active') {
          ActiveProjectDetails(projectId: int.parse(payload["id"])).navigate();
        } else {
          SuggestedProjectDetails(projectId: int.parse(payload["id"]))
              .navigate();
        }
      }
    } else if (userType == 'dde') {
      if (payload["route"] == 'project') {
        DDeFarmerInvestmentDetails(
          projectId: int.parse(payload["id"]),
          // farmerDetail:farmerDetail
        ).navigate();
      }
    } else if (userType == 'mcc') {
    } else if (userType == 'supplier') {
    } else {}
  }
}
