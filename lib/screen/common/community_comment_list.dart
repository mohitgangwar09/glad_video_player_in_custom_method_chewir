import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:glad/cubit/community_cubit/community_cubit.dart';
import 'package:glad/screen/custom_widget/custom_appbar.dart';
import 'package:glad/screen/custom_widget/custom_methods.dart';
import 'package:glad/screen/dde_screen/preview_screen.dart';
import 'package:glad/utils/app_constants.dart';
import 'package:glad/utils/color_resources.dart';
import 'package:glad/utils/extension.dart';
import 'package:glad/utils/helper.dart';
import 'package:glad/utils/images.dart';
import 'package:glad/utils/styles.dart';
import 'package:intl/intl.dart';

class CommunityCommentList extends StatefulWidget {
  const CommunityCommentList({super.key, required this.communityId});
  final String communityId;

  @override
  State<CommunityCommentList> createState() => _CommunityCommentListState();
}

class _CommunityCommentListState extends State<CommunityCommentList> {

  TextEditingController commentController = TextEditingController();

  @override
  void initState() {
    super.initState();

    SchedulerBinding.instance.addPostFrameCallback((_) {
      BlocProvider.of<CommunityCubit>(context).commentListApi(context, widget.communityId);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(body: BlocBuilder<CommunityCubit, CommunityCubitState>(
        builder: (context, state) {
          if (state.status == CommunityStatus.submit) {
            return const Center(
                child: CircularProgressIndicator(
                  color: ColorResources.maroon,
                ));
          } else if (state.responseCommunityCommentList == null) {
            return Center(child: Text("${state.responseCommunityCommentList} Api Error"));
          } else {
            return Container(
              color: Colors.white,
              child: Stack(
                children: [
                  landingBackground(),
                  Column(
                    children: [
                      CustomAppBar(
                        context: context,
                        titleText1: 'Comments',
                        centerTitle: true,
                        leading: arrowBackButton(),
                      ),
                      Expanded(
                          child: SingleChildScrollView(
                            child: Column(
                              children: [
                                20.verticalSpace(),
                                customList(
                                  list: state.responseCommunityCommentList!.data ?? [],
                                  child: (index) => state.responseCommunityCommentList!.data![index].createdBy.toString() == context.read<CommunityCubit>().sharedPreferences.getString(AppConstants.userId) ?
                                  Padding(
                                    padding: const EdgeInsets.only(bottom: 20),
                                    child: Padding(
                                      padding: const EdgeInsets.symmetric(horizontal: 20),
                                      child: Container(
                                        width: screenWidth(),
                                        padding: const EdgeInsets.all(30),
                                        decoration: BoxDecoration(
                                            color: Colors.white,
                                            border: Border.all(color: const Color(0xFF999999)),
                                            borderRadius: const BorderRadius.only(
                                                topLeft: Radius.circular(30),
                                                topRight: Radius.circular(30),
                                                bottomLeft: Radius.circular(30),
                                                bottomRight: Radius.circular(0))),
                                        child: Column(
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: [
                                            Text(state.responseCommunityCommentList!.data![index].user!.name ?? '',
                                                style: figtreeMedium.copyWith(
                                                    fontSize: 20, color: Colors.black)),

                                            Column(
                                              crossAxisAlignment: CrossAxisAlignment.start,
                                              children: [
                                                10.verticalSpace(),
                                                Text(
                                                    state.responseCommunityCommentList!.data![index].comment!,
                                                    style: figtreeMedium.copyWith(
                                                        fontSize: 16, color: Colors.black)),
                                                10.verticalSpace(),
                                              ],
                                            ),
                                            DateFormat('dd MMM, yyyy, hh:mm a').format(DateTime.parse(state.responseCommunityCommentList!.data![index].createdAt.toString())).textRegular(
                                                color: ColorResources.fieldGrey, fontSize: 14)
                                          ],
                                        ),
                                      ),
                                    ),
                                  ) :
                                  Padding(
                                    padding: const EdgeInsets.only(bottom: 20),
                                    child: Padding(
                                      padding: const EdgeInsets.symmetric(horizontal: 20),
                                      child: Container(
                                        width: screenWidth(),
                                        padding: const EdgeInsets.all(30),
                                        decoration: BoxDecoration(
                                            color: const Color(0xFFFFF3F4),
                                            border: Border.all(color: const Color(0xFFC788A5)),
                                            borderRadius: const BorderRadius.only(
                                                topLeft: Radius.circular(30),
                                                topRight: Radius.circular(30),
                                                bottomRight: Radius.circular(30),
                                                bottomLeft: Radius.circular(0))),
                                        child: Column(
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: [
                                            Text(state.responseCommunityCommentList!.data![index].user!.name ?? '',
                                                style: figtreeMedium.copyWith(
                                                    fontSize: 20, color: Colors.black)),

                                            Column(
                                              crossAxisAlignment: CrossAxisAlignment.start,
                                              children: [
                                                10.verticalSpace(),
                                                Text(
                                                    state.responseCommunityCommentList!.data![index].comment!,
                                                    style: figtreeMedium.copyWith(
                                                        fontSize: 16, color: Colors.black)),
                                                10.verticalSpace(),
                                              ],
                                            ),
                                            DateFormat('dd MMM, yyyy hh:mm a').format(DateTime.parse(state.responseCommunityCommentList!.data![index].createdAt.toString())).textRegular(
                                                color: ColorResources.fieldGrey, fontSize: 14)
                                          ],
                                        ),
                                      ),
                                    ),
                                  ),)
                              ],
                            ),
                          )),

                      Container(
                        height: AppBar().preferredSize.height * 1.5,
                        width: screenWidth(),
                        padding: const EdgeInsets.symmetric(horizontal: 16),
                        decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: const BorderRadius.only(
                                topLeft: Radius.circular(24),
                                topRight: Radius.circular(24)),
                            border: Border.all(color: ColorResources.grey)),
                        child: Row(
                          children: [
                            Expanded(
                              child: TextField(
                                controller: commentController,
                                decoration: const InputDecoration(
                                    border: InputBorder.none,
                                    focusedBorder: InputBorder.none,
                                    enabledBorder: InputBorder.none,
                                    hintText: 'Followup remarks...'),
                                onSubmitted: (value) {
                                  if(value.isNotEmpty) {
                                    context
                                        .read<CommunityCubit>()
                                        .addCommentApi(context, widget.communityId, commentController.text);
                                    commentController.clear();
                                  }
                                },
                              ),
                            ),
                            IconButton(onPressed: (){
                              if(commentController.text.isNotEmpty){
                                context
                                    .read<CommunityCubit>()
                                    .addCommentApi(context, widget.communityId, commentController.text);
                                commentController.clear();
                              }
                            },icon: const Icon(Icons.send,color: Colors.grey, size: 31,))
                          ],
                        ),
                      )
                    ],
                  ),
                ],
              ),
            );
          }
        }),);
  }
}
