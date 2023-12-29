import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:glad/cubit/landing_page_cubit/landing_page_cubit.dart';
import 'package:glad/cubit/livestock_cubit/livestock_cubit.dart';
import 'package:glad/screen/custom_widget/custom_appbar.dart';
import 'package:glad/screen/custom_widget/custom_methods.dart';
import 'package:glad/screen/dde_screen/preview_screen.dart';
import 'package:glad/utils/color_resources.dart';
import 'package:glad/utils/extension.dart';
import 'package:glad/utils/helper.dart';
import 'package:glad/utils/images.dart';
import 'package:glad/utils/styles.dart';
import 'package:grouped_list/grouped_list.dart';
import 'package:intl/intl.dart';

class LivestockEnquirySellerChatScreen extends StatefulWidget {
  const LivestockEnquirySellerChatScreen({super.key, required this.livestockId, required this.cowBreed, required this.advertisementNumber, required this.userName, required this.userId, required this.defaultPrice});
  final String livestockId;
  final String cowBreed;
  final String advertisementNumber;
  final String userName;
  final String userId, defaultPrice;

  @override
  State<LivestockEnquirySellerChatScreen> createState() => _LivestockEnquirySellerChatScreenState();
}

class _LivestockEnquirySellerChatScreenState extends State<LivestockEnquirySellerChatScreen> {

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
      'user_name': context.read<LivestockCubit>().state.responseLivestockDetail!.data!.userName ?? '',
      'date': DateFormat.yMMMMd().format(DateTime.now()),
      'user_type': 'seller',
      "message_type": 'text',
      // "${currentUser}messageCount":FieldValue.increment(1),
    }).then((value) => print("Message Added"))
        .catchError((error) => print("Failed to add user: $error"));
    scrollController.animateTo(0, duration: const Duration(milliseconds: 300), curve: Curves.easeOut);
    commentController.clear();
  }

  @override
  Widget build(BuildContext contexts) {
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
                Center(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
                      child: StreamBuilder(
                          stream: FirebaseFirestore.instance.collection('livestock_enquiry')
                              .doc(widget.livestockId)
                              .collection('enquiries')
                              .doc(widget.userId).snapshots(),
                        builder: (contexts, snapshot) {
                            if(!snapshot.hasData) {
                              return SizedBox.shrink();
                            }
                            if(snapshot.data!.data()!.containsKey('negotiated_price')) {
                              return Container(
                                width: screenWidth(),
                                height: 55,
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.all(
                                      Radius.circular(30),
                                    ),
                                    border: Border.all(color: Color(0xff6A0030)),
                                    color: Colors.white),
                                padding: EdgeInsets.symmetric(horizontal: 14),
                                child: Row(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.start,
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        'Negotiated Price: '.textRegular(color: ColorResources.maroon, fontSize: 14),
                                        getCurrencyString(double.parse(snapshot.data!.data()!['negotiated_price'])).textBold(color: ColorResources.maroon, fontSize: 14)
                                      ],
                                    ),
                                    InkWell(
                                      onTap: () {
                                        TextEditingController controller = TextEditingController();
                                        controller.text = snapshot.data!.data()!['negotiated_price'].toString();

                                        modalBottomSheetMenu(context, radius: 40,
                                            child: StatefulBuilder(
                                                builder: (contexts, setState) {
                                                  return SizedBox(
                                                    height: 320,
                                                    child: Padding(
                                                      padding: const EdgeInsets
                                                          .fromLTRB(23, 40, 25, 10),
                                                      child: Column(
                                                          crossAxisAlignment: CrossAxisAlignment
                                                              .start,
                                                          children: [
                                                            Center(
                                                              child: Text(
                                                                'Negotiated Price',
                                                                style: figtreeMedium
                                                                    .copyWith(
                                                                    fontSize: 22),
                                                              ),
                                                            ),
                                                            30.verticalSpace(),
                                                            Column(
                                                              crossAxisAlignment: CrossAxisAlignment
                                                                  .start,
                                                              children: [
                                                                TextField(
                                                                  controller: controller,
                                                                  maxLines: 1,
                                                                  keyboardType: TextInputType
                                                                      .number,
                                                                  inputFormatters: [
                                                                    FilteringTextInputFormatter
                                                                        .digitsOnly
                                                                  ],
                                                                  minLines: 1,
                                                                  decoration: InputDecoration(
                                                                      hintText: 'Enter negotiated value',
                                                                      hintStyle: figtreeMedium
                                                                          .copyWith(
                                                                          fontSize: 18),
                                                                      border: OutlineInputBorder(
                                                                          borderRadius: BorderRadius
                                                                              .circular(
                                                                              12),
                                                                          borderSide: const BorderSide(
                                                                            width: 1,
                                                                            color: Color(
                                                                                0xff999999),
                                                                          ))),
                                                                ),
                                                                30.verticalSpace(),
                                                                Padding(
                                                                  padding: const EdgeInsets
                                                                      .fromLTRB(
                                                                      28, 0, 29, 0),
                                                                  child: customButton(
                                                                    'Submit',
                                                                    fontColor: 0xffFFFFFF,
                                                                    onTap: () {
                                                                      if (controller
                                                                          .text
                                                                          .isEmpty) {
                                                                        showCustomToast(
                                                                            context,
                                                                            "Please enter negotiated price");
                                                                      } else
                                                                      if (double
                                                                          .parse(
                                                                          controller
                                                                              .text) >
                                                                          double
                                                                              .parse(
                                                                              widget
                                                                                  .defaultPrice)) {
                                                                        showCustomToast(
                                                                            context,
                                                                            "Negotiated price shouldn't be greater than price of cow");
                                                                      } else {
                                                                        context
                                                                            .read<
                                                                            LivestockCubit>()
                                                                            .updateNegotiateApi(
                                                                            context,
                                                                            widget
                                                                                .livestockId,
                                                                            controller
                                                                                .text,
                                                                            widget
                                                                                .userId);
                                                                        FirebaseFirestore
                                                                            .instance
                                                                            .collection(
                                                                            'livestock_enquiry')
                                                                            .doc(
                                                                            widget
                                                                                .livestockId)
                                                                            .collection(
                                                                            'enquiries')
                                                                            .doc(
                                                                            widget
                                                                                .userId)
                                                                            .update(
                                                                            {
                                                                              'created_at': Timestamp
                                                                                  .now(),
                                                                              'negotiated_price': controller
                                                                                  .text
                                                                              // "${currentUser}messageCount":FieldValue.increment(1),
                                                                            })
                                                                            .then((
                                                                            value) =>
                                                                            print(
                                                                                "Negotiation Added"))
                                                                            .catchError((
                                                                            error) =>
                                                                            print(
                                                                                "Failed to add user: $error"));
                                                                        controller
                                                                            .clear();
                                                                        pressBack();
                                                                      }
                                                                    },
                                                                    height: 60,
                                                                    width: screenWidth(),
                                                                  ),
                                                                )
                                                              ],
                                                            )
                                                          ]),
                                                    ),
                                                  );
                                                }));
                                      },
                                      child: 'edit'.textRegular(color: Color(0xFFFC5E60), fontSize: 14, underLine: TextDecoration.underline),
                                    )
                                  ],
                                ),
                              );
                            }
                              return customButton("Add Negotiate Price",
                                  style: figtreeSemiBold.copyWith(
                                      color: Colors.white
                                  ), onTap: () {
                                    TextEditingController controller = TextEditingController();
                                    controller.text =
                                        widget.defaultPrice.toString();

                                    modalBottomSheetMenu(context, radius: 40,
                                        child: StatefulBuilder(
                                            builder: (contexts, setState) {
                                              return SizedBox(
                                                height: 320,
                                                child: Padding(
                                                  padding: const EdgeInsets
                                                      .fromLTRB(23, 40, 25, 10),
                                                  child: Column(
                                                      crossAxisAlignment: CrossAxisAlignment
                                                          .start,
                                                      children: [
                                                        Center(
                                                          child: Text(
                                                            'Negotiated Price',
                                                            style: figtreeMedium
                                                                .copyWith(
                                                                fontSize: 22),
                                                          ),
                                                        ),
                                                        30.verticalSpace(),
                                                        Column(
                                                          crossAxisAlignment: CrossAxisAlignment
                                                              .start,
                                                          children: [
                                                            TextField(
                                                              controller: controller,
                                                              maxLines: 1,
                                                              inputFormatters: [
                                                                FilteringTextInputFormatter.allow(RegExp(r'^\d+\.?\d{0,2}')),
                                                              ],
                                                              keyboardType: const TextInputType.numberWithOptions(decimal: true),
                                                              minLines: 1,
                                                              decoration: InputDecoration(
                                                                  hintText: 'Enter negotiated value',
                                                                  hintStyle: figtreeMedium
                                                                      .copyWith(
                                                                      fontSize: 18),
                                                                  border: OutlineInputBorder(
                                                                      borderRadius: BorderRadius
                                                                          .circular(
                                                                          12),
                                                                      borderSide: const BorderSide(
                                                                        width: 1,
                                                                        color: Color(
                                                                            0xff999999),
                                                                      ))),
                                                            ),
                                                            30.verticalSpace(),
                                                            Padding(
                                                              padding: const EdgeInsets
                                                                  .fromLTRB(
                                                                  28, 0, 29, 0),
                                                              child: customButton(
                                                                'Submit',
                                                                fontColor: 0xffFFFFFF,
                                                                onTap: () {
                                                                  if (controller
                                                                      .text
                                                                      .isEmpty) {
                                                                    showCustomToast(
                                                                        context,
                                                                        "Please enter negotiated price");
                                                                  } else
                                                                  if (double
                                                                      .parse(
                                                                      controller
                                                                          .text) >
                                                                      double
                                                                          .parse(
                                                                          widget
                                                                              .defaultPrice)) {
                                                                    showCustomToast(
                                                                        context,
                                                                        "Negotiated price shouldn't be greater than price of cow");
                                                                  } else {
                                                                    context
                                                                        .read<
                                                                        LivestockCubit>()
                                                                        .updateNegotiateApi(
                                                                        context,
                                                                        widget
                                                                            .livestockId,
                                                                        controller
                                                                            .text,
                                                                        widget
                                                                            .userId);
                                                                    FirebaseFirestore
                                                                        .instance
                                                                        .collection(
                                                                        'livestock_enquiry')
                                                                        .doc(
                                                                        widget
                                                                            .livestockId)
                                                                        .collection(
                                                                        'enquiries')
                                                                        .doc(
                                                                        widget
                                                                            .userId)
                                                                        .update(
                                                                        {
                                                                          'created_at': Timestamp
                                                                              .now(),
                                                                          'negotiated_price': controller
                                                                              .text
                                                                          // "${currentUser}messageCount":FieldValue.increment(1),
                                                                        })
                                                                        .then((
                                                                        value) =>
                                                                        print(
                                                                            "Negotiation Added"))
                                                                        .catchError((
                                                                        error) =>
                                                                        print(
                                                                            "Failed to add user: $error"));
                                                                    controller
                                                                        .clear();
                                                                    pressBack();
                                                                  }
                                                                },
                                                                height: 60,
                                                                width: screenWidth(),
                                                              ),
                                                            )
                                                          ],
                                                        )
                                                      ]),
                                                ),
                                              );
                                            }));
                                  },
                                  width: screenWidth(), height: 55);
                        }
                      ),
                    )
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
                            groupSeparatorBuilder: (String groupByValue) => const SizedBox.shrink(),
                            itemBuilder: (context, dynamic element) => element.data()['user_type'] == 'seller' ?
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
