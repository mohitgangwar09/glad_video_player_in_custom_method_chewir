import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:glad/cubit/livestock_cubit/livestock_cubit.dart';
import 'package:glad/data/model/farmer_project_detail_model.dart';
import 'package:glad/data/model/frontend_kpi_model.dart';
import 'package:glad/data/model/livestock_cart_list.dart';
import 'package:glad/screen/custom_widget/container_border.dart';
import 'package:glad/screen/dde_screen/preview_screen.dart';
import 'package:glad/screen/livestock/livestock_cart_list_screen.dart';
import 'package:glad/screen/livestock/update_livestock.dart';
import 'package:glad/screen/custom_widget/custom_appbar.dart';
import 'package:glad/screen/custom_widget/custom_methods.dart';
import 'package:glad/utils/color_resources.dart';
import 'package:glad/utils/extension.dart';
import 'package:glad/utils/helper.dart';
import 'package:glad/utils/images.dart';
import 'package:glad/utils/styles.dart';
import 'package:intl/intl.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class LoanLivestockDetail extends StatefulWidget {
  const LoanLivestockDetail({Key? key, required this.isMyLivestock, required this.id,required this.cowQty,required this.status,required this.cartId,required this.farmerProjectId,required this.deliveryStatus,required this.mediaLivestock,required this.type}) : super(key: key);
  final bool isMyLivestock;
  final String id;
  final String cowQty,type;
  final String status,deliveryStatus;
  final int cartId,farmerProjectId;
  final List<MediaLivestock> mediaLivestock;

  @override
  State<LoanLivestockDetail> createState() => _LoanLivestockDetailState();
}

class _LoanLivestockDetailState extends State<LoanLivestockDetail> {

