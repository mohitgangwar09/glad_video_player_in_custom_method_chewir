import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:glad/cubit/improvement_area_cubit/improvement_area_cubit.dart';
import 'package:glad/screen/custom_widget/custom_appbar.dart';
import 'package:glad/screen/custom_widget/custom_methods.dart';
import 'package:glad/screen/custom_widget/custom_textfield2.dart';
import 'package:glad/utils/color_resources.dart';
import 'package:glad/utils/extension.dart';
import 'package:glad/utils/images.dart';
import 'package:glad/utils/styles.dart';

class EditImprovementArea extends StatefulWidget {
  const EditImprovementArea({super.key, required this.improvementIndex, required this.farmerId});
  final int improvementIndex;
  final int farmerId;

  @override
  State<EditImprovementArea> createState() => _EditImprovementAreaState();
}

class _EditImprovementAreaState extends State<EditImprovementArea> {
  @override
  void initState() {
    BlocProvider.of<ImprovementAreaCubit>(context).generateController(widget.improvementIndex);
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocBuilder<ImprovementAreaCubit, ImprovementAreaState>(
          builder: (context, state) {
        if (state.status == ImprovementAreaStatus.loading) {
          return const Center(
              child: CircularProgressIndicator(
            color: ColorResources.maroon,
          ));
        } else if (state.response == null) {
          return Center(child: Text("${state.response} Api Error"));
        } else {
          return Stack(
            children: [
              landingBackground(),
              Column(
                children: [
                  CustomAppBar(
                    context: context,
                    titleText1: "Improvement areas",
                    description: 'Provide the following details',
                    leading: arrowBackButton(),
                    centerTitle: true,
                    action: TextButton(
                        onPressed: () {
                          context.read<ImprovementAreaCubit>().updateImprovementAreaApi(context, widget.farmerId, widget.improvementIndex);
                        },
                        child: Text(
                          'Save',
                          style: figtreeMedium.copyWith(
                              color: ColorResources.maroon, fontSize: 14),
                        )),
                  ),
                  Expanded(
                    child: SingleChildScrollView(
                      child: Padding(
                        padding: const EdgeInsets.all(20),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Center(
                              child: Stack(
                                children: [
                                  ClipRRect(
                                    borderRadius:
                                    BorderRadius.circular(16.0),
                                    child: CachedNetworkImage(
                                      imageUrl: state
                                          .response!
                                          .data!
                                          .improvementAreaList![widget.improvementIndex]
                                          .image ??
                                          '',
                                      errorWidget: (_, __, ___) =>
                                          Image.asset(
                                            Images.facilities,
                                            width: screenWidth() * 0.75,
                                            height: screenWidth() * 0.65 ,
                                            fit: BoxFit.cover,
                                            alignment: Alignment.center,
                                          ),
                                      width: screenWidth() * 0.75,
                                      height: screenWidth() * 0.65,
                                      fit: BoxFit.cover,
                                      alignment: Alignment.center,
                                    ),
                                  ),
                                  Positioned(
                                    bottom: 20,
                                    right: 10,
                                    left: 10,
                                    child: Text(
                                      state
                                          .response!
                                          .data!
                                          .improvementAreaList![widget.improvementIndex]
                                          .name ??
                                          '',
                                      style: figtreeMedium.copyWith(
                                          color: Colors.white,
                                          fontSize: 18),
                                      textAlign: TextAlign.center,
                                    ),
                                  )
                                ],
                              ),
                            ),
                            20.verticalSpace(),
                            customList(
                              list: List.generate(state.response!.data!.improvementAreaList![widget.improvementIndex].farmerImprovementArea!.length, (index) => ''),
                                child: (index) => Padding(
                                  padding: const EdgeInsets.only(bottom: 20),
                                  child: CustomTextField2(title: state.response!.data!.improvementAreaList![widget.improvementIndex].farmerImprovementArea![index].parameter!, controller: state.areaControllers![index],),
                                )),
                          ],
                        ),
                      ),
                    ),
                  )
                ],
              )
            ],
          );
        }
      }),
    );
  }
}
