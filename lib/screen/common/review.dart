import 'package:flutter/material.dart';
import 'package:glad/utils/color_resources.dart';
import 'package:glad/utils/extension.dart';
import 'package:glad/utils/images.dart';
import 'package:glad/utils/styles.dart';

class GladReview extends StatefulWidget {
  const GladReview({super.key, required this.review, required this.name, required this.userType, required this.location, required this.attachment, required this.attachmentType});

  final String review;
  final String name;
  final String userType;
  final String location;
  final String attachment;
  final String attachmentType;

  @override
  State<GladReview> createState() => _GladReviewState();
}

class _GladReviewState extends State<GladReview> {


  @override
  Widget build(BuildContext context) {
    return Stack(
      clipBehavior: Clip.none,
      children: [
        Container(
          margin: const EdgeInsets.only(left: 22),
          decoration: BoxDecoration(
            border: Border.all(color:  const Color(0xFFDCDCDC).withOpacity(0.4),
              // borderRadius: BorderRadius.circular(radius),
            ),
            color: Colors.white,
            borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(20),
                bottomLeft: Radius.circular(60)),
            boxShadow:[
              BoxShadow(
                  color: Colors.grey.withOpacity(0.5),
                  blurRadius: 16.0,
                  offset: const Offset(0, 5)
              )],),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.fromLTRB(
                            10.0, 20, 10, 0),
                        child: Text(
                          maxLines: 4,
                          widget.review,
                          style: figtreeMedium.copyWith(
                              overflow: TextOverflow.ellipsis,
                              fontSize: 16, color: Colors.black),
                        ),
                      ),
                    ),

                    Padding(
                      padding: const EdgeInsets.fromLTRB(45.0,0,35,20),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('${widget.name}, ${widget.userType} ',
                              maxLines: 1,
                              style: figtreeMedium.copyWith(
                                  overflow: TextOverflow.ellipsis,
                                  fontSize: 14, color: Colors.black)),
                          4.verticalSpace(),
                          Text(widget.location,
                              maxLines: 1,
                              style: figtreeMedium.copyWith(
                                  overflow: TextOverflow.ellipsis,
                                  fontSize: 12,
                                  color: Colors.black)),
                        ],
                      ),
                    ),
                  ],
                ),
              ),

              ClipRRect(
                borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(20),
                    bottomLeft: Radius.circular(20)),
                child: Image.asset(Images.sampleVideo,
                    width: 120,
                    height: screenHeight(),
                    fit: BoxFit.cover),
              )
            ],
          ),
        ),
        Positioned(
            bottom: -5,
            left: 15,
            child: Container(
                decoration: const BoxDecoration(shape: BoxShape.circle, color: ColorResources.mustard),
                padding: const EdgeInsets.fromLTRB(7, 0, 7, 20),
                child: Image.asset(Images.comma, height: 64,))),
      ],
    );
  }
}
