import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:glad/cubit/profile_cubit/profile_cubit.dart';
import 'package:glad/screen/custom_widget/custom_appbar.dart';
import 'package:glad/screen/custom_widget/custom_methods.dart';
import 'package:glad/utils/color_resources.dart';
import 'package:glad/utils/extension.dart';
import 'package:glad/utils/images.dart';
import 'package:glad/utils/styles.dart';

class CommonNotification extends StatelessWidget {
  const CommonNotification({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          landingBackground(),
          Column(
            children: [
              CustomAppBar(
                context: context,
                titleText1: "Notifications",
                action: InkWell(
                  onTap: () {
                    context.read<ProfileCubit>().readAllNotificationApi(context);
                  },
                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(0, 20, 10, 0),
                    child: Text(
                      'Mark all as read',
                      style: figtreeMedium.copyWith(
                          fontSize: 14, color: ColorResources.maroon),
                    ),
                  ),
                ),
                leading: arrowBackButton(),
              ),
              Expanded(child: SingleChildScrollView(child: notification()))
            ],
          )
        ],
      ),
    );
  }

  //////////Notification//////////////
  Widget notification() {
    return BlocBuilder<ProfileCubit, ProfileCubitState>(
      builder: (context, state) {
        if (state.status == ProfileStatus.loading) {
          return const SizedBox(
            height: 350,
            child: Center(
                child: CircularProgressIndicator(
                  color: ColorResources.maroon,
                )),
          );
        } else if (state.responseNotificationList == null) {
          return Center(child: Text("${state.responseNotificationList} Api Error"));
        }else{
          return customList(
              list: state.responseNotificationList!.data ?? [],
              child: (index) {
                return Container(
                  margin: const EdgeInsets.fromLTRB(10,10,10,5),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(14),
                    border: Border.all(
                      color: state.responseNotificationList!.data![index].readStatus == 'unread' ? ColorResources.mustard : const Color(0xFFDCDCDC),
                      width: 1,
                    ),
                  ),
                  constraints: const BoxConstraints(maxHeight: 80),
                  child: Row(
                    children: [
                      Container(
                        width: 8,
                        // height: 80,
                        decoration: BoxDecoration(
                            color: state.responseNotificationList!.data![index].readStatus == 'unread' ? ColorResources.mustard : const Color(0xFFDCDCDC),
                            borderRadius: const BorderRadius.only(
                                topLeft: Radius.circular(18),
                                bottomLeft: Radius.circular(18))),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(18.0, ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                SizedBox(
                                  width: screenWidth() * 0.7,
                                  child: Text(
                                    state.responseNotificationList!.data![index].body ?? '',
                                    maxLines: 4,
                                    style: figtreeMedium.copyWith(fontSize: 14),
                                  ),
                                ),
                                InkWell(
                                    onTap: () {
                                      context.read<ProfileCubit>().readNotificationApi(context, state.responseNotificationList!.data![index].id);
                                    },
                                    child: SvgPicture.asset(Images.farmerNotification)),
                              ],
                            ),
                            // 10.verticalSpace(),
                            // Row(
                            //   children: [
                            //     Text(
                            //       '04k views',
                            //       style: figtreeMedium.copyWith(
                            //           fontSize: 14, color: ColorResources.fieldGrey),
                            //     ),
                            //     8.horizontalSpace(),
                            //     Container(
                            //       height: 5,
                            //       width: 5,
                            //       decoration: const BoxDecoration(
                            //           color: Colors.black, shape: BoxShape.circle),
                            //     ),
                            //     8.horizontalSpace(),
                            //     Text(
                            //       'Farmer',
                            //       style: figtreeMedium.copyWith(
                            //           fontSize: 14, color: ColorResources.fieldGrey),
                            //     ),
                            //     8.horizontalSpace(),
                            //   ],
                            // ),
                          ],
                        ),
                      ),
                    ],
                  ),
                );
              });
        }
      }
    );
  }
}
