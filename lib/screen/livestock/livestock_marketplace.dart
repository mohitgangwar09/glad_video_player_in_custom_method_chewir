import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:glad/screen/custom_widget/custom_methods.dart';
import 'package:glad/screen/custom_widget/livestock_details.dart';
import 'package:glad/screen/custom_widget/show_all_button.dart';
import 'package:glad/screen/livestock/livestock_detail.dart';
import 'package:glad/utils/color_resources.dart';
import 'package:glad/utils/extension.dart';
import 'package:glad/utils/styles.dart';

import '../../cubit/livestock_cubit/livestock_cubit.dart';

class LiveStockMarketplace extends StatefulWidget {
  const LiveStockMarketplace({super.key, required this.onTapShowAll});
  final void Function() onTapShowAll;

  @override
  State<LiveStockMarketplace> createState() => _LiveStockMarketplaceState();
}

class _LiveStockMarketplaceState extends State<LiveStockMarketplace> {
  @override
  void initState() {
    BlocProvider.of<LivestockCubit>(context).livestockListApi(context,true);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LivestockCubit, LivestockCubitState>(
        builder: (context, state) {
          if (state.status == LivestockStatus.submit) {
            return const Center(
                child: CircularProgressIndicator(
                  color: ColorResources.maroon,
                ));
          } else if (state.responseLivestockList == null) {
            return Center(child: Text("${state.responseLivestockList} Api Error"));
          } else if (state.responseLivestockList!.data == null) {
            return const SizedBox.shrink();
          } else {
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.fromLTRB(20, 10, 20, 2),
                  child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,

                    children: [
                      Text('Livestock Marketplace',
                          style: figtreeMedium.copyWith(fontSize: 18, color: Colors.black)),
                      ShowAllButton(onTap: widget.onTapShowAll)
                    ],
                  ),
                ),
                10.verticalSpace(),
                livestock(context, state),
              ],
            );
          }
        }
    );
  }

  Widget livestock(BuildContext context, LivestockCubitState state){
    return state.responseLivestockList!.data != null ? Padding(
      padding: const EdgeInsets.fromLTRB(20.0, 0, 10, 10),
      child: SizedBox(
        height: 250,
        child: ListView.separated(
            scrollDirection: Axis.horizontal,
            clipBehavior: Clip.none,
            itemCount: state.responseLivestockList!.data!.liveStoclLIst!.length > 5 ? 5 : state.responseLivestockList!.data!.liveStoclLIst!.length,
            itemBuilder: (context, index){
          return InkWell(
            onTap: () {
              BlocProvider.of<LivestockCubit>(context).state.selectedLivestockFarmerMAster = null;
              LiveStockDetail(id: state.responseLivestockList!.data!.liveStoclLIst![index].id.toString(), isMyLivestock: false,type: 'buyer', removeUserID: state.responseLivestockList!.data!.liveStoclLIst![index].userId.toString(),).navigate();
            },
            child: customShadowContainer(
              margin: 0,
              backColor: Colors.grey.withOpacity(0.4),
              child: SizedBox(
                width: 170,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Stack(
                      alignment: Alignment.bottomRight,
                      children: [
                        if(state.responseLivestockList!.data!.liveStoclLIst![index].liveStockDocumentFiles!.isNotEmpty)
                          SizedBox(
                            // padding: 2.marginAll(),
                              width: screenWidth(),
                              height:140,child: ClipRRect(borderRadius: const BorderRadius.only(topRight: Radius.circular(20),topLeft: Radius.circular(20)),child: CachedNetworkImage(imageUrl: state.responseLivestockList!.data!.liveStoclLIst![index].liveStockDocumentFiles![0].originalUrl ?? '',fit: BoxFit.cover,)))
                        else
                          const SizedBox(height: 140,),

                        if(state.responseLivestockList!.data!.liveStoclLIst![index].liveStockDocumentFiles!.length > 1)
                          customShadowContainer(
                            backColor: Colors.transparent,
                            color: Colors.transparent,
                            child: Row(
                              mainAxisSize: MainAxisSize.min,
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                (state.responseLivestockList!.data!.liveStoclLIst![index].liveStockDocumentFiles!.length).toString().textRegular(fontSize: 14, color: Colors.white),
                                const Icon(Icons.image_outlined, color: Colors.white,)
                              ],),
                          )
                      ],
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 10.0, right: 10, top: 6),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          RichText(
                              text: TextSpan(children: [
                                TextSpan(
                                    text: '${state.responseLivestockList!.data!.liveStoclLIst![index].cowBreed!.name ?? ''} cow ',
                                    style: figtreeMedium.copyWith(
                                        fontSize: 12, color: Colors.black)),
                                TextSpan(
                                    text: '(${state.responseLivestockList!.data!.liveStoclLIst![index].advertisementNo ?? ''})',
                                    style: figtreeMedium.copyWith(
                                        fontSize: 12, color: const Color(0xFF727272)))
                              ])),
                          6.verticalSpace(),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(getCurrencyString(double.parse(state.responseLivestockList!.data!.liveStoclLIst![index].price.toString())),
                                  style: figtreeSemiBold.copyWith(
                                      fontSize: 18, color: Colors.black)),
                              RichText(
                                  text: TextSpan(children: [
                                    TextSpan(
                                        text: 'Qty: ',
                                        style: figtreeMedium.copyWith(
                                            fontSize: 12, color: const Color(0xFF727272))),
                                    TextSpan(
                                        text: state.responseLivestockList!.data!.liveStoclLIst![index].balanceCows.toString(),
                                        style: figtreeMedium.copyWith(
                                            fontSize: 12, color: Colors.black)),
                                  ])),
                            ],
                          ),
                          12.verticalSpace(),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              RichText(
                                  text: TextSpan(children: [
                                    TextSpan(
                                        text: 'Age: ',
                                        style: figtreeMedium.copyWith(
                                            fontSize: 12, color: const Color(0xFF727272))),
                                    TextSpan(
                                        text: '${state.responseLivestockList!.data!.liveStoclLIst![index].age ?? ''} yrs',
                                        style: figtreeMedium.copyWith(
                                            fontSize: 12, color: Colors.black)),
                                  ])),
                              // 10.horizontalSpace(),
                              Container(
                                height: 5,
                                width: 5,
                                decoration: const BoxDecoration(
                                    color: Colors.black, shape: BoxShape.circle),
                              ),
                              // 10.horizontalSpace(),
                              RichText(
                                  text: TextSpan(children: [
                                    TextSpan(
                                        text: 'Milk: ',
                                        style: figtreeMedium.copyWith(
                                            fontSize: 12, color: const Color(0xFF727272))),
                                    TextSpan(
                                        text: '${double.parse(state.responseLivestockList!.data!.liveStoclLIst![index].yield ?? '').toInt()}L/day',
                                        style: figtreeMedium.copyWith(
                                            fontSize: 12, color: Colors.black))
                                  ])),
                            ],
                          ),
                          6.verticalSpace(),
                          if(state.responseLivestockList!.data!.liveStoclLIst![index].user != null)
                          Row(
                            children: [
                              Text(state.responseLivestockList!.data!.liveStoclLIst![index].user!.name != null
                                  ? state.responseLivestockList!.data!.liveStoclLIst![index].user!.name ?? ''
                                  : '',
                                style: figtreeMedium.copyWith(
                                    fontSize: 12, color: Colors.black), maxLines: 1,),

                              Flexible(
                                child: Text(state.responseLivestockList!.data!.liveStoclLIst![index].user!.address != null
                                    ? state.responseLivestockList!.data!.liveStoclLIst![index].user!.address!.address ?? ''
                                    : '',
                                  overflow: TextOverflow.ellipsis,
                                  style: figtreeMedium.copyWith(
                                      fontSize: 12, color: Colors.black), maxLines: 1,),

                              ),
                            ],
                          ),
                          // 12.verticalSpace(),
                          // Row(
                          //   children: [
                          //     Container(
                          //       decoration: BoxDecoration(
                          //         borderRadius: BorderRadius.circular(26),
                          //         border: Border.all(color: const Color(0xFFFC5E60)),
                          //       ),
                          //       padding: const EdgeInsets.symmetric(
                          //           horizontal: 16, vertical: 9.5),
                          //       child: SvgPicture.asset(Images.chatBubble),
                          //     ),
                          //     6.horizontalSpace(),
                          //     Container(
                          //       decoration: BoxDecoration(
                          //         borderRadius: BorderRadius.circular(50),
                          //         border: Border.all(color: const Color(0xffF6B51D)),
                          //       ),
                          //       padding: const EdgeInsets.symmetric(
                          //           vertical: 10.0, horizontal: 9.5),
                          //       child: Text('Add to Cart',
                          //           style: figtreeMedium.copyWith(
                          //               fontSize: 13.5, color: Colors.black)),
                          //     )
                          //   ],
                          // )
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        },
          separatorBuilder: (context, index) {
            return 10.horizontalSpace();
          },),
      ),
    ) : Padding(
      padding: EdgeInsets.only(top: screenWidth() / 2),
      child: const Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text('No data found'),
        ],
      ),
    );
  }

}