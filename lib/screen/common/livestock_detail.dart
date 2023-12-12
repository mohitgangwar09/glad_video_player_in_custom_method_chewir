import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:glad/cubit/livestock_cubit/livestock_cubit.dart';
import 'package:glad/screen/common/update_livestock.dart';
import 'package:glad/screen/custom_widget/custom_appbar.dart';
import 'package:glad/screen/custom_widget/custom_methods.dart';
import 'package:glad/utils/color_resources.dart';
import 'package:glad/utils/extension.dart';
import 'package:glad/utils/images.dart';
import 'package:glad/utils/styles.dart';
import 'package:intl/intl.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class LiveStockDetail extends StatefulWidget {
  const LiveStockDetail({Key? key, required this.isMyLivestock, required this.id}) : super(key: key);
  final bool isMyLivestock;
  final String id;

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
                          action: widget.isMyLivestock ? TextButton(
                            onPressed: () {
                              UpdateLivestock(detail: state.responseLivestockDetail!).navigate();
                              // context.read<ProfileCubit>().updateDdeFarmDetailApi(context,);
                            },
                            child: Text(
                              'Edit',
                              style: figtreeMedium.copyWith(
                                  fontSize: 14, color: ColorResources.maroon),
                            ),
                          ) : null,
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
                      Text(getCurrencyString(double.parse(state.responseLivestockDetail!.data!.price.toString())),
                          style: figtreeSemiBold.copyWith(
                              fontSize: 20, color: Colors.black)),
                    ],
                  ),
                  10.verticalSpace(),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                    SizedBox(
                      width: screenWidth() * 0.35,
                      child: Text(state.responseLivestockDetail!.data!.user!.address != null
                          ? state.responseLivestockDetail!.data!.user!.address!.address != null
                          && state.responseLivestockDetail!.data!.user!.address!.subCounty != null
                          ? state.responseLivestockDetail!.data!.user!.address!.subCounty! +
                          state.responseLivestockDetail!.data!.user!.address!.address!
                          : ''
                          : '',
                        style: figtreeMedium.copyWith(
                            fontSize: 12, color: Colors.black), maxLines: 2),
                    ),
                    Container(
                      height: 5,
                      width: 5,
                      decoration: const BoxDecoration(
                          color: Colors.black, shape: BoxShape.circle),
                    ),
                    Text('Posted on ${DateFormat('dd MMMM, yyyy').format(DateTime.parse(state.responseLivestockDetail!.data!.createdAt ?? ''))}',
                        style: figtreeMedium.copyWith(fontSize: 12, color: const Color(0xFF727272)), maxLines: 2)
                  ],),
                  30.verticalSpace(),
                  Text(
                      'Specification ',
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
                            border: Border.all(color: Color(0xFFDCDCDC))
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
                              border: Border.all(color: Color(0xFFDCDCDC))
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
                                    text: state.responseLivestockDetail!.data!.cowQty ?? '',
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
                              border: Border.all(color: Color(0xFFDCDCDC))
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
                              border: Border.all(color: Color(0xFFDCDCDC))
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
                              border: Border.all(color: Color(0xFFC788A5)),
                            color: Color(0xFFFFF3F4)
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
                            fontSize: 14, color: const Color(0xFF727272)),
                          softWrap: true,
                        ),
                      ),
                    ],
                  ),
                  40.verticalSpace(),
                  if(widget.isMyLivestock)
                    Column(
                      children: [

                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 20),
                          child: customButton('Enquiries',
                              style: figtreeMedium.copyWith(fontSize: 16),
                              onTap: () {
                                pressBack();
                              },
                              borderColor: 0xFFFC5E60,
                              color: 0xffFFFFFF,
                              enableFirst: true,
                              enableLast: true,
                              height: 60,
                              width: screenWidth(),
                              lastWidget: Text('03', style: figtreeBold.copyWith(fontSize: 18),),
                              widget: SvgPicture.asset(Images.chat, color: ColorResources.maroon,)),
                        ),
                        20.verticalSpace(),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 20),
                          child: customButton('Remove',
                              style: figtreeMedium.copyWith(fontSize: 16),
                              onTap: () {
                                pressBack();
                              },
                              width: screenWidth(),
                              height: 60,
                              color: 0xffDCDCDC),
                        ),
                      ],
                    )
                  else
                  Row(
                    children: [
                      customButton('',
                          style: figtreeMedium.copyWith(fontSize: 16),
                          onTap: () {},
                          width: screenWidth() * 0.2,
                          fontColor: 0xffFFFFFF,
                          color: 0xffFFFFFF,
                          borderColor: 0xFFFC5E60,
                          height: 60,
                          enableFirst: true,
                          widget: SvgPicture.asset(Images.chat, color: ColorResources.maroon,)),
                      6.horizontalSpace(),
                      Expanded(
                        child: customButton('Add to cart',
                            style: figtreeMedium.copyWith(fontSize: 16, color: Color(0xffFFFFFF)),
                            onTap: () {
                              context.read<LivestockCubit>().livestockAddToCartApi(context, state.responseLivestockDetail!.data!.id.toString(), );
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
