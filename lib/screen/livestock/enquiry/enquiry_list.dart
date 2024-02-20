import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:glad/cubit/livestock_cubit/livestock_cubit.dart';
import 'package:glad/data/model/response_project_data_firebase.dart';
import 'package:glad/screen/chat/firebase_chat_screen.dart';
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

class EnquiryList extends StatefulWidget {
  const EnquiryList({super.key,required this.livestockId, required this.cowBreed, required this.advertisementNumber, required this.defaultPrice});
  final String livestockId, cowBreed, advertisementNumber, defaultPrice;

  @override
  State<EnquiryList> createState() => _EnquiryListState();
}

class _EnquiryListState extends State<EnquiryList> {
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
                  titleText1: 'Enquiry',
                  description: '${'${widget.cowBreed} cows'} (${widget.advertisementNumber})',
                  leading: arrowBackButton()),
              Expanded(
                child: SingleChildScrollView(
                  child: Padding(
                    padding:
                    const EdgeInsets.only(left: 18.0, right: 18, top: 20),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        /*const CustomTextField(
                          hint: 'Search message...',
                          leadingImage: Images.search,
                          imageColors: Colors.black,
                          radius: 60,
                        ),
                        0.verticalSpace(),*/
                        StreamBuilder(
                            stream: FirebaseFirestore.instance.collection('livestock_enquiry')
                                .doc(widget.livestockId).collection('enquiries').orderBy('created_at').snapshots(),
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

                                      LivestockEnquirySellerChatScreen(
                                        livestockId: widget.livestockId.toString(),
                                        cowBreed: widget.cowBreed.toString(),
                                        advertisementNumber: widget.advertisementNumber.toString(),
                                        userName: chatDocs.docs[index]['user_name'].toString(),
                                        userId: chatDocs.docs[index]['user_id'].toString(),
                                        defaultPrice: widget.defaultPrice,
                                        ddeId: chatDocs.docs[index].data()['dde_id'],).navigate();
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
                                                  networkImage(text: chatDocs.docs[index]['user_photo'].toString(), height: 46, width: 46, radius: 40),
                                                  15.horizontalSpace(),
                                                  Column(
                                                    crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                    children: [
                                                      Text(chatDocs.docs[index]['user_name'].toString(),
                                                          style: figtreeMedium
                                                              .copyWith(
                                                              fontSize: 18,
                                                              color: Colors
                                                                  .black)),
                                                      4.verticalSpace(),
                                                      Text(chatDocs.docs[index]['user_address']??'',
                                                          style: figtreeRegular
                                                              .copyWith(
                                                              fontSize: 12,
                                                              color: ColorResources
                                                                  .fieldGrey)),
                                                    ],
                                                  ),
                                                ],
                                              ),
                                              SvgPicture.asset(Images.chat, color: ColorResources.maroon,),
                                            ],
                                          ),
                                          StreamBuilder(
                                              stream: FirebaseFirestore.instance.collection('livestock_enquiry')
                                                  .doc(widget.livestockId)
                                                  .collection('enquiries')
                                                  .doc(chatDocs.docs[index]['user_id'].toString()).snapshots(),
                                              builder: (contexts, snapshot) {
                                                if(!snapshot.hasData) {
                                                  return SizedBox.shrink();
                                                }
                                                if(snapshot.data!.data()!.containsKey('negotiated_price')) {
                                                  return Column(
                                                    children: [
                                                      10.verticalSpace(),
                                                      Row(
                                                        crossAxisAlignment: CrossAxisAlignment.center,
                                                        mainAxisAlignment: MainAxisAlignment.center,
                                                        children: [
                                                          'Negotiated Price: '.textRegular(color: ColorResources.maroon, fontSize: 14),
                                                          getCurrencyString(double.parse(snapshot.data!.data()!['negotiated_price'])).textBold(color: ColorResources.maroon, fontSize: 14),
                                                        ],
                                                      ),
                                                    ],
                                                  );
                                                }
                                                return SizedBox.shrink();
                                              }
                                          ),
                                        ],
                                      ),
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
