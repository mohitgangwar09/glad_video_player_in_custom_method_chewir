import 'package:flutter/material.dart';
import 'package:glad/screen/custom_widget/custom_methods.dart';

import 'application_widget.dart';

class ApplicationScreen extends StatelessWidget {
  const ApplicationScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return customList(child: (index){
      return const Padding(
        padding: EdgeInsets.only(right: 20.0,left: 10),
        child: MCCApplicationScreen(bottom: 25,),
      );});
  }
}
