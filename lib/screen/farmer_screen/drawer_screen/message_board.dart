import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:glad/data/model/response_project_data_firebase.dart';
import 'package:glad/screen/chat/firebase_chat_screen.dart';
import 'package:glad/screen/custom_widget/custom_appbar.dart';
import 'package:glad/screen/custom_widget/custom_methods.dart';
import 'package:glad/screen/custom_widget/custom_textfield.dart';
import 'package:glad/screen/dde_screen/suggested_investment.dart';
import 'package:glad/screen/farmer_screen/drawer_screen/chat_screen.dart';
import 'package:glad/utils/app_constants.dart';
import 'package:glad/utils/color_resources.dart';
import 'package:glad/utils/extension.dart';
import 'package:glad/utils/images.dart';
import 'package:glad/utils/sharedprefrence.dart';
import 'package:glad/utils/styles.dart';

class MessageBoard extends StatefulWidget {
  const MessageBoard({super.key,required this.userRoleId,required this.userType,required this.roleType});
  final String userRoleId,userType,roleType;

  @override
  State<MessageBoard> createState() => _MessageBoardState();
}

class _MessageBoardState extends State<MessageBoard> {
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
                  titleText1: 'Message board',
                  titleText1Style:
                      figtreeMedium.copyWith(fontSize: 20, color: Colors.black),
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
                        StreamBuilder(
                            stream: FirebaseFirestore.instance.collection('projects_chats')
                                .where(widget.userType,
                                isEqualTo: widget.userRoleId).snapshots(),
                            builder: (ctx,chatSnapShot) {
                              // if(chatSnapShot.connectionState == ConnectionState.waiting) {
                              //   return const Center(child: CircularProgressIndicator(),);}
                              if(!chatSnapShot.hasData) {
                                return const SizedBox.shrink();
                              }
                              final chatDocs = chatSnapShot.data;
                              return ListView.builder(
                                  reverse: true,
                                  shrinkWrap: true,
                                  padding: const EdgeInsets.only(top: 20,bottom: 0),
                                  itemCount: chatDocs!.docs.length,itemBuilder: (ctx,index) {
                                return Padding(
                                  padding: const EdgeInsets.only(bottom: 10),
                                  child: InkWell(
                                    onTap: () async{
                                      print(chatDocs.docs[index]['farmer_id']);
                                      ResponseProjectDataForFirebase response = ResponseProjectDataForFirebase(
                                          userName: await SharedPrefManager.getPreferenceString(AppConstants.userName),
                                          projectName: chatDocs.docs[index]['project_name'].toString(),
                                          farmerProjectId: int.parse(chatDocs.docs[index]['farmer_project_id']),
                                          userType: widget.roleType,
                                          farmerName: chatDocs.docs[index]['farmer_name'].toString(),
                                          farmerAddress: chatDocs.docs[index]['farmer_address'].toString(),
                                          farmerId: '',
                                          ddeId: chatDocs.docs[index]['dde_id'].toString(),
                                          mccId: '',
                                          supplierId: '');

                                          // userType: 'dde', userId: int.parse(chatDocs.docs[index]['userId'].toString()));
                                      FirebaseChatScreen(responseProjectDataForFirebase: response,).navigate();
                                      // DDeFarmerInvestmentDetails(projectId: int.parse(chatDocs.docs[index]['dde_id'].toString())).navigate();
                                    },
                                    child: Stack(
                                      children: [
                                        Container(
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
                                          child: Row(
                                            crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                            mainAxisAlignment:
                                            MainAxisAlignment.start,
                                            children: [
                                              Image.asset(Images.sampleUser),
                                              15.horizontalSpace(),
                                              Column(
                                                crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                                children: [
                                                  Text(chatDocs.docs[index]['project_name'].toString(),
                                                      style: figtreeMedium
                                                          .copyWith(
                                                          fontSize: 18,
                                                          color: Colors
                                                              .black)),
                                                  4.verticalSpace(),
                                                  Row(
                                                    children: [
                                                      Text(chatDocs.docs[index]['farmer_name']??'',
                                                          style: figtreeRegular
                                                              .copyWith(
                                                              fontSize: 12,
                                                              color: ColorResources
                                                                  .fieldGrey)),
                                                      8.horizontalSpace(),
                                                      Container(
                                                        height: 4,
                                                        width: 4,
                                                        decoration:
                                                        const BoxDecoration(
                                                            color: Colors
                                                                .black,
                                                            shape: BoxShape
                                                                .circle),
                                                      ),
                                                      8.horizontalSpace(),
                                                      SizedBox(width: 90,
                                                        child: Text(chatDocs.docs[index]['farmer_address'].toString(),
                                                            overflow: TextOverflow.ellipsis,
                                                            style: figtreeRegular
                                                                .copyWith(
                                                                fontSize: 12,
                                                                color: ColorResources
                                                                    .fieldGrey)),
                                                      ),
                                                    ],
                                                  ),
                                                ],
                                              ),
                                            ],
                                          ),
                                        ),
                                        // Positioned(
                                        //   right: 20,
                                        //   top: 20,
                                        //   child: Column(
                                        //     crossAxisAlignment:
                                        //     CrossAxisAlignment.end,
                                        //     children: [
                                        //       Text('09:32 PM',
                                        //           style:
                                        //           figtreeRegular.copyWith(
                                        //               fontSize: 10,
                                        //               color: ColorResources
                                        //                   .black)),
                                        //       8.verticalSpace(),
                                        //       Container(
                                        //         padding:
                                        //         const EdgeInsets.all(5),
                                        //         decoration: BoxDecoration(
                                        //             color:
                                        //             const Color(0xFFFC5E60),
                                        //             borderRadius:
                                        //             BorderRadius.circular(
                                        //                 8)),
                                        //         child: Text('06',
                                        //             style:
                                        //             figtreeRegular.copyWith(
                                        //                 fontSize: 10,
                                        //                 color:
                                        //                 ColorResources
                                        //                     .white)),
                                        //       ),
                                        //     ],
                                        //   ),
                                        // )
                                      ],
                                    ),
                                  ),
                                );
                              }
                              );
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
