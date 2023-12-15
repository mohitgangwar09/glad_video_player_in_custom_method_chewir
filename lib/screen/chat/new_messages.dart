import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:glad/data/model/response_project_data_firebase.dart';
import 'package:glad/utils/color_resources.dart';
import 'package:glad/utils/extension.dart';
import 'package:glad/utils/images.dart';
import 'package:intl/intl.dart';

class NewMessage extends StatefulWidget {
  const NewMessage({super.key,required this.responseProjectDataForFirebase});
  final ResponseProjectDataForFirebase responseProjectDataForFirebase;

  @override
  State<NewMessage> createState() => _NewMessageState();
}

class _NewMessageState extends State<NewMessage> {

  var _enteredMessage = '';
  final controller = TextEditingController();

  void _sendMessage() async {

    // FocusScope.of(context).unfocus();


    // print(widget.responseProjectDataForFirebase.userType);
    FirebaseFirestore.instance.collection('projects_chats')
        .doc(widget.responseProjectDataForFirebase.farmerProjectId.toString())
        .collection('chats').add({
      'text': _enteredMessage,
      'created_at': Timestamp.now(),
      'user_name': widget.responseProjectDataForFirebase.userName.toString(),
      'user_type': widget.responseProjectDataForFirebase.userType,
      'time': DateFormat('hh:mm a').format(DateTime.now()),
      'date': DateFormat.yMMMMd().format(DateTime.now()),
    }).then((value) => print("Message Added"))
        .catchError((error) => print("Failed to add user: $error"));

    controller.clear();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
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
          SvgPicture.asset(
            Images.attachment,
            colorFilter: const ColorFilter.mode(
                ColorResources.fieldGrey, BlendMode.srcIn),
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
    );
  }
}