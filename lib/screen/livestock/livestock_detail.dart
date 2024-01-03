import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:glad/cubit/landing_page_cubit/landing_page_cubit.dart';
import 'package:glad/cubit/livestock_cubit/livestock_cubit.dart';
import 'package:glad/cubit/profile_cubit/profile_cubit.dart';
import 'package:glad/data/model/add_followup_remark_model.dart';
import 'package:glad/data/model/frontend_kpi_model.dart';
import 'package:glad/data/model/livestock_cart_list.dart';
import 'package:glad/screen/auth_screen/login_with_password.dart';
import 'package:glad/screen/livestock/enquiry/enquiry_list.dart';
import 'package:glad/screen/livestock/enquiry/livestock_exquiry_chat.dart';
import 'package:glad/screen/livestock/livestock_cart_list_screen.dart';
import 'package:glad/screen/livestock/update_livestock.dart';
import 'package:glad/screen/custom_widget/custom_appbar.dart';
import 'package:glad/screen/custom_widget/custom_methods.dart';
import 'package:glad/utils/app_constants.dart';
import 'package:glad/utils/color_resources.dart';
import 'package:glad/utils/extension.dart';
import 'package:glad/utils/images.dart';
import 'package:glad/utils/styles.dart';
import 'package:intl/intl.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class LiveStockDetail extends StatefulWidget {
  const LiveStockDetail({Key? key, required this.isMyLivestock, required this.id,this.type}) : super(key: key);
  final bool isMyLivestock;
  final String id;
  final String? type;

  @override
  State<LiveStockDetail> createState() => _LiveStockDetailState();
}

class _LiveStockDetailState extends State<LiveStockDetail> {

  int activeIndex = 0;

