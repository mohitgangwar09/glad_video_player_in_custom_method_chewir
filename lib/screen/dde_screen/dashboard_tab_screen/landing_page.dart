import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:glad/screen/common/community_forum.dart';
import 'package:glad/screen/common/featured_trainings.dart';
import 'package:glad/screen/common/landing_carousel.dart';
import 'package:glad/screen/common/livestock_marketplace.dart';
import 'package:glad/screen/common/mcc_in_area.dart';
import 'package:glad/screen/common/trending_news.dart';
import 'package:glad/screen/custom_widget/custom_appbar.dart';
import 'package:glad/screen/custom_widget/custom_methods.dart';
import 'package:glad/screen/guest_user/drawer_screen.dart';
import 'package:glad/screen/dde_screen/dde_profile.dart';
import 'package:glad/utils/color_resources.dart';
import 'package:glad/utils/extension.dart';
import 'package:glad/utils/helper.dart';
import 'package:glad/utils/images.dart';
import 'package:glad/utils/styles.dart';
import 'package:table_calendar/table_calendar.dart';
import '../../auth_screen/login_with_password.dart';
import '../dashboard/dashboard_dde.dart';

class DDELandingPage extends StatelessWidget {
  const DDELandingPage({super.key});

  @override
  Widget build(BuildContext context) {

    CalendarFormat calendarFormat = CalendarFormat.week;
    RangeSelectionMode rangeSelectionMode = RangeSelectionMode.toggledOff;

    return Container(
      color: Colors.white,
      child: Stack(
        children: [

          landingBackground(),

          Column(
            children: [
              CustomAppBar(
                context: context,
                titleText1: 'Hello ',
                titleText2: 'Abdullah',
                leading: openDrawer(
                    onTap: () {
                      ddeLandingKey.currentState?.openDrawer();
                    },
                    child: SvgPicture.asset(Images.drawer)),
                action: Row(
                  children: [
                    InkWell(onTap: () {}, child: SvgPicture.asset(Images.call)),
                    7.horizontalSpace(),
                    InkWell(
                        onTap: () {
                          const GladProfile().navigate();
                        },
                        child: SvgPicture.asset(Images.person)),
                    8.horizontalSpace(),
                  ],
                ),
                richTitle: true,
              ),
              landingPage(calendarFormat),

            ],
          ),

        ],
      ),
    );
  }


