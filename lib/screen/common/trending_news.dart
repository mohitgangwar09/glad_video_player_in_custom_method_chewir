import 'package:flutter/material.dart';
import 'package:glad/screen/custom_widget/show_all_button.dart';
import 'package:glad/utils/extension.dart';
import 'package:glad/utils/images.dart';
import 'package:glad/utils/styles.dart';

class TrendingNewsAndEvents extends StatefulWidget {
  const TrendingNewsAndEvents({super.key});

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
              ShowAllButton(onTap: () {})
            ],
          ),
        ),
        Padding(
          padding: const EdgeInsets.fromLTRB(20.0, 20, 0, 20),
          child: SizedBox(
            height: 200,
            child: ListView.separated(
              itemCount: 10,
              scrollDirection: Axis.horizontal,
              itemBuilder: (context, index) {
                return Stack(
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.circular(16.0),
                      child: Image.asset(
                        Images.sampleVideo,
                        width: 150,
                        height: 200,
                        fit: BoxFit.cover,
                      ),
                    ),
                    Positioned(
                        bottom: 10,
                        left: 10,
                        right: 10,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                                '"Identification of gaps in farmers businesses and fixing them"',
                                style: figtreeMedium.copyWith(
                                    fontSize: 14, color: Colors.white),
                                softWrap: true),
                            5.verticalSpace(),
                            Text('18 Apr, 2023',
                                style: figtreeRegular.copyWith(
                                    fontSize: 10, color: Colors.white))
                          ],
                        )),
                  ],
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
