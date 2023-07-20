import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:glad/utils/color_resources.dart';
import 'package:glad/utils/extension.dart';
import 'package:glad/utils/images.dart';
import 'package:glad/utils/styles.dart';

class LivestockDetails extends StatelessWidget {
  const LivestockDetails({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16), color: Colors.white),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Image.asset(Images.sampleLivestock),
          Padding(
            padding: const EdgeInsets.all(12.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                RichText(
                    text: TextSpan(children: [
                      TextSpan(
                          text: 'Nsonga cow ',
                          style: figtreeMedium.copyWith(
                              fontSize: 12,
                              color: Colors.black)),
                      TextSpan(
                          text: '(N0987)',
                          style: figtreeMedium.copyWith(
                              fontSize: 12, color: const Color(0xFF727272)))
                    ])),
                6.verticalSpace(),
                Text(
                    'UGX 4.5M',
                    style: figtreeSemiBold.copyWith(
                        fontSize: 18,
                        color: Colors.black)),
                12.verticalSpace(),
                Row(
                  children: [
                    RichText(
                        text: TextSpan(children: [
                          TextSpan(
                              text: 'Age: ',
                              style: figtreeMedium.copyWith(
                                  fontSize: 12,
                                  color: const Color(0xFF727272))),
                          TextSpan(
                              text: '04 yrs',
                              style: figtreeMedium.copyWith(
                                  fontSize: 12, color: Colors.black)),
                        ])),
                    10.horizontalSpace(),
                    Container(height: 5, width: 5, decoration: const BoxDecoration(color: Colors.black, shape: BoxShape.circle),),
                    10.horizontalSpace(),
                    RichText(
                        text: TextSpan(children: [
                          TextSpan(
                              text: 'Milk: ',
                              style: figtreeMedium.copyWith(
                                  fontSize: 12,
                                  color: const Color(0xFF727272))),
                          TextSpan(
                              text: '16L/day',
                              style: figtreeMedium.copyWith(
                                  fontSize: 12, color: Colors.black))
                        ])),
                  ],
                ),
                6.verticalSpace(),
                Text(
                    'Kampala, Uganda',
                    style: figtreeMedium.copyWith(
                        fontSize: 12,
                        color: Colors.black)),
                12.verticalSpace(),
                Row(
                  children: [
                    Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(26),
                        border: Border.all(color: const Color(0xFFFC5E60)),),
                      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                      child: SvgPicture.asset(Images.chatBubble),
                    ),
                    6.horizontalSpace(),
                    Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(50),
                        border: Border.all(color: ColorResources.purple),),
                      padding: const EdgeInsets.symmetric(vertical: 12.0, horizontal: 12),
                      child: Text('Add to Cart',
                          style: figtreeMedium.copyWith(
                              fontSize: 14, color: Colors.black)),
                    )
                  ],
                )
              ],
            ),
          )

        ],
      ),
    );
  }
}
