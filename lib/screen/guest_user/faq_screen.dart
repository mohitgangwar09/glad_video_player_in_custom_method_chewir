import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:glad/cubit/training_cubit/training_cubit.dart';
import 'package:glad/screen/custom_widget/custom_appbar.dart';
import 'package:glad/screen/custom_widget/custom_methods.dart';
import 'package:glad/utils/color_resources.dart';
import 'package:glad/utils/images.dart';
import 'package:glad/utils/styles.dart';

class FaqScreen extends StatefulWidget {
  const FaqScreen({super.key});

  @override
  State<FaqScreen> createState() => _FaqScreenState();
}

class _FaqScreenState extends State<FaqScreen> {
  int defaultIndex = 0;

  @override
  void initState() {
    BlocProvider.of<TrainingCubit>(context).trainingCategoriesApi(context);
    BlocProvider.of<TrainingCubit>(context).faqListApi(context,"");
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          landingBackground(),
          BlocBuilder<TrainingCubit, TrainingCubitState>(
              builder: (context, state) {
                if (state.status == TrainingStatus.submit) {
                  return const Center(
                      child: CircularProgressIndicator(
                        color: ColorResources.maroon,
                      ));
                } else if (state.responseFaqList == null) {
                  return Center(
                      child: Text("${state.responseFaqList} Api Error"));
                }  else if (state.responseFaqList == null) {
                  return Center(
                      child: Text("${state.responseFaqList} Api Error"));
                }else{
                  return Column(
                    children: [
                      CustomAppBar(
                        context: context,
                        titleText1: "FAQ's",
                        centerTitle: true,
                        leading: arrowBackButton(),
                      ),
                      fourOptions(state),
                      listDetails(state),
                    ],
                  );
                }
            }
          )
        ],
      ),
    );
  }

  ////////////FourOptions///////////////
  Widget fourOptions(TrainingCubitState state) {
    return SizedBox(
      height: 45,
      child: customList(
          list: List.generate(
              state.responseTrainingCategories!.data!.length, (index) => null),
          axis: Axis.horizontal,
          child: (index) {
            return Row(

              children: [
                index == 0
                    ? Padding(
                  padding: const EdgeInsets.only(left: 20),
                  child: InkWell(
                    onTap: () {
                      BlocProvider.of<TrainingCubit>(context)
                          .emit(state.copyWith(selectedCategoryId: ''));
                      BlocProvider.of<TrainingCubit>(context)
                          .faqListApi(context, '');
                    },
                    child: Container(
                        padding: const EdgeInsets.all(14),
                        decoration: boxDecoration(
                          borderColor: state.selectedCategoryId == ''
                              ? ColorResources.maroon
                              : const Color(0xffDCDCDC),
                          borderRadius: 50,
                          backgroundColor: state.selectedCategoryId == ''
                              ? const Color(0xFFFFF3F4)
                              : Colors.white,
                        ),
                        child: Text(
                          'All',
                          style: figtreeMedium.copyWith(
                              fontSize: 12,
                              color: state.selectedCategoryId == ''
                                  ? ColorResources.maroon
                                  : Colors.black),
                        )),
                  ),
                )
                    : const SizedBox.shrink(),
                Padding(
                  padding:
                  EdgeInsets.only(right: 10, left: index == 0 ? 10 : 0),
                  child: InkWell(
                    onTap: () {
                      BlocProvider.of<TrainingCubit>(context).emit(
                          state.copyWith(
                              selectedCategoryId: state
                                  .responseTrainingCategories!
                                  .data![index]
                                  .id.toString() ??
                                  ''));
                      BlocProvider.of<TrainingCubit>(context).faqListApi(
                          context,
                          state.responseTrainingCategories!.data![index].id.toString() ??
                              '');
                    },
                    child: Container(
                        padding: const EdgeInsets.all(14),
                        decoration: boxDecoration(
                          borderColor: state.selectedCategoryId ==
                              state.responseTrainingCategories!.data![index]
                                  .id.toString()
                              ? ColorResources.maroon
                              : const Color(0xffDCDCDC),
                          borderRadius: 50,
                          backgroundColor: state.selectedCategoryId ==
                              state.responseTrainingCategories!.data![index]
                                  .id.toString()
                              ? const Color(0xFFFFF3F4)
                              : Colors.white,
                        ),
                        child: Text(
                          state.responseTrainingCategories!.data![index].name ??
                              '',
                          style: figtreeMedium.copyWith(
                              fontSize: 12,
                              color: state.selectedCategoryId ==
                                  state.responseTrainingCategories!
                                      .data![index].id.toString()
                                  ? ColorResources.maroon
                                  : Colors.black),
                        )),
                  ),
                ),
              ],
            );
          }),
    );
  }


  Widget listDetails(TrainingCubitState state) {
    return state.responseFaqList!.data!=null?customList(
        list: state.responseFaqList!.data!,
        child: (index) {
          return Padding(
            padding: const EdgeInsets.only(left: 15, right: 15),
            child: Container(
              margin: const EdgeInsets.only(top: 15),
              decoration: BoxDecoration(
                  border: Border.all(width: 1, color: ColorResources.colorGrey),
                  borderRadius: BorderRadius.circular(14)),
              child: Padding(
                padding: const EdgeInsets.only(
                    left: 15, right: 10, top: 15, bottom: 15),
                child: Column(
                  children: [
                    Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Expanded(
                            child: Text(
                              state.responseFaqList!.data![index].question!=null?state.responseFaqList!.data![index].question!:"",
                              maxLines: 4,
                              style: figtreeMedium.copyWith(fontSize: 18),
                            ),
                          ),
                          InkWell(
                              onTap: () {
                                setState(() {
                                  defaultIndex = index;
                                });
                              },

                              child: defaultIndex == index?SvgPicture.asset(

                                Images.lessFaq,
                                height: 40,
                                width: 40,
                              ):SvgPicture.asset(Images.addFaq)
                          )
                        ]),
                    defaultIndex == index
                        ? Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [

                        const SizedBox(
                          height: 20,
                        ),
                        Align(
                          alignment: Alignment.topLeft,
                          child: Text(
                            state.responseFaqList!.data![index].question!=null?state.responseFaqList!.data![index].answer!:"",
                            style: figtreeMedium.copyWith(
                                fontSize: 16,
                                color: ColorResources.colorGrey),
                          ),
                        ),
                      ],
                    )
                        : const SizedBox.shrink()
                  ],
                ),
              ),
            ),
          );
        }):const SizedBox(height:200,child: Center(child: Text("No data found")),
    );
  }
}