import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:glad/cubit/landing_page_cubit/landing_page_cubit.dart';
import 'package:glad/cubit/livestock_cubit/livestock_cubit.dart';
import 'package:glad/screen/custom_widget/custom_appbar.dart';
import 'package:glad/screen/custom_widget/custom_methods.dart';
import 'package:glad/screen/dde_screen/preview_screen.dart';
import 'package:glad/utils/app_constants.dart';
import 'package:glad/utils/color_resources.dart';
import 'package:glad/utils/extension.dart';
import 'package:glad/utils/helper.dart';
import 'package:glad/utils/images.dart';
import 'package:glad/utils/styles.dart';
import 'package:grouped_list/grouped_list.dart';
import 'package:intl/intl.dart';

class LivestockEnquiryChatScreen extends StatefulWidget {
  const LivestockEnquiryChatScreen({super.key, required this.livestockId, required this.cowBreed, required this.advertisementNumber, required this.userName, required this.userId, this.ddeId});
  final String livestockId;
  final String cowBreed;
  final String advertisementNumber;
  final String userName;
  final String userId;
  final String? ddeId;

  @override
  State<LivestockEnquiryChatScreen> createState() => _LivestockEnquiryChatScreenState();
}

class _LivestockEnquiryChatScreenState extends State<LivestockEnquiryChatScreen> {

  TextEditingController commentController = TextEditingController();
  ScrollController scrollController = ScrollController();

