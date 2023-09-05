import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:glad/cubit/profile_cubit/profile_cubit.dart';
import 'package:glad/screen/custom_widget/custom_appbar.dart';
import 'package:glad/screen/custom_widget/custom_methods.dart';
import 'package:glad/screen/custom_widget/g_map.dart';
import 'package:glad/screen/farmer_screen/profile/edit_address.dart';
import 'package:glad/screen/farmer_screen/profile/kyc_update.dart';
import 'package:glad/utils/color_resources.dart';
import 'package:glad/utils/extension.dart';
import 'package:glad/utils/helper.dart';
import 'package:glad/utils/images.dart';
import 'package:glad/utils/styles.dart';
import 'edit_profile.dart';

class FarmerProfile extends StatefulWidget {
  const FarmerProfile({super.key});

  @override
  State<FarmerProfile> createState() => _FarmerProfileState();
}

class _FarmerProfileState extends State<FarmerProfile> {
  @override
  void initState() {
    super.initState();

    BlocProvider.of<ProfileCubit>(context).getFarmerProfile(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocBuilder<ProfileCubit, ProfileCubitState>(
          builder: (context, state) {
        if (state.status == ProfileStatus.submit) {
          return const Center(
              child: CircularProgressIndicator(
            color: ColorResources.maroon,
          ));
        }
        return Stack(
          children: [
            farmerBackground(),
            Column(
              children: [
                CustomAppBar(
                  context: context,
                  titleText1: 'My Profile',
                  titleText1Style:
                      figtreeMedium.copyWith(fontSize: 20, color: Colors.black),
                  centerTitle: true,
                  leading: arrowBackButton(),
                  action: Padding(
                    padding: const EdgeInsets.only(right: 10),
                    child: InkWell(
                        onTap: () {
                          const EditProfile(
                            section: 'personal',
                          ).navigate();
                        },
                        child: SvgPicture.asset(Images.profileEdit)),
                  ),
                ),
                Expanded(
                  child: SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        10.verticalSpace(),
                        profileData(state),
                        40.verticalSpace(),
                        farmDetails(state),
                        30.verticalSpace(),
                        dde(context, state),
                        20.verticalSpace(),
                        cowsInTheFarm(state),
                        30.verticalSpace(),
                        address(context),
                        facilitiesInTheFarm(),
                        20.verticalSpace(),
                      ],
                    ),
                  ),
                )
              ],
            ),
          ],
        );
      }),
    );
  }

  Widget profileData(ProfileCubitState state) {
    return Column(
      children: [
        InkWell(
          onTap: () {
            const EditProfile(section: 'personal').navigate();
          },
          child: SizedBox(
            width: 150,
            child: Stack(
              children: [
                ClipRRect(
                    borderRadius: BorderRadius.circular(25),
                    child: Image.network(
                      state.responseFarmerProfile!.farmer!.photo!,
                      errorBuilder: (_, __, ___) => Image.asset(
                        Images.profileDemo,
                        height: 130,
                        width: 130,
                      ),
                    )),
                Positioned.fill(
                    child: Align(
                        alignment: Alignment.centerRight,
                        child: SvgPicture.asset(Images.imageEdit)))
              ],
            ),
          ),
        ),
        10.verticalSpace(),
        InkWell(
          onTap: () {
            const KYCUpdate().navigate();
          },
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(state.responseFarmerProfile!.farmer!.name!,
                  style: figtreeMedium.copyWith(fontSize: 24)),
              4.horizontalSpace(),
              SvgPicture.asset(Images.kycUnverified)
            ],
          ),
        ),
        10.verticalSpace(),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(state.responseFarmerProfile!.farmer!.email!,
                style: figtreeRegular.copyWith(
                    fontSize: 14, decoration: TextDecoration.underline)),
            8.horizontalSpace(),
            Container(
              height: 5,
              width: 5,
              decoration: const BoxDecoration(
                  color: Colors.black, shape: BoxShape.circle),
            ),
            8.horizontalSpace(),
            Text(state.responseFarmerProfile!.farmer!.phone!,
                style: figtreeSemiBold.copyWith(fontSize: 14)),
          ],
        ),
        10.verticalSpace(),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Column(
              children: [
                Text(
                    state.responseFarmerProfile!.farmer!.farmingExperience!
                        .split(' years')[0],
                    style: figtreeSemiBold.copyWith(fontSize: 22)),
                Text('Years exp.',
                    style: figtreeRegular.copyWith(
                      fontSize: 12,
                    )),
              ],
            ),
            7.horizontalSpace(),
            SizedBox(
              height: 35,
              child: customPaint(Colors.black),
            ),
            7.horizontalSpace(),
            Column(
              children: [
                Text(
                    calculateAge(DateTime.parse(
                            state.responseFarmerProfile!.farmer!.dateOfBirth!))
                        .toString(),
                    style: figtreeSemiBold.copyWith(fontSize: 22)),
                Text('Years old',
                    style: figtreeRegular.copyWith(
                      fontSize: 12,
                    )),
              ],
            ),
            15.horizontalSpace(),
            Container(
                padding: const EdgeInsets.fromLTRB(20, 15, 20, 5),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  color: Colors.white,
                ),
                child: Column(
                  children: [
                    Text('Critical',
                        style: figtreeSemiBold.copyWith(
                          fontSize: 16,
                        )),
                    const CustomIndicator(
                      percentage: 69,
                      width: 122,
                    ),
                  ],
                ))
          ],
        ),
      ],
    );
  }

  Widget facilitiesInTheFarm() {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.fromLTRB(20.0, 30, 0, 0),
          child: Align(
            alignment: Alignment.centerLeft,
            child: Text('Facilities in the Farm',
                style: figtreeMedium.copyWith(fontSize: 18)),
          ),
        ),
        15.verticalSpace(),
        SizedBox(
          height: 120,
          child: ListView.separated(
            itemCount: 10,
            shrinkWrap: true,
            scrollDirection: Axis.horizontal,
            itemBuilder: (context, index) {
              return Padding(
                padding: EdgeInsets.only(left: index == 0 ? 20.0 : 0),
                child: Column(
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.circular(16.0),
                      child: Image.asset(
                        Images.facilities,
                      ),
                    ),
                    7.verticalSpace(),
                    Text(
                      'Water',
                      style: figtreeMedium.copyWith(
                          color: Colors.black, fontSize: 14),
                    )
                  ],
                ),
              );
            },
            separatorBuilder: (context, index) {
              return 10.horizontalSpace();
            },
          ),
        )
      ],
    );
  }

  Widget address(BuildContext context) {
    return Stack(
      children: [
        const GMap(
          lat: 28.4986,
          lng: 77.3999,
          height: 350,
          zoomGesturesEnabled: false,
          zoomControlsEnabled: false,
          myLocationEnabled: true,
          myLocationButtonEnabled: false,
        ),
        Positioned(
          bottom: 20,
          left: 30,
          right: 30,
          child: Container(
            height: 105,
            decoration: BoxDecoration(
                color: Colors.white, borderRadius: BorderRadius.circular(16)),
            child: Padding(
              padding: const EdgeInsets.all(15),
              child: Row(
                children: [
                  Image.asset(Images.sampleLivestock),
                  15.horizontalSpace(),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text('Address',
                          style: figtreeMedium.copyWith(
                              fontSize: 16, color: Colors.black)),
                      4.verticalSpace(),
                      SizedBox(
                        width: MediaQuery.of(context).size.width * 0.4,
                        child: Text(
                          'Plot 11,Luwum St. Rwoozi, Kampala, Uganda 23489 Plot 11,Luwum St. Rwoozi, Kampala, Uganda 23489',
                          style: figtreeRegular.copyWith(
                            fontSize: 14,
                            color: Colors.black,
                            overflow: TextOverflow.ellipsis,
                          ),
                          maxLines: 2,
                        ),
                      ),
                    ],
                  )
                ],
              ),
            ),
          ),
        ),
        Positioned(
          right: 20,
          top: 10,
          child: InkWell(
              onTap: () {
                const EditAddress().navigate();
              },
              child: SvgPicture.asset(Images.profileEdit)),
        ),
      ],
    );
  }

  Widget cowsInTheFarm(ProfileCubitState state) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.fromLTRB(20.0, 0, 0, 0),
          child: Align(
            alignment: Alignment.centerLeft,
            child: Text('Cows in the farm',
                style: figtreeMedium.copyWith(fontSize: 18)),
          ),
        ),
        10.verticalSpace(),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0),
          child: Container(
            width: screenWidth(),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                color: Colors.white,
                border: Border.all(color: ColorResources.grey)),
            padding: const EdgeInsets.all(18.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                    Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        color: ColorResources.maroon,
                      ),
                      padding: const EdgeInsets.all(10.0),
                      child: Text(
                        state.responseFarmerProfile!.farmer!.cowBreedDetails!.breedName!,
                        style: figtreeRegular.copyWith(
                            fontSize: 12, color: Colors.white),
                      ),
                    ),

                20.verticalSpace(),
                Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: const Color(0xFFFFF3F4),
                  ),
                  padding: const EdgeInsets.symmetric(
                      vertical: 16.5, horizontal: 16),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      RichText(
                          text: TextSpan(children: [
                        TextSpan(
                            text: 'Milking Cows  ',
                            style: figtreeRegular.copyWith(
                                fontSize: 14, color: const Color(0xFF727272))),
                        TextSpan(
                            text: state.responseFarmerProfile!.farmer!.cowBreedDetails!.milkingCows!.toString(),
                            style: figtreeSemiBold.copyWith(
                                fontSize: 14, color: Colors.black)),
                      ])),
                      SizedBox(
                        height: 20,
                        child: customPaint(const Color(0xFF999999)),
                      ),
                      RichText(
                          text: TextSpan(children: [
                        TextSpan(
                            text: 'Yield  ',
                            style: figtreeRegular.copyWith(
                                fontSize: 14, color: const Color(0xFF727272))),
                        TextSpan(
                            text: '${state.responseFarmerProfile!.farmer!.cowBreedDetails!.yieldPerCow!.toString()} Ltr/Day',
                            style: figtreeSemiBold.copyWith(
                                fontSize: 14, color: Colors.black)),
                      ])),
                    ],
                  ),
                ),
                20.verticalSpace(),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SvgPicture.asset(Images.herdSize),
                        10.verticalSpace(),
                        Text('Herd Size',
                            style: figtreeMedium.copyWith(fontSize: 14)),
                        4.verticalSpace(),
                        Text(state.responseFarmerProfile!.farmer!.cowBreedDetails!.heardSize!.toString(),
                            style: figtreeSemiBold.copyWith(fontSize: 18)),
                      ],
                    ),
                    10.horizontalSpace(),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SvgPicture.asset(Images.dryCows),
                        10.verticalSpace(),
                        Text('Dry Cows',
                            style: figtreeMedium.copyWith(fontSize: 14)),
                        4.verticalSpace(),
                        Text(state.responseFarmerProfile!.farmer!.cowBreedDetails!.dryCows!.toString(),
                            style: figtreeSemiBold.copyWith(fontSize: 18)),
                      ],
                    ),
                    10.horizontalSpace(),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SvgPicture.asset(Images.heifer),
                        10.verticalSpace(),
                        Text('Heifer',
                            style: figtreeMedium.copyWith(fontSize: 14)),
                        4.verticalSpace(),
                        Text('03',
                            style: figtreeSemiBold.copyWith(fontSize: 18)),
                      ],
                    ),
                  ],
                ),
                20.verticalSpace(),
                Row(
                  // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: Row(
                        children: [
                          RichText(
                              text: TextSpan(children: [
                                TextSpan(
                                    text: '7-12 month: ',
                                    style: figtreeRegular.copyWith(
                                        fontSize: 12,
                                        color: const Color(0xFF727272))),
                                TextSpan(
                                    text: '08',
                                    style: figtreeMedium.copyWith(
                                        fontSize: 12, color: Colors.black)),
                              ])),
                        ],
                      ),
                    ),
                    Container(
                      height: 4.5,
                      width: 4.5,
                      decoration: const BoxDecoration(
                          color: Colors.black, shape: BoxShape.circle),
                    ),
                    Expanded(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          RichText(
                              text: TextSpan(children: [
                                TextSpan(
                                    text: '<6 month: ',
                                    style: figtreeRegular.copyWith(
                                        fontSize: 12,
                                        color: const Color(0xFF727272))),
                                TextSpan(
                                    text: '02',
                                    style: figtreeRegular.copyWith(
                                        fontSize: 12, color: Colors.black)),
                              ])),
                          /*Container(
                          height: 4.5,
                          width: 4.5,
                          decoration: const BoxDecoration(
                              color: Colors.black, shape: BoxShape.circle),
                        ),*/
                        ],
                      ),
                    ),
                    Container(
                      height: 4.5,
                      width: 4.5,
                      decoration: const BoxDecoration(
                          color: Colors.black, shape: BoxShape.circle),
                    ),
                    Expanded(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          RichText(
                              text: TextSpan(children: [
                                TextSpan(
                                    text: 'Bull calf: ',
                                    style: figtreeRegular.copyWith(
                                        fontSize: 12,
                                        color: const Color(0xFF727272))),
                                TextSpan(
                                    text: state.responseFarmerProfile!.farmer!.cowBreedDetails!.bullCalfs.toString() ?? '01',
                                    style: figtreeMedium.copyWith(
                                        fontSize: 12, color: Colors.black)),
                              ])),
                        ],
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget dde(BuildContext context, ProfileCubitState state) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20.0),
      child: Stack(
        alignment: Alignment.center,
        children: [
          SizedBox(height: 200, width: screenWidth()),
          Container(
            height: 150,
            width: screenWidth(),
            decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(16),
                border: Border.all(color: ColorResources.grey)),
            child: Padding(
              padding: const EdgeInsets.fromLTRB(15.0, 16, 0, 10),
              child: Column(
                children: [
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Image.network(
                        state.responseFarmerProfile!.farmer!.dairyDevelopMentExecutive!.image ?? '',
                        errorBuilder: (_, __, ___) =>
                            Image.asset(Images.sampleUser),
                      ),
                      15.horizontalSpace(),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(state.responseFarmerProfile!.farmer!.dairyDevelopMentExecutive!.name!,
                              style: figtreeMedium.copyWith(
                                  fontSize: 16, color: Colors.black)),
                          4.verticalSpace(),
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                              const Icon(
                                Icons.call,
                                color: Colors.black,
                                size: 16,
                              ),
                              Text(
                                  state.responseFarmerProfile!.farmer!.dairyDevelopMentExecutive!.phone ??
                                      '+256 758711344',
                                  style: figtreeRegular.copyWith(
                                      fontSize: 12, color: Colors.black)),
                            ],
                          ),
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
                                width: MediaQuery.of(context).size.width * 0.6,
                                child: Text(
                                  'Plot 11, street 09, Luwum St. Rwooz Plot 11, street 09, Luwum St. Rwooz',
                                  style: figtreeRegular.copyWith(
                                    fontSize: 12,
                                    color: Colors.black,
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                ),
                              ),
                            ],
                          )
                        ],
                      )
                    ],
                  ),
                  const Padding(
                    padding: EdgeInsets.only(right: 15.0),
                    child: Divider(),
                  ),
                  Text(
                    'You may contact our Dairy Development Executive (DDE) for any assistance related to application processing.',
                    style: figtreeRegular.copyWith(fontSize: 12),
                    textAlign: TextAlign.center,
                  )
                ],
              ),
            ),
          ),
          Positioned(
              top: 0,
              right: 10,
              child: Row(
                children: [
                  SvgPicture.asset(Images.callPrimary),
                  6.horizontalSpace(),
                  SvgPicture.asset(Images.whatsapp),
                  6.horizontalSpace(),
                ],
              )),
          Positioned(
            left: 0,
            top: -4,
            child: Text('DDE', style: figtreeMedium.copyWith(fontSize: 18)),
          )
        ],
      ),
    );
  }

  Widget farmDetails(ProfileCubitState state) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.fromLTRB(20, 20, 20, 10),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text('Farm Details', style: figtreeMedium.copyWith(fontSize: 18)),
              InkWell(
                  onTap: () {
                    const EditProfile(
                      section: 'farm',
                    ).navigate();
                  },
                  child: SvgPicture.asset(Images.profileEdit))
            ],
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0),
          child: Container(
            width: screenWidth(),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                color: Colors.white,
                border: Border.all(color: ColorResources.grey)),
            padding: const EdgeInsets.all(18.0),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('${state.responseFarmerProfile!.farmer!.farmSize} Acres',
                            style: figtreeSemiBold.copyWith(fontSize: 18)),
                        Text('Farm Area',
                            style: figtreeRegular.copyWith(fontSize: 12)),
                      ],
                    ),
                    10.horizontalSpace(),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('${state.responseFarmerProfile!.farmer!.dairyArea} Acres',
                            style: figtreeSemiBold.copyWith(fontSize: 18)),
                        Text('Dairy area',
                            style: figtreeRegular.copyWith(fontSize: 12)),
                      ],
                    ),
                    10.horizontalSpace(),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('${state.responseFarmerProfile!.farmer!.staffQuantity}',
                            style: figtreeSemiBold.copyWith(fontSize: 18)),
                        Text('Members',
                            style: figtreeRegular.copyWith(fontSize: 12)),
                      ],
                    ),
                  ],
                ),
                25.verticalSpace(),
                Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: const Color(0xFFE4FFE3).withOpacity(1),
                  ),
                  padding:
                      const EdgeInsets.symmetric(vertical: 12, horizontal: 9),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text('Managed by: ${state.responseFarmerProfile!.farmer!.managerName}',
                          style: figtreeMedium.copyWith(fontSize: 12)),
                      4.horizontalSpace(),
                      Container(
                        height: 5,
                        width: 5,
                        decoration: const BoxDecoration(
                            color: Colors.black, shape: BoxShape.circle),
                      ),
                      4.horizontalSpace(),
                      Text('${state.responseFarmerProfile!.farmer!.managerPhone}',
                          style: figtreeMedium.copyWith(fontSize: 12)),
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
      ],
    );
  }
}

class CustomIndicator extends StatelessWidget {
  const CustomIndicator(
      {super.key, required this.percentage, required this.width});
  final int percentage;
  final double width;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 30,
      width: width,
      child: Stack(
        alignment: Alignment.centerLeft,
        children: [
          Container(
            width: width,
            height: 5,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                gradient: const LinearGradient(colors: [
                  Color(0xFF4BC56F),
                  Color(0xFFFEEB53),
                  Color(0xFFFC5E60)
                ])),
          ),
          Positioned(
              left: percentage.toDouble(),
              child: Material(
                elevation: 4,
                color: Colors.transparent,
                shadowColor: const Color(0xFF000029),
                shape: const CircleBorder(),
                child: Container(
                  height: 22,
                  width: 22,
                  decoration: BoxDecoration(
                      color: const Color(0xFFFC5E60),
                      border: Border.all(color: Colors.white, width: 2),
                      shape: BoxShape.circle),
                ),
              ))
        ],
      ),
    );
  }
}
