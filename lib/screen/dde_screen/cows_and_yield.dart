import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:glad/screen/custom_widget/custom_appbar.dart';
import 'package:glad/screen/custom_widget/custom_methods.dart';
import 'package:glad/screen/custom_widget/custom_textfield.dart';
import 'package:glad/utils/color_resources.dart';
import 'package:glad/utils/extension.dart';
import 'package:glad/utils/images.dart';
import 'package:glad/utils/styles.dart';
class IconDataItem {
  SvgPicture image;
  bool isVisible;

  IconDataItem({required this.image, this.isVisible = true});
}

class CowsAndYield extends StatefulWidget {
  const CowsAndYield({super.key});

  @override
  State<CowsAndYield> createState() => _CowsAndYieldState();
}

class _CowsAndYieldState extends State<CowsAndYield> {
  int defaultIndex = 0;
  bool tag = false;
  List viewList = [];

  bool isVisible = false;

  void toggleVisibility() {
    setState(() {
      isVisible = !isVisible;
    });
  }


  List<String> items = ['Item 1', 'Item 2', 'Item 3'];



  void addItemToList() {

    setState(() {
      items.add("");
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
                titleText1: 'Cows and Yield',
                leading: arrowBackButton(),
                centerTitle: true,
                description: 'Provide the following details',
                action: TextButton(
                  onPressed: () {},
                  child: Text(
                    'Save',
                    style: figtreeMedium.copyWith(
                        fontSize: 14, color: ColorResources.maroon),
                  ),
                ),
                titleText1Style:
                    figtreeMedium.copyWith(fontSize: 20, color: Colors.black),
              ),
              Expanded(
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      addMore(),
                      addMoreCard(),
                      saveCancelButton(),
                    ],
                  ),
                ),
              )
            ],
          )
        ],
      ),
    );
  }

//////////AddMoreButton////////////////
  Widget addMore() {
    return Column(
      children: [
        50.verticalSpace(),
        customButton('+ Add More',
            height: 60,
            width: 200,
            onTap: () {
              addItemToList();
            },
            color: 0xffFFFFFF,
            borderColor: 0xff6A0030,
            fontColor: 0xff6A0030),
      ],
    );
  }

