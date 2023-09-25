import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:glad/cubit/cowsandyieldsum/cowsandyieldcubit.dart';
import 'package:glad/cubit/dde_farmer_cubit/dde_farmer_cubit.dart';
import 'package:glad/cubit/profile_cubit/profile_cubit.dart';
import 'package:glad/data/model/response_breed.dart';
import 'package:glad/data/model/response_district.dart';
import 'package:glad/screen/extra_screen/cowsandyieldsum.dart';
import 'package:glad/screen/extra_screen/profile_navigate.dart';
import 'package:glad/utils/extension.dart';
import '../../utils/helper.dart';
import '../../utils/styles.dart';
import '../custom_widget/container_border.dart';
import '../custom_widget/custom_methods.dart';

class BreedPicker extends StatelessWidget {
  final int index;
  const BreedPicker({
    Key? key,
    required this.index
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: ContainerBorder(
          height: screenHeight(),
          margin: 0.marginOnly(top: 0, bottom: 0,),
          padding:
          const EdgeInsets.only(left: 0, right: 0, top: 20, bottom: 20),
          backColor: 0xffF3F2F9,
          radius: 0,
          width: screenWidth(),
          widget: GestureDetector(
            onTap: () {
              FocusScope.of(context).requestFocus(FocusNode());
            },
            child: BlocBuilder<DdeFarmerCubit, DdeState>(
                builder: (BuildContext context, state) {
                  return SingleChildScrollView(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Stack(
                          children: [
                            Align(
                              alignment: Alignment.topLeft,
                              child: InkResponse(
                                onTap: () {
                                  pressBack();
                                },
                                child: Padding(
                                  padding: 15.paddingOnly(top: 8, bottom: 8),
                                  child: const Icon(
                                    Icons.clear,
                                    size: 30,
                                    color: Color(0xff2A303A),
                                  ),
                                ),
                              ),
                            ),
                            Align(
                              alignment: Alignment.topCenter,
                              child: TextButton(
                                  onPressed: () {
                                    // pressBack();
                                  },
                                  child: Text(
                                    'Select Breed'.tr,
                                    style: figtreeMedium.copyWith(
                                      color: Colors.black,
                                      fontSize: 22,
                                      //  decoration: TextDecoration.underline
                                    ),
                                  )),
                            ),
                          ],
                        ),
                        10.verticalSpace(),
                        searchBox(
                            enabledSearch: true,
                            width: screenWidth() - 140,
                            showCross: state.breedSearchController.text.isNotEmpty,
                            controller: state.breedSearchController,
                            onChanged: (value) {
                              BlocProvider.of<DdeFarmerCubit>(context).searchBreedFilter(value,state.breedResponse!);
                            },
                            onTap: () {
                              BlocProvider.of<DdeFarmerCubit>(context).changeSearchBreedController(TextEditingController());
                            }),
                        state.breedResponse != null
                            ? state.breedResponse!.isNotEmpty
                            ? state.breedSearchController.text.isNotEmpty
                            ? showSearchData(
                            state.searchBreedList!, context)
                            : showCountryData(
                            state.breedResponse!, context)
                            : const SizedBox()
                            : Text(
                          "Error",
                          textAlign: TextAlign.center,
                          style: figtreeBold.copyWith(
                            color: const Color(0xff000000),
                            fontSize: 20,
                          ),
                        ),
                      ],
                    ),
                  );
                }),
          )),
    );
  }

  showCountryData(
      List<DataBreed> listLoginCountryData, BuildContext context) {
    return showList(listLoginCountryData, context);
  }

  showSearchData(
      List<DataBreed> listLoginCountryData, BuildContext context) {
    return listLoginCountryData.isNotEmpty
        ? showList(listLoginCountryData, context)
        : const SizedBox();
  }

  showList(List<DataBreed> listDistrictData, BuildContext context) {
    return customList(
        child: (i) {
          var country = listDistrictData[i];
          return InkWell(
            onTap: () {
              // for(int i=0;i<CowsAndYieldsDDEFarmerState.requestData.length;i++){
              for(int i=0;i<CowsAndYieldsSumState.requestData.length;i++){
                // print(CowsAndYieldsDDEFarmerState.requestData[i].cowBreedId);
                if(CowsAndYieldsSumState.requestData[i].cowBreedId.toString() == country.id.toString()){
                  showCustomToast(context, "Breed Already exist");
                  return;
                }
              }
              BlocProvider.of<CowsAndYieldCubit>(context)
                  .changeBreed(country.name.toString(),country.id.toString(),index);
              BlocProvider.of<DdeFarmerCubit>(context)
                  .changeBreed(country.name.toString(),country.id.toString());
              BlocProvider.of<DdeFarmerCubit>(context)
                  .changeSearchBreedController(TextEditingController());
              disposeProgress();
            },
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Padding(
                  padding: 15.paddingAll(),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      Expanded(
                        child: Text(
                          country.name!,
                          style: figtreeRegular.copyWith(
                            color: const Color(0xff000000),
                            fontSize: 18,
                          ),
                        ),
                      ),
                      //const  Expanded(child: SizedBox()),
                    ],
                  ),
                ),
                seprator()
              ],
            ),
          );
        },
        list: listDistrictData);
  }
}
