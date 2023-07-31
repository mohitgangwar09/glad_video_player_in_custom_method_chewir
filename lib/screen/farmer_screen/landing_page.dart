import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:glad/screen/common/community_forum.dart';
import 'package:glad/screen/common/dde_in_area.dart';
import 'package:glad/screen/common/featured_trainings.dart';
import 'package:glad/screen/common/landing_carousel.dart';
import 'package:glad/screen/common/livestock_marketplace.dart';
import 'package:glad/screen/common/mcc_in_area.dart';
import 'package:glad/screen/common/review.dart';
import 'package:glad/screen/common/trending_news.dart';
import 'package:glad/screen/custom_widget/custom_methods.dart';
import 'package:glad/screen/custom_widget/show_all_button.dart';
import 'package:glad/screen/farmer_screen/common/widegt/project_widget.dart';
import 'package:glad/screen/farmer_screen/dashboard/dashboard_farmer.dart';
import 'package:glad/screen/farmer_screen/profile/farmer_profile.dart';
import 'package:glad/utils/color_resources.dart';
import 'package:glad/utils/extension.dart';
import 'package:glad/utils/images.dart';
import 'package:glad/utils/styles.dart';

class FarmerLandingPage extends StatelessWidget {
  const FarmerLandingPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    return Container(
      color: Colors.white,
      child: Stack(
        children: [

          landingBackground(),

          Padding(
            padding: EdgeInsets.only(top: screenHeight()>750?40.0:20),
            child: Column(
              children: [

                customAppBar('Hello ', 'Abdullah', onTapDrawer: (){
                  farmerLandingKey.currentState?.openDrawer();
                }, onTapProfile: (){
                  const FarmerProfile().navigate();
                },drawerVisibility: true),

                landingPage(context),

              ],
            ),
          ),

        ],
      ),
    );
  }


  Widget landingPage(context){
    return Expanded(
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [

            const LandingCarousel(),

            10.verticalSpace(),

            Padding(
              padding: const EdgeInsets.only(right: 20.0,bottom: 25),
              child: customGrid(
                  context,
                  mainAxisExtent: 185,
                  crossAxisSpacing: 0,
                  child: (int index) {
                return customProjectContainer(
                      width: screenWidth(),
                      child: Stack(
                        children: [
                          Align(
                            alignment: Alignment.center,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [

                                "18 K ltr.".textMedium(fontSize: 22),

                                Container(
                                  width: 70,
                                  margin: 10.marginAll(),
                                  padding: const EdgeInsets.symmetric(vertical: 4,horizontal: 7),
                                  decoration: boxDecoration(
                                    borderRadius: 30,
                                    backgroundColor: const Color(0xffE4FFE3),
                                  ),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [

                                      "30%".textSemiBold(color: const Color(0xff4BC56F)),

                                      const Icon(Icons.trending_up,color: Color(0xff4BC56F),size: 20,),

                                    ],
                                  ),
                                ),

                                12.verticalSpace(),

                                "Milking cows".textMedium(fontSize: 16),

                                7.verticalSpace(),

                                "05 Breeds".textMedium(fontSize: 12,color: const Color(0xff727272))

                              ],
                            ),
                          ),
                          Align(
                              alignment: Alignment.topRight,
                              child: Padding(
                                padding: const EdgeInsets.only(right: 14.0,top: 9),
                                child: SvgPicture.asset(Images.menuIcon),
                              )),
                        ],
                      ));
              }),
            ),

            Padding(
              padding: const EdgeInsets.fromLTRB(20, 10, 20, 0),
              child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,

                children: [
                  'Suggested Investment'.textMedium(fontSize: 18),

                  ShowAllButton(onTap: () {})
                ],
              ),
            ),

            Container(
              margin: 20.marginRight(),
              height: 242,
              child: customList(axis: Axis.horizontal,child: (int i) {
                return customProjectContainer(child: const ProjectWidget(status: true,),width: screenWidth()-53);
              }),
            ),

            10.verticalSpace(),

            const MCCInArea(
              name: 'Begumanya Charles',
              phone: '+256 758711344',
              address:
              'Plot 11, street 09, Luwum St. Rwooz Plot 11, street 09, Luwum St. Rwooz',
              image: '',
            ),

            35.verticalSpace(),

            const DDEInArea(
              name: 'Begumanya Charles',
              phone: '+256 758711344',
              image: '',
            ),

            topPerformingFarmer(),

            35.verticalSpace(),

            const LiveStockMarketplace(),

            10.verticalSpace(),

            const CommunityForum(
              name: 'Begumanya Charles',
              location: '+256 758711344',
              image: '',
              caption: 'Lorem Ipsum has been the industry\'s standard dummy text ever since the 1500s, when an unknown printer took a galley.',
              video: '',
              timeAgo: '5 Hrs ago',
            ),

            10.verticalSpace(),

            const FeaturedTrainings(),

            10.verticalSpace(),

            const TrendingNewsAndEvents(),

            10.verticalSpace(),

            const GladReview(),

            100.verticalSpace()

          ],
        ),
      ),
    );
  }

  Widget topPerformingFarmer(){
    return Padding(
      padding: const EdgeInsets.only(left: 20.0,top: 30,right: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [

          "Top performing farmers".textMedium(fontSize: 18),

          25.verticalSpace(),

          SizedBox(
            height: 350,
            child: customList(
                axis: Axis.horizontal,
                child: (int index){
              return Padding(
                padding: const EdgeInsets.only(right: 20.0),
                child: Stack(
                  children: [
                    Container(
                      margin: 30.marginTop(),
                      height: 310,
                      width: screenWidth()-140,
                      decoration: boxDecoration(
                          borderRadius: 18,
                          backgroundColor: const Color(0xffF9F9F9)
                      ),
                    ),

                    Positioned(
                        left: 0,
                        right: 0,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [

                            CircleAvatar(
                                radius: 35,
                                child: Image.asset(Images.sampleUser,fit: BoxFit.cover,width: 70,height: 70)),

                            20.verticalSpace(),

                            "Hurton Elizabeth".textMedium(color: Colors.black,fontSize: 16),

                            4.verticalSpace(),

                            "1234 NW Bobcat Lane, St".textRegular(color: const Color(0xff727272)),

                            22.verticalSpace(),

                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [

                                RichText(
                                  text: TextSpan(
                                    text: 'Milking Cows: ',
                                    style: figtreeRegular.copyWith(
                                        color: const Color(0xff727272)
                                    ),
                                    children: <TextSpan>[

                                      TextSpan(
                                          text: '30',style: figtreeSemiBold.copyWith(
                                          color: const Color(0xff23262A)
                                      )),

                                    ],
                                  ),
                                ),

                                10.horizontalSpace(),

                                const CircleAvatar(
                                  radius: 4,
                                  backgroundColor: Color(0xff23262A),
                                ),

                                10.horizontalSpace(),

                                RichText(
                                  text: TextSpan(
                                    text: 'Yield: ',
                                    style: figtreeRegular.copyWith(
                                        color: const Color(0xff727272)
                                    ),
                                    children: <TextSpan>[

                                      TextSpan(
                                          text: '15 LTR',style: figtreeSemiBold.copyWith(
                                          color: const Color(0xff23262A)
                                      )),

                                    ],
                                  ),
                                ),

                              ],
                            ),

                            23.verticalSpace(),

                            Stack(
                              children: [

                                CircleAvatar(
                                    radius: 25,
                                    child: Image.asset(Images.sampleUser,fit: BoxFit.cover,width: 70,height: 70)),

                                Padding(
                                  padding: const EdgeInsets.only(left: 40.0),
                                  child: CircleAvatar(
                                      radius: 25,
                                      child: Image.asset(Images.sampleUser,fit: BoxFit.cover,width: 70,height: 70)),
                                ),

                                Padding(
                                  padding: const EdgeInsets.only(left: 80.0),
                                  child: CircleAvatar(
                                      radius: 25,
                                      child: Image.asset(Images.sampleUser,fit: BoxFit.cover,width: 70,height: 70)),
                                ),

                              ],
                            ),

                            Container(
                              margin:20.marginTop(),
                              width: 110,
                              height: 45,
                              child: customButton("Compare",
                                  borderColor: 0xFF6A0030 ,
                                  color: 0xFFffffff,
                                  fontColor: 0xFF6A0030,
                                  onTap: (){}
                              ),
                            )

                          ],
                        )),
                  ],
                ),
              );
            }),
          ),

        ],
      ),
    );
  }
}