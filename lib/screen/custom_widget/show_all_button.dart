import 'package:flutter/material.dart';
import 'package:glad/utils/color_resources.dart';
import 'package:glad/utils/styles.dart';

class ShowAllButton extends StatelessWidget {
  const ShowAllButton({super.key, required this.onTap});
  final void Function() onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(50),
            border: Border.all(color: ColorResources.purple),
            color: ColorResources.purple),
        padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 10),
        child: Text('Show All',
            style: figtreeSemiBold.copyWith(fontSize: 12, color: Colors.white)),
      ),
    );
  }
}