  @override
  void initState() {
    BlocProvider.of<LivestockCubit>(context).livestockDetailApi(context, widget.id);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocBuilder<LivestockCubit, LivestockCubitState>(
          builder: (context, state) {
            if (state.status == LivestockStatus.submit) {
              return const Center(
                  child: CircularProgressIndicator(
                    color: ColorResources.maroon,
                  ));
            } else if (state.responseLivestockDetail == null) {
              return Center(child: Text("${state.responseLivestockDetail} Api Error"));
            } else {
              return Container(
                color: Colors.white,
                child: Stack(
                  children: [
                    landingBackground(),
                    Column(
                      children: [
                        CustomAppBar(
                          context: context,
                          titleText1: 'Cow Details',
                          centerTitle: true,
                          leading: arrowBackButton(),
                          // action: widget.isMyLivestock ? TextButton(
                          //   onPressed: () {
                          //     UpdateLivestock(detail: state.responseLivestockDetail!).navigate();
                          //     // context.read<ProfileCubit>().updateDdeFarmDetailApi(context,);
                          //   },
                          //   child: Text(
                          //     'Edit',
                          //     style: figtreeMedium.copyWith(
                          //         fontSize: 14, color: ColorResources.maroon),
                          //   ),
                          // ) : null,
                        ),
                        landingPage(context, state),
                      ],
                    ),
                  ],
                ),
              );
            }
          }
      ),
    );
  }

  Widget landingPage(BuildContext context, LivestockCubitState state){
    return Expanded(
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CarouselSlider(
                items: List.generate(state.responseLivestockDetail!.data!.liveStockDocumentFiles!.length, (index) =>
                    ClipRRect(
                        borderRadius: BorderRadius.circular(10),
                        child: CachedNetworkImage(imageUrl: state.responseLivestockDetail!.data!.liveStockDocumentFiles![index].originalUrl ?? '', width: screenWidth(), fit: BoxFit.cover,))),
                options: CarouselOptions(
                  // autoPlay: true,
                  clipBehavior: Clip.none,
                  enableInfiniteScroll: false,
                  viewportFraction: 0.9,
                  enlargeCenterPage: true,
                  height: screenWidth(),
                  onPageChanged: (index, reason) {
                    setState(() {
                      activeIndex = index;
                    });
                  },
                )),
            Center(
              child: Padding(
                padding: const EdgeInsets.all(5),
                child: AnimatedSmoothIndicator(
                  activeIndex: activeIndex,
                  count: state.responseLivestockDetail!.data!.liveStockDocumentFiles!.length,
                  effect: const WormEffect(
                      activeDotColor: ColorResources.maroon,
                      dotHeight: 7,
                      dotWidth: 7,
                      dotColor: ColorResources.grey),
                ),
              ),
            ),
            20.verticalSpace(),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      RichText(
                          text: TextSpan(children: [
                            TextSpan(
                                text: '${state.responseLivestockDetail!.data!.cowBreed!.name ?? ''} cow ',
                                style: figtreeMedium.copyWith(
                                    fontSize: 20, color: Colors.black)),
                            TextSpan(
                                text: '(${state.responseLivestockDetail!.data!.advertisementNo ?? ''})',
                                style: figtreeMedium.copyWith(
                                    fontSize: 20, color: const Color(0xFF727272)))
                          ])),


                      // widget.type == "buyer"?
                      Text(getCurrencyString(double.parse(state.responseLivestockDetail!.data!.price.toString())),
                          style: figtreeSemiBold.copyWith(
                              fontSize: 18, color: ColorResources.maroon,
                              decoration: state.responseLivestockDetail!.data!.negotiatedPrice != null ? state.responseLivestockDetail!.data!.negotiatedPrice!.isNotEmpty?TextDecoration.lineThrough:null : null
                              // decoration: TextDecoration.lineThrough
                          ))
                          // :const SizedBox.shrink(),

                    ],
                  ),
                  1.verticalSpace(),


                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text('Posted on ${DateFormat('dd MMMM, yyyy').format(DateTime.parse(state.responseLivestockDetail!.data!.createdAt ?? ''))}',
                          style: figtreeMedium.copyWith(fontSize: 12, color: const Color(0xFF727272)), maxLines: 2),
                      widget.type == "buyer"?
                      state.responseLivestockDetail!.data!.negotiatedPrice != null ? state.responseLivestockDetail!.data!.negotiatedPrice!.isNotEmpty?
                      Text(getCurrencyString(double.parse(state.responseLivestockDetail!.data!.negotiatedPrice![0].negotiatedPrice.toString())),
                          style: figtreeSemiBold.copyWith(
                            fontSize: 22, color: ColorResources.black,
                            // decoration: TextDecoration.lineThrough
                          )):const SizedBox.shrink():const SizedBox.shrink():const SizedBox.shrink(),
                    ],
                  ),


                  5.verticalSpace(),

                  Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [

                      Text(state.responseLivestockDetail!.data!.user!=null?state.responseLivestockDetail!.data!.user!.name+","??'':'',
                          style: figtreeMedium.copyWith(
                            fontSize: 12, color: ColorResources.black,
                            // decoration: TextDecoration.lineThrough
                          )),

                      Expanded(
                        child: Text(state.responseLivestockDetail!.data!.user!.address != null
                            ? state.responseLivestockDetail!.data!.user!.address!.address != null
                            && state.responseLivestockDetail!.data!.user!.address!.subCounty != null
                            ? " ${state.responseLivestockDetail!.data!.user!.address!.address!}"
                            : ''
                            : '',
                            style: figtreeMedium.copyWith(
                                fontSize: 12, color: Colors.black), maxLines: 2),
                      ),

                  ],),
                  // 5.verticalSpace(),



                  30.verticalSpace(),
                  Text(
                      'Specifications ',
                      style: figtreeMedium.copyWith(
                          fontSize: 14, color: const Color(0xFF727272))),
                  10.verticalSpace(),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        child: Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            border: Border.all(color: const Color(0xFFDCDCDC))
                          ),
                          padding:
                          const EdgeInsets.symmetric(vertical: 12, horizontal: 9),
                          alignment: Alignment.center,
                          child: RichText(
                              text: TextSpan(children: [
                                TextSpan(
                                    text: 'Age: ',
                                    style: figtreeMedium.copyWith(
                                        fontSize: 16, color: const Color(0xFF727272))),
                                TextSpan(
                                    text: '${state.responseLivestockDetail!.data!.age ?? ''} yrs',
                                    style: figtreeMedium.copyWith(
                                        fontSize: 16, color: Colors.black)),
                              ])),
                        ),
                      ),
                      10.horizontalSpace(),
                      Expanded(
                        child: Container(
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              border: Border.all(color: const Color(0xFFDCDCDC))
                          ),
                          padding:
                          const EdgeInsets.symmetric(vertical: 12, horizontal: 9),
                          alignment: Alignment.center,
                          child: RichText(
                              text: TextSpan(children: [
                                TextSpan(
                                    text: 'Quantity: ',
                                    style: figtreeMedium.copyWith(
                                        fontSize: 16, color: const Color(0xFF727272))),
                                TextSpan(
                                    text: state.responseLivestockDetail!.data!.balanceCows.toString() ?? '',
                                    style: figtreeMedium.copyWith(
                                        fontSize: 16, color: Colors.black))
                              ])),
                        ),
                      ),
                    ],
                  ),
                  10.verticalSpace(),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        child: Container(
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              border: Border.all(color: const Color(0xFFDCDCDC))
                          ),
                          padding:
                          const EdgeInsets.symmetric(vertical: 12, horizontal: 9),
                          alignment: Alignment.center,
                          child: RichText(
                              text: TextSpan(children: [
                                TextSpan(
                                    text: 'Pregnant: ',
                                    style: figtreeMedium.copyWith(
                                        fontSize: 16, color: const Color(0xFF727272))),
                                TextSpan(
                                    text: '${state.responseLivestockDetail!.data!.pregnant ?? ''}',
                                    style: figtreeMedium.copyWith(
                                        fontSize: 16, color: Colors.black)),
                              ])),
                        ),
                      ),
                      10.horizontalSpace(),
                      Expanded(
                        child: Container(
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              border: Border.all(color: const Color(0xFFDCDCDC))
                          ),
                          padding:
                          const EdgeInsets.symmetric(vertical: 12, horizontal: 9),
                          alignment: Alignment.center,
                          child: RichText(
                              text: TextSpan(children: [
                                TextSpan(
                                    text: 'Lactation: ',
                                    style: figtreeMedium.copyWith(
                                        fontSize: 16, color: const Color(0xFF727272))),
                                TextSpan(
                                    text: (state.responseLivestockDetail!.data!.lactation ?? '').toString(),
                                    style: figtreeMedium.copyWith(
                                        fontSize: 16, color: Colors.black))
                              ])),
                        ),
                      ),
                    ],
                  ),
                  10.verticalSpace(),
                  Row(
                    children: [
                      Expanded(
                        child: Container(
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              border: Border.all(color: const Color(0xFFC788A5)),
                            color: const Color(0xFFFFF3F4)
                          ),
                          padding:
                          const EdgeInsets.symmetric(vertical: 12, horizontal: 9),
                          alignment: Alignment.center,
                          child: RichText(
                              text: TextSpan(children: [
                                TextSpan(
                                    text: 'Milk: ',
                                    style: figtreeMedium.copyWith(
                                        fontSize: 16, color: const Color(0xFF727272))),
                                TextSpan(
                                    text: '${double.parse(state.responseLivestockDetail!.data!.yield ?? '').toInt()} Litre per day',
                                    style: figtreeMedium.copyWith(
                                        fontSize: 16, color: Colors.black))
                              ])),
                        ),
                      ),
                    ],
                  ),
                  30.verticalSpace(),
                  Text(
                      'Description ',
                      style: figtreeMedium.copyWith(
                          fontSize: 14, color: const Color(0xFF727272))),
                  15.verticalSpace(),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Expanded(
                        child: Text(
                          state.responseLivestockDetail!.data!.description ?? '',
                          style: figtreeMedium.copyWith(
                            fontSize: 14, color: Colors.black),
                          softWrap: true,
                        ),
                      ),
                    ],
                  ),
                  if(widget.isMyLivestock)
                    Column(
                      children: [
                        30.verticalSpace(),
                        Text(
                            'Advertisement Status ',
                            style: figtreeMedium.copyWith(
                                fontSize: 14, color: const Color(0xFF727272))),
                        15.verticalSpace(),
                      ],
                    ),
                  if(widget.isMyLivestock)
                    kpi(context, state),
                  40.verticalSpace(),
                  if(widget.isMyLivestock)
                    Column(
                      children: [

                        Row(
                          children: [
                            StreamBuilder(
                              stream: FirebaseFirestore.instance.collection('livestock_enquiry')
                                  .doc(widget.id).collection('enquiries').snapshots(),
                              builder: (context, snapshot) {
                                if(!snapshot.hasData) {
                                  return const SizedBox.shrink();
                                }
                                if(snapshot.data!.docs.isEmpty) {
                                  return const SizedBox.shrink();
                                }
                                return Expanded(
                                  child: customButton('Enquiries',
                                      style: figtreeMedium.copyWith(fontSize: 16),
                                      onTap: () {
                                        EnquiryList(livestockId: widget.id, cowBreed: state.responseLivestockDetail!.data!.cowBreed!.name ?? '', advertisementNumber: state.responseLivestockDetail!.data!.advertisementNo ?? '', defaultPrice: state.responseLivestockDetail!.data!.price.toString(),).navigate();
                                      },
                                      borderColor: 0xFFFC5E60,
                                      color: 0xffFFFFFF,
                                      enableFirst: true,
                                      height: 60,
                                      width: screenWidth(),
                                      widget: SvgPicture.asset(Images.chat, color: ColorResources.maroon,)),
                                );
                              }
                            ),
                            /*20.horizontalSpace(),
                            Expanded(
                              child: customButton('',
                                  style: figtreeMedium.copyWith(fontSize: 16),
                                  onTap: () {
                                    pressBack();
                                  },
                                  // borderColor: 0xFFFC5E60,
                                  // color: 0xffFFFFFF,
                                  enableFirst: true,
                                  height: 60,
                                  width: screenWidth(),
                                  widget: Row(
                                    children: [
                                      SvgPicture.asset(Images.loans,),
                                      10.horizontalSpace(),
                                      Text(
                                        'Loans',
                                        style: figtreeRegular.copyWith(
                                            fontSize: 16, color: Colors.white),
                                        softWrap: true,
                                      )
                                    ],
                                  )),
                            ),*/
                          ],
                        ),
                        20.verticalSpace(),
                        if(int.parse(state.responseLivestockDetail!.data!.balanceCows!.toString()) != 0)
                        customButton('Remove this ad',
                            style: figtreeMedium.copyWith(fontSize: 16),
                            onTap: () {
                              BlocProvider.of<LivestockCubit>(context).removeLivestockAPi(context, int.parse(widget.id));
                            },
                            width: screenWidth(),
                            height: 60,
                            color: 0xffDCDCDC),
                      ],
                    )
                  else
                  Row(
                    children: [
                      Expanded(
                        child: customButton('',
                            style: figtreeMedium.copyWith(fontSize: 16),
                            onTap:  BlocProvider
                                .of<LandingPageCubit>(context)
                                .sharedPreferences
                                .containsKey(AppConstants.userType) ? () async {
                              if (BlocProvider.of<ProfileCubit>(context).state.responseFarmerProfile == null) {
                                  await BlocProvider.of<ProfileCubit>(context).getFarmerProfile(context);
                              }
                              final query = FirebaseFirestore.instance.collection('livestock_enquiry').doc(widget.id);
                                  query.set({
                                'user_id': state.responseLivestockDetail!.data!.userId.toString(),
                                'livestock_id': widget.id.toString(),
                                'advertisement_number': state.responseLivestockDetail!.data!.advertisementNo.toString(),
                                'cow_breed': state.responseLivestockDetail!.data!.cowBreed!.name.toString(),
                                'created_at': Timestamp.now(),
                              });
                                  query.collection('enquiries').doc(context.read<LivestockCubit>().sharedPreferences.getString(AppConstants.userId)).
                                      set({
                                    'user_id': context.read<LivestockCubit>().sharedPreferences.getString(AppConstants.userId),
                                    'user_name': BlocProvider.of<ProfileCubit>(context).state.responseFarmerProfile!.farmer!.name ?? '',
                                    'user_address': BlocProvider.of<ProfileCubit>(context).state.responseFarmerProfile!.farmer!.address != null ? BlocProvider.of<ProfileCubit>(context).state.responseFarmerProfile!.farmer!.address!.address ?? '' : '',
                                    'user_photo': BlocProvider.of<ProfileCubit>(context).state.responseFarmerProfile!.farmer!.photo ?? '',
                                  });
                              LivestockEnquiryChatScreen(
                                livestockId: widget.id.toString(),
                                cowBreed: state.responseLivestockDetail!.data!.cowBreed!.name.toString(),
                                advertisementNumber: state.responseLivestockDetail!.data!.advertisementNo.toString(), userName: BlocProvider.of<ProfileCubit>(context).state.responseFarmerProfile!.farmer!.name ?? '',
                                userId: context.read<LivestockCubit>().sharedPreferences.getString(AppConstants.userId)!,).navigate();
                            } : () {
                          LoginWithPassword().navigate();
                            },
                            width: screenWidth(),
                            fontColor: 0xffFFFFFF,
                            color: 0xffFFFFFF,
                            borderColor: 0xFFFC5E60,
                            height: 60,
                            enableFirst: true,
                            widget: Row(
                              children: [
                                SvgPicture.asset(Images.chat, color: ColorResources.maroon,),
                                10.horizontalSpace(),
                                Text(
                                  'Enquiries',
                                  style: figtreeMedium.copyWith(
                                      fontSize: 16, color: Colors.black),
                                  softWrap: true,
                                )
                              ],
                            )),
                      ),
                      20.horizontalSpace(),
                      state.responseLivestockDetail!.data!.balanceCows == 0?
                      Expanded(
                        child: customButton('Out of stock',
                            style: figtreeMedium.copyWith(fontSize: 16, color: const Color(0xffFFFFFF)),
                            onTap: () {

                            },
                            width: screenWidth(),
                            fontColor: 0xffFFFFFF,
                            height: 60),
                      ):
                      Expanded(
                        child: customButton(state.responseLivestockDetail!.data!.isInCart == 0?'Add to cart':'View Cart',
                            style: figtreeMedium.copyWith(fontSize: 16, color: const Color(0xffFFFFFF)),
                            onTap:  BlocProvider
                                .of<LandingPageCubit>(context)
                                .sharedPreferences
                                .containsKey(AppConstants.userType) ? () {
                              if(state.responseLivestockDetail!.data!.isInCart == 0){
                                int quantity = 1;
                                modalBottomSheetMenu(context,
                                    radius: 40,
                                    child: StatefulBuilder(
                                        builder: (context, setState) {
                                          return SizedBox(
                                            height: 280,
                                            child: Padding(
                                              padding: const EdgeInsets.fromLTRB(23, 40, 25, 10),
                                              child: Column(
                                                  crossAxisAlignment: CrossAxisAlignment.start,
                                                  children: [
                                                    Center(
                                                      child: Text(
                                                        'Add To Cart',
                                                        style: figtreeMedium.copyWith(fontSize: 22),
                                                      ),
                                                    ),
                                                    30.verticalSpace(),
                                                    Container(
                                                      height: 55,
                                                      decoration: BoxDecoration(
                                                          border: Border.all(color: const Color(0xffD9D9D9,),width: 1.5),
                                                          borderRadius: BorderRadius.circular(10),
                                                          color: Colors.white
                                                      ),
                                                      width: screenWidth(),
                                                      padding: const EdgeInsets.symmetric(horizontal: 20),
                                                      child: Row(
                                                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                        children: [
                                                          InkWell(
                                                              onTap: () {
                                                                if(quantity == 1) {
                                                                  return;
                                                                }
                                                                quantity--;
                                                                setState(() {

                                                                });
                                                              },
                                                              child: SvgPicture.asset(Images.minusQuant)),
                                                          quantity.toString().textMedium(fontSize: 16, color: Colors.black),
                                                          InkWell(
                                                              onTap: () {
                                                                if(quantity < state.responseLivestockDetail!.data!.balanceCows){
                                                                  quantity++;
                                                                  setState(() {

                                                                  });
                                                                }else{
                                                                  showCustomToast(context, "Quantity not available");
                                                                }
                                                              },
                                                              child: SvgPicture.asset(Images.addQuant)),

                                                        ],),
                                                    ),

                                                    Column(
                                                      crossAxisAlignment: CrossAxisAlignment.start,
                                                      children: [

                                                        30.verticalSpace(),

                                                        Padding(
                                                          padding: const EdgeInsets.fromLTRB(28, 0, 29, 0),
                                                          child: customButton(
                                                            'Save',
                                                            fontColor: 0xffFFFFFF,
                                                            onTap: () {

                                                              context.read<LivestockCubit>().livestockAddToCartApi(context, state.responseLivestockDetail!.data!.id.toString(), quantity,state.responseLivestockDetail!.data!.negotiatedPrice!.isNotEmpty?state.responseLivestockDetail!.data!.negotiatedPrice![0].negotiatedPrice.toString():state.responseLivestockDetail!.data!.price.toString());

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
                                        }
                                    ));
                              }else{
                                /*int quantity = 1;
                                modalBottomSheetMenu(context,
                                    radius: 40,
                                    child: StatefulBuilder(
                                        builder: (context, setState) {
                                          return SizedBox(
                                            height: 280,
                                            child: Padding(
                                              padding: const EdgeInsets.fromLTRB(23, 40, 25, 10),
                                              child: Column(
                                                  crossAxisAlignment: CrossAxisAlignment.start,
                                                  children: [
                                                    Center(
                                                      child: Text(
                                                        'Add To Cart',
                                                        style: figtreeMedium.copyWith(fontSize: 22),
                                                      ),
                                                    ),
                                                    30.verticalSpace(),
                                                    Container(
                                                      height: 55,
                                                      decoration: BoxDecoration(
                                                          border: Border.all(color: const Color(0xffD9D9D9,),width: 1.5),
                                                          borderRadius: BorderRadius.circular(10),
                                                          color: Colors.white
                                                      ),
                                                      width: screenWidth(),
                                                      padding: const EdgeInsets.symmetric(horizontal: 20),
                                                      child: Row(
                                                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                        children: [
                                                          InkWell(
                                                              onTap: () {
                                                                if(quantity == 1) {
                                                                  return;
                                                                }
                                                                quantity--;
                                                                setState(() {

                                                                });
                                                              },
                                                              child: SvgPicture.asset(Images.minusQuant)),
                                                          quantity.toString().textMedium(fontSize: 16, color: Colors.black),
                                                          InkWell(
                                                              onTap: () {
                                                                if(quantity < state.responseLivestockDetail!.data!.balanceCows){
                                                                  quantity++;
                                                                  setState(() {

                                                                  });
                                                                }else{
                                                                  showCustomToast(context, "Available quantity is only $quantity");
                                                                }
                                                              },
                                                              child: SvgPicture.asset(Images.addQuant)),

                                                        ],),
                                                    ),

                                                    Column(
                                                      crossAxisAlignment: CrossAxisAlignment.start,
                                                      children: [

                                                        30.verticalSpace(),

                                                        Padding(
                                                          padding: const EdgeInsets.fromLTRB(28, 0, 29, 0),
                                                          child: customButton(
                                                            'Save',
                                                            fontColor: 0xffFFFFFF,
                                                            onTap: () {

                                                              context.read<LivestockCubit>().livestockAddToCartApi(context, state.responseLivestockDetail!.data!.id.toString(), quantity,state.responseLivestockDetail!.data!.price.toString());

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
                                        }
                                    ));*/
                                const LiveStockCartListScreen().navigate();
                              }
                            } : () {
                          LoginWithPassword().navigate();
                            },
                            width: screenWidth(),
                            fontColor: 0xffFFFFFF,
                            height: 60),
                      )
                    ],
                  ),
                  40.verticalSpace(),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}


Widget kpi(context,LivestockCubitState state) {
  List<FrontendKpiModel> kpiData = [];

  if(state.responseLivestockDetail!.data!.cowQty!=null){
    kpiData.add(FrontendKpiModel(name: 'Listed Cows',
        image: Images.investmentKpi,
        value: state.responseLivestockDetail!.data!.cowQty!.toString()));
  }

  if(state.responseLivestockDetail!.data!.soldQty!=null){
    kpiData.add(FrontendKpiModel(name: 'Sold Directly to Buyers',
        image: Images.investmentKpi,
        value: state.responseLivestockDetail!.data!.soldQty!.toString()));
  }

  if(state.responseLivestockDetail!.data!.loanAccepted!=null){
    kpiData.add(FrontendKpiModel(name: 'Loan Accepted',
        image: Images.investmentKpi,
        value: state.responseLivestockDetail!.data!.loanAccepted!.toString()));
  }

  if(state.responseLivestockDetail!.data!.loanApproved!=null){
    kpiData.add(FrontendKpiModel(name: 'Loan Approved',
        image: Images.investmentKpi,
        value: state.responseLivestockDetail!.data!.loanApproved!.toString()));
  }

  if(state.responseLivestockDetail!.data!.balanceCows!=null){
    kpiData.add(FrontendKpiModel(name: 'Remaining Cows',
        image: Images.investmentKpi,
        value: state.responseLivestockDetail!.data!.balanceCows!.toString()));
  }
  return customGrid(context,
      list: kpiData,
      crossAxisCount: 3,
      mainAxisSpacing: 15,
      crossAxisSpacing: 13,
      mainAxisExtent: 123,
      child: (index){
        return InkWell(
          onTap: (){
            // if(kpiData[index].name.toString() == "Paid EMIs"){
            //   ProjectDetailStatement(userRoleId: state.responseFarmerProjectDetail!.data!.farmerProject![0].farmerMaster!.id.toString(),farmerProjectId: widget.projectId.toString(),status: 'paid',).navigate();
            // }else if(kpiData[index].name.toString() == "Remaining Payable"){
            //   ProjectDetailStatement(userRoleId: state.responseFarmerProjectDetail!.data!.farmerProject![0].farmerMaster!.id.toString(),farmerProjectId: widget.projectId.toString(),status: 'due',).navigate();
            // }
          },
          child: Container(
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(14),
              border: Border.all(color: const Color(0xffDCDCDC),width: 1),
              boxShadow:[
                BoxShadow(
                    color: Colors.grey.withOpacity(0.2),
                    blurRadius: 2.0,
                    offset: const Offset(0, 2))],
            ),
            child: Padding(
              // padding: 0.paddingAll(),
              padding: const EdgeInsets.fromLTRB(8, 10, 8, 2),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      SvgPicture.asset(
                        kpiData[index].image.toString(),
                        width: 30,
                        height: 30,
                      ),
                      // kpiData[index].actionImage!=null?
                      kpiData[index].name.toString() == "Sold Directly to Buyers"?
                      state.responseLivestockDetail!.data!.balanceCows >0?
                      InkWell(
                          onTap: (){
                            int quantity = int.parse(kpiData[index].value ?? '');
                              modalBottomSheetMenu(context,
                                  radius: 40,
                                  child: StatefulBuilder(
                                      builder: (context, setState) {
                                        return SizedBox(
                                          height: 280,
                                          child: Padding(
                                            padding: const EdgeInsets.fromLTRB(23, 40, 25, 10),
                                            child: Column(
                                                crossAxisAlignment: CrossAxisAlignment.start,
                                                children: [
                                                  Center(
                                                    child: Text(
                                                      'Sold Directly to Buyers',
                                                      style: figtreeMedium.copyWith(fontSize: 22),
                                                    ),
                                                  ),
                                                  30.verticalSpace(),
                                                  Container(
                                                    height: 55,
                                                    decoration: BoxDecoration(
                                                        border: Border.all(color: const Color(0xffD9D9D9,),width: 1.5),
                                                        borderRadius: BorderRadius.circular(10),
                                                        color: Colors.white
                                                    ),
                                                    width: screenWidth(),
                                                    padding: const EdgeInsets.symmetric(horizontal: 20),
                                                    child: Row(
                                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                      children: [
                                                        InkWell(
                                                            onTap: () {
                                                              if(quantity == 1) {
                                                                return;
                                                              }
                                                              quantity--;
                                                              setState(() {

                                                              });
                                                            },
                                                            child: SvgPicture.asset(Images.minusQuant)),
                                                        quantity.toString().textMedium(fontSize: 16, color: Colors.black),
                                                        InkWell(
                                                            onTap: () {
                                                              if(quantity < state.responseLivestockDetail!.data!.cowQty){
                                                                quantity++;
                                                                setState(() {

                                                                });
                                                              }else{
                                                                showCustomToast(context, "Available quantity is only $quantity");
                                                              }
                                                            },
                                                            child: SvgPicture.asset(Images.addQuant)),

                                                      ],),
                                                  ),

                                                  Column(
                                                    crossAxisAlignment: CrossAxisAlignment.start,
                                                    children: [

                                                      30.verticalSpace(),
                                                      Padding(
                                                        padding: const EdgeInsets.fromLTRB(28, 0, 29, 0),
                                                        child: customButton(
                                                          'Save',
                                                          fontColor: 0xffFFFFFF,
                                                          onTap: () {
                                                              BlocProvider.of<LivestockCubit>(context).updateSoldCowApi(context, state.responseLivestockDetail!.data!.id!, quantity);
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
                                      }
                                  ));

                          },
                          child: Text(
                            'Update',
                            style: figtreeMedium.copyWith(
                              fontSize: 10,
                              decoration:TextDecoration.underline,
                              color: const Color(0xFFFC5E60)
                            ),
                          )):const SizedBox.shrink()
                          : const SizedBox.shrink(),
                      // const Align(alignment: Alignment.centerRight,child: Icon(Icons.check_circle,color: Colors.green,size: 20,))
                      //     :SvgPicture.asset(kpiData[index].actionImage.toString()):const SizedBox.shrink()

                    ],
                  ),
                  15.verticalSpace(),
                  Text(
                    '${kpiData[index].value}',
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: figtreeMedium.copyWith(fontSize: 14.3),
                  ),
                  05.verticalSpace(),
                  Text(
                    kpiData[index].name.toString(),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: figtreeRegular.copyWith(
                      fontSize: 12.5,
                    ),
                  )
                ],
              ),
            ),
          ),
        );
      });
}