///////////AddMoreCard////////////
  Widget addMoreCard() {
    return customList(
      list: items,
      child: (index) => InkWell(
        onTap: () {},
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            10.verticalSpace(),
            Padding(
              padding: const EdgeInsets.fromLTRB(10, 0, 13, 0),
              child: Column(
                children: [
                  Stack(
                    children: [
                      SizedBox(
                        // height: 150,
                        child: Column(
                          children: [
                            Container(
                              width: screenWidth(),
                              decoration: BoxDecoration(boxShadow: [
                                BoxShadow(
                                    color: Colors.grey.withOpacity(.100),
                                    blurRadius: 15),
                              ]),
                              child: InkWell(
                                // onTap: () {
                                //   setState(() {
                                //     defaultIndex = index;
                                //     if (viewList.contains(index)) {
                                //       viewList.remove(index);
                                //     } else {
                                //       viewList.add(index);
                                //     }
                                //   });
                                // },
                                child: Card(
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(20)),
                                  color: const Color(0xffFFB300),
                                  child: Column(children: [
                                    Padding(
                                      padding: const EdgeInsets.fromLTRB(
                                          20, 15, 15, 10),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Row(
                                            children: [
                                              Text(
                                                'Mar, 2023',
                                                style: figtreeBold.copyWith(
                                                    fontSize: 18),
                                              ),
                                              05.horizontalSpace(),
                                              const Icon(
                                                Icons.keyboard_arrow_down,
                                                size: 30,
                                              )
                                            ],
                                          ),
                                          Row(
                                            children: [
                                              // viewList.contains(index)?"dd".textBold():"PP".textMedium(),
                                              viewList.contains(index)
                                                  ? InkWell(
                                                      onTap: () {
                                                        setState(() {
                                                          defaultIndex = index;
                                                          if (viewList.contains(
                                                              index)) {
                                                            viewList
                                                                .remove(index);
                                                          } else {
                                                            viewList.add(index);
                                                          }
                                                        });
                                                      },
                                                      child: SvgPicture.asset(
                                                        Images.less1,
                                                        height:40,
                                                        width: 40,
                                                      ),
                                                    )
                                                  : InkWell(
                                              onTap: () {
                                                setState(() {
                                                  defaultIndex = index;
                                                  if (viewList.contains(
                                                      index)) {
                                                    viewList
                                                        .remove(index);
                                                  } else {
                                                    viewList.add(index);
                                                  }
                                                });
                                              },
                                                  child: const Icon(Icons.add)),
                                              10.horizontalSpace(),
                                              InkWell(
                                                onTap: (){
                                                  print(index);
                                                  removeItem(index);
                                                },
                                                child: SvgPicture.asset(
                                                  Images.deleteCows,
                                                  height: 40,
                                                  width: 40,
                                                ),
                                              )
                                            ],
                                          )
                                        ],
                                      ),
                                    ),
                                    10.verticalSpace(),
                                    Padding(
                                      padding: const EdgeInsets.fromLTRB(
                                          20, 0, 10, 20),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Row(
                                            children: [
                                              Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  Text(
                                                    '23',
                                                    style: figtreeSemiBold
                                                        .copyWith(fontSize: 18),
                                                  ),
                                                  Text(
                                                    'Herd Size',
                                                    style: figtreeMedium
                                                        .copyWith(fontSize: 12),
                                                  )
                                                ],
                                              ),
                                              05.horizontalSpace(),
                                            ],
                                          ),
                                          Row(
                                            children: [
                                              Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  Text(
                                                    '3800 Ltr.',
                                                    style: figtreeSemiBold
                                                        .copyWith(fontSize: 18),
                                                  ),
                                                  Text(
                                                    'Production',
                                                    style: figtreeMedium
                                                        .copyWith(fontSize: 12),
                                                  )
                                                ],
                                              ),
                                              05.horizontalSpace(),
                                            ],
                                          ),
                                          Row(
                                            children: [
                                              Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  Text(
                                                    '16',
                                                    style: figtreeSemiBold
                                                        .copyWith(fontSize: 18),
                                                  ),
                                                  Text(
                                                    'Milking Cows',
                                                    style: figtreeMedium
                                                        .copyWith(fontSize: 12),
                                                  )
                                                ],
                                              ),
                                              05.horizontalSpace(),
                                            ],
                                          ),
                                          Row(
                                            children: [
                                              Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  Text(
                                                    '8 Ltr.',
                                                    style: figtreeSemiBold
                                                        .copyWith(fontSize: 18),
                                                  ),
                                                  Text(
                                                    'Yield/day',
                                                    style: figtreeMedium
                                                        .copyWith(fontSize: 12),
                                                  )
                                                ],
                                              ),
                                              05.horizontalSpace(),
                                            ],
                                          ),
                                        ],
                                      ),
                                    ),
                                    viewList.contains(index)
                                        ? InkWell(
                                            onTap: () {},
                                            child: Container(
                                              decoration: BoxDecoration(
                                                  borderRadius:
                                                      const BorderRadius.only(
                                                          bottomLeft:
                                                              Radius.circular(
                                                                  20),
                                                          bottomRight:
                                                              Radius.circular(
                                                                  20)),
                                                  border: Border.all(
                                                      width: 1,
                                                      color: ColorResources
                                                          .mustard),
                                                  color: Colors.white),
                                              child: Padding(
                                                padding:
                                                    const EdgeInsets.fromLTRB(
                                                        20, 30, 20, 0),
                                                child: Column(
                                                  children: [
                                                    Row(
                                                      children: [
                                                        const Expanded(
                                                            child: SizedBox(
                                                                height: 60,
                                                                child:
                                                                    CustomTextField(
                                                                  hint:
                                                                      'Jersey',
                                                                ))),
                                                        10.horizontalSpace(),
                                                        SvgPicture.asset(
                                                            Images.addCows),
                                                        10.horizontalSpace(),
                                                        SvgPicture.asset(
                                                            Images.deleteField)
                                                      ],
                                                    ),
                                                    10.verticalSpace(),
                                                    const Padding(
                                                      padding: EdgeInsets.only(
                                                          left: 5, right: 5),
                                                      child: Divider(
                                                        thickness: 1,
                                                        color:
                                                            ColorResources.grey,
                                                      ),
                                                    ),
                                                    10.verticalSpace(),
                                                    Row(
                                                      children: [
                                                        const Expanded(
                                                            child: SizedBox(
                                                                height: 60,
                                                                child:
                                                                    CustomTextField(
                                                                  hint:
                                                                      'Ankole',
                                                                ))),
                                                        10.horizontalSpace(),
                                                        SvgPicture.asset(
                                                            Images.addCows),
                                                        10.horizontalSpace(),
                                                        SvgPicture.asset(
                                                            Images.deleteField)
                                                      ],
                                                    ),
                                                    20.verticalSpace(),
                                                    Row(
                                                      children: [
                                                        Expanded(
                                                            child: Column(
                                                          crossAxisAlignment:
                                                              CrossAxisAlignment
                                                                  .start,
                                                          children: [
                                                            Text(
                                                              'Herd',
                                                              style: figtreeSemiBold
                                                                  .copyWith(
                                                                      fontSize:
                                                                          12),
                                                            ),
                                                            05.verticalSpace(),
                                                            const CustomTextField(
                                                              hint: '',
                                                              paddingTop: 5,
                                                              inputType: TextInputType.phone,
                                                              paddingBottom: 21,
                                                              maxLine: 1,
                                                              width: 1,
                                                              borderColor:
                                                              0xff999999,
                                                            ),
                                                          ],
                                                        )),
                                                        15.horizontalSpace(),
                                                         Expanded(
                                                            child: Column(
                                                              crossAxisAlignment:
                                                              CrossAxisAlignment
                                                                  .start,
                                                              children: [
                                                                Text(
                                                                  'Milking Cow',
                                                                  style: figtreeSemiBold
                                                                      .copyWith(
                                                                      fontSize:
                                                                      12),
                                                                ),
                                                                05.verticalSpace(),
                                                                const CustomTextField(
                                                                  hint: '',
                                                                  paddingTop: 5,
                                                                  inputType: TextInputType.phone,
                                                                  paddingBottom: 21,
                                                                  maxLine: 1,
                                                                  width: 1,
                                                                  borderColor:
                                                                  0xff999999,
                                                                ),
                                                              ],
                                                            )),
                                                      ],
                                                    ),
                                                    20.verticalSpace(),
                                                    Row(
                                                      children: [
                                                         Expanded(
                                                            child:
                                                            Column(
                                                              crossAxisAlignment:
                                                              CrossAxisAlignment
                                                                  .start,
                                                              children: [
                                                                Text(
                                                                  'Yield (Ltr./Day)',
                                                                  style: figtreeSemiBold
                                                                      .copyWith(
                                                                      fontSize:
                                                                      12),
                                                                ),
                                                                05.verticalSpace(),
                                                                const CustomTextField(
                                                                  hint: '',
                                                                  paddingTop: 5,
                                                                  inputType: TextInputType.phone,
                                                                  paddingBottom: 21,
                                                                  maxLine: 1,
                                                                  width: 1,
                                                                  borderColor:
                                                                  0xff999999,
                                                                ),
                                                              ],
                                                            )),
                                                        15.horizontalSpace(),
                                                         Expanded(
                                                            child: Column(
                                                              crossAxisAlignment:
                                                              CrossAxisAlignment
                                                                  .start,
                                                              children: [
                                                                Text(
                                                                  'Dry',
                                                                  style: figtreeSemiBold
                                                                      .copyWith(
                                                                      fontSize:
                                                                      12),
                                                                ),
                                                                05.verticalSpace(),
                                                                const CustomTextField(
                                                                  hint: '',
                                                                  paddingTop: 5,
                                                                  inputType: TextInputType.phone,
                                                                  paddingBottom: 21,
                                                                  maxLine: 1,
                                                                  width: 1,
                                                                  borderColor:
                                                                  0xff999999,
                                                                ),
                                                              ],
                                                            )),
                                                        15.horizontalSpace(),
                                                         Expanded(
                                                            child: Column(
                                                              crossAxisAlignment:
                                                              CrossAxisAlignment
                                                                  .start,
                                                              children: [
                                                                Text(
                                                                  'Heifer',
                                                                  style: figtreeSemiBold
                                                                      .copyWith(
                                                                      fontSize:
                                                                      12),
                                                                ),
                                                                05.verticalSpace(),
                                                                const CustomTextField(
                                                                  hint: '',
                                                                  paddingTop: 5,
                                                                  inputType: TextInputType.phone,
                                                                  paddingBottom: 21,
                                                                  maxLine: 1,
                                                                  width: 1,
                                                                  borderColor:
                                                                  0xff999999,
                                                                ),
                                                              ],
                                                            )),
                                                      ],
                                                    ),
                                                    20.verticalSpace(),
                                                    Row(
                                                      children: [
                                                         Expanded(
                                                            child:
                                                            Column(
                                                              crossAxisAlignment:
                                                              CrossAxisAlignment
                                                                  .start,
                                                              children: [
                                                                Text(
                                                                  '7-12 mo',
                                                                  style: figtreeSemiBold
                                                                      .copyWith(
                                                                      fontSize:
                                                                      12),
                                                                ),
                                                                05.verticalSpace(),
                                                                const CustomTextField(
                                                                  hint: '',
                                                                  paddingTop: 5,
                                                                  inputType: TextInputType.phone,
                                                                  paddingBottom: 21,
                                                                  maxLine: 1,
                                                                  width: 1,
                                                                  borderColor:
                                                                  0xff999999,
                                                                ),
                                                              ],
                                                            )),
                                                        15.horizontalSpace(),
                                                         Expanded(
                                                            child: Column(
                                                              crossAxisAlignment:
                                                              CrossAxisAlignment
                                                                  .start,
                                                              children: [
                                                                Text(
                                                                  '<6 mo',
                                                                  style: figtreeSemiBold
                                                                      .copyWith(
                                                                      fontSize:
                                                                      12),
                                                                ),
                                                                05.verticalSpace(),
                                                                const CustomTextField(
                                                                  hint: '',
                                                                  paddingTop: 5,
                                                                  inputType: TextInputType.phone,
                                                                  paddingBottom: 21,
                                                                  maxLine: 1,
                                                                  width: 1,
                                                                  borderColor:
                                                                  0xff999999,
                                                                ),
                                                              ],
                                                            )),
                                                        15.horizontalSpace(),
                                                         Expanded(
                                                            child: Column(
                                                              crossAxisAlignment:
                                                              CrossAxisAlignment
                                                                  .start,
                                                              children: [
                                                                Text(
                                                                  'Bull Calf',
                                                                  style: figtreeSemiBold
                                                                      .copyWith(
                                                                      fontSize:
                                                                      12),
                                                                ),
                                                                05.verticalSpace(),
                                                                const CustomTextField(
                                                                  hint: '',
                                                                  paddingTop: 5,
                                                                  inputType: TextInputType.phone,
                                                                  paddingBottom: 21,
                                                                  maxLine: 1,
                                                                  width: 1,
                                                                  borderColor:
                                                                  0xff999999,
                                                                ),
                                                              ],
                                                            )),
                                                      ],
                                                    ),
                                                    10.verticalSpace(),
                                                    const Divider(
                                                      thickness: 1,
                                                      color:
                                                          ColorResources.grey,
                                                    ),
                                                    10.verticalSpace(),
                                                    customButton('+ Add More',
                                                        height: 50,
                                                        width: 130,
                                                        onTap: () {},
                                                        color: 0xffFFFFFF,
                                                        borderColor: 0xff6A0030,
                                                        fontColor: 0xff6A0030),
                                                    20.verticalSpace(),
                                                    Container(
                                                      decoration: BoxDecoration(
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(20),
                                                        color: const Color(
                                                            0xffFFF3F4),
                                                      ),
                                                      child: Padding(
                                                        padding:
                                                            const EdgeInsets
                                                                    .fromLTRB(
                                                                16, 20, 10, 20),
                                                        child: Column(
                                                          children: [
                                                            Row(
                                                              mainAxisAlignment:
                                                                  MainAxisAlignment
                                                                      .spaceBetween,
                                                              children: [
                                                                 Expanded(
                                                                    child:
                                                                    Column(
                                                                      crossAxisAlignment:
                                                                      CrossAxisAlignment
                                                                          .start,
                                                                      children: [
                                                                        Text(
                                                                          'Supplied to PDFL (Ltr.)',
                                                                          style: figtreeSemiBold
                                                                              .copyWith(
                                                                              fontSize:
                                                                              12),
                                                                        ),
                                                                        08.verticalSpace(),
                                                                         const CustomTextField(
                                                                          hint: '',
                                                                          paddingTop: 5,
                                                                          inputType: TextInputType.phone,
                                                                          paddingBottom: 21,
                                                                          maxLine: 1,
                                                                          width: 1,
                                                                          borderColor:
                                                                          0xff999999,
                                                                        ),
                                                                      ],
                                                                    )),
                                                                15.horizontalSpace(),
                                                                 Expanded(
                                                                    child: Column(
                                                                      crossAxisAlignment:
                                                                      CrossAxisAlignment
                                                                          .start,
                                                                      children: [
                                                                        Text(
                                                                          'Supplied to Others (Ltr.)',
                                                                          style: figtreeSemiBold
                                                                              .copyWith(
                                                                              fontSize:
                                                                              12),
                                                                        ),
                                                                        08.verticalSpace(),
                                                                        const CustomTextField(
                                                                          hint: '',
                                                                          paddingTop: 5,
                                                                          inputType: TextInputType.phone,
                                                                          paddingBottom: 21,
                                                                          maxLine: 1,
                                                                          width: 1,
                                                                          borderColor:
                                                                          0xff999999,
                                                                        ),
                                                                      ],
                                                                    )),
                                                                15.horizontalSpace(),
                                                                 Expanded(
                                                                    child:
                                                                        Column(
                                                                          crossAxisAlignment:
                                                                          CrossAxisAlignment
                                                                              .start,
                                                                          children: [
                                                                            Padding(
                                                                              padding: const EdgeInsets.only(top:15.0),
                                                                              child: Text(
                                                                                'Self use',
                                                                                style: figtreeSemiBold
                                                                                    .copyWith(
                                                                                    fontSize:
                                                                                    12),
                                                                              ),
                                                                            ),
                                                                            08.verticalSpace(),
                                                                            const CustomTextField(
                                                                              hint: '',
                                                                              paddingTop: 5,
                                                                              inputType: TextInputType.phone,
                                                                              paddingBottom: 21,
                                                                              maxLine: 1,
                                                                              width: 1,
                                                                              borderColor:
                                                                              0xff999999,
                                                                            ),
                                                                          ],
                                                                        )),
                                                              ],
                                                            ),
                                                            20.verticalSpace(),
                                                            Row(
                                                              mainAxisAlignment:
                                                                  MainAxisAlignment
                                                                      .spaceBetween,
                                                              children: [
                                                                Text(
                                                                  'Total milk production (Ltr.)',
                                                                  style: figtreeRegular
                                                                      .copyWith(
                                                                          fontSize:
                                                                              16),
                                                                ),
                                                                Text(
                                                                  '3800',
                                                                  style: figtreeBold
                                                                      .copyWith(
                                                                          fontSize:
                                                                              16),
                                                                ),
                                                              ],
                                                            ),
                                                            05.verticalSpace(),
                                                            const Divider(
                                                              thickness: 1,
                                                              color:
                                                                  ColorResources
                                                                      .grey,
                                                            ),
                                                            Row(
                                                              mainAxisAlignment:
                                                                  MainAxisAlignment
                                                                      .spaceBetween,
                                                              children: [
                                                                Text(
                                                                  'Yield (Ltr.) /Cow /Day',
                                                                  style: figtreeRegular
                                                                      .copyWith(
                                                                          fontSize:
                                                                              16),
                                                                ),
                                                                Text(
                                                                  '7.9',
                                                                  style: figtreeBold
                                                                      .copyWith(
                                                                          fontSize:
                                                                              16),
                                                                ),
                                                              ],
                                                            ),
                                                          ],
                                                        ),
                                                      ),
                                                    ),
                                                    20.verticalSpace(),
                                                  ],
                                                ),
                                              ),
                                            ),
                                          )
                                        : const SizedBox(
                                            width: 0,
                                            height: 0,
                                          )
                                  ]),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      //////////Bottom Design///////
                      // Positioned(
                      //   bottom: 0,
                      //   right: 25,
                      //   left: 25,
                      //   child: SvgPicture.asset(Images.cardImage),
                      // )
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

///////////SaveCancelButton////////////////////
  Widget saveCancelButton() {
    return Padding(
      padding: const EdgeInsets.fromLTRB(29, 40, 29, 0),
      child: Column(
        children: [
          // 40.verticalSpace(),
          customButton(
            'Save',
            style: figtreeMedium.copyWith(color: Colors.white, fontSize: 16),
            onTap: () {},
            width: screenWidth(),
            height: 60,
          ),
          15.verticalSpace(),
          customButton('Cancel',
              style: figtreeMedium.copyWith(fontSize: 16),
              onTap: () {},
              width: screenWidth(),
              height: 60,
              color: 0xffDCDCDC),
          20.verticalSpace(),
        ],
      ),
    );
  }

  void removeItem (int index){
    setState(() {
      items.removeAt(index);
    });
  }




}
