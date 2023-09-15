import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:glad/screen/custom_widget/custom_methods.dart';
import 'package:glad/utils/color_resources.dart';
import 'package:glad/utils/extension.dart';
import 'package:glad/utils/images.dart';
import 'package:glad/utils/styles.dart';

class ThankYou extends StatelessWidget {
  const ThankYou({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Stack(
        children: [
          Positioned(left: 80, child: SvgPicture.asset(Images.addRemark1)),
          Positioned(
              bottom: 0, right: 0, child: SvgPicture.asset(Images.otpBack1)),
          Padding(
            padding: const EdgeInsets.only(top: 80, right: 20, left: 20),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    SvgPicture.asset(Images.addRemark),
                  ],
                ),
                SvgPicture.asset(
                  Images.done,
                  height: 78,
                  width: 78,
                ),
                10.verticalSpace(),
                'Thank you!'
                    .textMedium(fontSize: 30, color: ColorResources.black),
                10.verticalSpace(),
                Text(
                  'Our Dairy Development Expert (DDE) will visit your farm for detailed survey.',
                  textAlign: TextAlign.center,
                  style: figtreeRegular.copyWith(fontSize: 16,color: ColorResources.black,)),
                  30.verticalSpace(),
                Stack(
                  alignment: Alignment.center,
                  children: [
                    SizedBox(
                        height: 110,
                        width: MediaQuery
                            .of(context)
                            .size
                            .width * 0.8),
                    Padding(
                      padding: const EdgeInsets.fromLTRB(0.0, 15, 10, 10),
                      child: Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20),
                          border: Border.all(
                            color: ColorResources.fieldGrey.withOpacity(0.5),
                            width: 1,
                          ),
                          boxShadow: [
                            BoxShadow(
                                color: Colors.grey.withOpacity(0.5),
                                blurRadius: 16.0,
                                offset: const Offset(0, 5))
                          ],
                          color: Colors.white,
                        ),
                        padding: const EdgeInsets.all(15.0),
                        child: Column(
                          children: [
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Image.asset(Images.sampleUser),
                                10.horizontalSpace(),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text('Matts Francesca',
                                        style: figtreeMedium.copyWith(
                                            fontSize: 16, color: Colors.black)),
                                    4.verticalSpace(),
                                    Text('+256 758711344',
                                        style: figtreeRegular.copyWith(
                                            fontSize: 14, color: Colors.black)),
                                  ],
                                ),
                              ],
                            ),
                            10.verticalSpace(),
                            const Divider(),
                            Text(
                              'You may Call or WhatsApp to our experts for any query related to the farm.',
                              textAlign: TextAlign.center,
                              style: figtreeRegular.copyWith(fontSize: 12),
                            ),
                            10.verticalSpace(),
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
                                onTap: () async {
                                  await callOnMobile(234567890);
                                },
                                child: SvgPicture.asset(Images.callPrimary)),
                            6.horizontalSpace(),
                            InkWell(
                                onTap: () async {
                                  await launchWhatsApp(234567890);
                                },
                                child: SvgPicture.asset(Images.whatsapp)),
                            16.horizontalSpace(),
                          ],
                        )),
                  ],
                ),

                40.verticalSpace(),
                customButton("Go to Home", fontColor: 0xffffffff, onTap: () {})
              ],
            ),
          )
        ],
      ),
    );
  }
}
