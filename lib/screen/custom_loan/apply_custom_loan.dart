import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:glad/cubit/auth_cubit/auth_cubit.dart';
import 'package:glad/cubit/livestock_cubit/livestock_cubit.dart';
import 'package:glad/cubit/profile_cubit/profile_cubit.dart';
import 'package:glad/cubit/project_cubit/project_cubit.dart';
import 'package:glad/data/model/farmers_list.dart' as fa;
import 'package:glad/data/model/frontend_kpi_model.dart';
import 'package:glad/data/model/loan_purpose_list.dart';
import 'package:glad/screen/custom_loan/custom_loan_kyc.dart';
import 'package:glad/screen/custom_widget/custom_appbar.dart';
import 'package:glad/screen/custom_widget/custom_methods.dart';
import 'package:glad/utils/app_constants.dart';
import 'package:glad/utils/color_resources.dart';
import 'package:glad/utils/extension.dart';
import 'package:glad/utils/images.dart';
import 'package:glad/utils/styles.dart';

class ApplyCustomLoan extends StatefulWidget {
  const ApplyCustomLoan({Key? key}) : super(key: key);

  @override
  State<ApplyCustomLoan> createState() => _ApplyCustomLoanState();
}

class _ApplyCustomLoanState extends State<ApplyCustomLoan> {

  String countryCode = "";
  String? purpose = '';
  TextEditingController price = TextEditingController();
  TextEditingController period = TextEditingController();
  TextEditingController purposeOfLoan = TextEditingController();
  TextEditingController remarks = TextEditingController();
  TextEditingController rateOfInterestController = TextEditingController();
  TextEditingController totalRepaymentController = TextEditingController();
  TextEditingController emiController = TextEditingController();
  List<String> repaymentDropdown = [];
  bool one = false;

  @override
  void initState() {
    BlocProvider.of<ProjectCubit>(context).customLoanFormApi(context,BlocProvider.of<AuthCubit>(context).sharedPreferences.getString(AppConstants.userType) == "dde" ? BlocProvider.of<LivestockCubit>(context).state.selectedLivestockFarmerMAster!.id.toString() : null);
    BlocProvider.of<ProjectCubit>(context).customLoanPurposeListApi(context);
    // BlocProvider.of<ProjectCubit>(context).state.responseLoanCalculation == null;
    // BlocProvider.of<ProjectCubit>(context).emit(BlocProvider.of<ProjectCubit>(context).state.copyWith(responseLoanCalculation: null));
    getCountryCode();
    super.initState();
  }

