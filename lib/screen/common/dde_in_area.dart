import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:glad/cubit/landing_page_cubit/landing_page_cubit.dart';
import 'package:glad/screen/custom_widget/custom_methods.dart';
import 'package:glad/screen/guest_user/invite_our_friend.dart';
import 'package:glad/utils/app_constants.dart';
import 'package:glad/utils/color_resources.dart';
import 'package:glad/utils/extension.dart';
import 'package:glad/utils/images.dart';
import 'package:glad/utils/styles.dart';
import 'package:intl/intl.dart';

import '../guest_user/expert_followup_screen.dart';

class DDEInArea extends StatefulWidget {
  const DDEInArea(
      {super.key,
      required this.name,
      required this.phone,
      required this.image,
      this.state});
  final String name;
  final String phone;
  final String image;
  final LandingPageState? state;

  @override
  State<DDEInArea> createState() => _DDEInAreaState();
}

class _DDEInAreaState extends State<DDEInArea> {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.fromLTRB(20, 10, 0, 2),
          child: Text('Dairy Development Expert (DDE)',
              style: figtreeMedium.copyWith(fontSize: 18, color: Colors.black)),
        ),
        Padding(
          padding: const EdgeInsets.fromLTRB(20, 0, 0, 0),
          child: Text('In your area',
              style:
                  figtreeRegular.copyWith(fontSize: 14, color: Colors.black)),
        ),
        Stack(
          alignment: Alignment.center,
          children: [
            SizedBox(
                height: 110, width: MediaQuery.of(context).size.width * 0.8),
            Padding(
              padding: const EdgeInsets.fromLTRB(15.0, 15, 15, 10),
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  border:
                      Border.all(color: ColorResources.grey.withOpacity(0.5)),
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
                        ClipRRect(
                          borderRadius: BorderRadius.circular(1000),
                          child: Container(
                            height: AppBar().preferredSize.height * 0.7,
                            width: AppBar().preferredSize.height * 0.7,
                            decoration:
                                const BoxDecoration(shape: BoxShape.circle),
                            child: CachedNetworkImage(
                              imageUrl: widget.image,
                              errorWidget: (_, __, ___) =>
                                  Image.asset(Images.sampleUser),
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                        15.horizontalSpace(),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(widget.name,
                                style: figtreeMedium.copyWith(
                                    fontSize: 18, color: Colors.black)),
                            4.verticalSpace(),
                            Text(widget.phone,
                                style: figtreeRegular.copyWith(
                                    fontSize: 14, color: Colors.black)),
                          ],
                        ),
                      ],
                    ),
                    15.verticalSpace(),
                    BlocProvider.of<LandingPageCubit>(context)
                        .sharedPreferences
                        .getString(AppConstants.userId) ==
                        null ? BlocProvider.of<LandingPageCubit>(context)
                                .state
                                .guestDashboardResponse!
                                .data!
                                .enquiry ==
                            null || BlocProvider.of<LandingPageCubit>(context)
        .state
        .guestDashboardResponse!
        .data!
        .enquiry!.status == 'closed'
                        ? InkWell(
                            onTap: () {
                              BlocProvider.of<LandingPageCubit>(context).getCurrentLocation();
                              const InviteAnExpert().navigate();
                            },
                            child: Container(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(180),
                                border:
                                    Border.all(color: ColorResources.yellow),
                                color: const Color(0xFFFFF3F4),
                              ),
                              padding: const EdgeInsets.symmetric(
                                  vertical: 12.0, horizontal: 26),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text('Invite our expert',
                                          style: figtreeSemiBold.copyWith(
                                              fontSize: 22,
                                              color: Colors.black)),
                                      Text('to survey your farm',
                                          style: figtreeRegular.copyWith(
                                              fontSize: 14,
                                              color: Colors.black)),
                                    ],
                                  ),
                                  Image.asset(
                                    Images.loginButton,
                                    height: 40,
                                    width: 40,
                                  ),
                                ],
                              ),
                            ),
                          )
                        : InkWell(
                            onTap: () {
                              const ExpertFollowUpScreen().navigate();
                            },
                            child: Column(
                              children: [
                                'Invited on ${DateFormat('dd, MMMM, yyyy').format(DateTime.parse(widget.state!.guestDashboardResponse!.data!.enquiry!.createdAt!))} for survey'
                                    .textRegular(
                                        color: ColorResources.fieldGrey,
                                        fontSize: 14),
                                5.verticalSpace(),
                                Container(
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(180),
                                    border: Border.all(
                                        color: ColorResources.yellow),
                                    color: const Color(0xFFFFF3F4),
                                  ),
                                  padding: const EdgeInsets.symmetric(
                                      vertical: 12.0, horizontal: 26),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: [
                                      Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text('Followup',
                                              style: figtreeSemiBold.copyWith(
                                                  fontSize: 22,
                                                  color: Colors.black)),
                                          Text(
                                              'If the expert didn\'t turn up',
                                              style: figtreeRegular.copyWith(
                                                  fontSize: 14,
                                                  color: Colors.black)),
                                        ],
                                      ),
                                      Image.asset(
                                        Images.loginButton,
                                        height: 40,
                                        width: 40,
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ) : const SizedBox.shrink()
                  ],
                ),
              ),
            ),
            Positioned(
                top: 0,
                right: 10,
                child: Row(
                  children: [
                    InkWell(
                        onTap: () async {
                          await callOnMobile(widget.phone);
                        },
                        child: SvgPicture.asset(Images.callPrimary)),
                    6.horizontalSpace(),
                    InkWell(
                        onTap: () async {
                          await launchWhatsApp(widget.phone);
                        },
                        child: SvgPicture.asset(Images.whatsapp)),
                    16.horizontalSpace(),
                  ],
                )),
          ],
        )
      ],
    );
  }
}
