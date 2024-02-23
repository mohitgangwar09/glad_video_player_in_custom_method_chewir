import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:glad/cubit/profile_cubit/profile_cubit.dart';
import 'package:glad/notification/fcm_navigation.dart';
import 'package:glad/screen/custom_widget/custom_appbar.dart';
import 'package:glad/screen/custom_widget/custom_methods.dart';
import 'package:glad/utils/color_resources.dart';
import 'package:glad/utils/extension.dart';
import 'package:glad/utils/images.dart';
import 'package:glad/utils/styles.dart';
import 'package:intl/intl.dart';

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
                action: BlocBuilder<ProfileCubit, ProfileCubitState>(
                    builder: (context, state) {
                      if (state.status == ProfileStatus.loading) {
                          return const SizedBox.shrink();
                      } else if (state.responseNotificationList == null) {
                          return const SizedBox.shrink();
                      } else  {
                          return Builder(
                            builder: (context) {
                              int count = 0;
                              if(state.responseNotificationList != null) {
                                for (var data in state.responseNotificationList!.data ?? []) {
                                  if (data.readStatus == 'unread') {
                                    count++;
                                  }
                                }
                              }
                              if(count > 0) {
                                return InkWell(
                                  onTap: () {
                                    context.read<ProfileCubit>()
                                        .readAllNotificationApi(context);
                                  },
                                  child: Padding(
                                    padding: const EdgeInsets.fromLTRB(
                                        0, 20, 10, 0),
                                    child: Text(
                                      'Mark all as read',
                                      style: figtreeMedium.copyWith(
                                          fontSize: 14,
                                          color: ColorResources.maroon),
                                    ),
                                  ),
                                );
                              } else {
                                return const SizedBox.shrink();
                              }
                            }
                          );
                    }
                  }
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
          return Padding(
            padding: const EdgeInsets.all(10),
            child: customList(
                list: state.responseNotificationList!.data ?? [],
                child: (index) {
                  return Padding(
                    padding: const EdgeInsets.only(bottom: 10),
                    child: InkWell(
                      onTap: () {
                        context.read<ProfileCubit>().readNotificationApi(context, state.responseNotificationList!.data![index].id);
                        Map route = {'route': state.responseNotificationList!.data![index].route ?? '', 'id': (state.responseNotificationList!.data![index].routeID ?? '').toString()};
                        print(route);
                        FcmNavigation.handleBackgroundStateNavigation(route);
                      },
                      child: Container(
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(14),
                          border: Border.all(
                            color: state.responseNotificationList!.data![index].readStatus == 'unread' ? ColorResources.mustard : const Color(0xFFDCDCDC),
                            width: 1,
                          ),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(18.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  SizedBox(
                                    width: screenWidth() * 0.7,
                                    child: Text(
                                      state.responseNotificationList!.data![index].body ?? '',
                                      style: figtreeMedium.copyWith(fontSize: 14),
                                    ),
                                  ),
                                  if(state.responseNotificationList!.data![index].readStatus == 'unread')
                                    SvgPicture.asset(Images.farmerNotification),
                                ],
                              ),
                              10.verticalSpace(),
                              Row(
                                children: [
                                  Text(
                                    DateFormat('EEEE, h:mm a').format(DateTime.parse(state.responseNotificationList!.data![index].createdAt!)),
                                    style: figtreeMedium.copyWith(
                                        fontSize: 14, color: ColorResources.fieldGrey),
                                  ),
                                  12.horizontalSpace(),
                                  Container(
                                    height: 5,
                                    width: 5,
                                    decoration: const BoxDecoration(
                                        color: Colors.black, shape: BoxShape.circle),
                                  ),
                                  12.horizontalSpace(),
                                  Text(
                                    formatProjectStatus(state.responseNotificationList!.data![index].userType ?? ''),
                                    style: figtreeMedium.copyWith(
                                        fontSize: 14, color: ColorResources.fieldGrey),
                                  ),
                                  8.horizontalSpace(),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  );
                }),
          );
        }
      }
    );
  }
}
