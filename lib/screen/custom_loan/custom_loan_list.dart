
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:glad/cubit/dde_enquiry_cubit/dde_enquiry_cubit.dart';
import 'package:glad/cubit/dde_farmer_cubit/dde_farmer_cubit.dart';
import 'package:glad/cubit/profile_cubit/profile_cubit.dart';
import 'package:glad/cubit/project_cubit/project_cubit.dart';
import 'package:glad/screen/custom_loan/apply_custom_loan.dart';
import 'package:glad/screen/custom_widget/custom_appbar.dart';
import 'package:glad/screen/custom_widget/custom_methods.dart';
import 'package:glad/screen/dde_screen/dashboard/dashboard_dde.dart';
import 'package:glad/screen/dde_screen/enquiry_details.dart';
import 'package:glad/utils/color_resources.dart';
import 'package:glad/utils/extension.dart';
import 'package:glad/utils/images.dart';
import 'package:glad/utils/styles.dart';
import 'package:intl/intl.dart';

class CustomLoanList extends StatefulWidget {
  const CustomLoanList({Key? key}) : super(key: key);

  @override
  State<CustomLoanList> createState() => _CustomLoanListState();
}

class _CustomLoanListState extends State<CustomLoanList> {
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
                      titleText1: 'Custom Loan',
                      titleText1Style:
                      figtreeMedium.copyWith(fontSize: 20, color: Colors.black),
                      centerTitle: true,
                      leading: arrowBackButton(),
                    ),
                    Expanded(
                      child: SingleChildScrollView(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 20),
                        child: Column(children: [
                          Container(
                              margin: 20.marginAll(),
                              height: 55,
                              width: screenWidth(),
                              child: customButton("Apply New Loan",
                                  fontColor: 0xffffffff,
                                  onTap: () {
                                      const ApplyCustomLoan().navigate();
                                  }))
                        ],),
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
