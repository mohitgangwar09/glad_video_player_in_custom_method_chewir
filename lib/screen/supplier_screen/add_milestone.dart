import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:glad/cubit/project_cubit/project_cubit.dart';
import 'package:glad/screen/custom_widget/custom_appbar.dart';
import 'package:glad/screen/custom_widget/custom_methods.dart';
import 'package:glad/utils/extension.dart';
import 'package:glad/utils/images.dart';
import 'package:glad/utils/styles.dart';

class AddSupplierMileStone extends StatefulWidget {
  const AddSupplierMileStone({Key? key,required this.farmerId,required this.farmerProjectId,required this.projectId,required this.projectStatus}) : super(key: key);

  final String farmerId,farmerProjectId,projectStatus;
  final int projectId;

  @override
  State<AddSupplierMileStone> createState() => _AddSupplierMileStoneState();
}

class _AddSupplierMileStoneState extends State<AddSupplierMileStone> {

  bool click = false;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      BlocProvider.of<ProjectCubit>(context).milestoneNameApi(context, widget.farmerId,widget.farmerProjectId);
    });
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      body: BlocBuilder<ProjectCubit,ProjectState>(
          builder: (context,state) {
            return Stack(
              children: [
                landingBackground(),
                Column(
                  children: [

                    CustomAppBar(
                      context: context,
                      titleText1: 'Add Project Milestone',
                      titleText1Style:
                      figtreeMedium.copyWith(fontSize: 20, color: Colors.black),
                      centerTitle: true,
                      leading: arrowBackButton(),
                      /*action: TextButton(
                      onPressed: () {},
                      child: Text(
                        'Save',
                        style: figtreeMedium.copyWith(
                            color: ColorResources.maroon, fontSize: 14),
                      )),*/
                    ),

                    Expanded(
                      child: SingleChildScrollView(
                        child: Padding(
                          padding: const EdgeInsets.all(20.0),
                          child: Column(
                            children: [


                              Align(
                                  alignment: Alignment.centerLeft,
                                  child: "Milestone Name".textMedium(color: Colors.black, fontSize: 12)),

                              5.verticalSpace(),

                              Stack(
                                children: [
                                  Container(
                                    height: 60,
                                    decoration: BoxDecoration(
                                        border: Border.all(color: const Color(0xffD9D9D9,),width: 1.5),
                                        borderRadius: BorderRadius.circular(10)
                                    ),
                                    width: screenWidth(),
                                    child: TextField(
                                      maxLines: 1,
                                      controller: state.milestoneTitle,
                                      onChanged: (value){
                                        setState(() {
                                          click = false;
                                          context.read<ProjectCubit>().milestoneId('');
                                          context.read<ProjectCubit>().searchMilestoneFilter(value, state.responseMilestoneName!);
                                        });
                                      },
                                      decoration: const InputDecoration(
                                          border: InputBorder.none,
                                          hintText: 'Search...',
                                          contentPadding: EdgeInsets.only(top: 10,left: 13)
                                      ),
                                    ),
                                  ),
                                  Visibility(
                                    visible: state.milestoneTitle.text.isNotEmpty,
                                    child: Positioned(
                                      top: 0,
                                      bottom: 0,
                                      right: 12,
                                      child: InkWell(
                                        onTap: (){
                                          setState(() {
                                            state.milestoneTitle.clear();
                                            state.filterMileStone!.clear();
                                          });
                                        },child: Align(alignment: Alignment.centerRight
                                          ,child: SvgPicture.asset(Images.cross)),
                                      ),
                                    ),
                                  )
                                ],
                              ),


                              state.milestoneTitle.text.isNotEmpty?
                              state.filterMileStone!=null?
                              Container(
                                // height: click? 0:state.filterMileStone!.isNotEmpty ? 200 : 0,
                                constraints: BoxConstraints(maxHeight: click? 0:state.filterMileStone!.isNotEmpty ? 200 : 0),
                                child: Card(
                                  child: ListView.separated(
                                      scrollDirection: Axis.vertical,
                                      shrinkWrap: true,
                                      padding: EdgeInsets.all(state.filterMileStone!.isNotEmpty?15:0),
                                      itemBuilder: (context,index){
                                        return InkWell(
                                          onTap: (){
                                            setState(() {
                                              click = true;
                                            });

                                            state.milestoneTitle.text = state.filterMileStone![index].milestoneTitle.toString();
                                            state.milestoneDuration.text = state.filterMileStone![index].milestoneDuration.toString();
                                            state.milestoneDescription.text = state.filterMileStone![index].milestoneDescription.toString();
                                            BlocProvider.of<ProjectCubit>(context).emit(state.copyWith(projectId: state.filterMileStone![index].id.toString(),filterMileStone: []));
                                            // state.filterMileStone!.clear();
                                          },
                                          child: Text(state.filterMileStone![index].milestoneTitle.toString(),
                                            style: figtreeMedium.copyWith(
                                              color: Colors.black,
                                              fontSize: 15,
                                            ),),
                                        );
                                      },
                                      separatorBuilder: (context,index){
                                        return const Divider(thickness: 1,height: 28,);
                                      },
                                      itemCount: state.filterMileStone!.length),
                                ),
                              ):
                              const SizedBox.shrink():
                              const SizedBox.shrink(),
                              25.verticalSpace(),

                              Align(
                                alignment: Alignment.centerLeft,
                                child: "Milestone Duration".textMedium(color: Colors.black, fontSize: 12),
                              ),

                              5.verticalSpace(),

                              Container(
                                height: 60,
                                decoration: BoxDecoration(
                                    border: Border.all(color: const Color(0xffD9D9D9,),width: 1.5),
                                    borderRadius: BorderRadius.circular(10)
                                ),
                                width: screenWidth(),
                                child: TextField(
                                  maxLines: 1,
                                  controller: state.milestoneDuration,
                                  keyboardType: TextInputType.number,
                                  inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                                  decoration: const InputDecoration(
                                      border: InputBorder.none,
                                      contentPadding: EdgeInsets.only(top: 10,left: 13)
                                  ),
                                ),
                              ),

                              25.verticalSpace(),

                              Align(
                                alignment: Alignment.centerLeft,
                                child: "Milestone Description".textMedium(color: Colors.black, fontSize: 12),
                              ),

                              5.verticalSpace(),

                              Container(
                                height: 60,
                                decoration: BoxDecoration(
                                    border: Border.all(color: const Color(0xffD9D9D9,),width: 1.5),
                                    borderRadius: BorderRadius.circular(10)
                                ),
                                width: screenWidth(),
                                child: TextField(
                                  maxLines: 1,
                                  controller: state.milestoneDescription,
                                  decoration: const InputDecoration(
                                      border: InputBorder.none,
                                      contentPadding: EdgeInsets.only(top: 10,left: 13)
                                  ),
                                ),
                              ),

                              50.verticalSpace(),

                              customButton('Save',
                                  style: figtreeMedium.copyWith(color: Colors.white),
                                  width: screenWidth(),
                                  height: 60,
                                  onTap: () {
                                    BlocProvider.of<ProjectCubit>(context).addSupplierMilestoneApi(context, widget.farmerId, widget.farmerProjectId, state.milestoneTitle.text, state.milestoneDescription.text, state.milestoneDuration.text,widget.projectId,widget.projectStatus);
                                  })

                            ],
                          ),
                        ),
                      ),
                    )
                  ],
                ),
              ],
            );
          }
      ),
    );
  }
}
