import 'package:cached_network_image/cached_network_image.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:glad/data/model/dashboard_news_event.dart';
import 'package:glad/screen/custom_widget/show_all_button.dart';
import 'package:glad/screen/guest_user/dashboard_tab_screen/news_and_event.dart';
import 'package:glad/utils/extension.dart';
import 'package:glad/utils/images.dart';
import 'package:glad/utils/styles.dart';
import 'package:intl/intl.dart';
import 'package:open_file_safe_plus/open_file_safe_plus.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:url_launcher/url_launcher.dart';

class TrendingNewsAndEvents extends StatefulWidget {
  const TrendingNewsAndEvents({super.key, required this.newsList});
  final List<NewsEvent> newsList;

  @override
  State<TrendingNewsAndEvents> createState() => _TrendingNewsAndEventsState();
}

class _TrendingNewsAndEventsState extends State<TrendingNewsAndEvents> {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.fromLTRB(20, 10, 20, 2),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text('Trending News & Events',
                  style: figtreeMedium.copyWith(
                      fontSize: 18, color: Colors.black)),
              ShowAllButton(onTap: () {
                const NewsAndEvent(isBottomAppBar: false,).navigate();
              })
            ],
          ),
        ),
        Padding(
          padding: const EdgeInsets.fromLTRB(20.0, 20, 0, 20),
          child: SizedBox(
            height: 200,
            child: ListView.separated(
              itemCount: widget.newsList.length,
              scrollDirection: Axis.horizontal,
              itemBuilder: (context, index) {
                return InkWell(
                  onTap: () async {
                    if(widget.newsList[index].resource == null) {
                      showCustomToast(context, 'No resource Url');
                      return;
                    }
                    if(widget.newsList[index].resource!.originalUrl!.endsWith('pdf')) {
                      var dir = await getApplicationDocumentsDirectory();
                      await Permission.manageExternalStorage.request();
                      await Dio().download(widget.newsList[index].resource!.originalUrl!, "${"${dir.path}/fileName"}.pdf");
                      await OpenFilePlus.open("${"${dir.path}/fileName"}.pdf");
                    } else{
                      Uri url = Uri.parse(widget.newsList[index].resource!.originalUrl!);
                      if (!await launchUrl(url, mode: LaunchMode.inAppWebView)) {
                        throw Exception('Could not launch $url');
                      }
                    }
                  },
                  child: Stack(
                    children: [
                      ClipRRect(
                        borderRadius: BorderRadius.circular(16.0),
                        child: CachedNetworkImage(
                          imageUrl: widget.newsList[index]
                              .image ??
                              '',
                          width: 150,
                          height: 200,
                          fit: BoxFit.cover,
                          errorWidget: (_, __, ___) {
                            return Image.asset(
                              Images.sampleVideo,
                              width: 150,
                              height: 200,
                              fit: BoxFit.cover,
                            );
                          },
                        ),
                      ),
                      Positioned(
                          bottom: 0,
                          left: 0,
                          right: 0,
                          child: Container(
                            decoration:  BoxDecoration(
                                color: Colors.black.withOpacity(.5),
                                borderRadius: const BorderRadius.only(bottomRight: Radius.circular(10),
                                    bottomLeft: Radius.circular(14))
                            ),
                            padding: 5.paddingAll(),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                    '"${widget.newsList[index].title}"',
                                    style: figtreeMedium.copyWith(
                                        fontSize: 14, color: Colors.white),
                                    softWrap: true),
                                5.verticalSpace(),
                                Text(DateFormat('dd MMM, yyyy').format(DateTime.parse(widget.newsList[index].validFrom ?? '')),
                                    style: figtreeRegular.copyWith(
                                        fontSize: 10, color: Colors.white))
                              ],
                            ),
                          )),
                    ],
                  ),
                );
              },
              separatorBuilder: (context, index) {
                return 10.horizontalSpace();
              },
            ),
          ),
        ),
      ],
    );
  }
}
