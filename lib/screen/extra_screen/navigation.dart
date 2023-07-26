import 'package:flutter/material.dart';
import 'package:glad/screen/dde_screen/dashboard/bottom_navigation_dde.dart';
import 'package:glad/screen/farmer_screen/dashboard/bottom_navigation_farmer.dart';
import 'package:glad/screen/mcc_screen/dashboard/bottom_navigation_mcc.dart';
import 'package:glad/screen/supplier_screen/dashboard/bottom_navigation_supplier.dart';
import 'package:glad/screen/drawer/guest_drawer.dart';
import 'package:glad/utils/extension.dart';
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

              const BottomNavigationSupplierScreen().navigate();

            }, child: Text("Service Provider",style: figtreeBold.copyWith(
                color: Colors.black,
                fontSize: 16
            ))),

            TextButton(onPressed: (){

              const BottomNavigationFarmerScreen().navigate();

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
