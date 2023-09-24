import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:glad/cubit/profile_cubit/profile_cubit.dart';
import 'package:glad/data/model/response_district.dart';
import 'package:glad/utils/extension.dart';
import '../../utils/helper.dart';
import '../../utils/styles.dart';
import '../custom_widget/container_border.dart';
import '../custom_widget/custom_methods.dart';

class DistrictPicker extends StatelessWidget {
  const DistrictPicker({
    Key? key,
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
            child: BlocBuilder<ProfileCubit, ProfileCubitState>(
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
                                'Select a District'.tr,
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
                        showCross: state.addressSearchController.text.isNotEmpty,
                        controller: state.addressSearchController,
                        onChanged: (value) {
                          BlocProvider.of<ProfileCubit>(context).loginSearchCountryFilter(value,state.districtResponse!);
                        },
                        onTap: () {
                          BlocProvider.of<ProfileCubit>(context).changeSearchDistrictController(TextEditingController());
                        }),
                    state.districtResponse != null
                        ? state.districtResponse!.isNotEmpty
                            ? state.addressSearchController.text.isNotEmpty
                                ? showSearchData(
                                    state.searchDistrictList!, context)
                                : showCountryData(
                                    state.districtResponse!, context)
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
      List<DistrictData> listLoginCountryData, BuildContext context) {
    return showList(listLoginCountryData, context);
  }

  showSearchData(
      List<DistrictData> listLoginCountryData, BuildContext context) {
    return listLoginCountryData.isNotEmpty
        ? showList(listLoginCountryData, context)
        : const SizedBox();
  }

  showList(List<DistrictData> listDistrictData, BuildContext context) {
    return customList(
        child: (i) {
          var country = listDistrictData[i];
          return InkWell(
            onTap: () {
              BlocProvider.of<ProfileCubit>(context)
                  .changeDistrict(country.name.toString(),country.id.toString(),TextEditingController(text: country.name.toString()));
              BlocProvider.of<ProfileCubit>(context)
                  .changeSearchDistrictController(TextEditingController());
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
