// import 'package:cached_network_image/cached_network_image.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:flutter_svg/flutter_svg.dart';
// import 'package:glad/cubit/landing_page_cubit/landing_page_cubit.dart';
// import 'package:glad/cubit/livestock_cubit/livestock_cubit.dart';
// import 'package:glad/data/model/livestock_detail.dart';
// import 'package:glad/screen/common/add_livestock.dart';
// import 'package:glad/screen/common/livestock_detail.dart';
// import 'package:glad/screen/custom_widget/custom_appbar.dart';
// import 'package:glad/screen/custom_widget/custom_methods.dart';
// import 'package:glad/screen/farmer_screen/dashboard/dashboard_farmer.dart';
// import 'package:glad/screen/guest_user/dashboard/dashboard_guest.dart';
// import 'package:glad/utils/app_constants.dart';
// import 'package:glad/utils/color_resources.dart';
// import 'package:glad/utils/extension.dart';
// import 'package:glad/utils/images.dart';
// import 'package:glad/utils/styles.dart';
//
// class MyLiveStockScreen extends StatefulWidget {
//   const MyLiveStockScreen({Key? key}) : super(key: key);
//
//   @override
//   State<MyLiveStockScreen> createState() => _MyLiveStockScreenState();
// }
//
// class _MyLiveStockScreenState extends State<MyLiveStockScreen> {
//
//   @override
//   void initState() {
//     BlocProvider.of<LivestockCubit>(context).myLivestockListApi(context);
//     super.initState();
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: BlocBuilder<LivestockCubit, LivestockCubitState>(
//           builder: (context, state) {
//             if (state.status == LivestockStatus.submit) {
//               return const Center(
//                   child: CircularProgressIndicator(
//                     color: ColorResources.maroon,
//                   ));
//             } else if (state.responseMyLivestockList == null) {
//               return Center(child: Text("${state.responseMyLivestockList} Api Error"));
//             } else {
//               return Container(
//                 color: Colors.white,
//                 child: Stack(
//                   children: [
//                     landingBackground(),
//                     Column(
//                       children: [
//                         CustomAppBar(
//                           context: context,
//                           titleText1: 'My Livestock Ads',
//                           centerTitle: true,
//                           leading: arrowBackButton(),
//                         ),
//                         Container(
//                           margin: const EdgeInsets.only(
//                               left: 20, right: 20, bottom: 13, top: 23),
//                           height: 50,
//                           decoration: boxDecoration(
//                               borderColor: Colors.grey,
//                               borderRadius: 62,
//                               backgroundColor: Colors.white),
//                           width: screenWidth(),
//                           child: Row(
//                             children: [
//                               13.horizontalSpace(),
//                               SvgPicture.asset(Images.searchLeft),
//                               13.horizontalSpace(),
//                               const Expanded(
//                                   child: TextField(
//                                     decoration: InputDecoration(
//                                         border: InputBorder.none,
//                                         hintText: "Search by..."),
//                                   )),
//                             ],
//                           ),
//                         ),
//                         landingPage(context, state),
//                       ],
//                     ),
//                     Positioned(
//                         bottom: 0,
//                         right: 0,
//                         child: InkWell(
//                           onTap: () {
//                             const AddLivestock().navigate();
//                           },
//                           child: SvgPicture.asset(
//                             Images.addLivestock,
//                             width: 100,
//                             height: 100,
//                           ),
//                         ))
//                   ],
//                 ),
//               );
//             }
//         }
//       ),
//     );
//   }
//
//   Widget landingPage(BuildContext context, LivestockCubitState state){
//     return state.responseMyLivestockList!.data != null ? Expanded(
//       child: customGrid(
//           padding: const EdgeInsets.fromLTRB(13,13,13,120),
//           list: state.responseMyLivestockList!.data ?? [],
//           crossAxisSpacing: 13,
//           mainAxisSpacing: 13,
//           mainAxisExtent: 250,
//           context, child: (index){
//         return InkWell(
//           onTap: () {
//             LiveStockDetail(id: state.responseMyLivestockList!.data![index].id.toString(), isMyLivestock: true,).navigate();
//           },
//           child: customShadowContainer(
//             margin: 0,
//             backColor: Colors.grey.withOpacity(0.4),
//             child: Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 Stack(
//                   alignment: Alignment.bottomRight,
//                   children: [
//                     Container(
//                         padding: 2.marginAll(),
//                         width: screenWidth(),
//                         height:140,child: ClipRRect(borderRadius: BorderRadius.circular(10),child: CachedNetworkImage(imageUrl: state.responseMyLivestockList!.data![index].liveStockDocumentFiles!.isNotEmpty ? state.responseMyLivestockList!.data![index].liveStockDocumentFiles![0].originalUrl ?? '' : '',fit: BoxFit.cover,))),
//                     if(state.responseMyLivestockList!.data![index].liveStockDocumentFiles!.length > 1)
//                     customShadowContainer(
//                       backColor: Colors.transparent,
//                       color: Colors.transparent,
//                       child: Row(
//                         mainAxisSize: MainAxisSize.min,
//                         mainAxisAlignment: MainAxisAlignment.end,
//                         children: [
//                         (state.responseMyLivestockList!.data![index].liveStockDocumentFiles!.length).toString().textRegular(fontSize: 14, color: Colors.white),
//                         const Icon(Icons.image_outlined, color: Colors.white,)
//                       ],),
//                     )
//                   ],
//                 ),
//                 Padding(
//                   padding: const EdgeInsets.only(left: 12.0, right: 3, top: 6),
//                   child: Column(
//                     crossAxisAlignment: CrossAxisAlignment.start,
//                     children: [
//                       RichText(
//                           text: TextSpan(children: [
//                             TextSpan(
//                                 text: '${state.responseMyLivestockList!.data![index].cowBreed!.name ?? ''} cow ',
//                                 style: figtreeMedium.copyWith(
//                                     fontSize: 12, color: Colors.black)),
//                             TextSpan(
//                                 text: '(${state.responseMyLivestockList!.data![index].advertisementNo ?? ''})',
//                                 style: figtreeMedium.copyWith(
//                                     fontSize: 12, color: const Color(0xFF727272)))
//                           ])),
//                       6.verticalSpace(),
//                       Row(
//                         mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                         children: [
//                           Text(getCurrencyString(double.parse(state.responseMyLivestockList!.data![index].price.toString())),
//                               style: figtreeSemiBold.copyWith(
//                                   fontSize: 18, color: Colors.black)),
//                           RichText(
//                               text: TextSpan(children: [
//                                 TextSpan(
//                                     text: 'Qty: ',
//                                     style: figtreeMedium.copyWith(
//                                         fontSize: 12, color: const Color(0xFF727272))),
//                                 TextSpan(
//                                     text: state.responseMyLivestockList!.data![index].cowQty.toString(),
//                                     style: figtreeMedium.copyWith(
//                                         fontSize: 12, color: Colors.black)),
//                               ])),
//                         ],
//                       ),
//                       12.verticalSpace(),
//                       Row(
//                         mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                         children: [
//                           RichText(
//                               text: TextSpan(children: [
//                                 TextSpan(
//                                     text: 'Age: ',
//                                     style: figtreeMedium.copyWith(
//                                         fontSize: 12, color: const Color(0xFF727272))),
//                                 TextSpan(
//                                     text: '${state.responseMyLivestockList!.data![index].age ?? ''} yrs',
//                                     style: figtreeMedium.copyWith(
//                                         fontSize: 12, color: Colors.black)),
//                               ])),
//                           // 10.horizontalSpace(),
//                           Container(
//                             height: 5,
//                             width: 5,
//                             decoration: const BoxDecoration(
//                                 color: Colors.black, shape: BoxShape.circle),
//                           ),
//                           // 10.horizontalSpace(),
//                           RichText(
//                               text: TextSpan(children: [
//                                 TextSpan(
//                                     text: 'Milk: ',
//                                     style: figtreeMedium.copyWith(
//                                         fontSize: 12, color: const Color(0xFF727272))),
//                                 TextSpan(
//                                     text: '${double.parse(state.responseMyLivestockList!.data![index].yield ?? '').toInt()}L/day',
//                                     style: figtreeMedium.copyWith(
//                                         fontSize: 12, color: Colors.black))
//                               ])),
//                         ],
//                       ),
//                       6.verticalSpace(),
//                       Text(state.responseMyLivestockList!.data![index].user!.address != null
//                           ? state.responseMyLivestockList!.data![index].user!.address!.address ?? ''
//                           : '',
//                           style: figtreeMedium.copyWith(
//                               fontSize: 12, color: Colors.black), maxLines: 1,),
//                       // 12.verticalSpace(),
//                       // Row(
//                       //   children: [
//                       //     Container(
//                       //       decoration: BoxDecoration(
//                       //         borderRadius: BorderRadius.circular(26),
//                       //         border: Border.all(color: const Color(0xFFFC5E60)),
//                       //       ),
//                       //       padding: const EdgeInsets.symmetric(
//                       //           horizontal: 16, vertical: 9.5),
//                       //       child: SvgPicture.asset(Images.chatBubble),
//                       //     ),
//                       //     6.horizontalSpace(),
//                       //     Container(
//                       //       decoration: BoxDecoration(
//                       //         borderRadius: BorderRadius.circular(50),
//                       //         border: Border.all(color: const Color(0xffF6B51D)),
//                       //       ),
//                       //       padding: const EdgeInsets.symmetric(
//                       //           vertical: 10.0, horizontal: 9.5),
//                       //       child: Text('Add to Cart',
//                       //           style: figtreeMedium.copyWith(
//                       //               fontSize: 13.5, color: Colors.black)),
//                       //     )
//                       //   ],
//                       // )
//                     ],
//                   ),
//                 ),
//               ],
//             ),
//           ),
//         );
//       }),
//     ) : Padding(
//       padding: EdgeInsets.only(top: screenWidth() / 2),
//       child: const Column(
//         crossAxisAlignment: CrossAxisAlignment.center,
//         mainAxisAlignment: MainAxisAlignment.center,
//         children: [
//           Text('No data found'),
//         ],
//       ),
//     );
//   }
// }
