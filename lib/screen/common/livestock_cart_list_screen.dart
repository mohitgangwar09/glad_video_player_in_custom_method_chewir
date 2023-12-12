import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:glad/cubit/landing_page_cubit/landing_page_cubit.dart';
import 'package:glad/cubit/livestock_cubit/livestock_cubit.dart';
import 'package:glad/data/model/livestock_detail.dart';
import 'package:glad/screen/common/add_livestock.dart';
import 'package:glad/screen/common/livestock_detail.dart';
import 'package:glad/screen/custom_widget/custom_appbar.dart';
import 'package:glad/screen/custom_widget/custom_methods.dart';
import 'package:glad/screen/farmer_screen/dashboard/dashboard_farmer.dart';
import 'package:glad/screen/guest_user/dashboard/dashboard_guest.dart';
import 'package:glad/utils/app_constants.dart';
import 'package:glad/utils/color_resources.dart';
import 'package:glad/utils/extension.dart';
import 'package:glad/utils/images.dart';
import 'package:glad/utils/styles.dart';

class LiveStockCartListScreen extends StatefulWidget {
  const LiveStockCartListScreen({Key? key}) : super(key: key);

  @override
  State<LiveStockCartListScreen> createState() => _LiveStockCartListScreenState();
}

class _LiveStockCartListScreenState extends State<LiveStockCartListScreen> {
  TextEditingController farmer = TextEditingController();
  TextEditingController loan = TextEditingController();

  @override
  void initState() {
    call();
    super.initState();
  }

