
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:glad/cubit/project_cubit/project_cubit.dart';
import 'package:glad/data/model/frontend_kpi_model.dart';
import 'package:glad/data/model/loan_purpose_list.dart';
import 'package:glad/screen/custom_widget/custom_appbar.dart';
import 'package:glad/screen/custom_widget/custom_methods.dart';
import 'package:glad/screen/custom_widget/custom_textfield2.dart';
import 'package:glad/utils/color_resources.dart';
import 'package:glad/utils/extension.dart';
import 'package:glad/utils/images.dart';
import 'package:glad/utils/styles.dart';
import 'package:intl/intl.dart';

class ApplyCustomLoan extends StatefulWidget {
  const ApplyCustomLoan({Key? key}) : super(key: key);

  @override
  State<ApplyCustomLoan> createState() => _ApplyCustomLoanState();
}

class _ApplyCustomLoanState extends State<ApplyCustomLoan> {

  String? purpose = '';
  TextEditingController price = TextEditingController();
  TextEditingController period = TextEditingController();
  TextEditingController remarks = TextEditingController();

  @override
  void initState() {
    BlocProvider.of<ProjectCubit>(context).customLoanFormApi(context, null);
    BlocProvider.of<ProjectCubit>(context).customLoanPurposeListApi(context);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocBuilder<ProjectCubit,ProjectState>(
          builder: (context,state) {
      if (state.status == ProjectStatus.loading) {
        return const Center(
            child: CircularProgressIndicator(
              color: ColorResources.maroon,
            ));
      } else if (state.responseLoanForm == null) {
        return Center(child: Text("${state.responseLoanForm} Api Error"));
      } else {
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
                          kpi(context, state),

                          30.verticalSpace(),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              "Purpose of Loan".textMedium(color: Colors.black, fontSize: 12),

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
                                  child: DropdownButton2<String>(
                                    isExpanded: true,
                                    isDense: true,
                                    value: purpose != '' ? purpose : null,
                                    hint: Text(
                                      'Select loan purpose',
                                      style: TextStyle(
                                        fontSize: 14,
                                        color: Theme.of(context).hintColor,
                                      ),
                                    ),
                                    items: state.responseLoanPurposeList == null ? null : state.responseLoanPurposeList!.data!
                                        .map((Data item) => DropdownMenuItem<String>(
                                      value: item.name,
                                      child: Text(
                                        item.name.toString(),
                                        style: const TextStyle(
                                          fontSize: 14,
                                        ),
                                      ),
                                    )).toList(),
                                    // value: state.counties![0].name!,
                                    onChanged: (String? value) {
                                      setState(() {
                                        purpose = value!.toString();
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

                          20.verticalSpace(),
                          Align(
                            alignment: Alignment.centerLeft,
                            child: "Loan amount (UGX)".textMedium(color: Colors.black, fontSize: 12),
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
                              inputFormatters: [FilteringTextInputFormatter.digitsOnly, LengthLimitingTextInputFormatter(10)],
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

                          Align(
                            alignment: Alignment.centerLeft,
                            child: "Repayment period (Months)".textMedium(color: Colors.black, fontSize: 12),
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
                              inputFormatters: [FilteringTextInputFormatter.digitsOnly, LengthLimitingTextInputFormatter(3)],
                              controller: period,
                              maxLength: 3,
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

                          Align(
                            alignment: Alignment.centerLeft,
                            child: "Remarks".textMedium(color: Colors.black, fontSize: 12),
                          ),
                          5.verticalSpace(),

                          5.verticalSpace(),
                          Container(
                            decoration: BoxDecoration(
                                border: Border.all(color: const Color(0xffD9D9D9,),width: 1.5),
                                borderRadius: BorderRadius.circular(10),
                                color: Colors.white
                            ),
                            child: TextField(
                              controller: remarks,
                              maxLines: 4,
                              minLines: 4,
                              decoration: InputDecoration(
                                  hintStyle:
                                  figtreeMedium.copyWith(fontSize: 18),
                                  border: InputBorder.none),
                            ),
                          ),
                          20.verticalSpace(),

                          Container(
                              margin: 20.marginAll(),
                              height: 55,
                              width: screenWidth(),
                              child: customButton("Apply",
                                  fontColor: 0xffffffff,
                                  onTap: () {
                                    if(purpose == '') {
                                      showCustomToast(context, 'Loan Purpose is required');
                                    } else if (price.text == ''){
                                      showCustomToast(context, 'Loan Amount is required');
                                    } else if (int.parse(price.text.toString()) > int.parse(state.responseLoanForm!.data!.remainingLimit.toString())){
                                      showCustomToast(context, 'Loan Amount cannot be more than Remaining Limit');
                                    } else if (period.text == ''){
                                      showCustomToast(context, 'Repayment months are required');
                                    } else if (int.parse(period.text)> int.parse(state.responseLoanForm!.data!.maxEmis.toString())){
                                      showCustomToast(context, 'Repayment months cannot be more than Max. EMI\'s');
                                    } else if (remarks.text == ''){
                                      showCustomToast(context, 'Remarks are required');
                                    } else {
                                      BlocProvider.of<ProjectCubit>(context)
                                          .customLoanApplyApi(
                                          context, purpose.toString(),
                                          int.parse(price.text.toString()),
                                          int.parse(period.text.toString()),
                                          remarks.text.toString(), null);
                                    }
                                  })),

                          40.verticalSpace(),
                        ],),
                      ),
                    )
                  ],
                ),
              ],
            );
            }
          }
      ),
    );
  }
}


