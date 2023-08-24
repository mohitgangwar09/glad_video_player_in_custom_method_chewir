import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:glad/screen/custom_widget/custom_methods.dart';
import 'package:glad/screen/guest_user/invite_our_friend.dart';
import 'package:glad/utils/color_resources.dart';
import 'package:glad/utils/extension.dart';
import 'package:glad/utils/images.dart';
import 'package:glad/utils/styles.dart';

class DDEInArea extends StatefulWidget {
  const DDEInArea(
      {super.key,
      required this.name,
      required this.phone,
      required this.image});
  final String name;
  final String phone;
  final String image;

  @override
  State<DDEInArea> createState() => _DDEInAreaState();
}

class _DDEInAreaState extends State<DDEInArea> {

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.fromLTRB(20, 10, 0, 2),
          child: Text('Dairy Development Expert (DDE)',
              style: figtreeMedium.copyWith(fontSize: 18, color: Colors.black)),
        ),
        Padding(
          padding: const EdgeInsets.fromLTRB(20, 0, 0, 0),
          child: Text('In your area',
              style:
                  figtreeRegular.copyWith(fontSize: 14, color: Colors.black)),
        ),
        Stack(
          alignment: Alignment.center,
          children: [
            SizedBox(
                height: 110, width: MediaQuery.of(context).size.width * 0.8),
            Padding(
              padding: const EdgeInsets.fromLTRB(15.0, 15, 15, 10),
              child: Container(
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    border: Border.all(color: ColorResources.grey.withOpacity(0.5)),
                  boxShadow:[
                    BoxShadow(
                        color: Colors.grey.withOpacity(0.5),
                        blurRadius: 16.0,
                        offset: const Offset(0, 5)
                    )],
                color: Colors.white,),
                padding: const EdgeInsets.all(15.0),
                child: Column(
                  children: [
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Image.asset(Images.sampleUser),
                        15.horizontalSpace(),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(widget.name,
                                style: figtreeMedium.copyWith(
                                    fontSize: 18, color: Colors.black)),
                            4.verticalSpace(),
                            Text(widget.phone,
                                style: figtreeRegular.copyWith(
                                    fontSize: 14, color: Colors.black)),
                          ],
                        ),
                      ],
                    ),
                    20.verticalSpace(),
                    InkWell(
                      onTap: (){
                        // const InviteAnExpert().navigate();
                      },
                      child: Container(
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(180),
                            border: Border.all(color: ColorResources.yellow),
                            color: const Color(0xFFFFF3F4),
                        ),

                        padding: const EdgeInsets.symmetric(vertical: 12.0, horizontal: 26),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text('Invite our expert',
                                    style: figtreeSemiBold.copyWith(
                                        fontSize: 22, color: Colors.black)),
                                Text('to survey your farm',
                                    style: figtreeRegular.copyWith(
                                        fontSize: 14, color: Colors.black)),
                              ],
                            ),
                            Image.asset(Images.loginButton, height: 40, width: 40,),
                          ],
                        ),
                      ),
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
                        await callOnMobile(234567890);
                      }, child: SvgPicture.asset(Images.callPrimary)),
                    6.horizontalSpace(),
                    InkWell(onTap: ()async{
                      await launchWhatsApp(234567890);
                    },child: SvgPicture.asset(Images.whatsapp)),
                    16.horizontalSpace(),
                  ],
                )),
          ],
        )
      ],
    );
  }
}
