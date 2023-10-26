// import 'package:equatable/equatable.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:glad/data/model/improvement_area_list_model.dart';
// import 'package:glad/data/model/response_enquiry_detail.dart';
// import 'package:glad/data/model/response_enquiry_model.dart';
// import 'package:glad/data/repository/dde_repo.dart';
// import 'package:glad/screen/custom_widget/custom_methods.dart';
// import 'package:glad/utils/extension.dart';
// import 'package:glad/utils/helper.dart';
// import 'package:shared_preferences/shared_preferences.dart';
// import 'package:stepper_list_view/stepper_list_view.dart';
//
// part 'improvement_area_state.dart';
//
// class ImprovementAreaCubit extends Cubit<ImprovementAreaState> {
//   final SharedPreferences sharedPreferences;
//   final DdeRepository apiRepository;
//
//   ImprovementAreaCubit(
//       {required this.apiRepository, required this.sharedPreferences})
//       : super(ImprovementAreaState.initial());
//
//   // improvementAreaListApi
//   void improvementAreaListApi(context, int farmerId, showLoader, int improvementIndex) async {
//     if (showLoader) {
//       emit(state.copyWith(status: ImprovementAreaStatus.loading));
//     }
//     // customDialog(widget: launchProgress());
//     var response = await apiRepository.getImprovementArea(farmerId);
//     if (response.status == 200) {
//       // disposeProgress();
//       emit(state.copyWith(response: response));
//       getStepperData(improvementIndex);
//     } else {
//       emit(state.copyWith(status: ImprovementAreaStatus.error));
//       showCustomToast(context, response.message.toString());
//     }
//   }
//
//   getStepperData(index) {
//     List<FarmerImprovementArea> areaList = (state.response!)
//         .data!
//         .improvementAreaList![index]
//         .farmerImprovementArea!;
//     Results resultData =
//         (state.response!).data!.improvementAreaList![index].results!;
//     emit(state.copyWith(
//         status: ImprovementAreaStatus.success,
//         stepperData: List.generate(
//           areaList.length,
//           (index) => StepperItemData(
//             id: '$index',
//             content: {
//               'title': areaList[index].parameter,
//               'description': areaList[index].value,
//               'uom': areaList[index].uom,
//             },
//             avatar: "dot",
//           ),
//         ),
//         resultData: resultData));
//   }
//
//   // updateImprovementAreaApi
//   void updateImprovementAreaApi(
//       context, int farmerId, int improvementIndex) async {
//     // emit(state.copyWith(status: ImprovementAreaStatus.loading));
//     List<Map<String, dynamic>> updatedData = [];
//     for (int index = 0; index < state.areaControllers!.length; index++) {
//       updatedData.add({
//         'id': state.response!.data!.improvementAreaList![improvementIndex]
//             .farmerImprovementArea![index].id.toString(),
//         'value': state.areaControllers![index].text.toString()
//       });
//     }
//     customDialog(widget: launchProgress());
//     var response = await apiRepository.updateImprovementArea({
//       'farmer_id': farmerId.toString(),
//       'improvementAreaData': updatedData,
//     });
//     if (response.status == 200) {
//       disposeProgress();
//       showCustomToast(context, 'Improvement Area updated', isSuccess: true);
//       pressBack();
//       improvementAreaListApi(context, farmerId, false, improvementIndex);
//     } else {
//       emit(state.copyWith(status: ImprovementAreaStatus.error));
//       showCustomToast(context, response.message.toString());
//     }
//   }
//
//
//   void generateController(int improvementIndex) {
//     List<TextEditingController> con = [];
//     emit(state.copyWith(areaControllers: []));
//
//     for (FarmerImprovementArea area in state.response!.data!
//         .improvementAreaList![improvementIndex].farmerImprovementArea!) {
//       con.add(TextEditingController(text: area.value));
//       print(area.value);
//     }
//     emit(state.copyWith(areaControllers: [...con]));
//   }
// }
