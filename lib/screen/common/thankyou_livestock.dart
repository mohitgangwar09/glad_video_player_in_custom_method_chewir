import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:glad/cubit/auth_cubit/auth_cubit.dart';
import 'package:glad/cubit/livestock_cubit/livestock_cubit.dart';
import 'package:glad/cubit/project_cubit/project_cubit.dart';
import 'package:glad/data/model/farmer_project_detail_model.dart';
import 'package:glad/data/model/response_add_livestock.dart';
import 'package:glad/screen/custom_widget/custom_methods.dart';
import 'package:glad/screen/dde_livestock/dde_my_farmer_ads.dart';
import 'package:glad/screen/dde_screen/dashboard/dashboard_dde.dart';
import 'package:glad/screen/farmer_screen/dashboard/dashboard_farmer.dart';
import 'package:glad/utils/app_constants.dart';
import 'package:glad/utils/color_resources.dart';
import 'package:glad/utils/extension.dart';
import 'package:glad/utils/images.dart';
import 'package:glad/utils/styles.dart';


class ThankYouLivestock extends StatelessWidget {
  const ThankYouLivestock({super.key, required this.response});
  final ResponseAddLivestock response;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Stack(
        children: [
          Positioned(left: 80, child: SvgPicture.asset(Images.addRemark1)),
          Positioned(
              bottom: 0, right: 0, child: SvgPicture.asset(Images.otpBack1)),
          Padding(
            padding: const EdgeInsets.only(top: 80, right: 20, left: 20),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    SvgPicture.asset(Images.addRemark),
                  ],
                ),
                SvgPicture.asset(
                  Images.done,
                  height: 78,
                  width: 78,
                ),
                10.verticalSpace(),
                // projectStatus == 'revoked'?'Revoked!'
                //     .textMedium(fontSize: 30, color: Colors.red):
                'Thank you!'
                    .textMedium(fontSize: 30, color: ColorResources.black),
                10.verticalSpace(),
                    Text(
                        'Your Livestock advertisement has been added successfully.',
                        textAlign: TextAlign.center,
                        style: figtreeRegular.copyWith(fontSize: 16,color: ColorResources.black,)),
                40.verticalSpace(),
                Column(children: [
                  Container(
                      padding: 2.marginAll(),
                      width: screenWidth()* 0.5,
                      height:140,child: ClipRRect(borderRadius: BorderRadius.circular(20),child: CachedNetworkImage(imageUrl: response.data!.liveStockDocumentFiles![0].originalUrl ?? '',fit: BoxFit.cover,))),
                  10.verticalSpace(),
                  Text(
                      '${response.data!.cowBreed!.name ?? ''} cow ',
                      style: figtreeMedium.copyWith(
                          fontSize: 18, color: Colors.black)),
                  20.verticalSpace(),
                  Text(
                      'Advertisement No.',
                      style: figtreeMedium.copyWith(
                          fontSize: 12, color: const Color(0xFF727272))),
                  // 2.verticalSpace(),
                  Text(
                      '${response.data!.advertisementNo ?? ''} ',
                      style: figtreeSemiBold.copyWith(
                          fontSize: 20, color: Colors.black)),
                ],),
                40.verticalSpace(),
                customButton("Back", fontColor: 0xffffffff, onTap: () {
                  if(BlocProvider.of<AuthCubit>(context).sharedPreferences.getString(AppConstants.userType) == "dde"){
                    const DdeMyLiveStockScreen(isNavigate:'yse').navigate(isInfinity: true);
                  }else{
                    BlocProvider.of<LivestockCubit>(context).myLivestockListApi(context, '');
                    pressBack();
                    pressBack();
                  }
                })
              ],
            ),
          )
        ],
      ),
    );
  }

  Widget profileDataWidget(FarmerMaster profileData,context){
    return Padding(
      padding: const EdgeInsets.fromLTRB(0.0, 20, 10, 20),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          border: Border.all(
            color: ColorResources.fieldGrey.withOpacity(0.5),
            width: 1,
          ),
          boxShadow: [
            BoxShadow(
                color: Colors.grey.withOpacity(0.5),
                blurRadius: 16.0,
                offset: const Offset(0, 5))
          ],
          color: Colors.white,
        ),
        padding: const EdgeInsets.all(15.0),
        child: Column(
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Image.asset(Images.sampleUser),
                10.horizontalSpace(),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [

                    Text(profileData.name??'',
                        style: figtreeMedium.copyWith(
                            fontSize: 16, color: Colors.black)),
                    4.verticalSpace(),
                    Text('+256 ${profileData.phone??''}',
                        style: figtreeRegular.copyWith(
                            fontSize: 14, color: Colors.black)),

                    4.verticalSpace(),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        const Icon(
                          Icons.location_on,
                          color: Colors.black,
                          size: 16,
                        ),
                        SizedBox(
                          width: MediaQuery.of(context).size.width *
                              0.5,
                          child: Text(profileData.address!=null?
                          profileData.address!.address!=null ?profileData.address!.address!.toString():"":"",
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: figtreeRegular.copyWith(
                              fontSize: 12,
                              color: Colors.black,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget improvementProfileDataWidget(FarmerProject profileData,context){
    return Padding(
      padding: const EdgeInsets.fromLTRB(0.0, 20, 10, 20),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          border: Border.all(
            color: ColorResources.fieldGrey.withOpacity(0.5),
            width: 1,
          ),
          boxShadow: [
            BoxShadow(
                color: Colors.grey.withOpacity(0.5),
                blurRadius: 16.0,
                offset: const Offset(0, 5))
          ],
          color: Colors.white,
        ),
        padding: const EdgeInsets.all(15.0),
        child: Column(
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Image.asset(Images.sampleUser),
                10.horizontalSpace(),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(profileData.name??'',
                        style: figtreeMedium.copyWith(
                            fontSize: 16, color: Colors.black)),
                    4.verticalSpace(),
                    Text('+256 ${profileData??''}',
                        style: figtreeRegular.copyWith(
                            fontSize: 14, color: Colors.black)),

                    4.verticalSpace(),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        const Icon(
                          Icons.location_on,
                          color: Colors.black,
                          size: 16,
                        ),
                        SizedBox(
                          width: MediaQuery.of(context).size.width *
                              0.5,
                          child: Text('need address'
                            /*farmerDetail.photo != null
                                    ? state.responseFarmerProjectDetail!.data!.farmerProject![0].dairyDevelopMentExecutive!.address["address"] != null
                                    && state.responseFarmerProjectDetail!.data!.farmerProject![0].dairyDevelopMentExecutive!.address["sub_county"] != null
                                    ? state.responseFarmerProjectDetail!.data!.farmerProject![0].dairyDevelopMentExecutive!.address["sub_county"] +
                                    state.responseFarmerProjectDetail!.data!.farmerProject![0].dairyDevelopMentExecutive!.address["address"]
                                    : ''
                                    : ''*/,
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: figtreeRegular.copyWith(
                              fontSize: 12,
                              color: Colors.black,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ],
            ),
            /* 10.verticalSpace(),
                        const Divider(),
                        Text(
                          'You may Call or WhatsApp to our experts for any query related to the farm.',
                          textAlign: TextAlign.center,
                          style: figtreeRegular.copyWith(fontSize: 12),
                        ),
                        10.verticalSpace(),*/
          ],
        ),
      ),
    );
  }

}