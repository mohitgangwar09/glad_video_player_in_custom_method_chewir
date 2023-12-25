import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:glad/cubit/dde_enquiry_cubit/dde_enquiry_cubit.dart';
import 'package:glad/cubit/dde_farmer_cubit/dde_farmer_cubit.dart';
import 'package:glad/cubit/landing_page_cubit/landing_page_cubit.dart';
import 'package:glad/cubit/profile_cubit/profile_cubit.dart';
import 'package:glad/cubit/project_cubit/project_cubit.dart';
import 'package:glad/screen/custom_widget/custom_appbar.dart';
import 'package:glad/screen/custom_widget/custom_methods.dart';
import 'package:glad/screen/dde_screen/dashboard/dashboard_dde.dart';
import 'package:glad/screen/dde_screen/dde_farmer_detail.dart';
import 'package:glad/screen/dde_screen/dde_farmer_filter.dart';
import 'package:glad/screen/dde_screen/suggested_investment.dart';
import 'package:glad/utils/color_resources.dart';
import 'package:glad/utils/extension.dart';
import 'package:glad/utils/helper.dart';
import 'package:glad/utils/images.dart';
import 'package:glad/utils/styles.dart';

class FarmerDdeTabScreen extends StatefulWidget {
  const FarmerDdeTabScreen({Key? key}) : super(key: key);

  @override
  State<FarmerDdeTabScreen> createState() => _FarmerDdeTabScreenState();
}

class _FarmerDdeTabScreenState extends State<FarmerDdeTabScreen> {

  String countryCode = "";
  bool search = false;
  TextEditingController searchEditingController = TextEditingController();

  void getCountryCode() async{
    String countryCodes = await BlocProvider.of<ProfileCubit>(context).getCountryCode();
    countryCode = countryCodes;
  }

  @override
  void initState(){
    super.initState();
    BlocProvider.of<DdeFarmerCubit>(context).getFarmer(context, '${BlocProvider.of<DdeFarmerCubit>(context).state.selectedRagRatingType}'.toLowerCase(), true);
    getCountryCode();
  }

