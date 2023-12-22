import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:glad/data/model/response_project_data_firebase.dart';
import 'package:glad/screen/chat/messages.dart';
import 'package:glad/screen/chat/new_messages.dart';
import 'package:glad/screen/custom_widget/custom_methods.dart';
import 'package:glad/utils/color_resources.dart';
import 'package:glad/utils/extension.dart';
import 'package:glad/utils/helper.dart';
import 'package:glad/utils/images.dart';
import 'package:glad/utils/styles.dart';
import 'package:grouped_list/grouped_list.dart';
import 'package:intl/intl.dart';

import 'message_bubble.dart';

class FirebaseChatScreen extends StatefulWidget {
  const FirebaseChatScreen({super.key,required this.responseProjectDataForFirebase});

  final ResponseProjectDataForFirebase responseProjectDataForFirebase;

  @override
  State<FirebaseChatScreen> createState() => _FirebaseChatScreenState();
}

class _FirebaseChatScreenState extends State<FirebaseChatScreen> {
  ScrollController scrollController = ScrollController();

  var _enteredMessage = '';
  final controller = TextEditingController();

  @override
  void initState() {
      super.initState();
  }

  void _sendMessage() async {
    FirebaseFirestore.instance.collection('projects_chats')
        .doc(widget.responseProjectDataForFirebase.farmerProjectId.toString())
        .collection('chats').add({
      'text': _enteredMessage,
      "file": '' ,
      'created_at': Timestamp.now(),
      'user_name': widget.responseProjectDataForFirebase.userName.toString(),
      'user_type': widget.responseProjectDataForFirebase.userType,
      'time': DateFormat('hh:mm a').format(DateTime.now()),
      'date': DateFormat.yMMMMd().format(DateTime.now()),
      "message_count":FieldValue.increment(1),
      "message_type": 'text',
      // "${currentUser}messageCount":FieldValue.increment(1),
    }).then((value) => print("Message Added"))
        .catchError((error) => print("Failed to add user: $error"));
    scrollController.animateTo(0, duration: Duration(milliseconds: 300), curve: Curves.easeOut);
    controller.clear();
  }

  Future<void> sendFile(File image,String messageType)async{
    customDialog(widget: launchProgress());
    final ref = FirebaseStorage.instance
        .ref()
        .child('image')
        .child('.jpg'
    );

    await ref.putFile(image).whenComplete(() {
      print("successfully");
    });

    final url = await ref.getDownloadURL();
    // Fireb
    FirebaseFirestore.instance.collection('projects_chats')
        .doc(widget.responseProjectDataForFirebase.farmerProjectId.toString())
        .collection('chats').add({
      'text': '',
      "file": url ,
      'created_at': Timestamp.now(),
      'user_name': widget.responseProjectDataForFirebase.userName.toString(),
      'user_type': widget.responseProjectDataForFirebase.userType,
      'time': DateFormat('hh:mm a').format(DateTime.now()),
      'date': DateFormat.yMMMMd().format(DateTime.now()),
      "message_count":FieldValue.increment(1),
      "message_type": messageType,
      // "${currentUser}messageCount":FieldValue.increment(1),
    }).then((value) {
      scrollController.animateTo(0, duration: Duration(milliseconds: 300), curve: Curves.easeOut);
      disposeProgress();
    }).catchError((error) {
      print("Failed to add user: $error");
      showCustomToast(context, error.toString());
      disposeProgress();
    });
  }

