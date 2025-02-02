import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:glad/cubit/dde_enquiry_cubit/dde_enquiry_cubit.dart';
import 'package:glad/screen/custom_widget/custom_methods.dart';
import 'package:glad/screen/custom_widget/g_map.dart';
import 'package:glad/utils/extension.dart';
import 'package:glad/utils/images.dart';
import 'package:glad/utils/styles.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class MCCInArea extends StatefulWidget {
  const MCCInArea(
      {super.key,
      required this.name,
      required this.phone,
      required this.address,
      required this.image, required this.lat, required this.long});
  final String name;
  final String phone;
  final String address;
  final String? image;
  final double? lat;
  final double? long;


  @override
  State<MCCInArea> createState() => _MCCInAreaState();
}

class _MCCInAreaState extends State<MCCInArea> {
  // Position? position;
  @override
  void initState() {
    /*Geolocator.getCurrentPosition().then((value) => setState(() {
          position = value;
        }));*/
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
              lat: widget.lat!,
              lng: widget.long!,
              height: 350,
              zoomGesturesEnabled: false,
              zoomControlsEnabled: false,
              myLocationEnabled: false,
              myLocationButtonEnabled: false,
              markers: {Marker(markerId: const MarkerId(''), position: LatLng(widget.lat!, widget.long!))},
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
                          ClipRRect(
                            borderRadius: BorderRadius.circular(1000),
                            child: Container(
                              height: AppBar().preferredSize.height * 0.7,
                              width: AppBar().preferredSize.height * 0.7,
                              decoration:
                              const BoxDecoration(shape: BoxShape.circle),
                              child: CachedNetworkImage(
                                imageUrl: widget.image!,
                                errorWidget: (_, __, ___) =>
                                    Image.asset(Images.sampleUser),
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
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
                          InkWell(
                              onTap: ()async{
                                await callOnMobile(widget.phone);
                                },child: SvgPicture.asset(Images.callPrimary)),
                          6.horizontalSpace(),
                          // SvgPicture.asset(Images.whatsapp),
                          whatsapp(widget.phone),
                          6.horizontalSpace(),
                          InkWell(
                              onTap: () async {
                                context.read<DdeEnquiryCubit>().launchURL(widget.lat.toString(),widget.long.toString(),context);
                              },
                              child: SvgPicture.asset(Images.redirectLocation)),
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