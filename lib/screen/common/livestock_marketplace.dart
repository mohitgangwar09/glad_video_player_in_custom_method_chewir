import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:glad/screen/custom_widget/custom_methods.dart';
import 'package:glad/screen/custom_widget/livestock_details.dart';
import 'package:glad/screen/custom_widget/show_all_button.dart';
import 'package:glad/utils/color_resources.dart';
import 'package:glad/utils/extension.dart';
import 'package:glad/utils/images.dart';
import 'package:glad/utils/styles.dart';

class LiveStockMarketplace extends StatelessWidget {
  const LiveStockMarketplace({super.key, required this.onTapShowAll});
  final void Function() onTapShowAll;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.fromLTRB(20, 10, 20, 2),
          child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,

            children: [
              Text('Livestock Marketplace',
                  style: figtreeMedium.copyWith(fontSize: 18, color: Colors.black)),
              ShowAllButton(onTap: onTapShowAll)
            ],
          ),
        ),
        10.verticalSpace(),
        SizedBox(
          height: 318,
          child: customList(
            list: List.generate(4, (index) => ''),
              padding: 10.marginLeft(),
              axis: Axis.horizontal,
              child: (index){
                return const LivestockDetails();
              }
        )),
      ],
    );
  }
}