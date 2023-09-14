import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:glad/cubit/profile_cubit/profile_cubit.dart';
import 'package:glad/screen/custom_widget/custom_appbar.dart';
import 'package:glad/screen/custom_widget/custom_methods.dart';
import 'package:glad/screen/custom_widget/g_map.dart';
import 'package:glad/screen/dde_screen/farmer_personal_detail.dart';
import 'package:glad/screen/dde_screen/improvement_areas.dart';
import 'package:glad/screen/dde_screen/cows_and_yield.dart';
import 'package:glad/screen/farmer_screen/dashboard/supplied_to_pdfl.dart';
import 'package:glad/screen/farmer_screen/profile/farmer_profile.dart';
import 'package:glad/utils/color_resources.dart';
import 'package:glad/utils/extension.dart';
import 'package:glad/utils/helper.dart';
import 'package:glad/utils/images.dart';
import 'package:glad/utils/styles.dart';

class DdeFarmerDetail extends StatefulWidget {
  const DdeFarmerDetail({Key? key, required this.userId}) : super(key: key);
  final int userId;

  @override
  State<DdeFarmerDetail> createState() => _DdeFarmerDetailState();
}

class _DdeFarmerDetailState extends State<DdeFarmerDetail> {
  @override
  void initState() {
    BlocProvider.of<ProfileCubit>(context)
        .getFarmerProfile(context, userId: widget.userId.toString());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: BlocBuilder<ProfileCubit, ProfileCubitState>(
          builder: (context, state) {
        if (state.status == ProfileStatus.submit) {
          return const Center(
              child: CircularProgressIndicator(
            color: ColorResources.maroon,
          ));
        } else if (state.responseFarmerProfile == null) {
          return "${state.responseFarmerProfile} Api Error".textMedium();
        }
        else{
          return Stack(
            children: [
              landingBackground(),
              Column(
                children: [
                  CustomAppBar(
                    context: context,
                    titleText1: "Farmer Details",
                    action: Padding(
                      padding: const EdgeInsets.only(right: 8.0),
                      child: InkWell(
                          onTap: () {
                            const PersonalDetail().navigate();
                          },
                          child: SvgPicture.asset(Images.profileEdit)),
                    ),
                    leading: Padding(
                      padding: const EdgeInsets.only(left: 8.0),
                      child: InkWell(
                          onTap: () {
                            pressBack();
                          },
                          child: SvgPicture.asset(Images.arrowBack)),
                    ),
                    centerTitle: true,
                  ),
                  Expanded(
                    child: SingleChildScrollView(
                      child: Padding(
                        padding: const EdgeInsets.only(bottom: 90.0),
                        child: Column(
                          children: [
                            Container(
                              margin: const EdgeInsets.only(top: 31),
                              padding: const EdgeInsets.only(left: 20, right: 20),
                              height: 171,
                              child: Row(
                                children: [
                                  ClipRRect(
                                      borderRadius: BorderRadius.circular(15),
                                      child: CachedNetworkImage(
                                        imageUrl: state.responseFarmerProfile!
                                            .farmer!.photo ?? '',
                                        width: 117,
                                        height: 150,
                                        fit: BoxFit.cover,
                                        errorWidget: (_, __, ___) => Image.asset(
                                          Images.profileDemo,
                                          width: 117,
                                          height: 150,
                                          fit: BoxFit.cover,
                                        ),
                                      )),
                                  10.horizontalSpace(),
                                  Expanded(
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.start,
                                          children: [
                                            SvgPicture.asset(
                                              Images.kycUnverified,
                                              width: 30,
                                              height: 30,
                                            ),
                                            4.horizontalSpace(),
                                            Text('KYC Verified',
                                                style: figtreeMedium.copyWith(
                                                    fontSize: 12)),
                                          ],
                                        ),
                                        10.verticalSpace(),
                                        Text(
                                            state.responseFarmerProfile!.farmer!
                                                    .name ??
                                                '',
                                            style: figtreeMedium.copyWith(
                                                fontSize: 17)),
                                        5.verticalSpace(),
                                        Text(
                                            state.responseFarmerProfile!.farmer!
                                                    .phone ??
                                                '',
                                            style: figtreeRegular.copyWith(
                                              fontSize: 12,
                                            )),
                                        5.verticalSpace(),
                                        Text(
                                            state.responseFarmerProfile!.farmer!
                                                    .email ??
                                                '',
                                            style: figtreeRegular.copyWith(
                                              fontSize: 12,
                                            )),
                                      ],
                                    ),
                                  ),
                                  10.horizontalSpace(),
                                  Column(
                                    children: [
                                      SvgPicture.asset(
                                        Images.callPrimary,
                                        width: 37,
                                        height: 37,
                                      ),
                                      10.verticalSpace(),
                                      SvgPicture.asset(
                                        Images.whatsapp,
                                        width: 37,
                                        height: 37,
                                      ),
                                    ],
                                  )
                                ],
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(
                                  left: 20.0, right: 25, top: 22),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Row(
                                    children: [
                                      "${calculateAge(DateTime.parse(state.responseFarmerProfile!.farmer!.dateOfBirth ?? '2001-08-19'))} years old".textRegular(),
                                      10.horizontalSpace(),
                                      const CircleAvatar(
                                        radius: 4,
                                        backgroundColor: Colors.black,
                                      ),
                                      10.horizontalSpace(),
                                      "${state.responseFarmerProfile!.farmer!.farmingExperience ?? 25} years experience".textRegular(),
                                    ],
                                  ),
                                  const CustomIndicator(
                                    percentage: 53,
                                    width: 75,
                                  ),
                                ],
                              ),
                            ),
                            Padding(
                              padding:
                              const EdgeInsets.only(left: 20.0, right: 25),
                              child: Row(
                                children: [
                                  Expanded(
                                      child: "Luwum St. Rwoozi, Kampala"
                                          .textRegular(fontSize: 12)),
                                  "Critical".textMedium(fontSize: 12),
                                  23.horizontalSpace()
                                ],
                              ),
                            ),
                            Container(
                              margin: const EdgeInsets.only(
                                  left: 20, right: 20, top: 28),
                              width: screenWidth(),
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(20),
                                  color: Colors.white,
                                  boxShadow: [
                                    BoxShadow(
                                        color: Colors.grey.withOpacity(0.2),
                                        blurRadius: 16.0,
                                        offset: const Offset(0, 5)),
                                  ],
                                  border: Border.all(color: ColorResources.grey)),
                              padding:
                              const EdgeInsets.fromLTRB(18.0, 18, 18, 10),
                              child: Column(
                                children: [
                                  Row(
                                    mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                    children: [
                                      Column(
                                        crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                        children: [
                                          Text('${state.responseFarmerProfile!.farmer!.farmSize ?? 150} Acres',
                                              style: figtreeSemiBold.copyWith(
                                                  fontSize: 18)),
                                          Text('Farm Area',
                                              style: figtreeRegular.copyWith(
                                                  fontSize: 12)),
                                        ],
                                      ),
                                      10.horizontalSpace(),
                                      Column(
                                        crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                        children: [
                                          Text('${state.responseFarmerProfile!.farmer!.dairyArea ?? 150} Acres',
                                              style: figtreeSemiBold.copyWith(
                                                  fontSize: 18)),
                                          Text('Dairy area',
                                              style: figtreeRegular.copyWith(
                                                  fontSize: 12)),
                                        ],
                                      ),
                                      10.horizontalSpace(),
                                      Column(
                                        crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                        children: [
                                          Text('${state.responseFarmerProfile!.farmer!.staffQuantity ?? 5}',
                                              style: figtreeSemiBold.copyWith(
                                                  fontSize: 18)),
                                          Text('Members',
                                              style: figtreeRegular.copyWith(
                                                  fontSize: 12)),
                                        ],
                                      ),
                                    ],
                                  ),
                                  17.verticalSpace(),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Text('Managed by: ${state.responseFarmerProfile!.farmer!.managerName ?? 'Moses Emanuel'}',
                                          style: figtreeMedium.copyWith(
                                              fontSize: 12,
                                              color: const Color(0xff727272))),
                                      10.horizontalSpace(),
                                      Container(
                                        height: 5,
                                        width: 5,
                                        decoration: const BoxDecoration(
                                            color: Colors.black,
                                            shape: BoxShape.circle),
                                      ),
                                      10.horizontalSpace(),
                                      Text(state.responseFarmerProfile!.farmer!.managerPhone ?? '+256 758711344',
                                          style: figtreeMedium.copyWith(
                                              fontSize: 12,
                                              color: const Color(0xff727272))),
                                      30.verticalSpace()
                                    ],
                                  )
                                ],
                              ),
                            ),
                            30.verticalSpace(),
                            milkSupplyCardDetails(),
                            30.verticalSpace(),
                            cowsInTheFarm(state),
                            30.verticalSpace(),
                            address(context),
                            topPerformingFarmer(),
                            25.verticalSpace(),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              Positioned(
                  bottom: 20,
                  right: 20,
                  left: 20,
                  child: Container(
                    padding: const EdgeInsets.only(left: 25),
                    height: 75,
                    decoration: boxDecoration(
                        backgroundColor: ColorResources.primary,
                        borderRadius: 40),
                    child: Row(
                      children: [
                        Expanded(
                          child: InkWell(
                            onTap: () {
                              const ImprovementAreas().navigate();
                            },
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                "Improvement areas".textRegular(
                                    fontSize: 19, color: Colors.white),
                                "Based on the survey done by our experts!"
                                    .textRegular(
                                    fontSize: 12, color: Colors.white)
                              ],
                            ),
                          ),
                        ),
                        const Padding(
                          padding: EdgeInsets.only(right: 25),
                          child: CircleAvatar(
                            radius: 23,
                            backgroundColor: Color(0xffFC5E60),
                            child: Icon(Icons.arrow_forward_rounded),
                          ),
                        )
                      ],
                    ),
                  )),
            ],
          );
        }
      }),
    );
  }

  ///////////milkSupplyCardDetails/////////
  Widget milkSupplyCardDetails() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.fromLTRB(25, 0, 0, 0),
          child: Text(
            'Milk supply (last 6 months)',
            style: figtreeMedium.copyWith(fontSize: 18),
          ),
        ),
        10.verticalSpace(),
        InkWell(
          onTap: () {
            const SuppliedToPDFL().navigate();
          },
          child: Padding(
            padding: const EdgeInsets.fromLTRB(18, 0, 24, 0),
            child: Column(
              children: [
                Stack(
                  children: [
                    SizedBox(
                      height: 210,
                      child: Column(
                        children: [
                          Container(
                            height: 200,
                            decoration: BoxDecoration(boxShadow: [
                              BoxShadow(
                                  color: Colors.grey.withOpacity(.100),
                                  blurRadius: 15),
                            ]),
                            child: Card(
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(20)),
                              color: const Color(0xffFFB300),
                              child: Padding(
                                padding:
                                    const EdgeInsets.only(left: 24.0, right: 20),
                                child: Column(children: [
                                  28.verticalSpace(),
                                  Row(
                                    children: [
                                      Expanded(
                                        child: Text(
                                          '2000 Ltr',
                                          style:
                                              figtreeBold.copyWith(fontSize: 24),
                                        ),
                                      ),
                                      Expanded(
                                        child: Text(
                                          'UGX 75M',
                                          style:
                                              figtreeBold.copyWith(fontSize: 24),
                                        ),
                                      ),
                                      SvgPicture.asset(
                                        Images.menuIcon,
                                      )
                                    ],
                                  ),
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Expanded(
                                          child: "Total supply"
                                              .textMedium(fontSize: 16)),
                                      Expanded(
                                          child:
                                              "Worth".textMedium(fontSize: 16)),
                                      0.verticalSpace()
                                    ],
                                  ),
                                  28.verticalSpace(),
                                  Row(
                                    children: [
                                      Expanded(
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text("Matts Francesca",
                                                style: figtreeMedium.copyWith(
                                                    fontSize: 16,
                                                    color: Colors.black)),
                                            4.verticalSpace(),
                                            Row(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.end,
                                              children: [
                                                const Icon(
                                                  Icons.call,
                                                  color: Colors.black,
                                                  size: 16,
                                                ),
                                                Text("+22112 3232 3223",
                                                    style:
                                                        figtreeRegular.copyWith(
                                                            fontSize: 12,
                                                            color: Colors.black)),
                                              ],
                                            ),
                                            4.verticalSpace(),
                                            Row(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.end,
                                              children: [
                                                const Icon(
                                                  Icons.location_on,
                                                  color: Colors.black,
                                                  size: 16,
                                                ),
                                                SizedBox(
                                                  width: screenWidth() * 0.5,
                                                  child: Text(
                                                    "Luwum St. Rwoozi, Kampala...",
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
                                      CircleAvatar(
                                          radius: 27,
                                          backgroundColor: ColorResources.primary,
                                          child: "MCC".textBold(
                                              color: Colors.white, fontSize: 13)),
                                    ],
                                  ),
                                  28.verticalSpace(),
                                ]),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Positioned(
                      bottom: 0,
                      right: 10,
                      left: 10,
                      child: SvgPicture.asset(Images.cardImage),
                    )
                  ],
                ),
              ],
            ),
          ),
        ),
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
                // const EditAddress().navigate();
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
          padding: const EdgeInsets.fromLTRB(20.0, 0, 20, 0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Align(
                alignment: Alignment.centerLeft,
                child: Text('Cows in the farm',
                    style: figtreeMedium.copyWith(fontSize: 18)),
              ),
              InkWell(
                  onTap: () {
                    CowsAndYield().navigate();
                  },
                  child: SvgPicture.asset(Images.profileEdit))
            ],
          ),
        ),
        14.verticalSpace(),
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
                Wrap(children: [
                  for(int index = 0; index < state.responseFarmerProfile!.farmer!.cowBreedDetails!.length; index++)
                    InkWell(
                      onTap: () {
                        BlocProvider.of<ProfileCubit>(context).changeSelectedBreedIndex(index);
                      },
                      child: Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20),
                          color: state.selectedBreedIndex == index ? ColorResources.maroon : const Color(0xFFF9F9F9),
                        ),
                        padding: const EdgeInsets.all(10.0),
                        child: Text(
                          state.responseFarmerProfile!.farmer!.cowBreedDetails![index].breedName!,
                          style: figtreeRegular.copyWith(
                              fontSize: 12, color: state.selectedBreedIndex == index ? Colors.white: Colors.black),
                        ),
                      ),
                    ),
                ],),
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
                                text: state.responseFarmerProfile!.farmer!.cowBreedDetails![state.selectedBreedIndex!].milkingCows!.toString(),
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
                                text: '${state.responseFarmerProfile!.farmer!.cowBreedDetails![state.selectedBreedIndex!].yieldPerCow!.toString()} Ltr/Day',
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
                        Text(state.responseFarmerProfile!.farmer!.cowBreedDetails![state.selectedBreedIndex!].herdSize!.toString(),
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
                        Text(state.responseFarmerProfile!.farmer!.cowBreedDetails![state.selectedBreedIndex!].dryCows!.toString(),
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
                                    text: state.responseFarmerProfile!.farmer!.cowBreedDetails![state.selectedBreedIndex!].sixMonthCow.toString(),
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
                                    text: state.responseFarmerProfile!.farmer!.cowBreedDetails![state.selectedBreedIndex!].bullCalfs.toString() ?? '01',
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

  Widget topPerformingFarmer() {
    return Padding(
      padding: const EdgeInsets.only(left: 20.0, top: 30, right: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          "Top performing farmers".textMedium(fontSize: 18),
          25.verticalSpace(),
          SizedBox(
            height: 350,
            child: customList(
                axis: Axis.horizontal,
                child: (int index) {
                  return Padding(
                    padding: const EdgeInsets.only(right: 20.0),
                    child: Stack(
                      children: [
                        Container(
                          margin: 30.marginTop(),
                          height: 310,
                          width: screenWidth() - 140,
                          decoration: boxDecoration(
                              borderRadius: 18,
                              backgroundColor: const Color(0xffF9F9F9)),
                        ),
                        Positioned(
                            left: 0,
                            right: 0,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                CircleAvatar(
                                    radius: 35,
                                    child: Image.asset(Images.sampleUser,
                                        fit: BoxFit.cover,
                                        width: 70,
                                        height: 70)),
                                20.verticalSpace(),
                                "Hurton Elizabeth".textMedium(
                                    color: Colors.black, fontSize: 16),
                                4.verticalSpace(),
                                "1234 NW Bobcat Lane, St".textRegular(
                                    color: const Color(0xff727272)),
                                22.verticalSpace(),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    RichText(
                                      text: TextSpan(
                                        text: 'Milking Cows: ',
                                        style: figtreeRegular.copyWith(
                                            color: const Color(0xff727272)),
                                        children: <TextSpan>[
                                          TextSpan(
                                              text: '30',
                                              style: figtreeSemiBold.copyWith(
                                                  color:
                                                      const Color(0xff23262A))),
                                        ],
                                      ),
                                    ),
                                    10.horizontalSpace(),
                                    const CircleAvatar(
                                      radius: 4,
                                      backgroundColor: Color(0xff23262A),
                                    ),
                                    10.horizontalSpace(),
                                    RichText(
                                      text: TextSpan(
                                        text: 'Yield: ',
                                        style: figtreeRegular.copyWith(
                                            color: const Color(0xff727272)),
                                        children: <TextSpan>[
                                          TextSpan(
                                              text: '15 LTR',
                                              style: figtreeSemiBold.copyWith(
                                                  color:
                                                      const Color(0xff23262A))),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                                23.verticalSpace(),
                                Stack(
                                  children: [
                                    CircleAvatar(
                                        radius: 25,
                                        child: Image.asset(Images.sampleUser,
                                            fit: BoxFit.cover,
                                            width: 70,
                                            height: 70)),
                                    Padding(
                                      padding:
                                          const EdgeInsets.only(left: 40.0),
                                      child: CircleAvatar(
                                          radius: 25,
                                          child: Image.asset(Images.sampleUser,
                                              fit: BoxFit.cover,
                                              width: 70,
                                              height: 70)),
                                    ),
                                    Padding(
                                      padding:
                                          const EdgeInsets.only(left: 80.0),
                                      child: CircleAvatar(
                                          radius: 25,
                                          child: Image.asset(Images.sampleUser,
                                              fit: BoxFit.cover,
                                              width: 70,
                                              height: 70)),
                                    ),
                                  ],
                                ),
                                Container(
                                  margin: 20.marginTop(),
                                  width: 110,
                                  height: 45,
                                  child: customButton("Compare",
                                      borderColor: 0xFF6A0030,
                                      color: 0xFFffffff,
                                      fontColor: 0xFF6A0030,
                                      onTap: () {}),
                                )
                              ],
                            )),
                      ],
                    ),
                  );
                }),
          ),
        ],
      ),
    );
  }
}
