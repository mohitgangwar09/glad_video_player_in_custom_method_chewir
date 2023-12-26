// import 'dart:io';
//
// import 'package:firebase_core/firebase_core.dart';
// import 'package:firebase_storage/firebase_storage.dart';
// import 'package:flutter/material.dart';
// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:flutter_svg/flutter_svg.dart';
// import 'package:glad/data/model/response_project_data_firebase.dart';
// import 'package:glad/screen/custom_widget/custom_methods.dart';
// import 'package:glad/utils/color_resources.dart';
// import 'package:glad/utils/extension.dart';
// import 'package:glad/utils/helper.dart';
// import 'package:glad/utils/images.dart';
// import 'package:intl/intl.dart';
//
// class NewMessage extends StatefulWidget {
//   const NewMessage({super.key,required this.responseProjectDataForFirebase, required this.controller});
//   final ResponseProjectDataForFirebase responseProjectDataForFirebase;
//   final ScrollController controller;
//
//   @override
//   State<NewMessage> createState() => _NewMessageState();
// }
//
// class _NewMessageState extends State<NewMessage> {
//
//   var _enteredMessage = '';
//   final controller = TextEditingController();
//
//   void _sendMessage() async {
//       FirebaseFirestore.instance.collection('projects_chats')
//           .doc(widget.responseProjectDataForFirebase.farmerProjectId.toString())
//           .collection('chats').add({
//         'text': _enteredMessage,
//         "file": '' ,
//         'created_at': Timestamp.now(),
//         'user_name': widget.responseProjectDataForFirebase.userName.toString(),
//         'user_type': widget.responseProjectDataForFirebase.userType,
//         'time': DateFormat('hh:mm a').format(DateTime.now()),
//         'date': DateFormat.yMMMMd().format(DateTime.now()),
//         "message_count":FieldValue.increment(1),
//         "message_type": 'text',
//         // "${currentUser}messageCount":FieldValue.increment(1),
//       }).then((value) => print("Message Added"))
//           .catchError((error) => print("Failed to add user: $error"));
//
//       widget.controller.jumpTo(widget.controller.position.maxScrollExtent);
//     controller.clear();
//   }
//
//   Future<void> sendFile(File image,String messageType)async{
//     customDialog(widget: launchProgress());
//     final ref = FirebaseStorage.instance
//         .ref()
//         .child('image')
//         .child('.jpg'
//     );
//
//     await ref.putFile(image).whenComplete(() {
//       print("successfully");
//     });
//
//     final url = await ref.getDownloadURL();
//     // Fireb
//     FirebaseFirestore.instance.collection('projects_chats')
//         .doc(widget.responseProjectDataForFirebase.farmerProjectId.toString())
//         .collection('chats').add({
//       'text': '',
//       "file": url ,
//       'created_at': Timestamp.now(),
//       'user_name': widget.responseProjectDataForFirebase.userName.toString(),
//       'user_type': widget.responseProjectDataForFirebase.userType,
//       'time': DateFormat('hh:mm a').format(DateTime.now()),
//       'date': DateFormat.yMMMMd().format(DateTime.now()),
//       "message_count":FieldValue.increment(1),
//       "message_type": messageType,
//       // "${currentUser}messageCount":FieldValue.increment(1),
//     }).then((value) {
//       disposeProgress();
//     }).catchError((error) {
//       print("Failed to add user: $error");
//       showCustomToast(context, error.toString());
//       disposeProgress();
//     });
//   }
//
//
//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       height: AppBar().preferredSize.height * 1.5,
//       width: screenWidth(),
//       padding: const EdgeInsets.symmetric(horizontal: 16),
//       decoration: BoxDecoration(
//           color: Colors.white,
//           borderRadius: const BorderRadius.only(
//               topLeft: Radius.circular(24),
//               topRight: Radius.circular(24)),
//           border: Border.all(color: ColorResources.grey)),
//       child: Row(
//         children: [
//           Expanded(
//               child: TextField(
//                 controller: controller,
//                 onChanged: (String value){
//                   setState(() {
//                     _enteredMessage = value;
//                   });
//                 },
//                 decoration: const InputDecoration(
//                     border: InputBorder.none,
//                     focusedBorder: InputBorder.none,
//                     enabledBorder: InputBorder.none,
//                     hintText: 'Message...'),
//               )),
//           InkWell(
//             onTap: ()async{
//               var image =  imgFromGallery();
//               image.then((value) async{
//                 await sendFile(File(value), 'image');
//               });
//             },
//             child: SvgPicture.asset(
//               Images.attachment,
//               colorFilter: const ColorFilter.mode(
//                   ColorResources.fieldGrey, BlendMode.srcIn),
//             ),
//           ),
//           10.horizontalSpace(),
//           SvgPicture.asset(
//             Images.camera,
//             colorFilter: const ColorFilter.mode(
//                 ColorResources.fieldGrey, BlendMode.srcIn),
//           ),
//
//           IconButton(
//               color: Theme.of(context).primaryColor,
//               icon: const Icon(
//                   Icons.send,
//                 size: 32,
//                 color: Colors.grey,
//               ),
//               onPressed: _enteredMessage.trim().isEmpty ? null : _sendMessage
//           )
//         ],
//       ),
//     );
//   }
// }