import 'dart:async';

import 'package:flutter/material.dart';
import 'package:glad/data/model/message_list.dart';
import 'package:glad/data/model/response_project_data_firebase.dart';
import 'package:glad/screen/chat/message_bubble.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:glad/screen/custom_widget/custom_methods.dart';
import 'package:glad/utils/extension.dart';
import 'package:intl/intl.dart';
import 'package:url_launcher/url_launcher.dart';

class Messages extends StatefulWidget {
  const Messages({super.key,required this.responseProjectDataForFirebase, required this.controller});
  final ResponseProjectDataForFirebase responseProjectDataForFirebase;
  final ScrollController controller;

  @override
  State<Messages> createState() => _MessagesState();
}

class _MessagesState extends State<Messages> {

  // ScrollController controllers =  ScrollController();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    // WidgetsBinding.instance.addPostFrameCallback((_) {
    //   Timer(Duration(milliseconds: 500),
    //           () => controllers.jumpTo(controllers.position.maxScrollExtent));
    //
    // });

    return StreamBuilder(
        stream: FirebaseFirestore.instance.collection('projects_chats')
            .doc(widget.responseProjectDataForFirebase.farmerProjectId.toString())
            .collection('chats')
            .orderBy('created_at',descending: true).snapshots(),
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
          // WidgetsBinding.instance.addPostFrameCallback((_) {
          //  if (chatSnapShot.data!.docChanges.isNotEmpty){
          //    Timer(Duration(milliseconds: 500),
          //            () => controllers.jumpTo(controllers.position.maxScrollExtent));
          //  }
          // });

          /*Scrollable.ensureVisible(
              GlobalObjectKey(category?.id).currentContext,
              duration: Duration(seconds: 1),// duration for scrolling time
              alignment: .5, // 0 mean, scroll to the top, 0.5 mean, half
              curve: Curves.easeInOutCubic);*/
          print(chatDocs!.docs.length);

          return Expanded(
            child: ListView.builder(
                itemCount: chatDocs.docs.length,
                reverse: true,
                padding: const EdgeInsets.fromLTRB(18, 18, 18, 10),
                controller: widget.controller,
                shrinkWrap: true,
                physics: const BouncingScrollPhysics(),
                itemBuilder: (conte,parentIndex){
                  // if (controllers.hasClients) {
                  //   controllers.jumpTo(controllers.position.maxScrollExtent);
                  // }
                  bool isSameDate = true;
                  final String dateString = chatDocs.docs[parentIndex]['date'];
                  DateTime date = DateFormat.yMMMMd().parse(dateString);
                  final item = chatDocs.docs[parentIndex];

                  print(DateFormat.yMMMMd());
                  if (parentIndex == 0) {
                    // if (date.isSameDate(DateFormat.yMMMMd().parse('December 18, 2023') )) {
                    print("object");
                    isSameDate = false;
                    // isSameDate = true;
                  } else {
                    // final String prevDateString = chatDocs.docs[parentIndex -1]['date'];
                    final String prevDateString = chatDocs.docs[parentIndex-1]['date'];
                    // final DateTime prevDate = DateTime.parse(prevDateString);
                    final DateTime prevDate = DateFormat.yMMMMd().parse(prevDateString);
                    isSameDate = date.isSameDate(prevDate);
                  }
                  if (parentIndex == 0 || !(isSameDate)) {
                    // if (date.isSameDate(DateFormat.yMMMMd().parse('December 18, 2023')) || !(isSameDate)) {
                    return Column(
                      children: [

                        Text(item.data()['date']),
                        // Text(date.formatDate('December 17, 2023')),

                        Padding(
                          padding: const EdgeInsets.only(top: 12.0),
                          child: MessageBubble(
                            // parentIndex.toString(),
                            item.data()['text'],
                            item.data()['user_name'],
                            item.data()['time'].toString(),
                            item.data()['user_type'],
                            widget.responseProjectDataForFirebase.userType.toString(),
                            item.data()['message_type'],
                            item.data()['file'],
                          ),
                        )
                      ],
                    );
                  }else {
                    return Padding(
                        padding: const EdgeInsets.only(top: 12.0),
                        child: MessageBubble(
                          // parentIndex.toString(),
                          item.data()['text'],
                          item.data()['user_name'],
                          item.data()['time'].toString(),
                          item.data()['user_type'],
                          widget.responseProjectDataForFirebase.userType.toString(),
                          item.data()['message_type'],
                          item.data()['file'],
                        )
                    );
                  }
                }
            ),
          );
        }
    );
  }
}

/*ListView.builder(
                        reverse: true,
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        padding: const EdgeInsets.all(30),
                        // itemCount: chatDocs.docs.length,itemBuilder: (ctx,index) {
                        itemCount: messageLists.length,itemBuilder: (ctx,index) {
                      return Padding(
                        padding: const EdgeInsets.only(top: 12.0),
                        child: MessageBubble(
                          data[index]['text'],
                          // chatDocs.docs[index]['text'],
                          "chatDocs.docs[index]['user_name']",
                          "chatDocs.docs[index]['time'].toString()",
                          "chatDocs.docs[index]['user_type']",
                          responseProjectDataForFirebase.userType.toString(),
                          'text',
                          // chatDocs.docs[index]['message_type'],
                          "chatDocs.docs[index]['file']",
                        ),
                      );
                    }
                    ),*/