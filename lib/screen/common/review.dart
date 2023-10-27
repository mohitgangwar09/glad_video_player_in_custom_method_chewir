import 'dart:io';
import 'dart:math';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:expandable_text/expandable_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:glad/utils/color_resources.dart';
import 'package:glad/utils/extension.dart';
import 'package:glad/utils/images.dart';
import 'package:glad/utils/styles.dart';
import 'package:path_provider/path_provider.dart';
import 'package:video_player/video_player.dart';
import 'package:video_thumbnail/video_thumbnail.dart';

class GladReview extends StatefulWidget {
  const GladReview(
      {super.key,
      required this.review,
      required this.name,
      required this.userType,
      required this.location,
      required this.attachment,
      required this.attachmentType});

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
  String? videoThumbnail;

  getThumbnail() async {
    if (widget.attachment == '') return;
    if (widget.attachmentType == 'image') return;
    final x = await VideoThumbnail.thumbnailFile(
        video: widget.attachment,
        thumbnailPath: (await getTemporaryDirectory()).path,
        quality: 100);
    setState(() {
      videoThumbnail = x!;
    });
  }

  @override
  void initState() {
    getThumbnail();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      clipBehavior: Clip.none,
      children: [
        Container(
          margin: const EdgeInsets.only(left: 22),
          decoration: BoxDecoration(
            border: Border.all(
              color: const Color(0xFFDCDCDC).withOpacity(0.4),
              // borderRadius: BorderRadius.circular(radius),
            ),
            color: Colors.white,
            borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(20), bottomLeft: Radius.circular(60)),
            boxShadow: [
              BoxShadow(
                  color: Colors.grey.withOpacity(0.5),
                  blurRadius: 16.0,
                  offset: const Offset(0, 5))
            ],
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                      child: Container(
                        alignment: Alignment.centerLeft,
                        padding: const EdgeInsets.fromLTRB(20.0, 30, 20, 30),
                        child: ExpandableText(
                          widget.review,
                          expandText: 'Read More',
                          linkColor: ColorResources.maroon,
                          style: figtreeMedium.copyWith(
                              overflow: TextOverflow.ellipsis,
                              fontSize: 16,
                              color: Colors.black),
                          expandOnTextTap: false,
                          maxLines: 5,
                          onLinkTap: () {
                            showModalBottomSheet(
                              backgroundColor: Colors.transparent,
                                context: context,
                                builder: (context) => Stack(
                                  children: [
                                    Container(
                                      decoration: const BoxDecoration(borderRadius: BorderRadius.only(topRight: Radius.circular(20), topLeft: Radius.circular(20)), color: Colors.white),
                                      padding: const EdgeInsets.only(left: 20),
                                      child: Row(
                                        children: [
                                          Expanded(
                                            child: Column(
                                              crossAxisAlignment: CrossAxisAlignment.start,
                                              mainAxisAlignment: MainAxisAlignment.center,
                                              children: [
                                                Text(
                                                  widget.review,
                                                  style: figtreeMedium.copyWith(
                                                      fontSize: 16, color: Colors.black),
                                                ),
                                                40.verticalSpace(),
                                                Row(
                                                  children: [
                                                    Container(
                                                        decoration: const BoxDecoration(
                                                            shape: BoxShape.circle, color: ColorResources.mustard),
                                                        padding: const EdgeInsets.fromLTRB(7, 0, 7, 20),
                                                        child: Image.asset(
                                                          Images.comma,
                                                          height: 64,
                                                        )),
                                                    10.horizontalSpace(),
                                                    Column(crossAxisAlignment: CrossAxisAlignment.start,
                                                      children: [
                                                        Text(
                                                            '${widget.name.split(' ')[0]}, ${widget.userType} ',
                                                            maxLines: 1,
                                                            style: figtreeMedium.copyWith(
                                                                overflow: TextOverflow.ellipsis,
                                                                fontSize: 14,
                                                                color: Colors.black)),
                                                        4.verticalSpace(),
                                                        Text(widget.location,
                                                            maxLines: 1,
                                                            style: figtreeMedium.copyWith(
                                                                overflow: TextOverflow.ellipsis,
                                                                fontSize: 12,
                                                                color: Colors.black)),
                                                      ],),
                                                  ],
                                                )
                                              ],
                                            ),
                                          ),
                                          20.horizontalSpace(),
                                          ClipRRect(
                                            borderRadius: const BorderRadius.only(
                                                topLeft: Radius.circular(20),
                                                bottomLeft: Radius.circular(20)),
                                            child: widget.attachmentType == "image"
                                                ? CachedNetworkImage(
                                              imageUrl: widget.attachment,
                                              width: 120,
                                              height: screenHeight(),
                                              fit: BoxFit.cover,
                                              errorWidget: (_, __, ___) => Image.asset(
                                                  Images.sampleVideo,
                                                  width: 120,
                                                  height: screenHeight(),
                                                  fit: BoxFit.cover),
                                            )
                                                : videoThumbnail != null
                                                ? InkWell(
                                              onTap: () {
                                                showDialog(
                                                    context: context,
                                                    builder: (context) => OverlayVideoPlayer(
                                                        url: widget.attachment));
                                              },
                                              child: Stack(
                                                alignment: Alignment.center,
                                                children: [
                                                  Image.file(
                                                    File(videoThumbnail!),
                                                    width: 120,
                                                    height: screenHeight(),
                                                    fit: BoxFit.cover,
                                                    errorBuilder: (_, __, ___) => Image.asset(
                                                        Images.sampleVideo,
                                                        width: 120,
                                                        height: screenHeight(),
                                                        fit: BoxFit.cover),
                                                  ),
                                                  SvgPicture.asset(Images.playVideo),
                                                ],
                                              ),
                                            )
                                                : Image.asset(Images.sampleVideo,
                                                width: 120,
                                                height: screenHeight(),
                                                fit: BoxFit.cover),
                                          )
                                        ],
                                      ),
                                    ),
                                    Positioned(
                                        right: 10,
                                        top: 10,
                                        child: Material(
                                          color: Colors.transparent,
                                          child: InkWell(
                                              onTap: () {
                                                pressBack();
                                              },
                                              child: const Icon(
                                                Icons.close,
                                                color: Colors.white,
                                              )),
                                        )),
                                  ],
                                ));
                          },
                          collapseText: 'Show Less',
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.fromLTRB(45.0, 0, 35, 15),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                              '${widget.name.split(' ')[0]}, ${widget.userType} ',
                              maxLines: 1,
                              style: figtreeMedium.copyWith(
                                  overflow: TextOverflow.ellipsis,
                                  fontSize: 14,
                                  color: Colors.black)),
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
                child: widget.attachmentType == "image"
                    ? CachedNetworkImage(
                        imageUrl: widget.attachment,
                        width: 120,
                        height: screenHeight(),
                        fit: BoxFit.cover,
                        errorWidget: (_, __, ___) => Image.asset(
                            Images.sampleVideo,
                            width: 120,
                            height: screenHeight(),
                            fit: BoxFit.cover),
                      )
                    : videoThumbnail != null
                        ? InkWell(
                            onTap: () {
                              showDialog(
                                  context: context,
                                  builder: (context) => OverlayVideoPlayer(
                                      url: widget.attachment));
                            },
                            child: Stack(
                              alignment: Alignment.center,
                              children: [
                                Image.file(
                                  File(videoThumbnail!),
                                  width: 120,
                                  height: screenHeight(),
                                  fit: BoxFit.cover,
                                  errorBuilder: (_, __, ___) => Image.asset(
                                      Images.sampleVideo,
                                      width: 120,
                                      height: screenHeight(),
                                      fit: BoxFit.cover),
                                ),
                                SvgPicture.asset(Images.playVideo),
                              ],
                            ),
                          )
                        : Image.asset(Images.sampleVideo,
                            width: 120,
                            height: screenHeight(),
                            fit: BoxFit.cover),
              )
            ],
          ),
        ),
        Positioned(
            bottom: -10,
            left: 15,
            child: Container(
                decoration: const BoxDecoration(
                    shape: BoxShape.circle, color: ColorResources.mustard),
                padding: const EdgeInsets.fromLTRB(7, 0, 7, 20),
                child: Image.asset(
                  Images.comma,
                  height: 64,
                ))),
      ],
    );
  }
}

