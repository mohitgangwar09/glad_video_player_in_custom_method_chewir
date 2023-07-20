import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:glad/screen/custom_widget/custom_methods.dart';
import 'package:glad/screen/drawer/guest_drawer.dart';
import 'package:glad/utils/color_resources.dart';
import 'package:glad/utils/extension.dart';
import 'package:glad/utils/images.dart';
import 'package:glad/utils/styles.dart';

class Navigation extends StatefulWidget {
  const Navigation({super.key});

  @override
  State<Navigation> createState() => _NavigationState();
}

class _NavigationState extends State<Navigation> {
  GlobalKey<ScaffoldState> key = GlobalKey();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: key,
      appBar: AppBar(
        leading: InkWell(
            onTap: () {
              key.currentState!.openDrawer();
            },
            child: Image.asset(
              Images.drawer,
              scale: 2,
            )),
      ),
      drawer: const GuestSideDrawer()
    );
  }
}
