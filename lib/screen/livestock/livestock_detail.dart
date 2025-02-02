import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:glad/cubit/auth_cubit/auth_cubit.dart';
import 'package:glad/cubit/dde_farmer_cubit/dde_farmer_cubit.dart';
import 'package:glad/cubit/landing_page_cubit/landing_page_cubit.dart';
import 'package:glad/cubit/livestock_cubit/livestock_cubit.dart';
import 'package:glad/cubit/profile_cubit/profile_cubit.dart';
import 'package:glad/data/model/add_followup_remark_model.dart';
import 'package:glad/data/model/frontend_kpi_model.dart';
import 'package:glad/data/model/livestock_cart_list.dart';
import 'package:glad/screen/auth_screen/login_with_password.dart';
import 'package:glad/screen/auth_screen/register_popup.dart';
import 'package:glad/screen/dde_livestock/add_mark_as_delivery.dart';
import 'package:glad/screen/dde_livestock/remove_this_ad_otp.dart';
import 'package:glad/screen/dde_screen/dashboard_tab_screen/farmer_dde_tab_screen.dart';
import 'package:glad/screen/livestock/enquiry/enquiry_list.dart';
import 'package:glad/screen/livestock/enquiry/livestock_exquiry_chat.dart';
import 'package:glad/screen/livestock/livestock_cart_list_screen.dart';
import 'package:glad/screen/livestock/update_livestock.dart';
import 'package:glad/screen/custom_widget/custom_appbar.dart';
import 'package:glad/screen/custom_widget/custom_methods.dart';
import 'package:glad/utils/app_constants.dart';
import 'package:glad/utils/color_resources.dart';
import 'package:glad/utils/extension.dart';
import 'package:glad/utils/helper.dart';
import 'package:glad/utils/images.dart';
import 'package:glad/utils/styles.dart';
import 'package:intl/intl.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class LiveStockDetail extends StatefulWidget {
  const LiveStockDetail({Key? key, required this.isMyLivestock, required this.id,this.type, this.removeUserID}) : super(key: key);
  final bool isMyLivestock;
  final String id;
  final String? type;
  final String? removeUserID;

  @override
  State<LiveStockDetail> createState() => _LiveStockDetailState();
}

class _LiveStockDetailState extends State<LiveStockDetail> {

  int activeIndex = 0;
  String countryCode = "";

  @override
  void initState() {
    if(BlocProvider.of<AuthCubit>(context).isLoggedIn()){
    if(BlocProvider.of<AuthCubit>(context).sharedPreferences.getString(AppConstants.userType) == "dde"){
      BlocProvider.of<DdeFarmerCubit>(context).getFarmer(context, '${BlocProvider.of<DdeFarmerCubit>(context).state.selectedRagRatingType}'.toLowerCase(), true, fromLivestockDetail: widget.removeUserID);
    }}

    getCountryCode();
    BlocProvider.of<LivestockCubit>(context).livestockDetailApi(context, widget.id);
    super.initState();
  }

