import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:glad/cubit/community_cubit/community_cubit.dart';
import 'package:glad/cubit/livestock_cubit/livestock_cubit.dart';
import 'package:glad/data/model/response_project_data_firebase.dart';
import 'package:glad/screen/chat/firebase_chat_screen.dart';
import 'package:glad/screen/common/friend_chat.dart';
import 'package:glad/screen/custom_widget/custom_appbar.dart';
import 'package:glad/screen/custom_widget/custom_methods.dart';
import 'package:glad/screen/custom_widget/custom_textfield.dart';
import 'package:glad/screen/dde_screen/suggested_investment.dart';
import 'package:glad/screen/farmer_screen/drawer_screen/chat_screen.dart';
import 'package:glad/screen/livestock/enquiry/livestock_enquiry_seller_chat.dart';
import 'package:glad/utils/app_constants.dart';
import 'package:glad/utils/color_resources.dart';
import 'package:glad/utils/extension.dart';
import 'package:glad/utils/images.dart';
import 'package:glad/utils/sharedprefrence.dart';
import 'package:glad/utils/styles.dart';

class FriendList extends StatefulWidget {
  const FriendList({super.key});

  @override
  State<FriendList> createState() => _FriendListState();
}

class _FriendListState extends State<FriendList> {

  @override
  void initState() {
    BlocProvider.of<CommunityCubit>(context).friendListApi(context);
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          landingBackground(),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CustomAppBar(
                  context: context,
                  centerTitle: true,
                  titleText1: 'Friend List',
                  leading: arrowBackButton()),
              Expanded(
                child: SingleChildScrollView(
                  child: Padding(
                    padding:
                    const EdgeInsets.only(left: 18.0, right: 18, top: 20),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const CustomTextField(
                          hint: 'Search message...',
                          leadingImage: Images.search,
                          imageColors: Colors.black,
                          radius: 60,
                        ),
                        0.verticalSpace(),
                        BlocBuilder<CommunityCubit, CommunityCubitState>(
                            builder: (context, state)
                              {
                                if (state.status == CommunityStatus.submit) {
                                  return const Center(
                                      child: CircularProgressIndicator(
                                        color: ColorResources.maroon,
                                      ));
                                } else if (state.responseFriendList == null) {
                                  return Center(
                                      child: Text("${state.responseFriendList} Api Error"));
                                } else {
                                    return ListView.builder(
                                        reverse: true,
                                        shrinkWrap: true,
                                        padding: const EdgeInsets.only(top: 20, bottom: 0),
                                        itemCount: state.responseFriendList!.data!.length,
                                        itemBuilder: (ctx, index) {
                                          return Padding(
                                            padding: const EdgeInsets.only(bottom: 10),
                                            child: InkWell(
                                              onTap: () async {
                                                CommunityFriendChatScreen(
                                                  userId: state.responseFriendList!.data![index].userId,
                                                  friendId: state.responseFriendList!.data![index].friendId,
                                                  friendName: state.responseFriendList!.data![index].friend!.name ?? '',
                                                  friendImage: state.responseFriendList!.data![index].friend!.profilePic ?? '',
                                                  friendAddress: state.responseFriendList!.data![index].friend!.address != null ? state.responseFriendList!.data![index].friend!.address!.address ??
                                                      '' : '',
                                                ).navigate();
                                              },
                                              child: Container(
                                                padding: const EdgeInsets.all(20),
                                                decoration: BoxDecoration(
                                                    color: Colors.white,
                                                    borderRadius:
                                                    const BorderRadius.only(
                                                        topLeft:
                                                        Radius.circular(20),
                                                        topRight:
                                                        Radius.circular(20),
                                                        bottomLeft:
                                                        Radius.circular(20)),
                                                    border: Border.all(
                                                        color: ColorResources.grey)),
                                                child: Column(
                                                  children: [
                                                    Row(
                                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                      children: [
                                                        Row(
                                                          crossAxisAlignment:
                                                          CrossAxisAlignment.center,
                                                          mainAxisAlignment:
                                                          MainAxisAlignment.start,
                                                          children: [
                                                            networkImage(
                                                                text: state.responseFriendList!.data![index].friend!.profilePic
                                                                    .toString(),
                                                                height: 46,
                                                                width: 46,
                                                                radius: 40),
                                                            15.horizontalSpace(),
                                                            Column(
                                                              crossAxisAlignment:
                                                              CrossAxisAlignment.start,
                                                              children: [
                                                                Text(state.responseFriendList!.data![index].friend!.name
                                                                    .toString(),
                                                                    style: figtreeMedium
                                                                        .copyWith(
                                                                        fontSize: 18,
                                                                        color: Colors
                                                                            .black)),
                                                                4.verticalSpace(),
                                                                Text(state.responseFriendList!.data![index].friend!.address != null ? state.responseFriendList!.data![index].friend!.address!.address ??
                                                                    '' : '',
                                                                    style: figtreeRegular
                                                                        .copyWith(
                                                                        fontSize: 12,
                                                                        color: ColorResources
                                                                            .fieldGrey)),
                                                              ],
                                                            ),
                                                          ],
                                                        ),
                                                        SvgPicture.asset(
                                                          Images.chat, color: ColorResources.maroon,),
                                                      ],
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            ),
                                          );
                                        }
                                    );
                                }
                          }
                        ),
                      ],
                    ),
                  ),
                ),
              )
            ],
          ),
        ],
      ),
    );
  }
}