Widget kpi(context,ProjectState state) {
  List<FrontendKpiModel> kpiData = [];

  if(state.responseLoanForm!.data!.maxLoanLimit != null){
    kpiData.add(FrontendKpiModel(name: 'Max. Limit',
        image: Images.investmentKpi,
        value: getCurrencyString(state.responseLoanForm!.data!.maxLoanLimit!)));
  }

  if(state.responseLoanForm!.data!.maxEmis!=null){
    kpiData.add(FrontendKpiModel(name: 'Max. EMI\'s',
        image: Images.revenueKpi,
        value: '${state.responseLoanForm!.data!.maxEmis!}Mo'));
  }

  if(state.responseLoanForm!.data!.msp!=null){
    kpiData.add(FrontendKpiModel(name: 'MSP/Ltr.',
        image: Images.roiKpi,
        value: getCurrencyString(state.responseLoanForm!.data!.msp!)));
  }

  if(state.responseLoanForm!.data!.loanApplied!=null){
    kpiData.add(FrontendKpiModel(name: 'Loans Applied',
        image: Images.emiKpi,
        value: state.responseLoanForm!.data!.loanApplied!.toString()));
  }

  if(state.responseLoanForm!.data!.loanValue!=null){
    kpiData.add(FrontendKpiModel(name: 'Loan Value',
        image: Images.loanKpi,
        value: getCurrencyString(state.responseLoanForm!.data!.loanValue!)));
  }

  if(state.responseLoanForm!.data!.remainingLimit!=null){
    kpiData.add(FrontendKpiModel(name: 'Remaining Limit',
        image: Images.repaymentKpi,
        value: getCurrencyString(state.responseLoanForm!.data!.remainingLimit!)));
  }

  return Column(
    mainAxisAlignment: MainAxisAlignment.end,
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [

      customGrid(context,
          list: kpiData,
          crossAxisCount: 3,
          mainAxisSpacing: 15,
          crossAxisSpacing: 13,
          mainAxisExtent: 123,
          child: (index){
            return Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(14),
                border: Border.all(color: const Color(0xffDCDCDC),width: 1),
                boxShadow:[
                  BoxShadow(
                      color: Colors.grey.withOpacity(0.2),
                      blurRadius: 2.0,
                      offset: const Offset(0, 2))],
              ),
              child: Padding(
                // padding: 0.paddingAll(),
                padding: const EdgeInsets.fromLTRB(8, 10, 8, 2),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        SvgPicture.asset(
                          kpiData[index].image.toString(),
                          width: 30,
                          height: 30,
                        ),
                        /*kpiData[index].actionImage!=null?
                          SvgPicture.asset(kpiData[index].actionImage.toString()):
                              const SizedBox.shrink()*/
                      ],
                    ),
                    15.verticalSpace(),
                    Text(
                      '${kpiData[index].value}',
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: figtreeMedium.copyWith(fontSize: 14.3),
                    ),
                    05.verticalSpace(),
                    Text(
                      kpiData[index].name.toString(),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: figtreeRegular.copyWith(
                        fontSize: 12.5,
                      ),
                    )
                  ],
                ),
              ),
            );
          }),


    ],
  );
}