  int activeIndex = 0;
  List<String> docOneFile = [];

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
                            fontSize: 20, color: ColorResources.maroon,
                            // decoration: TextDecoration.lineThrough
                          )),
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
                      // Container(
                      //   height: 5,
                      //   width: 5,
                      //   decoration: const BoxDecoration(
                      //       color: Colors.black, shape: BoxShape.circle),
                      // ),
                      // Text('Posted on ${DateFormat('dd MMMM, yyyy').format(DateTime.parse(state.responseLivestockDetail!.data!.createdAt ?? ''))}',
                      //     style: figtreeMedium.copyWith(fontSize: 12, color: const Color(0xFF727272)), maxLines: 2)

                      //   Text(getCurrencyString(double.parse(state.responseLivestockDetail!.data!.price.toString())),
                      //       style: figtreeSemiBold.copyWith(
                      //           fontSize: 22, color: Colors.black)),
                    ],),
                  // 5.verticalSpace(),
                  Text('Posted on ${DateFormat('dd MMMM, yyyy').format(DateTime.parse(state.responseLivestockDetail!.data!.createdAt ?? ''))}',
                      style: figtreeMedium.copyWith(fontSize: 12, color: const Color(0xFF727272)), maxLines: 2),
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
                                    text: widget.cowQty.toString() ?? '',
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

                  widget.deliveryStatus == "completed" || widget.deliveryStatus == "approved"?
                  Builder(
                      builder: (context) {

                        if(widget.mediaLivestock.isEmpty) {
                          return const SizedBox.shrink();
                        }
                        return Padding(
                          padding: const EdgeInsets.fromLTRB(0, 0, 0, 0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [

                              Text(
                                'Uploaded pictures',
                                style: figtreeMedium.copyWith(fontSize: 18),
                              ),

                              0.verticalSpace(),
                              customGrid(context,
                                  mainAxisSpacing: 0,
                                  crossAxisSpacing: 10,
                                  childAspectRatio: 1.2,
                                  padding: const EdgeInsets.all(0),
                                  list: widget.mediaLivestock, child: (index) {
                                    return InkWell(
                                      onTap: () {
                                        PreviewScreen(previewImage: widget.mediaLivestock[index].originalUrl ?? '').navigate();
                                      },
                                      child: Stack(
                                        alignment: Alignment.center,
                                        children: [
                                          ClipRRect(
                                              borderRadius: BorderRadius.circular(14),
                                              child: CachedNetworkImage(imageUrl: widget.mediaLivestock[index].originalUrl ?? '', fit: BoxFit.fitWidth,width: screenWidth(),)),
                                          Positioned(
                                            bottom: 20,
                                            right: 10,
                                            child: Container(
                                                alignment: Alignment.center,
                                                height:35,
                                                width: 80,
                                                decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(170)),
                                                padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
                                                child: Text(DateFormat('dd MMM, yy').format(DateTime.parse(widget.mediaLivestock[index].createdAt!)), style: figtreeMedium.copyWith(fontSize: 12),)),
                                          )
                                        ],
                                      ),
                                    );
                                  }),
                              20.verticalSpace()
                            ],
                          ),
                        );
                      }
                  ):const SizedBox.shrink(),

                  widget.status == "active"?
                  widget.type == "seller"?
                  widget.deliveryStatus == "pending"?
                  Container(
                      margin: 0.marginAll(),
                      height: 55,
                      width: screenWidth(),
                      child: customButton("Mark as Delivered",
                          fontColor: 0xffffffff, onTap: () {

                            TextEditingController controller = TextEditingController();
                            modalBottomSheetMenu(context,
                                radius: 40,
                                child: StatefulBuilder(
                                    builder: (context, setState) {
                                      return SizedBox(
                                        height: docOneFile.isEmpty?450:540,
                                        child: Padding(
                                          padding: const EdgeInsets.fromLTRB(23, 20, 25, 10),
                                          child: Column(
                                              crossAxisAlignment: CrossAxisAlignment.start,
                                              children: [
                                                Center(
                                                  child: Text(
                                                    'Delivery Confirmation',
                                                    style: figtreeMedium.copyWith(fontSize: 22),
                                                  ),
                                                ),
                                                15.verticalSpace(),
                                                Column(
                                                  crossAxisAlignment: CrossAxisAlignment.start,
                                                  children: [


                                                    Stack(
                                                      children: [
                                                        ContainerBorder(
                                                          margin: 0.marginVertical(),
                                                          padding: 10.paddingOnly(top: 15, bottom: 15),
                                                          borderColor: 0xffD9D9D9,
                                                          backColor: 0xffFFFFFF,
                                                          radius: 10,
                                                          widget: Row(
                                                            mainAxisAlignment: MainAxisAlignment.center,
                                                            crossAxisAlignment: CrossAxisAlignment.center,
                                                            children: [
                                                              5.horizontalSpace(),
                                                              Expanded(
                                                                child: Padding(
                                                                  padding: const EdgeInsets.only(
                                                                      left: 10.0, top: 2, bottom: 2),
                                                                  child: Column(
                                                                    crossAxisAlignment:
                                                                    CrossAxisAlignment.start,
                                                                    children: [
                                                                      RichText(
                                                                          text: TextSpan(children: [
                                                                            TextSpan(
                                                                                text: 'Choose ',
                                                                                style: figtreeMedium.copyWith(
                                                                                    fontSize: 16,
                                                                                    color: const Color(
                                                                                        0xFFFC5E60))),
                                                                            TextSpan(
                                                                                text: 'you file here',
                                                                                style: figtreeMedium.copyWith(
                                                                                    fontSize: 16,
                                                                                    color: ColorResources
                                                                                        .fieldGrey))
                                                                          ])),
                                                                      Text('Max size 5 MB',
                                                                          style: figtreeMedium.copyWith(
                                                                              fontSize: 12,
                                                                              color:
                                                                              ColorResources.fieldGrey))
                                                                    ],
                                                                  ),
                                                                ),
                                                              ),
                                                            ],
                                                          ),
                                                        ),
                                                        Positioned(
                                                          right: 13,
                                                          top: 0,
                                                          bottom: 0,
                                                          child: Row(
                                                            children: [
                                                              InkWell(
                                                                onTap: () async{
                                                                  var image = await imgFromGallery();
                                                                  docOneFile.add(image);
                                                                  setState(() {});
                                                                },
                                                                child: SvgPicture.asset(
                                                                  Images.attachment,
                                                                  colorFilter: const ColorFilter.mode(
                                                                      ColorResources.fieldGrey,
                                                                      BlendMode.srcIn),
                                                                ),
                                                              ),
                                                              10.horizontalSpace(),
                                                              InkWell(
                                                                onTap: () async{
                                                                  var image = await imgFromCamera();
                                                                  docOneFile.add(image);
                                                                  setState(() {});
                                                                },
                                                                child: SvgPicture.asset(
                                                                  Images.camera,
                                                                  colorFilter: const ColorFilter.mode(
                                                                      ColorResources.fieldGrey,
                                                                      BlendMode.srcIn),
                                                                ),
                                                              )
                                                            ],
                                                          ),
                                                        ),
                                                      ],
                                                    ),

                                                    Padding(
                                                      padding: const EdgeInsets.symmetric(horizontal: 20.0),
                                                      child: Column(
                                                        children: [
                                                          20.verticalSpace(),
                                                          Row(
                                                            crossAxisAlignment: CrossAxisAlignment.start,
                                                            children: [
                                                              for (String image in docOneFile)
                                                                Row(
                                                                  children: [
                                                                    documentImage(image, () {
                                                                      setState(() {
                                                                        docOneFile.remove(image);
                                                                      });
                                                                    }),
                                                                    10.horizontalSpace(),
                                                                  ],
                                                                )
                                                            ],
                                                          ),
                                                        ],
                                                      ),
                                                    ),

                                                    20.verticalSpace(),

                                                    Text(
                                                      'Add remarks',
                                                      style: figtreeMedium.copyWith(fontSize: 12),
                                                    ),

                                                    4.verticalSpace(),

                                                    TextField(
                                                      controller: controller,
                                                      maxLines: 4,
                                                      minLines: 4,
                                                      decoration: InputDecoration(
                                                          hintText: 'Write...',
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
                                                        'Submit',
                                                        fontColor: 0xffFFFFFF,
                                                        onTap: () async{
                                                          BlocProvider.of<LivestockCubit>(context).livestockDeliveryStatusApi(context, widget.cartId, widget.farmerProjectId.toString(), controller.text, "completed", docOneFile);
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
                          })):const SizedBox.shrink():const SizedBox.shrink():const SizedBox.shrink(),


                  widget.type == "buyer"?
                  widget.deliveryStatus == "completed"||widget.deliveryStatus == "rejected"?
                  Column(
                    children: [

                      widget.deliveryStatus == "completed"?
                      Container(
                          margin: 0.marginAll(),
                          height: 55,
                          width: screenWidth(),
                          child: customButton("Confirm Delivery",
                              fontColor: 0xffffffff, onTap: () {

                                TextEditingController controller = TextEditingController();
                                modalBottomSheetMenu(context,
                                    radius: 40,
                                    child: StatefulBuilder(
                                        builder: (context, setState) {
                                          return SizedBox(
                                            height: 350,
                                            child: Padding(
                                              padding: const EdgeInsets.fromLTRB(23, 20, 25, 10),
                                              child: Column(
                                                  crossAxisAlignment: CrossAxisAlignment.start,
                                                  children: [
                                                    Center(
                                                      child: Text(
                                                        'Delivery Confirmation',
                                                        style: figtreeMedium.copyWith(fontSize: 22),
                                                      ),
                                                    ),
                                                    15.verticalSpace(),
                                                    Column(
                                                      crossAxisAlignment: CrossAxisAlignment.start,
                                                      children: [


                                                        Text(
                                                          'Add remarks',
                                                          style: figtreeMedium.copyWith(fontSize: 12),
                                                        ),

                                                        4.verticalSpace(),

                                                        TextField(
                                                          controller: controller,
                                                          maxLines: 4,
                                                          minLines: 4,
                                                          decoration: InputDecoration(
                                                              hintText: 'Write...',
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
                                                            'Submit',
                                                            fontColor: 0xffFFFFFF,
                                                            onTap: () async{
                                                              BlocProvider.of<LivestockCubit>(context).livestockDeliveryStatusApi(context, widget.cartId, widget.farmerProjectId.toString(), controller.text, "approved", []);
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
                              })):const SizedBox.shrink(),

                      widget.deliveryStatus == "completed"?
                      15.verticalSpace():const SizedBox.shrink(),

                      Container(
                          margin: 0.marginAll(),
                          height: 55,
                          width: screenWidth(),
                          child: customButton("Reject",
                              fontColor: 0xff000000, color: 0xFFDCDCDC,onTap: () {
                                TextEditingController controller = TextEditingController();
                                modalBottomSheetMenu(context,
                                    radius: 40,
                                    child: StatefulBuilder(
                                        builder: (context, setState) {
                                          return SizedBox(
                                            height: 350,
                                            child: Padding(
                                              padding: const EdgeInsets.fromLTRB(23, 20, 25, 10),
                                              child: Column(
                                                  crossAxisAlignment: CrossAxisAlignment.start,
                                                  children: [
                                                    Center(
                                                      child: Text(
                                                        'Remarks',
                                                        style: figtreeMedium.copyWith(fontSize: 22),
                                                      ),
                                                    ),
                                                    15.verticalSpace(),
                                                    Column(
                                                      crossAxisAlignment: CrossAxisAlignment.start,
                                                      children: [


                                                        Text(
                                                          'Add remarks',
                                                          style: figtreeMedium.copyWith(fontSize: 12),
                                                        ),

                                                        4.verticalSpace(),

                                                        TextField(
                                                          controller: controller,
                                                          maxLines: 4,
                                                          minLines: 4,
                                                          decoration: InputDecoration(
                                                              hintText: 'Write...',
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
                                                            'Submit',
                                                            fontColor: 0xffFFFFFF,
                                                            onTap: () async{
                                                              BlocProvider.of<LivestockCubit>(context).livestockDeliveryStatusApi(context, widget.cartId, widget.farmerProjectId.toString(), controller.text, "rejected", []);
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
                              })),

                    ],
                  ):const SizedBox.shrink():const SizedBox.shrink(),


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
                          )):const SizedBox.shrink(): const SizedBox.shrink(),
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
