import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:geolocator/geolocator.dart';
import 'package:glad/screen/custom_widget/g_map.dart';
import 'package:glad/utils/extension.dart';
import 'package:glad/utils/images.dart';
import 'package:glad/utils/styles.dart';

class MCCInArea extends StatefulWidget {
  const MCCInArea(
      {super.key,
      required this.name,
      required this.phone,
      required this.address,
      required this.image});
  final String name;
  final String phone;
  final String address;
  final String image;

  @override
  State<MCCInArea> createState() => _MCCInAreaState();
}

class _MCCInAreaState extends State<MCCInArea> {
  Position? position;
  @override
  void initState() {
    Geolocator.getCurrentPosition().then((value) => setState(() {
          position = value;
        }));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.fromLTRB(20, 10, 0, 2),
          child: Text('Milk Collection Center (MCC)',
              style: figtreeMedium.copyWith(fontSize: 18, color: Colors.black)),
        ),
        Padding(
          padding: const EdgeInsets.fromLTRB(20, 0, 0, 12),
          child: Text('In your area',
              style:
                  figtreeRegular.copyWith(fontSize: 14, color: Colors.black)),
        ),
        Stack(
          children: [
            GMap(
              lat: position!.latitude,
              lng: position!.longitude,
              height: 350,
            ),
            Positioned(
              bottom: 10,
              left: 15,
              child: Stack(
                alignment: Alignment.center,
                children: [
                  SizedBox(
                      height: 150,
                      width: MediaQuery.of(context).size.width * 0.8),
                  Container(
                    height: 105,
                    width: MediaQuery.of(context).size.width * 0.8,
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(16)),
                    child: Padding(
                      padding: const EdgeInsets.fromLTRB(15.0, 20, 0, 10),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Image.asset(Images.sampleUser),
                          15.horizontalSpace(),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(widget.name,
                                  style: figtreeMedium.copyWith(
                                      fontSize: 16, color: Colors.black)),
                              4.verticalSpace(),
                              Row(
                                crossAxisAlignment: CrossAxisAlignment.end,
                                children: [
                                  const Icon(
                                    Icons.call,
                                    color: Colors.black,
                                    size: 16,
                                  ),
                                  Text(widget.phone,
                                      style: figtreeRegular.copyWith(
                                          fontSize: 12, color: Colors.black)),
                                ],
                              ),
                              4.verticalSpace(),
                              Row(
                                crossAxisAlignment: CrossAxisAlignment.end,
                                children: [
                                  const Icon(
                                    Icons.location_on,
                                    color: Colors.black,
                                    size: 16,
                                  ),
                                  SizedBox(
                                    width:
                                        MediaQuery.of(context).size.width * 0.5,
                                    child: Text(
                                      widget.address,
                                      style: figtreeRegular.copyWith(
                                        fontSize: 12,
                                        color: Colors.black,
                                        overflow: TextOverflow.ellipsis,
                                      ),
                                    ),
                                  ),
                                ],
                              )
                            ],
                          )
                        ],
                      ),
                    ),
                  ),
                  Positioned(
                      top: 0,
                      right: 10,
                      child: Row(
                        children: [
                          SvgPicture.asset(Images.callPrimary),
                          6.horizontalSpace(),
                          SvgPicture.asset(Images.whatsapp),
                          6.horizontalSpace(),
                          SvgPicture.asset(Images.redirectLocation),
                          4.horizontalSpace(),
                        ],
                      )),
                ],
              ),
            )
          ],
        )
      ],
    );
  }
}
