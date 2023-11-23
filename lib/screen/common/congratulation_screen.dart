import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:glad/cubit/project_cubit/project_cubit.dart';
import 'package:glad/screen/custom_widget/custom_methods.dart';
import 'package:glad/screen/dde_screen/dashboard/dashboard_dde.dart';
import 'package:glad/screen/farmer_screen/dashboard/dashboard_farmer.dart';
import 'package:glad/utils/extension.dart';
import 'package:glad/utils/images.dart';
import 'package:glad/utils/styles.dart';

class CongratulationScreen extends StatelessWidget {
  const CongratulationScreen({Key? key,required this.navigateFrom}) : super(key: key);
  final String navigateFrom;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocBuilder<ProjectCubit, ProjectState>(builder: (context, state){
          return Padding(
            padding: const EdgeInsets.all(35.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [

                SvgPicture.asset(Images.congratulation),

                15.verticalSpace(),

                "Congratulations!".toString().textMedium(fontSize: 34),

                10.verticalSpace(),

                "The project '${state.responseFarmerProjectDetail!=null?state.responseFarmerProjectDetail!.data!.farmerProject![0].name:'' ?? ''}' has been approved on behalf of the farmer. Our designated service provider will start the work as per schedule.".textRegular(fontSize: 16,
                textAlign: TextAlign.center),

                /*const SizedBox(height: 210,
                child: Stack(
                  children: [

                  ],
                ),),*/

                25.verticalSpace(),

                Row(
                  children: [
                    Expanded(
                      child: Stack(
                        children: [
                          InkWell(
                            onTap: (){
                            },
                            child: Padding(
                              padding: const EdgeInsets.only(top: 10.0),
                              child: customProjectContainer(
                                child: Padding(
                                  padding:
                                  const EdgeInsets.all(20),
                                  child: Column(
                                    crossAxisAlignment:
                                    CrossAxisAlignment.start,
                                    children: [
                                      15.verticalSpace(),
                                      Text(state.responseFarmerProjectDetail!.data!.farmerProject![0].farmerMaster!.name.toString() ?? '',
                                          style: figtreeMedium.copyWith(
                                              fontSize: 16,
                                              color: Colors.black)),

                                      5.verticalSpace(),

                                      Text('Farmer',
                                          style: figtreeMedium.copyWith(
                                              fontSize: 12,
                                              color: Colors.black)),

                                      10.verticalSpace(),
                                      Text('+256 ${state.responseFarmerProjectDetail!.data!.farmerProject![0].farmerMaster!.phone.toString() ?? ''}',
                                          style:
                                          figtreeRegular.copyWith(
                                              fontSize: 12,
                                              color: Colors.black)),
                                      10.verticalSpace(),
                                      Row(
                                        children: [
                                          Expanded(
                                            child: Text(
                                              state.responseFarmerProjectDetail!.data!.farmerProject![0].farmerMaster!.address!.address.toString() ?? '',
                                              maxLines: 2,
                                              style:
                                              figtreeRegular.copyWith(
                                                fontSize: 12,
                                                color: Colors.black,
                                                overflow:
                                                TextOverflow.ellipsis,
                                              ),
                                            ),
                                          ),
                                        ],
                                      )
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ),
                          Positioned(
                              left: 0,
                              right: 0,
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  ClipRRect(
                                    borderRadius: BorderRadius.circular(1000),
                                    child: Container(
                                      height: 60,
                                      width: 60,
                                      margin: const EdgeInsets.only(left: 15),
                                      decoration:
                                      const BoxDecoration(shape: BoxShape.circle),
                                      child: CachedNetworkImage(
                                        imageUrl:
                                        (state.responseFarmerProjectDetail!.data!.farmerProject![0].farmerMaster!= null) ? (state.responseFarmerProjectDetail!.data!.farmerProject![0].farmerMaster!.photo ?? '') : '',
                                        errorWidget: (_, __, ___) =>
                                            SvgPicture.asset(Images.person),
                                        fit: BoxFit.cover,
                                      ),
                                    ),
                                  ),
                                ],
                              )),
                        ],
                      ),
                    ),
                    Expanded(
                      child: Stack(
                        children: [
                          InkWell(
                            onTap: (){
                            },
                            child: Padding(
                              padding: const EdgeInsets.only(top: 10.0),
                              child: customProjectContainer(

                                child: Padding(
                                  padding:
                                  const EdgeInsets.all(20),
                                  child: Column(
                                    crossAxisAlignment:
                                    CrossAxisAlignment.start,
                                    children: [
                                      15.verticalSpace(),
                                      Text(state.responseFarmerProjectDetail!.data!.supplierDetail!.name ?? '',
                                          style: figtreeMedium.copyWith(
                                              fontSize: 16,
                                              color: Colors.black)),
                                      5.verticalSpace(),

                                      Text('Service Provider',
                                          style: figtreeMedium.copyWith(
                                              fontSize: 12,
                                              color: Colors.black)),
                                      10.verticalSpace(),
                                      Text('+256 ${state.responseFarmerProjectDetail!.data!.supplierDetail!.phone ?? ''}',
                                          style:
                                          figtreeRegular.copyWith(
                                              fontSize: 12,
                                              color: Colors.black)),
                                      10.verticalSpace(),
                                      Row(
                                        children: [
                                          Expanded(
                                            child: Text(
                                              'not come',
                                              maxLines: 2,
                                              style:
                                              figtreeRegular.copyWith(
                                                fontSize: 12,
                                                color: Colors.black,
                                                overflow:
                                                TextOverflow.ellipsis,
                                              ),
                                            ),
                                          ),
                                        ],
                                      )
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ),
                          Positioned(
                              left: 0,
                              right: 0,
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Align(
                                    alignment: Alignment.center,
                                    child: ClipRRect(
                                      borderRadius: BorderRadius.circular(1000),
                                      child: Container(
                                        height: 60,
                                        margin: const EdgeInsets.only(left: 15),
                                        width: 60,
                                        decoration:
                                        const BoxDecoration(shape: BoxShape.circle),
                                        child: CachedNetworkImage(
                                          imageUrl:
                                          (state.responseFarmerProjectDetail!.data!.supplierDetail.toString()!= null) ? (state.responseFarmerProjectDetail!.data!.supplierDetail!.image.toString() ?? '') : '',
                                          // '(state.responseDdeDashboard!.data != null) ? (state.responseDdeDashboard!.data!.dde!.photo ?? '')' : '',
                                          errorWidget: (_, __, ___) =>
                                              SvgPicture.asset(Images.person),
                                          fit: BoxFit.cover,
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              )),
                        ],
                      ),
                    ),
                  ],
                ),

                25.verticalSpace(),

                "You can track the status of your application from project section.".textRegular(fontSize: 14,textAlign: TextAlign.center),
                40.verticalSpace(),

                customButton("Go to Home", fontColor: 0xffffffff, onTap: () {
                  if(navigateFrom == "dde"){
                    const DashboardDDE(initialNavigateIndex: 0,).navigate(isInfinity: true);
                  }else{
                    const DashboardFarmer().navigate(isInfinity: true);
                  }
                })


              ],
            ),
          );
        }
      ),
    );
  }
}