  @override
  Widget build(BuildContext context) {

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
                  Image.asset(Images.sampleUser),
                  10.horizontalSpace(),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(widget.responseProjectDataForFirebase.projectName.toString(),
                          style: figtreeMedium.copyWith(
                              fontSize: 18, color: Colors.black)),
                      Text(widget.responseProjectDataForFirebase.farmerName.toString(),
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
                  stream: FirebaseFirestore.instance.collection('projects_chats')
                      .doc(widget.responseProjectDataForFirebase.farmerProjectId.toString())
                      .collection('chats')
                      .orderBy('created_at',descending: false).snapshots(),
                  builder: (ctx,chatSnapShot) {
                    // if(chatSnapShot.connectionState == ConnectionState.waiting) {
                    //   return const Center(child: CircularProgressIndicator(),);}
                    // WidgetsBinding.instance.addPostFrameCallback((_) {
                    //   if (controllers.hasClients) {
                    //     controllers.jumpTo(controllers.position.maxScrollExtent);
                    //   } else {
                    //     setState((){});
                    //   }
                    // });
                    if(!chatSnapShot.hasData) {
                      return const SizedBox.shrink();
                    }
                    final chatDocs = chatSnapShot.data;

                    /*Scrollable.ensureVisible(
                GlobalObjectKey(category?.id).currentContext,
                duration: Duration(seconds: 1),// duration for scrolling time
                alignment: .5, // 0 mean, scroll to the top, 0.5 mean, half
                curve: Curves.easeInOutCubic);*/
                    print(chatDocs!.docs.length);

                    return Expanded(
                      child: Padding(
                        padding: const EdgeInsets.fromLTRB(18, 0, 18, 0),
                        child: GroupedListView<dynamic, String>(
                          controller: scrollController,
                          elements: chatDocs.docs.toList(),
                          groupBy: (element) => element.data()['date'],
                          groupSeparatorBuilder: (String groupByValue) => Align(
                            alignment: Alignment.center,
                              child: Text(groupByValue)),
                          itemBuilder: (context, dynamic element) => Padding(
                            padding: const EdgeInsets.only(top: 8.0, bottom: 4),
                            child: MessageBubble(
                              // parentIndex.toString(),
                              element.data()['text'],
                              element.data()['user_name'],
                              element.data()['time'].toString(),
                              element.data()['user_type'],
                              widget.responseProjectDataForFirebase.userType.toString(),
                              element.data()['message_type'],
                              element.data()['file'],
                            ),
                          ),
                          itemComparator: (item1, item2) => item1.data()['date'].compareTo(item2.data()['date']), // optional
                          // useStickyGroupSeparators: true, // optional
                          // floatingHeader: true, // o
                          reverse: true,// ptional
                          // shrinkWrap: true,
                          order: GroupedListOrder.DESC, // optional
                        ),
                      ),
                    );
                    //   Expanded(
                    //   child: ListView.builder(
                    //       itemCount: chatDocs.docs.length ,
                    //       reverse: true,
                    //       padding: const EdgeInsets.fromLTRB(18, 18, 18, 10),
                    //       controller: scrollController,
                    //       shrinkWrap: true,
                    //       physics: const BouncingScrollPhysics(),
                    //       itemBuilder: (conte,parentIndex){
                    //         // if (controllers.hasClients) {
                    //         //   controllers.jumpTo(controllers.position.maxScrollExtent);
                    //         // }
                    //         // bool isSameDate = true;
                    //         // if(parentIndex != 0) {
                    //         //
                    //         //   final String dateString = chatDocs.docs.reversed.toList()[parentIndex]['date'];
                    //         //   DateTime date = DateFormat.yMMMMd().parse(dateString);
                    //         //
                    //         //   final String prevDateString = chatDocs.docs.reversed.toList()[parentIndex - 1]['date'];
                    //         //   // final DateTime prevDate = DateTime.parse(prevDateString);
                    //         //   final DateTime prevDate = DateFormat.yMMMMd().parse(prevDateString);
                    //         //   isSameDate = date.isSameDate(prevDate);
                    //         // } else {
                    //         //   final String dateString = chatDocs.docs.reversed.toList()[parentIndex]['date'];
                    //         //   DateTime date = DateFormat.yMMMMd().parse(dateString);
                    //         //
                    //         //   final String prevDateString = chatDocs.docs.reversed.toList()[parentIndex + 1]['date'];
                    //         //   // final DateTime prevDate = DateTime.parse(prevDateString);
                    //         //   final DateTime prevDate = DateFormat.yMMMMd().parse(prevDateString);
                    //         //   isSameDate = date.isSameDate(prevDate);
                    //         // }
                    //         //
                    //         // final item = chatDocs.docs.reversed.toList()[parentIndex];
                    //         // if(parentIndex == chatDocs.docs.length - 1 || (!isSameDate)) {
                    //         //   return Column(
                    //         //     children: [
                    //         //
                    //         //       Text(item.data()['date']),
                    //         //       // Text(date.formatDate('December 17, 2023')),
                    //         //
                    //         //       Padding(
                    //         //         padding: const EdgeInsets.only(top: 12.0),
                    //         //         child: MessageBubble(
                    //         //           // parentIndex.toString(),
                    //         //           item.data()['text'],
                    //         //           item.data()['user_name'],
                    //         //           item.data()['time'].toString(),
                    //         //           item.data()['user_type'],
                    //         //           widget.responseProjectDataForFirebase.userType.toString(),
                    //         //           item.data()['message_type'],
                    //         //           item.data()['file'],
                    //         //         ),
                    //         //       )
                    //         //     ],
                    //         //   );
                    //         // } else {
                    //         //   return Padding(
                    //         //       padding: const EdgeInsets.only(top: 12.0),
                    //         //       child: MessageBubble(
                    //         //         // parentIndex.toString(),
                    //         //         item.data()['text'],
                    //         //         item.data()['user_name'],
                    //         //         item.data()['time'].toString(),
                    //         //         item.data()['user_type'],
                    //         //         widget.responseProjectDataForFirebase.userType.toString(),
                    //         //         item.data()['message_type'],
                    //         //         item.data()['file'],
                    //         //       )
                    //         //   );
                    //         // }
                    //
                    //         // bool isSameDate = true;
                    //         // final String dateString = chatDocs.docs.reversed.toList()[parentIndex]['date'];
                    //         // DateTime date = DateFormat.yMMMMd().parse(dateString);
                    //         // final item = chatDocs.docs.reversed.toList()[parentIndex];
                    //         //
                    //         // print(DateFormat.yMMMMd());
                    //         // if (parentIndex == 0) {
                    //         //   // if (date.isSameDate(DateFormat.yMMMMd().parse('December 18, 2023') )) {
                    //         //   print("object");
                    //         //   isSameDate = false;
                    //         //   // isSameDate = true;
                    //         // } else {
                    //         //   // final String prevDateString = chatDocs.docs[parentIndex -1]['date'];
                    //         //   final String prevDateString = chatDocs.docs.reversed.toList()[parentIndex - 1]['date'];
                    //         //   // final DateTime prevDate = DateTime.parse(prevDateString);
                    //         //   final DateTime prevDate = DateFormat.yMMMMd().parse(prevDateString);
                    //         //   isSameDate = date.isSameDate(prevDate);
                    //         // }
                    //         // if (parentIndex == chatDocs.docs.length - 1 || !(isSameDate)) {
                    //         //   // if (date.isSameDate(DateFormat.yMMMMd().parse('December 18, 2023')) || !(isSameDate)) {
                    //         //   return Column(
                    //         //     children: [
                    //         //
                    //         //       Text(item.data()['date']),
                    //         //       // Text(date.formatDate('December 17, 2023')),
                    //         //
                    //         //       Padding(
                    //         //         padding: const EdgeInsets.only(top: 12.0),
                    //         //         child: MessageBubble(
                    //         //           // parentIndex.toString(),
                    //         //           item.data()['text'],
                    //         //           item.data()['user_name'],
                    //         //           item.data()['time'].toString(),
                    //         //           item.data()['user_type'],
                    //         //           widget.responseProjectDataForFirebase.userType.toString(),
                    //         //           item.data()['message_type'],
                    //         //           item.data()['file'],
                    //         //         ),
                    //         //       )
                    //         //     ],
                    //         //   );
                    //         // }
                    //         // else {
                    //         //   return Padding(
                    //         //       padding: const EdgeInsets.only(top: 12.0),
                    //         //       child: MessageBubble(
                    //         //         // parentIndex.toString(),
                    //         //         item.data()['text'],
                    //         //         item.data()['user_name'],
                    //         //         item.data()['time'].toString(),
                    //         //         item.data()['user_type'],
                    //         //         widget.responseProjectDataForFirebase.userType.toString(),
                    //         //         item.data()['message_type'],
                    //         //         item.data()['file'],
                    //         //       )
                    //         //   );
                    //         // }
                    //       }
                    //   ),
                    // );
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
                            controller: controller,
                            onChanged: (String value){
                              setState(() {
                                _enteredMessage = value;
                              });
                            },
                            decoration: const InputDecoration(
                                border: InputBorder.none,
                                focusedBorder: InputBorder.none,
                                enabledBorder: InputBorder.none,
                                hintText: 'Message...'),
                          )),
                      InkWell(
                        onTap: ()async{
                          var image =  imgFromGallery();
                          image.then((value) async{
                            await sendFile(File(value), 'image');
                          });
                        },
                        child: SvgPicture.asset(
                          Images.attachment,
                          colorFilter: const ColorFilter.mode(
                              ColorResources.fieldGrey, BlendMode.srcIn),
                        ),
                      ),
                      10.horizontalSpace(),
                      SvgPicture.asset(
                        Images.camera,
                        colorFilter: const ColorFilter.mode(
                            ColorResources.fieldGrey, BlendMode.srcIn),
                      ),

                      IconButton(
                          color: Theme.of(context).primaryColor,
                          icon: const Icon(
                            Icons.send,
                            size: 32,
                            color: Colors.grey,
                          ),
                          onPressed: _enteredMessage.trim().isEmpty ? null : _sendMessage
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