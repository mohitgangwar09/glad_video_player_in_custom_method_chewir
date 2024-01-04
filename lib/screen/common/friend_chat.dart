import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:glad/cubit/landing_page_cubit/landing_page_cubit.dart';
import 'package:glad/cubit/livestock_cubit/livestock_cubit.dart';
import 'package:glad/screen/chat/message_bubble.dart';
import 'package:glad/screen/custom_widget/custom_appbar.dart';
import 'package:glad/screen/custom_widget/custom_methods.dart';
import 'package:glad/screen/dde_screen/preview_screen.dart';
import 'package:glad/utils/app_constants.dart';
import 'package:glad/utils/color_resources.dart';
import 'package:glad/utils/extension.dart';
import 'package:glad/utils/helper.dart';
import 'package:glad/utils/images.dart';
import 'package:glad/utils/sharedprefrence.dart';
import 'package:glad/utils/styles.dart';
import 'package:grouped_list/grouped_list.dart';
import 'package:intl/intl.dart';

class CommunityFriendChatScreen extends StatefulWidget {
  const CommunityFriendChatScreen({super.key, required this.userId, required this.friendId, required this.friendName, required this.friendImage, required this.friendAddress});
  final int userId;
  final int friendId;
  final String friendName;
  final String friendImage;
  final String friendAddress;

  @override
  State<CommunityFriendChatScreen> createState() => _CommunityFriendChatScreenState();
}

class _CommunityFriendChatScreenState extends State<CommunityFriendChatScreen> {

  TextEditingController commentController = TextEditingController();
  ScrollController scrollController = ScrollController();

  String? channelId;

  @override
  void initState() {
    List users = [widget.userId, widget.friendId];
    users.sort();
    channelId = users.join('_');
    super.initState();
  }

  void _sendMessage() async {
    FirebaseFirestore.instance.collection('community_friends')
        .doc(channelId)
        .collection('chats').add({
      'text': commentController.text,
      'created_at': Timestamp.now(),
      'user_name': await SharedPrefManager.getPreferenceString(AppConstants.userName) ?? '',
      'date': DateFormat.yMMMMd().format(DateTime.now()),
      'user_id': widget.userId,
      "message_type": 'text',
      // "${currentUser}messageCount":FieldValue.increment(1),
    }).then((value) => print("Message Added"))
        .catchError((error) => print("Failed to add user: $error"));
    scrollController.animateTo(0, duration: const Duration(milliseconds: 300), curve: Curves.easeOut);
    commentController.clear();
  }

  @override
  Widget build(BuildContext contexts) {
    return SafeArea(
      top: false,
      bottom: true,
      child: Scaffold(
        backgroundColor: const Color(0xffF9F9F9),
        appBar: PreferredSize(
          preferredSize: Size(screenWidth(),100),
          child: Padding(
            padding: EdgeInsets.only(top: getStatusBarHeight(context)),
            child: Container(
              height: AppBar().preferredSize.height,
              width: screenWidth(),
              padding: const EdgeInsets.symmetric(horizontal: 8),
              decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: const BorderRadius.only(
                      bottomLeft: Radius.circular(24),
                      bottomRight: Radius.circular(24)),
                  border: Border.all(color: ColorResources.grey)),
              child: Row(
                children: [
                  arrowBackButton(),
                  14.horizontalSpace(),
                  networkImage(text: widget.friendImage.toString(), width: 46, height: 46, radius: 46),
                  10.horizontalSpace(),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(widget.friendName.toString(),
                          style: figtreeMedium.copyWith(
                              fontSize: 18, color: Colors.black)),
                      Text(widget.friendAddress.toString(),
                          style: figtreeRegular.copyWith(
                              fontSize: 12, color: ColorResources.fieldGrey)),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
        body: SizedBox(
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          child: Column(
            children: <Widget>[

              StreamBuilder(
                  stream: FirebaseFirestore.instance.collection('community_friends')
                      .doc(channelId)
                      .collection('chats')
                      .orderBy('created_at',descending: false).snapshots(),
                  builder: (ctx,chatSnapShot) {
                    if(!chatSnapShot.hasData) {
                      return const SizedBox.shrink();
                    }
                    final chatDocs = chatSnapShot.data;

                    return Expanded(
                      child: Padding(
                        padding: const EdgeInsets.fromLTRB(18, 0, 18, 0),
                        child: GroupedListView<dynamic, String>(
                          controller: scrollController,
                          elements: chatDocs!.docs.toList(),
                          groupBy: (element) => element.data()['date'],
                          groupSeparatorBuilder: (String groupByValue) => Align(
                              alignment: Alignment.center,
                              child: Text(groupByValue)),
                          itemBuilder: (context, dynamic element) {
                            return Padding(
                              padding: const EdgeInsets.only(top: 8.0, bottom: 4),
                              child: MessageBubble(
                                // parentIndex.toString(),
                                element.data()['text'],
                                element.data()['user_name'],
                                DateFormat('hh:mm a').format(DateTime.fromMillisecondsSinceEpoch((element.data()['created_at'] as Timestamp).seconds * 1000)),
                                element.data()['user_id'].toString(),
                                widget.userId.toString(),
                                element.data()['message_type'],
                                element.data()['file'] ?? '',
                              ),
                            ); },

                          itemComparator: (item1, item2) => item1.data()['date'].compareTo(item2.data()['date']), // optional
                          reverse: true,
                          order: GroupedListOrder.DESC, // optional
                        ),
                      ),
                    );
                  }
              ),

              Align(
                alignment: Alignment.bottomCenter,
                child: Container(
                  height: AppBar().preferredSize.height * 1.5,
                  width: screenWidth(),
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: const BorderRadius.only(
                          topLeft: Radius.circular(24),
                          topRight: Radius.circular(24)),
                      border: Border.all(color: ColorResources.grey)),
                  child: Row(
                    children: [
                      Expanded(
                          child: TextField(
                            controller: commentController,
                            decoration: const InputDecoration(
                                border: InputBorder.none,
                                focusedBorder: InputBorder.none,
                                enabledBorder: InputBorder.none,
                                hintText: 'Message...'),
                          )),

                      IconButton(
                          color: Theme.of(context).primaryColor,
                          icon: const Icon(
                            Icons.send,
                            size: 32,
                            color: Colors.grey,
                          ),
                          onPressed: commentController.toString().trim().isEmpty ? null : _sendMessage
                      )
                    ],
                  ),
                ),
              )

            ],),
        ),
      ),
    );
  }
}
