import 'package:flutter/material.dart';
import 'package:glad/data/model/response_project_data_firebase.dart';
import 'package:glad/screen/chat/message_bubble.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:intl/intl.dart';

class Messages extends StatelessWidget {
  const Messages({super.key,required this.responseProjectDataForFirebase});
  final ResponseProjectDataForFirebase responseProjectDataForFirebase;

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
        stream: FirebaseFirestore.instance.collection('projects_chats').doc(responseProjectDataForFirebase.farmerProjectId.toString()).collection('chats').orderBy('created_at',descending: true).snapshots(),
        builder: (ctx,chatSnapShot) {
          if(chatSnapShot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator(),);}
          final chatDocs = chatSnapShot.data;
          return ListView.builder(
            reverse: true,
            padding: const EdgeInsets.all(30),
            itemCount: chatDocs!.docs.length,itemBuilder: (ctx,index) {
              return Padding(
                padding: const EdgeInsets.only(top: 12.0),
                child: MessageBubble(
                    chatDocs.docs[index]['text'],
                    chatDocs.docs[index]['user_name'],
                    chatDocs.docs[index]['time'].toString(),
                    chatDocs.docs[index]['user_type'],
                    responseProjectDataForFirebase.userType.toString()
                ),
              );
            }
          );
        }
    );
  }
}