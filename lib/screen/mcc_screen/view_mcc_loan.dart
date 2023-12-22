import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:glad/cubit/project_cubit/project_cubit.dart';
import 'package:glad/data/model/farmer_profile_model.dart';
import 'package:glad/data/model/farmer_project_detail_model.dart';
import 'package:glad/screen/custom_widget/custom_appbar.dart';
import 'package:glad/screen/custom_widget/custom_methods.dart';
import 'package:glad/screen/custom_widget/custom_textfield.dart';
import 'package:glad/screen/dde_screen/dde_profile.dart';
import 'package:glad/utils/color_resources.dart';
import 'package:glad/utils/extension.dart';
import 'package:glad/utils/images.dart';
import 'package:glad/utils/styles.dart';

class ViewLoanKycMcc extends StatefulWidget {
  const ViewLoanKycMcc({super.key, required this.farmerDocuments,required this.farmerMaster});
  final FarmerProjectKycDocument farmerDocuments;
  final FarmerMaster farmerMaster;

  @override
  State<ViewLoanKycMcc> createState() => _ViewLoanKycMccState();
}

class _ViewLoanKycMccState extends State<ViewLoanKycMcc> {

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
                titleText1: 'View documents',
                titleText1Style:
                figtreeMedium.copyWith(fontSize: 20, color: Colors.black),
                centerTitle: true,
                leading: arrowBackButton(),
                description: 'Provide the following details',
              ),
              Expanded(
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      10.verticalSpace(),

                      Center(
                        child: ClipOval(
                          clipper: MyClip(),
                          child: SizedBox(
                            height: 180,
                            width: 190,
                            child: Container(
                              decoration: BoxDecoration(
                                  color: Colors.transparent,
                                  borderRadius: const BorderRadius.all(
                                      Radius.circular(8)),
                                  border: Border.all(
                                    width: 1,
                                    color: Colors.transparent,
                                  )),
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(8),
                                child: CachedNetworkImage(
                                  imageUrl: widget.farmerDocuments.projectFarmerPhoto!,
                                  fit: BoxFit.cover,
                                  errorWidget: (context, url, error) =>
                                      SvgPicture.asset(Images.uploadPP),
                                ),
                              ),
                            ),
                          ),

                        ),
                      ),
                      40.verticalSpace(),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 20.0),
                        child: Row(
                          children: [
                            Expanded(
                              child: CustomTextField(
                                hint: 'Recommendation Letter"',
                                enabled: false,
                                controller: TextEditingController()..text = formatProjectStatus(widget.farmerDocuments.addressDocumentName),
                                // itemList: const [
                                //   "Utility Bill",
                                //   "Bank Statement",
                                //   "Lease Agreement"
                                // ],
                                // onChanged: (String? value) {
                                // },
                                // image2: Images.arrowDropdown,
                                // image2Colors: Colors.black,
                              ),
                            ),
                          ],
                        ),
                      ),
                      10.verticalSpace(),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 20.0),
                        child: Row(
                          children: [
                            Expanded(
                              child: CustomTextField(
                                hint: 'Doc. No.',
                                enabled: false,
                                controller: TextEditingController()..text = widget.farmerDocuments.addressDocumentNumber!,
                                hintStyle: figtreeMedium.copyWith(
                                    fontSize: 16, color: Colors.black),
                                readOnly: true,
                              ),
                            ),
                            10.horizontalSpace(),
                            Expanded(
                              child: CustomTextField(
                                hint: 'Exp. Date',
                                hintStyle: figtreeMedium.copyWith(
                                    fontSize: 16, color: Colors.black),
                                image2: Images.calender,
                                enabled: false,
                                controller: TextEditingController()..text = widget.farmerDocuments.addressExpiryDate.toString()=="0000-00-00"?'':widget.farmerDocuments.addressExpiryDate.toString(),
                                image2Colors: ColorResources.maroon,
                                readOnly: true,
                                focusNode: FocusNode(),
                              ),
                            ),
                          ],
                        ),
                      ),
                      10.verticalSpace(),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 20.0),
                        child: Column(
                          children: [
                            20.verticalSpace(),
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [

                                for (AddressDocumentFile image in widget.farmerDocuments.addressDocumentFile!)
                                  Row(
                                    children: [
                                      viewDocumentImage(image.originalUrl!, isPDF: widget.farmerDocuments.addressDocumentName == 'bank-statement'),
                                      10.horizontalSpace(),
                                    ],
                                  )
                              ],
                            ),
                          ],
                        ),
                      ),
                      40.verticalSpace(),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 20.0),
                        child: Row(
                          children: [
                            Expanded(
                              child: CustomTextField(
                                hint: 'ID Proof',
                                readOnly: true,
                                controller: TextEditingController()..text = formatProjectStatus(widget.farmerDocuments.idDocumentName)!,
                                // dropdownValue: widget.farmerDocuments.docType,
                                // itemList: const [
                                //   // "Passport", "NIC"
                                // ],
                                // onChanged: (String? value) {
                                // },
                                // icon: Images.arrowDropdown,
                                // iconColor: Colors.black,
                              ),
                            ),
                          ],
                        ),
                      ),
                      10.verticalSpace(),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 20.0),
                        child: Row(
                          children: [
                            Expanded(
                              child: CustomTextField(
                                hint: 'Doc. No.',
                                enabled: false,
                                controller: TextEditingController()..text = widget.farmerDocuments.idDocumentNumber.toString()??'',
                                hintStyle: figtreeMedium.copyWith(
                                    fontSize: 16, color: Colors.black),
                                readOnly: true,
                              ),
                            ),
                            10.horizontalSpace(),
                            Expanded(
                              child: CustomTextField(
                                hint: 'Exp. Date',
                                enabled: false,
                                controller: TextEditingController()..text = widget.farmerDocuments.idExpiryDate.toString()=="0000-00-00"?'':widget.farmerDocuments.idExpiryDate.toString(),
                                hintStyle: figtreeMedium.copyWith(
                                    fontSize: 16, color: Colors.black),
                                image2: Images.calender,
                                image2Colors: ColorResources.maroon,
                                readOnly: true,
                                focusNode: FocusNode(),
                              ),
                            ),
                          ],
                        ),
                      ),
                      10.verticalSpace(),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 20.0),
                        child: Column(
                          children: [
                            20.verticalSpace(),
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                for (IdDocumentFile image in widget.farmerDocuments.idDocumentFile!)
                                  Row(
                                    children: [
                                      viewDocumentImage(image.originalUrl!),
                                      10.horizontalSpace(),
                                    ],
                                  )
                              ],
                            ),
                          ],
                        ),
                      ),
                      40.verticalSpace(),
                      actionButton()
                    ],
                  ),
                ),
              )
            ],
          ),
        ],
      ),
    );
  }

  Widget actionButton(){
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0),
          child: customButton(
            'Approve',
            onTap: () {
              TextEditingController controller = TextEditingController();
              modalBottomSheetMenu(context,
                  radius: 40,
                  child: StatefulBuilder(
                      builder: (context, setState) {
                        return SizedBox(
                          height: 320,
                          child: Padding(
                            padding: const EdgeInsets.fromLTRB(23, 20, 25, 10),
                            child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Center(
                                    child: Text(
                                      'Remarks',
                                      style: figtreeMedium.copyWith(fontSize: 22),
                                    ),
                                  ),
                                  15.verticalSpace(),
                                  Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [

                                      /*Text(
                                                      'Remarks',
                                                      style: figtreeMedium.copyWith(fontSize: 12),
                                                    ),*/
                                      5.verticalSpace(),
                                      TextField(
                                        controller: controller,
                                        maxLines: 4,
                                        minLines: 4,
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
                                      30.verticalSpace(),
                                      Padding(
                                        padding: const EdgeInsets.fromLTRB(28, 0, 29, 0),
                                        child: customButton(
                                          'Submit',
                                          fontColor: 0xffFFFFFF,
                                          onTap: () {
                                            BlocProvider.of<ProjectCubit>(context).inviteExpertForSurveyMcc(context,widget.farmerDocuments.farmerProjectId!,'',controller.text,'doc_verified',widget.farmerDocuments.farmerId.toString(),widget.farmerMaster);
                                          },
                                          height: 60,
                                          width: screenWidth(),
                                        ),
                                      )
                                    ],
                                  )
                                ]),
                          ),
                        );
                      }
                  ));
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
          padding: const EdgeInsets.symmetric(horizontal: 20.0),
          child: customButton('Reject',
              onTap: () {
                TextEditingController controller = TextEditingController();
                modalBottomSheetMenu(context,
                    radius: 40,
                    child: StatefulBuilder(
                        builder: (context, setState) {
                          return SizedBox(
                            height: 320,
                            child: Padding(
                              padding: const EdgeInsets.fromLTRB(23, 20, 25, 10),
                              child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Center(
                                      child: Text(
                                        'Remarks',
                                        style: figtreeMedium.copyWith(fontSize: 22),
                                      ),
                                    ),
                                    15.verticalSpace(),
                                    Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [

                                        /*Text(
                                                      'Remarks',
                                                      style: figtreeMedium.copyWith(fontSize: 12),
                                                    ),*/
                                        5.verticalSpace(),
                                        TextField(
                                          controller: controller,
                                          maxLines: 4,
                                          minLines: 4,
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
                                        30.verticalSpace(),
                                        Padding(
                                          padding: const EdgeInsets.fromLTRB(28, 0, 29, 0),
                                          child: customButton(
                                            'Submit',
                                            fontColor: 0xffFFFFFF,
                                            onTap: () {
                                              BlocProvider.of<ProjectCubit>(context).inviteExpertForSurveyMcc(context,widget.farmerDocuments.farmerProjectId!,'',controller.text,'rejected',widget.farmerDocuments.farmerId.toString(),widget.farmerMaster);
                                            },
                                            height: 60,
                                            width: screenWidth(),
                                          ),
                                        )
                                      ],
                                    )
                                  ]),
                            ),
                          );
                        }
                    ));
              },
              radius: 40,
              width: double.infinity,
              height: 60,
              style: figtreeMedium.copyWith(
                  color: Colors.black, fontSize: 16),
              color: 0xFFDCDCDC),
        ),
      ],
    );
  }

}