  void getCountryCode() async{
    String countryCodes = await BlocProvider.of<ProfileCubit>(context).getCountryCode();
    countryCode = countryCodes;
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
        if(state.responseLoanForm!.data!.maxEmis!=null){
          if(one == false){
            BlocProvider.of<ProjectCubit>(context).loanCalculationAPi(context,
                BlocProvider.of<AuthCubit>(context).sharedPreferences.getString(AppConstants.userType) == "dde" ? BlocProvider.of<LivestockCubit>(context).state.selectedLivestockFarmerMAster!.id.toString():
                BlocProvider.of<LivestockCubit>(context).sharedPreferences.getString(AppConstants.userRoleId).toString(),
                state.responseLoanForm!.data!.remainingLimit!.toString(), state.responseLoanForm!.data!.maxEmis!.toString());
            price.text = currencyFormatter().format(state.responseLoanForm!.data!.remainingLimit!.toString());
            period.text = state.responseLoanForm!.data!.maxEmis!.toString();
            one = true;
          }
          repaymentDropdown.clear();
          for(int i=0 ; i<state.responseLoanForm!.data!.maxEmis!;i++){
            repaymentDropdown.add((i+1).toString());
          }
        }
            return Stack(
              children: [
                landingBackground(),
                Column(
                  children: [
                    CustomAppBar(
                      context: context,
                      titleText1: 'Cash Advances',
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

                          if(BlocProvider.of<AuthCubit>(context).sharedPreferences.getString(AppConstants.userType) == "dde")
                            BlocBuilder<LivestockCubit, LivestockCubitState>(
                                builder: (context, state) {
                                return Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [

                                    Padding(
                                      padding: const EdgeInsets.only(
                                          left: 0, right: 0, bottom: 0,top: 10),
                                      child: Container(
                                        decoration: boxDecoration(
                                            borderRadius: 10,
                                            backgroundColor: const Color(0xffFBF9F9)
                                        ),
                                        child: Padding(
                                          padding:
                                          const EdgeInsets.fromLTRB(15.0, 10, 0, 5),
                                          child: Stack(
                                            children: [
                                              Row(
                                                crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                                children: [
                                                  state.selectedLivestockFarmerMAster!.photo == null ?Image.asset(Images.sampleUser):
                                                  networkImage(text: state.selectedLivestockFarmerMAster!.photo!,height: 46,width: 46,radius: 40),
                                                  15.horizontalSpace(),
                                                  Column(
                                                    crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                    children: [
                                                      Text(state.selectedLivestockFarmerMAster!.name!,
                                                          style: figtreeMedium.copyWith(
                                                              fontSize: 16,
                                                              color: Colors.black)),
                                                      4.verticalSpace(),
                                                      Row(
                                                        children: [
                                                          Text(
                                                              "${countryCode == ""? "":countryCode!=null?countryCode.toString():""} ${state.selectedLivestockFarmerMAster!.phone.toString()}",
                                                              style:
                                                              figtreeRegular.copyWith(
                                                                  fontSize: 12,
                                                                  color: Colors.black)),

                                                        ],
                                                      ),
                                                      4.verticalSpace(),
                                                      Row(
                                                        crossAxisAlignment:
                                                        CrossAxisAlignment.end,
                                                        children: [
                                                          SizedBox(
                                                            width: MediaQuery.of(context)
                                                                .size
                                                                .width *
                                                                0.5,
                                                            child: Text(
                                                              state.selectedLivestockFarmerMAster!.address!=null?
                                                              state.selectedLivestockFarmerMAster!.address!.address!=null?state.selectedLivestockFarmerMAster!.address!.address!:"":"",
                                                              style:
                                                              figtreeRegular.copyWith(
                                                                fontSize: 12,
                                                                color: Colors.black,
                                                                overflow:
                                                                TextOverflow.ellipsis,
                                                              ),
                                                            ),
                                                          ),
                                                        ],
                                                      )
                                                    ],
                                                  )
                                                ],
                                              ),
                                              Align(
                                                alignment: Alignment.topRight,
                                                child: Padding(
                                                  padding: const EdgeInsets.only(right: 14.0),
                                                  child: InkWell(
                                                      onTap: (){
                                                        modalBottomSheetMenu(context,
                                                            radius: 40,
                                                            child: SizedBox(
                                                                height: screenHeight()-220,
                                                                child: selectFarmer(isCustomLoan: true)));
                                                        one = false;
                                                      }, child: SvgPicture.asset(Images.edit,width: 20,height: 20,)),
                                                ),
                                              )
                                            ],
                                          ),
                                        ),
                                      ),
                                    ),

                                    20.verticalSpace(),

                                  ],
                                );
                              }
                            ),
                          kpi(context, state),

                          30.verticalSpace(),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              "Purpose".textMedium(color: Colors.black, fontSize: 12),

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
                                      'Select purpose',
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

                          if(purpose == "Other")
                            Column(
                              children: [
                                20.verticalSpace(),

                                Align(
                                  alignment: Alignment.centerLeft,
                                  child: "Other purpose".textMedium(color: Colors.black, fontSize: 12),
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
                                    controller: purposeOfLoan,
                                    decoration: const InputDecoration(
                                      border: InputBorder.none,
                                      counterText: '',
                                      contentPadding: EdgeInsets.only(top: 10,left: 13),
                                    ),
                                  ),
                                ),

                              ],
                            ),

                          20.verticalSpace(),
                          Align(
                            alignment: Alignment.centerLeft,
                            child: "Lending amount (UGX)".textMedium(color: Colors.black, fontSize: 12),
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
                              inputFormatters: [
                                currencyFormatter()
                                // FilteringTextInputFormatter.digitsOnly, LengthLimitingTextInputFormatter(10)
                              ],
                              controller: price,
                              maxLength: 10,
                              onChanged: (value){
                                // if(BlocProvider.of<AuthCubit>(context).sharedPreferences.getString(AppConstants.userType) == "dde"){
                                if(value.isNotEmpty){
                                  BlocProvider.of<ProjectCubit>(context).loanCalculationAPi(context,
                                      BlocProvider.of<AuthCubit>(context).sharedPreferences.getString(AppConstants.userType) == "dde" ? BlocProvider.of<LivestockCubit>(context).state.selectedLivestockFarmerMAster!.id.toString():
                                      BlocProvider.of<LivestockCubit>(context).sharedPreferences.getString(AppConstants.userRoleId).toString(),
                                      value.replaceAll(",", ""), period.text.isEmpty?'1':period.text);
                                }
                                setState(() {});
                                if((int.parse(price.text.replaceAll(",", "").toString()) > int.parse(state.responseLoanForm!.data!.remainingLimit.toString()))){
                                  showCustomToast(context, 'Requested Amount cannot be more than Remaining Limit');
                                  price.text = currencyFormatter().format(state.responseLoanForm!.data!.remainingLimit!.toString());
                                }
                              },
                              // enabled: false,
                              keyboardType: TextInputType.number,
                              decoration: const InputDecoration(
                                border: InputBorder.none,
                                counterText: '',
                                contentPadding: EdgeInsets.only(top: 10,left: 13),
                              ),
                            ),
                          ),
                          /*((int.parse(price.text.toString()) > int.parse(state.responseLoanForm!.data!.remainingLimit.toString())))?
                          Text("Loan amount",
                          style: figtreeRegular.copyWith(
                            color: Colors.red,fontSize: 11
                          ),):const SizedBox.shrink(),*/

                          20.verticalSpace(),

                          Row(
                            children: [
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    "Tenure (Months)".textMedium(color: Colors.black, fontSize: 12),

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
                                          value: period.text != '' ? period.text : null,
                                          hint: Text(
                                            'Select repayment period',
                                            style: TextStyle(
                                              fontSize: 14,
                                              color: Theme.of(context).hintColor,
                                            ),
                                          ),
                                          items: repaymentDropdown == null ? null : repaymentDropdown
                                              .map((String item) => DropdownMenuItem<String>(
                                            value: item,
                                            child: Text(
                                              item.toString(),
                                              style: const TextStyle(
                                                fontSize: 14,
                                              ),
                                            ),
                                          )).toList(),
                                          // value: state.counties![0].name!,
                                          onChanged: (String? value) {
                                            setState(() {
                                              period.text = value!.toString();
                                              if(price.text.replaceAll(",", "").isNotEmpty){
                                                BlocProvider.of<ProjectCubit>(context).loanCalculationAPi(context,
                                                    BlocProvider.of<AuthCubit>(context).sharedPreferences.getString(AppConstants.userType) == "dde" ? BlocProvider.of<LivestockCubit>(context).state.selectedLivestockFarmerMAster!.id.toString():
                                                    BlocProvider.of<LivestockCubit>(context).sharedPreferences.getString(AppConstants.userRoleId).toString(),
                                                    price.text.replaceAll(",", ""), period.text.isEmpty?'1':period.text);
                                              }
                                              /*if(BlocProvider.of<AuthCubit>(context).sharedPreferences.getString(AppConstants.userType) == "dde"){
                                                BlocProvider.of<ProjectCubit>(context).loanCalculationAPi(context,
                                                    BlocProvider.of<LivestockCubit>(context).state.selectedLivestockFarmerMAster!.id.toString(),
                                                    price.text, value);
                                              }else{
                                                // BlocProvider.of<ProjectCubit>(context).loanCalculationAPi(context, farmerId, loanAmount, repaymentMonths);
                                              }*/
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
                                  children: [

                                    Align(
                                      alignment: Alignment.centerLeft,
                                      child: "Rate of Interest (Per Month)".textMedium(color: Colors.black, fontSize: 12),
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
                                        controller: price.text.replaceAll(",", "").isNotEmpty?TextEditingController(text: state.responseLoanCalculation!=null?"${(double.parse(state.responseLoanCalculation!.data!.rateOfInterest.toString()) / 12).toStringAsFixed(2)}%":''):TextEditingController(),
                                        maxLength: 10,
                                        enabled: false,
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
                            ],
                          ),


                          20.verticalSpace(),

                          Row(
                            children: [

                              Expanded(
                                child: Column(
                                  children: [
                                    Align(
                                      alignment: Alignment.centerLeft,
                                      child: "Total Repayment".textMedium(color: Colors.black, fontSize: 12),
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
                                        enabled: false,
                                        inputFormatters: [
                                          currencyFormatter()
                                          // FilteringTextInputFormatter.digitsOnly, LengthLimitingTextInputFormatter(10)
                                        ],
                                        controller: price.text.replaceAll(",", "").isNotEmpty?TextEditingController(text: state.responseLoanCalculation!=null?currencyFormatter().format(state.responseLoanCalculation!.data!.totalRepayment.toString()):''):TextEditingController(),
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
                                  ],
                                ),
                              ),

                              10.horizontalSpace(),

                              Expanded(
                                child: Column(
                                  children: [
                                    Align(
                                      alignment: Alignment.centerLeft,
                                      child: "EMI Amount".textMedium(color: Colors.black, fontSize: 12),
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
                                        enabled: false,
                                        inputFormatters: [FilteringTextInputFormatter.digitsOnly, LengthLimitingTextInputFormatter(10)],
                                        controller: price.text.replaceAll(",", "").isNotEmpty?TextEditingController(text: state.responseLoanCalculation!=null?currencyFormatter().format(state.responseLoanCalculation!.data!.emiAmount.toString()):''):TextEditingController(),
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
                                  ],
                                ),
                              )

                            ],
                          ),

                          20.verticalSpace(),
                          Align(
                            alignment: Alignment.centerLeft,
                            child: "Remarks".textMedium(color: Colors.black, fontSize: 12),
                          ),
                          5.verticalSpace(),

                          // 5.verticalSpace(),
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
                                  contentPadding: EdgeInsets.only(top: 10,left: 13),
                                  hintStyle:
                                  figtreeMedium.copyWith(fontSize: 18),
                                  border: InputBorder.none),
                            ),
                          ),
                          40.verticalSpace(),

                          if(state.responseLoanForm!.data!.eligibilty == 'no')
                            Padding(
                              padding: const EdgeInsets.symmetric(horizontal: 40),
                              child: 'Cash advance applications are only permitted for users with at least one active project.'.textRegular(
                                  fontSize: 12,
                                  textAlign: TextAlign.center
                              ),
                            ),
                          5.verticalSpace(),


                          Container(
                              margin: 20.marginHorizontal(),
                              height: 55,
                              width: screenWidth(),
                              child: customButton("Apply",
                                  opacity: state.responseLoanForm!.data!.eligibilty == 'no' ? 0.5 : 1,
                                  fontColor: 0xffffffff,
                                  onTap: state.responseLoanForm!.data!.eligibilty != 'no'
                                      ? () {
                                    if(purpose == '') {
                                      showCustomToast(context, 'Purpose is required');
                                    } else if (purpose == 'Other' && purposeOfLoan.text.isEmpty){
                                      showCustomToast(context, 'Please enter purpose');
                                    }else if (price.text.replaceAll(",", "") == ''){
                                      showCustomToast(context, 'Requested Amount is required');
                                    } else if (int.parse(price.text.replaceAll(",", "").toString()) > int.parse(state.responseLoanForm!.data!.remainingLimit.toString())){
                                      showCustomToast(context, 'Requested Amount cannot be more than Remaining Limit');
                                    } else if (period.text == ''){
                                      showCustomToast(context, 'Repayment months are required');
                                    } else if (int.parse(period.text) > int.parse(state.responseLoanForm!.data!.maxEmis.toString())){
                                      showCustomToast(context, 'Repayment months cannot be more than Max. EMI\'s');
                                    } else if (remarks.text == ''){
                                      showCustomToast(context, 'Remarks are required');
                                    } else {
                                      CustomLoanKYC(
                                        purpose: purpose.toString() == "Other"?purposeOfLoan.text.toString():purpose.toString(),
                                        price: int.parse(price.text.replaceAll(",", "").toString()),
                                        period: int.parse(period.text.toString()),
                                        remarks: remarks.text.toString(),
                                        farmerMaster: BlocProvider.of<AuthCubit>(context).sharedPreferences.getString(AppConstants.userType) == "dde" ? BlocProvider.of<LivestockCubit>(context).state.selectedLivestockFarmerMAster! : null,
                                      ).navigate();
                                      // BlocProvider.of<ProjectCubit>(context)
                                      //     .customLoanApplyApi(
                                      //     context, purpose.toString(),
                                      //     int.parse(price.text.toString()),
                                      //     int.parse(period.text.toString()),
                                      //     remarks.text.toString(), widget.farmerMAster != null ? widget.farmerMAster!.id.toString() : null);
                                    }
                                  }
                                      : () {}
                              )
                          ),

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

  Widget kpi(context,ProjectState state) {

    List<FrontendKpiModel> kpiData = [];
    final MediaQueryData mediaData = MediaQuery.of(context);

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
      kpiData.add(FrontendKpiModel(name: 'Cash Advances Applied',
          image: Images.emiKpi,
          value: state.responseLoanForm!.data!.loanApplied!.toString()));
    }

    if(state.responseLoanForm!.data!.loanValue!=null){
      kpiData.add(FrontendKpiModel(name: 'Lending Value',
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
            mainAxisExtent: 130,
            child: (index){
              return MediaQuery(
                data: screenWidth()<380 ? mediaData.copyWith(textScaleFactor: 0.91):mediaData.copyWith(textScaleFactor: 1),
                child: Container(
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
                          maxLines: 3,
                          overflow: TextOverflow.ellipsis,
                          style: figtreeRegular.copyWith(
                            fontSize: 12.5,
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              );
            }),


      ],
    );
  }
}

