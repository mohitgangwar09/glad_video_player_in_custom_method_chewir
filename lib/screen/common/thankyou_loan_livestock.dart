import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:glad/cubit/auth_cubit/auth_cubit.dart';
import 'package:glad/cubit/dashboard_cubit/dashboard_cubit.dart';
import 'package:glad/cubit/landing_page_cubit/landing_page_cubit.dart';
import 'package:glad/cubit/livestock_cubit/livestock_cubit.dart';
import 'package:glad/screen/custom_widget/custom_methods.dart';
import 'package:glad/screen/dde_livestock/dde_my_farmer_ads.dart';
import 'package:glad/screen/farmer_screen/dashboard/dashboard_farmer.dart';
import 'package:glad/utils/app_constants.dart';
import 'package:glad/utils/color_resources.dart';
import 'package:glad/utils/extension.dart';
import 'package:glad/utils/images.dart';
import 'package:glad/utils/styles.dart';

import '../../data/model/livestock_cart_list.dart';


class ThankYouLivestockLoan extends StatelessWidget {
  const ThankYouLivestockLoan({super.key, required this.response});
  final FarmerMaster response;

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
                    'The loan application has been submitted successfully.',
                    textAlign: TextAlign.center,
                    style: figtreeRegular.copyWith(fontSize: 16,color: ColorResources.black,)),
                40.verticalSpace(),
                // response!=null?
                profileDataWidget(context),
                    // :const SizedBox.shrink(),
                40.verticalSpace(),
                customButton("Back", fontColor: 0xffffffff, onTap: () {
                  if(BlocProvider.of<AuthCubit>(context).sharedPreferences.getString(AppConstants.userType).toString() == "dde"){
                    const DdeMyLiveStockScreen().navigate();
                  }else{
                    const DashboardFarmer().navigate(isInfinity: true);
                    BlocProvider.of<DashboardCubit>(context).selectedIndex(3);
                  }
                })
              ],
            ),
          )
        ],
      ),
    );
  }

  Widget profileDataWidget(context){
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
                BlocProvider.of<LandingPageCubit>(context).state.response!.user!.farmerMaster!.photo!=null?
                networkImage(text: BlocProvider.of<LandingPageCubit>(context).state.response!.user!.farmerMaster!.photo!,height: 46,width: 46,radius: 40):
                Image.asset(Images.sampleUser),
                10.horizontalSpace(),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [

                    Text(BlocProvider.of<LandingPageCubit>(context).state.response!.user!.farmerMaster!.name!=null?BlocProvider.of<LandingPageCubit>(context).state.response!.user!.farmerMaster!.name!.toString():'',
                        style: figtreeMedium.copyWith(
                            fontSize: 16, color: Colors.black)),
                    4.verticalSpace(),
                    Text('+256 ${BlocProvider.of<LandingPageCubit>(context).state.response!.user!.farmerMaster!.phone!=null?BlocProvider.of<LandingPageCubit>(context).state.response!.user!.farmerMaster!.phone!.toString():''}',
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
                          child: Text(BlocProvider.of<LandingPageCubit>(context).state.response!.user!.farmerMaster!.address!=null?BlocProvider.of<LandingPageCubit>(context).state.response!.user!.farmerMaster!.address['address']!.toString():"",
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

}