  Color ragColor(String ragRating) {
    switch (ragRating) {
      case 'critical' : return const Color(0xffFC5E60);
      case 'average' : return const Color(0xffF6B51D);
      case 'satisfactory' : return const Color(0xff12CE57);
      // case 'mature' : return ColorResources.maroon;
      default: return Colors.white;
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<DdeFarmerCubit,DdeState>(builder: (context,state){
      if (state.status == DdeFarmerStatus.loading) {
        return const Center(
            child: CircularProgressIndicator(
              color: ColorResources.maroon,
            ));
      }else if(state.response == null){
       return "${state.response} Api Error".textMedium();
      }
      return Stack(
        children: [
          landingBackground(),
          hideKeyboard(
            context,
            child: Column(
              children: [
                CustomAppBar(
                  context: context,
                  titleText1: "Farmers",
                  action: Row(
                    children: [
                      InkWell(
                          onTap: () {

                            List<String> breedFilterList = [
                              'Default',
                              'Yield Per Cow Highest to Lowest',
                              'Yield Per Cow Lowest to Highest',
                              'Dairy Area Highest to Lowest',
                              'Dairy Area Lowest to Highest',
                              'Farm Size Highest to Lowest',
                              'Farm Size Lowest to Highest',
                              'Milk Supply Highest to Lowest',
                              'Milk Supply Lowest to Highest',
                              'Milking Cow Highest to Lowest',
                              'Milking Cow Lowest to Highest',
                            ];
                            List<String> breedRequestToApi = [
                              '',
                              'yield_per_cow_desc',
                              'yield_per_cow_asc',
                              'dairy_area_desc',
                              'dairy_area_asc',
                              'farm_size_desc',
                              'farm_size_asc',
                              'milk_supply_desc',
                              'milk_supply_asc',
                              'milking_cows_desc',
                              'milking_cows_asc'
                            ];

                            modalBottomSheetMenu(
                                context, child:
                            StatefulBuilder(
                              builder: (BuildContext contexts, void Function(void Function()) setState) {
                                return SizedBox(
                                  height: screenHeight()*0.65,
                                  child: Column(
                                    children: [

                                      Padding(
                                        padding: const EdgeInsets.only(left: 8.0,right: 8),
                                        child: Row(
                                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                          children: [

                                            TextButton(onPressed: (){
                                              pressBack();
                                            }, child: "Cancel".textMedium(color: const Color(0xff6A0030),fontSize: 14)),

                                            "Sort By".textMedium(fontSize: 22),

                                            TextButton(onPressed: (){},child: "Reset".textMedium(color: const Color(0xff6A0030),fontSize: 14))

                                          ],
                                        ),
                                      ),

                                      const Padding(
                                        padding: EdgeInsets.only(left: 20.0,right: 20),
                                        child: Divider(),
                                      ),

                                      Expanded(
                                        child: customList(list: breedFilterList,child: (index){
                                          return Padding(padding: const EdgeInsets.only(left: 30,right: 30,top:30,bottom: 10),
                                              child: Row(
                                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                children: [
                                                  InkWell(onTap: (){
                                                    setState(() {});
                                                    BlocProvider.of<DdeFarmerCubit>(context).breedOrderByFilter(breedRequestToApi[index].toString());
                                                    BlocProvider.of<DdeFarmerCubit>(context).getFarmer(context, '${BlocProvider.of<DdeFarmerCubit>(context).state.selectedRagRatingType}'.toLowerCase(), false);
                                                    pressBack();
                                                  },child: breedFilterList[index].toString().textRegular(fontSize: 16)),
                                                  state.breedFilter == breedRequestToApi[index].toString()?
                                                  const Icon(Icons.check,color: Colors.red,):const SizedBox.shrink()
                                                ],
                                              ));
                                        }),
                                      ),

                                      10.verticalSpace(),

                                      Container(margin: 20.marginAll(),height: 55,width: screenWidth(),child: customButton("Apply",fontColor: 0xffffffff, onTap: (){}))


                                    ],
                                  ),
                                );
                              },
                            ));
                          }, child: SvgPicture.asset(Images.filter2)),
                      13.horizontalSpace(),
                      InkWell(
                          onTap: () {
                            const FilterDDEFarmer().navigate();
                          }, child: SvgPicture.asset(Images.filter1)),
                      18.horizontalSpace(),
                      search == true?
                      Stack(
                        children: [
                          Container(
                            height: 50,
                            decoration: boxDecoration(
                                borderColor: Colors.grey,
                                borderRadius: 62,
                                backgroundColor: Colors.white),
                            width: screenWidth()-16,
                            child: Row(
                              children: [
                                13.horizontalSpace(),
                                SvgPicture.asset(Images.searchLeft),
                                13.horizontalSpace(),
                                Expanded(
                                    child: TextField(
                                      controller: searchEditingController,
                                      onChanged: (value){
                                        BlocProvider.of<DdeFarmerCubit>(context).getFarmer(context, '${BlocProvider.of<DdeFarmerCubit>(context).state.selectedRagRatingType}'.toLowerCase(), false,searchQuery: value.toString());
                                      },
                                      decoration: const InputDecoration(
                                          border: InputBorder.none, hintText: "Search"),
                                    )),
                              ],
                            ),
                          ),
                          Positioned(top: 0,bottom: 0,right:7,child: IconButton(
                              onPressed: () {
                                setState(() {
                                  search = false;
                                  searchEditingController.clear();
                                  BlocProvider.of<DdeFarmerCubit>(context).getFarmer(context, '${BlocProvider.of<DdeFarmerCubit>(context).state.selectedRagRatingType}'.toLowerCase(), false,searchQuery: '');
                                });
                              },
                              icon: const Icon(Icons.clear)))
                        ],
                      ):const SizedBox.shrink(),

                      search == false?
                      InkWell(
                        onTap: (){
                          setState(() {
                            search = true;
                            // BlocProvider.of<ProjectCubit>(context).ddeProjectsApi(context, selectedFilter, false,searchQuery:'');
                          });
                        },
                        child: Container(
                            width: 35,
                            height: 35,
                            decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                border: Border.all(color: const Color(0xffDCDCDC))
                            ),
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: SvgPicture.asset(Images.search,width: 23,height: 23,),
                            )
                        ),
                      ):const SizedBox.shrink()
                    ],
                  ),
                  leading: openDrawer(
                      onTap: () {
                        ddeLandingKey.currentState?.openDrawer();
                      },
                      child: SvgPicture.asset(Images.drawer)),
                ),
                /*Container(
                  margin: const EdgeInsets.only(
                      left: 20, right: 20, bottom: 13, top: 23),
                  height: 50,
                  decoration: boxDecoration(
                      borderColor: Colors.grey,
                      borderRadius: 62,
                      backgroundColor: Colors.white),
                  width: screenWidth(),
                  child: Row(
                    children: [
                      13.horizontalSpace(),
                      SvgPicture.asset(Images.searchLeft),
                      13.horizontalSpace(),
                      const Expanded(
                          child: TextField(
                            decoration: InputDecoration(
                                border: InputBorder.none, hintText: "Search"),
                          )),
                    ],
                  ),
                ),*/
                SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Container(
                    margin: const EdgeInsets.only(
                        left: 18, right: 7, bottom: 20, top: 10),
                    child: Row(
                      children: [
                        ragRatingButton(context, 'Critical', state.response!.ragRatingCount!.critical.toString(), state.selectedRagRatingType == 'critical', const Color(0xffFC5E60)),
                        ragRatingButton(context, 'Average', state.response!.ragRatingCount!.average.toString(), state.selectedRagRatingType == 'average', const Color(0xffF6B51D)),
                        ragRatingButton(context, 'Satisfactory', state.response!.ragRatingCount!.satisfactory.toString(), state.selectedRagRatingType == 'satisfactory', const Color(0xff12CE57)),
                        // ragRatingButton(context, 'Mature', state.response!.ragRatingCount!.mature.toString(), state.selectedRagRatingType == 'mature', ColorResources.maroon),
                      ],
                    ),
                  ),
                ),
                state.response!.farmerMAster!.isNotEmpty ? Expanded(
                  child: SingleChildScrollView(
                    padding: const EdgeInsets.only(bottom: 120, left: 0),
                    child: customList(list: state.response!.farmerMAster!,child: (int i) {
                      return Padding(
                        padding: const EdgeInsets.only(
                            left: 10, right: 20, bottom: 12),
                        child: Stack(
                          children: [
                            InkWell(
                              onTap: (){
                                BlocProvider.of<LandingPageCubit>(context).getCurrentLocation();
                                BlocProvider.of<ProfileCubit>(context).emit(ProfileCubitState.initial());
                                DdeFarmerDetail(userId: state.response!.farmerMAster![i].userId!,farmerId:state.response!.farmerMAster![i].id!).navigate();
                              },
                              child: customProjectContainer(
                                child: Padding(
                                  padding:
                                  const EdgeInsets.fromLTRB(15.0, 20, 0, 0),
                                  child: Column(
                                    children: [
                                      Row(
                                        crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                        children: [
                                          state.response!.farmerMAster![i].photo == null ?Image.asset(Images.sampleUser):
                                          networkImage(text: state.response!.farmerMAster![i].photo!,height: 46,width: 46,radius: 40),
                                          15.horizontalSpace(),
                                          Column(
                                            crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                            children: [
                                              Row(
                                                children: [
                                                  Text(state.response!.farmerMAster![i].name!,
                                                      style: figtreeMedium.copyWith(
                                                          fontSize: 16,
                                                          color: Colors.black)),

                                                  if(state.response!.farmerMAster![i].farmerRating!=null)
                                                    Row(
                                                      children: [

                                                        4.horizontalSpace(),
                                                        (state.response!.farmerMAster![i].farmerRating!=null?
                                                        state.response!.farmerMAster![i].farmerRating!.toStringAsFixed(2):"").textRegular(),

                                                        RatingBar.builder(
                                                            initialRating: 1,
                                                            glowColor: Colors.amber,
                                                            minRating: 1,
                                                            allowHalfRating: true,
                                                            itemCount: 1,
                                                            itemSize: 20,
                                                            ignoreGestures: true,
                                                            itemBuilder: (context, _) =>
                                                            const Icon(Icons.star, color: Color(0xffF6B51D)),
                                                            onRatingUpdate: (rating) {
                                                              print(rating);
                                                            }),

                                                        "{${state.response!.farmerMAster![i].farmerRatingCount!=null?
                                                        state.response!.farmerMAster![i].farmerRatingCount!.toString():""}}".textRegular()

                                                      ],
                                                    )
                                                ],
                                              ),
                                              4.verticalSpace(),
                                              Row(
                                                children: [
                                                  Text(
                                              "${countryCode == ""? "":countryCode!=null?countryCode.toString():""} ${state.response!.farmerMAster![i].phone.toString()}"
                                                      ,
                                                      style:
                                                      figtreeRegular.copyWith(
                                                          fontSize: 12,
                                                          color: Colors.black)),
                                                  10.horizontalSpace(),
                                                  Container(
                                                    height: 5,
                                                    width: 5,
                                                    decoration: const BoxDecoration(
                                                        color: Colors.black, shape: BoxShape.circle),
                                                  ),
                                                  10.horizontalSpace(),

                                                  Text(state.response!.farmerMAster![i].farmingExperience !=null?
                                                      "${state.response!.farmerMAster![i].farmingExperience == "0000-00-00"? '0':getAge(DateTime.parse(state.response!.farmerMAster![i].farmingExperience.toString()))} exp":"0 exp",
                                                      style: figtreeMedium.copyWith(fontSize: 12,)),

                                                ],
                                              ),
                                              4.verticalSpace(),
                                              Row(
                                                crossAxisAlignment:
                                                CrossAxisAlignment.end,
                                                children: [
                                                  SizedBox(
                                                    width: MediaQuery.of(context)
                                                        .size
                                                        .width *
                                                        0.5,
                                                    child: Text(
                                                      state.response!.farmerMAster![i].address!=null?
                                                      state.response!.farmerMAster![i].address!.address!=null?state.response!.farmerMAster![i].address!.address!:"":"",
                                                      style:
                                                      figtreeRegular.copyWith(
                                                        fontSize: 12,
                                                        color: Colors.black,
                                                        overflow:
                                                        TextOverflow.ellipsis,
                                                      ),
                                                    ),
                                                  ),
                                                ],
                                              )
                                            ],
                                          )
                                        ],
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.only(
                                            left:05, right: 15, top: 18),
                                        child: Row(
                                          mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                          children: [
                                            Text.rich(
                                              TextSpan(
                                                children: [
                                                  TextSpan(
                                                      text: 'Farm: ',
                                                      style:
                                                      figtreeRegular.copyWith(
                                                          color: const Color(
                                                              0xff808080),
                                                          fontSize: 12)),
                                                  TextSpan(
                                                    text: state.response!.farmerMAster![i].farmSize!=null?'${state.response!.farmerMAster![i].farmSize!} Acres':"",
                                                    style: figtreeSemiBold.copyWith(
                                                        fontSize: 12),
                                                  ),
                                                ],
                                              ),
                                            ),
                                            Text.rich(
                                              TextSpan(
                                                children: [
                                                  TextSpan(
                                                      text: 'Milking/Cows: ',
                                                      style:
                                                      figtreeRegular.copyWith(
                                                          color: const Color(
                                                              0xff808080),
                                                          fontSize: 12)),
                                                  TextSpan(
                                                    text: state.response!.farmerMAster![i].farmerMilkProduction!.isNotEmpty ? state.response!.farmerMAster![i].farmerMilkProduction![0].milkingCow!=null?state.response!.farmerMAster![i].farmerMilkProduction![0].milkingCow!.toString():'' : '',
                                                    style: figtreeSemiBold.copyWith(
                                                        fontSize: 12, color: Colors.black),
                                                  ),
                                                ],
                                              ),
                                            ),
                                            state.response!.farmerMAster![i].farmerMilkProduction!.isNotEmpty ?
                                            RichText(
                                                text: TextSpan(children: [
                                                  TextSpan(
                                                      text: 'Yield: ',
                                                      style: figtreeRegular.copyWith(
                                                          color: const Color(
                                                              0xff808080),
                                                          fontSize: 12)),
                                                  state.response!.farmerMAster![i].farmerMilkProduction![0].totalMilkProduction!=null?
                                                  TextSpan(
                                                      text: '${ double.parse('${state.response!.farmerMAster![i].farmerMilkProduction![0].totalMilkProduction!=null?
                                                      double.parse(state.response!.farmerMAster![i].farmerMilkProduction![0].totalMilkProduction!.toString())/
                                                          double.parse(state.response!.farmerMAster![i].farmerMilkProduction![0].milkingCow!=null?state.response!.farmerMAster![i].farmerMilkProduction![0].milkingCow!.toString():"1")
                                                          // /double.parse(DateTime(state.responseMonthlyWiseData![index].year!, state.responseMonthlyWiseData![index].month!, 0).day.toString())
                                                          / double.parse(DateTime(DateTime.parse(state.response!.farmerMAster![i].farmerMilkProduction![0].date ?? DateTime.now().toString()).year, DateTime.parse(state.response!.farmerMAster![i].farmerMilkProduction![0].date ?? DateTime.now().toString()).month+1, 0).day.toString()):'0'}').toStringAsFixed(2)
                                                      } Ltr.',
                                                      style: figtreeSemiBold.copyWith(
                                                          fontSize: 12, color: Colors.black)):TextSpan(
                                                      text: '',
                                                      style: figtreeRegular.copyWith(
                                                          color: const Color(
                                                              0xff808080),
                                                          fontSize: 12)),
                                                ])) : RichText(
                                                text: TextSpan(children: [
                                                  TextSpan(
                                                      text: 'Yield:  ',
                                                      style: figtreeRegular.copyWith(
                                                          color: const Color(
                                                              0xff808080),
                                                          fontSize: 12)),
                                                  TextSpan(
                                                      text: '',
                                                      style: figtreeSemiBold.copyWith(
                                                          fontSize: 12, color: Colors.black)),
                                                ])),
                                          ],
                                        ),
                                      ),
                                      20.verticalSpace(),
                                      /*state.response!.farmerMAster![i].farmerProject!.isNotEmpty ? Padding(
                                        padding: const EdgeInsets.only(right:15),
                                        child: InkWell(
                                          onTap: () {
                                            DDeFarmerInvestmentDetails(projectId: state.response!.farmerMAster![i].farmerProject![0].projectId,)
                                                .navigate();
                                          },
                                          child: Container(
                                            height: 83,
                                            padding: const EdgeInsets.fromLTRB(20, 10, 20, 10),
                                            decoration: boxDecoration(
                                                backgroundColor:
                                                const Color(0xffFFF3F4),
                                                borderRadius: 10),
                                            child: Column(
                                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                              children: [
                                                Row(
                                                  children: [
                                                    Expanded(child: (state.response!.farmerMAster![i].farmerProject![0].name ?? '')
                                                        .textMedium(fontSize: 12,maxLines: 2,overflow: TextOverflow.ellipsis)),
                                                    Container(
                                                      padding:
                                                      const EdgeInsets.symmetric(
                                                          vertical: 4,
                                                          horizontal: 7),
                                                      decoration: boxDecoration(
                                                        borderRadius: 30,
                                                        borderColor:
                                                        const Color(0xff6A0030),
                                                      ),
                                                      child: Text(
                                                        formatProjectStatus(state.response!.farmerMAster![i].farmerProject![0].projectStatus ?? ''),
                                                        textAlign: TextAlign.center,
                                                        style: figtreeMedium.copyWith(
                                                            color:
                                                            const Color(0xff6A0030),
                                                            fontSize: 10),
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                                Row(
                                                  mainAxisAlignment:
                                                  MainAxisAlignment.spaceBetween,
                                                  children: [
                                                    Column(
                                                      mainAxisAlignment:
                                                      MainAxisAlignment.center,
                                                      crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                      children: [
                                                        getCurrencyString(state.response!.farmerMAster![i].farmerProject![0].investmentAmount).toString().textSemiBold(
                                                            color: Colors.black,
                                                            fontSize: 16),
                                                       'Investment'.textMedium(
                                                            fontSize: 12,
                                                            color: const Color(
                                                                0xff808080)),
                                                      ],
                                                    ),
                                                    Column(
                                                      mainAxisAlignment:
                                                      MainAxisAlignment.center,
                                                      crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                      children: [
                                                        getCurrencyString(state.response!.farmerMAster![i].farmerProject![0].revenuePerYear).textSemiBold(
                                                            color: Colors.black,
                                                            fontSize: 16),
                                                        'Revenue'.textMedium(
                                                            fontSize: 12,
                                                            color: const Color(
                                                                0xff808080)),
                                                      ],
                                                    ),
                                                    Column(
                                                      mainAxisAlignment:
                                                      MainAxisAlignment.center,
                                                      crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                      children: [
                                                        double.parse(state.response!.farmerMAster![i].farmerProject![0].roiPerYear.toString()).toStringAsFixed(2).textSemiBold(
                                                            color: Colors.black,
                                                            fontSize: 16),
                                                       *//* '${state.response!.farmerMAster![i].farmerProject![0].roiPerYear}%'.textSemiBold(
                                                            color: Colors.black,
                                                            fontSize: 16),*//*
                                                        'ROI'.textMedium(
                                                            fontSize: 12,
                                                            color: const Color(
                                                                0xff808080)),
                                                      ],
                                                    ),
                                                  ],
                                                ),
                                              ],
                                            ),
                                          ),
                                        ),
                                      ) : const SizedBox.shrink(),*/

                                      // 15.verticalSpace(),
                                      Container(
                                        width: 140,
                                        height: 3,

                                        decoration: boxDecoration(
                                            borderRadius: 10,
                                            backgroundColor: ragColor(state.response!.farmerMAster![i].ragRating!=null?state.response!.farmerMAster![i].ragRating!.toLowerCase():"1")),
                                      )
                                    ],
                                  ),
                                ),
                              ),
                            ),
                            Positioned(
                                top: 0,
                                right: 0,
                                child: Row(
                                  children: [
                                    InkWell(
                                        onTap: () {
                                          callOnMobile(state.response!.farmerMAster![i].phone ??
                                              '');
                                        },
                                        child: SvgPicture.asset(Images.callPrimary)),
                                    6.horizontalSpace(),

                                    whatsapp(state.response!.farmerMAster![i].phone ?? ''),
                                    /*InkWell(
                                        onTap: () {

                                        },child: SvgPicture.asset(Images.whatsapp)),*/
                                    6.horizontalSpace(),
                                    InkWell(onTap: (){
                                      if(state.response!.farmerMAster![i].address!=null){
                                        BlocProvider.of<DdeEnquiryCubit>(context).launchURL(
                                            state.response!.farmerMAster![i].address!.latitude.toString(),
                                            state.response!.farmerMAster![i].address!.longitude.toString(),context);
                                      }
                                    },child: SvgPicture.asset(Images.redirectLocation)),
                                    4.horizontalSpace(),
                                  ],
                                )),
                          ],
                        ),
                      );
                    }),
                  ),
                )  : Padding(
                  padding: EdgeInsets.only(top: screenWidth() / 2),
                  child: const Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text('No data found'),
                    ],
                  ),
                ),
              ],
            ),
          ),

        ],
      );

    });

  }

  InkWell ragRatingButton(BuildContext context, String ragRating, String ragRatingCount, bool isSelected, Color ragColor) {
    return InkWell(
                        onTap: (){
                          if(BlocProvider.of<DdeFarmerCubit>(context).state.selectedRagRatingType == ragRating.toLowerCase()) {
                            BlocProvider.of<DdeFarmerCubit>(context).getFarmer(
                                context, '', false);
                          } else {
                            BlocProvider.of<DdeFarmerCubit>(context).getFarmer(
                                context, ragRating.toLowerCase(), false);
                          }
                        },
                        child: Container(
                          margin: const EdgeInsets.only(right: 12, left: 0),
                          padding: const EdgeInsets.all(10),
                          decoration: boxDecoration(
                              borderColor: const Color(0xffDCDCDC),
                              borderWidth: 1,
                              borderRadius: 62,
                              backgroundColor: isSelected ? ColorResources.maroon :Colors.white),
                          child: Row(
                            children: [
                              ragRating.textMedium(fontSize: 14, color: isSelected ? Colors.white : Colors.black),
                              6.horizontalSpace(),
                             ragRatingCount.toString().textSemiBold(
                                  fontSize: 12, color: isSelected ? Colors.white : ragColor),
                            ],
                          ),
                        ),
                      );
  }
}