class OverlayVideoPlayer extends StatefulWidget {
  const OverlayVideoPlayer({
    Key? key,
    required this.url,
  }) : super(key: key);

  final String url;

  @override
  State<OverlayVideoPlayer> createState() => _OverlayVideoPlayerState();
}

class _OverlayVideoPlayerState extends State<OverlayVideoPlayer> {
  late VideoPlayerController _controller;

  bool _pauseVis = false;

  bool _playVis = false;

  final Key videoPlayerKey = const Key('video-player-key');
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _controller = VideoPlayerController.networkUrl(Uri.parse(widget.url))
      ..initialize().then((_) {
        // Ensure the first frame is shown after the video is initialized, even before the play button has been pressed.
        setState(() {});
      });
    _controller.setLooping(false);

    _controller.play();
    setState(() {
      _playVis = false;
    });
  }

  @override
  void dispose() {
    // Ensure disposing of the VideoPlayerController to free up resources.
    _controller.dispose();

    super.dispose();
  }

  showFadingIcon() {
    var visible = true;
    return AnimatedOpacity(
        opacity: visible ? 1 : 0, duration: const Duration(milliseconds: 500));
  }

  showAnimation() {
    if (!_controller.value.isPlaying) {
      setState(() {
        _pauseVis = true;
        Future.delayed(const Duration(milliseconds: 500), () {
          setState(() {
            _pauseVis = false;
            _playVis = true;
          });
        });
      });
    } else if (_controller.value.isPlaying) {
      setState(() {
        _playVis = true;
        Future.delayed(const Duration(milliseconds: 500), () {
          setState(() {
            _playVis = false;
          });
        });
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return _controller.value.isInitialized
        ? SizedBox(
            height: min(
                MediaQuery.of(context).size.width /
                    _controller.value.aspectRatio,
                200),
            child: Align(
              child: AspectRatio(
                aspectRatio: _controller.value.aspectRatio,
                child: GestureDetector(
                    onTap: () {
                      setState(() {
                        _controller.value.isPlaying
                            ? _controller.pause()
                            : _controller.play();
                      });
                      showAnimation();
                    },
                    child: Stack(alignment: Alignment.center, children: [
                      VideoPlayer(
                        _controller,
                        key: videoPlayerKey,
                      ),
                      Visibility(
                        visible: _playVis || !_controller.value.isPlaying,
                        child: Container(
                          height: 40,
                          width: 40,
                          decoration: BoxDecoration(
                            color: Colors.black.withOpacity(0.3),
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: const Icon(Icons.play_arrow, size: 30),
                        ),
                      ),
                      Visibility(
                          visible: _pauseVis,
                          child: Container(
                            height: 40,
                            width: 40,
                            decoration: BoxDecoration(
                              color: Colors.black.withOpacity(0.3),
                              borderRadius: BorderRadius.circular(20),
                            ),
                            child: const Icon(Icons.pause, size: 30),
                          )),
                      Positioned(
                          bottom: 20,
                          width: MediaQuery.of(context).size.width * 0.8,
                          child: VideoProgressIndicator(
                            _controller,
                            allowScrubbing: true,
                            padding: const EdgeInsets.only(top: 10.0),
                          )),
                      Positioned(
                          right: 10,
                          top: 10,
                          child: Material(
                            color: Colors.transparent,
                            child: InkWell(
                                onTap: () {
                                  pressBack();
                                },
                                child: const Icon(
                                  Icons.close,
                                  color: Colors.white,
                                )),
                          )),
                    ])),
              ),
            ),
          )
        : const SizedBox.shrink();
  }
}
