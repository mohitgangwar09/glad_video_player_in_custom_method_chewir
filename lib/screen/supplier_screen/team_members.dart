import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:glad/cubit/profile_cubit/profile_cubit.dart';
import 'package:glad/screen/custom_widget/custom_appbar.dart';
import 'package:glad/screen/custom_widget/custom_methods.dart';
import 'package:glad/screen/custom_widget/custom_textfield.dart';
import 'package:glad/screen/farmer_screen/drawer_screen/chat_screen.dart';
import 'package:glad/screen/supplier_screen/add_team_members.dart';
import 'package:glad/screen/supplier_screen/update_team_members.dart';
import 'package:glad/utils/color_resources.dart';
import 'package:glad/utils/extension.dart';
import 'package:glad/utils/images.dart';
import 'package:glad/utils/styles.dart';

class TeamMembers extends StatefulWidget {
  const TeamMembers({super.key});

  @override
  State<TeamMembers> createState() => _TeamMembersState();
}

class _TeamMembersState extends State<TeamMembers> {

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      BlocProvider.of<ProfileCubit>(context).teamMemberListApi(context);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          landingBackground(),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CustomAppBar(
                  context: context,
                  centerTitle: true,
                  titleText1: 'Team Members',
                  titleText1Style:
                  figtreeMedium.copyWith(fontSize: 20, color: Colors.black),
                  action: TextButton(
                    onPressed: (){
                      const AddTeamMembers().navigate();
                    },
                    child: Text("Add New",
                      style: figtreeMedium.copyWith(
                          color: const Color(0xff6A0030)
                      ),),
                  ),
                  leading: arrowBackButton()),
              Expanded(
                child: BlocBuilder<ProfileCubit,ProfileCubitState>(
                    builder: (context,state) {
                      if(state.responseTeamMemberList == null){
                        return Center(
                          child: Text("No data found",
                          style: figtreeMedium.copyWith(
                            fontSize: 16
                          ),),
                        );
                      }else{
                        return SingleChildScrollView(
                          child: Padding(
                            padding:
                            const EdgeInsets.only(left: 18.0, right: 18, top: 20),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                CustomTextField(
                                  hint: 'Search members...',
                                  leadingImage: Images.search,
                                  imageColors: Colors.black,
                                  radius: 60,
                                  onChanged: (value){
                                    context.read<ProfileCubit>().filterMemberList(value, state.responseTeamMemberList!.data!);
                                  },
                                ),

                                20.verticalSpace(),

                                customList(
                                    child: (index) => Padding(
                                      padding: const EdgeInsets.only(bottom: 10),
                                      child: InkWell(
                                        onTap: () {
                                          UpdateTeamMembers(dataMemberList:state.responseTeamMemberList!.data![index]).navigate();
                                        },
                                        child: Stack(
                                          children: [
                                            Container(
                                              padding: const EdgeInsets.all(20),
                                              decoration: BoxDecoration(
                                                  color: Colors.white,
                                                  borderRadius:
                                                  const BorderRadius.only(
                                                      topLeft:
                                                      Radius.circular(20),
                                                      topRight:
                                                      Radius.circular(20),
                                                      bottomLeft:
                                                      Radius.circular(20)),
                                                  border: Border.all(
                                                      color: ColorResources.grey)),
                                              child: Row(
                                                crossAxisAlignment:
                                                CrossAxisAlignment.center,
                                                mainAxisAlignment:
                                                MainAxisAlignment.start,
                                                children: [
                                                  Image.asset(Images.sampleUser),
                                                  15.horizontalSpace(),
                                                  Column(
                                                    crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                    children: [
                                                      Text(state.filterMemberList![index].name??'',
                                                          style: figtreeMedium
                                                              .copyWith(
                                                              fontSize: 18,
                                                              color: Colors
                                                                  .black)),
                                                      4.verticalSpace(),
                                                      Row(
                                                        children: [
                                                          Text(state.filterMemberList![index].email??'',
                                                              style: figtreeRegular
                                                                  .copyWith(
                                                                  fontSize: 12,
                                                                  color: ColorResources
                                                                      .fieldGrey)),
                                                          8.horizontalSpace(),
                                                          Container(
                                                            height: 4,
                                                            width: 4,
                                                            decoration:
                                                            const BoxDecoration(
                                                                color: Colors
                                                                    .black,
                                                                shape: BoxShape
                                                                    .circle),
                                                          ),
                                                          8.horizontalSpace(),
                                                          Text('+256 ${state.filterMemberList![index].phone??''}',
                                                              style: figtreeRegular
                                                                  .copyWith(
                                                                  fontSize: 12,
                                                                  color: ColorResources
                                                                      .fieldGrey)),
                                                        ],
                                                      ),
                                                    ],
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                    list: state.filterMemberList!),

                                if(state.filterMemberList!.isEmpty)
                                  const Padding(
                                    padding: EdgeInsets.only(top: 40),
                                    child: Center(child: Text('No Results Found')),
                                  )
                              ],
                            ),
                          ),
                        );
                      }
                    }
                ),
              )
            ],
          ),
        ],
      ),
    );
  }
}
