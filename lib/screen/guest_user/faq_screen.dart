import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:glad/screen/custom_widget/custom_appbar.dart';
import 'package:glad/screen/custom_widget/custom_methods.dart';
import 'package:glad/utils/extension.dart';
import 'package:glad/utils/images.dart';
import 'package:glad/utils/styles.dart';

class FaqScreen extends StatelessWidget {
  const FaqScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      child: Stack(
        children: [
          landingBackground(),
          Column(
            children: [
              CustomAppBar(
                context: context,
                titleText1: "FAQ's",
                centerTitle: true,
                leading: openDrawer(
                    onTap: () {
                    },
                    child: SvgPicture.asset(Images.arrowBack))
              ),

              SizedBox(
                height: 45,
                child: customList(
                    list: [1,2,3],
                    axis: Axis.horizontal,
                    child:(index) {
                      return Container(
                          margin: 5.marginAll(),
                          padding: const EdgeInsets.only(
                              left: 14, right: 14, bottom: 10, top: 10),
                          decoration: boxDecoration(
                              borderColor: const Color(0xffDCDCDC),
                              borderRadius: 30),
                          child: const Text("Trending"));
                    }
                ),
              ),

              landingPage(context),
            ],
          ),
        ],
      ),
    );
  }

  Widget landingPage(BuildContext context){
    return Expanded(
      child: SingleChildScrollView(
        child: customList(
            padding: const EdgeInsets.fromLTRB(13,13,13,120),
            list: [1, 2, 3, 4, 5, 6, 7],
            child: (index){
              return Padding(
                padding: const EdgeInsets.only(bottom: 12.0),
                child: customShadowContainer(
                  margin: 0,
                  boxShadow: false,
                  backColor: Colors.grey.withOpacity(0.4),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [

                      Expanded(
                        child: Padding(
                          padding: const EdgeInsets.only(left: 28.0,top: 15),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                  'Lorem is simply dummy of the printing and industry?',
                                  maxLines: 4,
                                  overflow: TextOverflow.ellipsis,
                                  style: figtreeMedium.copyWith(
                                      fontSize: 16, color: Colors.black),
                                  softWrap: true),
                              16.verticalSpace(),
                            ],
                          ),
                        ),
                      ),

                      const Padding(
                        padding: EdgeInsets.only(top: 8.0,left: 5),
                        child: CircleAvatar(radius: 18,
                          backgroundColor: Color(0xffC788A5),
                        child: Padding(
                          padding: EdgeInsets.only(bottom: 20.0),
                          child: Icon(Icons.minimize,
                          color: Colors.white,),
                        ),),
                      ),

                      10.horizontalSpace()

                    ],
                  ),
                ),
              );
            }),
      ),
    );
  }

}