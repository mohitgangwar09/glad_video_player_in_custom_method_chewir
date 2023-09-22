import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:glad/data/model/improvement_area_list_model.dart';
import 'package:glad/data/model/response_enquiry_detail.dart';
import 'package:glad/data/model/response_enquiry_model.dart';
import 'package:glad/data/repository/dde_repo.dart';
import 'package:glad/utils/extension.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:stepper_list_view/stepper_list_view.dart';

part 'improvement_area_state.dart';

class ImprovementAreaCubit extends Cubit<ImprovementAreaState> {
  final SharedPreferences sharedPreferences;
  final DdeRepository apiRepository;

  ImprovementAreaCubit(
      {required this.apiRepository, required this.sharedPreferences})
      : super(ImprovementAreaState.initial());

  // improvementAreaListApi
  void improvementAreaListApi(context, int farmerId) async {
    emit(state.copyWith(status: ImprovementAreaStatus.loading));
    // customDialog(widget: launchProgress());
    var response = await apiRepository.getImprovementArea(farmerId);
    if (response.status == 200) {
      // disposeProgress();
      emit(state.copyWith(response: response));
      getStepperData(0);
    } else {
      emit(state.copyWith(status: ImprovementAreaStatus.error));
      showCustomToast(context, response.message.toString());
    }
  }

  getStepperData(index) {
    List<FarmerImprovementArea> areaList =
        (state.response!)
            .data!
            .improvementAreaList![index]
            .farmerImprovementArea!;
    emit(state.copyWith(
        status: ImprovementAreaStatus.success,
        stepperData: List.generate(
          areaList.length,
          (index) => StepperItemData(
            id: '$index',
            content: {
              'title': areaList[index].parameter,
              'description': areaList[index].value
            },
            avatar: "dot",
          ),
        )));
  }
}
