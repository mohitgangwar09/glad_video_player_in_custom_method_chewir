import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:glad/cubit/landing_page_cubit/landing_page_cubit.dart';
import 'package:glad/cubit/livestock_cubit/livestock_cubit.dart';
import 'package:glad/data/model/response_breed.dart';
import 'package:glad/screen/custom_widget/container_border.dart';
import 'package:glad/screen/custom_widget/custom_appbar.dart';
import 'package:glad/screen/custom_widget/custom_methods.dart';
import 'package:glad/screen/dde_screen/preview_screen.dart';
import 'package:glad/screen/farmer_screen/dashboard/dashboard_farmer.dart';
import 'package:glad/screen/guest_user/dashboard/dashboard_guest.dart';
import 'package:glad/utils/app_constants.dart';
import 'package:glad/utils/color_resources.dart';
import 'package:glad/utils/extension.dart';
import 'package:glad/utils/helper.dart';
import 'package:glad/utils/images.dart';
import 'package:glad/utils/styles.dart';

class AddLivestock extends StatefulWidget {
  const AddLivestock({Key? key}) : super(key: key);

  @override
  State<AddLivestock> createState() => _AddLivestockState();
}

class _AddLivestockState extends State<AddLivestock> {

  List<String> path = [];

  int quantity = 1;
  // String selectedBreed = '';
  DataBreed? selectedBreed;
  // int? selectedBreedId;


  TextEditingController price = TextEditingController();
  TextEditingController controller = TextEditingController();
  TextEditingController age = TextEditingController();
  TextEditingController milk = TextEditingController();
  String? lactation = '';
  String? pregnant = '';

