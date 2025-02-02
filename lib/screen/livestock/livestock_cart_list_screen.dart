import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:glad/cubit/auth_cubit/auth_cubit.dart';
import 'package:glad/cubit/dashboard_cubit/dashboard_cubit.dart';
import 'package:glad/cubit/landing_page_cubit/landing_page_cubit.dart';
import 'package:glad/cubit/livestock_cubit/livestock_cubit.dart';
import 'package:glad/cubit/profile_cubit/profile_cubit.dart';
import 'package:glad/data/model/livestock_detail.dart';
import 'package:glad/screen/dde_screen/dashboard/dashboard_dde.dart';
import 'package:glad/screen/livestock/add_livestock.dart';
import 'package:glad/screen/livestock/livestock_detail.dart';
import 'package:glad/screen/livestock/livestock_kyc.dart';
import 'package:glad/screen/custom_widget/custom_appbar.dart';
import 'package:glad/screen/custom_widget/custom_methods.dart';
import 'package:glad/screen/dde_screen/project_kyc/kyc_update.dart';
import 'package:glad/screen/farmer_screen/dashboard/dashboard_farmer.dart';
import 'package:glad/screen/guest_user/dashboard/dashboard_guest.dart';
import 'package:glad/utils/app_constants.dart';
import 'package:glad/utils/color_resources.dart';
import 'package:glad/utils/extension.dart';
import 'package:glad/utils/images.dart';
import 'package:glad/utils/styles.dart';

import '../../data/model/livestock_cart_list.dart';

class LiveStockCartListScreen extends StatefulWidget {
  const LiveStockCartListScreen({super.key, this.userId,this.navigates});
  final String? navigates;
  final String? userId;

  @override
  State<LiveStockCartListScreen> createState() => _LiveStockCartListScreenState();
}

class _LiveStockCartListScreenState extends State<LiveStockCartListScreen> {
  TextEditingController farmer = TextEditingController();
  TextEditingController loan = TextEditingController();

