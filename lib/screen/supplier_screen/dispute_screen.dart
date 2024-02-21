import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:glad/cubit/project_cubit/project_cubit.dart';
import 'package:glad/data/model/farmer_project_detail_model.dart';
import 'package:glad/screen/custom_widget/custom_methods.dart';
import 'package:glad/screen/dde_screen/dashboard/dashboard_dde.dart';
import 'package:glad/screen/farmer_screen/dashboard/dashboard_farmer.dart';
import 'package:glad/screen/supplier_screen/dashboard/dashboard_supplier.dart';
import 'package:glad/utils/app_constants.dart';
import 'package:glad/utils/color_resources.dart';
import 'package:glad/utils/extension.dart';
import 'package:glad/utils/images.dart';
import 'package:glad/utils/styles.dart';

class DisputeScreen extends StatefulWidget {
  const DisputeScreen({super.key, required this.project});
  final Data project;

  @override
  State<DisputeScreen> createState() => _DisputeScreenState();
}

class _DisputeScreenState extends State<DisputeScreen> {
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
                  Images.cancelImage,
                  height: 78,
                  width: 78,
                ),
                'Dispute!'
                    .textMedium(fontSize: 30, color: ColorResources.pinkReg),
                10.verticalSpace(),
                'Dispute request has been raised successfully.'
                    .textRegular(fontSize: 16, color: Colors.black),
                30.verticalSpace(),
                Container(
                  width: screenWidth(),
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(16),
                      border: Border.all(color: ColorResources.grey)),
                  child: Padding(
                    padding: const EdgeInsets.all(15),
                    child: Column(
                      children: [
                        Container(
                          width: screenWidth(),
                          padding: const EdgeInsets.symmetric(
                              vertical: 8, horizontal: 14),
                          decoration: BoxDecoration(
                              color: const Color(0xFFFFF3F4),
                              borderRadius: BorderRadius.circular(10)),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                widget.project.farmerProject![0].name ?? '',
                                style: figtreeMedium.copyWith(fontSize: 16),
                              ),
                              Text(
                                widget.project.farmerProject![0].improvementArea != null ? (widget.project.farmerProject![0]
                                    .improvementArea!.name ?? '') : '',
                                style: figtreeRegular.copyWith(
                                    fontSize: 12, color: const Color(0xFF808080)),
                              ),
                            ],
                          ),
                        ),
                        10.verticalSpace(),
                        Builder(
                          builder: (context) {
                            String type = context.read<ProjectCubit>().sharedPreferences.getString(AppConstants.userType)!;
                            return Row(
                              children: [
                                if(type != "farmer")
                                  (widget.project.farmerProject![0].farmerMaster!= null) ? Expanded(
                                  child: Stack(
                                    alignment: Alignment.topCenter,
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
                                                  Text(widget.project.farmerProject![0].farmerMaster!.name.toString() ?? '',
                                                      style: figtreeMedium.copyWith(
                                                          fontSize: 16,
                                                          color: Colors.black)),

                                                  5.verticalSpace(),

                                                  Text('Farmer',
                                                      style: figtreeMedium.copyWith(
                                                          fontSize: 12,
                                                          color: Colors.black)),

                                                  10.verticalSpace(),
                                                  Text('+256 ${widget.project.farmerProject![0].farmerMaster!.phone.toString() ?? ''}',
                                                      style:
                                                      figtreeRegular.copyWith(
                                                          fontSize: 12,
                                                          color: Colors.black)),
                                                  10.verticalSpace(),
                                                  Row(
                                                    children: [
                                                      Expanded(
                                                        child: Text(
                                                          widget.project.farmerProject![0].farmerMaster!.address != null
                                                              ? widget.project.farmerProject![0].farmerMaster!.address!.address ?? ''
                                                              : '',
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
                                      networkImage(text: (widget.project.farmerProject![0].farmerMaster!= null) ? (widget.project.farmerProject![0].farmerMaster!.photo ?? '') : '', height: 60, width: 60, size: 40, radius: 100),
                                    ],
                                  ),
                                ) : const SizedBox.shrink(),
                                if(type != "dde")
                                  (widget.project.farmerProject![0].dairyDevelopMentExecutive!= null) ? Expanded(
                                  child: Stack(
                                    alignment: Alignment.topCenter,
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
                                                  Text(widget.project.farmerProject![0].dairyDevelopMentExecutive!.name.toString() ?? '',
                                                      style: figtreeMedium.copyWith(
                                                          fontSize: 16,
                                                          color: Colors.black)),

                                                  5.verticalSpace(),

                                                  Text('DDE',
                                                      style: figtreeMedium.copyWith(
                                                          fontSize: 12,
                                                          color: Colors.black)),

                                                  10.verticalSpace(),
                                                  Text('+256 ${widget.project.farmerProject![0].dairyDevelopMentExecutive!.phone.toString() ?? ''}',
                                                      style:
                                                      figtreeRegular.copyWith(
                                                          fontSize: 12,
                                                          color: Colors.black)),
                                                  10.verticalSpace(),
                                                  Row(
                                                    children: [
                                                      Expanded(
                                                        child: Text(
                                                          widget.project.farmerProject![0].dairyDevelopMentExecutive!.address != null
                                                              ? widget.project.farmerProject![0].dairyDevelopMentExecutive!.address["address"] ?? ''
                                                              : '',
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
                                      networkImage(text: (widget.project.farmerProject![0].dairyDevelopMentExecutive!= null) ? (widget.project.farmerProject![0].dairyDevelopMentExecutive!.photo ?? '') : '', height: 60, width: 60, size: 40, radius: 100),
                                    ],
                                  ),
                                ) : const SizedBox.shrink(),
                                if(type != "supplier")
                                  widget.project.supplierDetail != null ? Expanded(
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
                                                  Text(widget.project.supplierDetail!.name ?? '',
                                                      style: figtreeMedium.copyWith(
                                                          fontSize: 16,
                                                          color: Colors.black)),
                                                  5.verticalSpace(),

                                                  Text('Service Provider',
                                                      style: figtreeMedium.copyWith(
                                                          fontSize: 12,
                                                          color: Colors.black)),
                                                  10.verticalSpace(),
                                                  Text('+256 ${widget.project.supplierDetail!.phone ?? ''}',
                                                      style:
                                                      figtreeRegular.copyWith(
                                                          fontSize: 12,
                                                          color: Colors.black)),
                                                  10.verticalSpace(),
                                                  Row(
                                                    children: [
                                                      Expanded(
                                                        child: Text(
                                                          widget.project.supplierDetail!.address["address"] ?? '',
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
                                      networkImage(text: widget.project.supplierDetail != null ? (widget.project.supplierDetail!.photo.toString() == false.toString() ? '' : widget.project.supplierDetail!.photo ?? '') : '', height: 60, width: 60, size: 40, radius: 100),
                                    ],
                                  ),
                                ) : const SizedBox.shrink(),
                              ],
                            );
                          }
                        ),
                      ],
                    ),
                  ),
                ),
                40.verticalSpace(),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 35),
                  child:
                  'Your project will be put on hold until the dispute is resolved.'
                      .textRegular(
                      fontSize: 16,
                      color: Colors.black,
                      textAlign: TextAlign.center),
                ),
                40.verticalSpace(),
                customButton("Go to Home",
                    fontColor: 0xffffffff,
                    onTap: () {
                      String type = context.read<ProjectCubit>().sharedPreferences.getString(AppConstants.userType)!;
                      if(type == "dde"){
                        const DashboardDDE().navigate(isInfinity: true);
                      }else if(type == "farmer"){
                        const DashboardFarmer().navigate(isInfinity: true);
                      } else {
                        const DashboardSupplier().navigate(isInfinity: true);
                      }
                    })
              ],
            ),
          )
        ],
      ),
    );
  }
}