  void _sendMessage() async {
    FirebaseFirestore.instance.collection('livestock_enquiry')
        .doc(widget.livestockId)
        .collection('enquiries')
        .doc(widget.userId)
        .collection('chats').add({
      'text': commentController.text,
      'created_at': Timestamp.now(),
      'user_name': widget.userName.toString(),
      'date': DateFormat.yMMMMd().format(DateTime.now()),
      'user_type': widget.ddeId != null ? 'buyer-dde' : 'buyer',
      "message_type": 'text',
      // "${currentUser}messageCount":FieldValue.increment(1),
    }).then((value) => print("Message Added"))
        .catchError((error) => print("Failed to add user: $error"));
    scrollController.animateTo(0, duration: const Duration(milliseconds: 300), curve: Curves.easeOut);
    commentController.clear();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: Colors.white,
        child: Stack(
          children: [
            landingBackground(),
            Column(
              children: [
                CustomAppBar(
                  context: context,
                  titleText1: 'Enquiry',
                  centerTitle: true,
                  description: '${'${widget.cowBreed} cows'} (${widget.advertisementNumber})',
                  leading: arrowBackButton(),
                ),
                StreamBuilder(
                    stream: FirebaseFirestore.instance.collection('livestock_enquiry')
                        .doc(widget.livestockId)
                        .collection('enquiries')
                        .doc(widget.userId)
                        .collection('chats')
                        .orderBy('created_at',descending: false).snapshots(),
                    builder: (ctx,chatSnapShot) {
                      if(!chatSnapShot.hasData) {
                        return Expanded(child: Container(),);
                        // return const SizedBox.shrink();
                      }
                      final chatDocs = chatSnapShot.data;
                      return Expanded(
                        child: Padding(
                          padding: const EdgeInsets.fromLTRB(18, 0, 18, 0),
                          child: GroupedListView<dynamic, String>(
                            controller: scrollController,
                            elements: chatDocs!.docs.toList(),
                            groupBy: (element) => element.data()['date'],
                            groupSeparatorBuilder: (String groupByValue) => const SizedBox.shrink(),
                            itemBuilder: (context, dynamic element) {
                              if(context.read<LivestockCubit>().sharedPreferences.getString(AppConstants.userType) == "dde"){
                                return element.data()['user_type'] == 'buyer-dde' ?
                                Padding(
                              padding: const EdgeInsets.only(bottom: 20),
                              child: Padding(
                                padding: const EdgeInsets.symmetric(horizontal: 20),
                                child: Container(
                                  width: screenWidth(),
                                  padding: const EdgeInsets.all(30),
                                  decoration: BoxDecoration(
                                      color: Colors.white,
                                      border: Border.all(color: const Color(0xFF999999)),
                                      borderRadius: const BorderRadius.only(
                                          topLeft: Radius.circular(30),
                                          topRight: Radius.circular(30),
                                          bottomLeft: Radius.circular(30),
                                          bottomRight: Radius.circular(0))),
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                          element.data()['text'],
                                          style: figtreeMedium.copyWith(
                                              fontSize: 16, color: ColorResources.fieldGrey)),
                                      10.verticalSpace(),
                                      DateFormat('dd MMM, yyyy, hh:mm a').format(DateTime.fromMillisecondsSinceEpoch((element.data()['created_at'] as Timestamp).seconds * 1000)).textRegular(
                                          color: ColorResources.fieldGrey, fontSize: 14)
                                    ],
                                  ),
                                ),
                              ),
                            ) :
                                Padding(
                              padding: const EdgeInsets.only(bottom: 20),
                              child: Padding(
                                padding: const EdgeInsets.symmetric(horizontal: 20),
                                child: Container(
                                  width: screenWidth(),
                                  padding: const EdgeInsets.all(30),
                                  decoration: BoxDecoration(
                                      color: const Color(0xFFFFF3F4),
                                      border: Border.all(color: const Color(0xFFC788A5)),
                                      borderRadius: const BorderRadius.only(
                                          topLeft: Radius.circular(30),
                                          topRight: Radius.circular(30),
                                          bottomRight: Radius.circular(30),
                                          bottomLeft: Radius.circular(0))),
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                          element.data()['user_name'],
                                          style: figtreeMedium.copyWith(
                                              fontSize: 16, color: Colors.black)),
                                      15.verticalSpace(),
                                      Text(
                                          element.data()['text'],
                                          style: figtreeMedium.copyWith(
                                              fontSize: 16, color: ColorResources.fieldGrey)),
                                      10.verticalSpace(),
                                      DateFormat('dd MMM, yyyy, hh:mm a').format(DateTime.fromMillisecondsSinceEpoch((element.data()['created_at'] as Timestamp).seconds * 1000)).textRegular(
                                          color: ColorResources.fieldGrey, fontSize: 14)
                                    ],
                                  ),
                                ),
                              ),
                            );
                              } else{
                                return element.data()['user_type'] == 'buyer' ?
                                Padding(
                                  padding: const EdgeInsets.only(bottom: 20),
                                  child: Padding(
                                    padding: const EdgeInsets.symmetric(horizontal: 20),
                                    child: Container(
                                      width: screenWidth(),
                                      padding: const EdgeInsets.all(30),
                                      decoration: BoxDecoration(
                                          color: Colors.white,
                                          border: Border.all(color: const Color(0xFF999999)),
                                          borderRadius: const BorderRadius.only(
                                              topLeft: Radius.circular(30),
                                              topRight: Radius.circular(30),
                                              bottomLeft: Radius.circular(30),
                                              bottomRight: Radius.circular(0))),
                                      child: Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                              element.data()['text'],
                                              style: figtreeMedium.copyWith(
                                                  fontSize: 16, color: ColorResources.fieldGrey)),
                                          10.verticalSpace(),
                                          DateFormat('dd MMM, yyyy, hh:mm a').format(DateTime.fromMillisecondsSinceEpoch((element.data()['created_at'] as Timestamp).seconds * 1000)).textRegular(
                                              color: ColorResources.fieldGrey, fontSize: 14)
                                        ],
                                      ),
                                    ),
                                  ),
                                ) :
                                Padding(
                                  padding: const EdgeInsets.only(bottom: 20),
                                  child: Padding(
                                    padding: const EdgeInsets.symmetric(horizontal: 20),
                                    child: Container(
                                      width: screenWidth(),
                                      padding: const EdgeInsets.all(30),
                                      decoration: BoxDecoration(
                                          color: const Color(0xFFFFF3F4),
                                          border: Border.all(color: const Color(0xFFC788A5)),
                                          borderRadius: const BorderRadius.only(
                                              topLeft: Radius.circular(30),
                                              topRight: Radius.circular(30),
                                              bottomRight: Radius.circular(30),
                                              bottomLeft: Radius.circular(0))),
                                      child: Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                              element.data()['user_name'],
                                              style: figtreeMedium.copyWith(
                                                  fontSize: 16, color: Colors.black)),
                                          15.verticalSpace(),
                                          Text(
                                              element.data()['text'],
                                              style: figtreeMedium.copyWith(
                                                  fontSize: 16, color: ColorResources.fieldGrey)),
                                          10.verticalSpace(),
                                          DateFormat('dd MMM, yyyy, hh:mm a').format(DateTime.fromMillisecondsSinceEpoch((element.data()['created_at'] as Timestamp).seconds * 1000)).textRegular(
                                              color: ColorResources.fieldGrey, fontSize: 14)
                                        ],
                                      ),
                                    ),
                                  ),
                                );
                              }},

                            itemComparator: (item1, item2) => item1.data()['date'].compareTo(item2.data()['date']), // optional
                            // useStickyGroupSeparators: true, // optional
                            // floatingHeader: true, // o
                            reverse: true,// ptional
                            // shrinkWrap: true,
                            order: GroupedListOrder.DESC, // optional
                          ),
                        ),
                      );
                    }
                ),


                Container(
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
                              hintText: 'Write a comment...'),
                          onSubmitted: (value) {
                            if(commentController.text.isNotEmpty){
                              _sendMessage();
                            }
                          },
                        ),
                      ),

                      IconButton(onPressed: (){
                        if(commentController.text.isNotEmpty){
                          _sendMessage();
                        }
                      },icon: const Icon(Icons.send,color: Colors.grey, size: 31,))
                    ],
                  ),
                )
              ],
            ),
          ],
        ),
      ),);
  }
}
