import 'dart:ui';

import 'package:glad/utils/color_resources.dart';

class IntroSliderModel {
  String title1;
  String title2;
  Color color;
  IntroSliderModel(
      {required this.title1,
        required this.title2,
        required this.color});
}

List<IntroSliderModel> introSliderContents = [
  IntroSliderModel(
    title1: 'Herd performance title goes here',
    title2: 'Herd performance takes a crew with the right tools sub title...',
    color: ColorResources.purple
    ),
  IntroSliderModel(
    title1: 'Title goes here, lorem ipsum dolar sit',
    title2: 'Our cows have access to clean drinking water and are fed a nutrition\'s diet...',
      color: ColorResources.mustard
    ),
];