import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:glad/screen/custom_widget/custom_methods.dart';
import 'package:glad/screen/dashboard/bottom_navigation_dde.dart';
import 'package:glad/screen/dashboard/bottom_navigation_mcc.dart';
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
            },)
      ),
      body: SizedBox(
        width: screenWidth(),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            TextButton(onPressed: (){
              const BottomNavigationDDEScreen().navigate();
            }, child: Text("DDE",style: figtreeBold.copyWith(
              color: Colors.black,
              fontSize: 16
            ))),

            TextButton(onPressed: (){

            }, child: Text("Service Provider",style: figtreeBold.copyWith(
                color: Colors.black,
                fontSize: 16
            ))),

            TextButton(onPressed: (){

            }, child: Text("Farmer",style: figtreeBold.copyWith(
                color: Colors.black,
                fontSize: 16
            ))),


            TextButton(onPressed: (){
              const BottomNavigationMCCScreen().navigate();
            }, child: Text("MCC",style: figtreeBold.copyWith(
                color: Colors.black,
                fontSize: 16
            ))),

          ],
        ),
      ),
      drawer: const GuestSideDrawer()
    );
  }
}
