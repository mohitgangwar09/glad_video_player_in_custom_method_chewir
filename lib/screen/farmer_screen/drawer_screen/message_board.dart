import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:glad/cubit/auth_cubit/auth_cubit.dart';
import 'package:glad/cubit/landing_page_cubit/landing_page_cubit.dart';
import 'package:glad/data/model/response_project_data_firebase.dart';
import 'package:glad/screen/chat/firebase_chat_screen.dart';
import 'package:glad/screen/custom_widget/custom_appbar.dart';
import 'package:glad/screen/custom_widget/custom_methods.dart';
import 'package:glad/utils/app_constants.dart';
import 'package:glad/utils/color_resources.dart';
import 'package:glad/utils/extension.dart';
import 'package:glad/utils/sharedprefrence.dart';
import 'package:glad/utils/styles.dart';

class MessageBoard extends StatelessWidget {
  const MessageBoard({super.key});

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
                        const EdgeInsets.only(left: 18.0, right: 18, top: 10),
                    child: StreamBuilder(
                        stream: FirebaseFirestore.instance.collection('projects_chats')
                            .where('${context.read<AuthCubit>().sharedPreferences.get(AppConstants.userType)}_id', isEqualTo: context.read<AuthCubit>().sharedPreferences.get(AppConstants.userRoleId))
                            .orderBy('updated_at')
                            .snapshots(),
                        builder: (ctx,AsyncSnapshot<QuerySnapshot<Map<String, dynamic>>> chatSnapShot) {
                          if(chatSnapShot.connectionState == ConnectionState.waiting) {
                            return const Center(child: CircularProgressIndicator());
                          }
                          if(!chatSnapShot.hasData) {
                            return const SizedBox.shrink();
                          }
                          final chatDocs = chatSnapShot.data;
                          if(chatDocs!.docs.isEmpty){
                            return SizedBox(height: 350,child: Center(child: Text("No message available",
                            style: figtreeMedium.copyWith(
                              fontSize: 17
                            ),)));
                          }
                          return ListView.builder(
                              reverse: true,
                              shrinkWrap: true,
                              padding: const EdgeInsets.only(top: 20,bottom: 0),
                              controller: ScrollController(),
                              itemCount: chatDocs.docs.length,itemBuilder: (ctx,index) {
                            return Padding(
                              padding: const EdgeInsets.only(bottom: 10),
                              child: InkWell(
                                onTap: () async{
                                  ResponseProjectDataForFirebase response = ResponseProjectDataForFirebase(
                                      userName: await SharedPrefManager.getPreferenceString(AppConstants.userName),
                                      projectName: chatDocs.docs[index]['project_name'].toString(),
                                      farmerProjectId: int.parse(chatDocs.docs[index]['farmer_project_id']),
                                      userType: BlocProvider.of<AuthCubit>(context).sharedPreferences.get(AppConstants.userType).toString(),
                                      farmerName: chatDocs.docs[index]['farmer_name'].toString(),
                                      farmerAddress: chatDocs.docs[index]['farmer_address'].toString(),
                                      farmerId: chatDocs.docs[index]['farmer_id'].toString(),
                                      ddeId: chatDocs.docs[index]['dde_id'].toString(),
                                      mccId: chatDocs.docs[index]['mcc_id'].toString(),
                                      supplierId: chatDocs.docs[index]['supplier_id'].toString(),
                                      projectImage: chatDocs.docs[index].data()['project_image'] ?? '');
                                  FirebaseChatScreen(responseProjectDataForFirebase: response,).navigate();
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
                                          networkImage(text: chatDocs.docs[index].data()['project_image'] ?? '', width: 46, height: 46, radius: 46),
                                          10.horizontalSpace(),
                                          Expanded(
                                            child: Column(
                                              crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                              children: [
                                                Text(chatDocs.docs[index]['project_name'].toString(),
                                                    style: figtreeMedium
                                                        .copyWith(
                                                        fontSize: 16,
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
                                          ),
                                        ],
                                      ),
                                    ),
                                    Positioned(
                                      right: 20,
                                      top: 20,
                                      child: Column(
                                        crossAxisAlignment:
                                        CrossAxisAlignment.end,
                                        children: [
                                          // Text('09:32 PM',
                                          //     style:
                                          //     figtreeRegular.copyWith(
                                          //         fontSize: 10,
                                          //         color: ColorResources
                                          //             .black)),
                                          // 8.verticalSpace(),
                                          StreamBuilder(
                                            stream: FirebaseFirestore.instance.collection('projects_chats')
                                                .doc(chatDocs.docs[index]['farmer_project_id'].toString())
                                                .collection('read-receipts')
                                                .where('user_id', isEqualTo: BlocProvider.of<LandingPageCubit>(context).sharedPreferences.getString(AppConstants.userRoleId).toString())
                                                .where('user_type', isEqualTo: BlocProvider.of<LandingPageCubit>(context).sharedPreferences.getString(AppConstants.userType).toString())
                                                .snapshots(),
                                            builder: (context, snapshot) {
                                              if(!snapshot.hasData){
                                                return const SizedBox.shrink();
                                              }
                                              if(snapshot.data!.docs.isEmpty) {
                                                return const SizedBox.shrink();
                                              }
                                              return Container(
                                                padding:
                                                const EdgeInsets.all(8),
                                                decoration: BoxDecoration(
                                                    color:
                                                    const Color(0xFFFC5E60),
                                                    borderRadius:
                                                    BorderRadius.circular(
                                                        20)),
                                                child: Text(snapshot.data!.docs.length.toString(),
                                                    style:
                                                    figtreeRegular.copyWith(
                                                        fontSize: 10,
                                                        color:
                                                        ColorResources
                                                            .white)),
                                              );
                                            }
                                          ),
                                        ],
                                      ),
                                    )
                                  ],
                                ),
                              ),
                            );
                          }
                          );
                        }
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