  call() async {
    await BlocProvider.of<LivestockCubit>(context).livestockCartListApi(context);
    loan.text = (int.parse(BlocProvider.of<LivestockCubit>(context).state.responseLivestockCartList!.data![0].cowQty.toString()) * double.parse(BlocProvider.of<LivestockCubit>(context).state.responseLivestockCartList!.data![0].liveStock!.price.toString()).toInt()).toString();
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
                          leading: arrowBackButton(),
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
    return state.responseLivestockCartList!.data != null ? Expanded(
      child: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 24),
          child: Column(
            children: [
              customList(
                  list: state.responseLivestockCartList!.data ?? [],
                  child: (index){
                return Padding(
                  padding: const EdgeInsets.only(bottom: 10),
                  child: Stack(
                    alignment: Alignment.center,
                    children: [
                      SizedBox(
                          height: 160,
                          width: screenWidth() * 0.9,),
                      SizedBox(
                        height: 140,
                        width: screenWidth() * 0.9,
                        child: InkWell(
                          onTap: () {
                            LiveStockDetail(id: state.responseLivestockCartList!.data![index].livestockId.toString(), isMyLivestock: true,).navigate();
                          },
                          child: customShadowContainer(
                            margin: 0,
                            backColor: Colors.grey.withOpacity(0.4),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Row(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Container(
                                        padding: const EdgeInsets.all(10),
                                        width: screenWidth() * 0.35,
                                        height: 140,
                                        child: ClipRRect(borderRadius: BorderRadius.circular(10),child: CachedNetworkImage(imageUrl: state.responseLivestockCartList!.data![index].liveStock!.liveStockDocumentFiles!.isNotEmpty ? state.responseLivestockCartList!.data![index].liveStock!.liveStockDocumentFiles![0].originalUrl ?? '' : '',fit: BoxFit.cover,))),
                                    Padding(
                                      padding: const EdgeInsets.only(bottom: 12, top: 12),
                                      child: Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          RichText(
                                              text: TextSpan(children: [
                                                TextSpan(
                                                    text: '${state.responseLivestockCartList!.data![index].liveStock!.cowBreed != null ? state.responseLivestockCartList!.data![index].liveStock!.cowBreed!.name ?? '' : ''} cow ',
                                                    style: figtreeMedium.copyWith(
                                                        fontSize: 12, color: Colors.black)),
                                                TextSpan(
                                                    text: '(${state.responseLivestockCartList!.data![index].liveStock!.advertisementNo ?? ''})',
                                                    style: figtreeMedium.copyWith(
                                                        fontSize: 12, color: const Color(0xFF727272)))
                                              ])),
                                          3.verticalSpace(),
                                          Text(getCurrencyString(double.parse(state.responseLivestockCartList!.data![index].liveStock!.price.toString())),
                                              style: figtreeSemiBold.copyWith(
                                                  fontSize: 18, color: Colors.black)),
                                          12.verticalSpace(),
                                          Column(
                                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                            children: [
                                              RichText(
                                                  text: TextSpan(children: [
                                                    TextSpan(
                                                        text: 'Age: ',
                                                        style: figtreeMedium.copyWith(
                                                            fontSize: 12, color: const Color(0xFF727272))),
                                                    TextSpan(
                                                        text: '${state.responseLivestockCartList!.data![index].liveStock!.age ?? ''} yrs',
                                                        style: figtreeMedium.copyWith(
                                                            fontSize: 12, color: Colors.black)),
                                                  ])),
                                              5.verticalSpace(),
                                              // 10.horizontalSpace(),
                                              // Container(
                                              //   height: 5,
                                              //   width: 5,
                                              //   decoration: const BoxDecoration(
                                              //       color: Colors.black, shape: BoxShape.circle),
                                              // ),
                                              // 10.horizontalSpace(),
                                              RichText(
                                                  text: TextSpan(children: [
                                                    TextSpan(
                                                        text: 'Milk: ',
                                                        style: figtreeMedium.copyWith(
                                                            fontSize: 12, color: const Color(0xFF727272))),
                                                    TextSpan(
                                                        text: '${double.parse(state.responseLivestockCartList!.data![index].liveStock!.yield ?? '').toInt()}L/day',
                                                        style: figtreeMedium.copyWith(
                                                            fontSize: 12, color: Colors.black))
                                                  ])),
                                            ],
                                          ),
                                          6.verticalSpace(),
                                          Text(state.responseLivestockCartList!.data![index].liveStock!.user != null ? state.responseLivestockCartList!.data![index].liveStock!.user!.address != null
                                              ? state.responseLivestockCartList!.data![index].liveStock!.user!.address!.address ?? ''
                                              : '' : '',
                                            style: figtreeMedium.copyWith(
                                                fontSize: 12, color: Colors.black), maxLines: 1),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(10),
                                  child: Container(
                                    width: 55,
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
                                              if(int.parse(state.responseLivestockCartList!.data![index].cowQty.toString()) == int.parse(state.responseLivestockCartList!.data![index].liveStock!.cowQty.toString()) &&
                                                  int.parse(state.responseLivestockCartList!.data![index].cowQty.toString()) == int.parse(state.responseLivestockCartList!.data![index].liveStock!.cowQty.toString()) - int.parse(state.responseLivestockCartList!.data![index].liveStock!.soldQty.toString())) {
                                                print('cannot add');
                                              } else {
                                                context.read<LivestockCubit>()
                                                    .livestockUpdateCartApi(context,
                                                    state.responseLivestockCartList!
                                                        .data![index].id, int.parse(
                                                        state
                                                            .responseLivestockCartList!
                                                            .data![index].cowQty
                                                            .toString()) + 1);
                                              }
                                            },
                                            child: SvgPicture.asset(Images.addQuant, height: 25, width: 25,)),
                                        state.responseLivestockCartList!.data![index].cowQty.toString().textSemiBold(fontSize: 16, color: Colors.black),
                                        InkWell(
                                            onTap: () {
                                              if(int.parse(state.responseLivestockCartList!.data![index].cowQty.toString()) != 1) {
                                                context.read<LivestockCubit>()
                                                    .livestockUpdateCartApi(context,
                                                    state.responseLivestockCartList!
                                                        .data![index].id, int.parse(
                                                        state
                                                            .responseLivestockCartList!
                                                            .data![index].cowQty
                                                            .toString()) - 1);
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
                                      .data![index].id);
                            },
                            child: SvgPicture.asset(Images.removeCart)),
                      ),
                    ],
                  ),
                );
              }),
              40.verticalSpace(),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20.0),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        'Subtotal: '.textMedium(color: Colors.black, fontSize: 16),
                        getCurrencyString(int.parse(state.responseLivestockCartList!.data![0].cowQty.toString()) * double.parse(state.responseLivestockCartList!.data![0].liveStock!.price.toString()).toInt()).textSemiBold(color: Colors.black, fontSize: 20)
                      ],
                    ),
                    40.verticalSpace(),
                    Align(
                      alignment: Alignment.centerLeft,
                      child: "Farmer Participation (UGX)".textMedium(color: Colors.black, fontSize: 12),
                    ),

                    5.verticalSpace(),

                    Container(
                      height: 60,
                      decoration: BoxDecoration(
                          border: Border.all(color: const Color(0xffD9D9D9,),width: 1.5),
                          borderRadius: BorderRadius.circular(10),
                          color: Colors.white
                      ),
                      width: screenWidth(),
                      child: TextField(
                        maxLines: 1,
                        inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                        controller: farmer,
                        maxLength: 10,
                        // enabled: false,
                        onChanged: (val) {
                          if(int.parse(val) > int.parse(state.responseLivestockCartList!.data![0].cowQty.toString()) * double.parse(state.responseLivestockCartList!.data![0].liveStock!.price.toString())){
                            showCustomToast(context, 'Farmer Participation cannot be greater than sub total');
                            setState(() {
                              loan.text = '';
                            });
                          } else {
                            setState(() {
                              loan.text = (int.parse(
                                  state.responseLivestockCartList!.data![0]
                                      .cowQty.toString()) * double.parse(
                                  state.responseLivestockCartList!.data![0]
                                      .liveStock!.price.toString()).toInt() -
                                  int.parse(val)).toString();
                            });
                          }
                        },
                        keyboardType: TextInputType.number,
                        decoration: const InputDecoration(
                          border: InputBorder.none,
                          counterText: '',
                          contentPadding: EdgeInsets.only(top: 10,left: 13),
                        ),
                      ),
                    ),

                    20.verticalSpace(),
                    Align(
                      alignment: Alignment.centerLeft,
                      child: "Loan Amount (UGX)".textMedium(color: Colors.black, fontSize: 12),
                    ),

                    5.verticalSpace(),

                    Container(
                      height: 60,
                      decoration: BoxDecoration(
                          border: Border.all(color: const Color(0xffD9D9D9,),width: 1.5),
                          borderRadius: BorderRadius.circular(10),
                          color: Colors.white
                      ),
                      width: screenWidth(),
                      child: TextField(
                        maxLines: 1,
                        inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                        controller: loan,
                        maxLength: 10,
                        enabled: false,
                        keyboardType: TextInputType.number,
                        decoration: const InputDecoration(
                          border: InputBorder.none,
                          counterText: '',
                          contentPadding: EdgeInsets.only(top: 10,left: 13),
                        ),
                      ),
                    ),
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