  @override
  void initState() {
    BlocProvider.of<LivestockCubit>(context).livestockBreedApi(context);
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocBuilder<LivestockCubit, LivestockCubitState>(
        builder: (context, state) {
          return Container(
            color: Colors.white,
            child: Stack(
              children: [
                landingBackground(),
                Column(
                  children: [
                    CustomAppBar(
                      context: context,
                      titleText1: 'Add Livestock',
                      centerTitle: true,
                      leading: arrowBackButton(),
                    ),
                    Expanded(
                      child: SingleChildScrollView(
                        child: Padding(
                          padding: const EdgeInsets.all(24),
                          child: Column(
                            children: [
                              Align(
                                alignment: Alignment.centerLeft,
                                child: "Cow Breed".textMedium(color: Colors.black, fontSize: 12),
                              ),

                              5.verticalSpace(),

                              Container(
                                height: 55,
                                decoration: BoxDecoration(
                                    border: Border.all(color: const Color(0xffD9D9D9,),width: 1.5),
                                    borderRadius: BorderRadius.circular(10),
                                    color: Colors.white
                                ),
                                width: screenWidth(),
                                child: DropdownButtonHideUnderline(
                                  child: DropdownButton2<DataBreed>(
                                    isExpanded: true,
                                    isDense: true,
                                    value: selectedBreed,
                                    hint: Text(
                                      'Select breed',
                                      style: TextStyle(
                                        fontSize: 14,
                                        color: Theme.of(context).hintColor,
                                      ),
                                    ),
                                    items: state.breed == null ? null : state.breed!.data!
                                        .map((DataBreed item) => DropdownMenuItem<DataBreed>(
                                      value: item,
                                      child: Text(
                                        item.name!,
                                        style: const TextStyle(
                                          fontSize: 14,
                                        ),
                                      ),
                                    )).toList(),
                                    // value: state.counties![0].name!,
                                    onChanged: (DataBreed? value) {
                                      setState(() {
                                      // selectedBreed = value!.name!;
                                      selectedBreed = value!;
                                      // selectedBreedId = value.id!;
                                      });
                                    },
                                    buttonStyleData: const ButtonStyleData(
                                      padding: EdgeInsets.symmetric(horizontal: 16),
                                      height: 40,
                                      width: 140,
                                    ),
                                    menuItemStyleData: const MenuItemStyleData(
                                      height: 40,
                                    ),
                                  ),
                                ),
                              ),

                              20.verticalSpace(),
                              Row(
                                children: [
                                  5.horizontalSpace(),
                                  'Add Photo'.textMedium(color: Colors.black, fontSize: 12),
                                ],
                              ),
                              5.verticalSpace(),
                              Stack(
                                children: [
                                  ContainerBorder(
                                    margin: 0.marginVertical(),
                                    padding:
                                    10.paddingOnly(top: 15, bottom: 15),
                                    borderColor: 0xffD9D9D9,
                                    backColor: 0xffFFFFFF,
                                    radius: 10,
                                    widget: Row(
                                      mainAxisAlignment:
                                      MainAxisAlignment.center,
                                      crossAxisAlignment:
                                      CrossAxisAlignment.center,
                                      children: [
                                        5.horizontalSpace(),
                                        Expanded(
                                          child: Padding(
                                            padding: const EdgeInsets.only(
                                                left: 10.0, top: 2, bottom: 2),
                                            child: Column(
                                              crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                              children: [
                                                RichText(
                                                    text: TextSpan(children: [
                                                      TextSpan(
                                                          text: 'Choose ',
                                                          style: figtreeMedium
                                                              .copyWith(
                                                              fontSize: 16,
                                                              color: const Color(
                                                                  0xFFFC5E60))),
                                                      TextSpan(
                                                          text: 'you file here',
                                                          style: figtreeMedium
                                                              .copyWith(
                                                              fontSize: 16,
                                                              color:
                                                              ColorResources
                                                                  .fieldGrey))
                                                    ])),
                                                Text('Max size 5 MB',
                                                    style:
                                                    figtreeMedium.copyWith(
                                                        fontSize: 12,
                                                        color:
                                                        ColorResources
                                                            .fieldGrey))
                                              ],
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  Positioned(
                                    right: 13,
                                    top: 0,
                                    bottom: 0,
                                    child: Row(
                                      children: [
                                        InkWell(
                                          onTap: () async {
                                            path.add(await imgFromGallery());
                                            setState(() {});
                                          },
                                          child: SvgPicture.asset(
                                            Images.attachment,
                                            colorFilter: const ColorFilter.mode(
                                                ColorResources.fieldGrey,
                                                BlendMode.srcIn),
                                          ),
                                        ),
                                        Row(children: [
                                          10.horizontalSpace(),
                                          InkWell(
                                            onTap: () async{
                                              path.add(await imgFromCamera());
                                              setState(() {});
                                            },
                                            child: SvgPicture.asset(
                                              Images.camera,
                                              colorFilter: const ColorFilter.mode(
                                                  ColorResources.fieldGrey,
                                                  BlendMode.srcIn),
                                            ),
                                          )
                                        ],),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                              Visibility(
                                visible: path.isNotEmpty,
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    20.verticalSpace(),
                                    Container(
                                      height: 80,
                                      alignment: Alignment.centerLeft,
                                      child: customList(
                                        list: path,
                                        axis: Axis.horizontal,
                                        child: (index) {
                                          return Row(
                                          children: [
                                            Stack(
                                              children: [
                                                InkWell(
                                                  onTap:() {
                                                    PreviewScreen(previewImage: path[index],).navigate();
                                                  },
                                                  child: Container(
                                                    decoration: BoxDecoration(
                                                      border: Border.all(color: const Color(0xFF819891)),
                                                      borderRadius: BorderRadius.circular(200),
                                                    ),
                                                    child: Padding(
                                                      padding: const EdgeInsets.all(4.0),
                                                      child: ClipRRect(
                                                        borderRadius: BorderRadius.circular(200),
                                                        child: isUrl(path[index]) ? CachedNetworkImage(
                                                            imageUrl: path[index], fit: BoxFit.fill,
                                                            height: 70,
                                                            width: 70, errorWidget: (_, __, ___) => Image.asset(
                                                          Images.sampleVideo,
                                                          fit: BoxFit.fill,
                                                          height: 70,
                                                          width: 70,)) : Image.file(File(path[index]), fit: BoxFit.fill,
                                                            height: 70,
                                                            width: 70, errorBuilder: (_, __, ___) => Image.asset(
                                                              Images.sampleVideo,
                                                              fit: BoxFit.fill,
                                                              height: 70,
                                                              width: 70,
                                                            )),),
                                                    ),
                                                  ),
                                                ),
                                                Positioned(
                                                  right: 0,
                                                  child: InkWell(
                                                    onTap: () {
                                                      path.remove(path[index]);
                                                      setState(() {});
                                                    },
                                                    child: Container(
                                                      decoration: BoxDecoration(
                                                          borderRadius: BorderRadius.circular(200),
                                                          color: Colors.white),
                                                      child: SvgPicture.asset(
                                                        Images.cancelImage,
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                              ],
                                            ),
                                            10.horizontalSpace(),
                                          ],
                                        );
                                      }),
                                    ),
                                  ],
                                ),
                              ),
                              // SingleChildScrollView(
                              //   scrollDirection: Axis.horizontal,
                              //   child: Row(
                              //     crossAxisAlignment: CrossAxisAlignment.start,
                              //     mainAxisAlignment: MainAxisAlignment.start,
                              //     children: [
                              //       for (String image in path)
                              //         Row(
                              //           children: [
                              //             Stack(
                              //               children: [
                              //                 InkWell(
                              //                   onTap:() {
                              //                     PreviewScreen(previewImage: image.toString(),).navigate();
                              //                   },
                              //                   child: Container(
                              //                     decoration: BoxDecoration(
                              //                       border: Border.all(color: const Color(0xFF819891)),
                              //                       borderRadius: BorderRadius.circular(200),
                              //                     ),
                              //                     child: Padding(
                              //                       padding: const EdgeInsets.all(4.0),
                              //                       child: ClipRRect(
                              //                         borderRadius: BorderRadius.circular(200),
                              //                         child: isUrl(image) ? CachedNetworkImage(
                              //                             imageUrl: image, fit: BoxFit.fill,
                              //                             height: 70,
                              //                             width: 70, errorWidget: (_, __, ___) => Image.asset(
                              //                           Images.sampleVideo,
                              //                           fit: BoxFit.fill,
                              //                           height: 70,
                              //                           width: 70,)) : Image.file(File(image), fit: BoxFit.fill,
                              //                             height: 70,
                              //                             width: 70, errorBuilder: (_, __, ___) => Image.asset(
                              //                               Images.sampleVideo,
                              //                               fit: BoxFit.fill,
                              //                               height: 70,
                              //                               width: 70,
                              //                             )),),
                              //                     ),
                              //                   ),
                              //                 ),
                              //                 Positioned(
                              //                   right: 0,
                              //                   child: InkWell(
                              //                     onTap: () {
                              //                       path.remove(image);
                              //                       setState(() {
                              //
                              //                       });
                              //                     },
                              //                     child: Container(
                              //                       decoration: BoxDecoration(
                              //                           borderRadius: BorderRadius.circular(200),
                              //                           color: Colors.white),
                              //                       child: SvgPicture.asset(
                              //                         Images.cancelImage,
                              //                       ),
                              //                     ),
                              //                   ),
                              //                 ),
                              //               ],
                              //             ),
                              //             10.horizontalSpace(),
                              //           ],
                              //         )
                              //     ],
                              //   ),
                              // ),

                              20.verticalSpace(),

                              Row(
                                children: [
                                  5.horizontalSpace(),
                                  'Available Quantity'.textMedium(color: Colors.black, fontSize: 12),
                                ],
                              ),
                              5.verticalSpace(),

                              Container(
                                height: 55,
                                decoration: BoxDecoration(
                                    border: Border.all(color: const Color(0xffD9D9D9,),width: 1.5),
                                    borderRadius: BorderRadius.circular(10),
                                    color: Colors.white
                                ),
                                width: screenWidth(),
                                padding: const EdgeInsets.symmetric(horizontal: 20),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    InkWell(
                                      onTap: () {
                                        if(quantity == 1) {
                                          return;
                                        }
                                        quantity--;
                                        setState(() {

                                        });
                                      },
                                        child: SvgPicture.asset(Images.minusQuant)),
                                    quantity.toString().textMedium(fontSize: 16, color: Colors.black),
                                    InkWell(
                                        onTap: () {
                                            quantity++;
                                            setState(() {

                                            });
                                        },
                                        child: SvgPicture.asset(Images.addQuant)),

                                ],),
                              ),

                              20.verticalSpace(),
                              Align(
                                alignment: Alignment.centerLeft,
                                child: "Cow Price (UGX)".textMedium(color: Colors.black, fontSize: 12),
                              ),

                              5.verticalSpace(),

                              Container(
                                height: 60,
                                decoration: BoxDecoration(
                                    border: Border.all(color: const Color(0xffD9D9D9,),width: 1.5),
                                    borderRadius: BorderRadius.circular(10),
                                    color: Colors.white
                                ),
                                width: screenWidth(),
                                child: TextField(
                                  maxLines: 1,
                                  inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                                  controller: price,
                                  maxLength: 10,
                                  // enabled: false,
                                  keyboardType: TextInputType.number,
                                  decoration: const InputDecoration(
                                      border: InputBorder.none,
                                      counterText: '',
                                      contentPadding: EdgeInsets.only(top: 10,left: 13),
                                  ),
                                ),
                              ),

                              20.verticalSpace(),

                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Expanded(
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        "Age (Years)".textMedium(color: Colors.black, fontSize: 12),

                                        5.verticalSpace(),

                                        Container(
                                          height: 55,
                                          decoration: BoxDecoration(
                                              border: Border.all(color: const Color(0xffD9D9D9,),width: 1.5),
                                              borderRadius: BorderRadius.circular(10),
                                              color: Colors.white,
                                          ),
                                          width: screenWidth(),
                                          child: TextField(
                                            maxLines: 1,
                                            inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                                            controller: age,
                                            maxLength: 10,
                                            keyboardType: TextInputType.number,
                                            decoration: const InputDecoration(
                                              border: InputBorder.none,
                                              counterText: '',
                                              contentPadding: EdgeInsets.only(top: 10,left: 13),
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  10.horizontalSpace(),
                                  Expanded(
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        "Lactation (Months)".textMedium(color: Colors.black, fontSize: 12),

                                        5.verticalSpace(),

                                        Container(
                                          height: 55,
                                          decoration: BoxDecoration(
                                              border: Border.all(color: const Color(0xffD9D9D9,),width: 1.5),
                                              borderRadius: BorderRadius.circular(10),
                                              color: Colors.white
                                          ),
                                          width: screenWidth(),
                                          child: DropdownButtonHideUnderline(
                                            child: DropdownButton2<int>(
                                              isExpanded: true,
                                              isDense: true,
                                              value: lactation != '' ? int.parse(lactation!) : null,
                                              hint: Text(
                                                'Select',
                                                style: TextStyle(
                                                  fontSize: 14,
                                                  color: Theme.of(context).hintColor,
                                                ),
                                              ),
                                              items: lactation == null ? null : List<int>.generate(10, (i) => i)
                                                  .map((int item) => DropdownMenuItem<int>(
                                                value: item,
                                                child: Text(
                                                  item.toString(),
                                                  style: const TextStyle(
                                                    fontSize: 14,
                                                  ),
                                                ),
                                              )).toList(),
                                              // value: state.counties![0].name!,
                                              onChanged: (int? value) {
                                                setState(() {
                                                lactation = value!.toString();
                                                });
                                              },
                                              buttonStyleData: const ButtonStyleData(
                                                padding: EdgeInsets.symmetric(horizontal: 16),
                                                height: 40,
                                                width: 140,
                                              ),
                                              menuItemStyleData: const MenuItemStyleData(
                                                height: 40,
                                              ),
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  )
                                ],
                              ),

                              20.verticalSpace(),

                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Expanded(
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        "Pregnant (Months)".textMedium(color: Colors.black, fontSize: 12),

                                        5.verticalSpace(),

                                        Container(
                                          height: 55,
                                          decoration: BoxDecoration(
                                              border: Border.all(color: const Color(0xffD9D9D9,),width: 1.5),
                                              borderRadius: BorderRadius.circular(10),
                                              color: Colors.white
                                          ),
                                          width: screenWidth(),
                                          child: DropdownButtonHideUnderline(
                                            child: DropdownButton2<int>(
                                              isExpanded: true,
                                              isDense: true,
                                              value: pregnant != '' ? int.parse(pregnant!) : null,
                                              hint: Text(
                                                'Select',
                                                style: TextStyle(
                                                  fontSize: 14,
                                                  color: Theme.of(context).hintColor,
                                                ),
                                              ),
                                              items: pregnant == null ? null : List<int>.generate(10, (i) => i)
                                                  .map((int item) => DropdownMenuItem<int>(
                                                value: item,
                                                child: Text(
                                                  item.toString(),
                                                  style: const TextStyle(
                                                    fontSize: 14,
                                                  ),
                                                ),
                                              )).toList(),
                                              // value: state.counties![0].name!,
                                              onChanged: (int? value) {
                                                setState(() {
                                                  pregnant = value!.toString();
                                                });
                                              },
                                              buttonStyleData: const ButtonStyleData(
                                                padding: EdgeInsets.symmetric(horizontal: 16),
                                                height: 40,
                                                width: 140,
                                              ),
                                              menuItemStyleData: const MenuItemStyleData(
                                                height: 40,
                                              ),
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  10.horizontalSpace(),
                                  Expanded(
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        "Milk (Per day)".textMedium(color: Colors.black, fontSize: 12),

                                        5.verticalSpace(),

                                        Container(
                                          height: 55,
                                          decoration: BoxDecoration(
                                              border: Border.all(color: const Color(0xffD9D9D9,),width: 1.5),
                                              borderRadius: BorderRadius.circular(10),
                                              color: Colors.white,
                                          ),
                                          width: screenWidth(),
                                          child: TextField(
                                            maxLines: 1,
                                            inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                                            controller: milk,
                                            maxLength: 10,
                                            keyboardType: TextInputType.number,
                                            decoration: const InputDecoration(
                                              border: InputBorder.none,
                                              counterText: '',
                                              contentPadding: EdgeInsets.only(top: 10,left: 13),
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  )
                                ],
                              ),
                              
                              20.verticalSpace(),

                              Align(
                                alignment: Alignment.centerLeft,
                                child: "Description".textMedium(color: Colors.black, fontSize: 12),
                              ),

                              5.verticalSpace(),

                              TextField(
                                controller: controller,
                                maxLines: 7,
                                minLines: 7,
                                decoration: InputDecoration(
                                    hintText: 'Write...',
                                    hintStyle:
                                    figtreeMedium.copyWith(fontSize: 18),
                                    border: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(12),
                                        borderSide: const BorderSide(
                                          width: 1,
                                          color: Color(0xff999999),
                                        ))),
                              ),
                              40.verticalSpace(),
                              Padding(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 20.0),
                                child: customButton(
                                  'Save',
                                  onTap: () {
                                    if(selectedBreed == null) {
                                      showCustomToast(context, 'Breed required');
                                    } else if(path.isEmpty) {
                                      showCustomToast(context, 'Cow images required');
                                    } else if( milk.text.isEmpty) {
                                      showCustomToast(context, 'Milk (Per day) required');
                                    }  else if( lactation == null) {
                                      showCustomToast(context, 'Lactation required');
                                    }  else if( price.text.isEmpty) {
                                      showCustomToast(context, 'Cow price required');
                                    }  else if( pregnant == null) {
                                      showCustomToast(context, 'Pregnant required');
                                    }  else if( quantity == 0) {
                                      showCustomToast(context, 'Breed required');
                                    }  else if( age.text.isEmpty) {
                                      showCustomToast(context, 'Age required');
                                    }  else if( controller.text.isEmpty) {
                                      showCustomToast(context, 'Description required');
                                    }  else {
                                      BlocProvider.of<LivestockCubit>(context)
                                          .livestockAddApi(
                                          context,
                                          selectedBreed!.id.toString(),
                                          path,
                                          milk.text,
                                          lactation ?? '',
                                          price.text,
                                          pregnant ?? '',
                                          quantity.toString(),
                                          age.text,
                                          controller.text);
                                    }
                                  },
                                  radius: 40,
                                  width: double.infinity,
                                  height: 60,
                                  style: figtreeMedium.copyWith(
                                      color: Colors.white, fontSize: 16),
                                ),
                              ),
                              20.verticalSpace(),
                              Padding(
                                padding: const EdgeInsets.symmetric(horizontal: 20),
                                child: customButton('Cancel',
                                    style: figtreeMedium.copyWith(fontSize: 16),
                                    onTap: () {
                                      pressBack();
                                    },
                                    width: screenWidth(),
                                    height: 60,
                                    color: 0xffDCDCDC),
                              ),
                            ],
                          ),
                        ),
                      ),
                    )
                  ],
                ),
              ],
            ),
          );
        }
      ),
    );
  }

}