  Widget landingPage(calendarFormat){
    return Expanded(
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const LandingCarousel(),
            10.verticalSpace(),

          farmersNearMe(),

          Container(
            margin: const EdgeInsets.only(left: 20,right: 20),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              color: const Color(0xffE4FFE3),
              border: Border.all(color: const Color(0xffECECFF))
            ),
            child: Column(
              children: [

                Padding(
                  padding: const EdgeInsets.only(left: 5,right: 5,bottom: 5),
                  child: TableCalendar(
                    headerStyle: const HeaderStyle(
                      leftChevronIcon: Icon(Icons.arrow_back,
                      color: Colors.black,),
                      rightChevronIcon: CircleAvatar(
                        radius: 18,
                        backgroundColor: Colors.grey,
                        child: Icon(Icons.arrow_forward_rounded,
                          color: Colors.black,),
                      ),
                      formatButtonVisible: false
                    ),
                    firstDay: DateTime.utc(2010, 10, 16),
                    lastDay: DateTime.utc(2030, 3, 14),
                    focusedDay: DateTime.now(),
                    calendarFormat: calendarFormat,
                    startingDayOfWeek: StartingDayOfWeek.sunday,
                    calendarStyle: CalendarStyle(
                      selectedDecoration: BoxDecoration(
                          color: ColorResources.primary,
                          borderRadius: BorderRadiusDirectional.circular(30)),
                    ),
                  ),
                ),

                Stack(
                  children: [
                    Container(
                      // height: 105,
                      // padding: 10.paddingAll(),
                      width: screenWidth(),
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(20)),
                      child: Padding(
                        padding: const EdgeInsets.fromLTRB(12.0, 20, 12, 22),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Image.asset(Images.sampleUser),
                            15.horizontalSpace(),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text("Begumanya Charles",
                                    style: figtreeMedium.copyWith(
                                        fontSize: 16, color: Colors.black)),
                                4.verticalSpace(),

                                "Visit schedule for today".textRegular(fontSize: 12),

                                10.verticalSpace(),

                                Row(
                                  crossAxisAlignment: CrossAxisAlignment.end,
                                  children: [
                                    'Project: '.textRegular(color: Colors.grey,
                                    fontSize: 12),
                                    Text("Dam Construction",
                                        style: figtreeRegular.copyWith(
                                            fontSize: 12, color: Colors.black)),
                                  ],
                                ),
                                4.verticalSpace(),
                                Row(
                                  crossAxisAlignment: CrossAxisAlignment.end,
                                  children: [
                                    const Icon(
                                      Icons.location_on,
                                      color: Colors.black,
                                      size: 16,
                                    ),
                                    SizedBox(
                                      width:
                                      screenWidth() * 0.5,
                                      child: Text(
                                        "Plot 11, Street 09, Luwum St.Rwo",
                                        style: figtreeRegular.copyWith(
                                          fontSize: 12,
                                          color: Colors.black,
                                          overflow: TextOverflow.ellipsis,
                                        ),
                                      ),
                                    ),
                                  ],
                                )
                              ],
                            )
                          ],
                        ),
                      ),
                    ),

                    Padding(
                      padding: const EdgeInsets.all(12.0),
                      child: Align(alignment: Alignment.topRight,
                        child: "9:00 am".textRegular(color: Colors.grey,
                        fontSize: 12),),
                    )
                  ],
                ),

              ],
            ),
          ),

          const LiveStockMarketplace(),
            10.verticalSpace(),
            const CommunityForum(
              name: 'Begumanya Charles',
              location: 'Kampala, Uganda',
              image: '',
              caption: 'Lorem Ipsum has been the industry\'s standard dummy text ever since the 1500s, when an unknown printer took a galley.',
              video: '',
              timeAgo: '5 Hrs ago',
            ),
            10.verticalSpace(),
            const FeaturedTrainings(),
            10.verticalSpace(),
            const MCCInArea(
              name: 'Begumanya Charles',
              phone: '+256 758711344',
              address:
              'Plot 11, street 09, Luwum St. Rwooz Plot 11, street 09, Luwum St. Rwooz',
              image: '',
            ),
            10.verticalSpace(),
            const TrendingNewsAndEvents(),
            100.verticalSpace(),
          ],
        ),
      ),
    );
  }
  
  Widget farmersNearMe(){
    return Padding(
      padding: const EdgeInsets.only(left: 20.0,right: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [

          "Farmers near me".textMedium(fontSize: 18),

          15.verticalSpace(),

          SizedBox(
            height: 100,
            child: customList(
                axis: Axis.horizontal,
                child: (int index){
              return Padding(
                padding: const EdgeInsets.only(right: 12.0),
                child: customShadowContainer(
                    margin: 0,
                    backColor: const Color(0xffFF8A8B),
                    width: 105,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [

                        const Align(
                          alignment: Alignment.centerRight,
                          child: Padding(
                            padding: EdgeInsets.all(8.0),
                            child: CircleAvatar(
                              radius: 13,
                              backgroundColor: Colors.red,
                              child: Icon(Icons.error,size: 17,),
                            ),
                          ),
                        ),

                        Padding(
                          padding: const EdgeInsets.only(left: 16.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [

                              "04".textSemiBold(fontSize: 26),

                              "Critical".textRegular(fontSize: 12),

                            ],
                          ),
                        )

                      ],
                    )),
              );
            }),
          ),

          37.verticalSpace(),

        ],
      ),
    );
  }


}