  double subtotal = 0;
  double? participationPercentage;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      apiCall();
    });
  }

  apiCall() async {
    BlocProvider.of<LivestockCubit>(context).livestockCartListApi(context,userId: widget.userId);
    if(BlocProvider.of<AuthCubit>(context).sharedPreferences.getString(AppConstants.userType) == "farmer"){
      if(BlocProvider.of<ProfileCubit>(context).state.responseFarmerProfile==null){
        BlocProvider.of<ProfileCubit>(context).getFarmerProfile(context);
      }
    }
    // loan.text = (int.parse(BlocProvider.of<LivestockCubit>(context).state.responseLivestockCartList!.data![0].cowQty.toString()) * double.parse(BlocProvider.of<LivestockCubit>(context).state.responseLivestockCartList!.data![0].cowPrice.toString()).toInt()).toString();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async{
        if(widget.navigates!=null){
          if(BlocProvider.of<LivestockCubit>(context).sharedPreferences.getString(AppConstants.userType) == "dde"){
            const DashboardDDE().navigate();
          }else{
            const DashboardFarmer().navigate();
            BlocProvider.of<DashboardCubit>(context).selectedIndex(3);
          }
        }else{
          pressBack();
        }
        return true;
      },
      child: Scaffold(
        body: BlocBuilder<LivestockCubit, LivestockCubitState>(
            builder: (context, state) {
              if (state.status == LivestockStatus.submit) {
                return const Center(
                    child: CircularProgressIndicator(
                      color: ColorResources.maroon,
                    ));
              } else if (state.responseLivestockCartList == null) {
                return Center(child: Text("${state.responseLivestockCartList} Api Error"));
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
                            titleText1: 'Cart',
                            centerTitle: true,
                            leading: InkWell(
                              onTap: (){
                                if(widget.navigates!=null){
                                  if(BlocProvider.of<LivestockCubit>(context).sharedPreferences.getString(AppConstants.userType) == "dde"){
                                    const DashboardDDE().navigate();
                                  }else{
                                    const DashboardFarmer().navigate();
                                    BlocProvider.of<DashboardCubit>(context).selectedIndex(3);
                                  }
                                }else{
                                  pressBack();
                                }
                              },
                              child: SvgPicture.asset(
                                Images.arrowBack,
                                // colorFilter: const ColorFilter.mode(Colors.white, BlendMode.srcIn),
                              ),
                            ),
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
      ),
    );
  }

  Widget landingPage(BuildContext contexts, LivestockCubitState state){
    return state.responseLivestockCartList!.data != null ? Expanded(
      child: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 24),
          child: Column(
            children: [
              customList(
                  list: state.responseLivestockCartList!.data![0].liveStockCartDetails!,
                  child: (index){
                return Padding(
                  padding: const EdgeInsets.only(bottom: 10),
                  child: Stack(
                    alignment: Alignment.center,
                    children: [
                      SizedBox(
                          height: 180,
                          width: screenWidth() * 0.9,),
                      SizedBox(
                        height: 160,
                        width: screenWidth() * 0.9,
                        child: InkWell(
                          onTap: () {
                            LiveStockDetail(id: state.responseLivestockCartList!.data![0].liveStockCartDetails![index].liveStock!.id.toString(), isMyLivestock: false,type: 'buyer',).navigate();
                          },
                          child: customShadowContainer(
                            margin: 0,
                            backColor: Colors.grey.withOpacity(0.4),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Expanded(
                                  child: Row(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Container(
                                          padding: const EdgeInsets.all(10),
                                          width: screenWidth() * 0.34,
                                          height: 160,
                                          child: ClipRRect(borderRadius: BorderRadius.circular(10),child: CachedNetworkImage(imageUrl: state.responseLivestockCartList!.data![0].liveStockCartDetails![index].liveStock!.liveStockDocumentFiles!.isNotEmpty ? state.responseLivestockCartList!.data![0].liveStockCartDetails![index].liveStock!.liveStockDocumentFiles![0].originalUrl ?? '' : '',fit: BoxFit.cover,))),
                                      Expanded(
                                        child: Padding(
                                          padding: const EdgeInsets.only(bottom: 12, top: 12),
                                          child: Column(
                                            crossAxisAlignment: CrossAxisAlignment.start,
                                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                            children: [
                                              RichText(
                                                  text: TextSpan(children: [
                                                    TextSpan(
                                                        text: '${state.responseLivestockCartList!.data![0].liveStockCartDetails![index].liveStock!.cowBreed!.name != null ? state.responseLivestockCartList!.data![0].liveStockCartDetails![index].liveStock!.cowBreed!.name ?? '' : ''} cow ',
                                                        style: figtreeMedium.copyWith(
                                                            fontSize: 12, color: Colors.black)),
                                                    TextSpan(
                                                        text: '(${state.responseLivestockCartList!.data![0].liveStockCartDetails![index].liveStock!.advertisementNo ?? ''})',
                                                        style: figtreeMedium.copyWith(
                                                            fontSize: 12, color: const Color(0xFF727272)))
                                                  ])),
                                              // 3.verticalSpace(),
                                              Column(
                                                crossAxisAlignment: CrossAxisAlignment.start,
                                                mainAxisAlignment: MainAxisAlignment.start,
                                                children: [
                                                Text(getCurrencyString(double.parse(state.responseLivestockCartList!.data![0].liveStockCartDetails![index].liveStock!.price.toString())),
                                                    style: figtreeSemiBold.copyWith(
                                                        fontSize: 18, color: ColorResources.maroon,
                                                        decoration: state.responseLivestockCartList!.data![0].liveStockCartDetails![index].liveStock!.liveStockNegotiation != null ? TextDecoration.lineThrough : null
                                                      // decoration: TextDecoration.lineThrough
                                                    )),
                                                state.responseLivestockCartList!.data![0].liveStockCartDetails![index].liveStock!.liveStockNegotiation != null ?
                                                Text(getCurrencyString(state.responseLivestockCartList!.data![0].liveStockCartDetails![index].liveStock!.liveStockNegotiation!.negotiatedPrice),
                                                    style: figtreeSemiBold.copyWith(
                                                        fontSize: 18, color: Colors.black)) : SizedBox.shrink(),
                                              ],),
                                              // 6.verticalSpace(),
                                              Wrap(
                                                spacing: 5,
                                                children: [
                                                  RichText(
                                                      text: TextSpan(children: [
                                                        TextSpan(
                                                            text: 'Age: ',
                                                            style: figtreeMedium.copyWith(
                                                                fontSize: 12, color: const Color(0xFF727272))),
                                                        TextSpan(
                                                            text: '${state.responseLivestockCartList!.data![0].liveStockCartDetails![index].liveStock!.age ?? ''} yrs',
                                                            style: figtreeMedium.copyWith(
                                                                fontSize: 12, color: Colors.black)),
                                                      ])),
                                                  RichText(
                                                      text: TextSpan(children: [
                                                        TextSpan(
                                                            text: 'Milk: ',
                                                            style: figtreeMedium.copyWith(
                                                                fontSize: 12, color: const Color(0xFF727272))),
                                                        TextSpan(
                                                            text: '${double.parse(state.responseLivestockCartList!.data![0].liveStockCartDetails![index].liveStock!.yield ?? '').toInt()}L/day',
                                                            style: figtreeMedium.copyWith(
                                                                fontSize: 12, color: Colors.black))
                                                      ])),
                                                ],
                                              ),
                                              // 12.verticalSpace(),
                                              Text(state.responseLivestockCartList!.data![0].liveStockCartDetails![index].liveStock!.user!.name??'',
                                                  style: figtreeMedium.copyWith(
                                                      fontSize: 12, color: Colors.black), maxLines: 1),
                                              // 6.verticalSpace(),
                                              Text(state.responseLivestockCartList!.data![0].liveStockCartDetails![index].liveStock!.user != null ? state.responseLivestockCartList!.data![0].liveStockCartDetails![index].liveStock!.user!.farmerMaster!.address != null
                                                  ? state.responseLivestockCartList!.data![0].liveStockCartDetails![index].liveStock!.user!.farmerMaster!.address!.address ?? ''
                                                  : '' : '',
                                                style: figtreeMedium.copyWith(
                                                    fontSize: 12, color: Colors.black), maxLines: 1),
                                            ],
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(10),
                                  child: Container(
                                    width: 50,
                                    decoration: BoxDecoration(
                                        border: Border.all(color: const Color(0xffD9D9D9,),width: 1.5),
                                        borderRadius: BorderRadius.circular(40),
                                        color: Colors.white
                                    ),
                                    height: screenHeight(),
                                    padding: const EdgeInsets.symmetric(vertical: 10),
                                    child: Column(
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      children: [
                                        InkWell(
                                            onTap: () {
                                              if(int.parse(state.responseLivestockCartList!.data![0].liveStockCartDetails![index].cowQty.toString()) == int.parse(state.responseLivestockCartList!.data![0].liveStockCartDetails![index].cowQty.toString()) &&
                                                  int.parse(state.responseLivestockCartList!.data![0].liveStockCartDetails![index].cowQty.toString()) == int.parse(state.responseLivestockCartList!.data![0].liveStockCartDetails![index].liveStock!.cowQty.toString()) - int.parse(state.responseLivestockCartList!.data![0].liveStockCartDetails![index].liveStock!.soldQty.toString())) {
                                                showCustomToast(context, "Available quantity is not available");
                                              } else {
                                                context.read<LivestockCubit>()
                                                    .livestockUpdateCartApi(context,
                                                    state.responseLivestockCartList!
                                                        .data![0].liveStockCartDetails![index].id!, int.parse(
                                                        state
                                                            .responseLivestockCartList!
                                                            .data![0].liveStockCartDetails![index].cowQty
                                                            .toString()) + 1,userId: state.responseLivestockCartList!.data![0].userId.toString());
                                              }
                                            },
                                            child: SvgPicture.asset(Images.addQuant, height: 25, width: 25,)),
                                        state.responseLivestockCartList!.data![0].liveStockCartDetails![index].cowQty.toString().textSemiBold(fontSize: 16, color: Colors.black),
                                        InkWell(
                                            onTap: () {
                                              if(int.parse(state.responseLivestockCartList!.data![0].liveStockCartDetails![index].cowQty.toString()) != 1) {
                                                context.read<LivestockCubit>()
                                                    .livestockUpdateCartApi(context,
                                                    state.responseLivestockCartList!
                                                        .data![0].liveStockCartDetails![index].id!, int.parse(
                                                        state
                                                            .responseLivestockCartList!
                                                            .data![0].liveStockCartDetails![index].cowQty
                                                            .toString()) - 1,
                                                    userId: state.responseLivestockCartList!.data![0].userId.toString());
                                              } else {
                                                print('cannot delete');
                                              }
                                            },
                                            child: SvgPicture.asset(Images.minusQuant, height: 25, width: 25,)),

                                      ],),
                                  ),
                                ),

                              ],
                            ),
                          ),
                        ),
                      ),
                      Positioned(
                        top: 0, right: screenWidth() * 0.02,
                        child: InkWell(
                            onTap: () {
                              context.read<LivestockCubit>()
                                  .livestockCartItemRemoveApi(context,
                                  state.responseLivestockCartList!
                                      .data![0].liveStockCartDetails![index].id!,
                                  userId: state.responseLivestockCartList!.data![0].userId.toString());
                            },
                            child: SvgPicture.asset(Images.removeCart)),
                      ),
                    ],
                  ),
                );
              }),

              // 5.verticalSpace(),

              customButton('Add More Livestock',color: 0xffffffff, borderColor: 0xffFC5E60,onTap: (){
                if(widget.navigates!=null){
                  if(BlocProvider.of<LivestockCubit>(context).sharedPreferences.getString(AppConstants.userType) == "dde"){
                    const DashboardDDE().navigate();
                  }else{
                    const DashboardFarmer().navigate();
                    BlocProvider.of<DashboardCubit>(context).selectedIndex(3);
                  }
                }else{
                  pressBack();
                }
              },width: screenWidth()*0.6),

              // 10.verticalSpace(),

              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20.0,vertical: 50),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        'Subtotal: '.textMedium(color: Colors.black, fontSize: 16),


                          Builder(
                            builder: (context) {
                              double count = 0;
                              for(LiveStockCartDetails cart in state.responseLivestockCartList!.data![0].liveStockCartDetails!){
                                if (cart.liveStock!.liveStockNegotiation == null) {
                                  count +=
                                  (double.parse(cart.cowQty.toString()) *
                                      (double.parse(cart.cowPrice.toString())));
                                } else {
                                  count +=
                                  (double.parse(cart.cowQty.toString()) *
                                      (double.parse(cart.liveStock!.liveStockNegotiation!.negotiatedPrice.toString())));
                                }
                              }
                              subtotal = count;
                              return Text(getCurrencyString(count),
                                  style: figtreeSemiBold.copyWith(
                                      fontSize: 18, color: Colors.black));
                            }
                          ),
                      ],
                    ),

                    30.verticalSpace(),



                    customButton(width: screenWidth()*0.6,'Submit Application', fontColor: 0xffffffff,onTap: (){
                      TextEditingController controller = TextEditingController();

                      participationPercentage = (subtotal*state.responseLivestockCartList!.data![0].farmerParticipationPercent)/100;
                      controller.text = currencyFormatter().format(participationPercentage!.toStringAsFixed(0));
                      modalBottomSheetMenu(context,
                          radius: 40,
                          child: StatefulBuilder(
                              builder: (contexts, setState) {
                                return SizedBox(
                                  height: 320,
                                  child: Padding(
                                    padding: const EdgeInsets.fromLTRB(23, 40, 25, 10),
                                    child: Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          Center(
                                            child: Text(
                                              'Buyer Participation',
                                              style: figtreeMedium.copyWith(fontSize: 22),
                                            ),
                                          ),
                                          30.verticalSpace(),

                                          Column(
                                            crossAxisAlignment: CrossAxisAlignment.start,
                                            children: [
                                              TextField(
                                                controller: controller,
                                                maxLines: 1,
                                                keyboardType: TextInputType.number,
                                                inputFormatters: [
                                                  currencyFormatter()
                                                ],
                                                minLines: 1,
                                                onChanged: (value){
                                                  // if()
                                                  if(double.parse(controller.text.replaceAll(",", "").toString())>subtotal){
                                                    showCustomToast(context, "Buyer participation can't be more than cart total");
                                                  }else if(double.parse(controller.text.replaceAll(",", ""))<participationPercentage!){
                                                    showCustomToast(context, "Buyer participation can't be less than ${state.responseLivestockCartList!.data![0].farmerParticipationPercent}% of subtotal");
                                                  }
                                                },
                                                decoration: InputDecoration(
                                                    hintText: 'Enter participation value',
                                                    hintStyle:
                                                    figtreeMedium.copyWith(fontSize: 18),
                                                    border: OutlineInputBorder(
                                                        borderRadius: BorderRadius.circular(12),
                                                        borderSide: const BorderSide(
                                                          width: 1,
                                                          color: Color(0xff999999),
                                                        ))),
                                              ),
                                              30.verticalSpace(),
                                              Padding(
                                                padding: const EdgeInsets.fromLTRB(28, 0, 29, 0),
                                                child: customButton(
                                                  'Submit Application',
                                                  fontColor: 0xffFFFFFF,
                                                  onTap: () {
                                                    if(controller.text.isEmpty){}else if(double.parse(controller.text.replaceAll(",", ""))>subtotal){
                                                      showCustomToast(context, "Buyer participation can't be more than cart total");
                                                    }else if(double.parse(controller.text.replaceAll(",", ""))<participationPercentage!){
                                                      showCustomToast(context, "Buyer participation can't be less than ${state.responseLivestockCartList!.data![0].farmerParticipationPercent}% of subtotal");
                                                    }else{

                                                      if(BlocProvider.of<AuthCubit>(context).sharedPreferences.getString(AppConstants.userType) == "farmer"){
                                                        if(BlocProvider.of<ProfileCubit>(context).state.responseFarmerProfile!.farmer!.kycStatus.toString() == "verified"){
                                                          LivestockKyc(id:state.responseLivestockCartList!.data![0].id!,farmerParticipation:controller.text.replaceAll(",", ""),
                                                              farmerMaster: state.responseLivestockCartList!.data![0].liveStockCartDetails![0].liveStock!.user!.farmerMaster!
                                                          ).navigate();
                                                        }else{
                                                          showCustomToast(context, "Your kyc is not verified");
                                                        }
                                                      }else{
                                                        if(state.selectedLivestockFarmerMAster!.kycStatus.toString() == "verified"){
                                                          LivestockKyc(id:state.responseLivestockCartList!.data![0].id!,farmerParticipation:controller.text.replaceAll(",", ""),
                                                            farmerMaster: state.responseLivestockCartList!.data![0].liveStockCartDetails![0].liveStock!.user!.farmerMaster!
                                                        ).navigate();
                                                        }else{
                                                          showCustomToast(context, "Farmer kyc is not verified");
                                                        }
                                                      }
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
                    })

                  ],
                ),
              ),

              20.verticalSpace(),
            ],
          ),
        ),
      ),
    ) : Padding(
      padding: EdgeInsets.only(top: screenWidth() / 2),
      child: const Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text('Cart is Empty'),
        ],
      ),
    );
  }
}