  void getCountryCode() async{
    String countryCodes = await BlocProvider.of<ProfileCubit>(context).getCountryCode();
    countryCode = countryCodes;
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

  Widget landingPage(BuildContext contexts, LivestockCubitState state){
    return Expanded(
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CarouselSlider(
                items: List.generate(state.responseLivestockDetail!.data!.liveStockDocumentFiles!.length, (index) =>
                    ClipRRect(
                        borderRadius: BorderRadius.circular(10),
                        child: CachedNetworkImage(imageUrl: state.responseLivestockDetail!.data!.liveStockDocumentFiles![index].originalUrl ?? '', width: screenWidth(), fit: BoxFit.cover,
                            errorWidget: (_, __, ___) =>
                                Image.asset(Images.sampleVideo,width: screenWidth(),)
                        ))),
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
                              decoration: state.responseLivestockDetail!.data!.negotiatedPrice != null ? TextDecoration.lineThrough:null
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
                      state.responseLivestockDetail!.data!.negotiatedPrice != null ?
                      Text(getCurrencyString(double.parse(state.responseLivestockDetail!.data!.negotiatedPrice!.negotiatedPrice.toString())),
                          style: figtreeSemiBold.copyWith(
                            fontSize: 22, color: ColorResources.black,
                            // decoration: TextDecoration.lineThrough
                          )):const SizedBox.shrink():const SizedBox.shrink()
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

                      if(state.responseLivestockDetail!.data!.user!=null)
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
                          if(BlocProvider.of<AuthCubit>(context).sharedPreferences.getString(AppConstants.userType) == "dde"){
                            modalBottomSheetMenu(context,
                                radius: 40,
                                child: SizedBox(
                                    height: screenHeight()-220,
                                    child: AddMarkAsDeliveryRemove(projectData: state.responseLivestockDetail!.data!.user!,id:int.parse(widget.id),updateSoldQtyTag: 'removeLiveStock',)));
                          }else{
                            BlocProvider.of<LivestockCubit>(context).removeLivestockAPi(context, int.parse(widget.id));
                          }},
                            width: screenWidth(),
                            height: 60,
                            color: 0xffDCDCDC),
                      ],
                    )
                  else
                 if(BlocProvider.of<LivestockCubit>(context).sharedPreferences.getString(AppConstants.userType) == "dde")
                   Column(
                     children: [

                       if(state.selectedLivestockFarmerMAster!=null)
                         Column(
                           crossAxisAlignment: CrossAxisAlignment.start,
                           children: [
                             "Buyer".textMedium(
                                 fontSize: 14,
                                 color: const Color(0xff727272)
                             ),
                             Padding(
                               padding: const EdgeInsets.only(
                                   left: 0, right: 0, bottom: 0,top: 10),
                               child: Container(
                                 decoration: boxDecoration(
                                     borderRadius: 10,
                                     backgroundColor: const Color(0xffFBF9F9)
                                 ),
                                 child: Padding(
                                   padding:
                                   const EdgeInsets.fromLTRB(15.0, 10, 0, 5),
                                   child: Stack(
                                     children: [
                                       Row(
                                         crossAxisAlignment:
                                         CrossAxisAlignment.start,
                                         children: [
                                           state.selectedLivestockFarmerMAster!.photo == null ?Image.asset(Images.sampleUser):
                                           networkImage(text: state.selectedLivestockFarmerMAster!.photo!,height: 46,width: 46,radius: 40),
                                           15.horizontalSpace(),
                                           Column(
                                             crossAxisAlignment:
                                             CrossAxisAlignment.start,
                                             children: [
                                               Text(state.selectedLivestockFarmerMAster!.name!,
                                                   style: figtreeMedium.copyWith(
                                                       fontSize: 16,
                                                       color: Colors.black)),
                                               4.verticalSpace(),
                                               Row(
                                                 children: [
                                                   Text(
                                                       "${countryCode == ""? "":countryCode!=null?countryCode.toString():""} ${state.selectedLivestockFarmerMAster!.phone.toString()}",
                                                       style:
                                                       figtreeRegular.copyWith(
                                                           fontSize: 12,
                                                           color: Colors.black)),

                                                 ],
                                               ),
                                               4.verticalSpace(),
                                               Row(
                                                 crossAxisAlignment:
                                                 CrossAxisAlignment.end,
                                                 children: [
                                                   SizedBox(
                                                     width: MediaQuery.of(context)
                                                         .size
                                                         .width *
                                                         0.5,
                                                     child: Text(
                                                       state.selectedLivestockFarmerMAster!.address!=null?
                                                       state.selectedLivestockFarmerMAster!.address!.address!=null?state.selectedLivestockFarmerMAster!.address!.address!:"":"",
                                                       style:
                                                       figtreeRegular.copyWith(
                                                         fontSize: 12,
                                                         color: Colors.black,
                                                         overflow:
                                                         TextOverflow.ellipsis,
                                                       ),
                                                     ),
                                                   ),
                                                 ],
                                               )
                                             ],
                                           )
                                         ],
                                       ),
                                       Align(
                                         alignment: Alignment.topRight,
                                         child: Padding(
                                           padding: const EdgeInsets.only(right: 14.0),
                                           child: InkWell(
                                               onTap: (){
                                                 modalBottomSheetMenu(context,
                                                     radius: 40,
                                                     child: SizedBox(
                                                         height: screenHeight()-220,
                                                         child: selectFarmer(livestockId: widget.id.toString())));
                                               }, child: SvgPicture.asset(Images.edit,width: 20,height: 20,)),
                                         ),
                                       )
                                     ],
                                   ),
                                 ),
                               ),
                             ),

                             20.verticalSpace(),

                             Row(
                               children: [
                                 Expanded(
                                   child: customButton('',
                                       style: figtreeMedium.copyWith(fontSize: 16),
                                       onTap:  BlocProvider
                                           .of<LandingPageCubit>(context)
                                           .sharedPreferences
                                           .containsKey(AppConstants.userType) ? () async {
                                         if (BlocProvider.of<ProfileCubit>(context).state.responseProfile == null) {
                                           await BlocProvider.of<ProfileCubit>(context).profileApi(context);
                                         }
                                         final query = FirebaseFirestore.instance.collection('livestock_enquiry').doc(widget.id);
                                         query.set({
                                           'user_id': state.responseLivestockDetail!.data!.userId.toString(),
                                           'livestock_id': widget.id.toString(),
                                           'advertisement_number': state.responseLivestockDetail!.data!.advertisementNo.toString(),
                                           'cow_breed': state.responseLivestockDetail!.data!.cowBreed!.name.toString(),
                                           'created_at': Timestamp.now(),
                                         });
                                         query.collection('enquiries').doc(state.selectedLivestockFarmerMAster!.userId.toString()).
                                         set({
                                           'user_id': state.selectedLivestockFarmerMAster!.userId.toString(),
                                           'user_name': state.selectedLivestockFarmerMAster!.name ?? '',
                                           'user_address': state.selectedLivestockFarmerMAster!.address != null ? state.selectedLivestockFarmerMAster!.address!.address ?? '' : '',
                                           'user_photo': state.selectedLivestockFarmerMAster!.photo ?? '',
                                           'dde_id': context.read<LivestockCubit>().sharedPreferences.getString(AppConstants.userId)!,
                                           'dde_name': BlocProvider.of<ProfileCubit>(context).state.responseProfile!.data!.user!.name,
                                           'created_at': Timestamp.now(),
                                         }, SetOptions(merge: true));
                                         LivestockEnquiryChatScreen(
                                           livestockId: widget.id.toString(),
                                           cowBreed: state.responseLivestockDetail!.data!.cowBreed!.name.toString(),
                                           advertisementNumber: state.responseLivestockDetail!.data!.advertisementNo.toString(),
                                           userName: '${BlocProvider.of<ProfileCubit>(context).state.responseProfile!.data!.user!.name ?? ''} (DDE)',
                                           userId: state.selectedLivestockFarmerMAster!.userId.toString(),
                                           ddeId: context.read<LivestockCubit>().sharedPreferences.getString(AppConstants.userId)!,
                                           livestockUserId: state.responseLivestockDetail!.data!.userId.toString(),
                                         ).navigate();
                                       } : () {
                                         const RegisterPopUp().navigate();
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
                                       onTap: () {
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

                                                                         context.read<LivestockCubit>().livestockAddToCartApi(context, state.responseLivestockDetail!.data!.id.toString(), quantity,state.responseLivestockDetail!.data!.negotiatedPrice!=null?state.responseLivestockDetail!.data!.negotiatedPrice!.negotiatedPrice.toString():state.responseLivestockDetail!.data!.price.toString(),
                                                                         userId: state.selectedLivestockFarmerMAster!.userId.toString());

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
                                           const LiveStockCartListScreen().navigate();
                                         }
                                       } ,
                                       width: screenWidth(),
                                       fontColor: 0xffFFFFFF,
                                       height: 60),
                                 )
                               ],
                             )

                           ],
                         ),

                       if(state.selectedLivestockFarmerMAster==null)
                         customButton('Select Farmer',
                             style: figtreeMedium.copyWith(fontSize: 16, color: const Color(0xffFFFFFF)),
                             onTap: (){
                               modalBottomSheetMenu(context,
                                   radius: 40,
                                   child: SizedBox(
                                       height: screenHeight()-220,
                                       child: selectFarmer(livestockId: widget.id)));
                             },
                             width: screenWidth(),
                             fontColor: 0xffFFFFFF,
                             height: 60),



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
                                    'created_at': Timestamp.now(),
                                  }, SetOptions(merge: true));
                              LivestockEnquiryChatScreen(
                                livestockId: widget.id.toString(),
                                cowBreed: state.responseLivestockDetail!.data!.cowBreed!.name.toString(),
                                advertisementNumber: state.responseLivestockDetail!.data!.advertisementNo.toString(), userName: BlocProvider.of<ProfileCubit>(context).state.responseFarmerProfile!.farmer!.name ?? '',
                                userId: context.read<LivestockCubit>().sharedPreferences.getString(AppConstants.userId)!,
                                livestockUserId: state.responseLivestockDetail!.data!.userId.toString(),
                              ).navigate();
                            } : () {
                              RegisterPopUp().navigate();
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

                                                              context.read<LivestockCubit>().livestockAddToCartApi(context, state.responseLivestockDetail!.data!.id.toString(), quantity,state.responseLivestockDetail!.data!.negotiatedPrice!=null?state.responseLivestockDetail!.data!.negotiatedPrice!.negotiatedPrice.toString():state.responseLivestockDetail!.data!.price.toString());

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
                                const LiveStockCartListScreen().navigate();
                              }
                            } : () {
                          const RegisterPopUp().navigate();
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

  final MediaQueryData mediaData = MediaQuery.of(context);

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
    kpiData.add(FrontendKpiModel(name: 'Sold',
        image: Images.investmentKpi,
        value: state.responseLivestockDetail!.data!.loanAccepted!.toString()));
  }

  if(state.responseLivestockDetail!.data!.loanApproved!=null){
    kpiData.add(FrontendKpiModel(name: 'In process',
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
        return MediaQuery(
          data: screenWidth()<380 ? mediaData.copyWith(textScaleFactor: 0.91):mediaData.copyWith(textScaleFactor: 1),

          child: InkWell(
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
                                                                if(quantity>0){
                                                                  if(quantity == 1) {
                                                                    return;
                                                                  }
                                                                  quantity--;
                                                                  setState(() {

                                                                  });
                                                                }
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
                                                              if(BlocProvider.of<AuthCubit>(context).sharedPreferences.getString(AppConstants.userType) == "dde"){
                                                                modalBottomSheetMenu(context, child: AddMarkAsDeliveryRemove(
                                                                    projectData: state.responseLivestockDetail!.data!.user!,
                                                                    id: state.responseLivestockDetail!.data!.user!.id,quantity:quantity.toString(),updateSoldQtyTag:"sold"));
                                                              }else{
                                                                BlocProvider.of<LivestockCubit>(context).updateSoldCowApi(context, state.responseLivestockDetail!.data!.id!, quantity);
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
                            ))
                            :const SizedBox.shrink()
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
          ),
        );
      });
}