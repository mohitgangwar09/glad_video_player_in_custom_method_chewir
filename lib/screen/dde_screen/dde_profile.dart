import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:glad/cubit/profile_cubit/profile_cubit.dart';
import 'package:glad/cubit/project_cubit/project_cubit.dart';
import 'package:glad/screen/custom_widget/custom_appbar.dart';
import 'package:glad/screen/custom_widget/custom_methods.dart';
import 'package:glad/screen/custom_widget/custom_textfield.dart';
import 'package:glad/screen/dde_screen/dde_earning_statement.dart';
import 'package:glad/screen/farmer_screen/dashboard_tab_screen/statement.dart';
import 'package:glad/utils/color_resources.dart';
import 'package:glad/utils/extension.dart';
import 'package:glad/utils/helper.dart';
import 'package:glad/utils/images.dart';
import 'package:glad/utils/styles.dart';

class DDEProfile extends StatefulWidget {
  const DDEProfile({super.key});

  @override
  State<DDEProfile> createState() => _DDEProfileState();
}

class _DDEProfileState extends State<DDEProfile> {

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    SchedulerBinding.instance.addPostFrameCallback((_) {
      BlocProvider.of<ProfileCubit>(context).profileApi(context);
      BlocProvider.of<ProjectCubit>(context).accountStatementApi(context, '');
    });
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      body: Stack(
        children: [
          landingBackground(),
          Column(
            children: [
              CustomAppBar(
                context: context,
                titleText1: '',
                leading: arrowBackButton(),
              ),
              Expanded(
                child: SingleChildScrollView(
                  child: BlocBuilder<ProfileCubit,ProfileCubitState>(
                      builder: (BuildContext context, state) {
                      return Column(
                        children: [
                          profileImage(context,state),
                          40.verticalSpace(),
                          ratingBar(context,state),
                          profileInputField(context,state),
                          earningCardDetails(context,state),
                          20.verticalSpace(),
                        ],
                      );
                    }
                  ),
                ),
              )
            ],
          ),
        ],
      ),
    );
  }

  ///////ProfileInputField//////////
  Widget profileInputField(BuildContext context,ProfileCubitState state) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(36, 0, 30, 0),
      child: Column(
        children: [
          40.verticalSpace(),
          CustomTextField(
            style: figtreeMedium.copyWith(fontSize: 14, color: Colors.black),
            hint: 'Phone',
            controller: state.phoneController,
            leadingImage: Images.textCall,
            imageColors: ColorResources.fieldGrey,
            enabled: false,
            withoutBorder: true,
            underLineBorderColor: ColorResources.grey,
          ),
          20.verticalSpace(),
          CustomTextField(
            hint: 'Email',
            controller: state.emailController,
            leadingImage: Images.emailPhone,
            imageColors: ColorResources.fieldGrey,
            style: figtreeMedium.copyWith(fontSize: 14, color: Colors.black),
            enabled: false,
            withoutBorder: true,
            underLineBorderColor: ColorResources.grey,
          ),
          20.verticalSpace(),
          CustomTextField(
            maxLine: 2,
            hint: 'Address',
            controller: state.addressController,
            leadingImage: Images.textEdit,
            imageColors: ColorResources.fieldGrey,
            style: figtreeMedium.copyWith(fontSize: 14, color: Colors.black),
            enabled: false,
            withoutBorder: true,
            underLineBorderColor: ColorResources.grey,
          ),
          40.verticalSpace(),
        ],
      ),
    );
  }

  ///////////EarningCardDetails/////////
  Widget earningCardDetails(BuildContext context,ProfileCubitState state) {
    return BlocBuilder<ProjectCubit,ProjectState>(
        builder: (context,state) {
          if (state.status == ProjectStatus.loading) {
            return const Center(
                child: CircularProgressIndicator(
                  color: ColorResources.maroon,
                ));
          } else if (state.responseAccountStatement == null) {
            return const Center(child: Text("Please check your internet connection"));
          }else{
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.fromLTRB(25, 0, 0, 0),
                  child: Text(
                    'Earning',
                    style: figtreeMedium.copyWith(fontSize: 18),
                  ),
                ),
                10.verticalSpace(),
                Padding(
                  padding: const EdgeInsets.fromLTRB(18, 0, 24, 0),
                  child: InkWell(
                    onTap: (){
                      const DdeEarningDetails().navigate();
                    },
                    child: Column(
                      children: [
                        Stack(
                          children: [
                            SizedBox(
                              height: 170,
                              child: Column(
                                children: [
                                  Container(
                                    // padding: const EdgeInsets.only(left: 10),
                                    decoration: BoxDecoration(boxShadow: [
                                      BoxShadow(
                                          color: Colors.grey.withOpacity(.100),
                                          blurRadius: 15),
                                    ]),
                                    child: Card(
                                      shape: RoundedRectangleBorder(
                                          borderRadius: BorderRadius.circular(20)),
                                      color: const Color(0xffFFB300),
                                      child: Column(children: [
                                        Row(
                                          mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                          children: [
                                            Padding(
                                              padding:
                                              const EdgeInsets.fromLTRB(10, 0, 0, 0),
                                              child: Text(
                                                getCurrencyString(state.responseAccountStatement!.data!.summary!.totalAmount!=null?state.responseAccountStatement!.data!.summary!.totalAmount!:0),
                                                style: figtreeBold.copyWith(fontSize: 28),
                                              ),
                                            ),
                                            SvgPicture.asset(Images.arrowPercent)
                                          ],
                                        ),
                                        Row(
                                          children: [
                                            Container(
                                              width: 82,
                                              height: 38,
                                              margin: const EdgeInsets.only(left: 10),
                                              decoration: BoxDecoration(
                                                  border: Border.all(
                                                      width: 2,
                                                      color: Colors.white),
                                                  color: const Color(0xff12CE57),
                                                  borderRadius:
                                                  BorderRadius.circular(40)),
                                              child: Padding(
                                                padding: const EdgeInsets.fromLTRB(
                                                    3, 0, 4, 0),
                                                child: Row(
                                                  children: [
                                                    const Icon(Icons.trending_up,
                                                        size: 25, color: Colors.white),
                                                    Text(
                                                      '+5.0%',
                                                      style: figtreeBold.copyWith(
                                                          fontSize: 13, color: Colors.white),
                                                    )
                                                  ],
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                        5.verticalSpace(),
                                        Padding(
                                          padding:
                                          const EdgeInsets.fromLTRB(10, 10, 20, 20),
                                          child: Row(
                                            mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                            children: [
                                              Row(
                                                children: [
                                                  Row(
                                                    children: [
                                                      Text(
                                                        'Due:',
                                                        style: figtreeSemiBold.copyWith(
                                                            fontSize: 14),
                                                      ),
                                                      05.horizontalSpace(),
                                                      Text(
                                                        getCurrencyString(state.responseAccountStatement!.data!.summary!.dueAmount!=null?state.responseAccountStatement!.data!.summary!.dueAmount!:0),
                                                        style: figtreeSemiBold.copyWith(
                                                            fontSize: 14),
                                                      ),
                                                    ],
                                                  ),
                                                  10.horizontalSpace(),
                                                  const CircleAvatar(
                                                    radius: 4,
                                                    backgroundColor: Colors.black,
                                                  ),
                                                  10.horizontalSpace(),
                                                  Row(
                                                    children: [
                                                      Text(
                                                        'Pending:',
                                                        style: figtreeSemiBold.copyWith(
                                                            fontSize: 14),
                                                      ),
                                                      05.horizontalSpace(),
                                                      Text(
                                                        getCurrencyString(state.responseAccountStatement!.data!.summary!.pendingAmount!=null?state.responseAccountStatement!.data!.summary!.pendingAmount!:0),
                                                        style: figtreeSemiBold.copyWith(
                                                            fontSize: 14),
                                                      )
                                                    ],
                                                  )
                                                ],
                                              ),
                                            ],
                                          ),
                                        ),
                                      ]),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Positioned(
                              bottom: 0,
                              right: 10,
                              left: 10,
                              child: SvgPicture.asset(Images.cardImage),
                            )
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            );
          }
      }
    );
  }

/////////RatingBar///////////
  Widget ratingBar(BuildContext context,ProfileCubitState state) {
    return state.responseProfile!=null ?
    Padding(
      padding: const EdgeInsets.fromLTRB(30, 0, 19, 0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.only(left: 5),
                child: Text(
                  '${state.responseProfile!.data!.user!.name}',
                  style: figtreeSemiBold.copyWith(fontSize: 22),
                ),
              ),

              RatingBar.builder(
                  initialRating: double.parse(state.responseUserRating!.data![0].rating!=null?state.responseUserRating!.data![0].rating!.toString():0.toString()),
                  glowColor: Colors.amber,
                  minRating: 1,
                  allowHalfRating: true,
                  itemCount: 5,
                  ignoreGestures: true,
                  itemBuilder: (context, _) =>
                      const Icon(Icons.star, color: Color(0xffF6B51D)),
                  onRatingUpdate: (rating) {
                    print(rating);
                  })
            ],
          ),
          SvgPicture.asset(
            Images.silver,
            height: 55,
            width: 55,
          )
        ],
      ),
    ):const SizedBox(width: 0,height: 0,);
  }

  /////////ProfileImage////////
  Widget profileImage(BuildContext context,ProfileCubitState state) {
    return state.responseProfile!=null ?Center(
      child: Stack(
        children: [
          ClipOval(
            clipper: MyClip(),
            child: SizedBox(
              height: 180,
              width: 190,
              child: networkImage(text: state.responseProfile!.data!.user!.profilePic.toString()),
            ),
          ),
          Positioned(
              right: 0,
              bottom: 24,
              child: InkWell(
                onTap: (){
                  showPicker(context, cameraFunction: () async{
                    var image = imgFromCamera();
                    image.then((value) async{
                       context.read<ProfileCubit>().updateProfilePicImage(context,value);
                    });
                  }, galleryFunction: () async{
                    var image = imgFromGallery();
                    image.then((value) async{
                      context.read<ProfileCubit>().updateProfilePicImage(context,value);
                    });
                  });
                },
                child: const CircleAvatar(
                  radius: 20,
                  backgroundColor: Colors.white,
                  child: CircleAvatar(
                    radius: 18,
                    backgroundColor: ColorResources.primary,
                    child: Icon(Icons.camera_alt, color: Colors.white, size: 20),
                  ),
                ),
              )),
        ],
      ),
    ):const SizedBox(width: 0,height: 0,);
  }
}

class MyClip extends CustomClipper<Rect> {
  @override
  Rect getClip(Size size) {
    return Rect.fromLTWH(0, 0,
        Platform.isAndroid ? size.width - 20 : size.width - 10, size.height);
  }

  @override
  bool shouldReclip(oldClipper) {
    return false;
  }
}
