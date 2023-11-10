import 'package:cached_network_image/cached_network_image.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:glad/cubit/news_cubit/news_cubit.dart';
import 'package:glad/cubit/profile_cubit/profile_cubit.dart';
import 'package:glad/screen/custom_widget/custom_appbar.dart';
import 'package:glad/screen/custom_widget/custom_methods.dart';
import 'package:glad/screen/guest_user/dashboard/dashboard_guest.dart';
import 'package:glad/utils/app_constants.dart';
import 'package:glad/utils/color_resources.dart';
import 'package:glad/utils/extension.dart';
import 'package:glad/utils/images.dart';
import 'package:glad/utils/styles.dart';
import 'package:intl/intl.dart';
import 'package:open_file_safe_plus/open_file_safe_plus.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:url_launcher/url_launcher.dart';

class NewsAndEvent extends StatefulWidget {
  const NewsAndEvent({Key? key, required this.isBottomAppBar}) : super(key: key);
  final bool isBottomAppBar;

  @override
  State<NewsAndEvent> createState() => _NewsAndEventState();
}

class _NewsAndEventState extends State<NewsAndEvent> {
  @override
  void initState() {
    BlocProvider.of<NewsCubit>(context).newsCategoriesApi(context);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: BlocBuilder<NewsCubit, NewsCubitState>(builder: (context, state) {
        if (state.status == NewsStatus.submit) {
          return const Center(
              child: CircularProgressIndicator(
            color: ColorResources.maroon,
          ));
        } else if (state.responseNewsCategories == null) {
          return Center(
              child: Text("${state.responseNewsCategories} Api Error"));
        } else if (state.responseNewsList == null) {
          return Center(child: Text("${state.responseNewsList} Api Error"));
        } else {
          return Stack(
            children: [
              landingBackground(),
              Column(
                children: [
                  widget.isBottomAppBar ?
                  CustomAppBar(
                    context: context,
                    titleText1: 'News and Events',
                    centerTitle: true,
                    leading: BlocProvider.of<ProfileCubit>(context).sharedPreferences.getString(AppConstants.userType) == 'mcc' ?
                    const SizedBox.shrink()
                    : openDrawer(
                        onTap: () {
                          landingKey.currentState?.openDrawer();
                        },
                        child: SvgPicture.asset(Images.drawer)),
                    // action: Row(
                    //   children: [
                    //     InkWell(
                    //         onTap: () {
                    //           modalBottomSheetMenu(
                    //               context, child:
                    //           SizedBox(
                    //             height: screenHeight()*0.65,
                    //             child: Column(
                    //               children: [
                    //
                    //                 Padding(
                    //                   padding: const EdgeInsets.only(left: 8.0,right: 8),
                    //                   child: Row(
                    //                     mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    //                     children: [
                    //
                    //                       TextButton(onPressed: (){
                    //                         pressBack();
                    //                       }, child: "Cancel".textMedium(color: const Color(0xff6A0030),fontSize: 14)),
                    //
                    //                       "Sort By".textMedium(fontSize: 22),
                    //
                    //                       TextButton(onPressed: (){},child: "Reset".textMedium(color: const Color(0xff6A0030),fontSize: 14))
                    //
                    //                     ],
                    //                   ),
                    //                 ),
                    //
                    //                 const Padding(
                    //                   padding: EdgeInsets.only(left: 20.0,right: 20),
                    //                   child: Divider(),
                    //                 ),
                    //
                    //                 Expanded(
                    //                   child: customList(list: [1,2,22,2,22,2,2,22,2],child: (index){
                    //                     return Padding(padding: const EdgeInsets.only(left: 30,right: 30,top:30,bottom: 10),
                    //                         child: "ROI Highest to Lowest".textRegular(fontSize: 16));
                    //                   }),
                    //                 ),
                    //
                    //                 10.verticalSpace(),
                    //
                    //                 Container(margin: 20.marginAll(),height: 55,width: screenWidth(),child: customButton("Apply",fontColor: 0xffffffff, onTap: (){}))
                    //
                    //
                    //               ],
                    //             ),
                    //           ));
                    //         }, child: SvgPicture.asset(Images.filter2)),
                    //     18.horizontalSpace(),
                    //   ],
                    // ),
                  ) :
                  CustomAppBar(
                    context: context,
                    titleText1: 'News and Events',
                    centerTitle: true,
                    leading: arrowBackButton(),
                  ),
                  SizedBox(
                    height: 45,
                    child: customList(
                        list: List.generate(
                            state.responseNewsCategories!.data!.length, (index) => null),
                        axis: Axis.horizontal,
                        child: (index) {
                          return Row(
                            children: [
                              index == 0
                                  ? Padding(
                                padding: const EdgeInsets.only(left: 20),
                                child: InkWell(
                                  onTap: () {
                                    BlocProvider.of<NewsCubit>(context)
                                        .emit(state.copyWith(selectedCategoryId: ''));
                                    BlocProvider.of<NewsCubit>(context)
                                        .newsListApi(context, '');
                                  },
                                  child: Container(
                                      padding: const EdgeInsets.all(14),
                                      decoration: boxDecoration(
                                        borderColor: state.selectedCategoryId == ''
                                            ? ColorResources.maroon
                                            : const Color(0xffDCDCDC),
                                        borderRadius: 50,
                                        backgroundColor: state.selectedCategoryId == ''
                                            ? const Color(0xFFFFF3F4)
                                            : Colors.white,
                                      ),
                                      child: Text(
                                        'All',
                                        style: figtreeMedium.copyWith(
                                            fontSize: 12,
                                            color: state.selectedCategoryId == ''
                                                ? ColorResources.maroon
                                                : Colors.black),
                                      )),
                                ),
                              )
                                  : const SizedBox.shrink(),
                              Padding(
                                padding:
                                EdgeInsets.only(right: 10, left: index == 0 ? 10 : 0),
                                child: InkWell(
                                  onTap: () {
                                    BlocProvider.of<NewsCubit>(context).emit(
                                        state.copyWith(
                                            selectedCategoryId: state
                                                .responseNewsCategories!
                                                .data![index]
                                                .id.toString() ??
                                                ''));
                                    BlocProvider.of<NewsCubit>(context).newsListApi(
                                        context,
                                        state.responseNewsCategories!.data![index].id.toString() ??
                                            '');
                                  },
                                  child: Container(
                                      padding: const EdgeInsets.all(14),
                                      decoration: boxDecoration(
                                        borderColor: state.selectedCategoryId ==
                                            state.responseNewsCategories!.data![index]
                                                .id.toString()
                                            ? ColorResources.maroon
                                            : const Color(0xffDCDCDC),
                                        borderRadius: 50,
                                        backgroundColor: state.selectedCategoryId ==
                                            state.responseNewsCategories!.data![index]
                                                .id.toString()
                                            ? const Color(0xFFFFF3F4)
                                            : Colors.white,
                                      ),
                                      child: Text(
                                        state.responseNewsCategories!.data![index].name ??
                                            '',
                                        style: figtreeMedium.copyWith(
                                            fontSize: 12,
                                            color: state.selectedCategoryId ==
                                                state.responseNewsCategories!
                                                    .data![index].id.toString()
                                                ? ColorResources.maroon
                                                : Colors.black),
                                      )),
                                ),
                              ),
                            ],
                          );
                        }),
                  ),
                  landingPage(context, state),
                ],
              ),
            ],
          );
        }
      }),
    );
  }

  Widget landingPage(BuildContext context, NewsCubitState state) {
    return  state.responseNewsList!.data != null
        ? Expanded(
      child: SingleChildScrollView(
        child: customList(
            padding: const EdgeInsets.fromLTRB(13, 13, 13, 120),
            list: List.generate(state.responseNewsList!.data!.length, (index) => null),
            child: (index) {
              return InkWell(
                onTap: () async {
                  if(state.responseNewsList!.data![index].resource == null) {
                    showCustomToast(context, 'No resource Url');
                    return;
                  }
                  if(state.responseNewsList!.data![index].resource!.originalUrl!.endsWith('pdf')) {
                    var dir = await getApplicationDocumentsDirectory();
                    await Permission.manageExternalStorage.request();
                    await Dio().download(state.responseNewsList!.data![index].resource!.originalUrl!, "${"${dir.path}/fileName"}.pdf");
                    await OpenFilePlus.open("${"${dir.path}/fileName"}.pdf");
                  } else{
                    Uri url = Uri.parse(state.responseNewsList!.data![index].resource!.originalUrl!);
                    if (!await launchUrl(url, mode: LaunchMode.inAppWebView)) {
                      throw Exception('Could not launch $url');
                    }
                  }
                },
                child: Padding(
                  padding: const EdgeInsets.only(bottom: 12.0),
                  child: customShadowContainer(
                    margin: 0,
                    backColor: Colors.grey.withOpacity(0.4),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                            padding: 9.marginAll(),
                            width: 130,
                            height: 120,
                            child: ClipRRect(
                                borderRadius: BorderRadius.circular(15),
                                child: CachedNetworkImage(
                                  imageUrl: state
                                      .responseNewsList!
                                      .data![index]
                                      .image ??
                                      '',
                                  fit: BoxFit.cover,
                                  errorWidget: (_, __, ___) {
                                    return Image.asset(
                                      Images.sampleLivestock,
                                      fit: BoxFit.cover,
                                    );
                                  },
                                ))),
                        Expanded(
                          flex: 6,
                          child: Padding(
                            padding: const EdgeInsets.only(left: 7.0, top: 15),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                    state.responseNewsList!.data![index].title!,
                                    maxLines: 3,
                                    overflow: TextOverflow.ellipsis,
                                    style: figtreeMedium.copyWith(
                                        fontSize: 16, color: Colors.black),
                                    softWrap: true),
                                16.verticalSpace(),
                                Text(DateFormat('dd MMM, yyyy').format(DateTime.parse(state.responseNewsList!.data![index].validFrom!)),
                                    style: figtreeRegular.copyWith(
                                        fontSize: 12,
                                        color: const Color(0xff727272))),
                              ],
                            ),
                          ),
                        ),
                        Expanded(
                          flex: 1,
                          child: Container(
                            height: 95,
                            padding: const EdgeInsets.only(right: 4, top: 3),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                SvgPicture.asset(Images.newsI),
                                SvgPicture.asset(Images.menuIcon)
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              );
            }),
      ),
    ) : const SizedBox.shrink();
  }
}
