import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
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

class ViewLoanKyc extends StatefulWidget {
  const ViewLoanKyc({super.key, required this.farmerDocuments,required this.rejectStatus});
  final FarmerProjectKycDocument farmerDocuments;
  final int rejectStatus;

  @override
  State<ViewLoanKyc> createState() => _ViewLoanKycState();
}

class _ViewLoanKycState extends State<ViewLoanKyc> {

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
                                hint: 'Select Address Proof',
                                enabled: false,
                                controller: TextEditingController()..text = widget.farmerDocuments.addressDocumentName!,
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
                                      viewDocumentImage(image.fullUrl!, isPDF: widget.farmerDocuments.addressDocumentName == 'bank-statement'),
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
                                hint: 'Select ID Proof',
                                readOnly: true,
                                controller: TextEditingController()..text = widget.farmerDocuments.idDocumentName!,
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
                                      viewDocumentImage(image.fullUrl!),
                                      10.horizontalSpace(),
                                    ],
                                  )
                              ],
                            ),
                          ],
                        ),
                      ),
                      // 40.verticalSpace(),
                      40.verticalSpace(),

                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 20.0),
                        child: customButton(
                          'Save',
                          onTap: () {

                              /*BlocProvider.of<ProjectCubit>(context).projectKycApi(context,
                                  widget.farmerId.toString(), widget.farmerProjectId.toString(),
                                  addressProof!.toLowerCase().replaceAll(' ', '-'),
                                  addressDoc.text,
                                  addressDate.text,
                                  addressImg,
                                  idProof!.toLowerCase().replaceAll(' ', '-'),
                                  idDoc.text,
                                  idDate.text,
                                  idImg,
                                  profilePicture,
                                  widget.farmerMaster);*/

                          },
                          radius: 40,
                          width: double.infinity,
                          height: 60,
                          style: figtreeMedium.copyWith(
                              color: Colors.white, fontSize: 16),
                        ),
                      ),


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
}
